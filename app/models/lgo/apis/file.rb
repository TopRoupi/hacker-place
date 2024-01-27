module Lgo::Apis::File
  def cmd_createfile(name, content)
    if VFile.find_by(name: name, computer: Computer.last)
      return "ERROR: file already exists"
    end

    VFile.create(name: name, content: content, computer: Computer.last)

    ""
  end

  def cmd_editfile(name, content)
    VFile.find_by(name: name, computer: Computer.last).update(content: content)

    ""
  end

  def cmd_deletefile(name)
    VFile.find_by(name: name, computer: Computer.last).destroy

    ""
  end
end
