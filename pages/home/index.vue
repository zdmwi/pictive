<template>
  <div class="container flex justify-between px-8 py-4">
    <div class="h-50 w-64 bg-white shadow-sm rounded-lg px-4 py-2 mt-2">
      <input class="h-40 w-auto bg-gray-100" placeholder="What's on your mind?">
      <button class="self-end flex-1 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full">
        Post
      </button>
    </div>
    <div class="px-4 mx-2 py-2">
      <Posts v-for="post in posts"
      v-bind:url="post.url"
      v-bind:caption="post.caption"
      v-bind:body="post.body"
      v-bind:date="post.date"
      :key="post.id"></Posts>
    </div>
    <div class="h-50 w-64 bg-white shadow-sm rounded-lg px-4 py-2 mt-2">
      <h5>Groups</h5>
      <span v-for="(group, index) in groups" :key="index">{{group.name}}</span>
    </div>
  </div>
</template>

<script>
import Posts from '@/components/shared/Posts.vue'

export default {
  layout: "home",
  components: {
      Posts
  },
  data() {
    return {
      posts: [
        {
          "id": 1,
          "url": "https://placeimg.com/640/480/nature",
          "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus quia, nulla! Maiores et perferendis eaque, exercitationem praesentium nihil.",
          "date": "2020-03-12"
        },
        {
          "id": 2,
          "url": "https://placeimg.com/640/480/animals/sepia",
          "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
          "date": "2020-04-26"
        },
        {
          "id": 5,
          "url": "https://placeimg.com/640/480/animals",
          "caption": "",
          "date": "2020-04-16"
        }
      ],
      groups: [
        {
          "name": "Group 1",
          "members": 50
        },
        {
          "name": "Group 2",
          "members": 120
        },
        {
          "name": "Group 3",
          "members": 15
        },
        {
          "name": "Group 4",
          "members": 20
        }
      ]
    }
  },
  methods: {

  }
}
</script>