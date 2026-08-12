Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE043230D;
	Wed, 12 Aug 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533681; cv=fail; b=gl70aEmRNAWqhhF7ut1DIK0LeYeLfGHSdnaS6p5lvlrWYSS5tLqL7j9Oh+Rv4UeVoWrZP4R2Kk4/M3siO1rJ1QprdSvnZSSkkBQpkEoB+lEDRM5fGKX10r9eaHZWcGCJ8DaxvggV7k+ZCv6WCalBqBUovIaVM0E7u7G1oV8OwBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533681; c=relaxed/simple;
	bh=p1dxGeET88azVDQ2hwQQTX6yAcaorjp2vFEG6ZpGEWA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N18SOpuzJdLvrpnoMS5i1PI7QFyeOiN++rFLr/gywhdQL6VKExm47i8fKjrV8eU8RsGNUpiiqGRbp6n7KxNLz/AJauSwL8VwWNKPlUrEwY9fzgUjc2BMGIeAqIzQa+it+Wq/zPvaAE8nQuD8cQRdA2ZDL+mNWO0Is+mu9L4mZMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aOCYBvE3; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aOCYBvE3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpxTRKxzNFTPSh1z1sq0TFMk/n60gx9yIXw44UWi/PXOoic4sclTZDyGpQxaZmCIWPjbjqcLRm6OCT4ojlGCeG7tv5jUm4MGrcClVqH+SeO5lBm7KfeExTEggDHY0pIVXZ/pLIH0nTKCc/NASqWoDlFe8d0kUdLz2EE4uUwKxBeZ0bC+MOMPzNuGL79G53cblu5ehjKU9/7SpYqXHP9PSqy6eosBZyZENSalS50/XAUw7qixyIo2w1VXFUAbhcmTRcnWV8gaS8QuHRIF3i2GqA+xa8VEpb/ja+YfQXtIrNATHDxoQXih+QVNkOr0/4QyTJwkskiXuB9sVegp2CQDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N24giod0xJFr9S0O54cBkYvHH2pqXz4W6u4vJ1llLBs=;
 b=pM/IDEU8SRrrRISyqDCsivpXCankv0UBF8ya1Q7V3V/2xtveVTWSl54etSOo8vT+I3m/C/APkrtlYQ+TtN1z3g0OyxK387rwhEWBeRzuPIOLlUxPxmonS6wcBaCZLatTGEciZugRTfApM4/sT0mP+HtZ9tjIchCA3BIGvWhegaPBLgndblMtKl8Yn4AijjQc8/rjIMYk1TptdxZFRpXwYyDDYQWJ76bYFIrYZdEz26OM8IqO0weLFOw3b1yADfOyaV5VnsdkYWm4ReLIHjKTSxAgtk5If1wi2Cv/4kCe8n3QhiK6ZkdP8nwZvU+OVa+WqI+1ZdjBgdyCE4oo0+7MZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N24giod0xJFr9S0O54cBkYvHH2pqXz4W6u4vJ1llLBs=;
 b=aOCYBvE3p4hiaLiUnM+YPHO3cCZ8Hcx+cRX6m+2TbeJBrBFiSAQ8fjDRGT079cYSl2I/Op+tdjJqNzE0kwSH75v06Te8QqPT2dzVOS/OcXLsfU7CGl5Fme8YL1wvNEtWWANKFzGuamlEGifqBka1fTlbQX/9O6nJXvgSYR8wPBFy+waMWrKf891SVDQtesfMpXdkq3NFzvxW6cCVsVT53eZ/GXdZxAO1V6eADWRWC0u/K/Tkn59cXngT1KNcuu22Ya5iXPrdSExobSDA+zssSW6kRI4LeepqBh+5fp+jPBi1uLDiXe6uuL7sblDeXg1TJDSNnyk0P4taNGLttoSpTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:21:15 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 11:21:15 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v4 0/6] cxl: Sashiko bug fixes
Date: Wed, 12 Aug 2026 19:21:01 +0800
Message-ID: <20260812112107.56181-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0019.apcprd04.prod.outlook.com
 (2603:1096:d10:25::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: e2119aab-42c6-478f-efc0-08def863d276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	uhIhwIVGoJuuTZTY/A4Xr/zlEi/09nNxfQu1CuBX28iABfeI7P4+sxMujMaTQpouPs6JhO0Q1sBbovEuG/djPhIGBqp6+iL81ZgDFaPHYptB8zBXWxm45akbYQx5CAHP+DVFsIDGSnrrDKTwI0zoP4AN11Plsnq8s2gwKgMogdgtfVpPvAluhNrqPaK6qtMfD63JcZ6CRCFPxEIhM3/nT6qEb0WFbBfpxDj+pe72n8jxRH3S2JIa4lHixZioE6pZIJLGPcdVUOZonckMTOEI71yPciTBRz9DkmVklHvcvC+/gypbp2yIbfOxek4FmRfM4xZHbIGB0jWlHffnVaKE+CtpJK8CTbABzxxGPrtzqK05u9cqMwkWNwQsk4LQuIu7lkT2PPpUuwFM7zMT3P5nUDtPu8x3EHcGnGKFC9UjQQlmoEUbEm5F0Xry3gpHsSs6YG1gzI5SN8wMuO4dSlfoS8Ywx4vDlbchVDkCiRN0YXPXV9LZYxh3EgePkFKqr2xxHCtKAFjDH7QS8Y1jqqRpUmRALv6KOc+IM4HuG+DW5numqB9lFVv7DcHmV9XebHcw99IiTnLNrn7NmjR9GBaJ7yTbcUWlAYisfBrQI4n0kJ9aKJwG0tZaBgWhZhxm/cdagir0pV/lkIlN0oyMyZOktawn1ysMA0oMMZUw5TmbRqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DK0rprBrbaexCrZ7UK4GgMr54I7b3/6E8bjgS0sXZ7EZlSjAm1wLjkdUhH9S?=
 =?us-ascii?Q?dLzL2nVYxe9LChTztkAtkAmRXEfzK8lyhnDe1Vev5Az6662UMS7Fjcir1f5P?=
 =?us-ascii?Q?fpMUtOXzBMwzRSi7ceqVL/mJSu6OFKnIxa4hLz6Al3FdlTnAlg+v6FS6YR8g?=
 =?us-ascii?Q?llspfe2cDPAEazMk5cf9RI2A5JUPSfL57NhkCQsSZAa930Y81W4KSIBd0Rvk?=
 =?us-ascii?Q?8Sxv2cOj5m3AZOGTAc2pbwxbAAxWYSPnS4q+OMbBELkQ8WbQUC1I39Q61SkN?=
 =?us-ascii?Q?+d46yIwX2pGoFp7kDWuyFhxKRVhqkpUovWE9H+qfjyQt6VargAjlICQIIU1z?=
 =?us-ascii?Q?e7zsnfvQ1oVw6t4Wgz1XiSXzKNRNZkaIEVQCw1KoDLfjB5bMPuhlWxB8bH56?=
 =?us-ascii?Q?/bgU/yvMQId+gnVmr0CCgs84jWKh6DZQ4+IvgtCHno9VpHHZgvu8tgBFaHIe?=
 =?us-ascii?Q?KvLIrqW0SFdF9aiiXjinyTHGjQUKdw6pR+Z373p9WqxjQmXGHzCL5IRNo7/M?=
 =?us-ascii?Q?Zp31dJL+IifT/u06jan6UTWvmgU/dosKlXnpPBryDtYHaq//JIgOLMYWE0nb?=
 =?us-ascii?Q?BdpepW7v/7Rp8WBwbE+Qqg/5su5GjqdZtgFhAOLxdysfL2ZJ1h4EK5Qx3uJK?=
 =?us-ascii?Q?/cEH0eRvhOph2PC2xmiTHjYB3K7KzAvt5b7zZgkWPjAwMTPt6KSsHXzg3t6Z?=
 =?us-ascii?Q?j2v0IhGyiAltNN6r5ESErygxAg40VbJkdftXBvNtO6+1IH3GTLgXpOXxsVqE?=
 =?us-ascii?Q?Q6qxeWGYZnzWxxjAk+zqBYldTNuz4uAmTwhlrf13Yr6s4FHW8wEHgmqVH29c?=
 =?us-ascii?Q?9KQrQd1dSnzEG3tYE6GXn951UevWF3c8iTrFMO/R+x3NLkAcAwKrb1w5xwId?=
 =?us-ascii?Q?DAPK6ieQGFj0v44021KisOpg7KgtOK8HXngJ2s4GmZOqXfe2ZnGV0/1q9UGD?=
 =?us-ascii?Q?w8OFmVuyaFJyUbssjLwNz6ApaOwp40pICNYm+RuE8lLQ4vt9xhXt7bEsyHQs?=
 =?us-ascii?Q?tD3VQKxZ2jZ6WL3YK8lJeMzi7RwygFDJI3EbJSAsI+Vf5iveJByuCDKZEM7E?=
 =?us-ascii?Q?H5LCmMoZ7ViEA1dFPyu8Q6qE5f2uWA9bzbNLaHVd1b5EWvL4xhUDmOxuT+f8?=
 =?us-ascii?Q?Sh6O0U6sGDgJ92hIsTIHRZQIvbdLLXo/wA4Pmq3ltmE61fFZkf/+HHbeTZtj?=
 =?us-ascii?Q?XsPh2dqC+gl++76jKll1zn8Ecy+N12cVDqZrVsD8lRZ+6qi1RLc5ZdSP3Gym?=
 =?us-ascii?Q?bk0ACL0OvmtZT5ah7Ki4IFARs3iH7vgQhMgTjNhzBmoKibMm2ljwWqC2qy98?=
 =?us-ascii?Q?O+CINei8TiSOEC3K5v0cYQ3O2Zf03JaX6JiG+5ioxSzYdXRrDCN4zGwDMYWp?=
 =?us-ascii?Q?vFNgYOjmQx7cD9r+WzW2RecuqLjJp4qLf/T3ILnaAUg3TyUmP9bIK5uzBjQ6?=
 =?us-ascii?Q?57B6V7gFfg7OqRU0Xa+fz20puH4hvo37M7wbgKf0fKTSHbf6p88h70Z5OjxI?=
 =?us-ascii?Q?WqSPxKZqO0a25V6TDCeONqGv04WyxzuHdSWZhCLvrcBzTsXXIu4tCHXBCLLp?=
 =?us-ascii?Q?0Sh3lmfQHPeyNY44vPQ/Es4QDtkKFyZ4KTIKgv7svhrA+QLWY62RhLfXs3Rq?=
 =?us-ascii?Q?zl8vimrPg8sBvI16h3/+O8bqT6lJEQvThNnChaEJponyppMtuU4hQfH2nqqy?=
 =?us-ascii?Q?nmBgPpedoEd3YAI7hroCVftUN1jBDhet2Q2R1xOKMm4mJjMEaTed2UwAiuce?=
 =?us-ascii?Q?4u+YiTtofQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2119aab-42c6-478f-efc0-08def863d276
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:21:15.3231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDz+zXeW0y1amuMxi0pCzkS2SjyGEeJU1VO2CJGVJaHMI2G1WZ5lAw68lQrvXZh771V8ACuqIagcBl1TpSJx7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

Six independent, pre-existing bugs in the CXL core, reported by
sashiko.

Patch 1: Get/Set Feature derive each mailbox command's offset from the
starting offset plus the amount of data already transferred, then store
it in a 16-bit field. A large offset/count supplied through fwctl can
cause a later offset to exceed the representable feature extent and be
truncated by cpu_to_le16(), targeting the wrong feature data. Reject
invalid ranges up front.

Change cxl_get_feature() to return ssize_t so invalid input and mailbox
failures are reported as negative errno instead of being conflated with
a zero-byte result. Update all EDAC callers for the signed return
contract while preserving the existing fwctl RPC response behavior.

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

Patch 6: poison_by_decoder() assumed every decoder with a DPA reservation
was assigned to a partition. Malformed device DPA metadata can leave
dpa_res set while part remains -1, causing a poison scan to access
before the partition array. Reject such decoders before the lookup.

Changes since v3 [1]:
- Patch 1~5: Rebase onto cxl/next
- Patch 6: New patch

[1]:
https://lore.kernel.org/linux-cxl/20260708074228.43654-1-icheng@nvidia.com/

Richard Cheng (6):
  cxl/features: Reject feature offset that overflows 16-bit field
  cxl/region: Scan all partitions for unmapped poison
  cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
  cxl/region: Start unmapped poison scan at the committed decoder
    boundary
  cxl/memdev: Don't overwrite the error from an earlier partition poison
    query
  cxl/region: Reject poison scan for decoder without a partition

 drivers/cxl/core/core.h     |  8 ++++----
 drivers/cxl/core/edac.c     | 20 +++++++++++++++-----
 drivers/cxl/core/features.c | 28 ++++++++++++++++++----------
 drivers/cxl/core/memdev.c   |  2 ++
 drivers/cxl/core/region.c   | 15 ++++++++-------
 5 files changed, 47 insertions(+), 26 deletions(-)


base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.0

