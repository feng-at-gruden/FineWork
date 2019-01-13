<template>
    <v-dialog v-model="dialog" lazy content-class="half-right-dialog" hide-overlay transition="slide-x-reverse-transition">
        <v-card>
            <v-container style="max-width: 600px;">
                <v-timeline dense clipped>                
                    <v-slide-x-transition group>
                        <v-timeline-item v-for="event in timelineData" :key="event.id" class="mb-3" color="pink" small>
                            <v-layout justify-space-between>
                                <v-flex xs7 v-text="event.text"></v-flex>
                                <v-flex xs5 text-xs-right v-text="event.time"></v-flex>
                            </v-layout>
                        </v-timeline-item>
                    </v-slide-x-transition>
                    <v-timeline-item class="mb-4" hide-dot>
                        <span>TODAY</span>
                    </v-timeline-item>
                    <v-timeline-item class="mb-3" color="grey" icon-color="grey lighten-2" small>
                        <v-layout justify-space-between>
                            <v-flex xs7>This order was archived.</v-flex>
                            <v-flex xs5 text-xs-right>15:26 EDT</v-flex>
                        </v-layout>
                    </v-timeline-item>
                    <v-timeline-item class="mb-3" small>
                        <v-layout justify-space-between>
                            <v-flex xs7>
                                <v-chip class="white--text ml-0" color="purple" label small>
                                    APP
                                </v-chip>
                                Digital Downloads fulfilled 1 item.
                            </v-flex>
                            <v-flex xs5 text-xs-right>15:25 EDT</v-flex>
                        </v-layout>
                    </v-timeline-item>
                    <v-timeline-item class="mb-3" color="grey" small>
                        <v-layout justify-space-between>
                            <v-flex xs7>
                                Order confirmation email was sent to John Leider (john@vuetifyjs.com).
                            </v-flex>
                            <v-flex xs5 text-xs-right>15:25 EDT</v-flex>
                        </v-layout>
                    </v-timeline-item>
                    <v-timeline-item class="mb-3" hide-dot>
                        <v-btn class="mx-0" color="white">
                            Resend Email
                        </v-btn>
                    </v-timeline-item>
                    <v-timeline-item class="mb-3" color="grey" small>
                        <v-layout justify-space-between>
                            <v-flex xs7>
                                A $15.00 USD payment was processed on PayPal Express Checkout
                            </v-flex>
                            <v-flex xs5 text-xs-right>15:25 EDT</v-flex>
                        </v-layout>
                    </v-timeline-item>
                    <v-timeline-item color="grey" small>
                        <v-layout justify-space-between>
                            <v-flex xs7>
                                John Leider placed this order on Online Store (checkout #1937432132572).
                            </v-flex>
                            <v-flex xs5 text-xs-right>15:25 EDT</v-flex>
                        </v-layout>
                    </v-timeline-item>
                </v-timeline>
            </v-container>
        </v-card>
    </v-dialog>
</template>
<script>
export default {
    name: 'ProjectTimeline',
    props: ['open','timeline'],
    computed: {
        timelineData(){
            return this.$props.timeline
        },
        dialog: {
            get() { return this.$props.open },
            set(v) {
                this.$emit('close')
            }
        }
    },
    methods: {

    }
}

</script>
<style>
</style>
