Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021626B95B;
	Wed, 26 Aug 2026 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708775; cv=fail; b=Gh8wi5c9LxePxYULOV5Sjhpkbih7axpoz/1n8rwUWZaXrUf4VzzMhvt81LHy7ozsiMHMtUSq41uw/uNUWwKysu31MtI0A5K1P748JzULD1eXyiSGcwGCIak0avF37hAlPCs6W8FtA5mVZNvpK8H2JqcI1xal/zJ1dJ+qKPpsZFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708775; c=relaxed/simple;
	bh=mlLW6Fu3SHXAjxvJJgN0jlzuuuva0ZwysSI3K6inlw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5N6wRAAeqXRgV1NNvmWZdcXEucKhJ9JEmCHftaL3P1O/xy8giVeOymejuKzYBjGgyFb651TLQ7DpnZoxf5v2xCFIBpr88Cp9SwBn6UHhixRv9TUs9JtFxDKrQ2D7Qj8qWzO+WV6ytaMNEbPf8y4O1IGeJJZ8U/FnGdjimEqKmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ma2BzaVL; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ma2BzaVL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLuKxtozWgkDSWLBX28lOhipTL/+uBGRsfnXMPxz9CSLjIDVLvZXLi/Y10sM2LwiC94TEM21TgGBqESvxoxZoAI67BgzaMSVSaAYPqjLXzLc/u73SCQYASceBSFvdJk/kZOftxzKQGqVpILP0QsT/qqaZgOg3hDPgDo10JeM4zpQrBa1Jwv01swD2gZgzxcteglh9lvDrRl0Ij8jX5jxgv2tqpeFKOl0+pFNsBK9jf+4ZJWTu+UcFfKevjr0FMhLDB5YsFPmc1YxENm3JKmlyHrWfPZOFH2kOSoMmKVmB+8wQlDOF0p4YqweVagegxKMZ9HnagiW/PEWYqNfhZF2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkFrn+OVs3AqHAcXuyxYWr8rlynROsWHe2sAq5dBERk=;
 b=sQ/moPVNmk2pI0IbVW0arjJtExiFUOLkWLM2QZHkxnaoQDqJV23WVvoyN7ihNRiyMYP7hmfn9iskG9mVZZ0k3sAMRa6iKcdGGt2Z+r1Am+HYBRhR0BQBn97E0c5go/uprBxZHT4tAYbm7M3pjxaxDoQoa3brhj90ktB1HWXV+nN7tkdqlxmjBID5c9yK3IopaaItw3smsi4tEsGfSGmucPSRUAkCdqGE33aLEJ8ZbOBpkkHZkFdrLJm5uzV3EbNSoCkQFtzlU/OsyAb+w+oAOKMSNO8s2NJf47vIGisjfSVv47ri2k+lUgQhGpBErqGtPBvPIridT9NbWb+lyELsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkFrn+OVs3AqHAcXuyxYWr8rlynROsWHe2sAq5dBERk=;
 b=ma2BzaVLuqn7mRitVLWoayzGDp1SttAoXm3zL3+hLO+mXi2Sg9tB+XWJoFqAOgxgFR4V9MAJs49ZUFZ2bEsVcopgqDLDcen4MsaieUwwuxDFnT/cNS+5xRQLL6SSRu8BePYDgZ+Q2yI9iFuABYPoTs20t8xkX6XzIPJIqrc7txsAaRc7u/oX5NC96Nx6zxdF1uOWEvc0+Hnx3V9M4TvLaRT3zwR5xyUPg4tK8qiNq+QipEm1Uy1LyADIpLz/FYyMChL060IhjXO9v0cIOXuda9tdWrmRQAg61jHABd0C8tXphYfJ0cOBJi64jOOnX4dAptb9fqMjMSGfYXkj8JcKcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.6; Wed, 26 Aug 2026 01:46:07 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 01:46:01 +0000
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
Subject: [PATCH v6 5/7] cxl/memdev: Don't overwrite the error from an earlier partition poison query
Date: Wed, 26 Aug 2026 09:45:06 +0800
Message-ID: <20260826014508.9989-6-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260826014508.9989-1-icheng@nvidia.com>
References: <20260826014508.9989-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PS2PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::24) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: dd85ff22-813c-44b6-121d-08df0313c80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tCqoWL7bP8W1P52zwxg9Uk22HWAlPmAKQh6OuznNi+OAcjE1UbO1Jf/+Jwmt84plp3e72v3Smxgs59HxI/yIJLKqEfASHGazpOcBoHNLJDZbrW2sXfzQy3ZXvMt/0JCMFgrUMDNIIO8ji/ZekIpkbbuOudFU+l59RJQBAJ5/I1CP+mtUbHVY1S2jFlHwobQMvdpbNd2a5uKMyKuaa9d2WF0tPFFNjrUOQPpVehy3+oadj211YnixzhajtWvPiuV6zOtGOYnvrUON1Y50ehhDW+gxOXaTRz1i7690DHnK+Ypaxv6MrV7Zwy9SLPAG2IrKQD28kt593d/sxDzWOhfrZ4gPfZYYV+nBrT/z3b/DhReQPE6gKe6AJqfgIUNe9FO+qYYlEt+G9mYX6nNGh3hC6QM4mC1XDaTDTWrZgsss/9Lqiw0gBxsYlvv7QPjW/+OwYuiWefznmbkXiyFiNQQ8Vi4DUeKAT9YMBzmwHuzrKjO7MWhnmGgMv+Jskw/t5YOtwfSGH5j36mkwJSYxlybNljou5VMkAxygLsaGRhxiclbDmc0F0THtwg5WqEy4u7Vx/ZbuRhdiVip29RprE5Zak8bxUjDdDfipPrxEfPTc5Yv06m9Z8aEs4KJKB6SCtxI8YXVczDdEysroZsNbQ5IEYd4mvbRv5YLfpEcTIUlvTbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jUXz0DBUrMNdAT+SRcoYySqIT71cu3gS32HmV8P2BT4im0n7PM35LQW13LjT?=
 =?us-ascii?Q?d4lV10RvvKE0CUeJSRiB4bEdTLJlpVUywz71e8mu4Jz0Vc2UsJTclAALjgXw?=
 =?us-ascii?Q?wn+gVV+GHJ6aSSMMQO+s8Yv3VFHQ8tUeCyJ+MT4jZQku8nrkbPI7Zyjg61Ux?=
 =?us-ascii?Q?eS2tIVeyKvtPS3JvnFxMNAsOP7mrZ2jTX15Eq8NdKXeE9Ze4DgNdQPwYTzjf?=
 =?us-ascii?Q?Kt5skoUyAhAsAlKs0kTiLzeye3IuuWSmQkk0Ci1P7ZUe0uMoEh55D8a62QAm?=
 =?us-ascii?Q?BJUjBl+6U0Mjne7AFap14HXETvWKInsjEaKh7oOsZkCCUiZlixg0WLc7iiwJ?=
 =?us-ascii?Q?5D0o/9R7J0SknVRpI5JyXJFEuv9FjdpVWSEN/ejHEQDMwp40TVcuzqbo1gkG?=
 =?us-ascii?Q?s7oG4N1MbkbeOrWd6Bd3fm+U5CzperGORq5H7FSGlRzV+3BmPjxh6+Dfgo/W?=
 =?us-ascii?Q?N+OgwEvtYindYZlDujJJqmSrCNXpGYd/90i42VTbW60P2UVeI2+rdEAXUbIY?=
 =?us-ascii?Q?W+koiuzcuXFKBXkoYs0OndeuauWLGaNShM300gBy/OBEJjVz/awb+ZLNw0yo?=
 =?us-ascii?Q?d3VIyG0bTb+4IWk0IzcCRnpoeFJBaeINFh3NZ1qtniItkoc6CMmClS+eFfFM?=
 =?us-ascii?Q?Dv4kMwjJ4iyZtp5rxVTBRpmNm8ihdjs59wUqVEBi8cwptbVgrvDS/Ngx5ba1?=
 =?us-ascii?Q?vKavgWhOHI3RsQFe1mg2eX1boCIYqAYf71HFCOCItoXvAvKJIUyTgII36CjX?=
 =?us-ascii?Q?kr+9c8BOyJDUu39NlRI60r3J9lv86yC9bfugsIyumkpFTX6w9M0Tb0+LS8VE?=
 =?us-ascii?Q?z2w+rJNneyThp6G28pNa6JUkOvQpgAksGBHF3MHTVTFo9/MNvLb+JsAraGRj?=
 =?us-ascii?Q?JXjte0jSLevfil8OyPWIl7sJ/6zBM3TzUY072iv36iTuDWFrytAxqJvVQ7T6?=
 =?us-ascii?Q?GS+8xgb4DXB8QhjAmhviM50xolUkv4glJR4v7NmdRxqxwKh6lnRdP+8IyrEO?=
 =?us-ascii?Q?ZsAwgJ7XgGvwxMJoRcoApJx72eLOLgI1VLtAV27E0ntP+gjgzrRzwc6/wbU4?=
 =?us-ascii?Q?4wAf55dDLxKC4keI75kmLEWgGfDUZPFI3W52rUxR5+eCP8FHrE3OCdR5vWkH?=
 =?us-ascii?Q?mzKjMd9EW5TaiQEo+aqmsBeGrIUVjElr7YXiY0PTEmUM6CGZ90ocFLT/1eKH?=
 =?us-ascii?Q?AoTvX4rz9brvlqZcTYKvqfNbVreQt6nGBwbtx3V2SflfEBCPlG37UfojSqEh?=
 =?us-ascii?Q?lNemQ3TyxTE5/SLl6hkDpjiUPkYjTzMWCTAJqmoJdJLOKVAGW7VAL8JAHJu4?=
 =?us-ascii?Q?EumlECe8XS9b6OCqSZDuiBfcpDdT9OlZZiT1xYfNaG2d/s1aD1D6zh5yuq07?=
 =?us-ascii?Q?ud7Kl+rnqpOW5gMj9RM9U1DhuqauNG2Hvh/QeGk2s1zbhhdwr54ysx+MT5iZ?=
 =?us-ascii?Q?3zCPdTx7BidK7p84cHNaw4YZJfB+EBiPSPESSGmQYl9bnp4S8aKj3nZ46dLC?=
 =?us-ascii?Q?cT5Fi77qoj4hGt/o1uGLI3nhoFme25fzXky9gne1Gnwex1nSRkktnTzJ2t9p?=
 =?us-ascii?Q?Tk3g8+eNw1waR/eGyq091MmFnTVuj4V4TrFnr9Y3aXuDnEMbWJ0gnVMwRGnd?=
 =?us-ascii?Q?ZVTA6L1gP4vNDlscnhPNMmYScEw7g4gJlwfUXjFUeoBcoNW7bDQFUEmhiQ+I?=
 =?us-ascii?Q?eUl3rFdrgWa/ATbgooWE8uJVszveh/ziud0XYVUvUNFbVobflr0DPciU3hCV?=
 =?us-ascii?Q?+hYZZZ1Ikw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd85ff22-813c-44b6-121d-08df0313c80e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 01:46:01.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jyg6ZPokhc6p5D6VW/iICgpcvqYn6Xk0KNLnpaxCTRMo8oe8WWqzkRY3IFPHqVZhjfjhHZ45mBtjHwQxIXGTDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - New added patch ( sashiko-bot's report )
---
 drivers/cxl/core/memdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..e39b3d13fd56 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 		 */
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			rc = 0;
+		if (rc)
+			break;
 	}
 	return rc;
 }
-- 
2.43.0

