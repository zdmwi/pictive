<template>
  <div class="w-full max-w-xs">
    <h3 class="block text-gray-700 font-bold mb-2">LOGIN</h3>
    <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
      <div class="mb-4">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email Address</label>
        <input
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          id="email"
          type="text"
          placeholder="someone@example.com"
        />
      </div>
      <div class="mb-6">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="password">Password</label>
        <input
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          id="password"
          type="password"
          placeholder="********"
        />
      </div>
      <div class="flex items-center justify-around">
        <button
          class="bg-indigo-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          type="button"
          @click="handleLoginQuery()"
        >Sign In</button>
      </div>
    </form>
    <p class="text-center text-gray-500 text-xs">&copy;2020 Acme Corp. All rights reserved.</p>
  </div>
</template>

<script>
export default {
  layout: 'login',
  data() {
    return {
      username: '',
      password: '',
      results: null
    }
  },
  methods: {
    async handleLoginQuery() {
      const { username } = this.username
      const { password } = this.password
      try {
        const url = '/api/login'
        this.results = this.$axios.$post(url, {
          username: username,
          password: password
        })
        console.log(results)
      } catch (e) {
        console.log(e)
      }
    }
  }
}
</script>

<style>
</style>
