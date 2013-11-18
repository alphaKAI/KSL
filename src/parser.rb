#encoding:utf-8
# GPLv3 LICENSE http://www.gnu.org/licenses/gpl-3.0.html
class CommandParser
	def initialize
		@kernel=KaiKernel.new
	end
	def parser(cmdstr)
		line = cmdstr.split(" ")
		
		2.times{|i|
			line[i].gsub!("~/","/home/#{ENV["USER"]}/")	if line[i] =~ /~\//
		}
		case line[0]
			when /help/
				@kernel.help
			when /exit/
				@kernel.exit
			when /cd/
					if line[1].to_s.empty?
						line [1] = "/home/#{ENV["USER"]}/"
					end
					unless File.exist?(line[1])
						puts "\'#{line[1]}\'という名前のディレクトリは存在しません 打ち間違えがないかご確認ください"
						return nil
					end

					Dir.chdir(line[1])
			when /date/
				@kernel.date
			when /version/
				@kernel.version
			else
				st=false
				self.cmdlist.each{|data|
					if line[0] == data.split(".")[0]
						line.delete_at(0)
						system("ruby #{$install_path}/#{data} #{line.join(" ")}")
						st = true
						break			
					end
				}
				
				if line[0] == ".."
					line[0] += "/"
				end
				if File.exist?(line[0].to_s) && File.ftype(line[0].to_s) == "directory"
					Dir.chdir(line[0])
					st = true
				end
				if line[0] =~ /^\.\D+$/
					tmp_s = String.new
					(line.size - 1) .times{|i|
						i += 1
						tmp_s += line[i]
						tmp_s += " "
					}
					if system("#{line[0][1..line[0].size]} #{tmp_s}")
						st = true
					end
				end
				unless st
					puts "\'#{line[0]}\'はKSLに対して有効なコマンドではありません" unless line[0].to_s.empty?
					require_relative "../bin/match.rb"
					cmdlist.each{|cmd|
						cmd = cmd.split(".")[0]
						if 1 <= match(cmd,line[0]) || 1 <= match(line[0].to_s,cmd)
							puts "もしかして:#{cmd}"
						end
					}
				end
		end
	end
	def cmdlist
		array = Array.new
		Dir.entries($install_path).each{|data|
			next if data == "." || data == ".."
			array << data
		}
		return array
	end
end
