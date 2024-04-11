module Lgo::Apis::File
  def cmd_createfile(name, content)
    computer = Computer.default_pc

    if VFile.find_by(name: name, computer: computer)
      return "ERROR: file already exists"
    end

    VFile.create(name: name, content: content, computer: computer)

    ""
  end

  def cmd_editfile(name, content)
    computer = Computer.default_pc

    VFile.find_by(name: name, computer: computer).update(content: content)

    ""
  end

  def cmd_deletefile(name)
    computer = Computer.default_pc

    VFile.find_by(name: name, computer: computer).destroy

    ""
  end
end
