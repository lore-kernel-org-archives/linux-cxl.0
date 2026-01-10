Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012034.outbound.protection.outlook.com [40.107.200.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16DB33A718;
	Sat, 10 Jan 2026 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045705; cv=fail; b=o3os/DrTkAwe5ADUbRToJ/0bj7cJOAThEH6xlYtyzYwuRkUeUb15OKyN2ZspMer5WLyjaQwD0IeF5ovK+3hba1ppfl7s7HA/6cvBHiSnZt1F3E8cXqtUWgL0xCBILBSb4HnyXZPtAyPOC6QRI90kW3tR0qdpWOF/4uUsmO7q9kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045705; c=relaxed/simple;
	bh=f0x3B6gTosMnWKlckugYHi4333ZFknFdmPqhX8W3sa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJJFEEXOXT8WjafWXBU4RklTnWr+MCI2C9sctLlN46KV+hdIvZ+MSDUv5U4y3wbhkds5CAPNyIkPCn8Sn868oeqwNoTFzMI0X0SCGeIaq3NTGCPlzmfC+oXmMGzDlbMXtlikq9HnXr1/rKWLpJJLkfX+VzGFM6cMs+vDHrcAI/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hoM4EXDH; arc=fail smtp.client-ip=40.107.200.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hoM4EXDH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6+R0w6LFZxEhhEGnL+LrFgJ1Nhlp9HuuSfeETDbOUfZkE+LEjIZhKv60l8TeRo3pLpFbvNbZjEZyvtZ5ee1NZ7ZFnBif4OQMm7o7ILBt+DepCuiAy4Qqv077+FApEuUp6tOVTM28nHBUGZGUhifTbSxSdhTj02sGGDN5/53/bB8ggiwMOPkiHE1qV8QRIbtKc6vBnTdEiZcJqDkMqGBWWc02tMT+tdD1YpKB7nM35jgC+U9UE0Yprbmk+b2uqj+iiPxv9zdHvHCV+7M/sC+XAJ+3bWkiEF+X6vL/LPCFZe//QaSGa2YEr9HcB2KSWMLaUW/LcfaSxtNwL0ZhuwaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KYYOXCadyCQwgFcgsIYFRW/HyFP/pZPjszkjcPExvg=;
 b=oDB4UnMk2bLyilmhJvMkmK+Ekf2hOocmFfWVEJ3MPKjG3cqCGhdDEJZbOjTc7A9eXmOsNteM/ml/zTIdbzgXXlpocRGXSMJYEZvoQ+10oY4aW1oTJZw0u/He9qEzsuVx3AZ12jrSPZ4tVZLiZ9UcQgtfX0luqaFoWGzNrUOUjhwckLur2eoWoLD3gXIArN9+FvZH8UNULXoTdPuhMOUcugfhqN/UjarBJRpO7FenImuWj5Hh2n9naYQC2I+6nWQd7KQg4wmris1DSPP6yBOYgcYg1dNB22x42NqV/iZESDFQlvc9FqL01JH022neSFJJ3pWPNFQ+UYzNrwyfWDq9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KYYOXCadyCQwgFcgsIYFRW/HyFP/pZPjszkjcPExvg=;
 b=hoM4EXDHf848qf12Eh0lsEg785b54QQUdnSSbiuA08tR3cs7e3ngs29Vp5muPOMRx66H25CKxwXQ98cCYdkkUkVH5hCN+F6akj8VXgAR9yVomE5GglzMwLlzULICrgEPWuAnSw48AFNJxsY7EKaoWtIjqabjEOzlZsnmrMXKNHc=
Received: from BL0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:207:3c::26)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Sat, 10 Jan
 2026 11:48:18 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::5b) by BL0PR02CA0013.outlook.office365.com
 (2603:10b6:207:3c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Sat,
 10 Jan 2026 11:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Sat, 10 Jan 2026 11:48:18 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:48:14 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 12/13] cxl/region: Factor out code into cxl_region_setup_poison()
Date: Sat, 10 Jan 2026 12:46:57 +0100
Message-ID: <20260110114705.681676-13-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5a852a-8d61-4ce8-02fe-08de503e25c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8h54mxI1kY1G9EQY75EGyyhlRRbQf+LzLOPN95qEwKFGDunr6R09ENdi3gzn?=
 =?us-ascii?Q?WDmdJGURWAsgNeG6sL12hdN9vq9+9fNHmMNdNCaWxCeVECHfow/qeTIP/W7y?=
 =?us-ascii?Q?gwdA8ND1jkn0H0Q3Lz22yaE8aktJ14hUjtAg1Iad7iJMmYWiXjOkmIwXMs6u?=
 =?us-ascii?Q?TZPKwWUO0A6WJrTPlCnb82gyy1C+w2M0Eq9XYSubHA2LPkZeU+gvD+FoK1uC?=
 =?us-ascii?Q?Pa4wVDi5nkDd9p69XHZA1hG32zFgLnybFdPi1sn1FAqL5ZbTl1B0tBw4/uPl?=
 =?us-ascii?Q?GoXkDBV7ROq1LEL6WM+W72+df9eDaYlO1o46OnEt6IfFw0aKwnNTFoUdKHbw?=
 =?us-ascii?Q?7nOb/JyLmknHfYWtaoVBzke6KGeBGVdW+nanKmzUb6I9+V1NiEF5VjUg9zid?=
 =?us-ascii?Q?xlOv10QAkx3YK3POocmAhQ5o/i6un7nnoZj5K4JLovs9X9Ur0/2EMO+qlwzU?=
 =?us-ascii?Q?LqBdiZAX7ilX5NLl37pq74T1J56DGToLX6el5pDn382Nj6n6lt/Oun54tkIl?=
 =?us-ascii?Q?2frPdVP3d24ndbo4HoshTEODvo9dPUdkms5ESwoflPMlGq2MBtCEFhcBkRy5?=
 =?us-ascii?Q?o0alf61apRbO1uk+lyMLMh2INEHCeBnnO5FIY3e11INh0WzmFKFuwRgQJjXM?=
 =?us-ascii?Q?FLjjf3XmqwqISPc7B6Vd3JAzbdeiir3T/CSE20e//GpulRvAfu+KzZmxB9bp?=
 =?us-ascii?Q?dDcJDZ1OJ0J+bLpXJbw/T+E70nxb9j7gCGQksAe2Ocp6NqW6Zj7bkFH5GHRd?=
 =?us-ascii?Q?HbjTnk8aXwslGzmTBS2K97je0L9JK0lnXnA2uZIwrrQ+n4SmyybU/XYvct7U?=
 =?us-ascii?Q?kFYlgLieRrwiiSv42wo2Cz9/W52/HQ+BkrwTcJNFW4r874+1YaArW8qwD8XX?=
 =?us-ascii?Q?YUlKw5aWzgCcwRKK2JeKD8HmTfo+vRY4TKsD/vDNNRa21rgWE8lBEeWjq7Y1?=
 =?us-ascii?Q?sSiXy+WjVNTTuHmf5kH4o3T+SSQnkoAIRj61OF9d5Ooq+8cr5X3u/0mfcvYO?=
 =?us-ascii?Q?CiWnKaOxEor7iTWQPbCD/mqrNaPOCAof9Ye4Oioodqp6hpbTuZ1H4kxQ0h0m?=
 =?us-ascii?Q?75N0cxg7Stx3+E0/zoL/1op1UHS0JrETuByzxpbKYJWoAVSu203W2gD32281?=
 =?us-ascii?Q?iIoyUVhDPag8GkhAxKHJEeHThOVBuKIl8iBFsQMQkMqBaB3Hrdkdj5+IP+Fz?=
 =?us-ascii?Q?qTPFDQb4NSBJq5g0P1Ccn4tn4GZnyShputlWNMylDnPGtReerTjAhpI5hpWq?=
 =?us-ascii?Q?JcpOuPxss0d2sKR5zo8qPINRLP1/t1efOtC/nZ0Eu6IhUSzCwEBbmzo5huvX?=
 =?us-ascii?Q?Wz/zvV5c89ZvJsnB5pHueBLuL9IS48tgBZ7c0PEOI+RYzS5RO2iiWK/BOv3X?=
 =?us-ascii?Q?iMmPdlkq5e8dZPqCrbpx53GY7f3cdLqkMOKUXdabjIN6m9Z3BnlQF3CVyEzt?=
 =?us-ascii?Q?XjD7xI9Ba5DRN3dDcIysNISMkbzZa6KAS+6QEhNkqbjeuU+SvPH8X0dBn7Tt?=
 =?us-ascii?Q?Lj59uAcYCDO9dGa5/MWYTk5tK9gEzSg4HYw42gKTlcQoUf4HJo5jE3h2UefP?=
 =?us-ascii?Q?JaRvfDvbtrn16NkgKow=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:48:18.4557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5a852a-8d61-4ce8-02fe-08de503e25c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

Poison injection setup code is embedded in cxl_region_probe(). For
improved encapsulation, readability, and maintainability, factor out
code into function cxl_region_setup_poison().

This patch is a prerequisit to disable poison injection for Normalized
Addressing.

No functional changes.

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

