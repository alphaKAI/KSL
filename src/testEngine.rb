#encoding:utf-8
require_relative "./engine.rb"
sh = ShellEngine.new

p sh.parser(File.read("../bin/base64.ksl"))
