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
				status =false
				self.cmdlist.each{|data|
					if line[0] == data.split(".")[0]
            fname = line[0]
						line.delete_at(0)
            if line.length == 0
              line = ""
            end
            
            fileData = []
            commentOut = false
            File.read($install_path + "/" + data).split("\n").each do |fline| 
              next if fline =~ /^#.*$/
              commentOut = true  if fline =~ /=begin/
              if commentOut && fline =~ /=end/
                commentOut = false
                next
              end
              next if commentOut
              fileData << fline
            end 
            eval("#{fileData.join(";")}")
            eval("#{fname} #{line}")
            eval("undef #{fname}")
						status = true
						break			
					end
				}
				
				if line[0] == ".."
					line[0] += "/"
				end
				if File.exist?(line[0].to_s) && File.ftype(line[0].to_s) == "directory"
					Dir.chdir(line[0])
					status = true
				end
				if line[0] =~ /^\.\D+$/
					tmp_s = String.new
					(line.size - 1) .times{|i|
						i += 1
						tmp_s += line[i]
						tmp_s += " "
					}
					if system("#{line[0][1..line[0].size]} #{tmp_s}")
						status = true
					end
				end
				unless status
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
=begin
		array = Array.new
		Dir.entries($install_path).each{|data|
			next if data == "." || data == ".."
			array << data
		}
=end
    array = Dir.entries($install_path).select do |elem| elem unless elem == "." || elem == ".." end
		return array
	end
end
