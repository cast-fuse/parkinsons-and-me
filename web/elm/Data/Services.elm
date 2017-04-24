module Data.Services exposing (..)

import Model exposing (..)
import Dict


handleTop3Things : Model -> Model
handleTop3Things model =
    case model.view of
        Services ->
            { model | top3things = top3things model.userWeightings model.services }

        _ ->
            model


top3things : WeightingsDict -> Services -> List ServiceData
top3things userWeightings services =
    userWeightings
        |> top3Ids
        |> List.map (\sId -> Dict.get sId services)
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
