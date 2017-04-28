module Views.Router exposing (router)

import Views.Loading exposing (..)
import Views.Home exposing (home)
import Views.UserInfo.Name exposing (name)
import Views.UserInfo.Postcode exposing (postcode)
import Views.UserInfo.Age exposing (age)
import Views.Quotes exposing (quotes)
import Views.Services exposing (..)
import Components.Utils exposing (emptyDiv)
import Model exposing (..)
import Html exposing (..)


router : Model -> Html Msg
router model =
    let
        handleLoading view =
            loadingBackground model <| view model
    in
        case model.view of
            Home ->
                handleLoading home

            Name ->
                handleLoading name

            Postcode ->
                handleLoading postcode

            Age ->
                handleLoading age

            Quotes ->
                handleLoading quotes

            Services ->
                handleLoading services

            Loading ->
                loadingBackground model <| emptyDiv
