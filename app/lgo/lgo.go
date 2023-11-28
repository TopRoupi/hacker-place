package main

import (
  "strings"
  "fmt"
  "io/ioutil"
  "github.com/yuin/gopher-lua"
  "net"
)

func serverFunc(message string) {
  conn, err := net.Dial("tcp", "localhost:8069")
  if err != nil {
    fmt.Println("Error connecting to server:", err)
  }
  defer conn.Close()

  fmt.Fprintf(conn, "%s\n", message)
}

func customPrint(L *lua.LState) int {
  args := []string{}
  for i := 1; i <= L.GetTop(); i++ {
    args = append(args, L.ToString(i))
  }

  serverFunc(strings.Join(args, " "))
  // fmt.Fprintf(conn, "%s\n", strings.Join(args, " "))
  // fmt.Println("\033[34m" + strings.Join(args, " ") + "\033[0m")

  return 0 // Number of return values
}

func myGoFunction(L *lua.LState) int {
  result := "Hello from Go!"
  L.Push(lua.LString(result))
  return 1
}

func concatStringAndNumber(L *lua.LState) int {
  // Get the parameters from Lua
  str := L.CheckString(1) // CheckString verifies that the argument is a string
  num := L.CheckNumber(2) // CheckNumber verifies that the argument is a number

  // Perform some operation
  result := fmt.Sprintf("%s-%.2f", str, num)

  // Push the result back to Lua
  L.Push(lua.LString(result))

  return 1 // Number of return values
}

func DoScriptInSandbox(L *lua.LState, script string) error {
  // io := L.GetGlobal("io").(*lua.LTable)
  // orgopen := io.RawGetH(lua.LString("open"))
  // defer io.RawSetH(lua.LString("open"), orgopen)
  // sandboxfunc := L.NewFunction(func(L *lua.LState) int {
  //   L.RaiseError("can not call in a sandbox environment.")
  //   return 0
  // })
  // io.RawSetH(lua.LString("open"), sandboxfunc)
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
  defer L.Close()

  L.PreloadModule("io", func(L *lua.LState) int {
    return 0
  })

  L.SetGlobal("myGoFunction", L.NewFunction(myGoFunction))
  L.SetGlobal("concatStringAndNumber", L.NewFunction(concatStringAndNumber))
  L.SetGlobal("print", L.NewFunction(customPrint))

  if err := DoScriptInSandbox(L, luaCode); err != nil {
    fmt.Println(err.Error())
  }

  serverFunc("END")
}

func main() {
  runHscriptFromFile("/home/me/hacker-place/app/lgo/in.lua")
}
