/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * Methods used accross the application speficif for the messages
 */

/**
 * Sets up the click behaviour for answering a messate
 * 
 * @param button HTML button
 */
  export function toggle_message_answer_for_button(button){
    button.addEventListener('click', ()=>{
      console.log('Clicked!')
      let answered_message_element = document.querySelector('#answered_message_id'); 
      answered_message_element.value = button.value
    });
  }