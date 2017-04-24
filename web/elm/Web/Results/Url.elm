module Web.Results.Url exposing (..)

import Model exposing (..)
import UrlParser exposing (..)
import Navigation exposing (..)


setResultsUrl : Model -> Cmd Msg
setResultsUrl model =
    model.uuid
        |> Maybe.map resultsUrl
        |> Maybe.withDefault Cmd.none


resultsUrl : String -> Cmd Msg
resultsUrl uuid =
    modifyUrl <| "/#my-results/" ++ uuid


setEntryPoint : Navigation.Location -> EntryPoint
setEntryPoint location =
    let
        parsedHash =
            parseHash (s "my-results" </> string) location
    in
        case parsedHash of
            Just answerUUID ->
                Finish answerUUID

            Nothing ->
                Start
