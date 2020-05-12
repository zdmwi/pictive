<template>
    <div>
        <div v-for="post in posts" :key="post.id" class="rounded-lg">
            <img class="rounded-lg" :src="post.url">
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            posts: [
                {
                    "id": 1,
                    "url": "https://placeimg.com/640/480/nature",
                    "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatibus quia, nulla! Maiores et perferendis eaque, exercitationem praesentium nihil.",
                    "date": "2020-03-12"
                }
            ]
        }
    }
}
</script>