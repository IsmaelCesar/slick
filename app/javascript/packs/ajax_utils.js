/**
 * @author Ismael Cesar <leamscesar@gmail.com> 
 * 
 * This class is dedicated to facilitating asynchronous requests using fetch api
 */
 export class AjaxBuilder { 
  constructor () {
    this.request_headers = {
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json', 
      'Accept': 'application/json'
    }
  }

  get(url, success_callback = undefined, error_callback = undefined){ 
    fetch(url, { method: 'GET', headers: this.request_headers } )
    .then((response) => { 
      console.log('Response')
      console.log(response)
      if(!response.ok) throw new Error('Something went wrong')
      return response.text(); 
    })
    .then((data)=>{
      success_callback?.(data); 
    })
    .catch( (error)=>{
      console.log('Error'); 
      console.log(error);
      return error.json();
    }).then((data)=>{
      error_callback?.(data)
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
      if(!response.ok) throw new Error(response.text())
      return response.text(); 
    })
    .then((data)=>{
      success_callback?.(data); 
    })
    .catch( (error)=>{
      error_callback?.(error)
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