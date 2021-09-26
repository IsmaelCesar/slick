/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to the condin of the behaviuor for when the user
 * has selected a group in the group list
 */

  import { Modal } from "bootstrap";

  document.querySelector('.btn-toggle-group-actions')?.addEventListener('click', ()=>{
    let group_actions = document.querySelector('#group-actions'); 
    if(group_actions){
      let modal_group_action = new Modal(group_actions);
      modal_group_action.show();
    }
  })

