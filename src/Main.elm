module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

-- import Page.NewPage as NewPage

import Browser
import Browser.Events
import Browser.Navigation
import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode
import Json.Encode
import Page.AboutPage as AboutPage
import Page.AdultCoursesPage as AdultCoursesPage
import Page.EventsPage as EventsPage
import Page.GalleryPage as GalleryPage
import Page.GiftVouchersPage as GiftVouchersPage
import Page.PageOne as PageOne
import Page.PageWithSubpage as PageWithSubpage
import Page.PrivacyPage as PrivacyPage
import Page.SchoolsPage as SchoolsPage
import Page.TestimonialsPage as TestimonialsPage
import Page.Top as Top
import Page.TutoringPage as TutoringPage
import Ports
import Session
import Type.Flags
import Type.LocalStorage
import Url
import Url.Parser as Parser exposing ((</>))
import Viewer



-- TYPES
-- Page: each time you need to add/remove a page, this needs to be updated appropriately
-- Each page holds the respective pages model, with the exception of the 404 NotFound page type


type Page
    = NotFound Session.Session
    | Top Top.Model
      -- | NewPage NewPage.Model
    | PageOne PageOne.Model
    | PageWithSubpage PageWithSubpage.Model
    | AboutPage AboutPage.Model
    | AdultCoursesPage AdultCoursesPage.Model
    | TutoringPage TutoringPage.Model
    | SchoolsPage SchoolsPage.Model
    | EventsPage EventsPage.Model
    | TestimonialsPage TestimonialsPage.Model
    | GiftVouchersPage GiftVouchersPage.Model
    | PrivacyPage PrivacyPage.Model
    | GalleryPage GalleryPage.Model



-- MODEL


type alias Model =
    { key : Browser.Navigation.Key -- Required in a Browser.application
    , page : Page
    }



-- INIT
-- To initialize the app, we route the URL to determine what page should be rendered.
-- We also get some information from the flags that will be stored in the Session


init : Type.Flags.Flags -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        localStorage =
            Json.Decode.decodeValue Type.LocalStorage.decode flags.localStorage

        ( model, cmds ) =
            routeUrl url <| Model key (NotFound <| Session.init flags)
    in
    --  On loading the application, we read form local storage. If the object is incorrectly formatted, clear localStorage
    case localStorage of
        Ok success ->
            ( model, cmds )

        Err _ ->
            -- If localstorage decoder failed, clear localstorage
            ( model, Cmd.batch [ cmds, Ports.clearLocalStorage () ] )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | OnWindowResize Int Int
    | OnLocalStorageChange Json.Encode.Value
    | TopMsg Top.Msg
      -- | NewPageMsg NewPage.Msg
    | PageOneMsg PageOne.Msg
    | PageWithSubpageMsg PageWithSubpage.Msg
    | AboutPageMsg AboutPage.Msg
    | AdultCoursesPageMsg AdultCoursesPage.Msg
    | TutoringPageMsg TutoringPage.Msg
    | SchoolsPageMsg SchoolsPage.Msg
    | EventsPageMsg EventsPage.Msg
    | TestimonialsPageMsg TestimonialsPage.Msg
    | GiftVouchersPageMsg GiftVouchersPage.Msg
    | PrivacyPageMsg PrivacyPage.Msg
    | GalleryPageMsg GalleryPage.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        -- When a link is clicked anywhere on our page. There are two types of links, external and internal
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    -- If you'd like to use hash-based routing:
                    -- ( model, Nav.pushUrl model.key (Url.toString (toHashUrl url)) )
                    ( model, Browser.Navigation.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Browser.Navigation.load href )

        -- When the URL changes. This could from something like clicking a link or the browser back/forward buttons
        UrlChanged url ->
            routeUrl url model

        -- Handle this however you'd like for responsive web design! The view in Main.elm and each respective page can change depending on the window size
        OnWindowResize width height ->
            let
                session =
                    extractSession model

                windowSize =
                    { width = width, height = height }
            in
            updateSession model { session | windowSize = windowSize }

        -- Handle a change in localStorage. Can be modified to your needs
        -- In the boilerplate, I update the session and send a message to the active page with tne new session
        OnLocalStorageChange msg ->
            let
                localStorage =
                    Json.Decode.decodeValue Type.LocalStorage.decode msg

                session =
                    extractSession model

                newSession =
                    case localStorage of
                        Ok success ->
                            { session | localStorage = success }

                        Err _ ->
                            { session | localStorage = Nothing }
            in
            updateSession model newSession

        -- The messages below will send a message received in Main.elm to the respective page.
        TopMsg msg ->
            case model.page of
                Top m ->
                    mapTopMsg model (Top.update msg m)

                _ ->
                    ( model, Cmd.none )

        --    NewPageMsg msg ->
        --        case model.page of
        --            NewPage m ->
        --                mapNewPageMsg model (NewPage.update msg m)
        --            _ ->
        --                ( model, Cmd.none )
        PageOneMsg msg ->
            case model.page of
                PageOne m ->
                    mapPageOneMsg model (PageOne.update msg m)

                _ ->
                    ( model, Cmd.none )

        PageWithSubpageMsg msg ->
            case model.page of
                PageWithSubpage m ->
                    mapPageWithSubpageMsg model (PageWithSubpage.update msg m)

                _ ->
                    ( model, Cmd.none )

        AboutPageMsg msg ->
            case model.page of
                AboutPage m ->
                    mapAboutPageMsg model (AboutPage.update msg m)

                _ ->
                    ( model, Cmd.none )

        AdultCoursesPageMsg msg ->
            case model.page of
                AdultCoursesPage m ->
                    mapAdultCoursesPageMsg model (AdultCoursesPage.update msg m)

                _ ->
                    ( model, Cmd.none )

        TutoringPageMsg msg ->
            case model.page of
                TutoringPage m ->
                    mapTutoringPageMsg model (TutoringPage.update msg m)

                _ ->
                    ( model, Cmd.none )

        SchoolsPageMsg msg ->
            case model.page of
                SchoolsPage m ->
                    mapSchoolsPageMsg model (SchoolsPage.update msg m)

                _ ->
                    ( model, Cmd.none )

        EventsPageMsg msg ->
            case model.page of
                EventsPage m ->
                    mapEventsPageMsg model (EventsPage.update msg m)

                _ ->
                    ( model, Cmd.none )

        TestimonialsPageMsg msg ->
            case model.page of
                TestimonialsPage m ->
                    mapTestimonialsPageMsg model (TestimonialsPage.update msg m)

                _ ->
                    ( model, Cmd.none )

        GiftVouchersPageMsg msg ->
            case model.page of
                GiftVouchersPage m ->
                    mapGiftVouchersPageMsg model (GiftVouchersPage.update msg m)

                _ ->
                    ( model, Cmd.none )

        PrivacyPageMsg msg ->
            case model.page of
                PrivacyPage m ->
                    mapPrivacyPageMsg model (PrivacyPage.update msg m)

                _ ->
                    ( model, Cmd.none )

        GalleryPageMsg msg ->
            case model.page of
                GalleryPage m ->
                    mapGalleryPageMsg model (GalleryPage.update msg m)

                _ ->
                    ( model, Cmd.none )



-- VIEW
-- Our view function renders the page depending on which page is active.


view : Model -> Browser.Document Msg
view model =
    let
        session =
            extractSession model
    in
    case model.page of
        NotFound _ ->
            Viewer.view session never Viewer.notFound

        Top m ->
            Viewer.view session TopMsg (Top.view m)

        -- NewPage _ ->
        -- Viewer.view session             NewPageMsg (NewPage.view m) model.route
        PageOne m ->
            Viewer.view session PageOneMsg (PageOne.view m)

        PageWithSubpage m ->
            Viewer.view session PageWithSubpageMsg (PageWithSubpage.view m)

        AboutPage m ->
            Viewer.view session AboutPageMsg (AboutPage.view m)

        AdultCoursesPage m ->
            Viewer.view session AdultCoursesPageMsg (AdultCoursesPage.view m)

        TutoringPage m ->
            Viewer.view session TutoringPageMsg (TutoringPage.view m)

        SchoolsPage m ->
            Viewer.view session SchoolsPageMsg (SchoolsPage.view m)

        EventsPage m ->
            Viewer.view session EventsPageMsg (EventsPage.view m)

        TestimonialsPage m ->
            Viewer.view session TestimonialsPageMsg (TestimonialsPage.view m)

        GiftVouchersPage m ->
            Viewer.view session GiftVouchersPageMsg (GiftVouchersPage.view m)

        PrivacyPage m ->
            Viewer.view session PrivacyPageMsg (PrivacyPage.view m)

        GalleryPage m ->
            Viewer.view session GalleryPageMsg (GalleryPage.view m)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Browser.Events.onResize OnWindowResize
        , Ports.onLocalStorageChange OnLocalStorageChange
        ]



-- MAIN


main : Program Type.Flags.Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- FUNCTIONS
-- Helper functions to send a command from Main to a page


mapTopMsg : Model -> ( Top.Model, Cmd Top.Msg ) -> ( Model, Cmd Msg )
mapTopMsg model ( m, cmds ) =
    ( { model | page = Top m }, Cmd.map TopMsg cmds )


mapPageOneMsg : Model -> ( PageOne.Model, Cmd PageOne.Msg ) -> ( Model, Cmd Msg )
mapPageOneMsg model ( m, cmds ) =
    ( { model | page = PageOne m }, Cmd.map PageOneMsg cmds )



-- mapNewPageMsg : Model -> ( NewPage.Model, Cmd NewPage.Msg ) -> ( Model, Cmd Msg )
-- mapNewPageMsg model ( m, cmds ) =
--     ( { model | page = NewPage m }, Cmd.map NewPageMsg cmds )


mapPageWithSubpageMsg : Model -> ( PageWithSubpage.Model, Cmd PageWithSubpage.Msg ) -> ( Model, Cmd Msg )
mapPageWithSubpageMsg model ( m, cmds ) =
    ( { model | page = PageWithSubpage m }, Cmd.map PageWithSubpageMsg cmds )


mapAboutPageMsg : Model -> ( AboutPage.Model, Cmd AboutPage.Msg ) -> ( Model, Cmd Msg )
mapAboutPageMsg model ( m, cmds ) =
    ( { model | page = AboutPage m }, Cmd.map AboutPageMsg cmds )


mapAdultCoursesPageMsg : Model -> ( AdultCoursesPage.Model, Cmd AdultCoursesPage.Msg ) -> ( Model, Cmd Msg )
mapAdultCoursesPageMsg model ( m, cmds ) =
    ( { model | page = AdultCoursesPage m }, Cmd.map AdultCoursesPageMsg cmds )


mapTutoringPageMsg : Model -> ( TutoringPage.Model, Cmd TutoringPage.Msg ) -> ( Model, Cmd Msg )
mapTutoringPageMsg model ( m, cmds ) =
    ( { model | page = TutoringPage m }, Cmd.map TutoringPageMsg cmds )


mapSchoolsPageMsg : Model -> ( SchoolsPage.Model, Cmd SchoolsPage.Msg ) -> ( Model, Cmd Msg )
mapSchoolsPageMsg model ( m, cmds ) =
    ( { model | page = SchoolsPage m }, Cmd.map SchoolsPageMsg cmds )


mapEventsPageMsg : Model -> ( EventsPage.Model, Cmd EventsPage.Msg ) -> ( Model, Cmd Msg )
mapEventsPageMsg model ( m, cmds ) =
    ( { model | page = EventsPage m }, Cmd.map EventsPageMsg cmds )


mapTestimonialsPageMsg : Model -> ( TestimonialsPage.Model, Cmd TestimonialsPage.Msg ) -> ( Model, Cmd Msg )
mapTestimonialsPageMsg model ( m, cmds ) =
    ( { model | page = TestimonialsPage m }, Cmd.map TestimonialsPageMsg cmds )


mapGiftVouchersPageMsg : Model -> ( GiftVouchersPage.Model, Cmd GiftVouchersPage.Msg ) -> ( Model, Cmd Msg )
mapGiftVouchersPageMsg model ( m, cmds ) =
    ( { model | page = GiftVouchersPage m }, Cmd.map GiftVouchersPageMsg cmds )


mapPrivacyPageMsg : Model -> ( PrivacyPage.Model, Cmd PrivacyPage.Msg ) -> ( Model, Cmd Msg )
mapPrivacyPageMsg model ( m, cmds ) =
    ( { model | page = PrivacyPage m }, Cmd.map PrivacyPageMsg cmds )


mapGalleryPageMsg : Model -> ( GalleryPage.Model, Cmd GalleryPage.Msg ) -> ( Model, Cmd Msg )
mapGalleryPageMsg model ( m, cmds ) =
    ( { model | page = GalleryPage m }, Cmd.map GalleryPageMsg cmds )



-- Extracts the session from the model


extractSession : Model -> Session.Session
extractSession model =
    case model.page of
        NotFound session ->
            session

        Top m ->
            m.session

        PageOne m ->
            m.session

        -- NewPage m ->
        -- m.session
        PageWithSubpage m ->
            m.session

        AboutPage m ->
            m.session

        AdultCoursesPage m ->
            m.session

        TutoringPage m ->
            m.session

        SchoolsPage m ->
            m.session

        EventsPage m ->
            m.session

        TestimonialsPage m ->
            m.session

        GiftVouchersPage m ->
            m.session

        PrivacyPage m ->
            m.session

        GalleryPage m ->
            m.session



-- Update the session of the active page (This could be changed to send a OnSessionChange Msg rather than using init)
-- However, I think it's better you design your pages such that initializing the page is equivalent to updating the session!


updateSession : Model -> Session.Session -> ( Model, Cmd Msg )
updateSession model session =
    case model.page of
        NotFound _ ->
            ( { model | page = NotFound session }, Cmd.none )

        Top m ->
            mapTopMsg model (Top.init session)

        PageOne m ->
            mapPageOneMsg model (PageOne.init session)

        -- NewPage m ->
        -- mapNewPageMsg model (NewPage.init session)
        PageWithSubpage m ->
            mapPageWithSubpageMsg model (PageWithSubpage.init session m.subpage)

        AboutPage m ->
            mapAboutPageMsg model (AboutPage.init session)

        AdultCoursesPage m ->
            mapAdultCoursesPageMsg model (AdultCoursesPage.init session)

        TutoringPage m ->
            mapTutoringPageMsg model (TutoringPage.init session)

        SchoolsPage m ->
            mapSchoolsPageMsg model (SchoolsPage.init session)

        EventsPage m ->
            mapEventsPageMsg model (EventsPage.init session)

        TestimonialsPage m ->
            mapTestimonialsPageMsg model (TestimonialsPage.init session)

        GiftVouchersPage m ->
            mapGiftVouchersPageMsg model (GiftVouchersPage.init session)

        PrivacyPage m ->
            mapPrivacyPageMsg model (PrivacyPage.init session)

        GalleryPage m ->
            mapGalleryPageMsg model (GalleryPage.init session)



-- ROUTING
-- The following functions create the client-side router. Update "parser" and "paths" for each page you add/remove


routeUrl : Url.Url -> Model -> ( Model, Cmd Msg )
routeUrl url model =
    let
        session =
            extractSession model

        -- If you'd like to use hash-based routing:
        -- hashUrl =
        --     { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
    in
    -- If you'd like to use hash-based routing:
    -- case Parser.parse (parser model session) hashUrl of
    case Parser.parse (parser model session) url of
        Just success ->
            success

        Nothing ->
            ( { model | page = NotFound session }, Cmd.none )


route : Parser.Parser a b -> a -> Parser.Parser (b -> c) c
route parser_ handler =
    Parser.map handler parser_



-- URL Parser tha maps a URL to a Page, and initializes that page.


parser : Model -> Session.Session -> Parser.Parser (( Model, Cmd Msg ) -> a) a
parser model session =
    Parser.oneOf
        [ route Parser.top (mapTopMsg model (Top.init session))

        -- , route (Parser.s paths.newPage)
        --     (mapNewPageMsg model (NewPage.init session))
        , route (Parser.s paths.aboutPage)
            (mapAboutPageMsg model (AboutPage.init session))
        , route (Parser.s paths.adultCoursesPage)
            (mapAdultCoursesPageMsg model (AdultCoursesPage.init session))
        , route (Parser.s paths.tutoringPage)
            (mapTutoringPageMsg model (TutoringPage.init session))
        , route (Parser.s paths.schoolsPage)
            (mapSchoolsPageMsg model (SchoolsPage.init session))
        , route (Parser.s paths.eventsPage)
            (mapEventsPageMsg model (EventsPage.init session))
        , route (Parser.s paths.testimonialsPage)
            (mapTestimonialsPageMsg model (TestimonialsPage.init session))
        , route (Parser.s paths.giftVouchersPage)
            (mapGiftVouchersPageMsg model (GiftVouchersPage.init session))
        , route (Parser.s paths.privacyPage)
            (mapPrivacyPageMsg model (PrivacyPage.init session))
        , route (Parser.s paths.galleryPage)
            (mapGalleryPageMsg model (GalleryPage.init session))
        ]



--  This holds the paths for each page. Update as needed for each page you add/remove


paths =
    { top = ""
    , adultCoursesPage = "adultcourses"
    , tutoringPage = "tutoring"
    , schoolsPage = "schools"
    , eventsPage = "events"
    , aboutPage = "about"
    , testimonialsPage = "testimonials"
    , giftVouchersPage = "giftvouchers"
    , privacyPage = "privacy"
    , galleryPage = "gallery"

    --, newPage = "newpage"
    }



-- Uncomment  this helper function if you need to use hash-based routing.
-- toHashUrl : Url.Url -> Url.Url
-- toHashUrl url =
--     { url | fragment = Just url.path, path = "" }
