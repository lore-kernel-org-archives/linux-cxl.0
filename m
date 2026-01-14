Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BA3191C4;
	Wed, 14 Jan 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409395; cv=fail; b=q5tWuod5JwMDaCreuGbNotZV2b6uQhmRcl7HackvBxHldndbkEQ818vN9T9dV7P5QPDCb3zLfaXPHS9eysHYJOBmqpYgE4FDVa/RnYLL8vYQraKxwaSXDY/C1wF6SqJrOxEgrDQrkog8JFq3/nMnSKF/E+cd45wMj5o2fxVYSSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409395; c=relaxed/simple;
	bh=xiwJAIUuh9AVDho+Gih/u77kTjCpeApAR4lYGw6KEmA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaDuHQHnnD2jc75bag4ySs9/6k0LBMugPXgsTbxk+FYrtcci/R0VAbHXWYbUBFuFIbGztSdSz3hlcw7VoViKSwJif61CDVMOdNlKknS3otN32Pnm2a6taBZSck0H+IMEmNmIcwBuzjiJgy1LWnM6iWD8k5HoPg53ZO/ySmhaehY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5BvKpnzV; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5BvKpnzV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJgKXSSnp4PPjWJvNwGM4YXWdJ2CAJrOFS4L+4vcR3UcyyruXJn4C6zExlfhIAkHuhHmerS3yzPBdwk/aiYA+Xcjkh6Yi7RQRtAQ7wzmsOs8+VOFlrm7nCSziVMAKY2zgOhkgd4p0IVcTsJWR0yODpi8PZaeJENPDAtWpl7CAhh8DwKIc9kTpm9Ks513A8KwkFmTofrB/1hstM8ETvJth9ZKctgLkffJYIQ7q5xIAYHnu5dJOAfgOyIdu7S/FlPA3OJ1L6swLi8DZouQi9LZj/q2H2fQQgWtafmrOwbtGFDOUHbVRCmNqxCk+Xi9bSF4zhoZAhsVrEV6LsaCb00pfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trp5Yw8f165Rl/oFd2YnsS4tfmH9XWPzMgehjItzdeY=;
 b=w+3bdWuvbgebaiCg13CP+RtouJ5sX3mhI765JrHth9rGKsrb5rH3mnJVmJkeB3Etk5nGbrySHnC7RQtfqV5Z7bFCzfHp5epdpyMptbya6Vrs+4/ldLmTQ5SPPqs3lFZhQiJr/v0YAjYRm8Js5nkoAKKI036d3fKM1aOqQOp9w9rnbX6ZlCu8C1Tc+7KGaMwvHG5Bpforqd72cGuGMM7K3rgiIVNqSVWXQ44O9NvroqvPkrrnwfh1AkHW43sDio46RuXBSVC4VEPFv+WVmhcsb6b4iiTBH9UPZl4sVAj5WhHSfEBZZFY1w6kRRnYIc4o+IqZOzUS6YH2XL+4tSIABAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trp5Yw8f165Rl/oFd2YnsS4tfmH9XWPzMgehjItzdeY=;
 b=5BvKpnzV2fQBP10/uSkUr0whAYEtTy2dunilFsDusRKiAl5Cqk9xilyhLfAeBrb8J44zmuFKGdzzSEciw3yRUwGxdjicr9WPnGYeE7VnDvVHuYpBxshPkRlxbJHw263Wcme6UnDJpXc4warAUiQH65xQjoDNAWOhmPnBoZPQLsA=
Received: from DS7PR03CA0039.namprd03.prod.outlook.com (2603:10b6:5:3b5::14)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:49:47 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::68) by DS7PR03CA0039.outlook.office365.com
 (2603:10b6:5:3b5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:46 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:41 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 12/13] cxl/region: Factor out code into cxl_region_setup_poison()
Date: Wed, 14 Jan 2026 17:48:28 +0100
Message-ID: <20260114164837.1076338-13-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
References: <20260114164837.1076338-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a79dbd-7e24-44a7-805c-08de538ced05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cJCEeYfar3nzyEYQJxjC+Q+IflT8ClLK3zQVgBHW69ta0odboh2ZiBUoAyPg?=
 =?us-ascii?Q?QqSjCijWjS6QJsaDCYOojyXQqx8MShw6XwEZ90F6VG/+r6A+pRDcP52YDnQx?=
 =?us-ascii?Q?5VpqCvMkBmc3pQm81VFOpe8ExJuLzpjKgL6GWoqsChDVbZz1uQfn5zVmDK5p?=
 =?us-ascii?Q?0Z8V+CsuTU2ZabPomxqFAeO0zgC3q+bADRpBVkKaJiSRfVT4uJ8/aScutwy/?=
 =?us-ascii?Q?QTQhOKIHWDm4vo9ez+et4CgWMFv1cX09dOvVizB1QHCbDC8TxSYLRW8vq/pV?=
 =?us-ascii?Q?KM+UxlE3YJxcp6BYqQC2wbE+Indj19PqzYnFVG8FvL9VTVSMPgdfUj0lqE9+?=
 =?us-ascii?Q?pLBof1feEqUXBUAT91lWI/GbDhIrzClKRMKrAckgHrAKYlujaAU0TuvurUVx?=
 =?us-ascii?Q?FPJfdG+lUzkxEONmbqLrIJclcQg+gqM3WyL/m6zMuUZtlWmFmPPhYfjzYuib?=
 =?us-ascii?Q?lVGps9SyJozlodKJKdMzvZbybn7V5XGihLI3vMJD2KmAg+jRk+iEDJZClBwr?=
 =?us-ascii?Q?zSrv3fX8NM/YnSe6xzrsVv/Vl6MmZ5oCfhTOEg8BYsT6+Yne3u5nBdusWjxD?=
 =?us-ascii?Q?B733sD8hZXuB3ts71qAV1fpkAenKAH9RLuGawGKTO9krZRONm6vNw7b7xKK0?=
 =?us-ascii?Q?Xad5PgJCgxM72QM6eaOc6/MxqG9m0gTQv+Lmeoq1jaXXPeIJvyGZ3OJkLyig?=
 =?us-ascii?Q?KW7yCY+KycXtafEDr79SdaVs5DlHNn1WD7trH3VgaUgAAFmrd3XLThtwbs5M?=
 =?us-ascii?Q?8ppFpQ5bVKofMzOKO1I0PN6K97R7ABDFREF3h2XAk2fVqaZdmYXKxc2qZ56V?=
 =?us-ascii?Q?wlYy7RmtKbVdHHzkHVzlenmgvNIIkrpO9+geqaI0ye3mkQaJ9x0JRVjvtiOQ?=
 =?us-ascii?Q?IbpUExoaegVWijftAcZhVXegk+N6IvGE+9yDjfF0pfpmlcBPFW4YGlJ0pebj?=
 =?us-ascii?Q?iaZ5kG1MmE5hzdDODNXCqO/mFk8WYAnIFRxeiB0h+ipZUgciCoYr8RAZJS1g?=
 =?us-ascii?Q?regLaDEmmbS2cDmkuchcgqwwaOwSGyxQQ8vYy2FSGNMw4RR/IsV55xrcdGs9?=
 =?us-ascii?Q?QnaWMrljg70Xvf7rYbkgGcFWpYgAQbLyapr9KbolLReHzrnoYxa5Z022I/pZ?=
 =?us-ascii?Q?zlOIr2tPoOQtQA5WH8GzLMBeSc3G24F2Q1gxl/RGdGa9KUxfcdZKtWsGmkGf?=
 =?us-ascii?Q?e9xgoX5rALvIFpDHO8ZtOAf4VbFBS5Hy5EU5lLLeO08z8ZOmazdiNiXE08Oi?=
 =?us-ascii?Q?yX51uokmBhBljspxe505/scW6f0/CrtSLYXYKm+lOYsQLa/GJT1C0RHqshXR?=
 =?us-ascii?Q?2BNpG8AyWdrFx90w9KJXAXcDvjr2p7dOxjfHenjfL2au7Sociz1W2A9JDDgZ?=
 =?us-ascii?Q?07YiWI5QfmTwbBqvbFwaGq4SiWqlbAEoj1nMhiT3u8tWLVMXDS/iwpeBW1Ee?=
 =?us-ascii?Q?vLM/gtSbbHvFNRR4dmc49e/Cpt0/PZyrjKTppggXa4Va3D7XiX7n3pLF8Lfw?=
 =?us-ascii?Q?71bt11XdVjlwdMozEFyK+T4t336kXGdMN7WPTOl837fgwy20vLvfWu3FZVxy?=
 =?us-ascii?Q?hi1bobzRwyj/3xztYx+S7UvNY3AI+NQisuy9fBpUf/60PUDy/Nagy39mHaQJ?=
 =?us-ascii?Q?LHGm46fI/A1Cu1gr2XEdwkovvy4EmD9arw06Vxv4MzxvjnvZQXTc+DKuVgV3?=
 =?us-ascii?Q?SCFuqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:46.9375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a79dbd-7e24-44a7-805c-08de538ced05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967

Poison injection setup code is embedded in cxl_region_probe(). For
improved encapsulation, readability, and maintainability, factor out
code into function cxl_region_setup_poison().

This patch is a prerequisite to disable poison by region offset for
Normalized Addressing.

No functional changes.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 53 +++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ed8469fa55a9..80cd77f0842e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3916,6 +3916,31 @@ static int cxl_region_debugfs_poison_clear(void *data, u64 offset)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_region_debugfs_poison_clear, "%llx\n");
 
+static int cxl_region_setup_poison(struct cxl_region *cxlr)
+{
+	struct device *dev = &cxlr->dev;
+	struct cxl_region_params *p = &cxlr->params;
+	struct dentry *dentry;
+
+	/* Create poison attributes if all memdevs support the capabilities */
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
+		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR))
+			return 0;
+	}
+
+	dentry = cxl_debugfs_create_dir(dev_name(dev));
+	debugfs_create_file("inject_poison", 0200, dentry, cxlr,
+			    &cxl_poison_inject_fops);
+	debugfs_create_file("clear_poison", 0200, dentry, cxlr,
+			    &cxl_poison_clear_fops);
+
+	return devm_add_action_or_reset(dev, remove_debugfs, dentry);
+}
+
 static int cxl_region_can_probe(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
@@ -3945,7 +3970,6 @@ static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	bool poison_supported = true;
 	int rc;
 
 	rc = cxl_region_can_probe(cxlr);
@@ -3969,30 +3993,9 @@ static int cxl_region_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	/* Create poison attributes if all memdevs support the capabilities */
-	for (int i = 0; i < p->nr_targets; i++) {
-		struct cxl_endpoint_decoder *cxled = p->targets[i];
-		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-
-		if (!cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_INJECT) ||
-		    !cxl_memdev_has_poison_cmd(cxlmd, CXL_POISON_ENABLED_CLEAR)) {
-			poison_supported = false;
-			break;
-		}
-	}
-
-	if (poison_supported) {
-		struct dentry *dentry;
-
-		dentry = cxl_debugfs_create_dir(dev_name(dev));
-		debugfs_create_file("inject_poison", 0200, dentry, cxlr,
-				    &cxl_poison_inject_fops);
-		debugfs_create_file("clear_poison", 0200, dentry, cxlr,
-				    &cxl_poison_clear_fops);
-		rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
-		if (rc)
-			return rc;
-	}
+	rc = cxl_region_setup_poison(cxlr);
+	if (rc)
+		return rc;
 
 	switch (cxlr->mode) {
 	case CXL_PARTMODE_PMEM:
-- 
2.47.3

