module Helpers.Delay exposing (..)

import Model exposing (..)
import Time exposing (..)
import Process
import Task


setTimeout : Float -> msg -> Cmd msg
setTimeout x msg =
    Process.sleep (millisecond * x)
        |> Task.map (always msg)
        |> Task.perform identity


waitThenShowServices : Cmd Msg
waitThenShowServices =
    setTimeout 800 <| SetView Services
