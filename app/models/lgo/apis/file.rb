module Lgo::Apis::File
  def cmd_createfile(name, content)
    computer = @lgo.computer

    if VFile.find_by(name: name, computer: computer)
      return "ERROR: file already exists"
    end

    VFile.create(name: name, content: content, computer: computer)

    ""
  end

  def cmd_editfile(name, content)
    computer = @lgo.computer

    VFile.find_by(name: name, computer: computer).update(content: content)

    ""
  end

  def cmd_deletefile(name)
    computer = @lgo.computer

    file = VFile.find_by(name: name, computer: computer)

    if file.nil?
      "ERROR: file already exists"
    else
      file.destroy

      ""
    end
  end

  def cmd_getfile(name)
    computer = @lgo.computer

    VFile.find_by(name: name, computer: computer).content
  end
end
