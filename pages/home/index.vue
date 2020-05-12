<template>
  <div class="container flex justify-between px-8 py-4">
    <div class="shadow-md h-64 w-3/5 p-4 bg-white flex flex-col rounded-lg">
      <textarea class="bg-gray-300 rounded-lg text-gray-800 text-sm h-40 form-input" placeholder="What's on your mind?">
      </textarea>
      <div class="inline-flex">
        <img class="mt-3 pr-2 ml-auto cursor-pointer" src="https://img.icons8.com/small/34/000000/camera.png"/>
        <button class="mt-3 bg-gray-500 hover:bg-gray-600 text-white text-base font-bold px-6 rounded-lg focus:outline-none focus:shadow-outline" type="button">
          Post
        </button>
      </div>
    </div>
    <div class="flex flex-col px-4 mx-2">
      <Posts v-for="post in userPosts"
      v-bind:p_id="post.id"
      v-bind:url="post.url"
      v-bind:caption="post.caption"
      v-bind:body="post.body"
      v-bind:date="post.date"
      :key="post.id"
      ></Posts>
    </div>
    <div class="shadow-md h-64 w-5/12 p-4 bg-white rounded-lg">
      <h5 class="text-gray-800 text-base font-bold">Groups</h5>
      <div v-for="(group, index) in groups.slice(0, 3)" :key="index" class="flex justify-start pt-4 mb-2">
            <div class="bg-gray-300 h-8 w-8 rounded-full cursor-pointer"></div>
            <div>
            <span class="block text-gray-900 text-sm leading-none pl-3 pt-1">{{group.name}}</span>
            <span class="block text-gray-900 text-xs pl-3">Lorem ipsum dolor sit amet...</span>
            </div>
      </div>
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
  computed: {
    userPosts: function () {
      this.posts.sort((a, b) => b.id - a.id );
      for(let i=0; i < this.posts.length; i++){
        let post = this.posts[i];
        let p_date = new Date(post.date);
        p_date.setTime(p_date.getTime()+86400000);
        post.date = p_date.toString().substring(4, 11);
        this.posts[i] = post;
      }
      return this.posts;
    }
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
          "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus quia, nulla! Maiores et perferendis eaque, exercitationem praesentium nihil.",
          "date": "2020-03-15"
        },
        {
          "id": 3,
          "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus quia, nulla! Maiores et perferendis eaque, exercitationem praesentium nihil.",
          "date": "2020-03-15"
        },
        {
          "id": 4,
          "url": "https://placeimg.com/640/480/tech",
          "caption": "",
          "date": "2020-04-06"
        },
        {
          "id": 5,
          "url": "https://placeimg.com/640/480/animals",
          "caption": "",
          "date": "2020-04-16"
        },
        {
          "id": 6,
          "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus quia, nulla! Maiores et perferendis eaque, exercitationem praesentium nihil.",
          "date": "2020-04-25"
        },
        {
          "id": 7,
          "url": "https://placeimg.com/640/480/animals/sepia",
          "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
          "date": "2020-04-26"
        },                           
        {
          "id": 8,
          "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus quia, nulla! Maiores et perferendis eaque, exercitationem praesentium nihil.",
          "date": "2020-05-01"
        },
        {
          "id": 9,
          "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus quia, nulla! Maiores et perferendis eaque, exercitationem praesentium nihil.",
          "date": "2020-05-05"
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