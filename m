Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAA3C108E;
	Wed,  5 Aug 2026 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909343; cv=fail; b=f0GOTgNw1o5WihNe4dIJ1sLGrSWlDzwPpmlrUOGP40vsNBu35+dEWPJLAG/yfm93wn1ydHpIwIQlPxlpaw+QRFlUsY8BlhUuNt+TD20nic3R+1drhcKRcY8E4w1K7LQn1dxQveGxlsyKELiokes2zgPzNOSROtrRgnF/1LH1J7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909343; c=relaxed/simple;
	bh=/GOYocx+vJ3wJ8C81l0S+VhTa1OFZdNsT1gETnh9slc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JQr7fz60F7MmZ/7VvYtkQYxmzE7IQOZcG0Jz6ST7GpH+hyrrLiUb6CPePGHExZBPPVyPcuvU+E6f5FcWCkb7/QMl7H+2NoKAGhg9kSU6rIGM2vI+2QbEPlza9IBsNN3GVylqBT/MC8zAD4PUY9u+yF+l0vnYkUnmN1z2PoJRtSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sigVJ8DM; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sigVJ8DM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLgLiwCISQL5DuR++oMMtfQDH9neh2KXI1fnewC0KXACCfdAB9TwO1DgrUOMXnwig5K13vGzhyCr0vq5GH28lx1+hLBLXmnRnnaAKhxWbos+Mp915ITlvgUZl432WZ4fdC9BElP6kR7iBXWY6GLbVU3MIk+EG0J0+PKlXfHk+Un4z+Z/A9IjGy2FVbR/Kx4fzm7AbtjTMkROVAh6a/MfrRn1pmDIxGZA+afIi4kFBT8xI1QuR0jT/J+Yd1wT0OKx+FhTEczs5qhyn+SKrHZLumQiXNWuTVXDd0zYjL6LblnQuyvnmRbWeNuS7CJTZTXAvYeRByZAZWV8cvTguN2NOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9e1DTWRZAvLxKcNsfBQyXUvgARc8MzqXTKHzzZo4b8=;
 b=sO+BdurOLXGeIqdpCd+YB2UlGqovN4+cVXeA4gOIzRZBvQKDwRRZTeVmJD8zEORrTtOh0G/DoyO3PPDKI2ykW5phhsLyvqep1GaRm207ooKdzjuTooUJlCBlCi3vWVjIPjAm9lw8aaM7x8ZnvHAdh9dXy6mO216XCZ/+H6JZk8MHq6uQ1BUX1peClJlKKzHI8kjk8XUc1PEu/qOgm0oG4yaS+JbI850Z/xlVxI1TqpbeL7gthtGR9DtsMu1IHvGvs2InC+cmg0lEgBaxWegJV36DjSoLRaq8++Za2uKi3A+CsNsG8t58XoqhGtPmcjLAjhcumxpCalo94qy34FYBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9e1DTWRZAvLxKcNsfBQyXUvgARc8MzqXTKHzzZo4b8=;
 b=sigVJ8DMpmFGQBfSpV6WhZU1neG5pXs9kyDdjsdKTPt7PLAWXdrVAKo3yyXdFCDjM68xsElFVYeo2MNS+TwzZ72rgW2HjylbhkrzyBz+qXhdHen1xDLzv3ms45Or4kOd1+m5nRhjv7GPHgPSU6iC9GGKO27AKkitWC2Iz9eUVq/of9bvt6+jNIGv6hA8IRGUbw2yxMJai8KwzUKRTTf44j4NoDrOkWesuO96q0Sd4guIG4mLmQbr9rTskm8hh/ul9jkFad2Ex7vChCzVA1WezXQl0Xa93Ob/Cr+lNqbR4Z6ehQOfaM8t/VuFzE5bBKJDTau7exb50+gx9s8u66LWrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 05:55:36 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 05:55:36 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com,
	alison.schofield@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	mochs@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v9 1/3] cxl/region: Simplify poison_by_decoder() error handling
Date: Wed,  5 Aug 2026 13:55:22 +0800
Message-ID: <20260805055524.22311-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260805055524.22311-1-icheng@nvidia.com>
References: <20260805055524.22311-1-icheng@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d3d0db-c58d-4763-f291-08def2b62bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yLNT0KKIhS3ID0e8iR3r8bSvVIpuedI05KrhfNJZLtHaOiPCk/IuOiLPaPPcILetldjvZzIapzA1oT/8SOwH4gBNrzuScIHn9tpXmwQSxYQc88nnlgDG5Z9DjFyddIfPjRmUFZ8QAH+De1EXWmrtik3NTve3zs3ysNQNhPA+/wAvZNu7EEvufDmpcqpJwwBJo4CFmwJZAszrp2vGfeTdUUaAuCY8nBVNYtsHRzdF1GmbbW4JCpNWhfASkRZzAtJr/apzH9i1Ghnm0FGQzcVcXpKD8lhu6vmjh5eFhLJetiesMxJQNK+kyHtO3xcCLNYGQ5lADbgEhHGKoHFLV3m+Ek8APla6VsjfW/L7xGM5ty4ZVuL9Rq1PROarKYY2OmG3xbDF6JmwG6y7T5Hu6MoZGfjGBjORJJo1P4EG0Z9nnfX/8taHMHB9dYFtFFMCVCDH/k4JTvKO8V2XqMxIRCRM4uqUsxa7bmCtef5/rr2QrpS3b19GY8gvSzrr8F9nc5/J34GoKa3o5wmBAlrAZajLkQwCxnN2T6ZY9zLLEQvWFsD8X6LOKAP17j4CqA4zSeW56BEld0AhwSM92+z0BJMki7bs7/MDo8gImAcKfAEtcFcDE7peY6vIiRv8EiLQwJzzJ3ZqZXkAQKijVauDHuZrl85mM+XoDoqG3oSWgrnRihI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eY2fk7W4CIzXPskBj1D30Mlw41Kxi8PFEtdnS371oSuycnIaeBLow1CqJoy4?=
 =?us-ascii?Q?J64VwTJrQ47VCevQe0ETkSG0RUy3NuuieGUXWtLYMbGWF5xzxOqXMKneVkz1?=
 =?us-ascii?Q?prCSEaX/ud0UUwyF7RbkNHJ8lIazjuk46Tdu0qVl4nCMlh9Li9I/RkZZuHnJ?=
 =?us-ascii?Q?f65hGCrPEPi6WEEgtM8X3QIfIIdPvnz9wjLBn4KOUhnK5CwAtqQNiLj8W8Bt?=
 =?us-ascii?Q?YLPaM63WKKbUR5WjK8fxtIKOZnbjlimrlEMqydLU/KQvcFYBnfIR1ioskaMj?=
 =?us-ascii?Q?1P8GuGq29joRo2j7WvNrBrITwB7nIIA7nJeOC42yHKbMIDC9il+3kq9UnDNZ?=
 =?us-ascii?Q?8LJqARSaYZ//uJ4lKjvRynqDojBzN8vNQFpqzGbhAAZS3Ph/0BaqbNC1tk+A?=
 =?us-ascii?Q?HHF0O5PIu854iXLe25WFQcNxr3oFUve8hvUw8ygB6P3R6bNU5JZiewheAAV5?=
 =?us-ascii?Q?Bbx/I0/WJbbaC77uX9E8uU3eYk4Eax/hX4Gvj/b9LS10ZzeM8AiJiTZneRZI?=
 =?us-ascii?Q?72fDhZfy1f/zNIg/W71nj9V8zKdQQdhBOMarLn3lxTtwyIg+ueGi4VlgEAu3?=
 =?us-ascii?Q?ARmlteyu+CMXBhmG5Qo4K4g2rMJZKD/lTesgV7CHWR4rBeusypz4hFNI83Ih?=
 =?us-ascii?Q?K/5veA7gvbFZybI/BeLtfyvsUtDDOVSlihnEkIgSYqa8h8n3Zy/oE4C9t0jO?=
 =?us-ascii?Q?UjbBf4umugCFGqq34/9VSVHkPaL7PEpWxCDv4k9wYY0hXGHDLkMRidB6UH/Q?=
 =?us-ascii?Q?E8gSn0+5TQQ1PPmA/H+/jSfkdJE6frippfhvFX9kyGkdJVttF3zZAk0q4sgn?=
 =?us-ascii?Q?alcqFwTCzuz+TglSJwFrMTgRqdTbRFQQarQoStzLXmg6YkQKUyMS6PNqMS06?=
 =?us-ascii?Q?0C0110ATopcujS4m/RWCRaZYVhdoKfVr0NR7FU3ZeaiV+3zM17XQuhp+vQ9T?=
 =?us-ascii?Q?7LusrbA4hc5RFNwgnU/B013NyANjMnP1K3J4G1RPRELEMbw9D+V7HhnS6hcw?=
 =?us-ascii?Q?XjoTgjBG9i+Ljyw84gOhCXf57zg1aa0TmJprkW3dqyEjriCl0mf0jnMqmWm6?=
 =?us-ascii?Q?aLTt//lMEgtLWw/3x5Leqy7mVyZ9ioJbhZphkT46Gu2wRg28laBzS99mczLO?=
 =?us-ascii?Q?mrBLPdPmU9xYBbfzW7+Abvx2RT4T5sIG284eI1y/yYy7+uFIhpHjh28tat8W?=
 =?us-ascii?Q?pSxfaD0P8f5Eln7zeVwLxiSRydd7zJJ3pCwkLmEns8lRL81JGeFsIisSfWN+?=
 =?us-ascii?Q?f6aH/2RAwYT0oco9Nc4U4u1XtUOEdRIChWXq+QH+wy1XywQOuDA/4yJnbHMg?=
 =?us-ascii?Q?H/XUtDNHbMDfCBf4dYVLYIZuG3SckzpcpeTc158yM9yB9iBe5ITr+ZDQKUoo?=
 =?us-ascii?Q?tFETEwysn9+iziqIMPygGIF1H0kIydA2krH43vXNupPDn66+XYetSjHcEg21?=
 =?us-ascii?Q?8mR5tEkb8YkkIjhRuliS+OH5WKJvFJsMj/+1qV0z8YpoWi58S4gc4f7JtgsC?=
 =?us-ascii?Q?rUjUDpI+p/KxQNKn7HeUUbb6D+rM1A5gM+mrBpiROFlL0WDlZYqdskcmi++d?=
 =?us-ascii?Q?lHWDB/ShglgUk1w4QrouJb9facOfQTzwD+DnlU1onmcInWSWddsXHi2XLfho?=
 =?us-ascii?Q?lwBgA8H3O0YdYEljsa9IpfEkr3+jKsgshts1Xclee6G7U08h4Yc9y1ws0dp2?=
 =?us-ascii?Q?bKD/uNeJGF51bnKPcdU1Hcb1ynHCANOuZ8VegJHBLpXOa6LJ39HVKu9npcWm?=
 =?us-ascii?Q?Xp76LWaeEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d3d0db-c58d-4763-f291-08def2b62bc6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:55:36.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te0/7CUVyqGT1iV2vN0J6D/9AHkSPM3JoFtorvZujmqf1KFR7PvgyIOefJO9/g+lKx4g4rBcSoJr3qfCSBWyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

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
Changelog:

v8 -> v9:
    - Add the poison_efault_forgiven() helper and use it in
      cxl_get_poison_unmapped()

v7 -> v8:
    - New patch. Splits the poison_by_decoder() readability cleanup out
      of "cxl/hdm: Allow zero sized HDM decoders" so the functional
      change is not mixed with a refactor of pre-existing code.
---
 drivers/cxl/core/region.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..45536909cc17 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2905,6 +2905,16 @@ struct cxl_poison_context {
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
@@ -2933,7 +2943,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			break;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
+		if (poison_efault_forgiven(rc, cxlds->part[i].mode))
 			continue;
 		if (rc)
 			break;
@@ -2950,14 +2960,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
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
@@ -2967,18 +2977,14 @@ static int poison_by_decoder(struct device *dev, void *arg)
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

