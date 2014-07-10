#encoding:utf-8

class ShellEngine
  def initialze
    $KSL_RC_FILE_PATH = ".kslrc"
    @functions = Hash.new
=begin
  Key:value

=end
    @currentUserPid = 0#Root

    readDotKSLrc($KSL_RC_FILE_PATH)
  end
  
  def readDotKSLrc(rcFILEpath)
    return false unless File.exist?(rcFILEpath)

    fileData = File.read(rcFILEpath)

  end

  private
  def parser(fileData)
    functions = Hash.new
    function_tmp = Strings.new
    currentStatuses = {
      "functionStatus" => false,
      "leftStaple"     => nil,
      "currentLine"    => 0,
      "currentSection" => nil
    }
    
    fileData.each_line do |line|
      currentStatuses["currentLine"] += 1
      case line
        when /requirements:/
          currentStatuses["currentSection"] = :requirements
        when /runlevel:/
          currentStatuses["currentSection"] = :runlevel
        when /allowedUsers:/
          currentStatuses["currentSection"] = :allowedUsers
        when /function:/
          currentStatuses["currentSection"] = :functionDefine
          currentStatuses["functionStatus"] = true
        when /.*endOf(requirements|runlevel|allowedUsers|function);$/
          currentStatuses["currentSection"] = nil
        end
    end
  end
end
