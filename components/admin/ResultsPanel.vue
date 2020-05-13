<template>
  <div class="h-full w-full p-2">
    <div class="bg-white rounded-lg text-gray-800 p-8 shadow-lg h-full w-full overflow-y-scroll">
      <div v-if="results" class="flex flex-col">
        <h1 class="text-lg font-bold mb-4">Showing result(s) for '{{ searchString }}'...</h1>
        <UserResults v-if="queryType === 'users'" :users="results" :searchString="searchString" />
      </div>
      <h1 v-else class="opacity-25 text-lg font-bold">No results to show.</h1>
    </div>
  </div>
</template>

<script>
import UserResults from '@/components/admin/UserResults.vue'

export default {
  props: {
    searchString: String,
    queryType: String,
    results: Array
  },
  components: {
    UserResults
  }
}
</script>

<style>
</style>
