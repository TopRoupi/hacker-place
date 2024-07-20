module Lgo::Apis::Computer
  def cmd_getcomputer
    [@lgo.machine.to_sgid.to_s, "lol2"]
  end
end
