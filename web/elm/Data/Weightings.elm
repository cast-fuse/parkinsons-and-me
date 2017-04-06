module Data.Weightings exposing (..)

import Model exposing (..)
import Dict exposing (..)


-- import Data.Quotes exposing (..)
-- mergeWeightings : Weighting


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
