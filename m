Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33153F8244;
	Wed,  8 Jul 2026 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496583; cv=fail; b=pWWOPeS4iy1hsTdecEtsPLBEjoKOSqEKHPn8DTm5DPhN4Kw7JI7fmq/fwZcUCDuo4uM20rqw9MSrbBbOIDUJ1dFoK6de5+HtWBYm6Atw0E99dRRCDC7Ef89ulR2WZxdGfphzp98UDYvkbrvo8eNNlwVKfTE2/jSn8IP2de8aKGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496583; c=relaxed/simple;
	bh=GTNwPDp7nTqUCpCcLxRvvv9u5N5DJhW/NUHIRzpVwSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pavnXDrh/EMme+dzNYWqnc/YGhk+/N1pJxhWcWDrVVWUdQKApDM5c3YzHDpcoiMj+uYK2B/Uw+aZVK1P6/eC/LpCl0YWUFlMlJQhZKy5WMoSFqOqJfSbBhAMjpzdcoCTq5lT8xRXjhEJ2oijQ6LnS3rCWHEIHzgQTas8QqkeVfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rc2Ah9AG; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rc2Ah9AG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCuKd6ZoWQVHreTdvkicBHE5RQ1Fy4bS2PzzRXVZeEWi0n4feh4Yii8YVciiHE30/XfQCEM9k77QZkfpRTrzU2eZ/HzlByaXGB0RGo1Sh9/5oijBTlFfZO7IO78UwCjT5c7UnTc2kflciaKCi4aTqfHZm+LjQ3P80Ul1O0mdo7/rIxJGdE2lCbNi3RixnjA6SutikTIxpyNorbLu+CUVbfE1Kfgigwi0US8NBsK2WdpCTmr44it88DncJ+lW27IhqqDbmPx7nJQnwHESkr0ogqx8xJ2ta9wDssAaA8wi1XBfebmCzrwhKYCExDqp1imZ3K+jrdmGZG8W4CdksV0OWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTVr8glGfV4+wdnxJ5W8/J2uo74aIyDAgdWEHF/yPZE=;
 b=jfBY75+pg1pfFBeNuCRxY9m+gLMhCOHUNv4ah2u++DiPW91vYxSeGIel034vRfhMZS9Mi9STDJetdtjof0QaED1mCuljcnKL1MFBjnUm2AbRICFfiy87m7pfr9lwiLm5Spuyrun7bLQ4obWnkboHFLwS3cVUin9O1JwrNVnOA2Bj9lID0Ckv/LlBMWHqem5bv4kqhysluTkFt+DajGOKAUsivB/8GeUZJ0pxxA44zb3lisIgH86UnO9lQQrBED4aurAdDMUs6ym5ppyOL96oAGQ1aslcfi6OzoiSiGYqQR+vAlatTsHwi/4ou0dyngcbwPRf5ZIYCgi5xY0xIEBH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTVr8glGfV4+wdnxJ5W8/J2uo74aIyDAgdWEHF/yPZE=;
 b=rc2Ah9AG1qhf5G1eRBLObITf1sH0C/996mwr3N+RFGQbgJeH8jm2yAI/iDLo+9n/9CyRfYpP9OUKUJZmYKDmgzMesTx7boE6nFpGfys6eXO/h11DYPEM+N/Mo1reb2vRsY2XlJlyCYDvnbVv2v10SZKZT4dWMUvpQ42iYJEhegZHKR6YrsABNfaXlxyPyVhuXRqV0x98XvQLP1aarIEPbiQ6t/D33LgUmUwpAJn92xoZq+h5D0oaUTnDdMHZ07ECqVoqLFzSzaOux1DxixQb16M8tYY22QFbOQRS9WiDDTfg07cxhr/HLlees6qUjxwQo8xG0lpSL321ZcdNWfeI+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:42:40 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:42:40 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 1/5] cxl/features: Reject feature offset that overflows 16-bit field
Date: Wed,  8 Jul 2026 15:42:24 +0800
Message-ID: <20260708074228.43654-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708074228.43654-1-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0044.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: ad944cc7-6267-4469-ca7b-08dedcc47d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Bn0t0UOaA0NHeIvezhHAM9pdujjhKSeNBKND825cS/x0q9gHpPJga0BXacs+ZQpon7nd+20xqMfNlJbiBsGE4M9Rj0n/hthxNwvLbQ4I6R+D7OGu4HMjlkBoWRhQPxzjDpciFB17gC36HN3AjAlUKWlLr465JUYdyyk5jL9D+MGTARGfzqrcNTVT4yQdiG0myUejCQsqRAjiJSAJmaV4o+vY087LwLxLj+rjr21ktEIunCdqzwPk+a+xzq1L4Vk2/S7i09Te4Mad6co0WzDr9EAPuS8sAC/d37g+pdxf6vLFrMuXEYtK2dlmYRWWzlFD7tTTYNLddLdZnqj5ZYBRWGX90kSC8JgS4cgN/9RfkTXRpswYwffM6b6U+xKhpSl7HawIyma6ThfkfC9YH1wKEaFgYuBdCHjSjfSbcd6cEg2M5B2hWAo8VmcCm3UoJs/ArzpCEfrrVJfnavV7FUkXLegr50Sgr2nvgHCgsGXy4TFMfL9xlVeaxPp2BaHO5n8KNWnOeyHx+PXWMJ8zhbg4XZpSSVMoDnWmGFmbJb/oweoMdKC2g9nhukMzv9TFPAg86VtnxieXlIxjzo9lsMdAnkRo+qUUE3Kf5nkhy4bwARNymf7GcQq8LB9lo7dsZxM/JV4UKP9DjqwEm1z2p5pkGcpE32AhMIE793NVZ0NhoRE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?netJ0zTiabeddN5V9+8Xh7tIAKWZ1vaxra0fHGZ6J15Al84EYymgwuCpHsC0?=
 =?us-ascii?Q?Ehl54bkwO51acSLQscHMCtUPXh3eVRJpzXIfa+R+QxQhQo2+h3OvVIRHZfwG?=
 =?us-ascii?Q?SgYFPPhZYmcb9emxz+oKx7Kwa1TDtK3a2vB9U5wacqCtYNiL4QPL+Bsv21Kp?=
 =?us-ascii?Q?6FjcPoRr0gggPvfSdzY9sClB7LQ2+BneaV0uP2eIThxRpulsqVkaflHRRA2S?=
 =?us-ascii?Q?smnGdcZPpqN4j+uqO0ge4SFu7LSWZ8Fx/KB+/csgeKi2K6vOtVJPXPc6MYzX?=
 =?us-ascii?Q?tp2vX83uKNhhrdx/4GBmiJmyfXTv6IxJSXijkJ6x3HmanYfVkYBKCawLuG6M?=
 =?us-ascii?Q?cG8Aou2kRzLExCgmcdbeTCoguFbDIn+7zt/temzkM3bTc2BZRtrHjnjsVNqJ?=
 =?us-ascii?Q?bpGnhM4PA2MdkyQOrQsnm0VGCEbqDCCuItEye1Cjpx2fVfbGCoTtUu4zae49?=
 =?us-ascii?Q?W3fQspK58J4izqeX0+aJFscTx2CC4cmn9Fmt5AQT5tZ9aL0a13LU8uT22v57?=
 =?us-ascii?Q?u/l/1t5WKaCUqL6qm8QMZpPKeQA5F3OJ+HUtKds6pHhd0KmQCObGmtydmMIp?=
 =?us-ascii?Q?3/oKifuCsrm9Lmm1Z/k/Tt0Z0ucoOzyggmmvdbSpXbRiNXLp7Zrxsk4gMybK?=
 =?us-ascii?Q?ADkRWH5Xc9ndxWapP3gNBqgKL8NEbWEy9VBpf0qayV+MJg1++OCTXfLsEKzs?=
 =?us-ascii?Q?9ZgScG3VsNpi1UQQupym0C36KnHjbRrjtBJ/938plhNpbKCoqjIemEqzEzwm?=
 =?us-ascii?Q?KhHWVINXJnjcF60EIXAkTStYehEE/wB4cA9InaZTs8rMRPMK28acSwXf9nIi?=
 =?us-ascii?Q?VX3xCw8D7bM/Zxzz+yQxKrrDXRx/a1SZ4VjYgG+FE0kXOfBjCBIyYm+NRvI6?=
 =?us-ascii?Q?Fi21POG0OnBbjmsPSXjnsermQBO7rKBiT9A4VJvQ//reql6+Sk2YUOck9LjX?=
 =?us-ascii?Q?HvKodZB5oZjIt6K/BIghP8EuGaLW7L6gEK87Aj7v2DFodCxxHFh7u9JqkHpY?=
 =?us-ascii?Q?v+iMFOtCNUarpNL4nLg9NXHPHWdCwzAe8nbOVarK4DxGTBjF8PHckLu4YUoG?=
 =?us-ascii?Q?5UduJyPMVIfctftWpHpre2T7GjS53dO2Hvknqvct9+YIiTLNk4ix8NOTGzQO?=
 =?us-ascii?Q?/9f/PY0heRpfGv/1vCHh7jaJS3YHZBS1xchkqTnQkADkBaSBhfFZOu+rYXNr?=
 =?us-ascii?Q?1LexAJB3QHlV0jJhGs2tXW7rFxTgyXD9JlhyKQ60i8qzccTiH9/Yl+JadOeS?=
 =?us-ascii?Q?+qm6NcfkFDacJVWGE2DUdKJVtBCNWUrDelltzN4BPPhsDoQeUdD2NH7mvV5v?=
 =?us-ascii?Q?r6KGShnW4aPHGZeTmqgqq841pqitDpkC9OdA91LLwYj/nGLPd4/v9ZBW0f9S?=
 =?us-ascii?Q?4eb4Ni1Mu5JlpZmsC61CRTH51qcTseg1AzmfH89R15fWGzRxm2oB7D3q1HRA?=
 =?us-ascii?Q?dlMMs5gxfoUXjrwBFkid8Xvvhjv69GKjIPDnRx/LrRWSKrOlnUSaKCxSiF08?=
 =?us-ascii?Q?vciogURqztNBFO2/iThVMYBlu72yXVgoNaIuCXTNEM39Dq9+Et7q1orCvF+6?=
 =?us-ascii?Q?cw/gU/SUY8OkdzLkZZ9n3nKZY0lVfGrMaEUH/wp/HXKxNWHfIMTgWbKvbTa/?=
 =?us-ascii?Q?wT6/bQfyMrFLB5GscCi9e+eds6I2FRnvoFxf6O4FtouJJ8nznm8EsYfgcNuv?=
 =?us-ascii?Q?RERhWSJ6B1HC5/p2jkb5i+uzp9SEv77+k+VXMwXHn0TVsm/7t+V9FqpR6Rm+?=
 =?us-ascii?Q?XugJpBJc/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad944cc7-6267-4469-ca7b-08dedcc47d1e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:42:40.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HygfMKdM5yCZpcKKx5hS22EnY2BuBBowJxxuPl3Bz1m9OusS3tgny36JQl1PIWFdRI5dltqIteI9ozmgKpO0pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

cxl_get_feature() and cxl_set_feature() build each mailbox command's
offset from the starting offset plus the amount of data already
transferred, then store it in a 16-bit field. An user-controlled fwctl
offset and transfer size can exceed the feature extent, allowing a later
offset to be truncated by cpu_to_le16() and target the wrong feature
data.

Reject requests whose transfer size exceeeds the remaining 16-bit
feature range. Express the check as "size > U16_MAX - offset" so the
validation itself can't wrap on 32-bit systems.

Change cxl_get_feature() to return ssize_t so invalid input and mailbox
failures are reported as negative errno rather than being conflated with
a zero-byte result. Update the EDAC callers to handle negative results.
Keep fwctl behvaior unchanged by translating helper failures to the same
header-only RPC response carrying the CXL mailbox return code.

Fixes: 5e5ac21f629d ("cxl/mbox: Add GET_FEATURE mailbox command")
Fixes: 14d502cc2718 ("cxl/mbox: Add SET_FEATURE mailbox command")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2->v3:
    - Change cxl_get_feature() to return ssize_t and report negative
      errno.
    - Update all EDAC callers for the signed return contract.
    - Preserve the existing fwctl RPC response behavior on helper
      failure.

v1->v2:
    - refactor the guard to "size > U16_MAX - offset", the addition is
      performed in size_t, so on 32-bit arch a large user-supplied size
wrpas the  sum and bypasses the check. The substraction form can't
misbehave since offset is a u16, making U16_MAX - offset always
well-defined.
---
 drivers/cxl/core/core.h     |  2 +-
 drivers/cxl/core/edac.c     | 20 +++++++++++++++-----
 drivers/cxl/core/features.c | 22 +++++++++++++++-------
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae63859..09dd1c1722dd 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -218,7 +218,7 @@ int cxl_port_get_possible_dports(struct cxl_port *port);
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
 cxl_feature_info(struct cxl_features_state *cxlfs, const uuid_t *uuid);
-size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
 		       u16 *return_code);
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
index 85185af46b72..aaa408445fd4 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -220,7 +220,7 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
 
-size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
 		       u16 *return_code)
@@ -235,7 +235,10 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		*return_code = CXL_MBOX_CMD_RC_INPUT;
 
 	if (!feat_out || !feat_out_size)
-		return 0;
+		return -EINVAL;
+
+	if (feat_out_size > U16_MAX - offset)
+		return -EINVAL;
 
 	size_out = min(feat_out_size, cxl_mbox->payload_size);
 	uuid_copy(&pi.uuid, feat_uuid);
@@ -258,7 +261,7 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		if (rc < 0 || !mbox_cmd.size_out) {
 			if (return_code)
 				*return_code = mbox_cmd.return_code;
-			return 0;
+			return rc < 0 ? rc : -EIO;
 		}
 		data_rcvd_size += mbox_cmd.size_out;
 	} while (data_rcvd_size < feat_out_size);
@@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
 	if (return_code)
 		*return_code = CXL_MBOX_CMD_RC_INPUT;
 
+	if (feat_data_size > U16_MAX - offset)
+		return -EINVAL;
+
 	struct cxl_mbox_set_feat_in *pi __free(kfree) =
 			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!pi)
@@ -460,6 +466,7 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	const struct cxl_mbox_get_feat_in *feat_in;
 	u16 offset, count, return_code;
 	size_t out_size = *out_len;
+	ssize_t data_size;
 
 	if (rpc_in->op_size != sizeof(*feat_in))
 		return ERR_PTR(-EINVAL);
@@ -476,16 +483,17 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
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

