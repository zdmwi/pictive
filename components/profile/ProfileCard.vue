<template>
  <div class="shadow-md h-64 w-64 p-4 bg-white flex flex-col items-center rounded-lg">
    <div class="h-24 w-24 bg-gray-300 rounded-full mb-4"></div>
    <h1 class="text-lg font-bold text-gray-800">{{ identity.displayName }}</h1>
    <span class="text-sm text-gray-600">{{ identity.metadata }}</span>
    <div class="my-5">
      
      <button 
        v-if="!edit"
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" 
        @click="edit = !edit"
      >
        Edit Photo
      </button>

      <div class="" v-if="edit">
          <button 
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 rounded ml-5 mr-5" 
            @click="savePhoto()"
          >
            Save Photo
          </button>
          <button 
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-1 px-2 rounded"
            @click="edit = !edit"
          >
            Cancel
          </button>
          
          <div class="flex my-2">
            <input
              class="mx-3 border" 
              type="text" 
              id="p-input" 
              ref="pinput" 
              placeholder="photo url"
            >
          </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    identity: Object
  },
  data () {
    return {
      edit: false
    }
  },
  methods: {
    async savePhoto () {
      const url = `api/users/${localStorage.getItem('user')}/profile`
      const photo = this.$refs.pinput.value
      console.log(this.$refs.pinput.value)
      console.log(photo)
      const results = await this.$axios.$post(url, {
        photo: photo
      })
      this.identity = resuls.data[0]
      this.edit = !this.edit
    }
  }
}
</script>

<style>
</style>
