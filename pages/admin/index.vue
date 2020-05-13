<template>
  <div class="flex h-full w-full">
    <ControlPanel @submit-query="handleSubmitQuery" @replay-submit-query="handleReplaySubmitQuery" />
    <ResultsPanel :queryType="queryType" :searchString="searchString" :results="results" />
  </div>
</template>

<script>
import ControlPanel from '@/components/admin/ControlPanel.vue'
import ResultsPanel from '@/components/admin/ResultsPanel.vue'

export default {
  layout: 'admin',
  components: {
    ControlPanel,
    ResultsPanel
  },
  data() {
    return {
      searchString: '',
      queryType: '',
      results: null
    }
  },
  methods: {
    async handleSubmitQuery(searchObjPayload) {
      const { queryType, searchString } = searchObjPayload
      this.searchString = searchString
      this.queryType = queryType
      try {
        const url = `/api/${queryType}`
        const results = await this.$axios.$get(url)
        this.results = results.data
      } catch (e) {
        console.log(e)
      }
    },

    handleReplaySubmitQuery(searchObjPayload) {
      const { queryType, searchString } = searchObjPayload
      this.searchString = searchString
    }
  }
}
</script>

<style>
</style>
