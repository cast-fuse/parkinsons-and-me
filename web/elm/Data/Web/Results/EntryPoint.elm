module Data.Web.Results.EntryPoint exposing (..)

import Model exposing (..)
import Data.Web.QuoteServiceWeightings exposing (..)
import Data.Web.Results.Request exposing (..)
import Data.Services exposing (..)
import Data.Weightings exposing (..)
import Data.Quotes exposing (..)
import Data.Answers exposing (handleAnswer)


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
            | currentQuote = List.head qIds
            , remainingQuotes = List.tail qIds
        }
            |> repopulateUserData user
            |> setQuoteServiceWeightings data
            |> foldAnswers answers
            |> handleGoToServices
            |> handleTop3Things


repopulateUserData : RawUser -> Model -> Model
repopulateUserData user model =
    { model
        | userId = Just user.id
        , name = Just user.name
        , postcode = Valid user.postcode
        , email = Just user.email
        , ageRange = Just user.ageRange
    }


setQuoteServiceWeightings : QuoteServiceWeightings -> Model -> Model
setQuoteServiceWeightings data model =
    { model
        | quotes = data.quotes
        , services = data.services
        , weightings = data.weightings
        , userWeightings = makeEmptyWeightingsDict data.services
        , earlyOnsetWeightings = handleEarlyOnsetWeightings data
    }


foldAnswers : List ( QuoteId, Answer ) -> Model -> Model
foldAnswers answers model =
    List.foldl (\( _, answer ) model -> handleAnswer answer model) model answers
