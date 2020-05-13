<template>
  <div class="shadow-md h-auto w-64 p-4 bg-white rounded-lg mr-8">
    <div
      v-for="item in ['Home', 2, 3, 4, 5]"
      :key="item"
      class="flex justify-start items-center pt-4 mb-2"
    >
      <div class="bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
      <div>
        <span class="block text-gray-800 text-sm font-bold pl-3">{{item}}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {}
</script>

<style>
</style>
