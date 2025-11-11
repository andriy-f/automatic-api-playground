import { grafserv } from "postgraphile/grafserv/fastify/v4";
import { pgl } from "./pgl.js";
import Fastify from 'fastify'
import { port } from "./graphile.config.mts";

const serv = pgl.createServ(grafserv);

// Import the framework and instantiate it
const fastify = Fastify({
    logger: true
})

// Declare a route
fastify.get('/', async function handler(request, reply) {
    return { hello: 'world' }
})

serv.addTo(fastify).catch((e) => {
    console.error(e);
    process.exit(1);
});

// Run the server!
try {
    await fastify.listen({ port: port })
} catch (err) {
    fastify.log.error(err)
    process.exit(1)
}