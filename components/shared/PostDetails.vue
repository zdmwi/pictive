<template>
  <div
    class="flex flex-col rounded-lg bg-white custom-height w-1/2 overflow-y-scroll shadow-lg mb-4 cursor-pointer"
    @click="isOpen=!isOpen;"
  >
    <div class="flex justify-start px-6 pt-4">
      <div class="bg-gray-300 h-12 w-12 rounded-full cursor-pointer"></div>
      <p class="text-gray-800 text-sm leading-none pl-4 pt-4">Jonathan Reinink</p>
      <p class="text-xs justify end ml-auto pt-4">{{date}}</p>
    </div>
    <div class="px-6 py-4">
      <p v-if="caption" class="text-gray-700 text-base">{{caption}}</p>
      <p v-else class="text-gray-700 text-base">{{body}}</p>
    </div>
    <img v-if="url" class="w-full h-64" :src="url" alt="Sunset in the mountains" />
    <div class="font-bold text-base my-2 px-6">Comments</div>
    <div
      v-for="comment in userCmmt.slice(0,3)"
      :key="comment.id"
      class="bg-gray-100 rounded-lg overflow-hidden shadow mx-4 mb-2 pb-2 overflow-y-scroll"
    >
      <div class="flex justify-start px-6 py-4">
        <div class="inline-block bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
        <span class="inline-block text-gray-800 text-sm leading-none pl-4 pt-2">Joana Willis</span>
        <p class="text-xs justify end ml-auto pt-2">{{comment.date}}</p>
      </div>
      <div class="px-6 pb-2">
        <p class="text-gray-700 text-sm">{{comment.text}}</p>
      </div>
    </div>
    <div class="flex justify-center">
      <button
        class="h-10 w-40 my-2 text-sm bg-transparent hover:bg-gray-500 text-gray-700 font-semibold hover:text-white border border-gray-500 hover:border-transparent rounded"
      >See More</button>
    </div>
  </div>
</template>

<script>
export default {
  props: ['p_id', 'url', 'caption', 'body', 'date'],
  computed: {
    userCmmt: function() {
      for (let i = 0; i < this.comments.length; i++) {
        let comment = this.comments[i]
        let c_date = new Date(comment.date)
        c_date.setTime(c_date.getTime() + 86400000)
        comment.date = c_date.toString().substring(4, 11)
        this.comments[i] = comment
      }
      return this.comments
    }
  },
  data() {
    return {
      comments: [
        {
          id: 1,
          text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
          date: '2020-05-02'
        },
        {
          id: 2,
          text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
          date: '2020-05-02'
        },
        {
          id: 3,
          text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
          date: '2020-05-03'
        },
        {
          id: 4,
          text: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
          date: '2020-05-04'
        }
      ]
    }
  }
}
</script>
<style>
.custom-height {
  height: 600px;
}
</style>
