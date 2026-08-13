Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440DE248F72;
	Thu, 13 Aug 2026 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592761; cv=fail; b=qx2GzIgoaYM68VRADd3qrWidORm/HS2/MgN9hY0pfMuYpIwZzzn11YaU+bpNi1D0Dq5cJmJQWOIx0NGZ04dP1WP95wQ86z9cTYuCC8Pvt35nhQ9HclIMoJLt/19QFQDVcezypcOb7YezxD7j9jg/u1M3ZpcRL/OLcM5fb3LAvSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592761; c=relaxed/simple;
	bh=TeWsT1lVkoB3LtiiVVApvWIYsouzJSHwn1PAAXwg2Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WstgZx2/xe2oy81gT8fpiwXvyqASrTRamHg6444i5BGJ9a2Ff5BPZAh8z+oO1At6HqwK9QNTsI87c34NFSIMms5OTvJpn1segRZdAIkALLNc85JvbrqxE4ELmeYc7dNB26TDLwEPX/9m4pH7mg+XJ7fTzY0NxogbbXaGce+aLE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rq28bk+6; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rq28bk+6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I25jecfIAH8gs0VqipH3uL3b8DrAbWATLUxuRHOi6sCx0fG4mhvrrKqDVDTzM6n8Ie7OJnv9TNBP+SDj5jIb9Ah+6tQV8Av3v5Lb8L68r6WVnZo2wTA+P260mO5ZW1zPTAMhu0GdNj2l1HSeGJOicfpi5tCgdZ0V+B/59pn1/WT2ZR2MOfkS/z9zZ9f8tEKv2cpLpZz2lyNY/PMDq+wT/pHvtsieHSVhIHBsDKsnMEsi6j/+6mfxmWA6XyfvkKzqKSbuj0VP1V01LlBHkHsnUqaE9pMk+g2HQwPrNN9qNdCag/WsBm2TNjGYyhGaDqJVkbi6r8EReK34EBK3iRpYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjs84Z6Pob9dA2ZLzsHKjv1VCi0KHgjYpPbsVyvdngo=;
 b=X8WG0kre9bTsvUEntTDeNvHKH/2EXI2Z06vzBrWtM6Snfa+9xcWQIgy5ny7JjNn+QqVxW2LHHzci8H0Cj+BCmyJ1UQQyT1DE+gmCEaJs2Yzbx03rKms2YnMmzxlCwtMDawy1kX6/J/857UseUFD6WnmVDIT0l3e2QIcW+6Q372x76CbFB9z1hdGlDGlLBLaphFeXpXob8tjmNGjIo4hLyrR/HWL+wRFWHwvGdKNIQx5oDC51qSbYUCDL5wIPePjIdzz78pQruO2Sh4DF4cKuTcrxRCeuRezSiH1i6yN5nCSsVVZoy7ZPHc/oAZlIxxGRTdtW6S4PTJb+ZTuwFEYhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjs84Z6Pob9dA2ZLzsHKjv1VCi0KHgjYpPbsVyvdngo=;
 b=rq28bk+6kTkrMkoKdurUGFUGO5NRYYkVk9j48wBWTS4Bo9UymuN6bLZgfwkV5qMVEAdXRJNwcC8NIJDSRqgMJSA7/Q44jm78DgmnAkRwutxxMfLJxNF+Ou4XygWKl4Cpn3W4iITb6auiBJIJ3GT7uis+AGZ5S3DBb8SaD4kll4Ir16DWIjLk5qQSkqT3Myov5IxxYtpYRt9fCU6Nmo1BHFzteNYN/7/i6NkXQWHCzUie9xQInISfRt3JXDKM3IRcxU9zwOg6V+3Qb11awS4mDYu/XfHCl6sAeDhcjQ7LBZ5ZV6ZAPTQev3eN8p/gRNoOPRkHQGrYQ8cCe7Zac0UN5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:45:53 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 03:45:46 +0000
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
Subject: [PATCH v5 0/7] cxl: Sashiko bug fixes
Date: Thu, 13 Aug 2026 11:45:31 +0800
Message-ID: <20260813034538.13189-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0042.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::11)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 436e5213-1234-405f-ccb0-08def8ed5ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+OK2FuxhYKAiyTfJmAQi4YZNC9YLxuM40bjwkYnQXtsyCzg8m1DGMunZKNy+ZdYtULzOvIzKwGDE7iCyiC5UqZH/j2emU/b0nEKgHnckr+NFu9xGl6C8uwsOBh9CiAd7SsWoPP7XMn4GkwTxa6V38F6NQMIwPKVhpcl3F6Q5EWOm1883uaeJTa+rmwTP+XHfMvAe00bzvz6H1xvHPRckyV0Sq3w4RTcECOKa38OJozEOMPkZ53tJE8uWcrOBBrwxGSjFOgky5GHY8SFQB9n4NnoH9db+gsylD2VVN1MtvB6JzXddEtVlODRyTqwOzy7Ly+WINTf78C8cmFeHys60cBmyLwyEbhOxL4AY83pb5H/6108D3CCwZdf2n924VCuuxWaoe3R5ZkNMwNtzpnQlvi/2XpGCGvPoDmlDrqToaRsT0aYy8ljC+w2hiaVd98OWQrXG/S7s6kY0n55kQnJFM5ISaL6dG2O5A0rzUXUTGcxUTwONTkQg3OP+Ig9ouIsDM9bJFi8aYZAhcc0LKVS41JkYMiwjm8loRk+c1Bt1FQmYmNivzVzjdIAub2vjHdcY0z5JB0o6kSfB7WuzZt8ITIwYkMBfgonKQVGsgtfml6YvY+6XFVRq+8IglrqSDy+9FYsi9fd7+U+rrfBhX4GML6bzSt3wsCjA4GGSH6Owh/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6pY1R1Frfs9d0hLCK7tdNQRPbqHcGg6YfGHE/bt4TQPWgi0O2vI+0jI2lsWu?=
 =?us-ascii?Q?GV32pnFcryZFrmqvEi0mWqY9GmDPRfUGqIDEdIKayXqFf+X1ZtNaqqzUd3CN?=
 =?us-ascii?Q?M8HfUWaiNTewwA3Tjrz2y0AoHNfF1QzolWV7eXWW4QGGDSFvAv5+JWU7V36G?=
 =?us-ascii?Q?yQpTpnu2I+WktMVZn+P5E40X7mXhHeRiVWohynq3gmg2dT3Pza7Ax4jc2g88?=
 =?us-ascii?Q?P5oOMpqFAGdyH36X873L9lfJZGnR2k/kvOI0fwSF98H7NxIkzLKTN/URpWHi?=
 =?us-ascii?Q?KXd8Q+XPqTYLtPpNFjho7Gdfo3Z46AsKuxf778Kucuej4rShR2VRA72A7ptt?=
 =?us-ascii?Q?aqDY/wwwvwMIVAovgeOZSG+o9E6nAdielt3CBlJJiL30oezaxSxdC9aEcxIq?=
 =?us-ascii?Q?96o9paDJcoG1N6nN4HQBUFAT/90wjuD1Xm9n2HCmqf4uYoMB+P2I5M/fl6Ws?=
 =?us-ascii?Q?rzfbIzJJ3NqNhJ/ZgvqokBS8RSIYuOSNjI2nuuhgH0jy+tYgHRmCjmwKhwq/?=
 =?us-ascii?Q?0f2PuNlEPFwtFnZJqDltplaowP+YU++P5VooNOGrCgX5ch/IsCD40aCk0IdA?=
 =?us-ascii?Q?M1tGGVM553+x8jfrckoA30bMd26LxR+OmGoo65imKyAyFaGNdZgyx8IVUgx2?=
 =?us-ascii?Q?fR74hZTGVIgpqP9NEazG6PkgzRwWkqT+ekYuZdzeHGmrCaMzZQn+9qTOxT+h?=
 =?us-ascii?Q?WdjcEhtS676Y1ivDR50Gi8z4hcwjPtKtg/SzlErfLwHOoeFribSR3+taVxw3?=
 =?us-ascii?Q?yX3VMhMc+mZp0Flv2ON4YWOy+ryY68pQKGp2m+qjCMlXx6Qh5jlOQTdMJx7r?=
 =?us-ascii?Q?iE+aZKoHh2YKlHlVOjPSMxZRTbxsFwDPBOtiUNsiLMdpQVAGpwhBENF7mUNu?=
 =?us-ascii?Q?PpHWNEn4JqWjKd3eZcHvBi9ETjqnVZS3v+UxYDiDEesMQBZq3h4bLo0nTbqu?=
 =?us-ascii?Q?kpZSkJdfLLmY/C08U9qms7qqe0IzihmIyfr/SLiRx8SnF0sDjEEFCCH/qNdn?=
 =?us-ascii?Q?2K8BhR1LKGmuqJzDN1awjUvhwYA/rMEhy6mZtBjsw852YjC6yFo8bOpgCHjv?=
 =?us-ascii?Q?LMUL6JbEDlO8mMKTa71+7DWoMxoOR5LJfagKqQS+dgdAHOufd3qi6fwFE4fI?=
 =?us-ascii?Q?x/p6RJjz20TphJiK5gQ7aqFCPNrUKkK7kEJ5qJTa3KUaQ2IkWZX3rG6s0eKv?=
 =?us-ascii?Q?fGiXtl2DQm5zPo1m2tpFKb7yxqMzvwwJ9OJ8Hy7IUFD8bJKC3o4N/F2+VKRk?=
 =?us-ascii?Q?RBLJmEW7Y/na5rSlnVIxnsNH7srYFeRtBeH/B+Ga2QMKx7oYcFNppPDpRkjD?=
 =?us-ascii?Q?bg64u8PrdrtBhY1zLvPpBQssi+HoROLXP/iVtBksh/DEL8JXuuSbNWZR3ArE?=
 =?us-ascii?Q?Oehzyd3AFZrt4MV3ey5bb55YjdGNfy5r437MCVK9LcRprdHy++yz30Lewh/W?=
 =?us-ascii?Q?vm+HwZGVUOqIDg5df9qx/luZefG7kEhN7wADpbpogpmmHzoSiqbvP6vafxBP?=
 =?us-ascii?Q?sjeQpToOjMwfQThRC2scwv1NFdMK8dNbjRAdkyMNEulx1KkpqeRsJGI3quYE?=
 =?us-ascii?Q?dkY/pahMUT9OHAYX5eSapagIwJsLYeteNS5iJlRNsUDOeYiAyznXYhst4KSD?=
 =?us-ascii?Q?+KU4XLnEAkE3LPR5mYNOAxrdVP+ITctC2oM++F+UvTvmBpLT+keEjEicWLRx?=
 =?us-ascii?Q?l3tXoQ+tgP3nDL50tUpJVQBV8rKGYUZbev5sO6dvxIEmLZVH7TmhJU8xYDcb?=
 =?us-ascii?Q?4hh2OoRzYQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436e5213-1234-405f-ccb0-08def8ed5ba6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:45:46.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBBt38aS2kB4dIMGe+lkLYJ/gARvmHGUpRtBhR11hcbCnh/IWYjKdoY3zDmpDrCp3YTuE9QwtrwtuovjpvK7dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

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


Changes since v4 [1]:
- Patch 7: New patch

[1]:
https://lore.kernel.org/linux-cxl/20260812112107.56181-1-icheng@nvidia.com/

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

 drivers/cxl/core/core.h     |  8 ++++----
 drivers/cxl/core/edac.c     | 20 +++++++++++++++-----
 drivers/cxl/core/features.c | 37 +++++++++++++++++++++++++------------
 drivers/cxl/core/memdev.c   |  2 ++
 drivers/cxl/core/region.c   | 15 ++++++++-------
 5 files changed, 54 insertions(+), 28 deletions(-)


base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.0

