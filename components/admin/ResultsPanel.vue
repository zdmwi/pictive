<template>
  <div class="h-full w-full p-2">
    <div class="bg-white rounded-lg text-gray-800 p-8 shadow-lg h-full w-full">
      <h1
        v-if="results"
        class="text-lg font-bold"
      >Showing {{ results.length }} result(s) for '{{ searchString }}'...</h1>
      <h1 v-else class="opacity-25 text-lg font-bold">No results to show.</h1>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    searchString: String,
    results: String
  }
}
</script>

<style>
</style>
