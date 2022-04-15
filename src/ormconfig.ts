import { join } from "path";
import { ConnectionOptions } from "typeorm";

const config = {
    host: "localhost",
    user: "postgres",
    password: "postgres",
    database: "postgres",
};

const connectionOptions: ConnectionOptions = {
    type: "postgres",
    host: config.host,
    port: 5432,
    username: config.user,
    password: config.password,
    database: config.database,
    entities: [],
    synchronize: true,
    dropSchema: false,
    logger: "advanced-console",
    migrations: [join(__dirname, "../migration/*.ts")],
    logging: true,
}