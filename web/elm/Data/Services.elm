module Data.Services exposing (..)

import Model exposing (..)
import Data.Weightings exposing (..)
import Dict


handleTop3Services : Model -> Model
handleTop3Services model =
    { model | top3Services = top3Services model }


top3Services : Model -> List ServiceData
top3Services model =
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


shortcodeToWidget : ServiceData -> ServiceWidget
shortcodeToWidget service =
    case service.shortcode of
        "peer_support" ->
            PeerSupport

        "forum" ->
            Forum

        "groups" ->
            Groups

        "parkinsons_nurse" ->
            ParkinsonsNurse

        "self_management" ->
            SelfManagement

        "local_advisor" ->
            LocalAdvisor

        "helpline" ->
            HelpLine

        "facebook" ->
            Facebook

        "newly_diagnosed" ->
            NewlyDiagnosed

        "early_onset" ->
            EarlyOnset

        "publications" ->
            Publications

        _ ->
            Publications


nullServiceData : ServiceData
nullServiceData =
    { title = ""
    , body = ""
    , cta = ""
    , url = ""
    , earlyOnset = False
    , shortcode = ""
    }
