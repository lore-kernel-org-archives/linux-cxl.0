Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792473254;
	b=fnGObH+eO+tGUphc1CPUa6soo9E8gy852fBwubMPhRnkkPAJ4PdnA1Jq/EC49h7fvq2m
	 wKWBHvAeGfj2PCtIEvGtU8o9gay6XIgsV87RPCdEbWscHsgo7ExxqlfadoTbkOjBfMnqF
	 pzt9MR25qJwleubx6pvMOurm8xFTZytrE19zAliQaoNlBURErkk/69YvKmLC2GFbgG8cO
	 +n35eHfml5E01nk01i1MTc0uLUGms5Zkg2beqT2TR8psAmfrPv3PFCYvHcwZNPrJtM0tW
	 c6WCRjb1C313YbLfgYhalQqQ+ywnerFKiJtida1N0BVRfOrJjyfoOjQ+rrdxviKMU8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473254;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hSruwplxpyu0ofoPRGGhQ6tUWx+VMENKlbIkKmWojk0=;
	b=QDWApRcnNSSLiYFyK4rOO3ASZ4PQt6p6p5+Q1dGNzlhqt3x2tmjP2e/QV987Qv9DETlL
	 wRRgOMh5Zq+kvGrOn4P/UPbBiYyXA/ANngtlISm87dDBnhpwfFtLF1Py4o8zbcvVYTAaS
	 EibjCwT69Mcg4IVQKHq3TDkBV5O61Lni6MJWw87F5OjdSNCdFvyK1xeS1bCDpda3Y1R6G
	 owJrBRvAanP9jMzSjlXTLkIRKeDbAHD0mzKavknd7/HBHtl4xIMxT+mzGCA2Cey5e1NqN
	 00Ex1qstTfxfC7Wok9NvftfNk7yzhueXVPUSzjKRP3RSXt9xukcLx2ekg9mzqmDhq/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N7iScNOe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.56
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F8606A319;
	Tue, 20 Oct 2026 05:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 567F8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N7iScNOe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADLWHgpkURPCmKrHo2WHu6OEeJcaPdUxpnz9/X3gXfO0Jct4yHK1dkoLOZ3k93OTtjOXNiB/3UGK+/nUvqctJJJe3sqvbk4C0MEPaYjtUFe0BdvYT2qKFsrYArRLfa4MA3Z4QpXIGrAV2lrbvVD8yMo1FK9JEBETQYpmuBDF5ahSqxP8ZUHtFJx5Y3Q1pnUYfaJSdGFUjXayezJ5O/UkNs91LWHqZ4NHJaigGfvOrrY0claA/07ADDqtdqW7/RTKsRDP+Pxx5c9XLcUNEfRxhOYMuqd1014a9Fegn6Us/P+2okndhoaWs1g1XlIasj8B3/fxYK2HrGw9bEQ8w1IAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSruwplxpyu0ofoPRGGhQ6tUWx+VMENKlbIkKmWojk0=;
 b=FpEbnwZjF5l1c7BNGSm60mDk/PIK6wKum3TxkQp2wQHgzAQ7Py3Uz4y6kN1OjbJKdnf3o3ePGH3L54BTwUDJJyn0bgaKQFklDEsYilDgthUVw4PWRBWRRFGkxt7ilp0fIuVSrNc+zH5pC/tfrrSSd1n58ZPN4l3DOrNOg4MTi+3M/KGOxOzY7ERK1z6/kkcxz6rTQDkt2dXwQ3Q24z06iRdC8TE7Ebo4yOGx33ffHNL2HV9dDKWElxP1jktj6uhgn/dE2kqRWmqTTKziaDj/3hY+SMDgnCOwBXC1FXSJPkwNCOD3q70YsrD6Yb6M8q+A5rwz5Sjy5tTVpiob7rclaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSruwplxpyu0ofoPRGGhQ6tUWx+VMENKlbIkKmWojk0=;
 b=N7iScNOeSkp0kfNv95zfV1dS0gfnQXEL3pqmwpz+BbmDvOMVcsNr4cOrvnta1heQCfn1MBSDzoYJP0dZX2Hiol7ooNl/mAXZ7LWgX0jp+ukQiedP8bi/2gfALigpsyopur7dnDxsQi0LQ5o8xao6yReHunATUvkpr77c9Aa0GrFn8+f7/FEpZUv2rhqvOfjxDFZbNz4xqA4Od21wPlWc6l1/o/asqhGCOY4taQUj9+OFHVFZk3cdl50ttluBa6SW/sSGaPjx+8JnyVT0hwx0sULlwWeEYhp0Oe8oNpMSelbCZx71O3gp+nsRHkr1Gghb6PKBE6Yu3twRac7CmGKm+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB292992.namprd12.prod.outlook.com (2603:10b6:208:5a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:14:11 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 05:14:11 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com
Cc: gourry@gourry.net,
	terry.bowman@amd.com,
	alucerop@amd.com,
	icheng@nvidia.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com
Subject: [PATCH v9 0/4] cxl: Repair poison enumeration regressions
Date: Tue, 20 Oct 2026 13:13:59 +0800
Message-ID: <20261020051403.14186-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB292992:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ce41c5-db6d-47c8-056b-08df2e68f977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|261009223027099003|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UypCWNYyNDOv0127ggCoa0dtbN2EqJQ3XmxvyjYZdT7ygrWhpOobnweBIaneLYIhGTb7J7nOYUi79u915udQuXo0woSDomocwARJ/Da/2sh05Hgmxm8x8MMNMVP67yxxUXZ1ABe/C2EFw2ZPdFFKS3cKZUrUHCo3YfBurK4PpdCYt33vTuNXLGb/PS34TGKR0JoA/g2EKT/9jSsLP2mwCoLIeucwhwo0tVUtOYn9cvIFCjElu5vthNgNBaQkDMMZEBcX2NkyEI4Gjbjec6mW6fZ7HGkGUeixoFoizTMy2OaWU9oOFJjtPIYgInSUqTMA7eSmYlDSAOp5kH+sbIhzM6CE61XMdLny4NflsnUB9g3t7Gc33QfLpgo3d5RS/krIASDeIvpXjhwUkN5M0Sj0EPBkpRAA8QRi9OcsGKus3wIqapZP2B04VBVPXQje8dNVTDVlo5r+to/PMk80hGCQiVaMW8zuper1avoJO5qtCb9ULdFpomDrBafjKA89C5PDppnK9Khg9+7/b4vlJhmvgyYxHQ0J9DyIM9Fdq/69COfH+FXmKBERnBxQbqFjMQAQu8SUG54vnlNxVv2hJgCCystzxNErYEtMU/2eacooSga5rCWK+3nhabM+4EJAuoyP9/3q0hS7IoWY1tmhNV5/etgMM4O0Ho7MDai7bsOa3Po=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(261009223027099003)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ArVz9QnC76tjdU4NQf0K4z5zUDeUCLEhKvuQo9EdKqFZFPlik92kHAjHqdYD?=
 =?us-ascii?Q?Zk4TK1IoumHBbS4dKcX4huoKlVD/r0s811SOT4DGya1/rDlHQxL+4fJxLxFC?=
 =?us-ascii?Q?o8VxN3M0NqBAOTONR3o3KVRwGDQqFB+WhhQa85rvCTnGIbREpsKr261Os228?=
 =?us-ascii?Q?eaSOb1SzwCTG2rsbPz+pZODIeXopO0i+Dim+TIDytBO7GE8FLT2o/fh3nDnq?=
 =?us-ascii?Q?Yt9gKY7qPX0LSbC37SpYHBhz7vYJ2kJXD0OBQz/Ep1KqHojApgsKjT8jobvn?=
 =?us-ascii?Q?zTuuF/iUfffledNosaTjZkU2L9VFzJFiOnMoX+AZ2Cos6x5LUSKa6HLLhjpV?=
 =?us-ascii?Q?ltntWC5gWALWb/kOodPbOyaVbY7UXIQ+2Jo2fooTr1hHhaYXRBC1mBlBrcXy?=
 =?us-ascii?Q?DwxmHQ2RmZgtsByOWj5vnBJH8kPzpi2IQMrZjkxtwW2sWIzV9i/kQiKJUaMU?=
 =?us-ascii?Q?tzwOkhgdLASLbCXeLGe3Mi6flyoZ9ccaR49iE9R8Z+LJspXMNzCPfafS7OgI?=
 =?us-ascii?Q?Dkkq50AvFFTcvXClNwAz9aHbxgHQXz3QObCvLGDsbtdk7CHxide+/f1oVjKk?=
 =?us-ascii?Q?kFMxHLeR4kmKRuXbBSSemRy19bhyep4zBGzotSSb9Re3CUI6s15oaIHiHcAv?=
 =?us-ascii?Q?Eu0u/O1ysrNwwi3XUo88n98KOJZ09oA+MKEyGR3EDZVppVB8iQeNpQCT/V0D?=
 =?us-ascii?Q?AdAtTKpO9g5hkfAwQVH5i5dRyTyIu96whF+UKnRyJ/Eo1Kvg8NrD93n2nEi1?=
 =?us-ascii?Q?jwswDx9ttJm7an+NuI6C1AkIm0NwvyfFG8WuqOF1mmLCeJpj1WaVEWVM/eiG?=
 =?us-ascii?Q?iMH5J8gPh9lZix8mFlXCYeqbnX9nhRpQEbii7W8+4uYNGBp+FTcgcuLvUaHJ?=
 =?us-ascii?Q?KBFzXCgk0R+YrbjvDMh0kszm1vEJB0SGrM5T3IjxbrGUn3obmvN60ATkfqJn?=
 =?us-ascii?Q?G+qU/1HyXGEbG+rsl8FyQeVmimM2Jyq8CB8UKps+daVB5znzxRReqC5aVcpD?=
 =?us-ascii?Q?RoYKwOrTmamBqOo1WThdNzKSSsnhlhVEaUvsBN7YywDuUCAwVi+q6gk1Bga9?=
 =?us-ascii?Q?Si8kTX9R1QbayzQIfQc6s8F8Xz3/fEBB5Xa+speN0dHGaYNjYu2/BV8zSeHD?=
 =?us-ascii?Q?hm+xy0CrJAt/7sfQiCvkiiA+/2+fFMGYFdQc7VzJJRDFY7+Wi7G3RIN3HMkA?=
 =?us-ascii?Q?s8wM08d8DhSGI4nTpALGO2bOQvD8wwUUUUXtdCzzxzI+S7q7Fis7bEFM/zKm?=
 =?us-ascii?Q?Rk0SQFIoRRue50lh6ndEKdBCRCWU3wl3mHstC65ouyQDcc6JXszgqFjUv79U?=
 =?us-ascii?Q?k3UGGaE4WAAUJzkJaYpV/SoRAPV5unoAGed0z5LKIZ9xRqUOo3OqNKzQk/cV?=
 =?us-ascii?Q?TFZRnyQCV2ytUXI/XOS0x19E5z7i4BkyZOpAhw+G+CMFjvgMVt4UXAcP/QUj?=
 =?us-ascii?Q?R1ytdm9Pv3+DbmFrpUBpAr7TRCSxAnM680Woi5m0nnOf5rCjnbXftn69erqr?=
 =?us-ascii?Q?M8gQBN7gJpsYiuBYxRGNqendII1UpzgV51lu2EiJtUDePo0Cqq3A2c4b5NKz?=
 =?us-ascii?Q?soUVnH1s37yPTyiwAqFBmanLs7OYlHEJpM30nV3+le4+rRB109vRcd03jz/s?=
 =?us-ascii?Q?rlrWFpA7HARIvnKOAfVXwdopNQw6L6MNfnjsQT+q10SKcrTeW6wupLGN6k9j?=
 =?us-ascii?Q?QRPr4zQNNORFgwwVV5JfRsozy9jAjA5Cluw8VKPlzZEYofJG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ce41c5-db6d-47c8-056b-08df2e68f977
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:14:11.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkbstWnxaBgRA54zvONwbNzi2nZHXzElE73pY8l3xNhQ3dX2PikO86WKZhHEvjiR1N6EwSMOZwLxP+9TbbIIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB292992

This series repairs four poison enumeration regressions introduced by
commit be5cbd084027 ("cxl: Kill enum cxl_decoder_mode"). This revision
rebases the four patches from v8 [1] onto Linus's v7.3 tag and
incorporates the review feedback.

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
from their beginning. Also reset both the partition and offset when
falling back to scanning all partitions, as suggested by Alison.

Patch 4: cxl_get_poison_by_memdev() can overwrite an earlier partition
query failure with a later success. Stop on the first error that is
not already tolerated as a RAM -EFAULT, preserving the failure.
Introduce a shared poison_efault_forgiven() helper in core.h and use
it in the memdev and region poison paths, as suggested by Davidlohr.


Changes since v8 [1]:
- Rebase onto Linus's v7.3 tag
- Keep patches 1 and 2 functionally unchanged
- Patch 3: Reset ctx.offset and ctx.part, suggested by Alison Schofield
- Patch 4: Introduce poison_efault_forgiven(), suggested by
  Davidlohr Bueso.
  The helper was present on v8's base but absent from v7.3

Best regards,
Richard Cheng.


Richard Cheng (4):
  cxl/region: Scan all partitions for unmapped poison
  cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
  cxl/region: Start unmapped poison scan at the committed decoder
    boundary
  cxl/memdev: Don't overwrite the error from an earlier partition poison
    query

 drivers/cxl/core/core.h   |  9 +++++++++
 drivers/cxl/core/memdev.c |  8 +++-----
 drivers/cxl/core/region.c | 24 ++++++++++++++----------
 3 files changed, 26 insertions(+), 15 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

