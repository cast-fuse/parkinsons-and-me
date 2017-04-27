port module Main exposing (..)

import Test exposing (..)
import UserInfoSpec
import QuotesSpec
import WeightingsSpec
import ServicesSpec
import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)


main : TestProgram
main =
    run emit allTests


allTests : Test
allTests =
    describe "All Tests"
        [ UserInfoSpec.all
        , QuotesSpec.all
        , WeightingsSpec.all
        , ServicesSpec.all
        ]


port emit : ( String, Value ) -> Cmd msg
