#encoding:utf-8

=begin
	Copyleft (C) alphaKAI 2013 http://alpha-kai-net.info
	GPLv3 LICENSE http://www.gnu.org/licenses/gpl-3.0.html
	Compare strings and return match counts.

	DevTest
=end
# DESCRIPTION Compare strings and return match counts Usage:match strings pattern
def match(str,pattern)
	p_length = pattern.length
	s_lebgth = str.length
	count=0
	 
	s_lebgth.times{|i|
		tmp_s=[]
		p_length.times{|j|
			tmp_s[j]=str[i+j]
		}
		if tmp_s.join == pattern
			count+=1
		end
	}
	 
	return count
end
=begin
if __FILE__ == $0
	string = ARGV[0].to_s
	pattern = ARGV[1].to_s
	puts "Match Count => #{match(string,pattern)}"
	print "Strings:"
	ary=string.split(pattern)
	if ary.size == 0
		print "\e[31m#{pattern}\e[0m"
	else
		ary.each{|s|
			if s.empty?
				print "\e[31m#{pattern}\e[0m"
			else
				print s
			end
		}
	end
	print " Pattern:#{pattern}\n"
end
=end
