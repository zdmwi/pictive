<template>
  <div class="flex flex-col mt-4 w-full text-sm">
    <h1 class="font-semibold">Query Types ({{ queryTypes.length }})</h1>
    <small
      class="opacity-75"
    >Change the type of query you want to make by clicking one of these options</small>
    <div class="flex flex-wrap mt-2">
      <div
        v-for="queryType in queryTypes"
        :key="queryType"
        class="w-1/4 mt-2 flex justify-center items-center"
      >
        <div
          @click="emitQueryType(queryType)"
          :class="currentQueryType === queryType ? selectedQuerySelectionClass : baseQuerySelectionClass"
        >{{ queryType }}</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    currentQueryType: String
  },
  data() {
    return {
      queryTypes: ['users', 'profiles', 'posts', 'groups']
    }
  },
  computed: {
    baseQuerySelectionClass() {
      return 'h-24 w-24 bg-society rounded-md p-4 flex justify-center items-center capitalize cursor-pointer shadow-md'
    },
    selectedQuerySelectionClass() {
      return 'h-24 w-24 bg-indigo-600 rounded-md p-4 flex justify-center items-center capitalize cursor-pointer shadow-md'
    }
  },
  methods: {
    emitQueryType(queryType) {
      this.$emit('change-query-type', queryType)
    }
  }
}
</script>

<style>
</style>
