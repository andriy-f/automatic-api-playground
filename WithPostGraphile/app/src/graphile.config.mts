import { PostGraphileAmberPreset } from "postgraphile/presets/amber";
// Use the 'pg' module to connect to the database
import { makePgService } from "postgraphile/adaptors/pg";
// import { PostGraphileRelayPreset } from "postgraphile/presets/relay";
import config from "./config.ts";

const preset: GraphileConfig.Preset = {
    extends: [
        PostGraphileAmberPreset,
        // Uncomment this to opt into a smaller Relay-focussed schema
        //PostGraphileRelayPreset,
    ],
    pgServices: [makePgService({ connectionString: config.db_url })],
};

export default preset;