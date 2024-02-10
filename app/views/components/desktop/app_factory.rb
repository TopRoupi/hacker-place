class Desktop::AppFactory
  APPS = [:ide, :files]

  def self.get_app_component(app, args)
    send(:"#{app}_factory", args)
  end

  def self.ide_factory(args)
    IdeComponent.new(computer_id: args[:computer_id], app_id: args[:app_id])
  end

  def self.files_factory(args)
    FileExplorerComponent.new(Computer.last)
  end
end
