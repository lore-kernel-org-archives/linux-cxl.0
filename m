Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BB477E4B;
	Thu,  2 Jul 2026 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983343; cv=fail; b=OgAnJqXX8tRh7fUBjIg0NXJavWA14/y5kyOASUrsW1fb4A1nAQ3VCOjIXvQNIswJLJR/cwhS4qR9PdVhjsKv/+EanN09DK3/Aaam5aJqRm7CZTITLD2qv/UbyDT7Qc7SiC0xMeVMd5grVOp0ZIUWQRQMJLsmuSfBAGWU3ojhYJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983343; c=relaxed/simple;
	bh=SC04Z18nFcb8ciMwFWSHsqyKVjLsp/DBHhtoUYJRcyk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bjyBJK3NmmVt+lNuwNUQW8x1Aa2uRNT0ZPYAYsV3VPl9LmdScfHzljJScZGpzjmuOp3z2+o43m1YtuLgVdVLTy6+GRxLeqRCfokgopNBjGUOEEBzQWvu40auXSRCDPU8+XpqRy0cVmOZjDEhqQ2w68gVIOKDL7X+YvI4vp2SFuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YCH0jKvf; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YCH0jKvf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxTNaF03H44lsHY01nrzd+4VnpfHnY+nszpGX/7qN1AUKs/3060mcsUXxXGex1aWD+ophyqbpOiOpYq6zI1fUTkuxuOV3ulI95KwO6z3HvupcUaWkH2CGeui/1w7mxAL1JbFgDRb2DF+QvKM3S/aCfaoU0BvmeSClPZIwZV0oQ87tUOCIguG0dy4vFOemf9C0jrTmI4x2JB3/u1BopJFPIaqjMpe4pYxg6mgIBYej+bGEC4j6VOSqAW2Vnao5XuR/d6wTysQORtzhFV4Moeo5R+0VpUvuoUW0aMH8ClFwB98rCbNNQgdDFi03X7XrLt3R0HU793leBNTEEi9LpW9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXRGZmg/a1CrU0QqXuR7zpVUG+10pPvgyltdf1SCfgI=;
 b=D9NM3quXqEhohXYKdJMJh6xCneS1FKnGiwP9I9X7dRrbpBCsZ5WUddeAIVNDvEBdBXRDj7GnVf4y3mFdi0FKNV3m0zHWp39VC69b4FMvUDXKGwyJxIR9icNWx945FXctPBhBq1cRz5ibx3d1MxW/UES9oDa3QLZPlu/x7+QxFHX8PG9OP6mLsuTUjviWNCGEyZ5fwda0tRjI+geHKZZPoi0NBpfD+kV6ED4znWj0fWs/Uy9cUYxOIkG4He8A9K3+U67gMMW74BmeM4eqTXBzTJ7U1Zl6VddzjqmjPfB0ccT+ynkgfWb9oWTuI1tawMhr09MoxI2sfGPeuNb5jAHaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXRGZmg/a1CrU0QqXuR7zpVUG+10pPvgyltdf1SCfgI=;
 b=YCH0jKvfejmKfMbd7BC4DpVuk+AsqJ9TtqzwfjCdGZXNnMgBl7C3owlvZ2cRSsi5lVvE6rvbTareDftVe6Vxq6jH5TukNcPfIhH5GuhP4TJA6V3L33VGojODcvBlAcBDAJlp+Zx6gST224dG9vFtUqBA4F2HGkC88Oj+XruavdykY8e8/TNQew2ZThfVIpLbz91Dq4KXgHjJkl8A9npnLyPg411iI8iv0iqX5Uje8+xSqPm6qn0uqpVZYGAI6567N3EwUokar/BokK6Qt4oh/02aW/0U2VANtqn4/bPRpK/m96Z3yc4tl2c5kQVuNtvrpCHGhRIsXsEXBszgBYzruQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 09:08:57 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 09:08:57 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2 0/5] cxl: Sashiko bug fixes
Date: Thu,  2 Jul 2026 17:08:44 +0800
Message-ID: <20260702090849.47501-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPFD8936FA16:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d79ea9d-d63d-4788-c5dd-08ded8198bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RWVryWG81M51EaGtqs9Ej6s5MWnjUSh4m/nz2xDoq+NGRaRygmdswfgLEEUDcIsRH68xxUCD3xCRTYt63ekNOJKDYtBClPIZgUyC+E78QkVgsNIXJeNwTWEiXis+EI1CccSc+tGY9i6JvLZttY6pqqw5YnpLA6RSwsRMvKT/wffLe8YVdoq1eE7FAcVUz1wyIQW7f/dYGRAA0hw8bkVv0BvDFOzgmzFIv13s6OaS1fwCX3wjiXLOQyHUcuZ1XGOzVXNG10ygH1iOs/NVQevR/5UI9btIzuOVkbPdnK88YZU7HRQN/tAM0lvQrkC4TJHGXxu++iRAVA1HZv1PyUB8AJgHPTHyD0CEZx67Nw2qYCGl6O72gdUJsk7FFDFvue02VKFl2lbp38xXEokNkVK3r4X6bppSl+7ujv4niO8XQ0BRJRXAu0HpvwE/EZtFqkhS9nuhjU5rQBr9bCnkJDsmFOy15qH/59PIClFSIm+B8k4SGhpMuQO1vVQwtLkaKVdQt/PhQafO875TJm6eq99h1twJXls+E+wt2g/ow+qchCzklUd6euQnVc85Yu6/R8kEJXSggVpkI58zAgSuRCfl9qNK/fxtkhQNiAjTQiHOqdoMxb7Ap003PDE62UbuNWoCG/uibN/u989E4Pgdm2bLwity0hCNvZ2fK+T8KpzeBjI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DcwdSAbRc8r09DHV9UglqUM6d8xXLmYdFt2q0ksNkiO4mdM3J7x/YNA+N6q4?=
 =?us-ascii?Q?C8VYPnRmG0oh2Y/UUF3DmQIMqMUurmUn3MAJupVoIdxRSRhNCgYgo5Wv5mgh?=
 =?us-ascii?Q?+jItQPWeFs0flo4MFIruHG8T/4pKuEd59N30We4GF8jaSQXxJLIPUsUtSvJl?=
 =?us-ascii?Q?4xNFnuE6w9oEF4CHOu7umB+Y5M0jevcQ3cryRn8i30np+qNP2bwPNa+lEbpL?=
 =?us-ascii?Q?LTno4OaPCb/1hD/aw2jd283ilM6cOEYgboO0v1k43eM8Gykhx8b+VRp/+ztO?=
 =?us-ascii?Q?6w4dYSJiIJeJgqXL46x5ckG6tcOtrNTaBvIbdOJ6xcEIbzHosC7cfXcjAbT6?=
 =?us-ascii?Q?tTN0hXw/K/DvgC9gyF9XN+hvCD9wIKot13m36WBlv9rKexaCPIQg2npop7XK?=
 =?us-ascii?Q?JdVyLALB4HUZrhlAGlDrykOpzC+68NUEkKBih0KyunI3PhLBXWmZYugGMGNv?=
 =?us-ascii?Q?699bZHYTLFoVB8+DOcSIsGhvhvr4gt4itnBvjvKuKZLeCI2o8ZJXIsjOyc5/?=
 =?us-ascii?Q?56JXzUQGPJkFMWct988esXhmuU4QQcMzPQe21tl8SVU8oj4PKEjRY1lCQoqA?=
 =?us-ascii?Q?MD34K3XJrnDfs9XDYNM1VTGMv79gtvvdVJTlErYeeRz+84RP+DdEzutnC22h?=
 =?us-ascii?Q?W4BkIPGj2FaNpSCQBoxNI0IMMR2G/baIQ/euMvSqXaTI4rA3qKWtM7NtthiE?=
 =?us-ascii?Q?CR/als5KfVZ0k4LC+AwzXX2gv3+P+cQ26k/EwQJayPACBANwdiZ+LuXppwz8?=
 =?us-ascii?Q?r8o3MujKENX7sQsEg76xvRZEq4Grwkwjv9fIefJE5Pd0r3i5k0GYgFt8+XG8?=
 =?us-ascii?Q?EDK2jc+JKuuTTgx6mmugfBn6kLC4B7Vs8/gTxEpEncmOvELu+M5AylJs4CAS?=
 =?us-ascii?Q?tJ6WGaNcw0wA7hfOhLVxXBayDO55dwOJXZia+mKKEbDwyyKNJaFVlJiO7Fbt?=
 =?us-ascii?Q?Bf+tJ3HGMemZ37b1o794W0MrzPR0SQDkqF3k7+pASM8k2sV2zLUclWvUEPHn?=
 =?us-ascii?Q?dN1JWVTNyDBuBfX2nXYkRB7doapz9q9W8NbhAYu/RU6Wj+2NI394gtQ+WPT9?=
 =?us-ascii?Q?uLWntFaVV+5klGWVXWvaR2xY0Lmd0G4H93eNYOswJAGXPQC1a2YqWPeEUAQ9?=
 =?us-ascii?Q?7e9+iRTP0CfbHXHsRtcdMpVNLVQP7N5N+HjjNaVGIWdB/pGZbCAInYKslEAQ?=
 =?us-ascii?Q?eQ322CsBJ+O3emvuYnDOW33JkCrFSM7wcnxwj0CWHl2Vq7KkL1tMXv0R/F5c?=
 =?us-ascii?Q?cuvuZcRDmN+/73GjLPJeyzQ1Z65f6o+q42eWA3I4PemaUg/9KvFXfZIL/lWO?=
 =?us-ascii?Q?l3dn66uFsfzmD6d3rDoPPCcXfOFsR8+x53TYGsBeaVsHLfyzXxCV2bcjvvHr?=
 =?us-ascii?Q?EtS0U3xWfC8Zh1sukQsv3lCvRS3FT1Nt1rmJ6fbARVpl0Oh4oj5AxnCPfgBq?=
 =?us-ascii?Q?nQJ+g7Dj1AIFEd6UJ6b1NdzueqIYQuKDVMSW2+PaT3JleWmz3YfZ2dQbN/Bj?=
 =?us-ascii?Q?gIl8yZ8S4CoD6YDte2i9zsIs+a/SLsl8lKTztedeVoJ/thvOuuzqVXOMb4qA?=
 =?us-ascii?Q?i6va1Uxio3eCgOqr3FDcRjr3Yb4PPH0GE7uSDtK+GGooZ8lwzRg8pj31t/r1?=
 =?us-ascii?Q?7nabO5vK1iA2eAwsfmeqZQvkgREKdc0TSDnAYHlFcCFSKA+wweTVqm7PYmO0?=
 =?us-ascii?Q?Qln/WYMZQx32+S3oc82MsRHVpH3xi/ftqNEcZ6jV6VdJfDxc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d79ea9d-d63d-4788-c5dd-08ded8198bd8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:08:56.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV0I1Ywe9bv/Zo9sVeCK5xKx8CXKL7yjqKfX1cr9Rcw27+tyP0yvfyk9wm1DKkMamTCYZtJC1E40mtHJa6e5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16

Five independent, pre-existing bugs in the CXL core, reported by sashiko.

Patch 1: Get/Set Feature stored offset + transfer-size into a 16-bit
field via cpu_to_le16() with no bounds check, so a large offset/count
from the fwctl interface silently wrapped and steered the device to the
wrong feature offset. Reject offset + size > U16_MAX up front.

Patch 2: cxl_get_poison_unmapped() aborted its whole partition sweep on
the first fully-mapped partition, silently skipping unmapped poison in
all later partitions. Skip that partition instead.

Patch 3: the same function tolerated the -EFAULT a RAM partition returns
for Get Poison List but left it in rc, so a benign fault on the last
scanned partition surfaced as a spurious read failure. Clear rc, as
poison_by_decoder() already does.

Patch 4: the same function also ignored the ctx->offset handoff from
poison_by_decoder() and derived its scan start from the highest DPA
allocation, so the DPA of allocated-but-uncommitted decoders was never
scanned by either phase. Resume the sweep at ctx->offset.

Patch 5: cxl_get_poison_by_memdev() overwrote rc on each partition
query, so an earlier partition's failure was masked by a later success
and unscanned poison was reported as a clean list. Stop on any error
not tolerated as a RAM -EFAULT.

Changes since v1 [1]:
- Patch 1: write the bounds checks as size > U16_MAX - offset so the
  check itself cannot wrap on 32-bit architectures (sashiko)
- Patch 2: commit message wording fix (Dave)
- New patches 4 and 5, fixing the pre-existing issues sashiko raised on
  the v1 patch 3 thread [2]

[1]:
https://lore.kernel.org/linux-cxl/20260630074657.43077-1-icheng@nvidia.com/
[2]:
https://lore.kernel.org/linux-cxl/20260630100022.A621A1F000E9@smtp.kernel.org/

Richard Cheng (5):
  cxl/features: Reject feature offset that overflows 16-bit field
  cxl/region: Scan all partitions for unmapped poison
  cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
  cxl/region: Start unmapped poison scan at the committed decoder
    boundary
  cxl/memdev: Don't overwrite the error from an earlier partition poison
    query

 drivers/cxl/core/features.c |  6 ++++++
 drivers/cxl/core/memdev.c   |  2 ++
 drivers/cxl/core/region.c   | 13 ++++++-------
 3 files changed, 14 insertions(+), 7 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

