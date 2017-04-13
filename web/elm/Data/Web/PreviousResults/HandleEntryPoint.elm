module Data.Web.PreviousResults.HandleEntryPoint exposing (..)

import Model exposing (..)
import Data.Web.QuoteServiceWeightings exposing (..)
import Data.Web.PreviousResults.Request exposing (..)
import Data.Services exposing (..)
import Data.Weightings exposing (..)
import Data.Quotes exposing (..)


handleGetUserData : Model -> List (Cmd Msg)
handleGetUserData model =
    case model.entryPoint of
        Start ->
            [ getQuoteServiceWeightings ]

        Finish aId ->
            [ getPreviousResults aId ]


loadPreviousResults : PreviousResults -> Model -> Model
loadPreviousResults { user, answers, quotes, services, weightings } model =
    let
        qIds =
            getQuoteIds quotes

        data =
            { weightings = weightings
            , quotes = quotes
            , services = services
            }
    in
        { model
            | userId = Just user.id
            , name = Just user.name
            , postcode = Valid user.postcode
            , email = Just user.email
            , currentQuote = List.head qIds
            , remainingQuotes = List.tail qIds
            , quotes = quotes
            , services = services
            , weightings = weightings
            , userWeightings = makeEmptyWeightingsDict services
            , earlyOnsetWeightings = handleEarlyOnsetWeightings data
        }
            |> foldAnswers answers
            |> handleGoToServices
            |> handleTop3Things


foldAnswers : List ( QuoteId, Answer ) -> Model -> Model
foldAnswers answers model =
    List.foldl (\( _, answer ) model -> handleAnswer answer model |> updateWeightings answer |> handleNextQuote) model answers
