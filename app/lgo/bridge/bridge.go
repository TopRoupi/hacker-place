package bridge

import (
  "encoding/json"
  "fmt"
  "os"
  "strconv"
  "log"
  "bufio"
)

type LuaArg struct {
  Value string `json:"value"`
  Type string `json:"type"`
}

var rubyCommandId = 0

func RubyAction(action string, params []LuaArg) []LuaArg {
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
