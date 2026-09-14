Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721764195DC;
	Mon, 14 Sep 2026 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376960; cv=fail; b=Bg8VTFqqaGCoboKnK2Rt5jvRPzW5IRbVze4H4QKHs+pUvEwwaAgyRKEruQ0tkfncvT7YWrFc03b+4RRW2Ki3fyyCZ9hN/peJZIUgOpg24ScbYsSn7ta7hht8KyJS/m7XWL5hBdaugl0euTFloK5jlNRZel2ML90e4lLonj8FB3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376960; c=relaxed/simple;
	bh=4gwm1ocbZfWmqcfp4lcRgeXjhY7yJ2VTOWvcxP8lIXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhCGenYYlFLzjWxPF1PTNh4QckGxaDtDA9ECeM12myYObM5wmLlUROqx19DHuYBAqmURwhcNN6xZm789mwCmtwiKxpESnuA2eJIWHJ6ps4rHKaJkadIWnMhw7kjuajSmZ/cBb1ioNsMK8dm/2kfStmJX22bxs24+IFGBfKfiQ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d1egoCsQ; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d1egoCsQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6nmtCYwiHePYDEapNENUD7CRZ2EZKyFI5+OJXDrVNAFX9C2ZT6fLxmBrDZYyzEqXA50+L9gLdsjm3F5G+FhOZ6O/dt4e97H15D/FIxKFfBtk95bDFuDCPbXWmHWBOtYesj51YWnNpTdE1e/IEhP81njr1jRMGr4JNlObWzVEht4dJt6n5PiQlPyTITM4UwauRhhxvsmtnjTB33rzh5wZ2At4Ra6gNu5LAhtJcnltjtChrCVZ0mERppMeYNl3a0zm5YSjJgVsCqNPpjgECzC1YCvMomBm5uHy/IiW4jUnFILEaxgSUULVV9EzmkF7diytAT/hQwS+1vA46+s2ETMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rELGOd2EOFC0/7glJXtVnLTCSPSqXHsoqXqjQvgq5a8=;
 b=ghM0OUEV2OHcFXPGhSQBFGjdcqjGdbf9MXeMWGF+gJA/zFqUyuQD7VANjMiQ9Z22hTK/kopwP4HXnTU7GRY8I3lnYY+4drxVCVl28BVkz0BPjNrEf8eZrlxWW0Zs0QyP7A0q0/Ov//JQkz67rXwM1+ho0XctQRAwzX9o8FUB+sEoJwF7gjPHy+dG0N24Wizxgv+uyUsy7clCH6iXGUEmeBgRka5tYROrYG3zunPpfx2oaRm12M2ERyaYLqj4ED/hU9f1TxqX2ffGlz6LsBSzJDJi4Tj2Md+CWHfRDr1Sp3YPgtW2lqhWVdinboy/zBS6aIwqHxYTNuveEQHTnqFwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rELGOd2EOFC0/7glJXtVnLTCSPSqXHsoqXqjQvgq5a8=;
 b=d1egoCsQ7Dmx8JjTKcFgzRlaNj279WsdUrXSMdAeEFBvA8KPhEi66VFqqAavajDAmY0OjXZu+h2xNINNeqZPEHOZwEv/hNhK6oBEMWGp5Guw5VkHf4suekHKKVp2qWWfYoA6I3Wn/DOb5bHf/IAFZZ4FkJiV4AiTlsyF5ZGIFxo3xMEzQuxWtvkeHQ1iFfBA/bjmtKqJvw/sJAHqnjbQQVmYRu3BUBGmzDUhi74xyvbGaqY7CmUlaQD7qLct2tKUk76/M4/veeQcdhreTjK+HnKo8v36IIn9xlZMS97V49f0stIn6uFKw6NpuDukySx48kMg9hF2VSYfmMgyfJYn6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:09:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:09:12 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	newtonl@nvidia.com,
	mochs@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v10 1/3] cxl/region: Simplify poison_by_decoder() error handling
Date: Mon, 14 Sep 2026 17:08:56 +0800
Message-ID: <20260914090858.19181-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260914090858.19181-1-icheng@nvidia.com>
References: <20260914090858.19181-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KUZPR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:d10:30::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 52edff7f-872a-4fd2-d3cb-08df123fd7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	xD8UWdyGInGfry4amk6YTuEbgoYAejgVz6Ag75E8c0NDbrDjc+Nm/1S8ZhAtGtxTtMEj2lGtHnk20Xu0n+tQt9MwOrMlxoBWuMuPt8iA7h+5XboeYBGSkGcTf44IRqRKMWVQMefkZd5LLDm1CTGord22IdfOx9zlkzNZjtrvtOy/q2F5XePNHoz45mZErcIphs804xdP8i4OouDd3MI/r9ST9NIjf69ID/XW1fhD5/iQ1lQ8ceDqPMa1qkM6da7mjyAbn/dZMtYc8EOuK+v2ilUzxtIvca7fyq4hleGbvqWXzvST8xscke+3GCFOTQx/x43YAaUe8MEYmArojmAuxS1sEL5pZkbxkecwaP4+ssOxWg+BoNT+tp7/f63LB0Pi9QSn96383l7shKT/vJaYkx5LShgKyfocvPfz9NBjtCZhE+pjg9PJD1huM7/Qftu5omy4Xfzle+Nq9saJPxCurq8hCJNQYwkQkKn2n4oiieembgVyysM+xcVD9VFr4A53vq0uE7d/2wyDxbnP+qfskvOGIh31vpQzJ/x8SNsTDuesH7v2J3oM3TbXeZtHGK7XJ3YE7N0WsUKm9Wn123N720EesGAMJwlUstmWjwHbwrUlQO+CSHpoX9rVtIo8IN6C5iilfwzW3+RuXkUtTowqKnLW7EiY+CPRwmInGCsuuCs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SX+aHDfWI/gfVso2DrrOt/fhvucdImGkXGEb+R49tnzdTU4mrAOgqAAcgGH7?=
 =?us-ascii?Q?Cr75g+m92uSdcWkoy/nJZO2brezBbInk1X5FaY3jKcc2gM30OE248pqqfOJ0?=
 =?us-ascii?Q?5Sb5i8HTLTMCKR/TXiGnh6HAb1lmgdq4gYWPnABkLxPN2kr4rUhz4ucj3Dn1?=
 =?us-ascii?Q?ZfDlASoc1OBpAnlU8O/Rjnnmo3DBeDeJcIvZ2zAFaZuOagQM0D3aoMf2XvI3?=
 =?us-ascii?Q?gKhe7kMnj5xg/DTqOlDZlzm7jlLVBhHgIc8OMKOX3ZLmnngka9Kbj+3feMZg?=
 =?us-ascii?Q?sOcAxivIrcEoEXDvy1L8cFnHwImN2nOE35LAeosjStfTWKjE68XhXDGZMW9Z?=
 =?us-ascii?Q?MDZH+LHA5YD4z34vH9a/4RdGn8Zc/MdBfla9kSk2QTtrHrDcLWk7aJPl7+ks?=
 =?us-ascii?Q?z3mlxtHBTbMjLOq0yTcrLVHDIQrIzXcdXM0RTDOTumsQJxKltyUx92Avbysw?=
 =?us-ascii?Q?oiS7Ki1SnzkINYh8n8mnOI+g7tuIrsUVyfg2cvUX4g0PxNpdmt8Ab9X0V+oi?=
 =?us-ascii?Q?Epre6/XoQZkc9qq0oFyinJk5AZSbCjwG4tp5Za/XgSf/xkw0XrbUOzYKqqny?=
 =?us-ascii?Q?+Q3wOKRE49jbTlZIJbcvryrRfXHfDvhjRPcvqIpcYOrXL1sk45kp6upYvOjS?=
 =?us-ascii?Q?v08h36CFYVvutqbZWnFgrsqUGyrHeMNLx/oruwj5LjiNxyTgjMiGed1u7zHo?=
 =?us-ascii?Q?xzlo1vpuotJzujmRIrcDl3bwu4Ii5Wk4x6xe8NjgHdd5WMhW+8PIRhHO594R?=
 =?us-ascii?Q?xheyploLlRmk4Vw+9o8a8d1i2PSmJfLhoOAdsarcp8+E6MJkmcNXRVgfdAJx?=
 =?us-ascii?Q?+X0kKt9DyqacYV3us2j6kIaMEyLHz08jNxRQ64bfzbcJy73/DEAigx8ItvNW?=
 =?us-ascii?Q?DjrRc+y4sXNb7K+e6yj60ZazzGb1omEVqJQOAFICHbisea/9uwW3ozasKdsr?=
 =?us-ascii?Q?c/SpYgurFc2a+xW+u89b3dLZyEBAUuj5zfDCFy/ZJn7KD6mF3+CxF7eCFQO5?=
 =?us-ascii?Q?e8foiVyk81480VbYYiqHE0CIoNyJc/N44iBvQsxf//XQyjrppLduBzvzNa4b?=
 =?us-ascii?Q?oPtUObz7Bmtjw2IydzrK+oYvWhrvrLq/EojZMjm7uRzVmVgw2xCxAPL8NFTZ?=
 =?us-ascii?Q?AaIp+vN8960RDqWOYnVi6T0bHKMzcWqs69qGCEeY2FZzpr3V0c1JC2ITkcZz?=
 =?us-ascii?Q?sZPVXtNBIa6BUgomKutWz/gQ/tsYCgpy7QSm4jEDHDhUCbPsSuFmjfMcyAnq?=
 =?us-ascii?Q?9gPfPS+6TyGDyQYGfNAaYIJB9tFt64wiona0a5jxg+xgvG5d2oMTM0KojJkq?=
 =?us-ascii?Q?BvP7ESFgHRlUHc5OQTPqjfOolpag5Z6JUmgM6OZPIK331CYQ8z9V0oPdN948?=
 =?us-ascii?Q?XmvVaSUEGDgQ2fVAqRu5/K9EUgCPHMYeE8GDemQiviegY8QkLUW/Mq9rMANL?=
 =?us-ascii?Q?KKXMhqw1G3sPDQKPr1xPF/QKTmQKUrB7aICem3HYeH2PuVPI+lDYuQTpgVEp?=
 =?us-ascii?Q?5Xd9Sn1q5blMx/Gst/pk4bYnkKJzUNYdfUZpHYwi8aSkRqIdNBBUwZ783WEn?=
 =?us-ascii?Q?PzuNPA99UcVOcDz+aJ+5/EK/e5u71brDVVZHJwzhFwFjnJP+ai0V1ejReuYw?=
 =?us-ascii?Q?sXJUSrrDyo5sujKPnFe7XEK6CRH7fTg9hIWDgS27ugoU/EDgCL35+9lIXk1B?=
 =?us-ascii?Q?/wnlHhTUtN6KVaJWG3P253LPWyIes0+ziS6OD7+Qe8qwAJAsQyB6+L0bLshR?=
 =?us-ascii?Q?DlP8TFrUTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52edff7f-872a-4fd2-d3cb-08df123fd7e7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:09:12.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrjRMKa7clfBofIpG+bgwxLIYQDIuk2fdoyK4yoxqqS102DgDWcwRxxpJIUTwygF6NzBTYzvf+i6iM1zTYhATQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952

"rc" carries both an error code and the loop control
signal for device_for_each_child(), so returning it bare is misleading,
the early guards mean "keep walking", not "no error". Zeroing "rc" to
forgive an -EFAULT on a RAM partition adds to that by discarding what
the device actually returned.

Return a literal 0 where the walk should continue, and test the
forgiven case directly instead of rewriting "rc". Give that test a
name, poison_efault_forgiven(), so cxl_get_poison_unmapped() and
poison_by_decoder() spell the same rule the same way. No functional
change.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4f6069451fed..677ebec8f48d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2903,6 +2903,16 @@ struct cxl_poison_context {
 	u64 offset;
 };
 
+/*
+ * A device may answer a Get Poison List request with "physical address
+ * specified is invalid" (-EFAULT). That answer is tolerated for a RAM
+ * partition and the poison walk continues.
+ */
+static inline bool poison_efault_forgiven(int rc, enum cxl_partition_mode mode)
+{
+	return rc == -EFAULT && mode == CXL_PARTMODE_RAM;
+}
+
 static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 				   struct cxl_poison_context *ctx)
 {
@@ -2931,7 +2941,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			break;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
+		if (poison_efault_forgiven(rc, cxlds->part[i].mode))
 			continue;
 		if (rc)
 			break;
@@ -2948,14 +2958,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	struct cxl_dev_state *cxlds;
 	struct cxl_memdev *cxlmd;
 	u64 offset, length;
-	int rc = 0;
+	int rc;
 
 	if (!is_endpoint_decoder(dev))
-		return rc;
+		return 0;
 
 	cxled = to_cxl_endpoint_decoder(dev);
 	if (!cxled->dpa_res)
-		return rc;
+		return 0;
 
 	cxlmd = cxled_to_memdev(cxled);
 	cxlds = cxlmd->cxlds;
@@ -2965,18 +2975,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
 		offset = cxled->dpa_res->start - cxled->skip;
 		length = cxled->skip;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
-			rc = 0;
-		if (rc)
+		if (rc && !poison_efault_forgiven(rc, mode))
 			return rc;
 	}
 
 	offset = cxled->dpa_res->start;
 	length = cxled->dpa_res->end - offset + 1;
 	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
-	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
-		rc = 0;
-	if (rc)
+	if (rc && !poison_efault_forgiven(rc, mode))
 		return rc;
 
 	/* Iterate until commit_end is reached */
-- 
2.43.0

