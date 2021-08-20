/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to the behaviours to be implemented in
 * the index page.
 */

  import { Modal } from "bootstrap"
  import { AjaxBuilder } from "../../packs/application";

  const modal_container_observer = new MutationObserver(()=>{
    const ajax_builder = new AjaxBuilder();

    let modal_new_invite = new Modal(document.querySelector('#modal-new-invite')); 
    modal_new_invite.show();

    document.querySelector('#add-new-contact')?.addEventListener('click', (event)=>{
      event.preventDefault();
      let form_user_invite = document.querySelector('#form-user-invite'); 
      let form_data = new FormData(form_user_invite);
      ajax_builder.post('/messaging/user_invites/create', Object.fromEntries(form_data))
    })

  })

  const modal_conainer = document.querySelector('#modal-container');
  if(modal_conainer){
    modal_container_observer.observe(modal_conainer, { childList: true })
  }