/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * This file is dedicated to coding the behaviour of group editing page
 * 
 */

  import alertify from "alertifyjs";
  import { AjaxBuilder } from "../../packs/ajax_utils"; 

  const btn_delete_group = document.querySelector('.btn-delete-group'); 
  btn_delete_group?.addEventListener('click', (event)=>{
    event.preventDefault();
    alertify.confirm("Are you sure?", "Once deletion is confimed it cannot be undone", 
                    ()=>{
                      let target = btn_delete_group.href
                      let ajax = new AjaxBuilder('text/html','text/html,application/xhtml+xml');
                      ajax.delete(target);
                    }, 
                    ()=>{
                      console.log("Delete Canceled");
                    }).set('labels', { ok: 'Yes', cancel: 'No'});
    
    return false; 
  }); 
