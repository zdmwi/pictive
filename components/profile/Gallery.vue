<template>
  <div class="shadow-md h-auto w-64 p-4 bg-white rounded-lg">
    <h1 class="text-gray-800 font-bold">{{ title }}</h1>
    <div class="flex flex-wrap justify-center items-center">
      <div v-for="photo in photos" class="w-1/3 flex justify-center items-center">
        <img class="h-16 w-16 bg-gray-300 rounded-lg mt-2" :src="photo.url" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: String,
    photos: Array
  }
}
</script>

<style>
</style>
