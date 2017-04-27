module WeightingsSpec exposing (..)

import Test exposing (..)
import Expect
import TestHelpers exposing (..)
import Model exposing (..)
import Update exposing (..)
import Data.Weightings exposing (..)


all : Test
all =
    describe "Weightings Spec Test Suite"
        [ makeEmptyWeightingsDictSpec
        , addWeightingsSpec
        , updateWeightingsSpec
        , alterWeightingsSpec
        , relevantWeightingsSpec
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


alterWeightingsSpec : Test
alterWeightingsSpec =
    describe "alterWeightingsSpec"
        [ test "takes a list of earlyOnset serviceIds and a weightingsDict and times the services score by 3 if it is an earlyOnset one" <|
            \() -> Expect.equal (alterWeightings earlyOnsetIds dummyWeightingsDict) dummyWeightingsDictEarlyOnset
        ]


earlyOnsetModel : Model
earlyOnsetModel =
    { initialModel
        | userWeightings = dummyWeightingsDict
        , ageRange = Just Forties
        , services = servicesDict
    }


lateOnsetModel : Model
lateOnsetModel =
    { initialModel
        | userWeightings = dummyWeightingsDict
        , ageRange = Just Seventies
        , services = servicesDict
    }


relevantWeightingsSpec : Test
relevantWeightingsSpec =
    describe "relevantWeightingsSpec"
        [ test "takes a model where user is earlyOnset and returns userWeightings altered appropriately" <|
            \() -> Expect.equal (relevantWeightings earlyOnsetModel) dummyWeightingsDictEarlyOnset
        , test "takes a model where user is earlyOnset and returns userWeightings altered appropriately" <|
            \() -> Expect.equal (relevantWeightings lateOnsetModel) dummyWeightingsDict
        ]
