/**
 * @author Ismael Cesar <leamscesar@gmail.com> 
 * 
 * This class is dedicated to facilitating asynchronous requests using fetch api
 */
 export class AjaxBuilder { 
  constructor (content_type='application/json', accept='application/json') {
    this.request_headers = {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': content_type, 
      'Accept': accept
    }
  }

  get(url, success_callback = undefined, error_callback = undefined){ 
    fetch(url, { method: 'GET', headers: this.request_headers } )
    .then((response) => {
      if(!response.ok) throw response;
      response.json().then((data)=>{
        success_callback?.(data);
      });
    })
    .catch( (error)=>{
      error.json().then((data)=>{
        error_callback?.(data);
      })
    });
  }

  delete(url, success_callback = undefined, error_callback = undefined){ 
    fetch(url, { method: 'DELETE', headers: this.request_headers } )
    .then((response) => {
      if(!response.ok) throw response;
      if(this.request_headers.Accept === 'application/json'){
        response.json().then((data)=>{
          success_callback?.(data);
        });
      }
    })
    .catch( (error)=>{
      if(this.request_headers.Accept === 'application/json'){
        error.json().then((data)=>{
          error_callback?.(data);
        })
      }
    });
  }

  post(url, data, success_callback = undefined, error_callback = undefined){
    fetch(url, { 
                 method: 'POST',
                 headers: this.request_headers, 
                 credentials: "same-origin",
                 body: JSON.stringify(data)
                } )
    .then((response) => {
      if(!response.ok) throw response;
      response.json().then((data)=>{
        success_callback?.(data);
      });
    })
    .catch( (error)=>{
      error.json().then((data)=>{
        error_callback?.(data);
      });
    });
  }

  put(url, data, success_callback = undefined, error_callback = undefined) {
    fetch(url, { 
      method: 'PUT',
      headers: this.request_headers, 
      body: JSON.stringify(data) 
     } )
    .then((response) => { 
      if(!response.ok) throw new Error(response.text())
      return response.text(); 
    })
    .then((data)=>{
      success_callback?.(data); 
    })
    .catch( (error)=>{
      console.log(error)
      return error.json();
      // error_callback?.(error)
    })
    .then((error)=>{
      error_callback?.(error)
    });
  }
}