import { readFileSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Read project config with robust error handling
const configPath = join(__dirname, '..', '..', 'project-config.json');
let configContent = readFileSync(configPath, 'utf-8');

// Remove BOM and other invisible characters
configContent = configContent.replace(/^\uFEFF/, '').replace(/^\u00EF\u00BB\u00BF/, '').trim();

let config;
try {
  config = JSON.parse(configContent);
} catch (error) {
  console.error(`Error parsing project-config.json:`);
  console.error(`Path: ${configPath}`);
  console.error(`Content length: ${configContent.length}`);
  console.error(`First 100 chars: ${configContent.substring(0, 100)}`);
  throw error;
}

// Read package.json
const packagePath = join(__dirname, '..', 'package.json');
const pkg = JSON.parse(readFileSync(packagePath, 'utf-8'));

// Update package.json with project config
pkg.name = `${config.project.name.toLowerCase().replace(/_/g, '-')}-gui`;
pkg.version = config.project.version;
pkg.description = `GUI for ${config.project.displayName}`;

// Write updated package.json
import { writeFileSync } from 'fs';
writeFileSync(packagePath, JSON.stringify(pkg, null, 2) + '\n');

console.log(`✓ Updated package.json: ${pkg.name}@${pkg.version}`);
