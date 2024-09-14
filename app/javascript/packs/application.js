// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require('jquery'); // jQueryを追加
// require('bootstrap'); // Bootstrapを追加

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "../stylesheets/application";

document.addEventListener("turbolinks:load", function() {
  // JavaScriptの動作を記述します
});


Rails.start()
Turbolinks.start()
ActiveStorage.start()
