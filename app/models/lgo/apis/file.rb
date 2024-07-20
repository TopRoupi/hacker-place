module Lgo::Apis::File
  def cmd_createfile(machine, name, content)
    if VFile.find_by(name: name, machine: machine)
      return "ERROR: file already exists"
    end

    VFile.create(name: name, content: content, machine: machine)

    ""
  end

  def cmd_editfile(machine, name, content)
    VFile.find_by(name: name, machine: machine).update(content: content)

    ""
  end

  def cmd_deletefile(machine, name)
    file = VFile.find_by(name: name, machine: machine)

    if file.nil?
      "ERROR: file already exists"
    else
      file.destroy

      ""
    end
  end

  def cmd_getfile(machine, name)
    VFile.find_by(name: name, machine: machine).content
  end
end
