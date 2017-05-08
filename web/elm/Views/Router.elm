module Views.Router exposing (router)

import Components.Utils exposing (emptyDiv)
import Html exposing (..)
import Model exposing (..)
import Views.Error exposing (error)
import Views.Home exposing (home)
import Views.Instructions exposing (instructions)
import Views.Loading exposing (..)
import Views.Quotes exposing (quotes)
import Views.Services exposing (services)
import Views.UserInfo.Age exposing (age)
import Views.UserInfo.Name exposing (name)
import Views.UserInfo.Postcode exposing (postcode)


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

            Instructions ->
                handleLoading instructions

            Quotes ->
                handleLoading quotes

            Services ->
                handleLoading services

            Error errorType ->
                handleLoading <| error errorType

            Loading ->
                loadingBackground model <| emptyDiv
