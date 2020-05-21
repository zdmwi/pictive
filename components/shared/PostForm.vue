<template>
  <div class="flex flex-col bg-white rounded-lg p-4 shadow-md">
    <div class="flex items-center w-80">
      <div class="h-10 w-10 bg-gray-300 rounded-full mr-4"></div>
      <form class="flex-1" @submit.prevent="handlePostQuery">
        <input
          v-model="postString"
          placeholder="What's on your mind?"
          type="text"
          class="form-input focus:outline-none bg-gray-300 text-gray-800 border-0 w-full rounded-lg text-sm"
        />
        <input
          v-model="photo"
          placeholder="Url photo"
          type="text"
          class="form-input focus:outline-none bg-gray-300 text-gray-800 border-0 w-full rounded-lg text-sm mt-2"
        />
      <div class="flex justify-end">
      <input
        type="submit"
        value="Post"
        class="bg-blue-500 hover:bg-blue-700 text-white text-sm font-bold cursor-pointer py-1 px-2 mt-2 ml-2 rounded-lg"
      />
      </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      postString: '',
      photo: ''
    }
  },
  methods: {
    async handlePostQuery() {
      const userId = localStorage.getItem('user') || 1
      const url = this.photo
      const caption = this.postString
      try{
        if(url=='' && caption==''){
          console.log('nothing entered')
        }
        else if(url==''){
          const results = await this.$axios.post(`/api/users/${userId}/texts`, {
            body: this.postString
          })
          console.log(results)
          this.postString = ''
        }
        else{
          const results = await this.$axios.post(`/api/users/${userId}/photos`, {
            url: url,
            caption: caption
          })
          console.log(results)
          this.postString = ''
          this.photo = ''
        }
      }catch(e){
        console.log(e)
      }
    }
  }
}
</script>

<style>
</style>
