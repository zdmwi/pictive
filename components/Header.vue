<template>
  <div class="flex shadow-md justify-between items-center p-4 bg-white">
    <div class="flex items-center">
      <h1 class="text-lg font-bold text-gray-800 mr-4">relatable.</h1>
      <form @submit.prevent="handleSubmitQuery">
        <input
          v-model="searchString"
          placeholder="Search relatable..."
          type="text"
          class="form-input focus:outline-none bg-gray-300 text-gray-800 border-0 w-64 rounded-lg text-sm"
        />
      </form>
    </div>
    <div class="flex bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
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
