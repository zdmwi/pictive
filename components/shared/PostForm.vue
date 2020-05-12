<template>
  <div class="flex flex-col bg-white rounded-lg p-4 shadow-md">
    <div class="flex items-center w-80">
      <div class="h-10 w-10 bg-gray-300 rounded-full mr-4"></div>
      <form class="flex-1" @submit.prevent="handleSubmitQuery">
        <input
          v-model="searchString"
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
      searchString: ''
    }
  },
  methods: {
    handleSubmitQuery() {
      console.log(this.searchString)
    }
  }
}
</script>

<style>
</style>
