Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15751474D;
	Tue, 22 Sep 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071904; cv=fail; b=nig7LmJsMIsXFgEwoBQtdSvotQ+CeNBQ2e1TPYUOAMA1j11ttwowq3GQoMlRhQ05q7RdwGeAo4nmCTvRd9Rre1RjI6bw4Gg/FHZbu8vBgIABGKNyxBh4+mWl+NDS3fELbkn2qQ9y9eQrwwL52YFMR4z1VgIWoK9E/TF5bA7Nxqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071904; c=relaxed/simple;
	bh=FiNZ4+8mRVtT7SEC4tm2hJVy8sivOae3HZB0HdaVWg8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=evlxILvyMgtEyktYZ36zQzL5Sabaruu4i7cmlV0ySTshU1kHX/77KBHPd7yHYmpBvQ9tl0FGrdYk/10n1Vhmvaui7w2yvDeVN7nv3xI9AMKs4EJilp3//9/go6vAG4BwZLXpXtQgJsm4VBXGHWUQknw84pXAqQYvq+fSrKpL0JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eQhxkufI; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eQhxkufI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuXP0ZyV8Q14vEm86+LorV0XHX9pmhfI35gA5qb45/Aw4BdgkWkqPuMFLT8rmv5DyatYKbZ4n5onXoKHhESNxdR6mz0JSoLnjWDTkKEX9asuk5H3MEaZZ3f15MPprH4ylE8SkZXzDm8lUNze9d9tor+uxES5m1cNOWUxK/Zipsl6FokS4L8hio67gR2Su3yzp/QA9zCyKiysO+0c9yV2skipq99FJ7PB+/yZhw7yfPTstq2/1+vsoBIwN/f7mmvbT2059t/ZT5XTs9MUq+0SEJooVDtLGcsLlDj6/K9FWajfpt0bt5mtSywtsMpz9LDnnbFh9Fc5Oo7gBX7aKYheLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTF2QhsovYDhSO0AUYpc23+xsBEOVjwVMZlfXzAbgmw=;
 b=p25pDgA9nGQhwXA0zaq2R2DVfFOTpf5r+8TgJGRSvKk18wmu0G6JCbXA3KoJSoFR+J19YpMyy7k3LcRDL3Tmfy/PI/CcDNODRhhl44y86j6yg17ptX/Ht+Pxg4spYh7ilcpBRl+Nb6Uq3/2R21mH8lVpl3XgkxTXOjLqph1dy10DtCYm2ckmVVBg0y+D7dD+Mra9jUeGLaHWc05/tL4GdgiASRelGI37AueAQFlJSk3+Y3cyQlIbDK8yGD6LEgp5PZWF3qGrmSFMsu+DnD44JpqYo5NQZxVJelBP/LN6brbMEo1qSc0SlZJsvSvF6HQ0Mx2AAEVgLM6cqtgxLXrjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTF2QhsovYDhSO0AUYpc23+xsBEOVjwVMZlfXzAbgmw=;
 b=eQhxkufI0b9MuFWqBeya3KrP5Q8fpIBJvKdoDRDaeZ2K/SYk1UWnDFSJtxZt7R3s12ABzW0D52IHnpzoxjV8Vu/BJ2lefJ2PF2+WfkX3x9bHKb70mTd8kRQ38SSOwln6Hg5Kx9my6OFE8QG2l8AmilcI2TIaRXSg8MDQG9DB34s9GgmZAYbGqDtOgwiB9JPpCU22TADMqzGVJrsM6dBhsyQm+Jmm/eG9UBOWizEHcF8aQMtS36SOOetXIKyj/hyrkLJJk16r0hCz8sFog3DqB+cclvbvsRfrfqETX/yR/lQpBQeRT3+CCYtTi4Q45jP0a87Jtyx0oFHhluXS4Mu8SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 10:11:37 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 10:11:36 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v8 0/4] cxl: Repair poison enumeration regressions
Date: Tue, 22 Sep 2026 18:11:25 +0800
Message-ID: <20260922101129.52794-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a18fe5a-3b8a-4cd7-c1d6-08df1891e2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3JBwhLfw2vaQ/Xj1n8pYXxK0QYZL/COwb2Oq+lPif9EkzAjZteYc8vngsX/yWJ3w7P/q131LUcRjlf6WRQp2P2ebQ0ErlZ+zu15y3qi8EUA1BXkrSbxJ4QlcBvIgbInYRl6iqrF1tdjg8kEOjiqvMqS6Y6ynpVi5D5he2Pd2/AeIrSs3SepMIDlFVIWQBxV5YO5Og5WRqNOMJfXp5cdvnB5cg/J/vhzex+o1OIqH4B2nCegYa/6Bdnn312CBc+uGtNR4HdmlChnJr14c/RWqefLKwnnptqE4xdCsf/Qjj1QCSTWE0FT+ik5MhIHY+v/MkMss3dQ8Lur+J4AtwxV9kIXsf+mFldiUHE5y6xchgJU+UaTZMvQzgEtCPMI17Wsc9OnmWZkzmJ54ra/ilftZNkunRKzNmevfXnSPQpDknMjCl2JkS3gqSWwaFzpmeINESCJoRkPeV4lC7SYnVv6ZtNBKpRSQ20+adyTV+NFpOE+xIWDLrf/0DOBUVa8/TMoWRd1WHHPkCysgGCIYWEYYVI8L/DnH1YemmB0Dogq8Ii1gHGqlIU10AodY7JVXiWricaF+LU+A9QGZ+0oPFo8Q97FMv2gwRVNqGYz7QbOCHFF0ubJMTjs9mO8YaEPwg0B8/PS4AqdrueoSxc/mvKoBuF9MlVRg+NVhEhNi9UUlqBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDlJek9EWU02YVZUenYyWk56Nk9iSHFtSER1S0pNN3U5RS8rTXlEZTJVT3Ji?=
 =?utf-8?B?a0ZtODRINFJXL0U4aVNGTm1sOHp1RDAwQTUxTmxYVG0wM1pBc1ZBNGcxdTk4?=
 =?utf-8?B?cHI2eGRYSkJkSEVOcjZOU0tQRWptR1FJY2hOZ3pMZ081REFub0ltckNkbk1Q?=
 =?utf-8?B?NU9kZEVYVG84Mko5dnFLbnNUbCtlRVVlRHJCZTBEK3NVT1l5cXhFVXltNldW?=
 =?utf-8?B?cDJFUjFUcWN2T2gzV3EzNGxoclRmdzJBMGtIeFFRa2tjMFhreXlQWlFhM00y?=
 =?utf-8?B?SEtuYWRYZFFsbElxM2pXbS9rQWU3eWgrQS85UTJoUldwY3RGVnhETFRPamNu?=
 =?utf-8?B?Z0liNVdYRkhycUNHZHVZYjZDZVUrVXFFQXQxWmw0RUdOM1VaQlE1Ymh2bW8x?=
 =?utf-8?B?VGlQdXA0TG9uYUJNUHY1aFQ4a1JDOUN5N05JZjFPaFRreGlHZS9uR0Z2UTJz?=
 =?utf-8?B?S0tHTmc2NGZ5SVVUSXppK3lOMEhpNU96MHhUNUozWFdDTjFQS0RVc0dvVUYx?=
 =?utf-8?B?RThBdjE3S1BqNHQ3WXlrM1RzbGk5dVR1ZlVucmJZdWVLK3gvalB4cHY0Y09l?=
 =?utf-8?B?K2t0MFkya2grV2FTa2poS09kQ1l0em5VaG04SmhDaW5pTVBUUDBGWHJ6Z1FY?=
 =?utf-8?B?UjFibG1vUkd2eStSUFVyNFBqbXpicENpaitiV3Z5OU5MdlFlU0hnTDQ2Rlhu?=
 =?utf-8?B?MTU5a1R1VWJSQ1RrckFEdXJGQkl3NEZiSUw4cUl2UnJLZjRGL3dUUUExQUIr?=
 =?utf-8?B?bXBDbzVuaW9xai9QWE82S2pPNzRiRXNiR2Z6UHRiWkZmOGxISDE2NmNlbFBs?=
 =?utf-8?B?VmNiMXdraURXMTRZVXNiQ1F2NVdIY2hwaGxkMHZxdHJQWktIWFh0ZlZYV0Vu?=
 =?utf-8?B?Q21KcGdhN3V6d0I4ZjdQcG9veTZzMEMvbXFpY3RmajVGQm9KaytudDBvZFpl?=
 =?utf-8?B?WEpGQSt5c0t5SGtRSHhkcU8zejZGQk54ekhncy9NRDNSQjE2RzVyRmRDTC9H?=
 =?utf-8?B?dm42MWJ1dFFYTUs3SUt4MVRLb1FHM29FQmgrU2Z3UUxZb25mSVptbFVqQXli?=
 =?utf-8?B?bTZUY3M3aTlTUlQxQUQvREg0ZklNZXlrdm9Xak9wYUJHQmhpdkRCU3I2Y1po?=
 =?utf-8?B?Mlp6VGFjY1czVGRZV3hTUldxNjB0RDE3YXJVb0pMVkRFb2cvWTFzeVZPWkhC?=
 =?utf-8?B?Y3hjYnRxOW5BdkpVMlFLa29RM09ieEx6Y3BZMitmODBveDFLcXJIQ0kvSk13?=
 =?utf-8?B?UlpJT0QwaXNWQVVndk4vU3hwbURQdjlpUG1Fa3RYTUY5dExZcVNveURvbzFs?=
 =?utf-8?B?WUVWakducm11TUNjbm1uRzJRd1dPSUNjWEZ5M2J4OTQxMTRrUzJlQXE0TXZn?=
 =?utf-8?B?Y0xxYkhLUmMvd3dyMmIySFdHdE9aR2h3K0VVV29md2xVemE1Um5McWlOTWZr?=
 =?utf-8?B?MHRNRjF2QzN4OWc5TGJxcWtKY2V4TmdPOWxhQm9Nc2FpMVZmMWNEQXA3RHZL?=
 =?utf-8?B?elVXT215TExEdHRQd2M3Um1Ca0g5K0N5MmlIYU9CWVFEY1I3NEcybkhudVBT?=
 =?utf-8?B?SlJaS3JDVUc0SGs5R2pybS9QZVkyR3U4S09FUDh2Vlczb2NTOTZZNlp1cTUr?=
 =?utf-8?B?MXF6M05JelpZRk5LTFdWYVpEQlRkeTFKR25jM1YwK3gxdnUxZXY4akVhYjlT?=
 =?utf-8?B?L0QwNmFFRXphNTJZWHI0bkg2blBSdFUxU2hpODhKTWhEcUwvbE1SNTk5aGNx?=
 =?utf-8?B?T1pRMisxcFBTR0t2eHBoYWdRU0pydDBmQVU1TEhiTlVjZFp0STBQVkE1dUhw?=
 =?utf-8?B?QlZuOTJ5MTk0UndxbVQ3QVdibi92TDVST3A4RWlMVHFCQjdBYWUrRldWYnFF?=
 =?utf-8?B?NDJJT0VKSk9vTnE0ZGJRL0JEYkFEcG1lOGFxVURqS0V0WEVqUWl1akhwaHZs?=
 =?utf-8?B?OTkwS3ozc3VFT2pQN0phUnBPNURWMWxvYTF2bEdDUXhFQzJqdWZES3V1MnJj?=
 =?utf-8?B?MGUxVVNaalJ1anE2dUJaRTBDekxCcmZlQ3lrL1hyaFpqdnQ1UmpaOU9iODRB?=
 =?utf-8?B?azhmSE9mYWlJRU11a1JwZUl1azFNMVo3cjF0clp2cW9UNEg2YzNjekVUMEkw?=
 =?utf-8?B?UmpmOXBNMlg2YzJodXhZRDUyTi9xZU03aitoRUF5Z2txU2lVbHBlWC9JeXRD?=
 =?utf-8?B?VElJcHN6RG1HSDBWNE01Q1RadTAwYXNON3RxWFREVEtvMlA0c3ZkcGtEcHpE?=
 =?utf-8?B?dmdaZldDalo3UFNiYXVZbnRJYUJJM3Q0UVRYN29CVlZ3RmZpTFljYjN4LzVF?=
 =?utf-8?B?ZzhWSTVrZ0cydGlCQjY4bTdEb3FXZWJaZ0lWNHA5OG42L1dRMjJsZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a18fe5a-3b8a-4cd7-c1d6-08df1891e2c9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:11:36.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xA2Z1EKgJedx2nzpt4kLTBhWODueEkUoy1xKWN/2tYsPg7xzgzKhlHdkj50AIZCaV5/2+tpd+MGFIMsInyHyTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

This series repairs four poison enumeration regressions introduced by
commit be5cbd084027 ("cxl: Kill enum cxl_decoder_mode"). It groups the
remaining poison fixes from v7 [1] into a poison repair set.

Patch 1: cxl_get_poison_unmapped() ends the partition walk when it
encounters a fully mapped partition. Continue to the next partition
instead, so unmapped poison in later partitions is still collected.

Patch 2: the unmapped scan tolerates -EFAULT for RAM partitions but
leaves the error in rc. If no later query overwrites rc, enumeration
incorrectly reports failure. Clear rc before continuing past the
tolerated error.

Patch 3: use the ctx->offset handoff from the committed-decoder walk
as the starting point for the unmapped scan. Starting after the highest
DPA allocation leaves ranges allocated to uncommitted decoders
unqueried. Resume at the committed boundary and scan later partitions
from their beginning.

Patch 4: cxl_get_poison_by_memdev() can overwrite an earlier partition
query failure with a later success. Stop on the first error that is
not already tolerated as a RAM -EFAULT, preserving the failure.

In v7 [1] patch 6's review, Jonathan also noted that
cxl_internal_send_cmd() documents -EFAULT as a hardware error.
I will send a separate patch to clarify its mapping from the Invalid
Physical Address device response.

Changes since v7 [1]:
- Retain v7 patches 2–5, renumbered as patches 1–4, and rebase onto
  current cxl/next.
- Drop v7 patches 1 and 7, which have been applied to cxl/next.
- Drop v7 patch 6 because the zero-sized HDM decoder series [2]
  already fixes its negative partition-index access. Specifically,
  commit 00f9ef9ad1ce ("cxl/hdm: Allow zero sized HDM decoders") [3]
  guards the partition lookup while allowing the decoder walk to continue.
- Expand patch 2's commit message to explain how a RAM poison query
  produces -EFAULT and why that response is tolerated.


[1]:
https://lore.kernel.org/linux-cxl/20260902053839.25595-1-icheng@nvidia.com/
[2]:
https://lore.kernel.org/linux-cxl/20260914090858.19181-1-icheng@nvidia.com/
[3]:
https://lore.kernel.org/linux-cxl/20260914090858.19181-3-icheng@nvidia.com/


Richard Cheng (4):
  cxl/region: Scan all partitions for unmapped poison
  cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
  cxl/region: Start unmapped poison scan at the committed decoder
    boundary
  cxl/memdev: Don't overwrite the error from an earlier partition poison
    query

 drivers/cxl/core/memdev.c |  2 ++
 drivers/cxl/core/region.c | 13 ++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)


base-commit: f2e9991100c903ec2d8eb62c3a1d6e0b9c67432e
-- 
2.43.0

