<template>
  <div class="container flex justify-between px-8 py-4">
    <SideNav />
    <div class="flex flex-col flex-1">
      <PostForm class="mb-4" />
      <Posts
        v-for="post in posts"
        v-bind:fname="post.fname"
        v-bind:lname="post.lname"
        v-bind:p_id="post.id"
        v-bind:url="post.url"
        v-bind:caption="post.caption"
        v-bind:body="post.body"
        v-bind:date="post.date"
        :key="post.id"
      ></Posts>
    </div>
    <div class="shadow-md h-64 w-64 p-4 bg-white rounded-lg ml-8">
      <h5 class="text-gray-800 text-base font-bold">User's Groups</h5>
      <div v-for="group in groups" :key="group" class="flex justify-start pt-4 mb-2">
        <div class="bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
        <div>
          <span class="block text-gray-800 text-sm leading-none pl-3 pt-1">{{group.name}}</span>
          <span class="block text-gray-800 text-xs pl-3">Lorem ipsum dolor sit amet...</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import PostForm from '@/components/shared/PostForm.vue'
import Posts from '@/components/shared/Posts.vue'
import SideNav from '@/components/home/SideNav.vue'

export default {
  components: {
    PostForm,
    Posts,
    SideNav
  },
  async created() {
    const postsResults = await this.$axios.$get(
      `/api/users/${this.$route.params.id}/home`
    )

    const groupsResults = await this.$axios.$get(
      `/api/users/${this.$route.params.id}/groups`
    )

    this.posts = postsResults.data
    this.groups = groupsResults.data

    console.log(postsResults, groupsResults)
  },
  data() {
    return {
      user: null,
      posts: [],
      groups: []
    }
  }
}
</script>
