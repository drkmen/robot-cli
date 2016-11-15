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

  desc 'move', 'move robot'
  def go(side)
    self.send side
    return false unless validate
    update_position
    @field.map[self.position[0]][self.position[1]] = 0
  end

  desc 'position', 'get robot position'
  def get
    @field.print
  end

  private

  def validate
    result = nil
    if self.position[0] >= @field.height || self.position[1] >= @field.width
      p 'not allowed'
      result = false
    else
      result = true
    end
    return result
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
    @field.print
  end

end

Robot.start(ARGV)