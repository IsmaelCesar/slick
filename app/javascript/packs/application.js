// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";

import "stylesheets/application"

import "bootstrap";
import "@popperjs/core";
import "@fortawesome/fontawesome-free/css/all";

import "channels";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

/**
 * @author Ismael Cesar <leamscesar@gmail.com> 
 * 
 * This class is dedicated to facilitating asynchronous requests using fetch api
 */
export class AjaxBuilder { 
  constructor () {
    this.request_headers = {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]'),
      'X-Requested-With': 'XMLHttoRequest',
      'Content-Type': 'application/html', 
      'Accept': 'application/html'
    }
  }

  get(url, success_callback = undefined, error_callback = undefined){ 
    fetch(url, { method: 'GET', headers: this.request_headers } )
    .then((response) => { 
      if(!response.ok) throw new Error(response.text())
      return response.text(); 
    })
    .then((data)=>{
      success_call_back?.(data); 
    })
    .catch( (error)=>{
      error_callback?.(error)
    });
  }

  post(url, data, success_call_back = undefined, error_call_back = undefined){
    fetch(url, { 
                 method: 'GET',
                 headers: this.request_headers, 
                 body: JSON.stringify(data) 
                } )
    .then((response) => {
      if(!response.ok) throw new Error(response.text())
      return response.text(); 
    })
    .then((data)=>{
      success_call_back?.(data); 
    })
    .catch( (error)=>{
      error_callback?.(error)
    });
  }

  put(url, data, success_call_back = undefined, error_call_back = undefined) {
    fetch(url, { 
      method: 'GET',
      headers: this.request_headers, 
      body: JSON.stringify(data) 
     } )
    .then((response) => { 
      if(!response.ok) throw new Error(response.text())
      return response.text(); 
    })
    .then((data)=>{
      success_call_back?.(data); 
    })
    .catch( (error)=>{
      error_callback?.(error)
    });
  }
}