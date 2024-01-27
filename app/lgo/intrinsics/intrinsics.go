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

// TODO: 1 - add File type, 2 - add Computer type, 3 - compose the 2 types

func CreateFile(L *lua.LState) int {
  name := L.CheckString(1)
  content := L.CheckString(2)

  args := []bridge.LuaArg{}
  args = append(args, bridge.LuaArg{Value: name, Type: "string"})
  args = append(args, bridge.LuaArg{Value: content, Type: "string"})

  result := bridge.RubyAction("createfile", args)[0].Value
  if(len(result) > 0) {
    L.RaiseError(result)
  }

  return 0
}

func EditFile(L *lua.LState) int {
  name := L.CheckString(1)
  content := L.CheckString(2)

  args := []bridge.LuaArg{}
  args = append(args, bridge.LuaArg{Value: name, Type: "string"})
  args = append(args, bridge.LuaArg{Value: content, Type: "string"})

  bridge.RubyAction("editfile", args)

  return 0
}

func DeleteFile(L *lua.LState) int {
  name := L.CheckString(1)

  args := []bridge.LuaArg{}
  args = append(args, bridge.LuaArg{Value: name, Type: "string"})

  bridge.RubyAction("deletefile", args)

  return 0
}
