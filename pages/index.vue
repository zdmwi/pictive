<template>
  <div class="w-full max-w-xs">
    <h3 class="block text-gray-700 font-bold mb-2">LOGIN</h3>
    <form @submit.prevent="handleLoginQuery" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
      <div class="mb-4">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email Address</label>
        <input
          v-model="email"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          id="email"
          type="text"
          placeholder="someone@example.com"
        />
      </div>
      <div class="mb-6">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="password">Password</label>
        <input
          v-model="password"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          id="password"
          type="password"
          placeholder="********"
        />
      </div>
      <div class="flex items-center justify-around">
        <button
          class="bg-indigo-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          type="submit"
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
      email: '',
      password: ''
    }
  },
  methods: {
    async handleLoginQuery() {
      // 'wAEhHs','iscott@gmail.com'
      try {
        if (this.email === 'admin' && this.password === '0000') {
          this.$router.push({ path: '/admin' })
        } else {
          const url = '/api/login'
          const results = await this.$axios.$post(url, {
            email: this.email,
            password: this.password
          })
          this.$router.push(
            { path: '/home' },
            { params: { id: results.data[0].id } }
          )
        }
      } catch (e) {
        console.log(e)
      }
    }
  }
}
</script>

<style>
</style>
