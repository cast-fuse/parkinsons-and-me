module Data.Web.PreviousResults.HandleEntryPoint exposing (..)

import Model exposing (..)
import Data.Web.QuoteServiceWeightings exposing (..)
import Data.Web.PreviousResults.Request exposing (..)


handleGetUserData : Model -> List (Cmd Msg)
handleGetUserData model =
    case model.entryPoint of
        Start ->
            [ getQuoteServiceWeightings ]

        Finish aId ->
            [ getQuoteServiceWeightings, getPreviousResults aId ]
