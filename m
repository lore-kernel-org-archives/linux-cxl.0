Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAE35E944;
	Thu, 21 May 2026 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352395; cv=fail; b=ayk8weOlUL8yrivcil8mLFHnk6QZ2Hv8EmZXZTIv/LZ1wf5Fg0QkFQHunN91GQik1ehOV03c2GnmeW43J+U5lcUId2AE+RmV55F0wKpZWv/MeeWcdHJl1kGmQMry1PpknWZU9uZ7AiJ5WFQhTvVS/ZhazGWGpTJ7MJW/9kRV5no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352395; c=relaxed/simple;
	bh=63lRmegzcJo4fx4pXgUq1E45fSAdd4bST3ccqlExpQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gfsWqHseyD0bqKf78R+sO06FkJvzceBVcOv6eHoAUOJzmwj+PJXuN1nRl/ti9zfS+dLM5NhH6ENjTlro/id9ozYcPH9kMW2RRb8tiuyabNLiRW5NSGSGTdKfQCgRdNXIHRWwGY4+hK81OJfnTeXblrQSXcon2OjIbGfo0dCxDHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hnjd9pS/; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hnjd9pS/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViyzMcdVMegxohO0mmGqtcnx3OCs7MTXRmO4ZIj1WjJzj+AMlcma3vTS8X8mqlF7f3rakOE/GWL4yUVz8QQeqFuNRyzpy9AyCMGSc41o6p2BK6sAqjcfh+lr6AZ98vp046ca57TZoGUbWqeCe/DsPMPyGoSoxwVvbDRQikq5r0i7kqo5/xuTV4Voo9fw2QqqEWHTcWhGvbsholXKAvYsWlchzrsJfdX8qEMFHcornKkIBtCDZWjVGei5hv84U/6XD9kgl+6dx/A6S/1JHyuKGH2fhhaapWVvOXVVXogI9YN0wd0lgIeXfbwivGL1BgNKBzzmyE+KtM+2s5dcZZEMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS2DJEJ4Jxsoyd+9+qlf9lVYf8JOK5g44M8PXGScHeE=;
 b=R+Syv9FLlFB+TaX/nOevcTm/efvmOneiTkFYGo1yh97gIKfrid64xypOaCpwHNjAXgj9e9N/HnJc3Pue7TFCjNkT6FeB1VSs8bCXeCE+UsNlt7Bg5k4xZ6lCwacxoB5qZD5ArFSbCCFavUigM199hvRy/NVW8QHmwdbndf0C2B3ZkGsSvzHurE8veKdVKrx4+2Nezj4g8SmxCZeEigs6tLfLpeKM8azHLCjVSOFkmEuKhQqU2QRDS6p4wU/+V0GRX2hJ8UHwsyBV0cfOT/IoBLqQJvwZcIMahXXoeKcjDO0BOAWttxwP5TfeTsEB5Lo7MySfjsJfQMPsOLGhyviN0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS2DJEJ4Jxsoyd+9+qlf9lVYf8JOK5g44M8PXGScHeE=;
 b=Hnjd9pS/3sWwUXoIwTxQ4+gbZ1X4ZUahJ/7ejjyG1NXjxip+4Anz5Ku4uJbn37jt4Mk3oezufI920sPMVYmooXd3EMZKFbKFusq4NbCP0j0y1OtfX0eoY7aJFp6BNWodp8wvqdnDUJgYJI2AHA0HRPHepgxKVaaCKFiXSqR/Z7JjmhsgEF5UEKXVUNHedP93O2INViBeEqSuFFebUd8gBChUyEq7rA6IUftGbGPAMbPUbOcb9Sz98dBXOOKhXLUYstyR+7uIU7SvvdG92CeadFRFCQQ6qw04f8FZN72r8sGT5ib3UcxUHf5KjD39rrhu8fY0cHp+8slWg5PFnrSyXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 08:33:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 08:33:05 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.ne
Cc: jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v2] cxl/test: Enforce PMD alignment for volatile mock regions
Date: Thu, 21 May 2026 16:32:57 +0800
Message-ID: <20260521083257.27753-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: d10683e7-fb23-4531-a136-08deb71393dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|6133799003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	HQL7VWo4G3Ug9HywBUl4MyQs6yR+DddRAWR9ZbHPGcIQrWNfxttNzq5MHhBVsOxjZ8CRn1r6cigRFby2arbpBOoa/xaevfYqTjLmWmFHUtzX6Y7cJFS/eQKAR7Zh7RcVdRRUtpbNauRCGLOY4y+8Na4WIM9M/rSeA21tUfVK2VxDk/BEd3vaYxpVBqobYCBmaykKHn5ed4bMIELPVdTGGTL/PEipvACc5Vj3tO/W2k+oz9k9TOPx2zx70jA1BSfKbU+0XhuiMc7yeSTBee2jB4yZwZYkjYYmZhJoxEE6r6UCfsqa547bdvr0TkIRlBP4yUSamiNC1Qv5moWl+CUFf4EFtXFCAK3/codVirJ2zItzw5NdPTWlIk20RLRRuFRcj7/3vGJc7gXuu8/nKf/htqfhhI0oAjTH7H4cpYDxZGA8ZLicUTfs85dPaA/clunkMcYCc7/w7RzZgoDe2X3Khg4hxYEgUeq/Zog2JdtSV7R/G+lxxXN2CEjqBu3T7ai9L3gKV3qCfJquHNBTX8MldfY36jEjfck6jOk4ut1svUfsBPuh+wsdhPfQ3vHVM0gcncRG0agCoKvX00hJ0bvbZSjirRkKM8V0ME5iVRy5BU3KZt9aurgFs0hcBESTlLDkwMHS6HO6SezsMvuU+YldarMb7PyihB7PIcdsVQixCRtK3xZn0zcXvszzQLih9GOoT/gMNtHYc8kmFHwVZiPxIg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(6133799003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wwL8ac8DJzYHLrKxwvaAa72/nuIG9uwuDsmoFKo9+U4L+86kuc1MVinSt1ok?=
 =?us-ascii?Q?lF/oh4nH8RZ8zr05ju3lZ8cjoL+vkOxvzdIvY31096w3UFsICmMTB4Sec9Rs?=
 =?us-ascii?Q?eRiwNshxhpd5dOckQcf3QJOM4FRV2dCPrAGy9Z236u7oaIat2W+nvOHctCd0?=
 =?us-ascii?Q?4FvCIO8vDLVaG1Tuk3HkWa72OBZ72dtXvJgBKgchEcsA25jWgdtS+sHszMMF?=
 =?us-ascii?Q?bRWGJEaXT+2gTkQgTs+bexpiTBqZJHhdAMx6ZgwP9Z+Egf7C0Gr8LUzabSyc?=
 =?us-ascii?Q?KmdhuGeWv+dgMjD4GedFQuV4DqR5g3V6eYjVwkXvxpr6yFlC9UTYll1UFaMX?=
 =?us-ascii?Q?QYB7FmgGkf7QF84bnpEQ5c4BdciVvZ3KIXwXdVBXAe7G0BBDhTsOOp5Ixfgp?=
 =?us-ascii?Q?kGIA6ceYqCU6m216j8751fn1VM2ek5PKNeGb8zVbX78yikAPtwd0qzpP5X12?=
 =?us-ascii?Q?5VzK5P7DWisn1wohwcNgSGkJg1NsCUUKByyWV+ULxnzUstI5M/pNS5iNBvgL?=
 =?us-ascii?Q?2MoXofsA2993qRoZ28YHlzEcU7cecW0U5wY8p58nZ+IH2CJ0g8zQZJXUIthr?=
 =?us-ascii?Q?mLTWrHLItbRSSoE/0CNODp8GEyMRYrPGpGHNWS46s5McQjMpIUc8u3/b+hI/?=
 =?us-ascii?Q?dvP0MOZKUYz/3UbHBcd5WnhYIPgVdMYXlR8oMH5TsrfqR6SSnm251x/0crOT?=
 =?us-ascii?Q?fzXKaBrjRXV/s2ChFQniROCyr/Sm6Kmc3vfWG+kY1S9IvEAYkIwvmF1NY7fh?=
 =?us-ascii?Q?R/zk4e1NYw68CuVIW1wmdniorj6sBtjIPJFEC8vVHZBvfMjZ8G/KziJ5xvnT?=
 =?us-ascii?Q?sJkWRCmj/s3AH9hTMh7r5/EaXmsxYysV/FmllgEzuZBRwI4yVnKRtxXiKzPG?=
 =?us-ascii?Q?4qWzps/k5b1QSdVs3Zn413H8awZJJbviCP+EO0ad2++/eeeGmpK6Fny6J/oB?=
 =?us-ascii?Q?b7t4yW1aFKivlWKDSRxvRJ+WVPheRfUHGdVatNnn28/HOSrPNA/7OHgHd7tO?=
 =?us-ascii?Q?9ArP7DxaLGVMtWf1RpzhR90oSe2lQtfTMFL91MoY5Dj5ilheuzRz+InVPf5j?=
 =?us-ascii?Q?E8sERTtzvOKvX7QQSOc6b49cylDUqoBn4nEbANiB1Cr0o5/LGQvQ5VibpzEu?=
 =?us-ascii?Q?RKmnEsZIK3oIux5KgJmi5dG2+A+L2ZzuyejJ/p3ePDIhD53YQ39abtpypn2E?=
 =?us-ascii?Q?u5pazzTQWgrk0+O4VycNuqLs7EwIKa0v3/FAkal/htwaHE3jaJTJhiNNeDih?=
 =?us-ascii?Q?g1zhLe+aqt5iH9xiQWS6OQCNlbONmYirz+7VAe3JA6JXBUVJV2omzGMj9uEk?=
 =?us-ascii?Q?B4BV3cYDjc4B0S6Fexhsh2O3H7mAjumYG70wWXdRCCDwCfPhXxN/FqQqqOVa?=
 =?us-ascii?Q?1EA1H/c1iZZFlDrnfZAvCWf5d0nlwOHm5UgHqVQLQRLmOU02f2s08PrJPfmS?=
 =?us-ascii?Q?KSDGYUlbQ/23NrfzEc0Yx01etJekaxGRYuxR6wRpLSok39yWYpu4+sDLCdes?=
 =?us-ascii?Q?o9Xq5jbxE9XBfaqycQL5gesaxipVmgyZ/4w8GTQ4MQ62vKAn+DZUNZOgaCMB?=
 =?us-ascii?Q?4mVnfHYW3802GNcwDlOl6+CV2maB/lLHg9sWHrH6cnNHJcmCUalw9ugTZd72?=
 =?us-ascii?Q?ATJ2XS3In6hFnYRbYHpBRBtwiXyeaF1Qm53wLl+U07exjfRjbudsFsWU0ySz?=
 =?us-ascii?Q?EAdyYaKOtZ69vcUkRMjXNPDdvU498jQwSr0dexIEKxLHKJJM7dkUCZcsecE1?=
 =?us-ascii?Q?1Zl4HDlE+Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10683e7-fb23-4531-a136-08deb71393dc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 08:33:05.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5msxX9Nq9IYAC9Ck1S3C2lRXe98vbxBVETdEYLH8z3rArLVAIBGDuXzHOrjhJ7+cg5e/JTDqHiVrgIuYJPbi7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
from a volatile window inherits a non-PMD-aligned start, and
cxl_dax_region_probe() -> alloca_dax_region() fails:

"""
    cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
                                with error -12
"""

Enfore that every volatile mock CFMWS is PMD-aligned in both start and
size.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1 -> v2:
    - Reframe from "fix start alignment" to "enforce PMD invariant for
      volatile CFMWS"
    - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
    - Gate populate_cedt() alignment on
      ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
    - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
      in cxl_test_init()

v1 link: https://lore.kernel.org/r/20260519233523.5991-1-icheng@nvidia.com/

Best regards,
Richard Cheng.
---
 tools/testing/cxl/test/cxl.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..09c309af5fd1 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -318,7 +318,7 @@ static struct {
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
-			.window_size = SZ_256M,
+			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
 		},
 		.target = { 3 },
 	},
@@ -495,9 +495,17 @@ static int populate_cedt(void)
 
 	for (i = cfmws_start; i <= cfmws_end; i++) {
 		struct acpi_cedt_cfmws *window = mock_cfmws[i];
+		int align = SZ_256M;
 
 		cfmws_elc_update(window, i);
-		res = alloc_mock_res(window->window_size, SZ_256M);
+		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
+			align = max_t(int, SZ_256M, PMD_SIZE);
+		res = alloc_mock_res(window->window_size, align);
 		if (!res)
 			return -ENOMEM;
 		window->base_hpa = res->range.start;
@@ -1826,6 +1834,8 @@ static __init int cxl_test_init(void)
 	int rc, i;
 	struct range mappable;
 
+	BUILD_BUG_ON(!IS_ALIGNED(MOCK_AUTO_REGION_SIZE_DEFAULT, PMD_SIZE));
+
 	cxl_acpi_test();
 	cxl_core_test();
 	cxl_mem_test();
-- 
2.43.0

