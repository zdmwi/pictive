Vue.component('todo-item', {
  template: `<li>I am a todo</li>`,
});

const app = new Vue({
  el: '#app',
  data: {
    message: 'Hello Vue!',
  },
});
