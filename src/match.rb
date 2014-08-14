#encoding:utf-8

=begin
	Copyleft (C) alphaKAI 2013 http://alpha-kai-net.info
	GPLv3 LICENSE http://www.gnu.org/licenses/gpl-3.0.html
	Compare strings and return match counts.

	DevTest
=end
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

