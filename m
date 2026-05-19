Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B56175A9C;
	Tue, 19 May 2026 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233744; cv=fail; b=lELZdZob5gmSI9/DjBTjRlve3wOwGzEHCDF30Fi3DdzkNYqTbHoVHUDAWaWt2WSVUV8QXHBSMeHKvv2D/ohhG67vEvX3mH18nKzJImIsGHxfepN27OgahYhqtWx7PWsSoP/rNmlkiXqewVLbHsOxNmkvLAZV/KqGdBf0+GLRA1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233744; c=relaxed/simple;
	bh=gLKKpO4jhh6auUo65yGGiG+ccN13NJq92i6rbOEGefE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M4J9ISMfghcTaYpO9OEb+wd4lfjQZTNX8LDGr6jgmYgKQfFcCAKa/iY0tolyXL2L+J0ReJV+Sz0/4/N1JRYL8pN5GLFb63LX12TodDJ9oFQBQ7oD/M0477rw/9cV8Z1aedbKFG+1gnPuo0nOnuGFU0Xu0JFJNJIMzI3Rq9iuvRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r2S42xqw; arc=fail smtp.client-ip=40.93.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r2S42xqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVfPfMk1JGCjOIEHz/4uli8b8pV4Flq3abZo2weafpCMRqnea0u9x7OS0yEQt6H94M7cVWDIbNg4y5hNjNYiuXqgOz94CJIzaUIDSMLvzao0t2RluUlCzMvAjd0GLABWyZ0EUzlRzeTKyT3y1zqtghOWsTSKVsLjrfgvBTSLJlE2j6Z+wusGh0QG5N6sj52QfB3oqxaimUtqE7cuD1ft/N3ERw1aOAWD1co7L+KAxd1TpR4QkWabbDN7YeQupeMIxlGgPMizblEGE+/mWun/Mj4fQYioG99USia1jDVLeMmXtR4nbgF3XG6kEtm3UtNiuK4zoT4A8i8RW6ag0kwBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RUKg3KPZP8YdM2u+kdvuW94uPvB+c7Rb8alB1fOj14=;
 b=WWRn+RDfgutb9+E7hXYG8hF8yd+QGTje24RGi+4mBepqMTsYjDGuwHbMu6hHoRUrctHcQEExDNmNhRvq6m4QoDJOpQl7lX8CVzHZNU0P8gNfnx0Mmw6ylvIfa21n7rF2yF7U52VzmfT4JE+jbvObZkR6DXY92m46jBNU2IoGPZawGaKidTJavoWXybU6Z5hq6ixwXARWHrbNfPpS7U+b14Ztjts6Qk0qYvmQR+9qXjm/7xQH7bP9wG2Xy7DJ4eUei95r+l4XrSs2pKKPYeHYW+4tEbbx5tmUcpzKo1r2T2dpjmHyxCOt4HC/uc+m2oygqdaWX8k7WeGR3K0V3jettg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RUKg3KPZP8YdM2u+kdvuW94uPvB+c7Rb8alB1fOj14=;
 b=r2S42xqw4Q/28higNzf8dTM8H5QBudb9tA3X/x5WDWAWehAXG+mdyRessMOzJaae0btUdGmbEnjhO1eqkov4E/xG90/oWGt/rDVEVtiVAnjQtzDGMPvH3tamQ+5WFmqMvS0y3zoEGOo/qC3PBOR6jGbKHYaqz4KbzmmXILggRHPJSBi9x1+YrollTqZzDZVGz64c4ifiArPh2JcBGlMAUZVliO8yAnAEsq5+2NH+vItqStieI+oqxFjTrFbbDF9RKkj52ob8lArtybnS72jEEordGEieJrh4D+TBeD138Ftt6RK+cV9fb998SU1TYPHZ33k0xooZJxtNLAd8ApJv4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 23:35:35 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 23:35:35 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net
Cc: jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	fabio.m.de.francesco@linux.intel.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] tools/testing/cxl: Align mock CFMWS to PMD_SIZE for ARM64 64K pages
Date: Wed, 20 May 2026 07:35:22 +0800
Message-ID: <20260519233523.5991-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR04CA0025.apcprd04.prod.outlook.com
 (2603:1096:d10:25::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 3014b1ed-85c7-43f5-d478-08deb5ff534c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	n4Tn8G9L8YTHQgRaIvDCus22YjWkkNcmqd686Aa3xBmV4gSDvkSSsdHvWN6FeI+St5qko73cNB0XX2Hi9pGVA6bm2OK0qK0FEcRRk+34CMUfnXUvyVJ2GDo1yXVPkWRgyuty+ci5K+DiUTXvJkDXq6q5PdfIWI3wjQDXqHsM73eVIwdjtdjFzfscib+pt78ISsY4UhWnES/k1IfCLheiIWHbBWRNvtJGGxfnc+lZiKY0gcO5oaT/k7zekg/OgsqK88L+FzZJ/GrSNM2/43HpmZELD1xZ4HLVLMfBtKu8B3xAks5/HZT8XllHVgBOL5JoWFeD826mwr/zRFDUs4nf8UPlNcGgngB/NEQhHvegp5Zcvqc+RlbNjxwD+74Lfne6C48P0l7GYXopB9JATrlPbicG20qYMogaSskhLB4XlHZs99wGTibNiddWHDBw8p8H5CNtSvjPzsiMB/q76+kLK2/9h9OnvVnQdCScoUuji5MVztk9Pgdvu5beE+IUq7bIzGXdC1rzBuGMqT602sQ4QRlxGRyK9GQ1pabPsb6Wzp87FoPP9sygdfsxK8IaV2ZEgYKkL7KwDPdqcFDYHsaY1vDj01x3cARiUOn57iAEPWJIqX8+YjibjdLUhqSiHgY37YUyzUvNL+oimfCL06zVwCUjglARpLqWPmBSPi2pIIGARS6ecWapnZRm4zCbbrwR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(11063799006)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4KWD5mC1hZJBInnjSG0RPFmIcb75XTa0AKjViZAXajQ6nDDdZ0m2fS83xzio?=
 =?us-ascii?Q?/jhpy761O4/gQWfCLQ79qUhKl5ow11ECw4XP1JwoH1lxMA63eQcJ5mM/1TwG?=
 =?us-ascii?Q?Gg91Q4efkjzXcZTx3jT6rZObjfVXx5EJjTgRsN6vDdSsvNMP9LZpAVKJl7VO?=
 =?us-ascii?Q?YuOl35ZvgLEy1YV7Kr5COTEIAur7fAkv+ey8P0JBIrr60ixRUCat0I5uEHJf?=
 =?us-ascii?Q?FSTeCn6fKlte+PFoKjbkPup3djU+k4brudRFtiNdCZPkGl+PTBpT2qPROhkt?=
 =?us-ascii?Q?znIX5wtttQ00QWUjB/Gk6Wlj6Utu16smzO9CHKewzFSMGAn7sDS/I1CflHcN?=
 =?us-ascii?Q?27AwqwCI6/KHimz0fS20O3s4mNrbC6aCVNlpBO7iW7tWoW2yTv7lh2qXTx8h?=
 =?us-ascii?Q?0zNUPpXDI16UChBeMtTTvnhOJNsAoi7BYHNxabOg8nMBtfOMs8dOdlLtO1NV?=
 =?us-ascii?Q?mw04KsWEQuW1gkRO+TzaizLXLFxlv288X2X64GHuptqOYaiWSQvNAC9n8iVl?=
 =?us-ascii?Q?zesvRY7/OaBlu/TnSNIq6QSecB4i1FEGxBquyo4J2C6Kq0KsIbup+sUyb9yD?=
 =?us-ascii?Q?svAym/oiQ52ktkhrk1GN+1ww6Jk/2QuZ27xpPf2L7wjWAS6oybVF38OO4Nz+?=
 =?us-ascii?Q?99P2pVVWXm6RALFByxmBPKD6MGuS6IaKN8wQ6gM6MZjNFOKDRmIcPqW+MTcQ?=
 =?us-ascii?Q?KIXVVwloC7Y1j/psbK4S3ftRfAQvfjtJhfzwSWoCtqwGDLS9vrsPQXOtiCqz?=
 =?us-ascii?Q?RfHAzp2iQ5WKX1dl+u0KcB309FCF2N4qMEjlF9clR9bhuAUaVrXL2dNDmyeS?=
 =?us-ascii?Q?JmzaxEY7dpnNGaxc8I3iF4t5JWPwjcLUnPdqo8Y6oNypsAx43LujmRzjH5j3?=
 =?us-ascii?Q?zJe7XHTGN5dl2EVVWX3g0M93tptVk/UY7KyjPfbgnNY0XpzILT7VpHPTuhEH?=
 =?us-ascii?Q?+N2/aZHw85AthQeK8esO8FkgBWstsHrnf41sCuoQzyy6iGsYgdII+nqHFISQ?=
 =?us-ascii?Q?wa+VGJAwPpHL3QGmtP25w1xcl1TJNLLz+JjoEeUTvXrjbmwm7wEzh7fUb0ue?=
 =?us-ascii?Q?UaLz72vRTCKOOKozkky3Z0UohRmC0ydW7WXPtJMtF0wj8niPG0dhNXcyHSCJ?=
 =?us-ascii?Q?7H5NWFzUlQ0qR4YCtI0Gf/dD9Ti3OQc2JN1aWkUDpXt2dPHH2TRfEAWjdxjf?=
 =?us-ascii?Q?bummEswRjpK/mgQvfUVOBLmoB8+e6M5nWg+JbVsRKSg2QY4qJiR8zoWSkfTb?=
 =?us-ascii?Q?llMntSEr5co7wGZpPrkrbLHMXTOxPGz1cNTrov1Fzk3v5wTYejqNVg0U9C05?=
 =?us-ascii?Q?fADIIuDJPGJ62CzCQSrdJwELLTUgxfwWnm2WCkgvWvRmjv8MaiMgkbT8T7R1?=
 =?us-ascii?Q?YdDufx0EcZ0vKqKYpUZ1kytXnJy099LbOGIZ1jSHzNtHrrFYbFm3abBbYF6M?=
 =?us-ascii?Q?PX/Em4GgsQXu4R5kCGknBDNdhRoopR5dQdbUozCJAH7zP/edMIC7/Bj73cCv?=
 =?us-ascii?Q?T71JieFEpILEEVeE5nIztSphrpEAmbL5QWUpMXd1VXN800fYUlSR6U1Lei43?=
 =?us-ascii?Q?Thex9pxxWb0vNXaBCE1EiJc1/tXfZ+gCPU0GpC6kFfFwXqpAONwdhlZYq4t5?=
 =?us-ascii?Q?DyQm83JQnXI3t1sZSwviePrVgLte3DmaX85rDiWYRW6AD3hjwO3pClxA7N4D?=
 =?us-ascii?Q?tCYaq4SiYrIGshbXc9ceWXRVrPWnk9uIi3636Ows9uzax1Z26XvBP9+GkSz3?=
 =?us-ascii?Q?DKk+TrWNPg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3014b1ed-85c7-43f5-d478-08deb5ff534c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 23:35:35.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mdi+tOKzhqGVSLW9cN76l1FnoYb/2uAkK/faAARve8cXL+qpsL+j+liL6HzhsVmSivNXIcoAt0svmelNFzHAJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830

cxl_test allocate synthetic CFMWS HPA windows out of a gen_pool and asks
the allocator for SZ_256M alignment. It has been sufficient on x86 with
4k pages, arm64 with 4k pages since their PMD_SIZE are 2MB.

But for 64k-page arm64 kernel with CONFIG_ARM64_64K_PAGES=y and
CONFIG_PGTABLE_LEVELS=3 , the PMD_SIZE is 512 MB, which is much larger
than the alignment cxl_test guarantees. That results in every CXL region
carved from that window inherits a mis-aligned start.

The DAX driver's cxl_dax_region_probe() then calls "alloc_dax_region()
and the probe fails with -ENOMEM, with error message

"""
    cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
                                with error -12
"""

It was hit while bringing up cxl_test on an ARM64 server with
ARM64_64K_PAGES config.

Raise the alignment passed to "alloc"mock_res()" to the larger of
SZ_256M and PMD_SIZE so that the mock CFMWS window is always at least as
well-aligned as "alloc_dax_region()" require.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 tools/testing/cxl/test/cxl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..b40e4bbcc958 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -497,7 +497,8 @@ static int populate_cedt(void)
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
 		cfmws_elc_update(window, i);
-		res = alloc_mock_res(window->window_size, SZ_256M);
+		res = alloc_mock_res(window->window_size,
+				     max_t(int, SZ_256M, PMD_SIZE));
 		if (!res)
 			return -ENOMEM;
 		window->base_hpa = res->range.start;
-- 
2.43.0

