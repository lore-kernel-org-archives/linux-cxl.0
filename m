Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEC16F0E3;
	Mon,  1 Jul 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856106; cv=fail; b=kYmeJ8sOL8KdgxwVmBRhmMHZVP0lVEU1XBb7BNBuXj2JxiETVOIFnod3x0a5StwrRoEhCe7XeDPI5ng2dapEiay4OasUoK5bAFkrOGjW8aE6tspo62jMh2x8Y+/8XkSLR5eJz3IrM1Ey7Tw7WH6a1Ol4vq3v/aCcf9UN5dV+6XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856106; c=relaxed/simple;
	bh=vxi2BveKx2d72IInQNT4V8klhjcRw+VnsVtOaZTJ/mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJS8uj4bWPjMqOaeMNgsbr3WrVa8D7qrqf7e5y82DwMug6HysS8DNzD3v1l8Pyq4WsfWKrgRIOAgGLQtZEmC8xJjJ7VaIDdF4lHqSELF1k6LK2w9cvm9meitu9Azdq6aUJs0kh1AWu1r8zdD+9A3ufN3VEbKvo7GHoGMNdFWwpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gf7DvPQn; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gf7DvPQn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hcjpj8LuGfB93yIc/x2YZPSFf7LWATyCiYEhiSUTW4hGQLLiIxR9fjaIDteNXlQP9134Biu0De1KY40D5DMlSvwkPAWe8dA9IvRYDVWr1jwC9i/MG8ReTZAE0PcXnciPwIr9RxTnKvSE4aB2PBxoztMT7hcJdNxmDpVfs99FCRpa51NREBfWDui0I+Y9gDmqDsJ1xVkktYuXLwmQoVHsfYptppDS8x/fHT6Drcq/jl3kIfX7zDSDmcESITkJP5hES67moUs+FgdIyrr31S95I7cZr9YDxwTM/7xnwFIR5BHNzZzrszqJVtwleV5ZVuC4Gt9f676q5E2jgcGdqzmJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPrE16HyJfyTGkyDchmZus+YzDNBhVyxLDSXdh1TC3s=;
 b=HImLsiXGxByYW9m8YWX+dVjPaBdrDCQixJx9bY44NPYTsv7I+/ztEpz/WKvZCBrOj0gjqEhTZEQHLQf7nEV592BDccwID/gJ66uhk42Ah+ZY7srfomjHbUc9zMYuy1xw0jGAtxx/pR+lojE0/UjgtQIGbt6UlbZ8UQ06WTSOlF+uE7mwSkbncAzMTTwYpJJ2za/MCQAnuPWTsuIWbiyK+NoX02ss4xlS3uNwoy0gvuK+F2N8e2HLfhAjJJ6P46DSQ5BIWZUMghkVfv+xeC8j0PMZo1pT2PDTEBhAhyATGcYvkORawuknroKfH02KftKq3KR0VM9i291pNdoED+PBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPrE16HyJfyTGkyDchmZus+YzDNBhVyxLDSXdh1TC3s=;
 b=Gf7DvPQn5VCZMAFCUwH83LNZ+9YzCg8e5vAo8Ro/9bWiJ6ihkU0lUEVSN5jJ6j0I3D/w/FDhSTAAWn32zwG6VX4ZtFhSiA8vrTmAarQgSBMxpEWVIi8IKoX0uS1ag6c5p0ZIPAjzH+355UH+8Gcz2oRnb29XnGTl2RgG/sBhJrg=
Received: from PH7P220CA0144.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::6)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 17:48:21 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::3c) by PH7P220CA0144.outlook.office365.com
 (2603:10b6:510:327::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 17:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 17:48:21 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 12:48:18 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH v2 1/5] cxl/hdm: Moving HDM specific code to core/hdm.c.
Date: Mon, 1 Jul 2024 19:47:49 +0200
Message-ID: <20240701174754.967954-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: af5a58b3-7290-4e25-621f-08dc99f5ff85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/AQRUhq2Dikh4twLWd5Dmwx2zOas57I6I4lIZ1RJ2Bo3fEWzqtQQEcQrhlM?=
 =?us-ascii?Q?4b7mFJXtRJIPzjCrtl1ut7BwkCfKYdGUEWAqjx+WyTF9+BSzB9UVw24va0DX?=
 =?us-ascii?Q?cV/VCjlc1ZlBJVFGgZush3DPNDfG6DiWDEoMkF6Wid1wjnVq1w7yXKXOWgh7?=
 =?us-ascii?Q?3XwyTf+ArNDhosnqGxcSDbfjRwapSWf41cQdUXrkuo6+Rs+g/7fo7fK7vJ3E?=
 =?us-ascii?Q?TA9lBMfM34V/LvkKVIYbBMdydiAykjLB196GtKDFPHKIYVKi6TgzdiwZeMU9?=
 =?us-ascii?Q?mjhsCWqXJN1zf7cRJXBshoWMQ7n1Ji0P5Ak0Is6lcVkOvH3zg/NejgHQQv8P?=
 =?us-ascii?Q?EuBkYi3Vqb/FxoXMbNN8w3kMaGgxZuEWBrgBoy3K2e+CLr/R47C4B5P/kcW3?=
 =?us-ascii?Q?/cAScjSybJ83APQXrdCse/3UVwr4TAUFpIdHjPve7SF8P53EsExPSMM6XKFF?=
 =?us-ascii?Q?DTkY1PXKrPijHZgI11uKhv9JPbtGMSDPwUf0Gb6p3a/K4B9Zzj7g1RKlGkXA?=
 =?us-ascii?Q?n9Xu8BAi7mfsyzqYp9exhBZTVm3uH1Jx2q3o8k5TmugkYvTYItCvBqWYb/yF?=
 =?us-ascii?Q?kGT8UT+3arjENjMHEnWP6O5fkg+ym4Hh4MZ+QPEzPJ+H0/yDGBxdNbQUU303?=
 =?us-ascii?Q?MpoK/k4Wbm6Sjbo4vcq4kqKmc9Ir5Oze5nrN++K7/0u7PSAzoDEiH4VzlX0O?=
 =?us-ascii?Q?ReXBYLrgX9SNan+HvREtDXEPAxRr0s895FxlB5RhKU3PYSc14vYxdv+ZCtNl?=
 =?us-ascii?Q?cmjFa98LLO4hEF3aBlZmDndov8/xK/sQjHUE8legQ2ksSOIEAconCr7byGte?=
 =?us-ascii?Q?agf+fcxD9amBqOi5K/4gsIOH8VKMWQIiWvnnVI5w2/FgADxvYL5FeGhuNuhw?=
 =?us-ascii?Q?3dL7W4I0VzlakUEf12hdNJCNV75GY5YwKVPr6aVKObapmm67TbGQpBTJB8nX?=
 =?us-ascii?Q?Y6Pw454gK9XusxlN61pQ/solWIu3fZTt9zaBT0C/XmwX3P2W37a+XF1j/fH1?=
 =?us-ascii?Q?e3uzAMzE5obUZkckuaTcTsaMMiR9ZDSizd3Q6iBXXjF54b49qFx0RCDFIFw/?=
 =?us-ascii?Q?BQR7hTtFCTFXtFnptOchYdcQIu7lAoyCv9g1bVZurzzmHhlmlpVz0XgqchDy?=
 =?us-ascii?Q?YPic24yQYWvxRXY5e01xSUQewQ/PyIB5phKBo6XsN1trpMSAaQ2p1vexUWZk?=
 =?us-ascii?Q?1ersbc6Xy3laS4wripYi1snHdnPcbM4rx2ZYe5zGlsoVhT9LJz1FIj+rSdWm?=
 =?us-ascii?Q?umuqnzPc1kYu3g1LjwQ6vlTeVb3+y9TcfyUbDhlpXhG9+YhAEgX08b2Y/0Nh?=
 =?us-ascii?Q?tXhuDKy+WjxsS6Zaihrlj5aOGBVG9VTj5MI1253oc+jiB8ibYkXTud9vR1QI?=
 =?us-ascii?Q?rWxQTuDGUoT8+ctjEDlhD7BJEdTHNubeHge8oubJcWwpPUz8bKBG/KV/wZ0z?=
 =?us-ascii?Q?jimlWAOrWaBT6fvxYWPtIn1mC1W0Fxil?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:48:21.1799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af5a58b3-7290-4e25-621f-08dc99f5ff85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575

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

