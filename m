Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F528B7DA;
	Wed, 26 Aug 2026 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708726; cv=fail; b=lh4X++s4wPsBz/ShBsWid4B09qR82a+Als2BUhPduJcgz3dxPUK1t6SBYSRBA8Tq8iWgUlwtbpThaKU7io4jGEnghWDYkLBy76XCiwZNmH06aM78i0XPMleBjTcffVmgSRsLnK6xwV9WyY5g62L/X/GYwuBFaZFKJSsPlv5gKik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708726; c=relaxed/simple;
	bh=EaZtFcDr7hbqhodEIhjzdc0VcNcbA+Pfmr9T3z+Arx8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NA61DgDiq4laCpIogtr8rtLnL4XskQw6ZsXSXVlfiuz1WZSOZ9uvbqpr4PzsccnLIWE7AWnEkMnKfuFLG1RcAldkhJaaT4gVGhaB4nqwM9uB1P4mjiIq3vHZz7MRjpN+wTr4Mknr9rDfXoxIdXC7mUpbuUzZ1RbbisRSoBRXAHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o6rTnBbn; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o6rTnBbn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ8bABxcwrHLMomAKrEOEYN7XdlCjNsO4/QBDK6rba0sSqX30s+SfMp0R69Q01umu4e23adHycLrjpBFTNXBbwe3Qvaqmm91QhyPuzhnt2eir5Bz6vL8Kx8FSvrPcXOWqxJ0HV9Xq3RD9wcqgFkLBQ7KUJQlnin81cFR96IxcMlYIu/PVmmZ9ZdNXmFdKS11f54V1G6N45u0AQq2HQn4MPUbL8kElreHqh4V4kN04QtG5c9VVnTbeN8Qc4r5l2dB6gApYIcDZt228u+90Xo+4i+l6jGVLDhk159qco2YFdU9FJEkhren41afJxb98iYgFhf6hjuJo1MWb0BjT+JNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGiN4A5NyEKmlio++N/HFEyYcqtujoOtfxeGbQYVU44=;
 b=AegYgPIsh1rtE8cxmFvlkM7xvy76+vXMHcB0UlpZe+9y+aPvCmx0W2GTYLUeUVWvQO4/GZL9fPsVxLlsduOA2o36FGLyoGo8+Aoz/GA98qhkxzJmDL3t+Ql8a9CccwjGLBP1M6A0vu0QMn/dApo7qhyqDqQfMXbTfB5U97x7Fn5jSB1lHwNnAYhgkpeBvNgahp+EE3WPi9ckehQk5fk4EIWrg7dVQjDA0sYACzAKMJzKxr7HKhkEOV6OdiNZ/Ryiz8irXuGRieR6rK+Zyw+JU3g9nijpLArZP40g/ahiIXscj5kaHSkXC0FZ/Xj+MDyK7NfPs4j406Q2CQUemzfcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGiN4A5NyEKmlio++N/HFEyYcqtujoOtfxeGbQYVU44=;
 b=o6rTnBbn8pQZkIWeJ8citiqQgdmRwXh4quz5ojQdfGCCOkQeMVhGDhlv1vJ4RFuRmAX6t3Cc4fRXGL3y5ixcL6oKWyExzQv/c2Y7mI1lenf6OP4i2JNs+fX16uUDRFIOgbLllkEY3GHcK4i5ZvZ9piew9wVR5B86ig31iQCAIy1e0x4Ul03H301fBwEtfYzhfyAzt30EF/NRdNJyEkKbO6WGM+fppEDJXqtoeA1R/c7BIjdkCredUFRrTBuvvy//KhC986IZJ19KbAqkhbBOSQj30xLNnpXs+pQsKW5GUJpkvMQ2G5YJkmm4vVhPTLdtp1t04Uy4pyTW90CrDDDQZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 01:45:20 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:45:20 +0000
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
Subject: [PATCH v6 0/7] cxl: Sashiko bug fixes
Date: Wed, 26 Aug 2026 09:45:01 +0800
Message-ID: <20260826014508.9989-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c7cfba-c2d7-43af-f586-08df0313aef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	xu/5WjX+MiwN7o+H2/IjfUaX94vJqTRVPkbjcGnXIJb63G7pqS25kgeH+eYgz76vonQo50BbiEIV3O6fE5gpn5la9BFE2ytiqAce2h4O/eeHCyLytcOB0RaqmTBEyl1rsztltpvGUkzRDY9+28cajMIVAeRZJA8bEoPe0j0XEAxsweVpSmP7Lw27mkA7Go2B8/xTTS5z1qRWIQSrPYUruQrDZ7foDY5VH4krJ4rJQ2HUO78qPAQluhFTwmsmeQNQerc/yM7Wp8v2tgUXA89ExcjWrlwFhOwC6JM4jxjqiIpCWQQLpO24C/oE/HAeTqwFvFjLF3MHSVqK8CTofNs/IKTFGPhlTEJ2wP4xd0OnQYHe9PmXrayjUMkHiFKIzID11W/z9OUTdp0lqjvK3JNe7DoS9owmPjtf6UGMGCdwEcCpC+IYFxfjcLMCVUROzdTblc3x+q5cHY52Idb1dZ8Gjp8FkpLV3SUZDPyhLQ7uVq1NJ1PGtGUduzrs91sXVt1m7UTyKvNdLUdW+pVXoOH76IKKjAs0I0K0KWCwq2UDxqUEXOVn1Q6d+B4eDWVfm9HkDZCHcTrbcODtUMggkao0KZK/CVUToamAayx9t7Sivo7n/urWl0pobUdtgAItb01RiIUYPppl8pB7R+h7A2Vs2tjAeOiuPbW2Am42lNKcj2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rXwXdvm9W/LXo57rSFUvKaQuqKoTNkC4BJ8fyHlXavBquvkltj5J9nWQ6Tpa?=
 =?us-ascii?Q?dWJlxR/Juw4EWfHa44XM5040j8gY+Jxtgr6L7Xdr1rrCNSaFqWNBMmj7SLzM?=
 =?us-ascii?Q?+kn6TWwLlwHJi8hhA6MxpFwyIfw03xe4UlQRAwRae+09wyXunwF52/g7WmRy?=
 =?us-ascii?Q?rqRab+x+dO373RpQbnx9Htc/1Yq/0rxhuAQ5vaOzbipmaoAfe28ssyZG+s+X?=
 =?us-ascii?Q?AkBXMZEEPrkLk0Q3d+kP9wR1um5letC+U4pIjp49IUPT2luV8WsK/mPgy1AF?=
 =?us-ascii?Q?tPzLG1UoC4/15a3+/Rh/UpZqbTjj0Ii6WDttxW1ER6xk3or1JYPri210lM5Y?=
 =?us-ascii?Q?WXrN+R26wpMSCyudR4T1pbhOV3cwz5FfB+ey2S5LYfMfEFc/sX2O6jUg3iSq?=
 =?us-ascii?Q?mO8b+ePiXYCoQ5nWd+LfsijKz7ZCb1Ozx4VXRqtAyPqD+j44v1b0HV66fDDL?=
 =?us-ascii?Q?eg+dwcl6nwMu1kzdzq04n6eHrzJrFzF73hj93ow5fsE2fJhksl2E/ydG4v9C?=
 =?us-ascii?Q?AlfOAuxU24gBkJuwOha5wshERBB97Orf2bGLqMPruL6zH7kI1VtDjd6VClFP?=
 =?us-ascii?Q?4XANnffIaNyxMpWNKNcb8V9O0K7j9KgHU1Hogro1hDSoEuZBEvhf1Ph02rfZ?=
 =?us-ascii?Q?NWMbd/NRjAZLwzH6tI+P7jkjinP+vvN+zygxVwzMM1LkDtiF+o96C1zV/ydG?=
 =?us-ascii?Q?/+sKKTMzqVhl7BCBPOB2ykNvfnFC9MJ0RaM/2lQuWHpa47zoqUD+nb950v6a?=
 =?us-ascii?Q?C5wgAfKndm4Sgcs08C+dP1isDeRKt94QpG8/1XnFC6B8ClgrEORWLJjOEtEe?=
 =?us-ascii?Q?S0xUo6SFCY3ESYDGSAI2uZUUHJCeHVY77Ln12qEyaxri0HgN9EclzSxHT0aX?=
 =?us-ascii?Q?gWBZ+922GAy0S5R3GvTgM+bQl5UParLNaxU2zHBBPjovOixlJfuD/wdJ9KJO?=
 =?us-ascii?Q?NbIKxswJzhImAykXr5d8idd/Tmf/HqmykQLWYfpbvJHzrgIxcXYtT4co8GFa?=
 =?us-ascii?Q?ZbINLptmyPOMVz+Sm/tue2odYDzjjO8TTPIsQdFVhKYg2L4TbSIW57FSPVB1?=
 =?us-ascii?Q?33378c5SV9eUY3F7owZRwwl3PLC7dPpCdfussOJpq/BZqtLdomRb+f/lNDlH?=
 =?us-ascii?Q?mArctHHEwomV0XvaBTR3fAX7YHPNmwaxkmRX4Y5MD6PSEYh/OCg3fuisavMo?=
 =?us-ascii?Q?ESs4eGexIIDB+HmCm4hVkvhoMWetXNXAKSfSAyBzL0daaOXfRnTsqnBD1bxn?=
 =?us-ascii?Q?ZeQCQ960/VrBeuy1sUeJAhD481KOAParRR9MjKawOlTWIklsDvuZgy8BU/Ux?=
 =?us-ascii?Q?r0xH/l285/cOUZzCC5JUl1s1rug90LrZ2hcTTriF8XOR4aKxaAJYct8XYHC2?=
 =?us-ascii?Q?ZkLomwAlcMr1gGMwL9VHt02KzauDUVIPeWIfrtPsjiGmGqBBOpLdxU3xLiQW?=
 =?us-ascii?Q?ucgOM6Tj3W7NFtYf7YCR7erUglmzRLB3Ro/i/31GDguKjylt7a5/KHFBbw0u?=
 =?us-ascii?Q?d+1XumsErZM2JIEuAsQVb/ytsB+xjHAc1dOkqds4RxuCaRpkt3k6G/AZlxau?=
 =?us-ascii?Q?R9/9+BI7I6T0YzUVEM2Vl+TpwFqFf8SMyumVDZMxnPTN0CKxcTtKoQBHmGYS?=
 =?us-ascii?Q?9xOu43Gn5Coc+QyMuTfwH/Vk8srvz73iR5BE7G1uvHmcfmr4djBVd5/mU+po?=
 =?us-ascii?Q?qo1SlvtC6GDvAbScXLIMCZWQBGz5+0QCOLhOJSx7rIwUZyCshHebv/dxMDUM?=
 =?us-ascii?Q?nYOcJZIDdQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c7cfba-c2d7-43af-f586-08df0313aef0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:45:20.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NC4DjHt6PsJ/OBfusVWrNxr7GJcCR+58Kmgcy+WlSSaURk4aItbXinJTbtCOAKwsR7lcP2iMtRBu3PHStL81QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297

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

Changes since v5 [1]:
- Patch 7: Remove the redundant terminal CXL_MBOX_CMD_RC_SUCCESS
  assignments. (Dave Jiang)

[1]:
https://lore.kernel.org/linux-cxl/20260813034538.13189-1-icheng@nvidia.com/

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

 drivers/cxl/core/core.h     |  8 +++----
 drivers/cxl/core/edac.c     | 20 +++++++++++++-----
 drivers/cxl/core/features.c | 42 ++++++++++++++++++++++---------------
 drivers/cxl/core/memdev.c   |  2 ++
 drivers/cxl/core/region.c   | 15 ++++++-------
 5 files changed, 54 insertions(+), 33 deletions(-)


base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.0

