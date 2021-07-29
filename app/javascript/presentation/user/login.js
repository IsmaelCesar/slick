/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * this file contains frontend logic for the login page
 */

let sign_up = document.querySelector('#sign-up') 
if(sign_up){
  sign_up.onclick = (event) =>{
    event.preventDefault();
    window.location.replace('/presentation/user/sign_up')
  }
}