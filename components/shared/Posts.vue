<template>
    <div class="rounded-lg bg-white h-auto overflow-hidden shadow-lg mb-4">
        <div class="flex justify-start px-6 pt-4">
            <div class="bg-gray-300 h-12 w-12 rounded-full cursor-pointer"></div>
            <p class="text-gray-900 text-sm leading-none pl-4 pt-4">Jonathan Reinink</p>
            <p class="text-xs justify end ml-auto pt-4">{{date}}</p>
        </div>
        <div class="px-6 py-4">
            <p v-if="caption" class="text-gray-700 text-base">
            {{caption}}
            </p>
            <p v-else class="text-gray-700 text-base">
            {{body}}
            </p>
        </div>
        <img v-if="url" class="w-full" :src="url" alt="Sunset in the mountains">
    </div>
</template>

<script>
export default {
    props: ['url','caption','body','date']
}
</script>