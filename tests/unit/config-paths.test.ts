import { test } from 'node:test';
import assert from 'node:assert/strict';
import { resolve } from 'node:path';
import { resolveConfigPath, resolveStateDir, resolveWorkspaceDir } from '../../src/utils/config';

test('resolveStateDir uses override', () => {
  const env = { RACHELBOT_STATE_DIR: '/tmp/rachelbot-state' } as NodeJS.ProcessEnv;
  assert.equal(resolveStateDir(env), resolve('/tmp/rachelbot-state'));
});

test('resolveConfigPath uses override', () => {
  const env = { RACHELBOT_CONFIG_PATH: '/tmp/rachelbot.json' } as NodeJS.ProcessEnv;
  assert.equal(resolveConfigPath(env), resolve('/tmp/rachelbot.json'));
});

test('resolveWorkspaceDir uses override', () => {
  const env = { RACHELBOT_WORKSPACE: '/tmp/rachelbot-workspace' } as NodeJS.ProcessEnv;
  assert.equal(resolveWorkspaceDir(env), resolve('/tmp/rachelbot-workspace'));
});
