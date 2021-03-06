#encoding:utf-8

=begin
	Copyleft (C) alphaKAI 2013 http;//alpha-kai-net.info
	GPLv3 LICENSE http://www.gnu.org/licenses/gpl-3.0.html

	Base64 encode decode program
=end
# DESCRIPTION Base64 encode/decode program Usage:base64 [option]  arguments  more info => base64 -help
require "base64"
require "kconv"

def help
	puts "Base64 encode/decode program"
	puts "Copyleft (C) alphaKAI 2013 http://alpha-kai-net.info"
	puts "This script is able to encode to base64 strings from string or file and"
	puts "decode to original data from base64 strigns"
	puts "\n\tUsage:"
	puts "\tbase64 [option] arguments"
	puts "\targuments:base string or input file name, output file name"
	puts "\t  option:"
	puts "\t    encode string : -e convert to base64 strings from context strings"
	puts "\t    decode string : -d decode to context strings from base64 strings"
	puts "\t    file encode : -fe or -ef convert to base64 from arguments file data"
	puts "\t    file deode : -df or -df decode to original data from arguments file"
end
def result(hash)
	hash.each{|key,value|
		puts "#{key}:#{value}"
	}
end
def base64(args)
	error_s = "引数の数が不正です -hオプションを使用して使い方を確認してください"
	check_s = proc{
		if args[1].to_s.empty?
			puts error_s
			return nil
		end
	}
	check_f = proc{
		if args[1].to_s.empty? || args[2].to_s.empty?
			puts error_s
		end
	}
	fck = proc{
		unless File.exist?(args[1])
			puts "\'#{args[1]}\'というファイルは存在しません 入力に間違えが無いかご確認ください"
			return nil
		end
	}
	if args[0].to_s.empty?
		puts "オプションが指定されていません オプションを指定してください"
		return nil
	end
	case args[0]
		when /-h/
			help
		when "-e"
			check_s.call
			b64s = Base64.encode64(Kconv.kconv(args[1].to_s,Kconv::UTF8))
			result({
				"Mode" => "Encode String",
				"Base String" => args[1].to_s,
				"Result" => b64s
			})
		when "-d"
			check_s.call
			context = Base64.decode64(args[1].to_s)
			result({
				"Mode" => "Decode String",
				"Base String" => args[1].to_s,
				"Result" => context
			})
		when /-(fe|ef)/
			check_f.call
			fck.call
			File.write(args[2],Base64.encode64(File.binread(args[1])))
		when /-(fd|df)/
			check_f.call
			fck.call	
			File.write(args[2],Base64.decode64(File.binread(args[1])))
	end
end
base64(ARGV)
