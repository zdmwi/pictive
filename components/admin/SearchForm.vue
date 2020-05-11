<template>
  <div class="flex flex-col">
    <form @submit.prevent="emitSubmit" class="flex">
      <input
        v-model="searchString"
        :placeholder="'Search for ' + currentQueryType + '...'"
        type="text"
        class="form-input focus:outline-none bg-society text-white border-0 w-64 rounded-l-lg rounded-r-none text-sm shadow-md"
      />
      <button
        type="submit"
        class="flex justify-center py-2 px-4 border border-transparent text-sm leading-5 font-medium rounded-r-lg text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition duration-150 ease-in-out shadow-md"
      >Search</button>
    </form>
    <div v-if="searchCache.lastUsedQueue.length > 0" class="flex items-center opacity-75 mt-2">
      <span class="mr-1 text-sm">Recent:</span>
      <span
        class="mr-2 text-sm underline cursor-pointer"
        v-for="searchObjString in searchCache.lastUsedQueue"
        @click="emitReplaySubmit(searchObjString)"
      >{{ searchObjString }}</span>
    </div>
  </div>
</template>

<script>
import LRUCache from '@/utils/LRUCache'

const cacheCapacity = 3
export default {
  props: {
    currentQueryType: String
  },
  data() {
    return {
      searchString: '',
      searchCache: new LRUCache(cacheCapacity)
    }
  },
  methods: {
    emitSubmit() {
      this.searchCache.put(`${this.currentQueryType}:${this.searchString}`)
      this.$emit('submit-query', this.searchString)
    },

    emitReplaySubmit(searchObjString) {
      const [queryType, searchString] = searchObjString.split(':')
      const searchObjPayload = {
        queryType,
        searchString
      }
      this.searchString = searchString
      this.searchCache.put(searchObjString)
      this.$emit('replay-submit-query', searchObjPayload)
    }
  }
}
</script>

<style>
</style>
