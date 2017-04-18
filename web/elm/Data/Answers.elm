module Data.Answers exposing (..)

import Model exposing (..)
import Data.Weightings exposing (updateWeightings)
import Data.Quotes exposing (handleNextQuote)


handleAnswer : Answer -> Model -> Model
handleAnswer answer model =
    model
        |> handleAnswer answer
        |> updateWeightings answer
        |> handleNextQuote


storeAnswer : Answer -> Model -> Model
storeAnswer answer model =
    case model.currentQuote of
        Just qId ->
            { model | userAnswers = model.userAnswers ++ [ ( qId, answer ) ] }

        Nothing ->
            model
