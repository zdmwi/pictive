<template>
  <div class="shadow-md h-64 w-64 p-4 bg-white flex flex-col items-center rounded-lg">
    <div class="h-24 w-24 bg-gray-300 rounded-full mb-4"></div>
    <h1 class="text-lg font-bold text-gray-800">{{ identity.displayName }}</h1>
    <span class="text-sm text-gray-600">{{ identity.metadata }}</span>
  </div>
</template>

<script>
export default {
  props: {
    identity: Object
  }
}
</script>

<style>
</style>
