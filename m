Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCAA3876A7;
	Wed,  2 Sep 2026 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327544; cv=fail; b=U0FJ43Km34Jvcm1b8rnM4tpdefH7+PhV1iaEh8XMFm0zhuaxuiQtSnrxi5WGvxDJ+5L6tMy74dsir84YHGeNsRvBpQS2NH0iAJCUrjkujG6hogLmTXXQ0u+qkZ4+cs5mEV4knxR46X4aAM3hOhZ2+MoEwBslbc5tIokwZxCS1bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327544; c=relaxed/simple;
	bh=MQEE6NIdNbheA+9RlvV08FXmBCzkus50NpmJNDfFaGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjUxqnJmmodSZQhB/0/IG/qX29pNkaNZz5jTZn529iPloRlAxj4ZMHYttxmhYmUZRQox2RyaxCKFGkr4SFCRW/DD7mIDZfnlduGuYsfSvxWbkSXoMCV1yFPFRN8g8a2s3fBoeQFqx3hiIKyZvzU1JxthtDiDFjqpg4v/jXeK/PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tWTpN/DJ; arc=fail smtp.client-ip=40.93.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tWTpN/DJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7PPfK33C/2pRKzqUMTzO5iMkv5OtjnRSSnkslKX4HPf4UlbgXBbDBHVSwkJhUasVHqGfCtQMURXiBsvbX5h+qVmPC3AzxiElFzUU9625v21+QkawuNZWQIarUvSQ2qLALcbFSMinXaRtARQB6Lb9sQVW/L0X59+agym0hyDha4FLnodM4wAC2/MmUv3oYSwtYTZntxPQ81W7dHkTRvrwaLWTSwXxmZ/TVtpUKPzlO5mj9e26l2TUHwFoZQ0LFuLR37iQBvpcL82uCjYghZ1tXkQnRijWtfS6JBD7mGIDKOD+CqsT+63XozU+2KLGAFsaYe4hKwDYvTc2l2fWjkpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUK1tn+P8QxiMCtqdzoHSMO1b36cWusTV90PUYxK2bo=;
 b=h/z0N/E41J7kwyVyGMExT1Y0mVNpcjv/pfBVBAqcoLS9t+WWZDQzrs0rx2W4cvidHGi4SX7BtOMfmUSngPc9aKQ5SDf53qJdDG0bDbz8oZpmNGwRmEfdrqFB9yYByKSJK+R+dUxEsxZc+HPUtRS2eQN6DoYrd+Wpp9rAs9hvla35tW1m4+IiKIaK3LlAX5XBXOF87XT9PNeQiAT+WuHd0eiJ2tmRVR+sYOLfYN8/xQGCtDB/Ims6m0KG7K82bzewbPUuIogJNG3s5ksQsfJgAeES1zPZMrKGQoi9xhgQwgB9YDKfEhXnJ+fwMdiEZeP9TLuK5Nyd3Y2LVDt5p7b4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUK1tn+P8QxiMCtqdzoHSMO1b36cWusTV90PUYxK2bo=;
 b=tWTpN/DJ1DR4pm+zIzQn1oE6RpPZn0IO7c8NdmrBvklJDFL/vK7pxnZx6iCsm+RX+OhhaDHajnkNxoNgYGt3fq+qT+j7rtnRvGIRO9HsWOrCY2X0EtAze8QRBzw8KksnWpUx0ThS3zQygNswKsAwohQmnCofyOwVwcJZ9J8GtDUyg+vcw4P2nD7i3C+CROzlRmE+h+3FVFVlG5WUW4nrnd1U3DRIppBUmxmjJN4SB7AWwPeHjaDDHnHPFUUiHI+wkyGGjqLzDrHhWiQenWUPChu0z4TVLw3m5CsLjpqCMa8bugPQvfIbvk/1ECGDWvaV7LNy6RWRezvwSpkLCy47ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 05:38:58 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:38:57 +0000
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
Subject: [PATCH v7 1/7] cxl/features: Reject feature offset that overflows 16-bit field
Date: Wed,  2 Sep 2026 13:38:33 +0800
Message-ID: <20260902053839.25595-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260902053839.25595-1-icheng@nvidia.com>
References: <20260902053839.25595-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 10629d2c-cff5-432a-12df-08df08b47ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LHbrBY4R1AgOFd7vBiJi1MvBTeie6vpzdHOSH+hknLXukpjgONwKJiuPAeCZHitR+GBFlY9fUINDae6pZjn0GC5B6mJJNzDHhjgFkKOlz6aErl6qyYzqvNk9GcJo8Hzi69cNUUdflbl6sNQJ/XAsHkDGngdBNcI/z+xtBmCZxrjlav62qhuAMFHCFR9XwWsDn8MUYrt0Gw5U5P/W38Tj2Um9B8rZgbRQeuNrykTOyR0FhN0hAwgTXNnfU/EJaixur9USjgbNKUuvFw47kM3jQ2ZxJPu+eQdT3K3izhyuOb068HaFr3c+V37gGF4y1O78ukK2ZXwvjuYvYt5UcII9I06IsXUD5pLY5ZddjzlQ15AS5oROEikRTQMy3axeKSdcdZsT2oowkvs//5tUCt5YmTYn+gUujYR6+p45oAWpqt5Mc2ImdzUUVBxbFYO5IyTW8/cPfRNmkAIZnrPNpgV6d62g04v6ZxaA37LpljlinmEN3EwqRYxysGvn4yyO3P7YDi7IVfLeY9Lenuj9UAP7grFgz0KFzUELFbYQv/lGE84APzjj0DJ69FYFh4h9USRvfnb7tLtHBGdVoPV0DE6C5Ju4VWZwgFtEHsHP8HwrrymnyXQiCkO/t1OdZx3ZjUDZKE0xtOiV6Lf29WguzFnBDUrZbBL0goECUF7AsE0vZAU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t1tRgSpcuT095aMT34iMC+KI2QbBqaJqKNbA+EA8PQ4MqI1aowCiQIVFRHxg?=
 =?us-ascii?Q?gcltNHJOz+dOklQt6NGLpxasgB0QUl2Rsm0Jejqo2DmMvxw7Gv2RrCh0bwfL?=
 =?us-ascii?Q?iTxEZU1Q0PGxqmftruvMGfc6hpyZdEqqNNW19k5khxsZ35qptWsqE/R3nIaN?=
 =?us-ascii?Q?1fhRMcsvg4Nfsdu74VnSQw0OAAesw8yVdEGD1t9TE7z1tLPcmfpZHDgaQKIU?=
 =?us-ascii?Q?nVjGjRQXMby9NmrT044kCbsLFDSc4ZJmcFGm+B2VRt0nO4Lzvl9Z69raTOov?=
 =?us-ascii?Q?+VsutTJJdcgH4lufeZnZGJR5nfNiuQd2rCPzcojNE+cCr1SCZC/PyKhh7xQi?=
 =?us-ascii?Q?FzkNpqVF4DEkVtnMZsV3cCgfFbA0D0d2shR3wgP+xJ8d0e9k6U4rmRXUtktc?=
 =?us-ascii?Q?fnbkcQ/WrAIfQ7w7LIrYNgWajnYmu++0vrNYMfylkFK0sR4RGjrz6L1DCI9y?=
 =?us-ascii?Q?BsYVC0ZC3UzQ1MLG0PHiSLlWvFang/cuEGBN/yUN3hZSprRCa4B977eqtSjx?=
 =?us-ascii?Q?RdxD2xvMzlnj9/EKZCnwFx7ENU2YCQMCFLZcJdIKlDF+EhLqTqPModG3H69e?=
 =?us-ascii?Q?c9xsi4bKTP3HLSc+giXWpC0dr/C7aBzjHRN+2jOCiu9x3GDwW+kwqWTIrAaI?=
 =?us-ascii?Q?aa37qCqi1mAeW6fiFW2C4HRNDEQeR/isvOkvp5cb8tKHpHOq/cQkTtLAsQGX?=
 =?us-ascii?Q?q0XpFMLCaPVMdhYM9TeB42F0F9bHdfTUogu2VE1nZTof8NiD3b/6m28NBop9?=
 =?us-ascii?Q?PZEuGw14Fm2sr/bveV1/qj8RjKQTy4SPnbcDSBiswBeD1jDZKj1+5SQfMFQA?=
 =?us-ascii?Q?yEGkEW43Hi/2PQjfOGMKcuZgu3ZenlqPzH2US6C2fA780SHAV76PolTfGIuw?=
 =?us-ascii?Q?IJufGvgE2xzR/j3TJAk2LRHMRGwes7ynwiS8H/Kwmz2S0lR/9jqW97fJ4UfC?=
 =?us-ascii?Q?cfGkMeNv1N+BalPBHD24+DV+Omq7lBqj3xurD2CA6dFdiF+piWwk8JmPmxVW?=
 =?us-ascii?Q?83OnLovDTQJyI4bjh59HKR+d5ZUl+wDskl264odD1l3pFYbst6rBQ3/pAZ9w?=
 =?us-ascii?Q?xOgpiiEpSMZmbeNUtZSdliAEs0RVJ4Fgl8yJaDj54liBj0IJDqB9CjPyaU8G?=
 =?us-ascii?Q?sYMD56gg5a00PkCS8Q6MKnkuyrfGEcZzMT8LQVyzjvkjIg062o0W4ouazpH5?=
 =?us-ascii?Q?cBcZ9CiqEdltMa2Y6nPKgkDj8IwHpSOuTMgmmjjolZQz4/1hFAC0SQD7giBN?=
 =?us-ascii?Q?z9KB9n69UYWdInA4Z2CWUbId5qHEGeMyMLluv9/hjbh8GLEuP1S4hWHHiXUQ?=
 =?us-ascii?Q?cBOtBUrMJTV6KpEZTIkre1OrcUMmA7WmoJGRBS4JRm6M7ZgT6qz10yWkaqZg?=
 =?us-ascii?Q?aNzGMjD+AStEAqcrvmItYxPun9jyFy1T7AIE0UjzW+G3VN3F7Tlr7JEZkkW1?=
 =?us-ascii?Q?0O1wqNrmgMijXwPal/bnVgGFKNkNyWg3mbM5miRThstCT0lS9uwlsr1ytkrr?=
 =?us-ascii?Q?kIHYco0E8ST51rxOJMvQegEYpKomry+hWpIxXxXgBEeiMUwGmiTx4MseBKM+?=
 =?us-ascii?Q?u+qdMYHeqkjAk9UEt6RK0n/eD5qx4VLQyx/c7I2634Cded/wn2E7Jd4yeYsz?=
 =?us-ascii?Q?yujZzdj3V08wPFbWcV1JW+Jufl1BGGas58yWcD0kaRcN53wDzFzfOKU+9I6m?=
 =?us-ascii?Q?2RqJ0bweInBrowZA9GNvsaQCOjfDq9M96KY5uNDcsmkkCDp7ZHoDbUq88OnV?=
 =?us-ascii?Q?3RQHIfrMHw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10629d2c-cff5-432a-12df-08df08b47ba9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:38:57.5716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXc6yDxLDcG2rekJrbKShmktOToBRWSij03zbdq1kn/Rj5aDo83p9PWDwGywYl/sKo+FthN4Ik3gpFjYIDlGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712

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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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
2.53.0

