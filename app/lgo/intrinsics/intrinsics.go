package intrinsics

import (
  "lgo/bridge"
  lua "github.com/yuin/gopher-lua"
)

func CustomPrint(L *lua.LState) int {
  args := []bridge.LuaArg{}

  for i := 1; i <= L.GetTop(); i++ {
    arg := bridge.LuaArg{Value: L.Get(i).String(), Type: L.Get(i).Type().String()}
    args = append(args, arg)
  }

  bridge.RubyAction("print", args)

  return 0 // Number of return values
}

// takes no params or a string as param and print the string
// and waits for the user input and return string that the user
// typed
func Input(L *lua.LState) int {
  numArgs := L.GetTop()

  args := []bridge.LuaArg{}
  if numArgs >= 1 {
    arg := L.Get(1)
    if arg.Type() == lua.LTString {
      args = append(args, bridge.LuaArg{Value: arg.String(), Type: "string"})
    } else {
      L.RaiseError("invalid param type")
      return 0 // Invalid argument type, do nothing
    }
  }

  result := bridge.RubyAction("input", args)

  L.Push(lua.LString(result[0].Value))
  return 1
}

