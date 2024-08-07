package main

import (
  "fmt"
  "os"
  "strings"
  "io/ioutil"
  lua "github.com/yuin/gopher-lua"
  libs "github.com/vadv/gopher-lua-libs/inspect"
  "lgo/intrinsics"
  "lgo/bridge"
)

func DoScriptInSandbox(L *lua.LState, script string) error {
  L.SetGlobal("io", lua.LNil)

  err := L.DoString(script)

  return err
}

func runHscriptFromFile(fname string) {
  content, err := ioutil.ReadFile(fname)
  if err != nil {
    fmt.Println("Error:", err)
    return
  }

  append_code := "local inspect = require(\"inspect\")\n"

  luaCode := append_code + string(content)

  L := lua.NewState()
  libs.Preload(L)
  defer L.Close()


  paramsString := bridge.RubyAction("params", []bridge.LuaArg{})[0].Value
  paramsList := strings.Fields(paramsString)

  L.SetGlobal("params", L.NewTable())
  for i := 0; i < len(paramsList); i++ {
    L.RawSet(L.GetGlobal("params").(*lua.LTable), lua.LNumber(i + 1), lua.LString(paramsList[i]))
  }

  intrinsics.RegisterComputerType(L)
  L.SetGlobal("get_computer", L.NewFunction(intrinsics.GetComputer))

  L.SetGlobal("print", L.NewFunction(intrinsics.CustomPrint))
  L.SetGlobal("input", L.NewFunction(intrinsics.Input))

  L.SetGlobal("createfile", L.NewFunction(intrinsics.CreateFile))
  L.SetGlobal("editfile", L.NewFunction(intrinsics.EditFile))
  L.SetGlobal("deletefile", L.NewFunction(intrinsics.DeleteFile))
  L.SetGlobal("getfile", L.NewFunction(intrinsics.GetFile))

  if err := DoScriptInSandbox(L, luaCode); err != nil {
    args := []bridge.LuaArg{}
    args = append(args, bridge.LuaArg{Value: err.Error(), Type: "string"})
    bridge.RubyAction("print_error", args)
  }
}

func main() {
  argsWithoutProg := os.Args[1:]
  luaScriptPath := argsWithoutProg[0]

  runHscriptFromFile(luaScriptPath)
  fmt.Println("->PROGRAM_END")
}
