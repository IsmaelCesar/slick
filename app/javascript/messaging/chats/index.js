/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to the behaviours to be implemented in
 * the index page.
 */

  import { Modal } from "bootstrap"
  import { AjaxBuilder } from "../../packs/ajax_utils";

  const ajax_builder = new AjaxBuilder();
  const modal_container = document.querySelector('#modal-container');

  const modal_container_observer = new MutationObserver(()=>{    
    console.log('Mutated')

    let modal_new_invite = new Modal(document.querySelector('#modal-new-invite')); 
    modal_new_invite.show();

    document.querySelector('#link-add-friend')?.addEventListener('click', (event)=>{
      event.preventDefault();
      let form_user_invite = document.querySelector('#form-user-invite'); 
      if(form_user_invite.checkValidity()){
        let form_data = new FormData(form_user_invite);
        ajax_builder.post('/messaging/user_invites/create', 
                          Object.fromEntries(form_data), 
                          (data)=>{ 
                            console.log(data)
                          }, (error)=>{
                            console.log(error);
                          });
      }
      else{
        console.log('Preencha o campo');
      }
    })

  });

  if(modal_container){
    console.log('Applying mutation observer')
    modal_container_observer.observe(modal_container, { childList: true })
  }