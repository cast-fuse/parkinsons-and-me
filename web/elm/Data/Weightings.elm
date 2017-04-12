module Data.Weightings exposing (..)

import Model exposing (..)
import Dict exposing (..)


updateWeightings : Answer -> Model -> Model
updateWeightings answer model =
    let
        newWeightings =
            addWeightings model.userWeightings (getWeightingsById model.currentQuote model.weightings)
    in
        case answer of
            Yes ->
                { model | userWeightings = newWeightings }

            No ->
                model


getWeightingsById : Maybe QuoteId -> Weightings -> WeightingsDict
getWeightingsById qId weightings =
    case qId of
        Just i ->
            weightings
                |> Dict.get i
                |> Maybe.withDefault Dict.empty

        Nothing ->
            Dict.empty


makeEmptyWeightingsDict : Services -> WeightingsDict
makeEmptyWeightingsDict services =
    services
        |> Dict.map (\_ _ -> 0)


addWeightings : WeightingsDict -> WeightingsDict -> WeightingsDict
addWeightings w1 w2 =
    let
        add sId a b acc =
            Dict.insert sId (a + b) acc

        skip _ _ acc =
            acc
    in
        Dict.merge skip add skip w1 w2 Dict.empty
