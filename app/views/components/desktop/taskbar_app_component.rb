class Desktop::TaskbarAppComponent < ApplicationComponent
  def initialize(name)
    @name = name
  end

  def template
    button(class: "p-2 bg-white/10") do
      @name
    end
  end
end
