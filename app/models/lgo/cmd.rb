class Lgo::Cmd
  include CableReady::Broadcaster
  # include Lgo::TerminalIntrinsics
  include Lgo::CableIntrinsics
  include Lgo::CmdPreparation

  attr_reader :id, :cmd, :args, :lgo

  def initialize(lgo)
    @lgo = lgo
    @id, @cmd = lgo.last_line.split(" ")
    @args = JSON.parse(lgo.last_line.split(" ")[2..].join(" "))
  end

  def run
    send("pre_cmd_#{cmd}", args)
  end

  def self.is_cmd?(text)
    text[0..3] == "RUBY"
  end
end
