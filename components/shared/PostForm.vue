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
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      postString: ''
    }
  },
  methods: {
    async handlePostQuery() {
      try{
        const results = await this.$axios.post(`/api/users/${this.$route.params.id}/texts`, {
          body: this.postString
        })
        console.log(results)
        this.postString = ''
      }catch(e){
        console.log(e)
      }
    }
  }
}
</script>

<style>
</style>
