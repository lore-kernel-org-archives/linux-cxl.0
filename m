Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4A3A4F33;
	Fri, 22 May 2026 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428713; cv=fail; b=oqOmBe+/xH0Us1Z123i7ym2Uk9sGwH12pfWlv9QgyiWHIM+slqvIZs/MFpy7gcySqMstZ7hXgqAGbxISuE6FR756qmEQBxpKkumTBXozxmcWFe5s7gG5ljD6/r04P0Nyil+4fisxO1+J5SgVMGZGfpqRe87PFhfGL0I2eDjPRAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428713; c=relaxed/simple;
	bh=wSL4hBHTq1kB4UUP02kmGqzDObr3bNImUb1FqO/lPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EHPd/VrdbOJG6JuC8mxBKiGRSYN8yf/su/qIBuPqfVjB3SQjCdwh+X35JXdbMY45v0Sp4bWqClDpE1BeWLSiorjmB1dYi3tvofVYLIigOEAB+UtROpVnpMS4eUc0o9SbSTxaTQX0Vc+TgnLpF2+sMS7S078jtZ5XUfCjdaKiwYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=edRJyPmt; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="edRJyPmt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3Kk4Kv8/eckK1QyYdnlxuaNQUWjFEWI/R4AHemcRTNa+5KLv9bknHmsW2rgkQ+TF9AsrqHVkDri1eu6cjPtnn7Z6OP94j25kleeS2EC3WZZd6sPqFCNIJoagf8NfiPlvX4g2f1FftGtnwRureT7ARm0SylvPy/Qw35Db2X0JoNBlvus5tLpuh18/RcdZrwVtO7t8o/1CmjvVjh5Cn3zae47aAe5KG8BSrag6QdeICFY7iSIxM5BLg4Lr0zMvAEcid/aHDLC/qpuGGQ++c7h2RecvFJWQvTt6PleiV2kU473QhsGKOvy0iJTtDVb3iNU49jDPrbG3FILrc1FCF/MHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSEvTaIdIuqZI+asDWWxyVpeB8a/TZcjAnaRSC0iWxg=;
 b=gxQHx3IHGuExYnXt5Jav2NsqRKAv5KptUfA20EcLWYaJDr8nscMlp2aztRfsURUU9R+kUuhtA9xxHafOXsMmr5b9RWrQCf3wEyRLd6+QnBWSYbP6/7T8pflOcE1lH7Mj6LcWtTEIbx4mWPGAfdStKPVsK8hAF1861gjQVRfC11X227E5RtV1nI9CA9JYK51g5kEy910/T8Zttgs+Jd123atyFxCAI5KF9LDRcxU9FHDMy81qrmVKAafSGsMF81bLnfqisYh6RTsw2aASpt80BCSYIE14flTvW7QqoxT0/q1zC9KuDZVH51IUi7QzdkuZldZ4PMNReHOSunzk4/UjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSEvTaIdIuqZI+asDWWxyVpeB8a/TZcjAnaRSC0iWxg=;
 b=edRJyPmthqb89bRIOAC9CppqMdF5tA3rOxQxPR8darhh1tuMeJa13uWDt3y4qotjf0w1F8IMUHafRmSHeZgGUG4Y47DuxgBKUAMXb0pfrXd3DCfQBg5TN5tCWUDoRytYAIrNH4LHCO8rk6li314kGF3H2efUnDbJ0whq7o7doqnjiexG4toHbMk6LHjR31y42piYPQ96DfkquydEuN1rgzhIHo5IjKG1qZXtOTP0bqP4KFQGkJf2Xq2YKQQeVJLwEWE0VjPK3H+1x0ggHSdQ2klveqbFki40Q14FKvHIiiWGhKWj4xCKykzHW9MMFVxemF48+3ofz6mYr69zlOk8tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Fri, 22 May
 2026 05:45:06 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 05:45:06 +0000
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
Subject: [PATCH v3] cxl/test: Enforce PMD alignment for volatile mock regions
Date: Fri, 22 May 2026 13:44:57 +0800
Message-ID: <20260522054457.5429-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU1PR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:802:19::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d2ceed-b1a6-43bd-39a9-08deb7c5471e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	a/b+vnbV0G6NzAomGmPlXvuP3xFFl3FIejX565WFIwYBpxi55NLs6Qmi+1KIXORsJDXcBIoP4aQTLw9uIxMkXjCDtbSDd0PiCNjDtsS9chQKwV0vHDDIqbTcgPOE5xoy1+vBAy+8Qrlh3HJX18qB7FBSFf+HNl2Lf6V24R176rCOHXTe9NB53/vYhnOcHJwOKUwpWimzo5j8JzSkDbf4V0VuU43wRgBQkV+md/Z3Ya0LDUWE+B1nC7RKv2SwPnGhDhN6Gg4oaCWVUsmyoSkjXuhyST0wtulYItEcIdVoJ7SZ2aNzNT68IL1ZnlC4x5MlAJT/Xky7zLnsD1jjwphyzFjZHbP4/VWhGD4IQosZEXL0k7yqgmZ0A6bFKH1+O0f8UVeX0Wy2fUkW8UuW/Z+fKbRyLd+TeMd9yM67fED321ibGmpNfqEMW7V83fPZnVICVoMAvCHLS41QX9ET4DvzUIYfAiRN4o+i8g17IfXuum6Gh3gEPktw1vwGdA0dddeayK1yzO2zZd08lYKbyim5B4zRPjFhEWicLwtAVcaodpNpvxOno4gkwDqsenihYin/Se4dfE1LeaMoOY6vocx1uzzGyG8JcobjjO68gWHxXO4kSWwp4KVP7FIPhqrs6UHo/X/DakPd/JvfU19J65QVKr+lB4iUTbMljkC3mN9IRALSrCGHc8xORc5RRtoMP7y4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(6133799003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KVDraZPHYvzcVC06WNzO49+6ZElp+oUKyjGuhbrL69sDvOqKN1RJP1RkoalC?=
 =?us-ascii?Q?oHTR41Q6mem4YCkmUnQB+7vmvEZBUMkJ4n1UMgUIRpbtJ57TdDCFwSDk0MAt?=
 =?us-ascii?Q?8DUCb9BwApC3XBFzbvLzjonj2qS280CzQGI2YBbe5sSiSTh8p8EIgHc3DnZp?=
 =?us-ascii?Q?ytqEgye0pulTyBLlGAbKmmOCFgMxPfaUeNmO7P9P9f2NgLKf/RS2BN59gDyB?=
 =?us-ascii?Q?9pbWihGNaZovs7hces/cbfDUrHcEtcaPcI7NLVDZe3AV8NxJGmYmO8iPdwNz?=
 =?us-ascii?Q?VLpJCXFA0Q+PBvBTZI1r3IpyUJIJdml6cOhHVsX9WarkkjF+jfmgJvXIiMas?=
 =?us-ascii?Q?Fu7GCFAi+4p6zY0cnjDCy+s09VfuBOz6HQQpUGYHqf8s0fDhxN0FM0I3AJ+n?=
 =?us-ascii?Q?R5LAn0JNI1MaqReHf4syFIl75mbYerXz5TQNn1EweWKsdd+2MmUEVnAZKzLL?=
 =?us-ascii?Q?dWUIAu7y/nR7IZphm6QlGhls9xx5oi/k7AXRwEiub16ZSedEHacJvQ7Zc7YU?=
 =?us-ascii?Q?x3eZUZO+9OM5D1WYYphpgIIoBwaEhsV9JzgmXmVcXppa8Q9awAI3g++i03V/?=
 =?us-ascii?Q?tMz/bz9Gve40nxZjkxq1qMy1AEhcdvieX8GHAHlg0/fvktyXbrkA5zVBjH3n?=
 =?us-ascii?Q?Cm0Lkt6pbINY4sLBkA54tybFGjGwUjfwzXfUX4dXojUdFrBVyUKftw3/4NGC?=
 =?us-ascii?Q?3LPlqMQ94V4oguwi0Nti9ZkFMk3TdR7Z/Xvy3JMD2pF3EsO/7V0pSj2pF9oR?=
 =?us-ascii?Q?0dJY0o0GLw/o4d6/fzSYE6H3t09TwHwk+v0Vaz1GH5HdOsGYMtfSYbaFSnFJ?=
 =?us-ascii?Q?3QZr57YXC+k8i988RF72gCOW5EbGKCocqP77zrUvF6wQdiy0cnyg9lNI7wFW?=
 =?us-ascii?Q?G8gj4wYbG1+mtJw8DZc4g71/2SJVsbD+e/tJM+dXWCjD1vUhs7wgJCock1Gz?=
 =?us-ascii?Q?If7dJYWZr7laVTVXUFWpbLur3Xh9rrTt+KNGxjB7HAg2fIJQkEkUpWhgYEz1?=
 =?us-ascii?Q?/IWm9biEQ6i1/iHmgAbiROjiasDTCHFkwOaQzX69L+YH4fmMqhYusagmSHlU?=
 =?us-ascii?Q?o08a57YHkJOyR3GNbEwtqI6TQ3h1y8M2fVV+grunlhOPlZ1N+G2zL/LUHRou?=
 =?us-ascii?Q?aRFOzcC1N+bAKJQMqH/m2KSHP8G8d3OVE5ybNmo6IoajQZN1eo2WXNzAlleY?=
 =?us-ascii?Q?hJIPTWquFtdywZ+/guSKNYAjtbT4sJjoAixP6/gfIxQDDqTM3fV6Sz8nw/C0?=
 =?us-ascii?Q?Vfwwb2SPyt3bNsNdO7FkUA0ix5KwVCD8mXQmcXzPnPULKU821Nq955rafo2a?=
 =?us-ascii?Q?TWKRk0P0LQ+yzb33hr0ZlnMVnifcFCmclg+ofBaEmCEro7Ou/wdssaPpqCSD?=
 =?us-ascii?Q?zIqaPedu8n583qRDWlU489Gvy4hqN7CDGHOyLfbE2hsyeQgkA1G5eY0IGY+T?=
 =?us-ascii?Q?2enuSMWW4A1ABogB6Eq2d0sZWcKo5E1x+qn4GeoW1yiBl8hRS3wyr7cmMx6B?=
 =?us-ascii?Q?yLR6OsMW59OkG+SiMbncE+lvYa35q4jnPsszGpyX6Zby0oViODl/q+5IFWKe?=
 =?us-ascii?Q?ASstHLziptFm9ooKk9gvvlnOboAEMUbANaoYcizGgpffaLGXLQfgH89fQqQ3?=
 =?us-ascii?Q?uavgtBcvGV9uQ0q23W89ElTHqn0doTo8tKuuK7xLf4bc60xUKIFF4+l9xmdq?=
 =?us-ascii?Q?I/jagv9jV/DSTIn/MQ+W1Ab2v/9QDOzKfI0ZNVHCkz7cJBPrGOGMUOtCsXgp?=
 =?us-ascii?Q?p7oOtVGtCg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d2ceed-b1a6-43bd-39a9-08deb7c5471e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:45:06.6191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXGBS5IGbkXhgodeFlgaZsp+L2Wq7vndinBLURKJFUaCl+nSSEiYi/jzqSGbNG+l6EvOqSTONREa5LBPnxCAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
from a volatile window inherits a non-PMD-aligned start, and
cxl_dax_region_probe() -> alloc_dax_region() fails:

"""
    cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
                                with error -12
"""

Enforce that every volatile mock CFMWS is PMD-aligned in both start and
size

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2->v3:
    - Correct hunk headers
    - Add base commit SHA

v1->v2:
    - Reframe from "fix start alignment" to "enforce PMD invariant for
      volatile CFMWS"
    - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
    - Gate populate_cedt() alignment on
      ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
    - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
      in cxl_test_init()

Best regards,
Richard Cheng.
---
 tools/testing/cxl/test/cxl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 418669927fb0..7a1105f9a0bb 100644
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
@@ -495,9 +495,12 @@ static int populate_cedt(void)
 
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
@@ -1826,6 +1829,8 @@ static __init int cxl_test_init(void)
 	int rc, i;
 	struct range mappable;
 
+	BUILD_BUG_ON(!IS_ALIGNED(MOCK_AUTO_REGION_SIZE_DEFAULT, PMD_SIZE));
+
 	cxl_acpi_test();
 	cxl_core_test();
 	cxl_mem_test();

base-commit: 6779b50faa562e6cca1aa6a4649a4d764c6c7e28
-- 
2.43.0

