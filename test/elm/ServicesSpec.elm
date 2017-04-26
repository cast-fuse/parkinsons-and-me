module ServicesSpec exposing (..)

import Test exposing (..)
import Expect
import TestHelpers exposing (..)
import Data.Services exposing (..)


all : Test
all =
    describe "Services Spec Test Suite" [ top3IdsSpec ]


top3IdsSpec : Test
top3IdsSpec =
    describe "top3IdsSpec"
        [ test "takes a weightingsDict and returns the top3 serviceIds" <|
            \() -> Expect.equal (top3Ids dummyWeightingsDict) [ 5, 2, 3 ]
        , test "takes a weightingsDict and returns the top3 serviceIds" <|
            \() -> Expect.equal (top3Ids dummyWeightingsDictEarlyOnset) [ 2, 5, 4 ]
        ]
