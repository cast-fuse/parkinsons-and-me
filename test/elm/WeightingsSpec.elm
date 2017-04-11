module WeightingsSpec exposing (..)

import Test exposing (..)
import Expect
import TestHelpers exposing (..)
import Model exposing (..)
import Update exposing (..)
import Data.Weightings exposing (..)
import Dict exposing (..)


all : Test
all =
    describe "Weightings Spec Test Suite"
        [ makeEmptyWeightingsDictSpec
        , addWeightingsSpec
        , updateWeightingsSpec
        ]


updateWeightingsSpec : Test
updateWeightingsSpec =
    describe "updateWeightings"
        [ test "given a Yes will add the current weightings together" <|
            \() ->
                Expect.equal (updateWeightings Yes firstQuoteModel) secondQuoteModel
        ]


secondQuoteModel : Model
secondQuoteModel =
    { firstQuoteModel
        | userWeightings = doubleWeightingsDict
    }


firstQuoteModel : Model
firstQuoteModel =
    { initialModel
        | userWeightings = dummyWeightingsDict
        , weightings = dummyWeightings
        , currentQuote = Just 1
        , remainingQuotes = Just [ 2, 3 ]
    }


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
