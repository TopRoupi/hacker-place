package intrinsics

import (
  "lgo/bridge"
  lua "github.com/yuin/gopher-lua"
)

type Computer struct {
    id string
    Hostname string
}

const luaComputerTypeName = "computer"

func RegisterComputerType(L *lua.LState) {
    mt := L.NewTypeMetatable(luaComputerTypeName)
    L.SetGlobal("computer", mt)
    L.SetField(mt, "__index", L.SetFuncs(L.NewTable(), computerMethods))
}

func GetComputer(L *lua.LState) int {
    args := []bridge.LuaArg{}
    result := bridge.RubyAction("getcomputer", args)

    computer := &Computer{result[0].Value, result[1].Value}
    ud := L.NewUserData()
    ud.Value = computer
    L.SetMetatable(ud, L.GetTypeMetatable(luaComputerTypeName))
    L.Push(ud)
    return 1
}

var computerMethods = map[string]lua.LGFunction{
    "hostname": computerGetSetName,
    "type": computerGetType,
}

func computerGetType(L *lua.LState) int {
    L.Push(lua.LString("computer"))
    return 1
}

// Checks whether the first lua argument is a *LUserData with *Computer and returns this *Computer.
func checkComputer(L *lua.LState) *Computer {
    ud := L.CheckUserData(1)
    if v, ok := ud.Value.(*Computer); ok {
        return v
    }
    L.ArgError(1, "computer expected")
    return nil
}

func computerGetSetName(L *lua.LState) int {
    c := checkComputer(L)
    if L.GetTop() == 2 {
        c.Hostname = L.CheckString(2)
        return 0
    }
    L.Push(lua.LString(c.Hostname))
    return 1
}
