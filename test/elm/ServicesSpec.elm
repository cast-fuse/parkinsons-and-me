module ServicesSpec exposing (..)

import Test exposing (..)
import Expect
import WeightingsSpec exposing (earlyOnsetModel, lateOnsetModel)
import TestHelpers exposing (..)
import Data.Services exposing (..)


all : Test
all =
    describe "Services Spec Test Suite"
        [ top3IdsSpec
        , top3ServicesSpec
        ]


top3IdsSpec : Test
top3IdsSpec =
    describe "top3IdsSpec"
        [ test "takes a weightingsDict and returns the top3 serviceIds" <|
            \() -> Expect.equal (top3Ids dummyWeightingsDict) top3ServiceIds
        , test "takes a weightingsDict and returns the top3 serviceIds" <|
            \() -> Expect.equal (top3Ids dummyWeightingsDictEarlyOnset) top3EarlyOnsetIds
        ]



-- dummyServiceData and dummyServiceDataEarlyOnset only vary in the earlyOnset record field being set to False
-- and True respectively. The way the dummyData is made means that a service with an odd serviceId will
-- have dummyServiceData as its ServiceData and one with an even serviceId will be have dummyServiceDataEarlyOnset.
-- This is how the order of the List which is the second argument to Expect.equal can be worked out.


top3ServicesSpec : Test
top3ServicesSpec =
    describe "top3ServicesSpec"
        [ test "takes a earlyOnset model and returns a list of the top 3 ServiceData" <|
            \() -> Expect.equal (top3Services earlyOnsetModel) [ dummyServiceDataEarlyOnset, dummyServiceData, dummyServiceDataEarlyOnset ]
        , test "takes a lateOnset model and returns a list of the top 3 ServiceData" <|
            \() -> Expect.equal (top3Services lateOnsetModel) [ dummyServiceData, dummyServiceDataEarlyOnset, dummyServiceData ]
        ]
