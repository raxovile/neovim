return {
  'prettier/vim-prettier',
  run = 'yarn install --frozen-lockfile --production',
  cmd = 'Prettier',
  ft = { 'javascript', 'typescript', 'css', 'scss', 'json', 'markdown' },
}
