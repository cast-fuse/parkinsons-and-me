module Web.Results.UrlParser exposing (..)

import Model exposing (..)
import UrlParser exposing (..)
import Navigation


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
