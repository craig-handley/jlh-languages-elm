module Page.GalleryPage exposing (Model, Msg(..), init, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Session
import Viewer



-- MODEL


type alias Model =
    { session : Session.Session
    }



-- INIT


init : Session.Session -> ( Model, Cmd Msg )
init session =
    ( Model session, Cmd.none )



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Viewer.Details Msg
view model =
    { title = toTitle
    , body =
        [ div [ class "content" ]
            [ div [ class "heading" ] [ text "Gallery" ]
            , div [ class "center" ]
                [ div [] [ text "September 2019" ]
                , img [ src model.session.images.gallery_01 ] []
                , div [] [ text "July 2019 : Boules tournament" ]
                , img [ src model.session.images.gallery_02 ] []
                , img [ src model.session.images.gallery_03 ] []
                , img [ src model.session.images.gallery_04 ] []
                , img [ src model.session.images.gallery_05 ] []
                , img [ src model.session.images.gallery_06 ] []
                , div [] [ text "June 2019 : French evening" ]
                , img [ src model.session.images.gallery_07 ] []
                , img [ src model.session.images.gallery_08 ] []
                , img [ src model.session.images.gallery_09 ] []
                , img [ src model.session.images.gallery_10 ] []
                , img [ src model.session.images.gallery_11 ] []
                , img [ src model.session.images.gallery_12 ] []
                , div [] [ text "April 2019 : Barcroft Primary School fashion show" ]
                , img [ src model.session.images.gallery_13 ] []
                , img [ src model.session.images.gallery_14 ] []
                , div [] [ text "March 2019 : Class visit to Nice" ]
                , img [ src model.session.images.gallery_15 ] []
                , img [ src model.session.images.gallery_16 ] []
                , img [ src model.session.images.gallery_17 ] []
                , img [ src model.session.images.gallery_18 ] []
                , div [] [ text "January 2019" ]
                , img [ src model.session.images.gallery_19 ] []
                , img [ src model.session.images.gallery_20 ] []
                , div [] [ text "October 2018" ]
                , img [ src model.session.images.gallery_21 ] []
                , div [] [ text "July 2018" ]
                , img [ src model.session.images.gallery_22 ] []
                , img [ src model.session.images.gallery_23 ] []
                , img [ src model.session.images.gallery_24 ] []
                , img [ src model.session.images.gallery_25 ] []
                , img [ src model.session.images.gallery_26 ] []
                , img [ src model.session.images.gallery_27 ] []
                , div [] [ text "June 2018" ]
                , img [ src model.session.images.gallery_28 ] []
                , div [] [ text "February 2018" ]
                , img [ src model.session.images.gallery_29 ] []
                , div [] [ text "November 2017" ]
                , img [ src model.session.images.gallery_30 ] []
                ]
            ]
        ]
    }



-- HELPERS


toTitle : String
toTitle =
    "Gallery Page"
