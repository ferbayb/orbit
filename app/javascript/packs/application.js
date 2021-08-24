import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

import "controllers";
window.dispatchMapsEvent = function (...args) {
  const event = document.createEvent("Events");
  event.initEvent("google-maps-callback", true, true);
  event.args = args;
  window.dispatchEvent(event);
};
