module Data.Services exposing (..)

import Model exposing (..)
import Data.Weightings exposing (..)
import Dict


handleTop3Services : Model -> Model
handleTop3Services model =
    { model | top3services = top3services model }


top3services : Model -> List ServiceData
top3services model =
    let
        userWeightings =
            relevantWeightings model
    in
        userWeightings
            |> top3Ids
            |> List.map (\sId -> Dict.get sId model.services)
            |> List.map (Maybe.withDefault nullServiceData)


top3Ids : WeightingsDict -> List ServiceId
top3Ids userWeightings =
    userWeightings
        |> Dict.toList
        |> List.sortWith (\( _, w1 ) ( _, w2 ) -> compare w2 w1)
        |> List.take 3
        |> List.map Tuple.first


nullServiceData : ServiceData
nullServiceData =
    { title = ""
    , body = ""
    , cta = ""
    , url = ""
    , earlyOnset = False
    , shortcode = ""
    }
