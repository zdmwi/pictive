<template>
<transition name="modal">
  <div class="overlay">
  <div
    class="flex flex-col rounded-lg bg-white custom-height w-1/2 overflow-y-scroll shadow-lg mb-4 cursor-pointer"
  >
    <div class="flex justify-end mr-2 mt-2">
      <img @click="$emit('close')" src="https://img.icons8.com/metro/26/000000/multiply.png"/>
    </div>
    <div class="flex justify-start px-6 pt-4">
      <div class="bg-gray-300 h-12 w-12 rounded-full cursor-pointer"></div>
      <p class="text-gray-800 text-sm leading-none pl-4 pt-4">{{fname}} {{lname}}</p>
      <p class="text-xs justify end ml-auto pt-4">{{date}}</p>
    </div>
    <div class="px-6 py-4">
      <p v-if="caption" class="text-gray-700 text-base">{{caption}}</p>
      <p v-else class="text-gray-700 text-base">{{body}}</p>
    </div>
    <img v-if="url" class="w-full h-64 mb-4" :src="url" alt="Sunset in the mountains" />
    <form class="mx-4 mb-2" @submit.prevent="handleCommentQuery">
        <input
          v-model="commentString"
          placeholder="Make a comment"
          type="text"
          class="form-input focus:outline-none bg-gray-300 text-gray-800 border-0 w-full rounded-lg text-sm"
        />
    </form>
    <div class="font-bold text-base my-2 px-6">Comments</div>
    <div v-if="comments.length > 0">
      <div
        v-for="comment in userCmmt.slice(0,3)"
        :key="comment.id"
        class="bg-gray-100 rounded-lg overflow-hidden shadow mx-4 mb-2 pb-2"
      >
        <div class="flex justify-start px-6">
          <div class="inline-block bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
          <span class="inline-block text-gray-800 text-sm leading-none pl-4 pt-2">Joana Willis</span>
          <p class="text-xs justify end ml-auto pt-2">{{comment.c_date}}</p>
        </div>
        <div class="px-6 pb-2">
          <p class="text-gray-700 text-sm">{{comment.comment}}</p>
        </div>
      </div>
    </div>
    <div v-else class="bg-gray-100 rounded-lg overflow-hidden shadow mx-4 mb-2 pb-2">
      <div class="px-6">
        <p class="text-gray-700 text-sm pt-2">No Comments</p>
      </div>
    </div>
    <div class="flex justify-center">
      <button
        class="h-10 w-40 my-2 text-sm bg-transparent hover:bg-gray-500 text-gray-700 font-semibold hover:text-white border border-gray-500 hover:border-transparent rounded"
      >See More</button>
    </div>
  </div>
  </div>
</transition>
</template>

<script>
export default {
  props: ['p_id', 'url', 'caption', 'body', 'date', 'fname', 'lname'],
  computed: {
    userCmmt: function() {
      for (let i = 0; i < this.comments.length; i++) {
        let comment = this.comments[i]
        let c_date = new Date(comment.c_date)
        c_date.setTime(c_date.getTime() + 86400000)
        comment.c_date = c_date.toString().substring(4, 11)
        this.comments[i] = comment
      }
      return this.comments
    }
  },
  async mounted() {
    const commentResults = await this.$axios.get(`/api/posts/${this.p_id}/comments`)
    let data = commentResults.data

    this.comments = data.data

    console.log(commentResults)
  },
  data() {
    return {
      comments: [],
      commentString: ''
    }
  },
  methods: {
    async handleCommentQuery(){
      const userId = localStorage.getItem('user') || 1
      try{
        const results = await this.$axios.post(`/api/users/${userId}/comments`, {
          post_id: this.p_id,
          comment: this.commentString
        })
        console.log(results)
        let d = new Date().toLocaleString()
        this.comments.push({
          id: 1,
          comment: this.commentString,
          c_date: d
        })
        this.commentString = ''
      }catch(e){
        console.log(e)
      }
    }
  }
}
</script>
<style>
.custom-height {
  height: 600px;
}

.fadeIn-enter {
  opacity: 0;
}
.fadeIn-leave-active {
  opacity: 0;
  transition: all 0.2s step-end;
}
.fadeIn-enter .modal,
.fadeIn-leave-active.modal {
  transform: scale(1.1);
}
.overlay {
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  background: #00000094;
  z-index: 999;
  transition: opacity 0.2s ease;
}
</style>