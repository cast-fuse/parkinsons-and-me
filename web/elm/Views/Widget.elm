module Views.Widget exposing (..)

import Model exposing (..)
import Html exposing (..)
import Components.EarlyOnset exposing (..)
import Components.Facebook exposing (..)
import Components.Forum exposing (..)


renderWidget : ServiceWidget -> Html Msg
renderWidget widget =
    case widget of
        EarlyOnset ->
            earlyOnset

        Facebook ->
            facebook

        Forum ->
            forum

        _ ->
            forum
