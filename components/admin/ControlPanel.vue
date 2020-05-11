<template>
  <div class="flex flex-col justify-center items-center p-16 text-left h-full w-full">
    <h1 class="text-2xl font-semibold leading-tight">Hi Admin</h1>
    <small class="opacity-75 mb-4">View and manage the relatable things here.</small>
    <SearchForm
      :currentQueryType="currentQueryType"
      @replay-submit-query="emitReplaySubmitQuery"
      @submit-query="emitSubmitQuery"
    />
    <QuerySelector :currentQueryType="currentQueryType" @change-query-type="handleChangeQueryType" />
  </div>
</template>

<script>
import SearchForm from '@/components/admin/SearchForm.vue'
import QuerySelector from '@/components/admin/QuerySelector.vue'

export default {
  components: {
    SearchForm,
    QuerySelector
  },
  data() {
    return {
      // the default query is searching for a user
      currentQueryType: 'users'
    }
  },
  methods: {
    handleChangeQueryType(newQueryType) {
      this.currentQueryType = newQueryType
    },

    emitSubmitQuery(searchString) {
      const searchObjPayload = {
        queryType: this.currentQueryType,
        searchString
      }
      this.$emit('submit-query', searchObjPayload)
    },

    emitReplaySubmitQuery(searchObjPayload) {
      const { queryType } = searchObjPayload
      this.currentQueryType = queryType
      this.$emit('replay-submit-query', searchObjPayload)
    }
  }
}
</script>

<style>
</style>
