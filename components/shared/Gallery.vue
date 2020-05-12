<template>
  <div class="shadow-md h-auto w-64 p-4 bg-white rounded-lg">
    <h1 class="text-gray-800 font-bold">Gallery</h1>
    <div class="flex flex-wrap justify-center items-center">
      <div v-for="num in [1,2,3,4,5,6,7,8,9]" class="w-1/3 flex justify-center items-center">
        <div class="h-16 w-16 bg-gray-300 rounded-lg mt-2"></div>
      </div>
    </div>
  </div>
</template>

<script>
export default {}
</script>

<style>
</style>
