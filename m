Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFC16EC0E;
	Mon,  1 Jul 2024 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856115; cv=fail; b=UWYUfm/2jmkvxvGqK2Xocet+DtwnLpV1OMjq1YKopCrRV7hYzq8J2VZxMjEwvqEN8o8GOaF0rpz9S+PR5J2gDCmvv+j1Fg2L+3F3poEiEaphMucHg4LQW5cv6wNBOaGcMuzZVHDbbBatiTV20sPsX8pd/coSPqBUNCw2RH382n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856115; c=relaxed/simple;
	bh=CSUBmafGC/wwdSnalGy7Y+ViTsiZtqFnkD3xzP8Vx6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOWpvYjP1anpStAHcmUCM7PTfcYRD5bbLlNPNjx88/nBnSdpa/bx5PtVGVt8lUYFMw0btriMz9VYr2wDoJsy4jm5vxzig4PV6nXvAusIQjFl1yZGREAB3H57Wp82Ur7dqwJDmfgq0hXYfqiduF7LhS+MbDOSkIT1R/JQ8vvqjck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5IQ1jVNG; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5IQ1jVNG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0dJcKHa8FqX8/ZsHDkvJTL7Js4Wk0BqrFYO4BDN9P8JhQdtm5/Tk/S60lT37Oqb5P0oNl6PwdOVZ54erZX6E+/wrFl0tXs3M80lUGJX1KD7Ihhk5ZkRmWhf6535GpLjOMnSAelXsf5f1ORvtQoUnkK4hPZfA9XrNOvTHDVoodavQcN5olO8bjAjiBWSVKugiXqMI76Um2hQDcJpOVdFsp8azb1JLO2ZRpaZyFArKXyDw9qKTfURtHMBokN9KFdRnxvnZw83Z/KtBhDeGBaQzPoi0A1Hd4afTtnbKMNG1hl4dcp1sYYEZwSa0fSjbTRkjNWBQnYc0thitAlv5PZs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvTHDYS5g3rvFskiyopebg68RQxdzwYWGUVzm2Z7aB8=;
 b=PeKdAan3+sZn+XDIBWG7d6oChql24CSN/KTLXBmT6bERjjSCdaRu1LaVKT564Fbsmgqsd+1SzHA9yiYtjN4AwvJ14O1Rh9wPOEaz2cap3CQ16F1408hPdfRMsPUPfjlYmROnZJVB1Rg6f9q9ZKMQwWfJKz3OqgkPMfpqe6lJXoy4PNCCcNkoYbxyNFLuiuF363BDOndU9wgL78lewkhElO8n/z2f/fkkRa0kh4LZciqRXwYfvqcyhPPVw2im0mIXvgx4Wum9TuegauacinMaOF3qPxj4eTt49uoZHEirsI3MUXggcxI7olpIy2K6YZNQCmseCmDvj4SaAXvR5D/uPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvTHDYS5g3rvFskiyopebg68RQxdzwYWGUVzm2Z7aB8=;
 b=5IQ1jVNGojE8/YEv9mFtRMydxiag6VPsgLE84kfXKdj+FVr7tMFdgWn/b9v5KBFS0J0O2QdGuMrdyn05EZCQ9i8FYZJcD5iClZ8PXOlkDaV0LBL/bGOTt08HMd77yoS/D4CROdDr7aOE4qvX3rPocEkjBlICC2FyjsRKgkLNlEE=
Received: from SA1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::15)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 17:48:28 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:22c:cafe::a6) by SA1P222CA0023.outlook.office365.com
 (2603:10b6:806:22c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Mon, 1 Jul 2024 17:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 17:48:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 12:48:25 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH v2 3/5] cxl/acpi: Add platform flag for HPA address translation
Date: Mon, 1 Jul 2024 19:47:51 +0200
Message-ID: <20240701174754.967954-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701174754.967954-1-rrichter@amd.com>
References: <20240701174754.967954-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 739c98c4-4f18-48e3-c057-08dc99f603bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jXRG2Gmh0rGf7dbZS2fCK94dSrleT71TJ3VOfFwR6d0c+nD24FXRG9xmAQTx?=
 =?us-ascii?Q?VB3ZmbUrzlioYF4NO3SVylFXZwax3CWVDcaoXel+2iKOYTxMQD+H/13OM85b?=
 =?us-ascii?Q?i/2s3zHBTZvg8O4gGoNlfwPAbSZj3KoHKQ5vbSzQpqe+cuYqt2fjOJeQPW8J?=
 =?us-ascii?Q?okLK9H/XvmGbU1VJiedDqIm3U8THWL/3B38WHAREymfp1qWQzNmf2hXOuB3L?=
 =?us-ascii?Q?Az9jhGLioWUZ43VjMt9vacFiiuaIsw+rB1QmGoZrQqptoouYSBmumod/NFKz?=
 =?us-ascii?Q?osu5y5WygFXOUubrWaSmA6rQGfxI3GQZHSqQeeDbg9YTpiE4beXzEZl05RZw?=
 =?us-ascii?Q?FhVtXdkfmyIyj4jlUgP8bBBoWDkuOgBxzMsbKGZ9iAkLbLeqgKarCatMQsq0?=
 =?us-ascii?Q?sFu9RV7shKSv7kkGStmuschHnypr/6To+CKVte5eeK2g/2SJ7HeZ8UzqgJcf?=
 =?us-ascii?Q?07nbSuCOUXlKtos9s7GngLqn30uVR8Z6jgWhf34YYl2gFK13upCVoCSEzpqJ?=
 =?us-ascii?Q?/C/V9cUpk/++qwIepowUX1dYoSsoYL7e7+sjnlyXUnNSoyXSJYDmT0ajadTE?=
 =?us-ascii?Q?LjXoYFnCdvSVgeouR/QoUCoLsc1GNz1f55B+/4QLl1bCf0gx/lu647xCy7iz?=
 =?us-ascii?Q?d0faFlaS3jwGgWKt1XU4Jn3LvnFS9ZbYz/C43/4P7Rg2ib4B6L2jm18B+Dab?=
 =?us-ascii?Q?br7nT0vwNZ1HlGO2nU9PDVEMRCiklD5Kt1VY4RW+sRR225vdbdqT1GVonYPH?=
 =?us-ascii?Q?ZzAhp1MBM49RV7xHbTSsQ+uteu0obmddR6Pm8DZh11N9r2Iu8YJXWv3KXGCx?=
 =?us-ascii?Q?HS9u0qwmArK+cjZD0J0MG2uIYgex3LEt1xcHn+ViAIG5Sk4DGLCl4GrpSw1c?=
 =?us-ascii?Q?2AJilLFLhIjdxZGxXFBvpL3VJGcEdnGXJe/UERYFK85/IHcw9aHwT73gqEl+?=
 =?us-ascii?Q?6IwF2MSV5PzKKXQX/dlNwvTxEBtPZMRg84LO+zSmTwfafA60Hq4GIN/IthBb?=
 =?us-ascii?Q?F2J+kC8yenllg9zkjiMNf+ABkJjMTOgQJ4pFpUU8diBgw0UYbFhwY714ULXP?=
 =?us-ascii?Q?OcSbK0hIdk4VxrtkBOuqzY0cx0Pg3+NvyTgcXHNAqRt+g8jvPbORbnYo9ieD?=
 =?us-ascii?Q?+ScQDlHUgzTjLZiwt5dT8xkjAmbmbqeGqDOOW2w7rX/1PjdkJ+FX83vpv3pK?=
 =?us-ascii?Q?dYlziPJ41GUuYvvex+thJ78LXZYDrO6So5ZBaVnDDyUuJC1SonlQYldhN6on?=
 =?us-ascii?Q?bz5dJJAWCZa+6vWCywWEAQjTOJrD/EVjRTW47foHNbq2sBfIL+r4/0vATX1E?=
 =?us-ascii?Q?7aC3omd9NAMCs0IvtXw2p8cH8LGEyJqUQPsvwhOda6H6lb6fQA36ty/1WjxD?=
 =?us-ascii?Q?tBW4ypxcAhx/vdhKN1AAKqd+3QQTgLtBhPUdhC874Ym2uNcCbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:48:28.2627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 739c98c4-4f18-48e3-c057-08dc99f603bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

Adding an early check to detect platform specifics to (later) enable
HPA address translation. The cxl_root structure is used to store that
information.

Note: The platform check will be added later when enabling address
translation.

Link: https://lore.kernel.org/all/65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch/
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 7 +++++++
 drivers/cxl/cxl.h  | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 571069863c62..67f73a831bd3 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -536,6 +536,11 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 	return 0;
 }
 
+static void setup_platform_quirks(struct cxl_root *root)
+{
+	root->hpa_xlat_enable = 0;
+}
+
 static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
 {
 	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
@@ -838,6 +843,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		return PTR_ERR(cxl_root);
 	root_port = &cxl_root->port;
 
+	setup_platform_quirks(cxl_root);
+
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 603c0120cff8..95d054dc1af0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -627,10 +627,12 @@ struct cxl_port {
  *
  * @port: cxl_port member
  * @ops: cxl root operations
+ * @hpa_xlat_enable: enable HPA translation
  */
 struct cxl_root {
 	struct cxl_port port;
 	const struct cxl_root_ops *ops;
+	bool hpa_xlat_enable;
 };
 
 static inline struct cxl_root *
-- 
2.39.2

