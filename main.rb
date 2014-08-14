#encoding:utf-8
=begin
	Copyright (C) alphaKAI 2013-2014 http://alpha-kai-net.info
	UNIX Shell Environment KSL in Ruby

  The MIT LICENSE http://opensource.org/licenses/MIT
=end

#unless ARGV[0] == "test"
#  $KSL_INSTALLED_PATH = "/ROOTFS/KSL"
#else
  $KSL_INSTALLED_PATH = "."
#end
require "find"
require "readline"
require_relative "#{$KSL_INSTALLED_PATH}/src/parser.rb"
require_relative "#{$KSL_INSTALLED_PATH}/src/kernel.rb"

VER = "0.0.3 rb for OSv"
$install_path = "#{Dir.pwd}/bin"
$pc_user_color = 36
class MainFunctions
	def initialize
		@parser = CommandParser.new
		@kernel = KaiKernel.new
		@shellstack = Array.new
	end
	def about
		puts "KSL in Ruby VERSION:#{VER}"
		puts "Copyright (C) alphaKAI 2013-2014 http://alpha-kai-net.info"
    puts "The MIT LICENSE http://opensource.org/licenses/MIT"
		puts "実装されているコマンドの一覧はhelpコマンドで確認できます"

    @baseOS = "OSv"
		puts "\n現在KSLが動作しているOS:#{@baseOS}\n\n"
	end
	def ShellLine(loop_count,error)
		path   = Dir.pwd
    pcname = "OSv"
		uname  = ENV["USER"]

		if path =~ /\/home\/#{uname}/
			path.gsub!("/home/#{uname}","~")
		end
		unless error == 0
			print "#{error} "
		end
		
		commands = @parser.cmdlist
		tmp_ary = Array.new

		commands.each{|a|
			tmp_ary <<  a.split(".")[0]
		}
		commands = tmp_ary
		commands += Dir.entries(Dir.pwd)

		Readline.completion_proc = proc{|word|
			commands.grep(/\A#{Regexp.quote word}/)
		}
		input = Readline.readline("\r\e[#{$pc_user_color}m#{uname}@#{pcname} \e[31m[KSL]\e[0m \e[1m#{path}\e[0m #{@kernel.prompt}",true)
                
		@shellstack << input
		ret = @parser.parser(input)
		puts ""
                ret
	end
end

userHash = {
  "root"     => -1,
  "alphaKAI" =>  0,
  "user"     =>  1
}
loop do
  id = nil
  userName = nil
  loop do
    print "UserName: "
    input_name = STDIN.gets.chomp
    puts

    id = userHash[input_name]
    if id == nil
      puts "Login failed"
    else
      userName = input_name
      break
    end
  end

  i = 0
  error = 0

  @mf = MainFunctions.new
  @mf.about
  loopThread = Thread.new do
    # set id
    loopThread.access_control_id = id
    loop do
      begin
        ret = @mf.ShellLine(i, error)
        if ret == 1
            break
        end
      rescue => e
       puts "Permisson error:#{e}"
      ensure
        i+=1
      end
    end
  end
  loopThread.join
end
