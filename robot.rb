#!/usr/bin/env ruby
require 'rubygems'
require 'thor'
require 'yaml'
require './field.rb'

class Robot < Thor
  attr_accessor :position

  def initialize(*args)
    super
    @conf = YAML.load_file('position.yml')
    @field = Field.new
    self.position = [@conf['y'], @conf['x']]
    @field.map[self.position[0]][self.position[1]] = 'X'
  end

  desc 'go left', 'move robot'
  def go(side)
    self.send side
    return false unless valid?
    update_position
    @field.map[self.position[0]][self.position[1]] = 0
    @field.draw
  end

  desc 'get', 'get robot position'
  def get
    @field.draw
  end

  private

  def valid?
    if self.position[0].between?(0, @field.height) && self.position[1].between?(0, @field.width)
      true
    else
      p 'not allowed'
      @field.draw
      false
    end
  end

  def up
    self.position[0] -= 1
  end

  def down
    self.position[0] += 1
  end

  def left
    self.position[1] -= 1
  end

  def right
    self.position[1] += 1
  end

  def update_position
    @conf['y'] = self.position[0]
    @conf['x'] = self.position[1]
    File.open('position.yml', 'w') {|f| f.write @conf.to_yaml }
    @field.map[self.position[0]][self.position[1]] = 'X'
  end
end

Robot.start(ARGV)