#encoding:utf-8

=begin
	Copyleft (C) alphaKAI 2013 http://alpha-kai-net.info
	GPLv3 LICENSE http://www.gnu.org/licenses/gpl-3.0.html
	Like UNIX cat

	DevTest
=end
# DESCRIPTION Like UNIX cat Usage:cat file1 file2 ...
def cat(args)
	args.each{|arg|
		unless File.exists?(arg)
			puts "\'#{arg}\'という名前のファイルは見つかりません コマンドにミスがないかご確認ください"
			next
		end
		IO.foreach(arg){|line|
			puts line
		}
	}
end
cat(ARGV)
