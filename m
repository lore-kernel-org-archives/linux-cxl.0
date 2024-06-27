Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211431A0B0C;
	Thu, 27 Jun 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528422; cv=fail; b=ecOlnrH4TM1HR8Ehm+fowIsW7+KnHlYccZ6yVNVI5swlu1aTz9YTEHLT2LhBpbctKovq+iFDX6CHXQScCV0XTblV4RzWvNS8AS3Hm5sD+Y/dCNwqwR4sSjGdaJJLqoNXfMCZzzQFva/Tg1psMdq3DGCYOmMD/Z50F6Zz8QGYEw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528422; c=relaxed/simple;
	bh=vxi2BveKx2d72IInQNT4V8klhjcRw+VnsVtOaZTJ/mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDzWy7eyfXFgI6h7IUuolaChrBvPKnS2Nu7PbVF7SsQoNF0gMm6NQdsLINPHlaxRYg/a2hF33moz9L9l80qyESwgo3X2l9Tj+P6I2g0LoAz9LVIUCnsSqLJr1Jgdbbbrp7/gNEdNNyqRfa8avCQSPwJB27CobTw6/rJ7H6XnwQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pVDxEGcw; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pVDxEGcw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhW2nrtpH7BetPIomAdd1EJV9P0oxaqqvuS8P1fYfZcKmgLXMhYw0e2VDCW9CPUKCRku5GjzPRTtLxgQGa3dP0Twslkfemv3riIPV55+hFPWE57NG6Y/cquONWPWYGDLwn8VeaUKGWomMa+b1u2QCiBCgZkFPlNC6H444cOat5xYKhaRmYWNYLpxI7z4SSMHYpnJP7jbm+s8I8PRoEDNvYI9ipqMXp9v6Hy0rp44Qfwl4MNnZi5pbBFNLo55U7wfTqe9x7CGFfHWajs6VUYjO9nPmDTm6eByohCfXhQeoud+8FusApXnCPDXy8nH1CzgXgi6PUa9kfgtEVeSmHQpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPrE16HyJfyTGkyDchmZus+YzDNBhVyxLDSXdh1TC3s=;
 b=Gt/gC56v6oyT5L6lKNK7F5iZaTga+zNaFD0yBgmz4JLTGctgBG9YajzUJIB0s8gXA0EI27HzXi4RGQJqD7c7xLPNeN+XgBtJ3K9vemfT9DggUA5Ov1b8b2/zJRV9TmtqWqoNCE6WoB45Q+f3/7x2BiFGc414Mv2akqt+t/c5JgDvx4LDTgr3pRrG/7qOI/eJkPlKvgyzoJ6wWPfD70ePTf0zvTTMiEiOPwTVkE/Nayg16ghVhzTSNWpVE8cc+k2mtxE2Ln86YCFSgku++1npPiiNkGVrRc/9QUwoLOgCL3cPNR1/DJkqc2rVM7Wz75EqrRky6Sw+0YTbB38+M4GoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPrE16HyJfyTGkyDchmZus+YzDNBhVyxLDSXdh1TC3s=;
 b=pVDxEGcwFvj1qBBMnTwbFtZsR8aLZmUbhY5pUlvY4QQbW1asNJ3/jLh1lK7q840bLA4AdT4wckNKjNfzWbodhSWbTRoOp3A0XkQDVlSQYZhu4dC3gTMR8LKRbGjVIwHk8je/uW4PBj8zGyinOiT76CCARArThBVvwUc8dmDM9m4=
Received: from CH0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:610:74::8)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.36; Thu, 27 Jun
 2024 22:46:51 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::b5) by CH0PR04CA0063.outlook.office365.com
 (2603:10b6:610:74::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 22:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 22:46:51 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 17:46:47 -0500
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH 1/5] cxl/hdm: Moving HDM specific code to core/hdm.c.
Date: Fri, 28 Jun 2024 00:46:10 +0200
Message-ID: <20240627224615.854162-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240627224615.854162-1-rrichter@amd.com>
References: <20240627224615.854162-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 4032ff15-8960-4feb-dc6f-08dc96fb08fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tc6XYdmDOhdoz7xnEwYgigFPdp7tfZBbZ1yZf/Yc+Z93BDCBg4OnatMs7t1q?=
 =?us-ascii?Q?s+LLP1dhCD/AtlPxh/UdW5/rWU3DZ+Y889IsbglrDctoi4Wt6DfCDGs6PtBR?=
 =?us-ascii?Q?8zTDpTFZdqchRhJW7556TMzOmIbKM3qPNpKjtAf7y8BcQiQ0mxInjihkJJR+?=
 =?us-ascii?Q?UjgxImzk+Sh3Chcdzh9EZolvq7ZbQbmJs9wdKeH21akfBpLqNwayM46V8zlC?=
 =?us-ascii?Q?2Uqn4FPi+XA3yx3sqsqb8cGJj4QG4bSv0XJDQQ7HIvoSKHZIYiId1hc8VKpg?=
 =?us-ascii?Q?WeWE0QL9JXs9AdXrQARJ2C0sR/Kf6R0QNDfSQGq583emnRfvN+AMrbJZz+Kc?=
 =?us-ascii?Q?ubnPFRMDs+30obkl7tlNpts30YK+x0JvQMnXh4OuB1yoZK8jyMo9cNKP0o66?=
 =?us-ascii?Q?cZJzkELwLY453yee6lyTxN/EKbvTLiO+RCMCs/PZHhOt3vltt2mavyZ6SVjm?=
 =?us-ascii?Q?FtO0AUe9jr8b+zzKUyajt+3v7X689RmPwpdX93EwvdUZij7JShgak6D1uddG?=
 =?us-ascii?Q?w2QcQ8NkRs9bNHTc/Aj56xS1E3BDmxe+/txyACVsWkCg1eStwTN/XBPda+Hn?=
 =?us-ascii?Q?VeMyj7hM3eUQE/aCdKGQMP6Ce+TPgUGcm5mVCzG+VWfRSTiSqsWqJCvoneT5?=
 =?us-ascii?Q?pJuHfjk9blOBVUyISuWynZeWIUNyLNmD7RVztq79CQpGgqeQRoaJiR5FElV7?=
 =?us-ascii?Q?iBjvrTiKO2j417qYttD5TDdMeR9xy/wBM6g3m+l5Wf889rSgb5JazDaHIp3s?=
 =?us-ascii?Q?sICs6/0ljRtqcirDWVMxMraDlixEA2fhdrJhjt9k9f6hTEklNdBbr1Dse4/i?=
 =?us-ascii?Q?dxnKS2hNZgASZPRhT5MeggWrnMXDOv3LOgFYemoTwd02tm2ovd6G37APeFIr?=
 =?us-ascii?Q?tJDwixpwi0//wJmMzMJLYQdTTJoXJs2/ukYnCR/sr5MqvaeeG79Ud5whbOiI?=
 =?us-ascii?Q?QnCfG9ofuhQzruoL5iScX92S8YPCB10qI4lpjreiVJGiB17lkt3JDELHX4Jy?=
 =?us-ascii?Q?HsDK+hYDKQhrlwaleiw7tzefpQmbzWKqAfPEB4RlqpAHBA4q68IX3O6Nuywi?=
 =?us-ascii?Q?Cj7BeeWqAlZ4Pza1xPL8QAscJ55bLFLTezmAIfuvlXgxDcFTCp1pw0MPEl5P?=
 =?us-ascii?Q?IAdOM5JcLCdM45f3HJgkQO/QV8XYm64ZYbXHbFKR10UFtPy8af1YcK6ydOGt?=
 =?us-ascii?Q?8K3596qzLLbmrR6pnsrjYgdObPoGPg1ypgFtw8FS7UaA5AGfg1yXYeqPmT5t?=
 =?us-ascii?Q?IMWLkbV8wY50Vlony3Bozfz1Oy15fAZFVzLM1yDVYv40BPbC8o/rqPOKeMCw?=
 =?us-ascii?Q?lnMyzCSlutvHjtU8OMT1ytle1a51hAVf2k97c1cA+cqTM1NlMJ/FxAVWtYnK?=
 =?us-ascii?Q?jtt/jJU52KKMDPq9jCVvV0nrWc9CoahRJyb5T/Esd5pfzoHEGjR312iwqzIj?=
 =?us-ascii?Q?q3CQliq91BZ47POTYuzXP33qbThrmzYJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:46:51.0799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4032ff15-8960-4feb-dc6f-08dc96fb08fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

Code to handle HDM specifics is implemented in core/pci.c and
core/hdm.c. In both files helper functions will be needed for address
translation. To simplify the introduction of static helper functions,
move all HDM code to core/hdm.c.

The function devm_cxl_enable_mem() is no longer static and is shared
now within the core module. No functional changes otherwise.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/core.h |   2 +
 drivers/cxl/core/hdm.c  | 117 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/pci.c  | 119 +---------------------------------------
 drivers/cxl/cxlmem.h    |   3 +
 drivers/cxl/cxlpci.h    |   3 -
 5 files changed, 123 insertions(+), 121 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 625394486459..d8c3c27ce100 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -70,6 +70,8 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
+struct cxl_dev_state;
+int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds);
 
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 784843fa2a22..605da9a55d89 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1027,3 +1027,120 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);
+
+/* require dvsec ranges to be covered by a locked platform window */
+static int dvsec_range_allowed(struct device *dev, void *arg)
+{
+	struct range *dev_range = arg;
+	struct cxl_decoder *cxld;
+
+	if (!is_root_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+
+	if (!(cxld->flags & CXL_DECODER_F_RAM))
+		return 0;
+
+	return range_contains(&cxld->hpa_range, dev_range);
+}
+
+static void disable_hdm(void *_cxlhdm)
+{
+	u32 global_ctrl;
+	struct cxl_hdm *cxlhdm = _cxlhdm;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
+	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+}
+
+static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	u32 global_ctrl;
+
+	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
+	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
+}
+
+/**
+ * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
+ * @cxlds: Device state
+ * @cxlhdm: Mapped HDM decoder Capability
+ * @info: Cached DVSEC range registers info
+ *
+ * Try to enable the endpoint's HDM Decoder Capability
+ */
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
+			struct cxl_endpoint_dvsec_info *info)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_port *port = cxlhdm->port;
+	struct device *dev = cxlds->dev;
+	struct cxl_port *root;
+	int i, rc, allowed;
+	u32 global_ctrl = 0;
+
+	if (hdm)
+		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	/*
+	 * If the HDM Decoder Capability is already enabled then assume
+	 * that some other agent like platform firmware set it up.
+	 */
+	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
+		return devm_cxl_enable_mem(&port->dev, cxlds);
+	else if (!hdm)
+		return -ENODEV;
+
+	root = to_cxl_port(port->dev.parent);
+	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
+		root = to_cxl_port(root->dev.parent);
+	if (!is_cxl_root(root)) {
+		dev_err(dev, "Failed to acquire root port for HDM enable\n");
+		return -ENODEV;
+	}
+
+	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
+		struct device *cxld_dev;
+
+		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
+					     dvsec_range_allowed);
+		if (!cxld_dev) {
+			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
+			continue;
+		}
+		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
+		put_device(cxld_dev);
+		allowed++;
+	}
+
+	if (!allowed && info->mem_enabled) {
+		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
+	 * [High,Low] when HDM operation is enabled the range register values
+	 * are ignored by the device, but the spec also recommends matching the
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
+	 * are expected even though Linux does not require or maintain that
+	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
+	 * Decoder Capability Enable.
+	 */
+	if (info->mem_enabled)
+		return 0;
+
+	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+	if (rc)
+		return rc;
+
+	return devm_cxl_enable_mem(&port->dev, cxlds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8567dd11eaac..4f67e3ae7a05 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -270,7 +270,7 @@ static void clear_mem_enable(void *cxlds)
 	cxl_set_mem_enable(cxlds, 0);
 }
 
-static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
+int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 {
 	int rc;
 
@@ -282,46 +282,6 @@ static int devm_cxl_enable_mem(struct device *host, struct cxl_dev_state *cxlds)
 	return devm_add_action_or_reset(host, clear_mem_enable, cxlds);
 }
 
-/* require dvsec ranges to be covered by a locked platform window */
-static int dvsec_range_allowed(struct device *dev, void *arg)
-{
-	struct range *dev_range = arg;
-	struct cxl_decoder *cxld;
-
-	if (!is_root_decoder(dev))
-		return 0;
-
-	cxld = to_cxl_decoder(dev);
-
-	if (!(cxld->flags & CXL_DECODER_F_RAM))
-		return 0;
-
-	return range_contains(&cxld->hpa_range, dev_range);
-}
-
-static void disable_hdm(void *_cxlhdm)
-{
-	u32 global_ctrl;
-	struct cxl_hdm *cxlhdm = _cxlhdm;
-	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-
-	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-	writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
-	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-}
-
-static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
-{
-	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	u32 global_ctrl;
-
-	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
-	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-
-	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
-}
-
 int cxl_dvsec_rr_decode(struct device *dev, int d,
 			struct cxl_endpoint_dvsec_info *info)
 {
@@ -425,83 +385,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
 
-/**
- * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
- * @cxlds: Device state
- * @cxlhdm: Mapped HDM decoder Capability
- * @info: Cached DVSEC range registers info
- *
- * Try to enable the endpoint's HDM Decoder Capability
- */
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
-			struct cxl_endpoint_dvsec_info *info)
-{
-	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	struct cxl_port *port = cxlhdm->port;
-	struct device *dev = cxlds->dev;
-	struct cxl_port *root;
-	int i, rc, allowed;
-	u32 global_ctrl = 0;
-
-	if (hdm)
-		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-
-	/*
-	 * If the HDM Decoder Capability is already enabled then assume
-	 * that some other agent like platform firmware set it up.
-	 */
-	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
-		return devm_cxl_enable_mem(&port->dev, cxlds);
-	else if (!hdm)
-		return -ENODEV;
-
-	root = to_cxl_port(port->dev.parent);
-	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
-		root = to_cxl_port(root->dev.parent);
-	if (!is_cxl_root(root)) {
-		dev_err(dev, "Failed to acquire root port for HDM enable\n");
-		return -ENODEV;
-	}
-
-	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
-		struct device *cxld_dev;
-
-		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
-					     dvsec_range_allowed);
-		if (!cxld_dev) {
-			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
-			continue;
-		}
-		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
-		put_device(cxld_dev);
-		allowed++;
-	}
-
-	if (!allowed && info->mem_enabled) {
-		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
-		return -ENXIO;
-	}
-
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
-	 */
-	if (info->mem_enabled)
-		return 0;
-
-	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
-	if (rc)
-		return rc;
-
-	return devm_cxl_enable_mem(&port->dev, cxlds);
-}
-EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
-
 #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
 #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
 #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 19aba81cdf13..61d9f4e00921 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -862,4 +862,7 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
+			struct cxl_endpoint_dvsec_info *info);
+
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 4da07727ab9c..fe01793af1cb 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -122,9 +122,6 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 }
 
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
-struct cxl_dev_state;
-int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
-			struct cxl_endpoint_dvsec_info *info);
 void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-- 
2.39.2

