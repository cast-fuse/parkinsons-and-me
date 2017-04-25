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
    ServiceData "" "" "" "" False ""


servicesDict : Services
servicesDict =
    serviceIds
        |> List.map (\x -> ( x, dummyServiceData ))
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


serviceIds : List Int
serviceIds =
    [ 1, 2, 3 ]


quoteIds : List Int
quoteIds =
    [ 1, 2, 3 ]


doubleServiceWeightings : List Float
doubleServiceWeightings =
    List.map (\x -> x * 2) serviceWeightings


serviceWeightings : List Float
serviceWeightings =
    [ 0.8, 0.9, 0.3 ]
