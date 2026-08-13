Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CDC2749DC;
	Thu, 13 Aug 2026 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592764; cv=fail; b=kM8iVfc+vzoc4UOGQ5Xacroc3W+GPaevyX/HIVd6fWI1Ep4cPt3aoDaoFagnxd/fWj6PpNk7eQ4uS32INTwRlcyrJdttpMG7o2NVblw1nB9OHEAwzYXsWrQ6pJgz6W1UikepSR+klZW3BGfSxtADbW+smIQkz4XwQjYhyF6xB9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592764; c=relaxed/simple;
	bh=BVHR0ufqrKrSKizVnep+oJsuiGwJAHGQmYpy1ObZEGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6SzLpFvNxYZZKJAtICCbHK2EyTtqa5Xsiav76wfHvD3/D8nE/NQ6uhLP1Pc+be7vSmXHHbp76UsCgolefdJ2BlFm/pbpHdhrxAp0cHmV6ym+sbylbFYxraGESaUSFSd7QTQn4NyTlNtY4nrQFOwzZdF0Uz8fyDV/+a5WNmifDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KKq4GtFi; arc=fail smtp.client-ip=52.101.46.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KKq4GtFi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBQDAoewFC8ImkuQl6tF3u3Cew3q8DcF6H6SC3Kvfs1ZUqoqcm2eRGpvHziXDGQhTLS2orxh5LQGJuZyYtp1xyJAXlvQqq5ap58yjoRnwD9Z9JzObC+izMO+T4KDYwvqiBK85IYN1joHeayTamD9GitB9fDithXSVhej81dben9GYnTskFiyB+3uZJ5arPbS+qFgU/jCzLcCYBPPT4jcXsS/7BR0UW3OdY3yu04hRbMgObKAVzVTRI+/gSOkIgyN0lDvX3PXiAW01WL3CjFmTXoELw56KsAkvBL2J5jGScmjVTpNi+g9dNGy6vZdJWXi3I5Qy4K+ZwZgYRSBuwVesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPX0hP0cTHccGMcHn8PQ0Bo8SsfahFdlJ3t+MPc9+rs=;
 b=N1QsxhzrEBQfkgAUyNCNolEvBKY0sKTEC/c4iAh4Hac5PuJo7iRTNDhP3ansCEKH+CU89+dqsCUR9uIoaO38K/DdM6gcuIhFyEtsd9KCgbFXh/XljBdavflIz+4q16CrBsjh3bhKxSeHUnxmHVzCYkeHqmgWnbRYajxbTdu2EdDrB2DXVXBCcbRx3xRmyKpsTHnaBf17j5EV0v7ucnnwBueGmUaUIU6y7XdIEtSQ9qyj4kZbS7QgtN7eMUDrkjM0iCY0RII67BjEhSzv4Xqr8xIXogfaOpkX23dqqQpyzcywJNxeJxuvfTVDZaNgMFiBYDv0Z2Xtokd3qyuTN0E+RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPX0hP0cTHccGMcHn8PQ0Bo8SsfahFdlJ3t+MPc9+rs=;
 b=KKq4GtFiM+A2pOcw0vFaKDg+D+54uOyCWzlEi1OXR2nSVGtiEola8WnnXgcE/AEIRNd3bdLAlp4Pr0KPk71WwvjMeb23MQFhwQwHZRbN1v2mT9aZ/lYyJW5o2d4Ix8exZ7PNZlD53ulzmuHhDC+agzXwdw9rzgVswduKlbOlw7YyQ3r2ugCWGNXr3WYo340Fxv/JeTo3UZDQz5nkxUUGuHFXCL005u5xFKIA1l6nZ5R1/ygYCXmxILWbHtPRqlqWC9IMd3tHpNptaGFceE+LqmutGiED2fQT9QSzmFCjZhGGPIcJY/FZujuRwbCZwlK6d2svIsNF1UhnfjsmUVlQaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:45:54 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 03:45:54 +0000
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
Subject: [PATCH v5 1/7] cxl/features: Reject feature offset that overflows 16-bit field
Date: Thu, 13 Aug 2026 11:45:32 +0800
Message-ID: <20260813034538.13189-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813034538.13189-1-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 3129da59-eca3-4efb-fd6c-08def8ed6035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HNBw4Vs2Sqin++z+14iAfB7Ba9sHv64b+zMKAqt+zCzm2hZo5ek3YKzaobLkj4sm1yFVvksMedZRmChuP+aABefKeS4haFM5nhKMiQO86ig/1XDvZLdMPrOU4REvzf3fSeeTgfqQmv0UKyR8F1WP2wCchceEL4VhCYuGANpnhmugs5y6ADupEDFHxsFmOChnRWic61Jp8ZNW9vtaC+ImMvqqZ67ewEsaFUXeTHCkiNIFtNizOk8D4lLmoio2NzdZfzc4nZPcJKSTyErXmSKFqDGIawxa0xm3E/TFV9UEPeC4PJr9LHykbneO6AkDgZ4jbVywaZg3SkDaZbZ81U6MdUGsZQCxEuz5wmFqhkXm4MYodSleyKYOy0KubeH77GfjWFh0VgcQ0/dAjdv9/0G4tsWmP4ntFaLlUHlZtgawGHvdLaBP8dWg8EV+53pFEdRU2hCVBO9b/S3aXTGRjPn66zy/mVtYXImgj6YZmJJL517m5KG5Y6fLeT5kb4UhLBaOm0S0nThjFCxMRsqZ1PP8CeplTmdtH53zpz5DgvyTiiZYc1kXsA9yzgPx0c7nvgQxpt8lldPznM/mPblUL+42v8SZLhZkpHLX3NG/Ln39Cl+aRXfKKbAnnKF6VK9nkSOgtcppyZ3AZipG28zeqjJxj4eIXndFYPL5QbjRbKYA50k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zqf/UzX4iRmOTjGyS24TGXjrjqjOH/vWpYOiT0XIzDOvj31/PSfX7zfl4Dtt?=
 =?us-ascii?Q?J1xGlzfkXQVPBOXKrKzSfkbWYPRPavdPzhBGNpJ3QMITu9q3+Ok02zJuqZTA?=
 =?us-ascii?Q?GouvxuqMP/2VD6R7mQfusRvOqMycjAv/TuG/T/APmy+Qx6ER355neWtx69uP?=
 =?us-ascii?Q?/rOwYqUz+RaA+jTFIDqjbi9qDA4/ZVzx3cyxUsJGw+9Kn7IyIZv0aLDa2vv/?=
 =?us-ascii?Q?piuZfKRnCDAwhwrt5V1OJ0ETjWe64eGFC1ZhBj1Jomr5wrfcSssqGeHi4kfL?=
 =?us-ascii?Q?ZZGTEHjIAxtU3sbjWJY3nC2pHJ2qNzDCLBIGL37JvSoP5BO1p/LK9bqI/8qw?=
 =?us-ascii?Q?AR6cbGh+78K6td9PRWklr3jpqeOROQ5o62JFQqlJ9ORe5fTFaUStDj7xo9ZP?=
 =?us-ascii?Q?oUFSzq1r/YCIF6a/ekrhrhF+t6rPU/QxOcn3q08PTmc8RgKEftzi6VPhtnOE?=
 =?us-ascii?Q?JjqgMM3/jQZwjB0OmEmYQxyQvakkSaGSQNRgrtOp7Mkmog5rEIYpunzB7D8w?=
 =?us-ascii?Q?FJwwrBwZTX/2aFcdG7+canfRzTseyMA34sHadc+6rkU43yv1Pr6kJ9PAhaK3?=
 =?us-ascii?Q?WUXmwdTb9j0FrbcvkJUSobGb2fd8dzez80SPgF6jSt6Db/wnwv8lKECGUcsJ?=
 =?us-ascii?Q?e3jMRuHq2/cUusoHiKks0cquFTRCt1K/LMchRZIfT6YfsX02w0kDS6nEXH+Y?=
 =?us-ascii?Q?LtFB8ECl8yCP56k63krQa64bEGTHqzN+cnzjgdKKf3Ns2A1aRiPxxnHAUKoO?=
 =?us-ascii?Q?jl0cBzQw+jd7lqlHoqjY8oMy33V7e13iyj+suXUfJwjHELjyA2/VgdOAcQtm?=
 =?us-ascii?Q?CCGMxC5F6pHFwVUrv7EhzR5t5QMvoM64oriZeSCY5gVDyB59NgJVDKDRjuGG?=
 =?us-ascii?Q?IUL8Q0sHgdYEEcYKIqVTvm6MtJanOaY9NBkX/1xjwiroIf4pXPtDqtVyofKt?=
 =?us-ascii?Q?cbvlaEE3tIBM9RyA38gJBfiRUWTL+9OJXCdYg3UWKp83QrfmcNV6qVefWZ7D?=
 =?us-ascii?Q?z7qwRdFYXpwWk/mlTVUVZ483lK/vfRI5lNthF8E+JEYPv33pS0D7zOnuhGfa?=
 =?us-ascii?Q?XbXgw/k+oB1lBupwwmkl+W6Yy/GpET0QYxrHFzNaQK4tEru0i3S7cqCzpNZp?=
 =?us-ascii?Q?uxU3jBY+P5ywrvAZs9yATCzfq0ZsOoVqEGVG3tJVgy23l4qRJ6DJcyJ/wVJ/?=
 =?us-ascii?Q?4SkOx51GCYtIYTQ2pDWacRE97BVqkNyiUfJllBsqB5k9ZDfoTFhY8NLo15Zd?=
 =?us-ascii?Q?Gk8rwShvYTxkD74rLiP5ZN5PtrtrSL1E0MMSCKQn6Qv89ySy4v7LKc7gA5Lt?=
 =?us-ascii?Q?NELBNpL+ym+/hGrB4E2upI10TN/ftUF2/34QelqChL773ZR7da7RO4NdSryL?=
 =?us-ascii?Q?KzdFJKqE5oSjqdtgbAGDNBTmNPYXuWVAnR+W+P/wqyC1SujWUfPfNnPThUXY?=
 =?us-ascii?Q?DKbgxBiwsKtpCdKPL4X8dqVTErAzQZQ4vmZgD5bszsKDfJ/Rbjv0ZdHXsJfy?=
 =?us-ascii?Q?n5xaHcB6I6N6BlEDR1CHtQYgEfN/fIwNyBOQrPvpS8cx6GAP8MBmoGbq6Tpb?=
 =?us-ascii?Q?kPJr/4+b+ZxRZnlyrxT7B779of2csHAGYyVDtetBBlibZb1UV93ke/Jbyt5t?=
 =?us-ascii?Q?JRR8VCFqLu+joTvrJO9hnX7cDDX1BUXLmSS+2hIKoxr0+2OxHOwR6QxX6AQw?=
 =?us-ascii?Q?0hldOh7JMcXKWE+giRm5iJgURoH1cbrv+ScifYyvfqpWICrpOHIELQXQDnj9?=
 =?us-ascii?Q?gFHoV5D6lw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3129da59-eca3-4efb-fd6c-08def8ed6035
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:45:54.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRlGLqOInZwFm17QFp9yUE2epVJDTqhno4IeSZRxRHFNYQD5lvPomnfYAguD7D2kuB16CY0kMfwBXWkwoFTEQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

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

