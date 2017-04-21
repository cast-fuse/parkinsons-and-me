module Data.Web.Results.EntryPoint exposing (..)

import Model exposing (..)
import Model.Email exposing (Email(Retrieved))
import Model.Postcode exposing (Postcode(Valid))
import Data.Web.QuoteServiceWeightings exposing (..)
import Data.Web.Results.Request exposing (..)
import Data.QuoteServiceWeightings exposing (..)
import Data.Services exposing (..)
import Data.Quotes exposing (..)
import Data.Answers exposing (handleAnswer)


handleGetUserData : Model -> List (Cmd Msg)
handleGetUserData model =
    case model.entryPoint of
        Start ->
            [ getQuoteServiceWeightings ]

        Finish answerUUID ->
            [ getResults answerUUID ]


loadResults : Results -> Model -> Model
loadResults { user, answers, quotes, services, weightings } model =
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
        , email = Retrieved user.email
        , ageRange = Just user.ageRange
    }


foldAnswers : List ( QuoteId, Answer ) -> Model -> Model
foldAnswers answers model =
    List.foldl (\( _, answer ) model -> handleAnswer answer model) model answers
