package main

import (
  "fmt"
  "os"
  "strings"
  "strconv"
  "bufio"
  "log"
  "io/ioutil"
  lua "github.com/yuin/gopher-lua"
  libs "github.com/vadv/gopher-lua-libs/inspect"
  "encoding/json"
)

type LuaArg struct {
  Value string `json:"value"`
  Type string `json:"type"`
}

var rubyCommandId = 0

func rubyAction(action string, params []LuaArg) []LuaArg {
  rubyCommandId++

  jsonData, err := json.Marshal(params)
  if err != nil {
    fmt.Println("Error:", err)
    return make([]LuaArg, 0, 0)
  }

  fmt.Println("->RUBY(" + strconv.Itoa(rubyCommandId) + ") " + action + " " + string(jsonData))

  var result []LuaArg

  reader := bufio.NewReader(os.Stdin)
  input, err := reader.ReadString('\n')
  if err != nil {
      log.Fatal(err)
  }
  input = input[2:]

  var x []map[string]string
  json.Unmarshal([]byte(input), &x)

  for i := 0; i < len(x); i++ {
    arg := LuaArg{Value: x[i]["value"], Type: x[i]["type"]}
    result = append(result, arg)
  }

  return result
}

func customPrint(L *lua.LState) int {
  args := []LuaArg{}

  for i := 1; i <= L.GetTop(); i++ {
    arg := LuaArg{Value: L.Get(i).String(), Type: L.Get(i).Type().String()}
    args = append(args, arg)
  }

  rubyAction("print", args)

  return 0 // Number of return values
}

// takes no params or a string as param and print the string
// and waits for the user input and return string that the user
// typed
func input(L *lua.LState) int {
  numArgs := L.GetTop()

  args := []LuaArg{}
  if numArgs >= 1 {
    arg := L.Get(1)
    if arg.Type() == lua.LTString {
      args = append(args, LuaArg{Value: arg.String(), Type: "string"})
    } else {
      L.RaiseError("invalid param type")
      return 0 // Invalid argument type, do nothing
    }
  }

  result := rubyAction("input", args)

  L.Push(lua.LString(result[0].Value))
  return 1
}

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


  paramsString := rubyAction("params", []LuaArg{})[0].Value
  paramsList := strings.Fields(paramsString)

  L.SetGlobal("params", L.NewTable())
  for i := 0; i < len(paramsList); i++ {
    L.RawSet(L.GetGlobal("params").(*lua.LTable), lua.LNumber(i), lua.LString(paramsList[i]))
  }

  L.SetGlobal("print", L.NewFunction(customPrint))
  L.SetGlobal("input", L.NewFunction(input))

  if err := DoScriptInSandbox(L, luaCode); err != nil {
    args := []LuaArg{}
    args = append(args, LuaArg{Value: err.Error(), Type: "string"})
    rubyAction("print_error", args)
  }
}

func main() {
  argsWithoutProg := os.Args[1:]
  luaScriptPath := argsWithoutProg[0]

  runHscriptFromFile(luaScriptPath)
  fmt.Println("->PROGRAM_END")
}
