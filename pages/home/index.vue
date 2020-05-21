<template>
  <div class="container flex justify-between px-8 py-4">
    <SideNav />
    <div class="flex flex-col flex-1">
      <PostForm class="mb-4" />
      <Posts
        v-for="post in userPosts"
        v-bind:fname="post.fname"
        v-bind:lname="post.lname"
        v-bind:p_id="post.post_id"
        v-bind:url="post.url"
        v-bind:caption="post.caption"
        v-bind:body="post.body"
        v-bind:date="post.created_on"
        :key="post.id"
      ></Posts>
    </div>
    <div>
      <div class="shadow-md self-start h-auto w-64 p-4 bg-white rounded-lg ml-8">
        <div class="flex justify-between items-center">
          <h5 class="text-gray-800 text-base font-bold">User's Groups</h5>
          <span @click="handleCreateGroup" class="text-sm text-indigo-600 cursor-pointer">New Group</span>
        </div>
        <div v-for="group in groups.slice(0, 5)" :key="group" class="flex justify-start pt-4 mb-2">
          <div class="bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
          <div>
            <span class="block text-gray-800 text-sm leading-none pl-3 pt-1">{{group.name}}</span>
            <span class="block text-gray-800 text-xs pl-3">Lorem ipsum dolor sit amet...</span>
          </div>
        </div>
      </div>
      <div class="mt-4 shadow-md self-start h-auto w-64 p-4 bg-white rounded-lg ml-8">
        <h5 class="text-gray-800 text-base font-bold">Suggested Friends</h5>
        <div v-for="group in groups.slice(0, 5)" :key="group" class="flex justify-start pt-4 mb-2">
          <div class="bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
          <div>
            <span class="block text-gray-800 text-sm leading-none pl-3 pt-1">{{group.name}}</span>
            <span class="block text-gray-800 text-xs pl-3">Lorem ipsum dolor sit amet...</span>
          </div>
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
  computed: {
    userPosts: function () {
      this.posts.sort((a, b) => b.post_id - a.post_id )
      for(let i=0; i < this.posts.length; i++){
        let post = this.posts[i];
        let p_date = new Date(post.created_on);
        p_date.setTime(p_date.getTime()+86400000);
        post.created_on = p_date.toString().substring(4, 11);
        this.posts[i] = post;
      }
      return this.posts
    }
  },
  async mounted() {
    const userId = localStorage.getItem('user') || 1

    const postsResults = await this.$axios.$get(`/api/users/${userId}/home`)

    const groupsResults = await this.$axios.$get(`/api/users/${userId}/groups`)

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
  },
  methods: {
    handleCreateGroup() {
      console.log('creating a group')
    }
  }
}
</script>
