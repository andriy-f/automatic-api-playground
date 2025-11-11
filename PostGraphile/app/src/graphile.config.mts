import { PostGraphileAmberPreset } from "postgraphile/presets/amber";
// Use the 'pg' module to connect to the database
import { makePgService } from "postgraphile/adaptors/pg";
import { PostGraphileRelayPreset } from "postgraphile/presets/relay";

if (!process.env.DATABASE_URL) {
    throw new Error("DATABASE_URL environment variable is not set");
}

export const port = process.env.PORT ? parseInt(process.env.PORT, 10) : 5678;

const preset: GraphileConfig.Preset = {
    extends: [
        PostGraphileAmberPreset,
        // Uncomment this to opt into a smaller Relay-focussed schema
        //PostGraphileRelayPreset,
    ],
    grafserv: { port: port },
    pgServices: [makePgService({ connectionString: process.env.DATABASE_URL })],
};

export default preset;