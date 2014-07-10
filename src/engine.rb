#encoding:utf-8
require "pp"
def p(arg)
  pp arg
end
class ShellEngine
  def initialze
    $KSL_RC_FILE_PATH = ".kslrc"
    @functions = Hash.new
    @currentUserPid = 0#Root

    readDotKSLrc($KSL_RC_FILE_PATH)
  end
  
  def readDotKSLrc(rcFILEpath)
    return false unless File.exist?(rcFILEpath)

    fileData = File.read(rcFILEpath)

  end

  def parser(fileData)
    functions = Hash.new
=begin
  {"functionName": {
      "requirements" => [],
      ""
    }
  }
=end
    tmp_functions = {
      "requirements"  => [],
      "runlevel"      => 3,
      "allowedUsers"  => "",
      "allowedGroups" => [],
      "help"          => "",
      "function"      => ""
    }
    tmp_function_flag = true
    buf_function = []
    currentStatuses = {
      "scriptName"     => nil,
      "functionStatus" => false,
      "leftStaple"     => nil,
      "currentLine"    => 0,
      "currentSection" => nil,
      "lastSection"    => nil
    }

    fileData.each_line do |line|
      line.gsub!(/\n/, "")
      currentStatuses["currentLine"] += 1
      tmp_function_flag = false if currentStatuses["scriptName"]
      
      if currentStatuses["currentSection"] == nil
        case line
          when /commandName:/
            currentStatuses["currentSection"] = :commandName
            next
          when /requirements:/
            currentStatuses["currentSection"] = :requirements
            next
          when /runlevel:/
            currentStatuses["currentSection"] = :runlevel
            next
          when /allowedUsers:/
            currentStatuses["currentSection"] = :allowedUsers
            next
          when /allowedGroups:/
            currentStatuses["currentSection"] = :allowedGroups
            next
          when /help/
            currentStatuses["currentSection"] = :help
            currentStatuses["functionStatus"] = true
            next
          when /function:/
            currentStatuses["currentSection"] = :function
            currentStatuses["functionStatus"] = true
            next
        end
      end

      if currentStatuses["currentSection"] && line =~ /endOf(commandName|requirements|runlevel|allowedUsers|allowedGroups|help|function);$/
        unless line == "endOf#{currentStatuses["currentSection"]};" 
          puts "Syntax Error : between #{line} - #{currentStatuses["currentSection"]}"
          exit
        end

        currentStatuses["currentSection"]    = nil
        next
      end
      
      case currentStatuses["currentSection"]
        when :commandName
          currentStatuses["scriptName"] = line.gsub(/(\s|\t)/, "")
          functions[currentStatuses["scriptName"]] = Hash.new
          functions[currentStatuses["scriptName"]] = tmp_functions if tmp_functions
          next
        when :requirements
          line.gsub!(/(\s|\t)/, "")
          if line.include?(",")
            tmp_array = line.split(",")
          else
            tmp_array = [line]
          end
          tmp_array.each do |elem|
            if tmp_function_flag
              tmp_functions["requirements"] << elem
            else
              functions[currentStatuses["scriptName"]]["requirements"] << elem
            end
          end
          next
        when :runlevel
          if tmp_function_flag
            tmp_functions["runlevel"] = line.gsub(/(\s|\t)/, "").to_i
          else
            functions[currentStatuses["scriptName"]]["runlevel"] = line.gsub(/(\s|\t)/, "").to_i
          end
          next
      end

    end
    
    return functions
  end
end
