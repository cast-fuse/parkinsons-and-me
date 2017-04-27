module Data.Weightings exposing (..)

import Model exposing (..)
import Dict exposing (..)


alterWeightings : List ServiceId -> WeightingsDict -> WeightingsDict
alterWeightings serviceIds weightingsDict =
    let
        alterWeight sId weight =
            if List.member sId serviceIds then
                weight * 3
            else
                weight
    in
        Dict.map alterWeight weightingsDict


getEarlyOnsetIds : Services -> List ServiceId
getEarlyOnsetIds services =
    services
        |> Dict.toList
        |> List.filter (\( sid, { earlyOnset } ) -> earlyOnset)
        |> List.map Tuple.first


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


relevantWeightings : Model -> WeightingsDict
relevantWeightings model =
    let
        earlyOnSetIds =
            getEarlyOnsetIds model.services

        earlyOnsetUserWeightings =
            alterWeightings earlyOnSetIds model.userWeightings
    in
        if shouldReceiveEarlyOnsetWeightings model then
            earlyOnsetUserWeightings
        else
            model.userWeightings


getWeightingsById : Maybe QuoteId -> Weightings -> WeightingsDict
getWeightingsById qId weightings =
    case qId of
        Just i ->
            weightings
                |> Dict.get i
                |> Maybe.withDefault Dict.empty

        Nothing ->
            Dict.empty


shouldReceiveEarlyOnsetWeightings : Model -> Bool
shouldReceiveEarlyOnsetWeightings model =
    case model.ageRange of
        Just UnderForty ->
            True

        Just Forties ->
            True

        _ ->
            False


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
