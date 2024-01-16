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

  luaCode := string(content)

  L := lua.NewState()
  libs.Preload(L)
  defer L.Close()


  paramsString := bridge.RubyAction("params", []bridge.LuaArg{})[0].Value
  paramsList := strings.Fields(paramsString)

  L.SetGlobal("params", L.NewTable())
  for i := 0; i < len(paramsList); i++ {
    L.RawSet(L.GetGlobal("params").(*lua.LTable), lua.LNumber(i), lua.LString(paramsList[i]))
  }

  L.SetGlobal("print", L.NewFunction(intrinsics.CustomPrint))
  L.SetGlobal("input", L.NewFunction(intrinsics.Input))

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
