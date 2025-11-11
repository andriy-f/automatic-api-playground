import { PostGraphileAmberPreset } from "postgraphile/presets/amber";

const preset: GraphileConfig.Preset = {
    extends: [PostGraphileAmberPreset],
};

export default preset;