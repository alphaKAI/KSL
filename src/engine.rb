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
            puts "Begin commandName"
            currentStatuses["currentSection"] = :commandName
            next
          when /requirements:/
            puts "Begin requirements"
            currentStatuses["currentSection"] = :requirements
            next
          when /runlevel:/
            puts "Begin runlevel"
            currentStatuses["currentSection"] = :runlevel
            next
          when /allowedUsers:/
            puts "Begin allowedUsers"
            currentStatuses["currentSection"] = :allowedUsers
            next
          when /allowedGroups:/
            puts "Begin allowedGroups"
            currentStatuses["currentSection"] = :allowedGroups
            next
          when /help:/
            puts "Begin help"
            currentStatuses["currentSection"] = :help
            currentStatuses["functionStatus"] = true
            next
          when /function:/
            puts "Begin function"
            currentStatuses["currentSection"] = :function
            currentStatuses["functionStatus"] = true
            next
        end#End of case
      end#End of if

      if currentStatuses["currentSection"] && line =~ /endOf(commandName|requirements|runlevel|allowedUsers|allowedGroups|help|function);$/
        unless line == "endOf#{currentStatuses["currentSection"]};" 
          puts "Syntax Error : between #{line} - #{currentStatuses["currentSection"]}"
          puts "cf: Line #{currentStatuses["currentLine"]}"
          exit
        end#End of unless

        if currentStatuses["functionStatus"]
          kindOfFunction = nil
          if currentStatuses["currentStatuses"] == :function
            kindOfFunction = "function"
          else
            kindOfFunction = "help"
          end

          func = functionParser(buf_function)
          if tmp_function_flag
            tmp_functions[kindOfFunction] = func
          else
            functions[currentStatuses["scriptName"]][kindOfFunction] = func
          end#End of if
          currentStatuses["functionStatus"] = false
          buf_function = []
        end#End of if
        currentStatuses["currentSection"]    = nil
        puts "close"
        next
      end#End of if
      
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
            end#End of if
          end#End of each
          next
        when :runlevel
          line.gsub!(/(\s|\t)/, "")
          if tmp_function_flag
            tmp_functions["runlevel"] = line.to_i
          else
            functions[currentStatuses["scriptName"]]["runlevel"] = line.to_i
          end#End of if
          next
        when :allowedUsers, :allowedGroups
          mode = nil
          if currentStatuses["currentSection"] == :allowedUsers
            mode = "allowedUsers"
          else
            mode = "allowedGroups"
          end#End of if

          line.gsub!(/(\s|\t)/, "")
          
          if line.include?(",")
            tmp_array = line.split(",")
          else
            tmp_array = [line]
          end#End of if
          
          tmp_array.each do |elem|
            if tmp_function_flag
              if elem =~ /all/i
                tmp_functions[mode]               = [:all]
                currentStatuses["currentSection"] = nil
                break
              else
                tmp_functions[mode] << elem
              end#End of if
            else
              if elem =~ /all/i
                functions[currentStatuses["scriptName"]][mode] = [:all]
                currentStatuses["currentSection"]              = nil
                break
              else
                functions[currentStatuses["scriptName"]][mode] << elem
              end#End of if
            end#End of if
          end#End of if
          next
        when :help, :function
          if currentStatuses["functionStatus"]
            buf_function << line
          else
            puts "Error"#ErroMes
          end
          next
      end#End of case

    end#End of each
    return functions
  end#End of def

  def functionParser(functionStrings)
    return functionStrings
  end
end#End of class
