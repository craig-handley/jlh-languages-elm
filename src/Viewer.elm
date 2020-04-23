module Viewer exposing (Details, notFound, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Session
import Url.Builder
import Utils



{-
   This module builds the view. Every individual page's view function returns a Viewer.Details,
   which is used to generate a Browser.Document msg in this module
-}


type alias Details msg =
    { title : String
    , body : List (Html msg)
    }



-- VIEW


view : Session.Session -> (a -> msg) -> Details a -> Browser.Document msg
view session msg details =
    { title = details.title ++ Utils.genericTitle
    , body =
        [ viewHeader session

        --, Html.map msg <| div [ class "container", class "main", style "height" (String.fromInt (session.windowSize.height - headerHeight - footerHeight) ++ "px") ] details.body
        , Html.map msg <| div [ class "container", class "main" ] details.body
        , viewFooter session
        ]
    }



-- HEADER
-- This header is statically generated. You'd likely want this to be dynamic in some way based on the active page & session
-- You could create an additional field in Viewer.Details for a header, and create this header in Main.elm or in each individual page's view


buildNav : Html msg
buildNav =
    div [ class "nav-links" ]
        [ a [ href "/" ] [ text "Home" ]
        , text " | "
        , a [ href "/adultcourses" ] [ text "Adult Courses" ]
        , text " | "
        , a [ href "/tutoring" ] [ text "Tutoring" ]
        , text " | "
        , a [ href "/schools" ] [ text "Schools" ]
        , text " | "
        , a [ href "/events" ] [ text "Events" ]
        , text " | "
        , a [ href "/about" ] [ text "About" ]
        , text " | "
        , a [ href "/testimonials" ] [ text "Testimonials" ]
        , text " | "
        , a [ href "/giftvouchers" ] [ text "Gift Vouchers" ]
        , text " | "
        , a [ href "/privacy" ] [ text "Privacy" ]
        , text " | "
        , a [ href "/gallery" ] [ text "Gallery" ]

        -- , text " | "
        --    , a [ href "newpage" ] [ text "New Page" ]
        ]


viewHeader : Session.Session -> Html msg
viewHeader session =
    div []
        [ div [ class "header", class "container" ]
            [ buildNav ]
        , div [ class "header2", class "container", class "jlh-logo" ]
            [ img [ src session.images.logo ] []
            ]
        ]



-- FOOTER


viewFooter : Session.Session -> Html msg
viewFooter session =
    div []
        [ div [ class "footer", class "container" ]
            [ buildNav ]
        , div [ class "footer2", class "container" ]
            [ img [ src session.images.email ] []
            , text "jane@jlhlanguages.org"
            , img [ src session.images.phone ] []
            , text "07793 556020"
            , a [ href "https://www.facebook.com/pg/JLHLanguages/posts/?ref=page_internal" ] [ img [ src session.images.facebook ] [] ]
            , text "Find us on Facebook"
            ]
        ]



-- 404 PAGE (NotFound)


notFound : Details msg
notFound =
    { title = "Page Not Found"
    , body =
        [ div [ class "not-found" ]
            [ div [ style "font-size" "12em" ] [ text "404" ]
            , h1 [ style "font-size" "3.5em" ] [ text "Page Not Found" ]
            , h3 [ style "font-size" "1.5em" ]
                [ text "Oops - Looks like you got lost or clicked a bad link! "
                , a [ href "/" ] [ text "Click here " ]
                , text "to go back to the home page."
                ]
            ]
        ]
    }



-- LOGO


viewLogo : Html msg
viewLogo =
    a [ href "/", style "text-decoration" "none" ] [ Utils.logo 32 ]



-- STYLING HELPERS (lazy, hard-coded styling)


headerHeight =
    60


footerHeight =
    60
