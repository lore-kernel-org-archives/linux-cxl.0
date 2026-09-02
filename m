Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED238837D;
	Wed,  2 Sep 2026 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327539; cv=fail; b=swJbGHN89WqxnOupGe/K9NbDnUvBue2MBG1vlvyvqi73OCStIEiuf4Oqngb1vG/HbOoxc3VzZJRiG2L9SgvrWtNNweWWV1eZlJiTLCKPxWyu11LilHVBmmQDV1lHYCn22kQ6fmMI3CB8Bboc6A9W8YCdsdqyOKwvrc84t390Z7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327539; c=relaxed/simple;
	bh=lYVnUJBSaQGyZINrvL8Rt04B01LbaJkJIKX/7Zvvwqk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qeNtXed+RnMOoWoTUqPnHn0mrEaEoCHtpOO4bvGGD3VOaF0Z2dCLHVpo8u8P/5sj/AblMtjEZQDM9D7vChaTXQRW4Mf4wKn5h2loADfsjmS9SWwpLqN0qO0S+MoNajx1qlZLsX3MqnUu0uAWa/WWwEt9SKHRZ1PFOB+SXMZoHIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NTMTw+a8; arc=fail smtp.client-ip=52.101.43.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NTMTw+a8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJJrwKOtylI5D2Hv3Nm3na9OVQWG8SXVGQF2xFl/ujZ7CID78i5b73cPLyNpP0kRR2RliwN9qKi5JA8t0vulw8OfrTe60r+vpdGQ4p3V7qJPhlS1tK4pAsK4yZAHsiTuM6sOeNE/OGy4nHgyD6++1dri6tibqOqo9MEbCk0zz89qwYPXryYQR56E1/nMlxU0LMCHHIXr3CX3+ET+IX+m17s8GhHKNlpkmAj7bGvrSMvdjbj0MvvfC9pfbgrE3rryj3l66EmHQjykdPgzadWNjhNE1BBkKvtiWpcyXAWkhN3pOTxbGz/8JsIQRiCHVwHHCg2nAED+u4hpX9WTvOTFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAgehJdHKvHsaE3uMqrk4XjG5LbvIdzpKd4+ng5Y//Q=;
 b=Nt91ESCXM49sMYdpEK4SBgE3ITDqJHruXSGTfOOjLGJ8w3TRXtds7IfyoEWR9+3ioVJDblaHEJGJnQ3LvEsG4J6BzuF9UnIpklB788NSQmvB1G48mqS3WEy9STcfCDTk/kCQUuXVlxxAWJoA9sBUR8EzqO/BfiKiDqVVVvVpYqscx/nnV//+Lsu2dZdEmg1p45liFsHCmdUXMtwuMzs03k9v3BMuFZF3X3HVKE3uRzIVe+frBcVftY3nFfOdmCETt4Eot5wRJDrCjONpmwLSS9jDg2UfFoeU5T3xuG8kBTVUmWpjZxM7Jaki+pM1FouXZLfSDwmAhqIm/lGvwx+xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAgehJdHKvHsaE3uMqrk4XjG5LbvIdzpKd4+ng5Y//Q=;
 b=NTMTw+a87CzNvzgYev3CFHYpQz53EEAoZU457GFTXs7RxEdkBythq+ww9G32npUWhgRTtinAFKDgRVpflBYCcFpb9Ar8JOyg1uQJPVcCY/ZHzLLkyHZW9+js/gvh5L5z4oimkOnKEas5sa4im70unTG8bUl1lRnLqmpRciBbf/eXXoYvOk2gKsRYie8kO3mgP4YevIJIeS3vrxyMa7ZBkH39t1NHfMohjVKMjI44bhcpXm1oLaGgnvmR1MdND8eiJISOUrwvLzqoKsTVixi8KZk3Sx9rdUSxWZN0uKS5VJf2qpSfSPprEziPlzbSg6A0Adj64BhCZryNjMsThqllTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:38:50 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:38:50 +0000
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
Subject: [PATCH v7 0/7] cxl: Sashiko bug fixes
Date: Wed,  2 Sep 2026 13:38:32 +0800
Message-ID: <20260902053839.25595-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0e6e49-b129-4148-db65-08df08b4775d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JRWkKFFlnhupdRmPrhvXMr80pL4ftTP6/zoseOtowxNbmiZcct3XqKVLu3ZJp7Sv0s5iJsT/hLyj4w8nYpsP9YCoad8bUqE4cQyYyhEIUeQ7k4RqHeOAIueurvQN22cB/2BloVwqfkQ44FutbFVM693fdboYXmYUg6dUMe74VLQPV7ouxh7x8PDCOVLbnez/DMGzRoxtAxjW2h2N2sWrHaBoKzwv1zGER/VjKVqK+7r6bZnV1NiPkSm0zTIYFYoSxZDJxU2YaVkWYLcVOW+UXCwNcGFn/+dvI2YwxNJPiJUkiKGSE1ZwB+KPBJYPdtaaPwSlauAmfwaQDTF3yf1ovOJ7M144v8Gql9kRJZLBopcwRsvAVmkTjyNg6vWnIw7hbf742G1eqtSdrDklRxeEgZaZev2MO66+0aWz1+m+ZwRjnMV9apxpfpRlMhhY7Ujndf1vL9CBsbpdKEgnUq4YAIwF0JYa1fBdeycv6uvtoAvvapv5REE4HlC//5Ni2aHi0cGf4McmvpFsiTfv8U05qjrrH+NOinFAWJfDrZRSpXIWMarNh+Hxo/0VtURl6iTmVsFcAkMy2YEIty1qPYgtaoIjNsi4J0nq+D5JbhuvacMMx/EvUiQZB0pDERkQ0WbRrWf6fPaEs3AFb/drNUdTCt06x+/8ngKKjs5plA3Agdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/UrjfzDCJ/FKsNjocfjAda4u5D/BI4FULoVR0NDgdaVCq8RLDwx2jBNV0F8?=
 =?us-ascii?Q?mQkAj6eSBLW1ESJZl8Nx/2Dc34Bqu+5rDeyfkQcWbYzRvMsHpBVz0gaZFHB6?=
 =?us-ascii?Q?oaQQ1mtQCrniLmg0tHnuEQSkVwmdcSxn3XvBLAIFiWhgB3J4gRkWM66QXhhl?=
 =?us-ascii?Q?rJyQrRacok3gI/3ib5qOPYRLayE2ESZnQlWgXLx38VtMFresKBAOKBHBtnKd?=
 =?us-ascii?Q?GbLgbCUjC8GPbp8mzlw5Gu6WCziTkbBdMlupwM0YNe+hOkoI6BUucUzSZQfq?=
 =?us-ascii?Q?+/op38e6fh6KM/ObPHaIIlVhXm6KWj8W2Sg5KZsgcQyjdInSxIsmlS0erLUT?=
 =?us-ascii?Q?xJgcNd3AHaNaksNyy7651nGnkp5TXrq6FuiZJqCgWN2S9AXF8EAG1VkG5Xn/?=
 =?us-ascii?Q?O6smL9S5BjOU0TJT5Q00feWaZCS85qBcPx7GQEoMHb7i8thmM9YLKDSKgUy4?=
 =?us-ascii?Q?5dPrPbPryQGJsyTHYpXrRfXYzNXVliy+TfAikoJnsolEKp+UcLXzWPqxjAaF?=
 =?us-ascii?Q?CLgRDtJmQfQSPXL1Jz3RTEiBUFho7/LGnrrsftgTcr9noLWYKEGE97JR4N1Y?=
 =?us-ascii?Q?8QihteoTnSq9lcX8DqdkMdLjSS0GWzEBUxhPuiFc63l4SqmNGNiUU9Aod9Wf?=
 =?us-ascii?Q?O3l71Q7RF3aWTTxyOeR4fMkgWPWvp4wTWNlmdlNbX5eYKXsau38DwJO7gEk7?=
 =?us-ascii?Q?TKzTAj2Gbxl2/evwcuBGrqtSXQzWJHR6rLASJ5c2yF8VqtaBJUgRraIjEUYM?=
 =?us-ascii?Q?Bmnn3wHzX7SVOurrVgaxzRMFkXiU1ZP0BDUDnmGCSQ3wlKHRfe236WhDoUOD?=
 =?us-ascii?Q?3W2y5HK0uaCTXHcmJbaSSye7VFNCloCqy3lbZTNX2v/CrLbmyMWS+L9CExo0?=
 =?us-ascii?Q?PWEnd2BoFfXnFbLsewsIV/AQe364/en5Jm2bVe/NyPIY9RpPK53D8/n1e1yz?=
 =?us-ascii?Q?YM919VY/PcbmOnWB0MDynu4BW/9DUPjzL/5e0XKtDK/g9uTIyVeijK91P6vq?=
 =?us-ascii?Q?bXawuD02HBxXreyYNLR/nvDRel6imS2vEEUPQh6rvYUbYODdvONCvRKrxubW?=
 =?us-ascii?Q?ro/fRGt640c2s04i9y2tfM3Kib7ZayaNJ95ipo4YYXF61EfXMex7C08hmCyT?=
 =?us-ascii?Q?N/kb5n/DfOXHB0DiRehkCQjK3AzVmJXZRJsa67lEkB1nB8EAwMYrCeS4Ylzy?=
 =?us-ascii?Q?9Z26mYyZEqOxx/9K3yvq0s7kTxJdDFfdhJ0NOSjpqMuoEKXuBVDiMTgblUhr?=
 =?us-ascii?Q?KgO5y1pibC4SRxHvyTkAIZUS6B3eqAastbuxmkOuY4iDi9pNTOBFHSRZmT+e?=
 =?us-ascii?Q?gLX3HtV/ZLf38WghyBqIGxxrxDqG4VjiGcMJpKqfTANyPJb2pgru8uApu4Ws?=
 =?us-ascii?Q?DxKEjefSTuOchkSTb5Pk4/0X0GYQsrlYLKe5fHCb0EO0qxKzAxSF38qMibh1?=
 =?us-ascii?Q?knYnZlW9angyAHZ1fKe6LwP5N8O4AU2ThXRqxuQOaTQXpTvKauz7aTGvQerl?=
 =?us-ascii?Q?H6ZW6x9+H6cF142apuvHlgGhZtlQVFb3vcMaqgcEHxdW46L8Skrtg/MHEWul?=
 =?us-ascii?Q?hYry+94eBTKVEcMDUoFbbHpR3uZe/ah0VYK1Gg73IRcvWgFLVV24cNPbhJp5?=
 =?us-ascii?Q?YEElnSoxyKyaNnaxeG7gyH0iZouoH000T/hX4fh/OAyQ2URZ7nrbzAz/tkfB?=
 =?us-ascii?Q?gjekitOPhQhoastavZGQJh+9NWzo0r4KrT5sRemvOlc9OD71?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0e6e49-b129-4148-db65-08df08b4775d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:38:50.4119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NSmyCkJadvjpb97EJzgttz2GTKqDzO9KeQjwU+gasDZEQFWEjYMYvCFtEvTwV3aIAbguBHO7vp+QyRgjie/3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

Seven independent, pre-existing bugs in the CXL core, reported by
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

Patch 7: the Get and Set Feature fwctl handlers converted all helper
failures into normal RPC responses, sometimes with a SUCCESS device
status. Propagate delivery failures as ioctl errors while continuing to
report actual device errors through rpc_out->retval.

A nonzero short Get Feature response is valid when Offset + Count runs
past the end of the feature. Preserve the returned bytes as a successful
partial transfer, reject unexpected zero-length success responses, and
require fixed-format EDAC callers to receive their complete attribute
structures before consuming them.

Changes since v6 [1]:
- Patch 7: Remove redundant braces. (Dave Jiang)

[1]:
https://lore.kernel.org/linux-cxl/20260826014508.9989-1-icheng@nvidia.com/


Richard Cheng (7):
  cxl/features: Reject feature offset that overflows 16-bit field
  cxl/region: Scan all partitions for unmapped poison
  cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
  cxl/region: Start unmapped poison scan at the committed decoder
    boundary
  cxl/memdev: Don't overwrite the error from an earlier partition poison
    query
  cxl/region: Reject poison scan for decoder without a partition
  cxl/fwctl: Propagate feature RPC delivery errors

 drivers/cxl/core/core.h     |  8 +++---
 drivers/cxl/core/edac.c     | 30 +++++++++++++-------
 drivers/cxl/core/features.c | 56 ++++++++++++++++++++++++-------------
 drivers/cxl/core/memdev.c   |  2 ++
 drivers/cxl/core/region.c   | 15 +++++-----
 5 files changed, 71 insertions(+), 40 deletions(-)


base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.53.0

