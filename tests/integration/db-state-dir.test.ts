import { test } from 'node:test';
import assert from 'node:assert/strict';
import { existsSync } from 'node:fs';
import { join } from 'node:path';
import { createTempStateDir } from '../helpers/state';

test('database uses RACHELBOT_STATE_DIR', async () => {
  const tempState = createTempStateDir();
  const tempDir = tempState.dir;
  const previousStateDir = process.env.RACHELBOT_STATE_DIR;
  process.env.RACHELBOT_STATE_DIR = tempDir;

  try {
    const { createDatabase } = await import('../../src/db/index.ts');
    const db = createDatabase();
    await db.getVersion();
    const dbPath = join(tempDir, 'rachelbot.db');
    assert.ok(existsSync(dbPath));
    db.close();
  } finally {
    if (previousStateDir === undefined) {
      delete process.env.RACHELBOT_STATE_DIR;
    } else {
      process.env.RACHELBOT_STATE_DIR = previousStateDir;
    }
    tempState.cleanup();
  }
});
