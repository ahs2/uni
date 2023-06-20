// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import Rails from '@rails/ujs'

import Choices from "choices.js"
window.Choices = Choices

import flatpickr from "flatpickr"

Rails.start()
