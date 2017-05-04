module Web.Results.EntryPoint exposing (..)

import Model exposing (..)
import Model.Email as Email exposing (Email)
import Model.Postcode as Postcode
import Web.QuoteServiceWeightings exposing (..)
import Web.Results.Request exposing (..)
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
            List.map Tuple.first answers

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
        , postcode = Postcode.Valid user.postcode
        , email = populateEmail user.email model
        , emailConsent = user.emailConsent
        , ageRange = Just user.ageRange
    }


populateEmail : String -> Model -> Email
populateEmail email model =
    if email == "" then
        Email.NotEntered
    else
        case model.entryPoint of
            Start ->
                Email.Valid email

            Finish _ ->
                Email.Retrieved email


foldAnswers : List ( QuoteId, Answer ) -> Model -> Model
foldAnswers answers model =
    List.foldl (\( _, answer ) model -> handleAnswer answer model) model answers
