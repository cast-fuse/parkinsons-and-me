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


setEntryPoint : Navigation.Location -> Model -> Model
setEntryPoint location model =
    let
        parsedHash =
            parseHash (s "my-results" </> string) location
    in
        case parsedHash of
            Just answerUUID ->
                { model
                    | entryPoint = Finish answerUUID
                    , view = Loading
                    , uuid = Just answerUUID
                }

            Nothing ->
                { model | entryPoint = Start }
