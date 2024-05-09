class Desktop::AppFactory
  APPS = [:ide, :files]

  def self.get_app_component(app, args)
    send(:"#{app}_factory", args)
  end

  def self.ide_factory(args)
    Apps::Ide.new(
      computer_id: args[:computer_id],
      app_id: args[:app_id]
    )
  end

  def self.files_factory(args)
    Apps::FileExplorer.new(
      computer_id: args[:computer_id],
      app_id: args[:app_id]
    )
  end

  def self.file_factory(args)
    Apps::FileViewer.new(
      computer_id: args[:computer_id],
      app_id: args[:app_id],
      args: args[:args]
    )
  end

  def self.terminal_factory(args)
    Apps::Terminal.new(
      computer_id: args[:computer_id],
      app_id: args[:app_id],
      args: args[:args]
    )
  end
end
