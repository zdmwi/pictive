<template>
  <div class="shadow-md self-start h-auto w-64 p-4 bg-white rounded-lg mr-8">
    <nuxt-link
      to="/home"
      v-for="item in ['Home']"
      :key="item"
      class="flex justify-start items-center p-2 hover:bg-gray-200 rounded-lg"
    >
      <div class="bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
      <div>
        <span class="block text-gray-800 text-sm font-bold pl-3">{{item}}</span>
      </div>
    </nuxt-link>
  </div>
</template>

<script>
export default {}
</script>

<style>
</style>
