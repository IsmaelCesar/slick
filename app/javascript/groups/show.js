/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to the condin of the behaviuor for when the user
 * has selected a group in the group list
 */

  import { Modal } from "bootstrap";
  
  const modal_container = document.querySelector('#modal-container')
  // Logic for when the modal is filled with a modal with a form inside it
  const observer = new MutationObserver(()=>{
    let modal_element = document.querySelector('.modal-new-text-channel');
    let modal = new Modal(modal_element); 
    modal.show();
  });
  observer.observe(modal_container, { childList: true }); 