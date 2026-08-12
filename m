Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE57435502;
	Wed, 12 Aug 2026 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533688; cv=fail; b=lTZKF+2Iybsl6wxA5gppGXdRzmiREGkJzVPb7eV1ZDRP+fBVepRfCuXSciQk0cLvvJ2ODo0HL8fKcA4jwVwEtT6FW/7Sy5LLF8hgmbLYGyO2maogDyw6fk4QuunEN5dsRfde/wU+TVZnkz5IVZR5Tl3Pn29m1AC5myIE8pQsSP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533688; c=relaxed/simple;
	bh=BVHR0ufqrKrSKizVnep+oJsuiGwJAHGQmYpy1ObZEGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qm4VJcNpcQ7RglujEgjQ2Oq36Wp46ahsKAETgh7LXsYcQ1tw3RpYSH3c9rUjF//tCF0c9tWFcL64lg4yTXwi0QOcU/UPAmV2VwH/WKKGaY4KDvGLFbok4K1dujWQyyHGeTYsmA9UQ74lodjkNeXLpkmyurwor9nLASKwbhz0B4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bzBob6a4; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bzBob6a4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWjT4fi5NJ3AlpyMcThPztxUBfwKForBJt58GPSVtw7+kuD8tbgwpD2Fc+ReNt9ntrHMg8nZm6sSzcmr3BwfegMWRuVo81C27MDba9LFleDkNKc/D8c6STLt7Nxra4W3Uu7Cde57VKKydQnUuq7aBK1+l3QqFv0zfCzppw4/wmiZWkowLevHtO62PE8fzgLmu5zXox4ordfosu5ubsEBJAF0lUV8cb025mxJCQRs5g5pyGNKuRqF/kVb+ROZ/eEZNZQ+c8BaHKSnzXEErL3q93hjAN4XFSxOWFAEHJbJsKCo2FqxSuEMFOq8N1uW6w5ybk2QEaAVJL7J5IJBI1gEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPX0hP0cTHccGMcHn8PQ0Bo8SsfahFdlJ3t+MPc9+rs=;
 b=nhkGOfi+m/EE/aRJ3d1heTAcSr2vRp1jgVhM3qNgsQqxUlKX7KNuTlkeanwoQzoBd/fNwLl8Au3aq8I+uOwWVhPkgFIl0BLW018EBZrN7BxfL0qWz8RDJFsU9KJySgjhmow+NgusejQhkzkBFXl3Mvg6Wm1zUeoBNugtkvzl/HS3X5yU13isghEypBBorOlpKwFlejgV7X4bUlK4sW2l5siePgsbv8SFOBhQR41uwtEMvLuRjA8ycuaAP92hPeyrcEfMSiBQmUZ3IqZcNxWc5aRSjpz452s3jYYVDqUjZBUYa7SAkFm5CKZu1HDy+SvXOkCXsdLsbvajVpucTBey6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPX0hP0cTHccGMcHn8PQ0Bo8SsfahFdlJ3t+MPc9+rs=;
 b=bzBob6a4zy7Ys5hgDONa5w72HReNXuQMVRKYPH654Cmx4gew5KYcj2v1dzokjlJBAW95lVroM1xMoPd8/aFFzTnJEZJrGphKYsOChcJzHJnXOcIaZp+4t9jlN6qonsyYiLPscUPr83NUJs4Dy7RHE6L9/4zubQ53UkxeIFQLcmAf3jXyeb2d0grlzdpJrW/hoRXG1YD0VG6qE2Qep3j0D4mSuUdw1LLzOz7BzInWjush1W2A+Dp572k17bru6xX4rhPzw0zB+axGp8dm92HhCRfL86n/wh9iq/EKsvJpBaF0Z5XEp8LakHstFseLhbMaT0gWc4VZKepEf5hVqfmcdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 11:21:23 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 11:21:23 +0000
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
Subject: [PATCH v4 1/6] cxl/features: Reject feature offset that overflows 16-bit field
Date: Wed, 12 Aug 2026 19:21:02 +0800
Message-ID: <20260812112107.56181-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812112107.56181-1-icheng@nvidia.com>
References: <20260812112107.56181-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:d10:2a::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: ab40478f-bad2-4fe0-9710-08def863d6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Pxu1W896WVQcjbR3jMhzcCG2OKCCFkT2taOiiHzMyinyKQkVWDOK78xDHE3WZgVNBYZ3UH6G9OVBwQoirD2yzhpYirNVzflEDqXRE2oit1JJymDNFq2XPPnLxDTWqrqj52EkMmBt6gRe0oZHBeGkrJhiQONj1/agC2eis/E1VJif5mDYJagvgdTrMVsPxKV9UWwJ10vz3HrWEsYIhAfCz45uOsz2CPJ+YnmBNrGo9t0saFpc79USpmMdb8zR0pxbr7C95bj/GVdhnjiqeokFLuu1gmZpKE85FCu4dCyVBUli4llnDy1qh5nSXzzP4tdKzxf6K9U+9pycGco5gfKZMXMVTwjZtXuBeEC2SeFzrFLUeS3gn1EWpx78829gtacP7DgYidOEHAyGBHq3MezQdZ4gX28O9AkvR/BS5lUMYx5SuehPPLRIVTKD5ff1+E5N4yB+FJsojBMKs6RJ6YHacb1vUuheX2XDPVbOhnGxs6ylGK5c3V7vR/WUUv19+k4dyLc/BOz3NvxhuxyS2HTPA26ApFXyHn0tJuDndfYuDlO6qz8qXQidw28qK3/oh/xT8kVivpMh/MpSRKEwvUxu8yr0NOcY07fvqYU75StGdppnpznH45RRQZSCxdgGqDlcUnRJtqFcFi24mZ7wl1aoQxTiqpxim4vTgPfedXesBtw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f6CsA369p1llDmb7eAqcRXwbun+6sSzU6KbSkYOTK6RIORT7kqVGwZZf2+ff?=
 =?us-ascii?Q?2GX0BH2rJKhRlK0yhAMuPFEli/Lw4JhK1B7a+lELfE3wmRbP0S1sstk5F6IX?=
 =?us-ascii?Q?YEhUFRwZqkYCsdxHJ1wZ6zsjPf1JbhZ+fPT/MMAAvOKcgF87Xec+bDpTepRs?=
 =?us-ascii?Q?29FhHfwdWooAL3M7IvBHvNBDUkn7e0mKKtny1M0iNAdq182jgbqwCNkUAZ31?=
 =?us-ascii?Q?FvEelpyqC7lgaae67ymefyqXDyWfH8WEcDhNMYy9nUrkpBVpemM51euhDTaC?=
 =?us-ascii?Q?QhRW3PDEzSg79nk2HAX4a6r6cAys46gm2Vp/EgAn+1c5yLhA+t2/7NblisJS?=
 =?us-ascii?Q?SDTnzudASP8AHKESiKuV8NYKZnS1KRszvX/EakWo91MNySE2QepSop3ZAoH+?=
 =?us-ascii?Q?5l6d8+Sax01I+ieKT0JTe3BzHWYnCn3Blh4KXvn500QcshQJPyf4x6MpKzT7?=
 =?us-ascii?Q?qNa0M/UMht4I2y6enN6HiLpa1b1pkkpNL97uDNdU4/u/PoNStrapUP9ldKik?=
 =?us-ascii?Q?nUylJz5k5OodfvvGk6Fa1xX5oGUexuKeKL23q3OT9hsKikO6pSYCODp0L/iD?=
 =?us-ascii?Q?hYLEtJrnUH5SnBq9uN7/lLHtqRUAtT3W1IbCXSGpXYXOG8i3KBNBZxJlzQoK?=
 =?us-ascii?Q?IxOY1WoyVUow9C/6i08s2lT+LqAlVCTXwnNDaPKhIq4Kip+cfr88aDZVCUC6?=
 =?us-ascii?Q?XdQjxEVTmmhy8ISfan2xM/ocDCzgu59RGWGUZzdhEeBN8aQSrihBkL0SRAAu?=
 =?us-ascii?Q?9+R5JRL1F+oPvKdsvcd5b9whrg0NGeGdhP5hiDe4Y4axPRYg/JGbj5p1UI7I?=
 =?us-ascii?Q?ouaxu+oN6ig4DKmpn95CXscFJW4gI7VCNiMEUMSdU5/9tPHwtg+/l2OrzOaE?=
 =?us-ascii?Q?M5gahFAIlvY3dbZ+/6P5uOrhzY+cTwIGo+KHS367g3ZA27OmkujvRJJS3XaB?=
 =?us-ascii?Q?G+ybr2dNx9uCV9y/wjDYBSaHI6kIJkkEczW6fWshNyeiIu9wXklq4jmXjcZA?=
 =?us-ascii?Q?6l2n9kI8c4uZFwmw0YVclOQsvndyPG0jDnUpougMswuDADy17bkp6UxUPB9H?=
 =?us-ascii?Q?qKnRPQLEzmQMrTISyK3r3bXqVRuAInNH7/dFp2fYJHAVWfCpwbnJ0s+tzZgU?=
 =?us-ascii?Q?f/P+IFA0gpessJIZjkqVfPi/gP5cUNYWl8/Qz+Fr5TGSMCodWdVBxoVEa1w4?=
 =?us-ascii?Q?uL5JxUmIH/uJ37FFC2skEPgYLseDWsVqhpo0NeZhGvZO/lVap+jRyDoTZVSc?=
 =?us-ascii?Q?IASreKjra/srvmcCMLOC4iC0IYOkHj7FFbZg3+rqUmkX4XzSXSSGzFHOvyyM?=
 =?us-ascii?Q?sK6JWJi4zxHgIwOczaNur1YrB5N0J1COMfV/lLnCHboGUeuHCBdi+DsuEd4H?=
 =?us-ascii?Q?UKwni+DDPGeWbuWFWABNR1m0LWBQlrr9FNoUolaFD4NAqDgFfisv+TwrBi85?=
 =?us-ascii?Q?nTmZpSwihjsgQhM4fRECsfu1NPFEKHzJLGQI1BoVHJ4bK7yP/+nBDTNkresD?=
 =?us-ascii?Q?dV2mnDQ9W9SIo9X2y96PvIIC16giSKa/URQ9VLCh6yEKf6OehrnzCqGM8EZD?=
 =?us-ascii?Q?DnY8OfLFCwMk6CwsGIZb8E24tQnOR91cpwh3EQt8y5ruVharuL8n414k0DI+?=
 =?us-ascii?Q?9xurMv5SFJOLzxXyZcsedb7RjXbMNQec7ZCToIDaVEbKVXVupF04lKjjlzf7?=
 =?us-ascii?Q?NGs1CM9wToX4cR+FReUfa1tcUQo+xt/KtYok26baM1WWVAklwrlL7EHzFQz6?=
 =?us-ascii?Q?CoAQxhOZ8A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab40478f-bad2-4fe0-9710-08def863d6ef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 11:21:23.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JXWbMLLtNq0Qg9KXHoToJvbF+nar1RxYqinVPqpolVx3nmk/vQvz8rf3omj6TkhtADYMvVl4iP0/Aics2cXjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

cxl_get_feature() and cxl_set_feature() build each mailbox command's
offset from the starting offset plus the amount of data already
transferred, then store it in a 16-bit field. A user-controlled fwctl
offset and transfer size can exceed the feature extent, allowing a later
offset to be truncated by cpu_to_le16() and target the wrong feature
data.

Reject requests whose transfer size exceeds the remaining 16-bit feature
range. Express the check as "size > U16_MAX - offset" so the validation
itself cannot wrap on 32-bit systems.

Change cxl_get_feature() to return ssize_t so invalid input and mailbox
failures are reported as negative errno rather than being conflated with
a zero-byte result. Update the EDAC callers to handle negative results.
Keep fwctl behavior unchanged by translating helper failures to the same
header-only RPC response carrying the CXL mailbox return code.

Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/core.h     |  8 ++++----
 drivers/cxl/core/edac.c     | 20 +++++++++++++++-----
 drivers/cxl/core/features.c | 28 ++++++++++++++++++----------
 3 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..bb380ec6daeb 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -217,10 +217,10 @@ int cxl_port_get_possible_dports(struct cxl_port *port);
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
 cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
-size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
-		       enum cxl_get_feat_selection selection,
-		       void *feat_out, size_t feat_out_size, u16 offset,
-		       u16 *return_code);
+ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+			enum cxl_get_feat_selection selection,
+			void *feat_out, size_t feat_out_size, u16 offset,
+			u16 *return_code);
 int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u8 feat_version, const void *feat_data,
 		    size_t feat_data_size, u32 feat_flag, u16 offset,
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index b321971fef58..f1df4b5cfe5b 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -78,7 +78,7 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
 				    u16 *cycle, u8 *flags, u8 *min_cycle)
 {
 	size_t rd_data_size = sizeof(struct cxl_scrub_rd_attrbs);
-	size_t data_size;
+	ssize_t data_size;
 	struct cxl_scrub_rd_attrbs *rd_attrbs __free(kfree) =
 		kzalloc(rd_data_size, GFP_KERNEL);
 	if (!rd_attrbs)
@@ -87,6 +87,8 @@ static int cxl_mem_scrub_get_attrbs(struct cxl_mailbox *cxl_mbox, u8 *cap,
 	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, NULL);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
@@ -551,7 +553,7 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	struct cxl_ecs_fru_rd_attrbs *fru_rd_attrbs;
 	size_t rd_data_size;
-	size_t data_size;
+	ssize_t data_size;
 
 	rd_data_size = cxl_ecs_ctx->get_feat_size;
 
@@ -563,6 +565,8 @@ static int cxl_mem_ecs_get_attrbs(struct device *dev,
 	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, NULL);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
@@ -583,7 +587,7 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
 	struct cxl_ecs_fru_wr_attrbs *fru_wr_attrbs;
 	size_t rd_data_size, wr_data_size;
 	u16 num_media_frus, count;
-	size_t data_size;
+	ssize_t data_size;
 
 	num_media_frus = cxl_ecs_ctx->num_media_frus;
 	rd_data_size = cxl_ecs_ctx->get_feat_size;
@@ -596,6 +600,8 @@ static int cxl_mem_ecs_set_attrbs(struct device *dev,
 	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, NULL);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
@@ -1264,7 +1270,7 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
 	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	u16 restriction_flags;
-	size_t data_size;
+	ssize_t data_size;
 	u16 return_code;
 	struct cxl_memdev_sparing_rd_attrbs *rd_attrbs __free(kfree) =
 		kzalloc(rd_data_size, GFP_KERNEL);
@@ -1274,6 +1280,8 @@ cxl_mem_sparing_get_attrbs(struct cxl_mem_sparing_context *cxl_sparing_ctx)
 	data_size = cxl_get_feature(cxl_mbox, &cxl_sparing_ctx->repair_uuid,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, &return_code);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
@@ -1750,7 +1758,7 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
 	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
 	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
 	u16 restriction_flags;
-	size_t data_size;
+	ssize_t data_size;
 	u16 return_code;
 
 	struct cxl_memdev_ppr_rd_attrbs *rd_attrbs __free(kfree) =
@@ -1761,6 +1769,8 @@ static int cxl_mem_ppr_get_attrbs(struct cxl_ppr_context *cxl_ppr_ctx)
 	data_size = cxl_get_feature(cxl_mbox, &cxl_ppr_ctx->repair_uuid,
 				    CXL_GET_FEAT_SEL_CURRENT_VALUE, rd_attrbs,
 				    rd_data_size, 0, &return_code);
+	if (data_size < 0)
+		return data_size;
 	if (!data_size)
 		return -EIO;
 
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index ba6d2a5acb74..8d44ce829497 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -220,10 +220,10 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
 
-size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
-		       enum cxl_get_feat_selection selection,
-		       void *feat_out, size_t feat_out_size, u16 offset,
-		       u16 *return_code)
+ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+			enum cxl_get_feat_selection selection,
+			void *feat_out, size_t feat_out_size, u16 offset,
+			u16 *return_code)
 {
 	size_t data_to_rd_size;
 	struct cxl_mbox_get_feat_in pi;
@@ -235,7 +235,10 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		*return_code = CXL_MBOX_CMD_RC_INPUT;
 
 	if (!feat_out || !feat_out_size)
-		return 0;
+		return -EINVAL;
+
+	if (feat_out_size > U16_MAX - offset)
+		return -EINVAL;
 
 	uuid_copy(&pi.uuid, feat_uuid);
 	pi.selection = selection;
@@ -259,7 +262,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		if (rc < 0 || !mbox_cmd.size_out) {
 			if (return_code)
 				*return_code = mbox_cmd.return_code;
-			return 0;
+			return rc < 0 ? rc : -EIO;
 		}
 		data_rcvd_size += mbox_cmd.size_out;
 	} while (data_rcvd_size < feat_out_size);
@@ -288,6 +291,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	if (return_code)
 		*return_code = CXL_MBOX_CMD_RC_INPUT;
 
+	if (feat_data_size > U16_MAX - offset)
+		return -EINVAL;
+
 	struct cxl_mbox_set_feat_in *pi __free(kfree) =
 			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!pi)
@@ -462,6 +468,7 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	const struct cxl_mbox_get_feat_in *feat_in;
 	u16 offset, count, return_code;
 	size_t out_size = *out_len;
+	ssize_t data_size;
 
 	if (rpc_in->op_size != sizeof(*feat_in))
 		return ERR_PTR(-EINVAL);
@@ -482,16 +489,17 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	if (!rpc_out)
 		return ERR_PTR(-ENOMEM);
 
-	out_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
-				   feat_in->selection, rpc_out->payload,
-				   count, offset, &return_code);
+	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
+				    feat_in->selection, rpc_out->payload,
+				    count, offset, &return_code);
 	*out_len = sizeof(struct fwctl_rpc_cxl_out);
-	if (!out_size) {
+	if (data_size <= 0) {
 		rpc_out->size = 0;
 		rpc_out->retval = return_code;
 		return no_free_ptr(rpc_out);
 	}
 
+	out_size = data_size;
 	rpc_out->size = out_size;
 	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
 	*out_len += out_size;
-- 
2.43.0

