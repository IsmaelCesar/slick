/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to the behaviours to be implemented in
 * the index page.
 */


// Monitoring changes in the form container 
const new_contact_container = document.querySelector('#form-container');
const mutation_observer = new MutationObserver(()=>{
  document.querySelector('#cancel-new-invite')?.addEventListener('click', ()=>{
    let contact_form = document.querySelector('#form-container form');
    contact_form.style.display = 'none';
  });
});
mutation_observer.observe(new_contact_container, { childList: true });
