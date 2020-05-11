<template>
  <div class="flex h-full w-full">
    <ControlPanel @submit-query="handleSubmitQuery" @replay-submit-query="handleReplaySubmitQuery" />
    <ResultsPanel :searchString="searchString" :results="results" />
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
      results: null
    }
  },
  methods: {
    async handleSubmitQuery(searchObjPayload) {
      const { queryType, searchString } = searchObjPayload
      this.searchString = searchString
      try {
        const url = '/api/users'
        const results = await this.$axios.$get(url)
        console.log(results)
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
