module Lgo::Apis::File
  def cmd_createfile(name, content)
    VFile.create(name: name, content: content, computer: Computer.last)

    nil
  end

  def cmd_editfile(name, content)
    VFile.find_by(name: name, computer: Computer.last).update(content: content)

    nil
  end

  def cmd_deletefile(name)
    VFile.find_by(name: name, computer: Computer.last).destroy

    nil
  end
end
