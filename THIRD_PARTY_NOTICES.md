# Third-party notices

## jnMetaCode/agency-agents-zh

This package is a port of [`jnMetaCode/agency-agents-zh`](https://github.com/jnMetaCode/agency-agents-zh).
The upstream source is used under the MIT License.

| | |
|---|---|
| Package | [`agency-agents-zh@1.2.7`](https://www.npmjs.com/package/agency-agents-zh) |
| Repository | [jnMetaCode/agency-agents-zh](https://github.com/jnMetaCode/agency-agents-zh) |
| Authors | Michael Sitarzewski (original English version) · jnMetaCode (Chinese translation and localization) |
| License | MIT |
| Release date | 2026-07-19 |
| Tarball | `https://github.com/jnMetaCode/agency-agents-zh/archive/465aa4a5a40a376e9ef6c2e151889997992215b9.tar.gz` |
| gitHead | `465aa4a5a40a376e9ef6c2e151889997992215b9` |
| SHA-256 | `5fd83eabce726f3c507efecdd7df874a42d1e353c0c62f887110169e02c593e4` |
| shasum (sha1) | `c83c0550aa4dffd1f30f8db396f4bdc10fb2589e` |

### What the port ships

The upstream repository has 347 tracked files at the pinned commit. 342 are
copied verbatim (byte-identical, SHA-256 below); 5 differ, each explained in
the port report (issue #39):

- `.github/workflows/sync-to-gitee.yml` — not ported: hard-codes the upstream
  author's Gitee remote and `GITEE_TOKEN`; keeping it would force-push this
  repo's `main` to the upstream Gitee mirror, so it is not portable.
- `LICENSE` — upstream lines kept verbatim, plus one `Copyright (c) 2026
  GongYuanCaiJi (dsh port)` line.
- `.gitignore` — the playbook standard, because the upstream one ignores
  `integrations/`, which would untrack 14 shipped files.
- `README.md` — rewritten as a bilingual facade per the port playbook.
- `package.json` — reshaped to the dsh plugin form (name, dsh.bundle,
  scripts; upstream `check:counts` kept).

The 342 verbatim files are the 267 agent files plus AGENT-LIST.md, CATALOG.md,
UPSTREAM.md, CONTRIBUTING.md, scripts, integrations, examples, assets,
`.github/` (minus the Gitee sync workflow), `strategy/`, and
`.gitattributes`. The plugin's dsh adaptation layer (`index.js`,
`index.d.ts`, `cordis.patch.yml`, `lib/`, `test/`) is new and has no
upstream counterpart.

### Verifying the verbatim claim yourself

The README states that the agent files are byte-identical to upstream. You do
not have to take that on trust — fetch the pinned upstream tarball and
compare:

```bash
curl -sL https://github.com/jnMetaCode/agency-agents-zh/archive/465aa4a5a40a376e9ef6c2e151889997992215b9.tar.gz | tar xz
UP=agency-agents-zh-465aa4a5a40a376e9ef6c2e151889997992215b9
for d in academic design engineering finance game-development gis hr legal marketing paid-media product project-management sales security spatial-computing specialized strategy supply-chain support testing; do
  diff -rq "$UP/$d" "$d" || exit 1
done
echo "all agent dirs OK"
```

Expected differences are limited to: `sync-to-gitee.yml` (not ported),
`LICENSE` (added dsh port line), `.gitignore` (playbook standard),
`README.md` (bilingual facade), `package.json` (dsh plugin shape), and the
dsh adaptation files listed above.

Expected SHA-256 of every verbatim file (342 files):

```
`.gitattributes` | `ed65c024021bacdc57203bc9d5a23f2afacc32088f8f595e5b7d82710d7b70de`
`.github/FUNDING.yml` | `2b837639535c88caaaeae8d2fa6c367ab7b17578146b04e5e77c255811b8711b`
`.github/ISSUE_TEMPLATE/bug-report.yml` | `e3eb8155f9c3de4dbfd6ce4a419eef76f67b67237ddd446ef5fea804d6958389`
`.github/ISSUE_TEMPLATE/bug_report.md` | `904fa97527548fbee6f88a302ea3998a20502ab69a7440b182959c85438ee5fc`
`.github/ISSUE_TEMPLATE/feature_request.md` | `2f50e30d6f7d4e5073e876568a115bbe153d206c1fce6989248249affcb1287b`
`.github/ISSUE_TEMPLATE/new-agent-request.yml` | `3e0f5fb285d7f0f604b33c8f879252e9fe7e28b61fc24804fc1fcd5b37805385`
`.github/ISSUE_TEMPLATE/new_agent.md` | `16f1786df45bfdfce8262d95dc61b7cdbf062c3cf345d147473daa404c014566`
`.github/PULL_REQUEST_TEMPLATE.md` | `4ca121e44adfa5ea1ed78076dc337fc097324ce91da2e282407d3de8e97cb029`
`.github/workflows/ci.yml` | `7ec8141a97ed4f7d909a03cc7139e528c96f28fbb4358abb9fcd758a6e0c26c6`
`.github/workflows/lint-agents.yml` | `1bc6852a30da7e804d2b974f16eaa4759b9f90100e4d9dd9f17744b048d98a59`
`AGENT-LIST.md` | `46f01fb9fc2ed48781828b646986b5c9e70f70422f2e7501f055aa925a293c22`
`CATALOG.md` | `98a8d4d48b7a202eff197f56801aee29a0a2023f3c0daa67b850f49466b4a8e6`
`CONTRIBUTING.md` | `47090baae627a58d8ca8b536dd6764de23fae108d4e178270f154435714ad6b0`
`README.zh-TW.md` | `509fd8fa1f6562d49f475068400d978e64419f407c921d67f1f3deb4abf27e05`
`UPSTREAM.md` | `aa5217ec3bb2813753210a54bc3d2b8d8cecb70a4d5775274a56b93a2f658eea`
`academic/academic-anthropologist.md` | `3cc836522e497fb2cf238b5604574d6506afd2f964005b076cb6aaf9d3931871`
`academic/academic-geographer.md` | `3f81034ed5afc3a997c7a8e35be4c4015bc362e3f7d9b33d75a3d59810c40231`
`academic/academic-historian.md` | `caa32fe21f776e93e566a60d41ea21e1cc55c73c33faa7bdf1d6fdbcbb74c48e`
`academic/academic-narratologist.md` | `a594a3246810121b56614b4e457cf6e8685c1379618440e7f7f5e1b61bb396d9`
`academic/academic-psychologist.md` | `4e929a2aaa231ed240aa458a41c0a6711b90d6ee297fb40c3af6ae082f4d1590`
`academic/academic-study-planner.md` | `5700dd2bb80e4ec591c6a7a82e02516cb19451c687f340bf5d08d63519eb0c42`
`assets/experts-gallery.png` | `7c40bd534afb10c915cf2b9f5e2c45e06893d86970bd9499ec360c9e55c03220`
`assets/qr-wechat.jpg` | `64193331757391128d233273e0ad2a9b6273d180d4e8de969d15859f6251249d`
`assets/sponsor-apinebula.jpeg` | `e98839fed6215ef44b258b2a54e6b80c232150f8156b5257b15bdf1a9418b841`
`assets/sponsor-ccsub.jpeg` | `6ed4f9dcdedb3bb0987d51892526157271a891a5ca0e0ba4c79da1ae5d938e9f`
`assets/sponsor-compshare.jpeg` | `11ea96cab7eff5ad2422b19a20f35ad6230363eaea06b60cc09075feedaefa87`
`assets/sponsor-cubence.jpeg` | `6b3767e04cc13a697ff4aafc9280b991c2643f76688ab456c0ce27c84dd6ee26`
`assets/sponsor-duoyuanx.jpeg` | `a9823fd0cee96932f208e29327a3e3875667f5830817cd755c4ada5ebc076d28`
`assets/sponsor-rootflowai.jpeg` | `e871b812d3023b3563250c127c55ec73ff502ddfe14ac5ec65d6ccc275bc954a`
`assets/sponsor-volcengine.jpeg` | `57fdd265e87b5b4205d6852e25ef38d6b514a4f8c7d76dcb03b51392a33b1216`
`design/design-brand-guardian.md` | `8f80efac61af2893bf2661faa6fda5b8d56158a503f1ace2e8cd0ae8eaa247c1`
`design/design-image-prompt-engineer.md` | `78400484719d2b3c6889735befe0d01215d2b51a86011a90222e4df70a70781d`
`design/design-inclusive-visuals-specialist.md` | `81b29599264658a1c44730dfae08e76db136f6fc057258cf867eec72033210cd`
`design/design-persona-walkthrough.md` | `0b8782977a8473456b016898f1ef0b447f96bd294ef609a9085f5fb14692f3d1`
`design/design-ui-designer.md` | `281edf2c63124b5762bf01a6995087a3734a186d65135bc0d80218d7ef659684`
`design/design-ux-architect.md` | `d53059c7e304bf9d3023e55686b80981ccc0829e6610e94fe0f43b4f0e97f2ef`
`design/design-ux-researcher.md` | `c47fc392cb91cb05bb422b57e7f6ffc86f1974394548f4c8ab18f293e084c78e`
`design/design-visual-storyteller.md` | `6dd5b1c9056ae3a413a06623f86688ffa9eee4ebe27a8ceab07a702f27470650`
`design/design-whimsy-injector.md` | `392e093fefa2c123ee9c8fe6f462a21e1a640ba6caa25e83512ac10912d88bd9`
`engineering/engineering-ai-data-remediation-engineer.md` | `b84c5964fd05ed0c96586ecd466d565829e50bd92a80d06942515b1325e55f46`
`engineering/engineering-ai-engineer.md` | `961924c67bf689c185ccb5f7ec5e10a3ba4f7db15b93b4512e916c5234017a09`
`engineering/engineering-autonomous-optimization-architect.md` | `127db14dc99315b16283da3aff1f286277f1408c2da3d690ba2111441fc1cdde`
`engineering/engineering-backend-architect.md` | `8fe4312fa28978e6939d77cb09170b6fbb3b353306a6f55595f6ca27d56e6793`
`engineering/engineering-cms-developer.md` | `17eede194b4954936b7fb8cdac252544e2538230a69e24df65c470ad69fab24c`
`engineering/engineering-code-reviewer.md` | `d320cb74a7ae46c5533917b59372135c5bf00dbcf42613d99a859e9d2ac45c76`
`engineering/engineering-codebase-onboarding-engineer.md` | `1c698d4e9512d1d427d5cf764f8534488dae5e32f8b86c1e3d1f0bb62c3db64e`
`engineering/engineering-data-engineer.md` | `b09eea5e3096e649c0599b448b8e48db70e5f7d45f16f630b5c9deaf7be29656`
`engineering/engineering-database-optimizer.md` | `65eae661bdc52becc21df2e2f40785023c089eb5bad4ce8319bacb344ebfdaeb`
`engineering/engineering-devops-automator.md` | `ea09f7bf48628a20b1132cc45d1510933c98be441c35f7fa77fecabd9576147d`
`engineering/engineering-dingtalk-integration-developer.md` | `26c84eb65ce3751c39696832838d3c81b78c6ca586b110ca5f6d34207fa1a903`
`engineering/engineering-drupal-shopping-cart.md` | `a6aaeb25c012c9651f981d0a7617d323ab2f0b522ee78f9023586218ab6ff5d0`
`engineering/engineering-email-intelligence-engineer.md` | `35e50b8c7bad830313972aaa938065c9cef69b29f270bbc095f69aebae03d458`
`engineering/engineering-embedded-firmware-engineer.md` | `9f0e73007ba56460154c3cd0e2e691c69053b73d6fa816ed70c51bbb197abf2f`
`engineering/engineering-embedded-linux-driver-engineer.md` | `299ed78b0ad7e592c2014a795fbd67d821343d24e41fb4ceb45487fa8952793e`
`engineering/engineering-feishu-integration-developer.md` | `850dcd4cf628ce15b99ca4f82e47e1b03898222601dcc6ba762b8dcca12f4af5`
`engineering/engineering-filament-optimization-specialist.md` | `17b172bd9d62639bc9e6639bcb365f91fcc4815817696292dd7aaae693b0fc3b`
`engineering/engineering-fpga-digital-design-engineer.md` | `efd3dc3642485e3669d7b6b767c9a6a9770f1b4fa5b6adfcff6b9eb0396aac7b`
`engineering/engineering-frontend-developer.md` | `d6a428dd719c950ee0137fa4053ef0fb2cc9403aa2fdf5613832bbd4d5344055`
`engineering/engineering-git-workflow-master.md` | `b7059fff11988e6ab36355ad2eced5741dcee55188edbf9fedf798ab74cc2bb7`
`engineering/engineering-incident-response-commander.md` | `9ae5d1f2e80e987b5c9117ad06e5d1058056ce463ea05596db2852f1266e55b6`
`engineering/engineering-iot-solution-architect.md` | `30f2294925cd07f8acb9ee74057945d52a6fd01424bbc41397a91bb597b23d17`
`engineering/engineering-it-service-manager.md` | `d6569d41334e654652468af46344413eb41471c7fe4aa975491cac1479bc0b23`
`engineering/engineering-mechanical-design-engineer.md` | `017e724ee8b941993cc518d34d72f9debe15d6062e5bce04c9aa1ad4df218878`
`engineering/engineering-minimal-change-engineer.md` | `cfb57394f8aebf768a0bf8b8bb28f4436d0076d614500142755dc342c07d71d1`
`engineering/engineering-mobile-app-builder.md` | `0293ed98a5b77441c6a5681bd3e048424662ec45730b86f4b2d169c2337de9e2`
`engineering/engineering-multi-agent-systems-architect.md` | `e8b446a52efe49ffbf7f0eae182f49677b6922697682e89fbd3b7ec68eca5ccb`
`engineering/engineering-network-engineer-china.md` | `9525700edb247ea2e5e0dfeca3e73edfc87234062ca0af07aa095c452b98b0e2`
`engineering/engineering-orgscript-engineer.md` | `18cde8f38d4ee31e7067ac13b73311a571ee8817e7d212adc63860a6f2b642a7`
`engineering/engineering-pc-host-engineer.md` | `489109a2d6897c48e0f733c604e647aa8f69476d45860a6ce7d0de1de5ada476`
`engineering/engineering-prompt-engineer.md` | `e310c6fcb969222fc159c98a9150e8fa62a5f36034ed1c3efa679b631acfca7d`
`engineering/engineering-rapid-prototyper.md` | `6f8b18a7f612b0563401d4c101f64414aba12dc5e19812b2bf7329f7943eb50b`
`engineering/engineering-security-engineer.md` | `2d71dada5f2d938da90fbff1d6933b0c0c7775ef2c67c13529af0e80bdd6b52f`
`engineering/engineering-senior-developer.md` | `be10be0af5ae0af3e5508d57321610fadb14b5fec03607b5751ce6b1d6ef584a`
`engineering/engineering-software-architect.md` | `01ecf0e3481148362a5801956a487545d6259be59b329770868d362d3f87b4ea`
`engineering/engineering-solidity-smart-contract-engineer.md` | `f278652abb896ac1004c96fb503db77b58dc3a30ffe62c408cd4eea2e1eee061`
`engineering/engineering-sre.md` | `691c6c266f1ae54622b4eaa65e19bda021a1d5b5bb581ba1090bac6f54ea421f`
`engineering/engineering-technical-writer.md` | `736c31430de535e3bbbf3231244d537358eb35fbc8b5615887a69cf0534dac6d`
`engineering/engineering-threat-detection-engineer.md` | `f38c8c49b2351194f0f575472ce3c1ca268e80cb3f59d14c98437f5d34e77d77`
`engineering/engineering-voice-ai-integration-engineer.md` | `03061c19819ee0b7b06aa700bd6e0ff8ba2ced5826d274eb4936e6db6d166dde`
`engineering/engineering-wechat-mini-program-developer.md` | `d9a32063f86864f9c35f91df113d042e97278ffbe038ec92ba18d4eb625ccfcd`
`engineering/engineering-wordpress-shopping-cart.md` | `d11dea0d3726963baf0afac29a43b27d0cd17fca4e142adf84eea03683c8ee77`
`examples/README.md` | `4337886744e068c62fe24795c60aed43e82f13c56526646445c48e02b3cab3f9`
`examples/nexus-spatial-discovery.md` | `828bd93b1fbb2218e5eee049c618448be2e081cd46983e928dbecd7afcbcc2df`
`examples/workflow-book-chapter.md` | `a0382f06c7536579be480c737d56257c3247b55fbacfc6fdc219f870053a8f3f`
`examples/workflow-landing-page.md` | `05942259ec3fa56d32dc882e27646c75d69bdd8cb8333212ac9589eaba729bac`
`examples/workflow-startup-mvp.md` | `e540cc1c11e16ea5726dbfe2122e8832e020b865f957fdeb44a2216ab5873308`
`examples/workflow-with-memory.md` | `12d75f810271871ea4aec14feb3705ea51fb0bb2519ef1e651c68777475c2453`
`examples/workflow-xiaohongshu-launch.md` | `e9e780ed327aa2b880e507cd8a1fcca88988f705e787c61b03939660bca6d66c`
`finance/finance-bookkeeper-controller.md` | `fbe4902126de06e15571302e0bceb6dab578fd3d0f59f28ba6b2174d5db8ba4e`
`finance/finance-financial-analyst.md` | `78ff9736f2299d110f8d43fd0b699034dfb7106efc48a4f870b2ea141dfe7c3b`
`finance/finance-financial-forecaster.md` | `08ab01d7b7fa97e7b2212c63bfd4313413b44cf701af96eba632b63e32a3ea65`
`finance/finance-fpa-analyst.md` | `4ddde76a3dca27c7d72d7f4aac0f5edcfc682e4b2dd49643a13570f9ccef4ac7`
`finance/finance-fraud-detector.md` | `ca6f3cf2940cb04194eee3810f1e66c0ff564c2af2f31a67cf0c6e1b427fb266`
`finance/finance-investment-researcher.md` | `2523990756fb0ad34c0df86f7122a202dfcbe3556b4fa3becff08476b45e63b5`
`finance/finance-invoice-manager.md` | `d6c40d4173c4085e92bc7ff790b4aea549afb8d5eab6512319737f2590d208cc`
`finance/finance-tax-strategist.md` | `c98f7ca9cd66d865c423c0565c507e7f7c8300ddb571246b4ef02fd182519b5b`
`game-development/blender/blender-addon-engineer.md` | `82ba9fa03ce87df0b7f56a24be09a9cb7ca87f72cebbf3fbc6ccf68028baa1d4`
`game-development/game-audio-engineer.md` | `6c87b8879acd202a33160fcbaf67c9376b84f36831da414552faad73b1716ac3`
`game-development/game-designer.md` | `cca81fd1ab3f400e73772281232bb13e313b34d69aca4ec2ab8e40a5ec88ad42`
`game-development/godot/godot-gameplay-scripter.md` | `28f2c2dba99664776b312f06aab2283b7fb2f1560879c7f4ff2c9dde338d03c6`
`game-development/godot/godot-multiplayer-engineer.md` | `e91a184c87b4790cb8af837f32896f46126997171278785c442b38761aa904dd`
`game-development/godot/godot-shader-developer.md` | `cc8b7f9ae146497f63556ee0bc4896f800ad4fd9d4e32db8327bd6159c449780`
`game-development/level-designer.md` | `0e3206bf4bf2eee9cdd826ebb35bb3bdaff24f58e080bb9cab6f828552e76c56`
`game-development/narrative-designer.md` | `378740928ecb8c75de61bf910801e988c6cfacfc5186f092e08ec03d5d64077e`
`game-development/roblox-studio/roblox-avatar-creator.md` | `0f3ac964bdcff1be9db9fdd20bfeeeb6ccc7b770c80591691a40e49cda521023`
`game-development/roblox-studio/roblox-experience-designer.md` | `c76c3259bbf2b122419a667690407b9a3ac4b4fe2d54eab133e416224a778bf1`
`game-development/roblox-studio/roblox-systems-scripter.md` | `c46ec5149c07de1b535b72fdeff7b376cbf116406e59f0cf96b35a664a5e7c9e`
`game-development/technical-artist.md` | `cd3deb32f80601800bf0baa41bb38075c16fe44f75f1f058793f8230713a3564`
`game-development/unity/unity-architect.md` | `33b8b205d4675313f6fae5b467604ceb82f0b547752a6378425cb3ed85f7e25a`
`game-development/unity/unity-editor-tool-developer.md` | `70d3538b2ddc01f2dededb922a672cc3e35bb602d2223696ed15216b19246eba`
`game-development/unity/unity-multiplayer-engineer.md` | `98aa3daed72cd41e8d70197f908c17c879531a1ea9d93ab7ed7893380bd29ed1`
`game-development/unity/unity-shader-graph-artist.md` | `e42271213fb042d7b20bbd017d041a8f3a135efcbfb6e7c64a65532ca818ab14`
`game-development/unreal-engine/unreal-multiplayer-architect.md` | `344b8bcf777a6cb30f3c975020e009093ab3c7ce463b3d5c3f348ed1a9674e87`
`game-development/unreal-engine/unreal-systems-engineer.md` | `f22ff42bfd63bc5da9e471cf272a343e51947086c3dc8deb6cb274f9c5ac8397`
`game-development/unreal-engine/unreal-technical-artist.md` | `1eff2f97c1663ba7907f104c4354687573c671fbe0e594e97b475f399066f34f`
`game-development/unreal-engine/unreal-world-builder.md` | `4daa9e25e9943f44884d485829fcc71306f17b3ffd28afd0d3ab6b3a6d93f6bf`
`gis/gis-3d-scene-developer.md` | `1def6695dc5cb792ca4eea7e1bbfed0759c450732d820fc31cdf82e946ff1b39`
`gis/gis-analyst.md` | `4c2ea05e849679dee317b225497ff3269baa4f10370553841eb51125267c2c96`
`gis/gis-bim-specialist.md` | `b7ebb86bb664e8db8b6865150601f55ee72d6d4e127831fb800ee2a9fbad493f`
`gis/gis-cartography-designer.md` | `415b460e4d327ef1dd38ffa8ba5ae60fca4b93399be90851c5c34d7e698fca01`
`gis/gis-drone-reality-mapping.md` | `a5fc76bd25d9001399d4d20664613dab9d8197f45c757977ab8b33d3349522ef`
`gis/gis-geoai-ml-engineer.md` | `35ab1af8a6edec31011f74b3c21e88d54bc07cd3bcfc6d83be3da8c081cf2389`
`gis/gis-geoprocessing-specialist.md` | `e8b48173e858ef654cf9ba923dbde938962a7f5f9e05300e65d43475e318dc27`
`gis/gis-qa-engineer.md` | `0e4f0c5daa7532be885f87c02b928c96b74c0ed3c390ed992473471e7ea5d37a`
`gis/gis-solution-engineer.md` | `e53741315f8a39c7d7d00a76d985b1d7b4ce6f4d9a7ea9fcc0be2d62c38d8d0d`
`gis/gis-spatial-data-engineer.md` | `495dbb3ac039d015cce271ebb79e8236ba099dbd102692c9c66851c034e96abb`
`gis/gis-spatial-data-scientist.md` | `77c673205cc1a3873908bc7b3c7da9723df43e15abe0fd552e7026d8f8c4d8df`
`gis/gis-technical-consultant.md` | `ba7e621198ef2e98c8d750567625c4af9fa03e4bc820127c53bf1da3a6f3348a`
`gis/gis-web-gis-developer.md` | `ad58cc75ca8e24973a7dd14fee286d9a3818ed7662ec90ac9aa6de3242a04a7c`
`hr/hr-performance-reviewer.md` | `6fcebd41309f33189cc77f22d33a1c0dd6195cfd3af1064e2a94242a73de6e0c`
`hr/hr-recruiter.md` | `3c3cc9f2d0256ca8f36f6bc25f05209a4e1354099320914a72bddb4007b2333e`
`integrations/README.md` | `497acb01b68469fa182d2f56e105b5f3bc4ba9e0e633b9013b3eea4a927c0df6`
`integrations/aider/README.md` | `3e3f31ba521db394d350453bb6765f562c375db66d92220e77b13c92e72ac06f`
`integrations/antigravity/README.md` | `806941ccd528a978504f07603b51018394d680403658be6d31e81e7eadebe111`
`integrations/claude-code/README.md` | `ba0d40b544f661a88cc74eb2a5e6f9d03142b37da24f5dd83e8324f3404577b1`
`integrations/cursor/README.md` | `cfd87fa9e3e520030312af9d80374f4369e12b70913a719541a926ea2d50d535`
`integrations/gemini-cli/README.md` | `9f54cd4d8b4ef54a552bbd7ab06f79f1f9b3fd92aeb5ae8c47c720829af1b9ac`
`integrations/github-copilot/README.md` | `81c59088b32258ba22ae553997f7b9e9c2d33268871ab914747ce5d1015ec7f4`
`integrations/mcp-memory/README.md` | `e3252682132b4aa6f95f17fb4888cf8722b8bd9c747af403e3d6651b1dd57cf4`
`integrations/mcp-memory/backend-architect-with-memory.md` | `961975de8bff54a089ddc9b86dd86e8f3ac1a9c37aff9c68aed0afd45bfb5eab`
`integrations/mcp-memory/setup.sh` | `7fd9166f7410f3708486b26301166728befacde39fc561a492f3ce6e7c529928`
`integrations/openclaw/README.md` | `4a2a0d6fb6d2ec7a360d3e023ab5e333c3508e4a6d4312120e28eba1aef6d00a`
`integrations/opencode/README.md` | `4db4e70ae72fd43f5f5779bb9070bc12dc6b6167fb8b716f78d29fef5eb1ff13`
`integrations/trae/README.md` | `5ecc0ce2649837f879266d877c6934b9bb9ad6d945a49fe9511cd15dea661e38`
`integrations/windsurf/README.md` | `93b3c1dc2ac3c884f32f0469ada9f268a399bc7f423402b29ea4dc84482fb19a`
`legal/legal-contract-reviewer.md` | `944f34ffda7a6114f78c66e6f41d223e39b44cdcbcf0057581d0e542035eeae8`
`legal/legal-policy-writer.md` | `4bcb56b77d791122225ed4e4d6559dc172a0cedfa3328a34e0aeda3ef589a365`
`marketing/marketing-aeo-foundations.md` | `b8be54289956cd6c597c9d1c496d426932b9c96bf28b36ecfb04bd66b0d9eef4`
`marketing/marketing-agentic-search-optimizer.md` | `ea493d85f7cd26b50b6f32f5fab6b38862cf560e215853dfd781c87212a94da1`
`marketing/marketing-ai-citation-strategist.md` | `13b52ae43e1dfe0f0e6bba2688ec991d3bb446bcbdfb69eec91426830ee421ff`
`marketing/marketing-app-store-optimizer.md` | `f4a8733381af22b602dd0be0f5242a951c5c4c5386667a4acc950ce67aa3a4de`
`marketing/marketing-baidu-seo-specialist.md` | `3762fb2b474e5c2d5d1be127f0b5dd34795ed08cd495c5bb1fe3bedb1f0396ed`
`marketing/marketing-bilibili-strategist.md` | `bb718aaf407144b09105ca3da19a903c1cceedb7ac7f574b40f21bc3af4fe009`
`marketing/marketing-book-co-author.md` | `ba942ba173d458da1d9f61ba92506398de7b8a8b04c8adcc61faab964fbc640f`
`marketing/marketing-carousel-growth-engine.md` | `8522387fc4212079816ce687a4611928de28c21eca1f8e1c9317bdb86ad75b30`
`marketing/marketing-china-ecommerce-operator.md` | `e06351b302a7ffb86fafdd0c4afd23111c0a238424ed7ebee99a7ce60ba4745c`
`marketing/marketing-china-market-localization-strategist.md` | `3961b77c8f0878f9c88a8a13dfee686fe64ce74b7f2b775d4d769d9078e75bff`
`marketing/marketing-content-creator.md` | `36ef796f45931ba3bfa7e1360ab1c05baf06186a52f64fbfa3db1a00c4fad4d4`
`marketing/marketing-cross-border-ecommerce.md` | `ffd6f2718914764a72a315165b0dc65a8f86860fa081feadd8c138cc9ed3455c`
`marketing/marketing-daily-news-briefing.md` | `1975f7a1c834bfabc9b14e887f37e099f3537a5360b60d219372be32c4582915`
`marketing/marketing-douyin-strategist.md` | `7482d0758335fe95a6f6839e5efefeee4503a4aa83a1f1d07bd1b0f4f63c1de0`
`marketing/marketing-ecommerce-operator.md` | `15b6fdb4589ca9f8d60ad69076b58a6be83cc35b028fd7d6f5c843a3c4160915`
`marketing/marketing-email-strategist.md` | `8aaead77726c2a0aa8c9dd82215dae75c4f3d799e7e2be9c3a8049ba5c1aed91`
`marketing/marketing-global-podcast-strategist.md` | `c02a25f8cea3ee176caf045e9839c9bf40cb15e96aabeded395663d7ee68c5fe`
`marketing/marketing-growth-hacker.md` | `d0e6e05c1b6d506ec34befa796fc2020e071869978cf9f3645a72fc0acddbff3`
`marketing/marketing-instagram-curator.md` | `e4a2822928c5d4184473fa30555993abac09d3e1b9811bde005127d732f96cb2`
`marketing/marketing-knowledge-commerce-strategist.md` | `44abeb16eacd28ee0c364f04652f71c89f180b807c6fd83e3fb0879793b054cc`
`marketing/marketing-kuaishou-strategist.md` | `d2a1c3d9573227a147b4c55392be8b3604775140b43ee080bf27b16d9ac8cc6a`
`marketing/marketing-linkedin-content-creator.md` | `da9a933cf0e87b27ee4890f4f17d8eaaadaedc30939618d47860414af5f91292`
`marketing/marketing-livestream-commerce-coach.md` | `bc34e2bf9760cf432cf6186236283dac8f8a4bb2608efd7fe0b17784b23a7383`
`marketing/marketing-multi-platform-publisher.md` | `11161053b58bc5cb36db0efd7aa66479a9d7e45426248a5776eec8ffdafff549`
`marketing/marketing-podcast-strategist.md` | `086bb019bb62e0d135771b7aaefa72fafaf97e2001e1e9f7f6ef70da9b4f5928`
`marketing/marketing-pr-communications-manager.md` | `f5640642c00b535be155b5ba149f5c27a1943e3bc7c19f42f9cf49a8814c2ca5`
`marketing/marketing-private-domain-operator.md` | `29f03c71c98542a14c20a597d3aafb53be733bd71a3ca4c3118bd85571820b92`
`marketing/marketing-reddit-community-builder.md` | `10098662dfc977f9644baaed810cb2236cf3b319b5fed5e8d0dcf51edaf5812e`
`marketing/marketing-seo-specialist.md` | `3a6099d7c8982bbbd390e844f1b32c2c23c317feb233f2e9a9797b90cd3767af`
`marketing/marketing-short-video-editing-coach.md` | `ac43113ca1c14ca26587c7223ff40a729fb58f980c29cadd6a18607c850e2c22`
`marketing/marketing-social-media-strategist.md` | `f279560d1c785026984cce52506122a826a65c08b7e0d6b98cc6aa620ddd5ddf`
`marketing/marketing-tiktok-strategist.md` | `9983c817334692805658d71511b3dae148e5847fde01fc58dd10529b0d9592fa`
`marketing/marketing-twitter-engager.md` | `c09743e819777cea81c956b6176c0048f0e6c6a60c3039e1f8b7e730f6e89a30`
`marketing/marketing-video-optimization-specialist.md` | `be248c25319a7a8aa96052b7fbd2b5d55bc5411aebe76cc29b30620d5c0db385`
`marketing/marketing-wechat-official-account.md` | `840a72d99f8472bba032f671fef4ba5afc7b9afec4113b7df28e165f0572883b`
`marketing/marketing-wechat-operator.md` | `7311b34a39a47718cc32c80b2ebd9ea682eff2ba9cadf58f3cd1b8741c83a322`
`marketing/marketing-weibo-strategist.md` | `3033fc22b3edaeb1a0f8bbc68338e033fcfbdddeece4505b71605f9f79775e81`
`marketing/marketing-weixin-channels-strategist.md` | `871905f8636591766d8931951491599c5094687d81b37b9aaddff69893200113`
`marketing/marketing-x-twitter-intelligence-analyst.md` | `f2f23e59c3910c314d1a4320cb70b15231df63abeede7e166faff2be4c371423`
`marketing/marketing-xiaohongshu-operator.md` | `1d48333fbe54906ad76af8096b0a8a7d8bc26b1d12a3507e94f070d2c0b83d93`
`marketing/marketing-xiaohongshu-specialist.md` | `e5e6127be028d61a15b59839c629b4c19d2b7b61f33bc53efb29110a92544f5d`
`marketing/marketing-zhihu-strategist.md` | `2c5ef7bc1120e568d2ff19059cbc66fbbf97b18807c926139a9516c3b280eb0d`
`paid-media/paid-media-auditor.md` | `6a7561becb2dfbc5cb6483763b52a8f5873d7d7660a2b941ed86cdd8a2004014`
`paid-media/paid-media-creative-strategist.md` | `ff3a47b043540e4d47692917d04de77197c851238931f569ba7d6858b94b61d8`
`paid-media/paid-media-paid-social-strategist.md` | `9ea4e7304797f1c2fe5ad6861ba69ea12193965f031e2d62f6bf4a9bb98986a9`
`paid-media/paid-media-ppc-strategist.md` | `deca042071a000d8f51655b1e9c99064093cbeb7fb61f8c4f702f100393b75f3`
`paid-media/paid-media-programmatic-buyer.md` | `6d099b78ba10691c73b618a40bd7b33c19943eb0fc50e3c104efcaf35d077cca`
`paid-media/paid-media-search-query-analyst.md` | `b2aa125f1246ba3a707d8cfd9c2808c8fefbb8a455dbcdc600132e573458e132`
`paid-media/paid-media-tracking-specialist.md` | `f12ed9af997da991ce586644a5b98b8574b646d48e8ed635ce0ddc22a5778044`
`product/product-behavioral-nudge-engine.md` | `a8d0c3792c39f129c94a5b35db4063d45de4bf327f28b1b270f2f803ad063734`
`product/product-feedback-synthesizer.md` | `814c69a12eae4171e0061ad0688b0066f3f2ead02af659005eaf05cd9ea9d616`
`product/product-manager.md` | `96bc169270baef55bcfbbcd634227b12addb9c3d8b4b5a990fba93bfdc01477e`
`product/product-sprint-prioritizer.md` | `9c5ba43b4aa327bea65a1655d9d38bd436ebbc12eb24429aa1b751833a520bf0`
`product/product-trend-researcher.md` | `a79f830f4c9ddae8efa23e8066918d796b24b5f7a357ae2fd44b4898e6fc1003`
`project-management/project-management-experiment-tracker.md` | `143b82a8468255cef4a2b227a4313dad41ff1be408222e82ce7b912479b9a707`
`project-management/project-management-jira-workflow-steward.md` | `27046242b82d98e92fd11d49fececabf7d555d5ec704c22aa3485d750d8d9c4f`
`project-management/project-management-meeting-notes-specialist.md` | `a660a78d66658f99d238c619e34a4a77b5d920c82438c24da4e82787c1ccda1d`
`project-management/project-management-project-shepherd.md` | `1ff5edd13c4a57756f8d444c4f590cda8f05e532a50b4dcf673c27c7ac510e70`
`project-management/project-management-studio-operations.md` | `2c9746209431725d5b5a4b756ed965e5bd48d196d9207730bcb154936eb7cde4`
`project-management/project-management-studio-producer.md` | `f925f7d2feeffc1652c31f4d6deb7271e69c02d2c1b349e579b9655a1d1912f8`
`project-management/project-manager-senior.md` | `1e3dc02f8311ba60c648a1040531d847ba254a2ce17b49c0fb1205d8a226fe9d`
`sales/sales-account-strategist.md` | `9f497768a7a199052564461eef989c47eab91ed483ac109ac815cd1e896f130d`
`sales/sales-coach.md` | `cb8663615848a7b89ec3ad9a100b6d691d085f9676142e5ebfcdeeadb641b189`
`sales/sales-deal-strategist.md` | `44a702d9b0f3935e3ae1bcf012a9c38f445ec4d541b29112f14e38b976de49d2`
`sales/sales-discovery-coach.md` | `a4e34044a82e75079de0df545efb88298aee9e23b22dfe8b4886468ac6a6150a`
`sales/sales-engineer.md` | `6d517573e5be1a763d0a856ec9a4809e05292a3410f538b325f86accb91f3be9`
`sales/sales-offer-lead-gen-strategist.md` | `a616e666a1d8b157f464b901dfc63fc1d9b0e49901e93b99cece97ec49237f53`
`sales/sales-outbound-strategist.md` | `53ef1f0ef6bf3bfa333a97601e57eb24ca26882eddf983f01b3b9c0af740ddb8`
`sales/sales-pipeline-analyst.md` | `778db408857ab32d84f6ce15f3fa12b9787123330faec05b1303f41cd5c20f5e`
`sales/sales-proposal-strategist.md` | `d19dbd0bd01fcdff91e204bc1a676ee71c222875450bd87e2dc86b10fda5ecf1`
`scripts/check-counts.mjs` | `c6ac0c6b51d1ae9a204810a3addf04975ed3177d2fa03235df164eabd132217d`
`scripts/convert.ps1` | `f1a8c4580eb6378fa740db947afd78d7b4d50ed77ee1814204b743f92f78f052`
`scripts/convert.sh` | `4bdc8639351389586181d1127bf1c39d4119b9d652a47140d77f0582d2f03008`
`scripts/generate-ar-catalog.sh` | `8c0d771f7cc660823fbebf8a26536026cbcfcd379a3e6107d183601bd199cd29`
`scripts/generate-id-catalog.sh` | `5f2bd2f61e781744f423003fe9c2cc070da6b65ce7641f7ea7ca1e9660ec6d28`
`scripts/generate-ko-catalog.sh` | `70bcc340cdf12ef7994254456964c054a10794d6eea9f86f1766e6ffc7b313ab`
`scripts/generate-pt-BR-catalog.sh` | `3b686d390ae6eeb3e2b73bc9905c0ebf90ae9db9282409038e828f08fb4f9426`
`scripts/generate-regional-agent.sh` | `e837769aaa249c9f7d76c1aa35469a91161756d2c2dcf784b5501453883a2b6f`
`scripts/generate-ru-catalog.sh` | `77fb49130e31cb0089aa1268e583cbcd414b8f757460a6aeefecb6da95897748`
`scripts/install.ps1` | `507f8ac76de38bf6d74eaedc3943d52ce644754748948298d4a6558a327f1ffc`
`scripts/install.sh` | `21b4272a19b000e5cfd11c834168e48e9efc02833dbfb7e440f6348c954029bf`
`scripts/lint-agents.sh` | `c7b6c916d15783b630eafb338c50d3db110c77efab1ec06f616f12035cc7f507`
`scripts/sync-tw.sh` | `e2257a89f8a4f720c1e9ab3d15427503335d4ff954a33dcb57a9bb41320b45a1`
`scripts/translate-to-lang.sh` | `e5edc33279ddc7f8e641521acb51aa86631a3bba4755552cc405dfd30f13e39a`
`security/security-appsec-engineer.md` | `e25012c2802b21baadf931f8873a4e12ece6b2e507762ed55c265c51788d31f9`
`security/security-architect.md` | `60edc907d7f37da74e7655aa93eb4a7121ed3ba45616759ff75fa11967ea9c95`
`security/security-blockchain-security-auditor.md` | `3486f4f5d1b057eba8b6a02bf747da858b9ad2613c03cae23b70167db95abac6`
`security/security-cloud-security-architect.md` | `4b51e5c55223173e9d8cebc14c0f3b936a21605032872a0a696926dc520a99dd`
`security/security-compliance-auditor.md` | `48a8159482b11a4bb22cb844b7abda73adbad28e2b2a421b97a184ab7cc6b767`
`security/security-incident-responder.md` | `aa7a7819c7b933813adf721f686d6e78f81d3f40b4c4615e59a2f3ebd252da34`
`security/security-penetration-tester.md` | `ce52848e390712e059bd5e934a1ba3243fdde7b27ee290a917cc4580ef4c0af7`
`security/security-senior-secops.md` | `724486fe50f67eb89339cc4c4189a160d7338f6e07482e94875299a2a724198c`
`security/security-threat-detection-engineer.md` | `1992d6955058e1af6fac351daee1390201da971b6536751dd87949b6b93b461b`
`security/security-threat-intelligence-analyst.md` | `ef386e8e922030df5c3bc9e08c5d0992164893ebf9e0dd23ec91222a262c9d0c`
`spatial-computing/macos-spatial-metal-engineer.md` | `fcc9811000c74f4de43c2b389a40b61f58ff712d7263b15636303d9f2122315a`
`spatial-computing/terminal-integration-specialist.md` | `146ea5cf00386c4f953e2000e69d20e544bc9e8bebc1f9ffc63f96a5bc36bd93`
`spatial-computing/visionos-spatial-engineer.md` | `b64af4443f65aa6e4d6201e8ece262ac8571a45d87900ef25b87f81ce8d6e22c`
`spatial-computing/xr-cockpit-interaction-specialist.md` | `a90fea66a1b7b4fdc130e454e5854470b34b0fc67a719ff13053a80ade8e1ad7`
`spatial-computing/xr-immersive-developer.md` | `832ac971334e7dead2214dcee68778f5083df715222c37012c0b6def2b8d621b`
`spatial-computing/xr-interface-architect.md` | `ec01af400129ff01878fa259850826b79348943018453fdad7dbe8c52f4cfdc8`
`specialized/accounts-payable-agent.md` | `3aff261babadf1c9b5fe44b84324a3a7f8aacb97058e7b2ddcf876f5ee825bc9`
`specialized/agentic-identity-trust.md` | `e52c16dd1cb715db7a7c374d75df9af654c2d45ae73d8bb08fd94c51a7649456`
`specialized/agents-orchestrator.md` | `d64c9d8cb387e4cf11d638907f37b1f7adbe73ff63da4170b915c2a3f4213225`
`specialized/automation-governance-architect.md` | `01f5f622fb957e70571766eebfe7d1e6f668105eb00e431d67af53da552b7b72`
`specialized/business-strategist.md` | `75fb3fa32b2f8a9ce5d019ad363437e7dba0d96291bb3e66d1c46bc3016c5179`
`specialized/change-management-consultant.md` | `917904bdabd02602ed0adc4ead8da8b5e5230b937f39bfbdf8258a76a03aca7f`
`specialized/chief-financial-officer.md` | `08d98b1621857fdf5bb163075c4132a79109f8b3bc56008192ada7f0efec13a0`
`specialized/corporate-training-designer.md` | `5e86b064f89373e85195fd417c518dc8a292838768f062e0ca7af5ff5d07a778`
`specialized/customer-success-manager.md` | `fc7d444ca27d86b035cb4eaffe12f0ff771137785c9ab0de1034b29189486ef2`
`specialized/data-consolidation-agent.md` | `679a11ec2405ec4a10d948d3426d7d0f9416db72dcccfe9f04b8d70bd200b3fc`
`specialized/data-privacy-officer.md` | `7e371d4577cb362fc410481b13dbdfab16f2f5b8400295a3eadcff22982d0654`
`specialized/esg-sustainability-officer.md` | `e2361e76a969bdf605ea01153227588568e285b678ab16dc019e172a99aef790`
`specialized/gaokao-college-advisor.md` | `df468b153af911bf3ce566fb559e9a1f46ca774ef82138cdc9a8fe752a30b754`
`specialized/government-digital-presales-consultant.md` | `d78fa96aaee06df74518f6d9f74df7ef3c19e74dc6b048c6f6c6914a56e9f669`
`specialized/grant-writer.md` | `8c1a74ce895b67228475d9e742984b336bc58dd99eadefbda15ff10f039a286a`
`specialized/healthcare-customer-service.md` | `404ba72be1e59062bb3c8a400604b58f39546c0b78613ad2041dc3ca7f62e9db`
`specialized/healthcare-marketing-compliance.md` | `e41b1a7dbecaa4751740389cf6e0b78c72317e5d1fc0be0e81e1189ab11f0465`
`specialized/hospitality-guest-services.md` | `f69115b0a7c0d7313bbfe0f5382b87753e8bdafaf7c045d0c184f5c3f37fa041`
`specialized/hr-onboarding.md` | `66f104f7178b96d621363e95597e6beec8df573d4066010c19f57e0e88ef0b20`
`specialized/identity-graph-operator.md` | `2762e8563a4f5f2c896b6d10eca6016d3dae7b51705a697c8a30169bba4c9789`
`specialized/language-translator.md` | `f4d479f5561ecc6d19088f45be9187df6606059077e0907f5d2ad1e781f25abe`
`specialized/legal-billing-time-tracking.md` | `67cf632bedf2594aaaa2c3d3bb7a751a2368f979e0c3a635396bb49cef8d93fe`
`specialized/legal-client-intake.md` | `9535ae140a71a47c7a8dd515f59814cd133149cc80f08332c9917b252f3d4bd3`
`specialized/legal-document-review.md` | `14df59bace4a5849cb830324b49c0d5985cc39aa33f1361ef743dd4b6ea7f06e`
`specialized/livestock-archive-auditor.md` | `fb4b0af1e317db1b93eaaadb8fd3e616248328bb847d417e5b0312e769d8a123`
`specialized/loan-officer-assistant.md` | `2132a03a5856c98dd8196e532889d44644ebdae568c1593b55cd5152d05b1c26`
`specialized/lsp-index-engineer.md` | `5a4aa3cd4519f31e91c9d7d62951ab6a73edb3c40511b483fc700980a9e42457`
`specialized/ma-integration-manager.md` | `332acbe36b933f4c19fecaffeba3ce60eb3b3bdbbb1d030d608cabbfa6dc3d2f`
`specialized/medical-billing-coding-specialist.md` | `090a2a7a75cebed2772477f2ce62dff6c156f367cd9520b1cf41501b6ccc68f3`
`specialized/operations-manager.md` | `1ee84d9ff617394e8833013f56950bf1d4821a11a7d1dc900a706fc7732a1dab`
`specialized/organizational-psychologist.md` | `27069474c4e6e2496ea47fd918a1d49c7ab588c8de43e56b28884ab8eb238540`
`specialized/personal-growth-mentor.md` | `0688cd8c901b1199718b32a81712e9197e9f15f3e10004544475ee5c6315779e`
`specialized/prompt-engineer.md` | `96abf6dc6efb74391c27248b440ba605f6954510193b1846c626f98ccac56b71`
`specialized/real-estate-buyer-seller.md` | `c6fb58d8c81b32e1e97412cdef32286c8a3d7080a517e33496e031dc722bae14`
`specialized/recruitment-specialist.md` | `89eb116cace623769ff127658d7c80555a23680d98f6d73db01a9614af830029`
`specialized/report-distribution-agent.md` | `753bcc04c5e7ac0f4e519afd6d2a55d73df3f7a26d0ce89165e972cb23e082d6`
`specialized/retail-customer-returns.md` | `5d564da46d3b80449f4e7cd632871160119c14dc4f866631947377ae3c85597e`
`specialized/sales-data-extraction-agent.md` | `453423c9304112dd79792d96aa7e380636acc92363820ea581f4e9e766c2155a`
`specialized/specialized-ai-policy-writer.md` | `1087a58c40c8c9575d5f83e4d455b84af8f25e83c2cfc6685c3b1be78ec1e16b`
`specialized/specialized-chief-of-staff.md` | `53d3329d26442a5970ebbde607b4b5496228a6d1c721ce6d91461a3bdbb9d4a2`
`specialized/specialized-civil-engineer.md` | `b466e15e7ece6e14c91fce6abd7f999104da8cd563c48b9c3cf0c3cb8fc2ed36`
`specialized/specialized-cultural-intelligence-strategist.md` | `dce3d8028b7ac0f82ca0fc9259e0aaecd7acaea3a75fdec8ff3c9a7f9962dfc1`
`specialized/specialized-developer-advocate.md` | `993ab3f4757fa140a21a2fe2b72d057c2250bc56a8817401d64ecb07dc48c6f4`
`specialized/specialized-document-generator.md` | `16b0c4f08769afaa0d364218847022b9f61f0b6593029ec3ad3973913df9b575`
`specialized/specialized-french-consulting-market.md` | `7ac37291c9e50c6aecb1fb319a0552e128234abbf6ab9c7785876bc487cb7bf5`
`specialized/specialized-korean-business-navigator.md` | `da6cbbd75047485c9df8838c78b3ba1510c9224fdeb7b6f93d2879c89fed2eaa`
`specialized/specialized-mcp-builder.md` | `2dde17d530f6939106c614a67d26c062b2fe3ef8eaa4734c29bbe88845ff9675`
`specialized/specialized-meeting-assistant.md` | `0ba1c661201c4f7ae0cabb8929f354369da8e28b9d57e7ca89c875cf97613d8c`
`specialized/specialized-model-qa.md` | `ab5aa0be831708b1a26eca06b45456a540ed4e080847ef0e295cf73b7177254e`
`specialized/specialized-pricing-analyst.md` | `cc903cf5b739158df1993378d25c3715e35485567e26b96faa8cc702ec1e1774`
`specialized/specialized-pricing-optimizer.md` | `dea7e7f2cceb5b21a233b1b0631b4077efb84309a08ce0f45495e985e8545bad`
`specialized/specialized-risk-assessor.md` | `d77d8b944a399b70457811848590bf3271e1bfdeb79a493cca244bd8e41378b6`
`specialized/specialized-salesforce-architect.md` | `0702dbfddcae6656b48966bbdca4e68eeb794dec2ab4fca25f4b8bdd9015c7ff`
`specialized/specialized-strategy-duel-agent.md` | `c57b96aba5801b1bc88c5ccc3af2d04d0e3a88cddded9a381335b89fff33a59e`
`specialized/specialized-workflow-architect.md` | `c0fd192e8e4c7796c41d347f22c5398b3f2b5ec4d1b7a85f4159609dbaa75a24`
`specialized/study-abroad-advisor.md` | `e2d870d230008bec4fa81481c6e83bccca3ac14810907167c11e0bcad8c112db`
`specialized/technical-translator-agent.md` | `4611b405515c1631c22f77b30f87b76189e87a832c310df36c0e61c5d27e0c24`
`specialized/zk-steward.md` | `017f4fdaa85d8291652d953ea3f3bc71dd08ed3b32de91cb38b690e58520f170`
`strategy/EXECUTIVE-BRIEF.md` | `e718c927d2f2f10336dbe4cbdebb9d412d0ebc45f2be1e28f549738a379f9b60`
`strategy/QUICKSTART.md` | `bca8bf230ad9e7c1de931d49c97edf2599712a2636c56bef05bb99f2a848610f`
`strategy/coordination/agent-activation-prompts.md` | `ffd08c3b056195ec26e10adaeca2e6a1982e3bdcfdae63908cfab3ed0f738329`
`strategy/coordination/handoff-templates.md` | `f6dacce7c04d288f41f10cd8c8ebff349310fa3869223d6f9d686b29839397fd`
`strategy/nexus-strategy.md` | `ff15d5c591bbe9c1c35cde14d63ed1222ec9d53e513db977cad7b86afc27f757`
`strategy/playbooks/phase-0-discovery.md` | `e7093f971c3911ded29aef32cb5e61dd94627d953e9444a9b286bbadb03794a4`
`strategy/playbooks/phase-1-strategy.md` | `923d342d2f2a726298551aba5d25cc55f6093470ec18fdd01b661722204b9389`
`strategy/playbooks/phase-2-foundation.md` | `6c862c565a2f03145e69e4f0d3bda80d96c14a3834c96dfcef291474a8068bb9`
`strategy/playbooks/phase-3-build.md` | `2631e1b45cd884055c748d14760facff9d9876f879188777b724504a2d168d63`
`strategy/playbooks/phase-4-hardening.md` | `91a0ad6c63ebee7232bf00f5b48f1490450793532d02cee20555498f55bf04f0`
`strategy/playbooks/phase-5-launch.md` | `1ec78bbd7ef2d520d6af2f1364a793521d8b5e3a31b9a8b9e34e769ff4eb1d03`
`strategy/playbooks/phase-6-operate.md` | `e2a7a7a8c2a6c810d9ba71a724ce28b02e6a82d8e6a9d46787de5a3f5577e331`
`strategy/runbooks/scenario-enterprise-feature.md` | `5341e5cdeef92e47178bac24babcb9ee760b6b9e4c1bf7aad2a8fbb7935d50cb`
`strategy/runbooks/scenario-incident-response.md` | `d102b8c79d169bb411fea6dd66fab32fc864e83d2211a52db78adffd01bf2645`
`strategy/runbooks/scenario-marketing-campaign.md` | `54de01508d1c3138d5dad67f93437e8de629bf18485ff160dff46023bb3e6cf0`
`strategy/runbooks/scenario-startup-mvp.md` | `c3aaba5b90abf80c53cdb015694aefbee06babc907d5ae27df41653a0a9368b3`
`supply-chain/supply-chain-garment-factory-planning-engineer.md` | `6dc7f2ab35a5d7a1255cf691e0734274a15441b49d0431705d2a6d460c94b674`
`supply-chain/supply-chain-inventory-forecaster.md` | `6d603ba0dfa844243b6ef3f2209a8338545cc3b2c41ce247f057e23c1a50c121`
`supply-chain/supply-chain-route-optimizer.md` | `52bfebb9e640d6464450ce299fe160ce1e7c23345ea884e7c986961d25e2f285`
`supply-chain/supply-chain-strategist.md` | `6a6954c651a88577a31967f2ac47d4e660986834c254d72601fab2ad171de853`
`supply-chain/supply-chain-vendor-evaluator.md` | `8cc89a3e72c0f5525bd85a54722f7a4013fe800d060dfc20a15fd1ba5c0e1b74`
`support/support-analytics-reporter.md` | `50851236ca1ed8a14002592795b1a6ee6e3c0957779f0788910449538476c204`
`support/support-executive-summary-generator.md` | `734ad10478b60c9b554bc06eef70c7e727e861c16fd7061ff62ad72608789c3b`
`support/support-finance-tracker.md` | `4871b13c47029b935f9dbc606f5dfcefb283e91ec3d660c0bc3a539be5d0b2d6`
`support/support-infrastructure-maintainer.md` | `1811e0a6c37d0206a4837271a7b5af5b486e69c690cdbfcc6166ba9786281e2b`
`support/support-legal-compliance-checker.md` | `e5cec1a449d621c9857754c27703edfe5bca14c070fde50d84768d5213bb770b`
`support/support-recruitment-specialist.md` | `adf4319813dce63ab5e0a749ed91bd6bf63eb6d90b51f9352e48072e3aa6bec5`
`support/support-support-responder.md` | `6f67293675246d14c236c4abbe22dee0a25c906aecb2c3187d44909ea7c2d0a5`
`testing/testing-accessibility-auditor.md` | `4ddef77c85566032c7b6bfc048d3e68cf73b139002b76e445fe7371faea152bf`
`testing/testing-api-tester.md` | `109e840ef3d78add8cb2aade5815183a3853b3c25e04a1288e02d856c377baaa`
`testing/testing-embedded-qa-engineer.md` | `b7c628087be808dcdb628cbec732cc94fb498de8b5d7ebf67c2083b8a9de9f38`
`testing/testing-evidence-collector.md` | `10471bdc6334e5cd929676938153032781c5df3e30f244551fb8aa605a973151`
`testing/testing-performance-benchmarker.md` | `b57b5ca8efb40502dee8d44f59e7e0288aec3674e34f7553ade6398f87c07e70`
`testing/testing-reality-checker.md` | `8664df10397bb930985bc1309bc35400a6ca8fe294d974e7991d652a2cc43bb6`
`testing/testing-test-results-analyzer.md` | `521fd2c1ba8559d1fa4910abcbd3398c4d61dd8f5de119902989a8bfae404e71`
`testing/testing-tool-evaluator.md` | `2b5f84cc8e625b2db7b4ff3afb36e96cc346f2982f0419c05f9da5edaa519dfd`
`testing/testing-workflow-optimizer.md` | `c78a3364ac8b726cff3c3decbd26ebe59fb0d4d20a198937461d4c5e1b294ef9`
```


`package.json` (dsh plugin shape), `README.md` (bilingual facade), `LICENSE`
(added port line), `.gitignore` (playbook standard) and the dsh adaptation
layer are deliberately different from upstream and are not listed.
