import { mkdir, readFile, writeFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";

const root = resolve(".");
const source = resolve(root, "index.html");
const output = resolve(root, "dist", "index.html");

const html = await readFile(source, "utf8");
await mkdir(dirname(output), { recursive: true });
await writeFile(output, html, "utf8");

console.log(`Built ${output}`);

