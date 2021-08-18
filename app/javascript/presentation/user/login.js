/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * this file contains frontend logic for the login page
 */

  const sign_up = document.querySelector('#btn-sign-up') 
  sign_up?.addEventListener('click', (event) =>{
    event.preventDefault();
    window.location.replace('/presentation/user/sign_up');
  });
