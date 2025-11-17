import { grafserv } from "postgraphile/grafserv/fastify/v4";
import Fastify from 'fastify'
import { pgl } from "./pgl.ts";
import config from "./config.ts"

const server = pgl.createServ(grafserv);

// Import the framework and instantiate it
const fastify = Fastify({
    logger: true
})

// Declare a route
fastify.get('/hello-world', async function handler(request, reply) {
    return { hello: 'world' }
})

server.addTo(fastify).catch((e) => {
    console.error(e);
    process.exit(1);
});

// Run the server!
try {
    await fastify.listen({
        port: config.port,
        host: config.host
    })
} catch (err) {
    fastify.log.error(err)
    process.exit(1)
}