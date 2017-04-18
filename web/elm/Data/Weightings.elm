module Data.Weightings exposing (..)

import Model exposing (..)
import Dict exposing (..)


handleEarlyOnsetWeightings : QuoteServiceWeightings -> Weightings
handleEarlyOnsetWeightings quoteServiceWeightings =
    let
        serviceIds =
            getEarlyOnsetIds quoteServiceWeightings.services
    in
        alterWeightings serviceIds quoteServiceWeightings.weightings


alterWeightings : List ServiceId -> Weightings -> Weightings
alterWeightings serviceIds weightings =
    let
        alterWeight sId weight =
            if List.member sId serviceIds then
                weight * 3
            else
                weight
    in
        weightings
            |> Dict.map (\_ weightingsDict -> Dict.map alterWeight weightingsDict)


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
            addWeightings model.userWeightings (getWeightingsById model.currentQuote <| relevantWeightings model)
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


relevantWeightings : Model -> Weightings
relevantWeightings model =
    if shouldReceiveEarlyOnsetWeightings model then
        model.earlyOnsetWeightings
    else
        model.weightings


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
