port module Main exposing (..)

import Test exposing (..)
import UserInfoSpec
import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)


main : TestProgram
main =
    run emit (describe "all tests:" [ UserInfoSpec.all ])


port emit : ( String, Value ) -> Cmd msg
