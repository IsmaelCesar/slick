/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * useful procedures to the messaging functionalities
 */

 import { toggle_message_answer_for_button } from "./messages/utils";

  export function setup_mutation_observer_for_context(container){
    // Tracking mutations on the chat container for the messages
   //const message_chat_content = document.querySelector('.messaging-chat-content');
    let container_observer = new MutationObserver(()=>{
      document.querySelectorAll('.btn-answer-message').forEach((button_answer_message)=>{
        toggle_message_answer_for_button(button_answer_message);
      });
    });
    container_observer.observe(container, { childList: true });
    return container_observer;
  }