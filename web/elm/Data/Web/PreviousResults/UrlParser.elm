module Data.Web.PreviousResults.UrlParser exposing (..)

import Model exposing (..)
import UrlParser exposing (..)
import Navigation


setEntryPoint : Navigation.Location -> EntryPoint
setEntryPoint location =
    let
        parsedHash =
            parseHash (s "previous-results" </> string) location
    in
        case parsedHash of
            Just answer_id ->
                Finish answer_id

            Nothing ->
                Start
