package intrinsics

import (
  "lgo/bridge"
  lua "github.com/yuin/gopher-lua"
)

// TODO: 1 - add File type, 2 - add Computer type, 3 - compose the 2 types

func CreateFile(L *lua.LState) int {
  computer := L.CheckUserData(1)
  name := L.CheckString(2)
  content := L.CheckString(3)
  v, ok := computer.Value.(*Computer)
  if !ok {
    L.ArgError(1, "computer expected")
  }

  args := []bridge.LuaArg{}
  args = append(args, bridge.LuaArg{Value: v.id, Type: "string"})
  args = append(args, bridge.LuaArg{Value: name, Type: "string"})
  args = append(args, bridge.LuaArg{Value: content, Type: "string"})

  result := bridge.RubyAction("createfile", args)[0].Value
  if(len(result) > 0) {
    L.RaiseError(result)
  }

  return 0
}

func EditFile(L *lua.LState) int {
  computer := L.CheckUserData(1)
  name := L.CheckString(2)
  content := L.CheckString(3)
  v, ok := computer.Value.(*Computer)
  if !ok {
    L.ArgError(1, "computer expected")
  }

  args := []bridge.LuaArg{}
  args = append(args, bridge.LuaArg{Value: v.id, Type: "string"})
  args = append(args, bridge.LuaArg{Value: name, Type: "string"})
  args = append(args, bridge.LuaArg{Value: content, Type: "string"})

  bridge.RubyAction("editfile", args)

  return 0
}

func DeleteFile(L *lua.LState) int {
  computer := L.CheckUserData(1)
  name := L.CheckString(2)
  v, ok := computer.Value.(*Computer)
  if !ok {
    L.ArgError(1, "computer expected")
  }

  args := []bridge.LuaArg{}
  args = append(args, bridge.LuaArg{Value: v.id, Type: "string"})
  args = append(args, bridge.LuaArg{Value: name, Type: "string"})

  result := bridge.RubyAction("deletefile", args)[0].Value

  if(len(result) > 0) {
    L.RaiseError(result)
  }

  return 0
}

func GetFile(L *lua.LState) int {
  computer := L.CheckUserData(1)
  name := L.CheckString(2)
  v, ok := computer.Value.(*Computer)
  if !ok {
    L.ArgError(1, "computer expected")
  }

  args := []bridge.LuaArg{}
  args = append(args, bridge.LuaArg{Value: v.id, Type: "string"})
  args = append(args, bridge.LuaArg{Value: name, Type: "string"})

  result := bridge.RubyAction("getfile", args)

  L.Push(lua.LString(result[0].Value))
  return 1
}
