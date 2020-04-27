import './css/main.css';
import {
  Elm
} from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import logo from './img/jlh-languages.png';
import email from './img/email.png';
import facebook from './img/facebook.png';
import phone from './img/phone.png';
import tutoring_01 from './img/tutoring_01.png';
import tutoring_02 from './img/tutoring_02.png';
import schools_french from './img/schools_french.jpg';
import schools_spanish from './img/schools_spanish.jpg';
import schools_french_01 from './img/schools_french_01.jpg';
import schools_french_02 from './img/schools_french_02.png';
import schools_french_03 from './img/schools_french_03.png';
import schools_french_04 from './img/schools_french_04.jpg';
import schools_french_05 from './img/schools_french_05.jpg';
import schools_spanish_flyer from './img/schools_spanish_flyer.png';
import schools_spanish_food from './img/schools_spanish_food.jpg';
import schools_spanish_room from './img/schools_spanish_room.jpg';
import schools_spanish_staff from './img/schools_spanish_staff.jpg';
import events_01 from './img/events_01.png';
import about_01 from './img/about_01.jpg';
import testimonials_01 from './img/testimonials_01.png';
import testimonials_02 from './img/testimonials_02.jpg';
import testimonials_03 from './img/testimonials_03.png';
import testimonials_04 from './img/testimonials_04.png';
import gift_voucher_01 from './img/gift_voucher_01.png';




// CONFIG
const storageName = "elm-spa-boilerplate" // key in localStorage

const app = Elm.Main.init({
  flags: generateFlags(),
  node: document.getElementById('elm')
});

registerServiceWorker(); // Don't want service workers? Just comment this line out

// Generate flags to send to our Elm app on intialization
function generateFlags() {
  return {
    timeAppStarted: Date.now(),
    windowSize: {
      width: window.innerWidth,
      height: window.innerHeight
    },
    localStorage: JSON.parse(localStorage.getItem(storageName)) || null,
    images: {
      logo,
      email,
      facebook,
      phone,
      tutoring_01,
      tutoring_02,
      schools_french,
      schools_spanish,
      schools_french_01,
      schools_french_02,
      schools_french_03,
      schools_french_04,
      schools_french_05,
      schools_spanish_flyer,
      schools_spanish_food,
      schools_spanish_room,
      schools_spanish_staff,
      events_01,
      about_01,
      testimonials_01,
      testimonials_02,
      testimonials_03,
      testimonials_04,
      gift_voucher_01,
    }
  };
}


// [To Elm] Send messages thorugh port on change of localStorage
window.addEventListener("storage", event => {
  if (event.storageArea === localStorage && event.key === storageName) {
    // console.log(event.newValue)
    app.ports.onLocalStorageChange.send(JSON.parse(event.newValue) || null);
  }
});


// [From Elm] Set localStorage
app.ports.toLocalStorage.subscribe(data => {
  // console.log(data);
  localStorage.setItem(storageName, JSON.stringify(data));
  // app.ports.onLocalStorageChange.send(data);
});

// [From Elm] Clear localStorage
app.ports.clearLocalStorage.subscribe(() => {
  // console.log("clearing localStorage");
  localStorage.removeItem(storageName);
  // app.ports.onLocalStorageChange.send(null);
});

/* ----- NOTE: TO CONSIDER -----

  Notice how lines 43 and 50 are commented out.
  It seems redundant to tell Elm about a change in localStorage that was initially triggered by Elm.
  However, this may actually be useful! How?

  By doing this, we can synchronize state across multiple tabs!  For example, assuming that some sort of user credentials are stored in localStorage...
  if a user signs out on one tab, and we clear the localStorage through Elm in that tab, our app will receive the update in all other tabs and respond appropriately if we send this 'redundant' message!

  However, one must be very careful in how you handle changes in localStorage in each page.
  You might end up creating an infinite loop of messages being passed, or responding to a change in localStorage twice
  or that reason, I've left this 'redundancy' commented out. It shouldn't be needed for most simple applications

*/