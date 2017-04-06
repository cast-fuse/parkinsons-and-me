module WeightingsSpec exposing (..)

import Test exposing (..)
import Expect
import Model exposing (..)
import Update exposing (..)
import Data.Weightings exposing (..)
import Dict exposing (..)


all : Test
all =
    describe "Weightings Spec Test Suite"
        [ makeEmptyWeightingsDictSpec, addWeightingsSpec ]


makeEmptyWeightingsDictSpec : Test
makeEmptyWeightingsDictSpec =
    describe "makeEmptyWeightingsDict"
        [ test "takes a services dict and returns a dict with serviceIds as keys and values all 0.0" <|
            \() -> Expect.equal (makeEmptyWeightingsDict servicesDict) zerosWeightingDict
        ]


addWeightingsSpec : Test
addWeightingsSpec =
    describe "addWeightingsDictSpec"
        [ test "takes 2 weightingsDict and combines their values by adding them together" <|
            \() -> Expect.equal (addWeightings zerosWeightingDict dummyWeightingsDict) dummyWeightingsDict
        ]


dummyServiceData : ServiceData
dummyServiceData =
    ServiceData "" "" "" ""


servicesDict : Services
servicesDict =
    Dict.fromList [ ( 0, dummyServiceData ), ( 1, dummyServiceData ), ( 2, dummyServiceData ) ]


zerosWeightingDict : WeightingsDict
zerosWeightingDict =
    Dict.fromList [ ( 0, 0 ), ( 1, 0 ), ( 2, 0 ) ]


dummyWeightingsDict : WeightingsDict
dummyWeightingsDict =
    Dict.fromList [ ( 0, 0.8 ), ( 1, 0.9 ), ( 2, 0.3 ) ]
