module QuotesSpec exposing (all)

import Test exposing (..)
import Expect
import Model exposing (..)
import Update exposing (..)
import Data.Quotes exposing (..)


all : Test
all =
    describe "Quotes Spec Test Suite"
        [ handleNextQuoteSpec
        , nextQuoteSpec
        , handleGoToServicesSpec
        ]


handleGoToServicesSpec : Test
handleGoToServicesSpec =
    describe "handleGoToServices"
        [ test "if there are no quotes left should change the view to Services" <|
            \() ->
                Expect.equal (handleGoToServices noQuotes) nextView
        , test "if there are remaining quotes should leave the model untouched" <|
            \() ->
                Expect.equal (handleGoToServices lastQuote) lastQuote
        , test "if there are remaining quotes should leave the model untouched" <|
            \() ->
                Expect.equal (handleGoToServices firstQuote) firstQuote
        ]


handleNextQuoteSpec : Test
handleNextQuoteSpec =
    describe "handleNextQuote"
        [ test "takes remaining quotes, sets the current quote and sets the new remaining quotes as the tail of the original list" <|
            \() ->
                Expect.equal (handleNextQuote initialQuotes) firstQuote
        , test "if there are no remaining quotes should return a model with remaining and current quotes as Nothing" <|
            \() ->
                Expect.equal (handleNextQuote lastQuote) noQuotes
        ]


nextQuoteSpec : Test
nextQuoteSpec =
    describe "nextQuote"
        [ test "takes a Maybe List of quoteIds and returns the head" <|
            \() ->
                Expect.equal (nextQuote (Just [ 1, 2, 3 ])) (Just 1)
        , test "Given Nothing returns Nothing" <|
            \() ->
                Expect.equal (nextQuote Nothing) Nothing
        ]


nextView : Model
nextView =
    { noQuotes | view = Services }


noQuotes : Model
noQuotes =
    { initialModel
        | remainingQuotes = Nothing
        , currentQuote = Nothing
    }


lastQuote : Model
lastQuote =
    { initialModel
        | remainingQuotes = Nothing
        , currentQuote = Just 5
    }


firstQuote : Model
firstQuote =
    { initialModel
        | remainingQuotes = Just [ 2, 3, 4, 5 ]
        , currentQuote = Just 1
    }


initialQuotes : Model
initialQuotes =
    { initialModel
        | remainingQuotes = Just [ 1, 2, 3, 4, 5 ]
    }
