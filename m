Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED1A26FDBF;
	Tue,  2 Jun 2026 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378873; cv=fail; b=tuTZUo72EenVOufbJdOaVvghocXTWyMeFSCuAWgBHUff9XuEsRuYZS32nOkuIcq30E61XJpu8eJHzSqY5FUQ0p7mHlcPnd+UC8WvDcMnBQkzY7qUOEK+XyWejJc2w3f2m2Z/vxSwLiVWk5Dp4hBdooXH9pvI/g67AI1iHiSLbRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378873; c=relaxed/simple;
	bh=AQVDBEPjDRmpPJvQAEen5Dn3f80wFSmRHsHEDo60iH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jn1dU4wwdaj1Y1B2kRYFgjzTbKpdyTEo3mLxlBnfnDzx4jLJw450l2tFy6b/VvUhgk3c+edOAFMfloYAAjgEMyajP6cwq8KH0STEh1a3kFd8rSiQnIgBbeaickhJhxwo+ODSFLhVeGV1qqqGq8Ro7zGSIMixx54iRMxNlkorFwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ve68qySN; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ve68qySN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl5BzgOPaXE4N8fk0YxEJhnsSdFOMeeM4N8YDF8yr4kIPx2P/qEJeVTlU4rgn/LG7dZl3oJxVVA4QCNp8YeOn+ZSkYN16T7AZGUTksPFxFTYVkm/MEBVVopoUV0EoM4XHAzWcgsm59dytRsasD2TOT+XSHUKXkaFI1AZghRjLT3q9PDcBOt4JQi+3IUbq1P8NPp1iGbSUYbAvakeLYNlMEeh8Z8qqhh+uLp9YP+ksET/fuTmFyJQzzgXE6vTDH9aVHyzdZlz0/fCEJIczJ1pb770vnvUmwOJzQT3x9il7E5W873CYA5OnWz8BcGN/Dl/Vls2tsnSIaKL06cIRBxV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgTYBPwAstuNkJl4jSCFl5ZQPnccqerRBB6bYtSxQPw=;
 b=CNBL5ezIrI0ETosfLQ6h06R01bVu/eoLDKrCrxS/z694cbGnPpD8qT1KRplLZDCoL+7JVRzxI+5gY+k/ZZgohMX06ic+uae43qxqDtvCPeLwWrWfVx6yI8hk/ofF2CE5Rx9xOupfmwA8m2Qs3zERAONYPX0KZ7WNCNGyXZySNEjJnSX1P0OrawaI7Z2bhq6A+gdQE9lbHxmt62KxAZvLV3M1g2sEfuzksbS5hT/+89zXzq51hUmowQ01yf6KB2Lrq9TUDfD4wnv2Qn0WZsjwDVKhOvm8SZ9FLcbGARvBevjjm0V+oof5Y+IErxXqBIDotvRqmb4/XahGTLHWhBeL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgTYBPwAstuNkJl4jSCFl5ZQPnccqerRBB6bYtSxQPw=;
 b=Ve68qySNNy4o7bd/v2/vZUH25U0ibP02FX2sMq8unoI7f2oz8xSZVA3MALu96ETbrR609c0waufkOzHJQY5wOaDLQtIASYu+AApoeDwgKOsb03V/6wofh+4lDiykaNyTHlPhuWahKzqkP9HFl3/L94ukWNxG9lVBUvnbKWw6k+BZgl8GBxM+uS/dfRBjWQPjKdwiUyLN0fe40gOlNkhP2+8YohJO7X3a4rJNUjEZLXapRh76l5GFP+W0EIU+qAsngyMWsELgPrvKLHzKKbymTQo6sFMKk6WO6VhlpE47q8SCj6J9E4luIj6X1plfPV5nvKqCTbV3asDEfD3e37ol9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 05:41:08 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:41:08 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	smadhavan@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2 1/2] cxl/hdm: Allow zero sized HDM decoders
Date: Tue,  2 Jun 2026 13:40:52 +0800
Message-ID: <c743dde11ad652a65b84d206085d09d7e56b9183.1779957270.git.icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1779957270.git.icheng@nvidia.com>
References: <cover.1779957270.git.icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU2P306CA0051.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1308470d-b2ff-464c-f47d-08dec0698bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	+O3ZUkdmLXoM0nVjIlC0B5zmx+N6fASlESyQH/eVduNVs5q/G7L5JJ7GmZKTwflN8X+GaMBEGX9HLcFRIHHUOMVnsEBNfOeOkaxMOr5wmcY76NBTrURj9QNTKHqcIT8/7UbPV4fIpo3NLjQGpIXi+TLEbmTnCv8oImv15dYz86hKzxV33ChP1TFs7FLvtkAcQHQyxk1rzXQVlDuPDAonkUgs7QUDfIOeotXo5TQUcXHuPEyXVcprMP4Cy/R+gMiANDHpEJWjHXglSuDoAIgflb01CWoX2agLtSbFnq51xMjRAGDq6WFC0Jw4HMFWlhhSkZdq0RRznbH7fbnmoUsvt9qlEZ58GAZ61WqeyVZ73AQFRSiPct7cwjF4gx779g/pIzN4420iIpq+IOvNXkpCuSTZtW6T9UYEwbF8zYinHvL6ISUwX2XWyu4JmblnBCSnBfj/0b2xC+YZO5gYVnLd9AM/dXkMfZL2kXtYnT13Hi8dvqYMHLLpWp+AZQEkKW6laN+17gABurAN9cMbQxxRH0MwsUS++WZBlI3tUDxUco95hsvU4TGA0ZlbQNb0M8dyBRdThF8aLrzbNQCwF+Qe6ipE4+nUV1PUJJy/+peeOE5Ip4k/s+m/Gxi65llwjodBMCF3Hi55A3QUpUDmyx1mFpy4dBfihlsFHVu9FHLnLbIsfB+SxMOHCiS23UlgidGe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUZreEdZbWREaVI2VklyLy9DTnplU2RKcHdZODA3Q0h6NnRPc2FncUxtU3Q2?=
 =?utf-8?B?cEQ2Q2tvcUlDWDFacm9mcTROTUJkWjlwMUt3QzZ0R0QwaTA1RlpDZDJvVHlI?=
 =?utf-8?B?b1Eza01yNEVINlBtQ3VmYWJFblpzT3c2UzlGREJiWUlyVFdDMTh1K0FVYzFH?=
 =?utf-8?B?ekhXQjlPKzYwZ0Jqd2dCSlUzMURZUzIrNE5SV0hnN2ZNMnFVMlBxK2pDTmtW?=
 =?utf-8?B?V095ZkRvMklhZlNHOUtaNHk4V00xZjd6U20zNEovUWVIOGYvT1lTcTAyMDIr?=
 =?utf-8?B?RW9LSXFEZnhGbnM0RW9iZ1FLbkVLblZ6YWpheS9OdXViV2NKR3ArS2F2MEdr?=
 =?utf-8?B?cTJta0ZLQ3FScHhydjJ0Qkpqb0hjOFQ2UndMTUxsVERRZ2ZTbDJVY3pubC8x?=
 =?utf-8?B?Q0dtelNac2p0QUQ1TW9OcGRpbmlTdWFPcDBkK3dEdTlKZXQ1Y2hPNlkzbDNm?=
 =?utf-8?B?Wi9CTDNOSzNJWEJpdGdFWUo5WlhNQXJuTitlUHdzVnRBVStjV1Blc1FYNENu?=
 =?utf-8?B?eEJoY0tQT2NrdnM3MFdiSDk5OW9Db0wwS3plMERQbGJFbGVkSWZpZTMyL0cy?=
 =?utf-8?B?Q0ZTYmFqVVZKUk5mVUV0RHdibjBIRkdOZG5oS2FWNVFiL1pEMHZPejVJdlBQ?=
 =?utf-8?B?RmhlSkFZK0ttYnBMSzJxV1crMjIwUXdKTDR2eDhQWW5Fckp2aW5VVEhuR0Ex?=
 =?utf-8?B?c2tzcnNNSThoRGc0a1ZsQmV1TWt1dnNLYStsaTdPVkYyVEJDWXM2OHRjOU02?=
 =?utf-8?B?bFYzMGhNZXBoTDFsaWViaGd2bnpXSkRPakF6QXNJNFZtNS9BbHMzRE5nMzlr?=
 =?utf-8?B?NjRCQ2NCMDhmRThzeXM5THpucTRHeTZIQS8rM1M1NjZZS21RbkovU1ZFSnJ5?=
 =?utf-8?B?dndhbFNJYXZXczhhWFZabklPcVdrWkx5QzZ2THFIeXhzQldJRW9rNkxjb1Fu?=
 =?utf-8?B?cFh1Y01QMll5VWZZU2wzUFE0NWMwaXpIUFR6bnlXYVlDS0Q4VUx4dVNxSFRF?=
 =?utf-8?B?b3hreHdpSmJDY21MckhES2F1eHVvazhmR1JVeFkzcTZwZk9WZUUvL0hmRFBM?=
 =?utf-8?B?WlgzNUh3ak55K0VDSExkRXhiZ0d1dGw2K1BHc3V3cUZjYmF5YnUvVi9nZ1B0?=
 =?utf-8?B?ZUZuWTBSL1ptTEtKRUJrKy8yd09uZkxFTXNqUHNlMnMvaHZ0OHQ4K21KNGlE?=
 =?utf-8?B?UThlUnl6QXRCNWpoNVFzMExucGZtT08xS09Sd2srN1ZHY3dxOEpid3QyYi95?=
 =?utf-8?B?WXJETmwzSGtxUDVFQnpZeU1QVHZEakU1cDFWU2tXMnp4VHMxa1pUMjUzRXM2?=
 =?utf-8?B?NDBRUUNNNjYzMWlrcTZXellkOWlpc1kvSTQwQ1V0eHBnejlxT3JqcmVSTVR3?=
 =?utf-8?B?emNwcG9ZM0xJbnJDYkVOOVZxbGQvWkxpd2NCSEhUbVJJcmZsY2xzdlFmNXhP?=
 =?utf-8?B?TDdOSEFETnoxVVQvWVJSZGNEZW56WnBuMjNTSGlnRkd5RzlqdWZnWld1cmhK?=
 =?utf-8?B?Znk4T3QyWUxOWVlxRzVzeWdxVkFmVk1EVFhQV2pyVjZwa3d6U1AyRkZZYU12?=
 =?utf-8?B?RU92ZjVVY09ORnNGRE03VS9CRkNlYSs3Zkg5SzZNRWVHWEZ6bFZON28xc2pv?=
 =?utf-8?B?NHZrZTJwU2ErRFBKNXllUlRqekJBKzkxUFErZjgxemN0b3diUFhGRll2SXhp?=
 =?utf-8?B?TitlbnNZd0ZQMXU0Vy9EbXRwZEJ0ZVFjWFZyMVVJeUVYV1pHaVpZTGdxZ0JI?=
 =?utf-8?B?Mmh6ejkxd0xhSXNNZVprMVc0c2hrMEhtRWY3RWdzT0FtcjU5NEIzWUFzSlJJ?=
 =?utf-8?B?WVR6aTVLd2drbnU2THVWblI4cUhxVkNSTm90L2V0c21kYU1qNnZ6eGdFbXhm?=
 =?utf-8?B?cG9Ma21iQ3l3Y3laZ0RjWHcyYWc1OGxRd1VGa01vOUV1LyszRTZEbEVLd0RU?=
 =?utf-8?B?U0VwYzU5QWdTbWxDKzNFQjNHUm1Fam1FVTBxMnl5bnpJeHZqSVo4bFA1SSta?=
 =?utf-8?B?SXI3UXBRYmIrMU9JTDZhZmI4S295SUYwbFFVMnJSSzJQMUdCUGZJZlpLQytY?=
 =?utf-8?B?OU9hR3ZoMnFmT1hKRnpsU2U4bjFjS0tIUytteDcrVW9sQk9zVHJaYmE0VEJ4?=
 =?utf-8?B?aXlhb3VXdmYyeU1xOFNkTUNsa2xPaXdxcDNWMXhxQk5mc2VBUGNZakJiUEpu?=
 =?utf-8?B?YURMNVNmOFFYM3RuMHo1eTVGU2R0a2dXN2NwbGNoWHprL2UzbWovQzZKSVY4?=
 =?utf-8?B?ZUEzYUh2QlkvemhhTTZaRUdjZTJYVFR5cG54TjNLVkh1eFBIZmYvWE93dmNC?=
 =?utf-8?Q?XlJrNiQrXFB+XhCvD6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1308470d-b2ff-464c-f47d-08dec0698bfe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 05:41:08.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+eJJxTeS0MwYxLUHZ6xcsKx4xLo/0AZGfrOTlAZeQ0N7lvl+rD0/qwAESoT41g8S38hQmfpaamhBVPV+RhoMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840

CXL r3.2 §8.2.4.20.12 and §14.13.10 permit committing an HDM decoder
with size 0. BIOS commits and LOCKs such decoders to burn slots,
preventing the OS from programming new regions through them, e.g. for a
Type 3 device in a Trusted Computing Base (TCB) established via the
Trusted Security Protocol (TSP).

init_hdm_decoder() rejects these with -ENXIO and aborts port
enumeration, so "cxl list" shows nothing for the affected port.

Set port->commit_end before the size check so later contiguous decoders
pass the out-of-order check, and skip devm_cxl_dpa_reserve() since
zero-size decoder wouldn't need to reserve DPA ranges.

The decoder is added to topology normally, LOCK is read from the HW
control register so "cxl list" reflects the slot's real state.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog

v1->v2:
    - Add zero-size committed decoders to the topology instead of
      skipping them. Drop v1's -ENOSPC sentinel and the matching
"continue" in devm_cxl_enumerate_decoders(); fall through so
add_hdm_decoder() registers the decoder.
    - Set port->commit_end unconditionally for any committed decoder,
      not only non-zero-size ones, so subsequent decoders satisfy the
out-of-order check.
    - Add an explicit early-return before devm_cxl_dpa_reserve() in the
      endpoint-decoder path. __cxl_dpa reserve() rejects zero-size
decoders
    - Spell out TSP and TCB and cite spec sections in commit message
    - Reorder series, implementation first
---
 drivers/cxl/core/hdm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..467ac45bee55 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1031,13 +1031,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			return -ENXIO;
 		}
 
-		if (size == 0) {
-			dev_warn(&port->dev,
-				 "decoder%d.%d: Committed with zero size\n",
-				 port->id, cxld->id);
-			return -ENXIO;
-		}
 		port->commit_end = cxld->id;
+
+		if (size == 0)
+			dev_dbg(&port->dev,
+				"decoder%d.%d: Committed with zero size\n",
+				port->id, cxld->id);
 	} else {
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1096,6 +1095,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (!committed)
 		return 0;
 
+	/* Committed zero-size decoder has nothing to reserve in DPA. */
+	if (size == 0)
+		return 0;
+
 	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
 	if (remainder) {
 		dev_err(&port->dev,
-- 
2.43.0

