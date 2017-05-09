module TestHelpers exposing (..)

import Model exposing (..)
import Dict


dummyWeightings : Weightings
dummyWeightings =
    quoteIds
        |> List.map (\x -> ( x, dummyWeightingsDict ))
        |> Dict.fromList


dummyServiceData : ServiceData
dummyServiceData =
    { title = ""
    , body = ""
    , cta = ""
    , url = ""
    , earlyOnset = False
    , locationBasedUrl = False
    }


dummyServiceDataEarlyOnset : ServiceData
dummyServiceDataEarlyOnset =
    { dummyServiceData
        | earlyOnset = True
    }


insertDummyServiceData : Int -> ServiceData
insertDummyServiceData i =
    if i % 2 == 0 then
        dummyServiceData
    else
        dummyServiceDataEarlyOnset


servicesDict : Services
servicesDict =
    serviceIds
        |> List.indexedMap (\i x -> ( x, insertDummyServiceData i ))
        |> Dict.fromList


zerosWeightingDict : WeightingsDict
zerosWeightingDict =
    serviceIds
        |> List.map (\x -> ( x, 0 ))
        |> Dict.fromList


doubleWeightingsDict : WeightingsDict
doubleWeightingsDict =
    doubleServiceWeightings
        |> List.map2 (,) serviceIds
        |> Dict.fromList


dummyWeightingsDict : WeightingsDict
dummyWeightingsDict =
    serviceWeightings
        |> List.map2 (,) serviceIds
        |> Dict.fromList


dummyWeightingsDictEarlyOnset : WeightingsDict
dummyWeightingsDictEarlyOnset =
    dummyWeightingsDict
        |> Dict.map
            (\i x ->
                if List.member i earlyOnsetIds then
                    3 * x
                else
                    x
            )


top3EarlyOnsetIds : List Int
top3EarlyOnsetIds =
    let
        alterWeight ( sId, w ) =
            if List.member sId earlyOnsetIds then
                ( sId, w * 3 )
            else
                ( sId, w )
    in
        serviceWeightings
            |> List.map2 (,) serviceIds
            |> List.map alterWeight
            |> sortIdsByWeight


top3ServiceIds : List Int
top3ServiceIds =
    serviceWeightings
        |> List.map2 (,) serviceIds
        |> sortIdsByWeight


sortIdsByWeight : List ( Int, Float ) -> List Int
sortIdsByWeight weightIds =
    weightIds
        |> List.sortBy Tuple.second
        |> List.reverse
        |> List.map Tuple.first
        |> List.take 3


serviceIds : List Int
serviceIds =
    [ 1, 2, 3, 4, 5, 6 ]


serviceWeightings : List Float
serviceWeightings =
    [ 0.1, 0.5, 0.3, 0.2, 0.8, 0.0 ]


earlyOnsetIds : List Int
earlyOnsetIds =
    [ 2, 4 ]


quoteIds : List Int
quoteIds =
    [ 1, 2, 3, 4, 5 ]


doubleServiceWeightings : List Float
doubleServiceWeightings =
    List.map (\x -> x * 2) serviceWeightings
