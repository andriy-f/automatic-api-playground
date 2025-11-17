const requireEnv = (varName: string): string => {
    const value = process.env[varName];
    if (!value) {
        throw new Error(`Environment variable ${varName} is required but not set.`);
    }
    return value;
}

const getEnv = (varName: string): string | null => {
    return process.env[varName] ?? null;
}

const getEnvInt = (varName: string): number | null => {
    const value = process.env[varName];
    if (!value) {
        return null;
    }
    const intValue = parseInt(value, 10);
    if (isNaN(intValue)) {
        throw new Error(`Environment variable ${varName} is not a valid integer.`);
    }
    return intValue;
}

const port = getEnvInt('PORT') ?? 5678;
const host = getEnv('HOST') ?? 'localhost'; // 0.0.0.0 for all interfaces, localhost for local only
const db_url = requireEnv('DATABASE_URL');
const node_env = getEnv('NODE_ENV') ?? 'development';
const is_dev = node_env === 'development';

export default {
    port,
    host,
    db_url,
    node_env,
    is_dev
};