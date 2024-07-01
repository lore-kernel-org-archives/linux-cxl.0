Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6A16EC11;
	Mon,  1 Jul 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856114; cv=fail; b=rTev4L+/dwOz8epRnOljTiJ675ZVXGajeE0D37vZIHpNhMF3DdYdGhc8DPtyV5rzKHjmzUEuAGsmFKlZ6VUJ922okIlQKlPVnuQ1EkWctnQfACdrWiTyle8GpqJ982kQhIxMIvq4AA2APSRcoV6DdEbqnhkZ+BuoaNvoEudB8CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856114; c=relaxed/simple;
	bh=kfBgx1cN9MGxCeqW04wWSTxZ31ki+m1SrHTU6OvWjJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoE9xfaOxy8uCNrDmvjcZToF6PT09IIyKjgZP5/OSxLE1oJIWyud1zhjDlJrjNHj9g1nQ2Q1LXFmKHnG2Silkwnri2YZjxIdLVTqp3o/wUby6ifqepF6X11kYqfH6KU5TiMv1nwcwVLDPd5u+q7h//6uSAcRnBiz474haXeZ8IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aGl39xsk; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aGl39xsk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvQRhJ4kx9lXA8oEZxauHoJVU51iMgjjk08tclh2H6Sn41mnQaUMuaQXrpv+IRZerjcQu18WVJHe8rrdarzgx1CjNiBokbikx8la7v94Tpmw9fdx74wWiLnIoOhiQryZWGUfmOlW2B/qrO6ru6hdMZxcFJ75gGpVZXjO8c1G2UXb9CEJkHPQI08/hzpBRREv0bVaxyLU/t76kOqx3IBHS31XtZzVyoK401k4751dvNPIyJn8zfEr6LJ6KFA7laODIOAYKZ+bU0bNMOUDR7T3T40Yts6o+u+SLxz5t++r4O7zNuDvFYN5EmRw9Tp8D9S600kfjFMWc3eHbU9VkFozmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjP5YshW8yxPb5hSTf2Cu12fdT4c3VRWLRHit/0vJJA=;
 b=hnTdNyUSxrJzGv+L4kOhD2d0Wb0lbO1aNHA0AB1+B3KLOS9wHO0yeX+fWLBPAg2KX4BpJssCtZ/iTf2vX040C+1zhlfoVmPt7Kp3cgPVXakvwbxsRIPMP3MH12myJSwHAhiE614j4s6qiKw6WFexvjkRjGTjjCRZ4zGwq9KxcyBBYTfYzmA2Mw/QCGf67TS17wBs3oXi8GDtqEKH3hNsOKvNiKg7bDwp96X7Q74mVORCLHgRuBdtBTKaXBtqRQ5gECNKTmg88Z9w/Vi/XXYdVXYPPmLGQ2oOrxUFhzUVLkCZpS9vMC/Mgz5qEk3Lo5QJ+odZJgS94tOAqZ4NnNj3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjP5YshW8yxPb5hSTf2Cu12fdT4c3VRWLRHit/0vJJA=;
 b=aGl39xskrQYOQ+Vz79IsYvXUlY1Y/Yjs2MUzq8RsEFauqVlGH+6kLAknQkDlcXQgi+1rdu5Es2t8hMBu2UfdmCRy21N5Tzel8D1g9+5KUWymYAfyYvw/FuSe9fdetL9Nb0Olk5lcliTPzzlqq2IDv/YLeXl6Dtandzz40W542sY=
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 1 Jul
 2024 17:48:25 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::fb) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 17:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 17:48:24 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 12:48:22 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH v2 2/5] cxl/hdm: Implement address translation for HDM decoding
Date: Mon, 1 Jul 2024 19:47:50 +0200
Message-ID: <20240701174754.967954-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: cc62cb5b-1305-4437-5698-08dc99f601b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pC6eQmyj4yC4nNK00U2DZal2kg9MxEoZtOE8WxBFqFl+ZIbEQcva44ey5pfC?=
 =?us-ascii?Q?W51Yg6TQwu//88GSsOgG2vy/ASwAsXFRqFsr50p+mVgoiEKqVJXanYrU7Kos?=
 =?us-ascii?Q?b16iNoKPISOliiAv94sDOf2HHKWJJocTapKrA3ylJnZoIjftWf5pbXWDstU9?=
 =?us-ascii?Q?VjlqK5+GfaL5hdC/ULsqBQjWRYfyA7JahXbXQNQsnYecNDYLinlWfoyt/cBg?=
 =?us-ascii?Q?GDaQo0fAWc6xqHDI33kF6AglSL0THcy166QoSDAxxe3a/TV3PlWgsvv6f1T4?=
 =?us-ascii?Q?Ao7f77nxWnAyLDGhU8n4rBq79tFg+c2xORMLy4eO3UAchP5i5xU/JyIpSZKG?=
 =?us-ascii?Q?7KqQTZDWZ1Rcr+nvSHPvy7ycMPTW5Gs0YLQ5oOTU/5MQbOPpSCAfgKrGm3bJ?=
 =?us-ascii?Q?+8e8bVnmwwhL4kpvIA8VIHIGscImAvOCxXN3KrE63u2+7GeclmTMsJFB/3/L?=
 =?us-ascii?Q?JHeE2IlbCZpsGt4hEVWXcfUpgBjYf41GveFuXhdcnjiIQ/QVvuLJONNRudon?=
 =?us-ascii?Q?9ZfLO8Wr0bhNFvGsI0MVd76bTcuMMXvmayjBehRUrrqsqqQCBHYc62oUL1mc?=
 =?us-ascii?Q?S2vYW9C2Q4DxJxe1SGxPFVfmtscGuZujjPuccpOPeq6ka4KwWd7w4e1sYIoB?=
 =?us-ascii?Q?ayIRZ4OayqhItgvPhIf0+5q7gFOMHAbMU7HKiEQOsCPgEOM40NgvbyZ1wZ+U?=
 =?us-ascii?Q?PMADPpTee3FPfMe5aoeCqVqWPD2eNUgkZXkzHbjAprOI7Y9wRhGqlIKRcIk/?=
 =?us-ascii?Q?uTqMNwNSxnz7/U/26jAbkE7gxGstkQu1Sw5KBPIdkHZ1c9qbxcad9iPYens8?=
 =?us-ascii?Q?keXhIWlJ01alX4eu8PuONyPLxztbRZ8a82tUw8B8FBpNbJhZiVPiaOw/NC7A?=
 =?us-ascii?Q?TRLYWxY2SyOdW5Czok1S2mlSrySSxFJjHh5VMb6VPNMk/+xo/y2r4r2lgVXc?=
 =?us-ascii?Q?orxrjEerpqPQR7HKZ2ZfKxwefEGNnHsxcXIkwXk2svJcXY4e2s68qEHhkPsn?=
 =?us-ascii?Q?n+AiOstOblDja7/HESDvO+16iwvsgqLcaGOECgYb5inzaT64X+X8voP3uUpv?=
 =?us-ascii?Q?izmxa00BJdTHuw8mjYvPcFvKMUrkn752GGCFsPLHjCEu4GPE70EGJlDLKc7l?=
 =?us-ascii?Q?mlSOd3ZYZWyuo5pcF+5U+j80D9BOARaWJ3LqMOosD0Pgsgxo0HHPOH7qs50t?=
 =?us-ascii?Q?sbuO6DlaBQ0+1g7HK2oBKWv5e794MqMvD9KO3MMDCY422yJjefoqucaWF8aW?=
 =?us-ascii?Q?ilPT7HcNaTM/kkF9NIr9Ya0pk/kcf9qkxQ1POWHiEZYij4Y+rf+0R0Sw1TpP?=
 =?us-ascii?Q?T/ZSbh8TjK8q4P3LZu6pBlS6dqx5gbS+sfrjG1Bq72Z4aegoReqTCGmRp0hv?=
 =?us-ascii?Q?JLWid4wHynltk3+o0ZKHy8u/Eo/StrEr6HdtRbevQC+14Y2KgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 17:48:24.8783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc62cb5b-1305-4437-5698-08dc99f601b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

Default expectation of Linux is that HPA == SPA, which means that
hardware addresses in the decoders are the same as the kernel sees
them. However, there are platforms where this is not the case and an
address translation between decoder's (HPA) and the system's physical
addresses (SPA) is needed.

The CXL driver stores all internal hardware address ranges as SPA.
When accessing the HDM decoder's registers, hardware addresses must be
translated back and forth. This is needed for the base addresses in
the CXL Range Registers of the PCIe DVSEC for CXL Devices
(CXL_DVSEC_RANGE_BASE*) or the CXL HDM Decoder Capability Structure
(CXL_HDM_DECODER0_BASE*).

To handle address translation the kernel needs to keep track of the
system's base HPA the decoder bases on. The base can be different
between memory domains, each port may have its own domain. Thus, the
HPA base cannot be shared between CXL ports and its decoders, instead
the base HPA must be stored per port. Each port has its own struct
cxl_hdm to handle the sets of decoders and targets, that struct can
also be used for storing the base.

Add @base_hpa to struct cxl_hdm. Also Introduce helper functions for
the translation and use them to convert the HDM decoder base addresses
to or from an SPA.

While at this, rename len to size for the common base/size naming used
with ranges.

Link: https://lore.kernel.org/all/65c6b8c9a42e4_d2d4294f1@dwillia2-xfh.jf.intel.com.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/hdm.c | 69 ++++++++++++++++++++++++++++++++++--------
 drivers/cxl/cxlmem.h   |  1 +
 2 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 605da9a55d89..50078013f4e3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -125,6 +125,17 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	return true;
 }
 
+static void setup_base_hpa(struct cxl_hdm *cxlhdm)
+{
+	/*
+	 * Address translation is not needed on platforms with HPA ==
+	 * SPA. HDM decoder addresses all base on system addresses,
+	 * there is no offset and the base is zero (cxlhdm->base_hpa
+	 * == 0). Nothing to do here as it is already pre-initialized
+	 * zero.
+	 */
+}
+
 /**
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
@@ -144,6 +155,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	dev_set_drvdata(dev, cxlhdm);
 
+	setup_base_hpa(cxlhdm);
+
 	/* Memory devices can configure device HDM using DVSEC range regs. */
 	if (reg_map->resource == CXL_RESOURCE_NONE) {
 		if (!info || !info->mem_enabled) {
@@ -611,6 +624,23 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
+/*
+ * Default expectation is that decoder base addresses match
+ * HPA resource values (that is cxlhdm->base_hpa == 0).
+ */
+
+static inline resource_size_t cxl_xlat_to_hpa(resource_size_t base,
+					      struct cxl_hdm *cxlhdm)
+{
+	return cxlhdm->base_hpa + base;
+}
+
+static inline resource_size_t cxl_xlat_to_base(resource_size_t hpa,
+					       struct cxl_hdm *cxlhdm)
+{
+	return hpa - cxlhdm->base_hpa;
+}
+
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -655,7 +685,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
 	cxld_set_interleave(cxld, &ctrl);
 	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
+	base = cxl_xlat_to_base(cxld->hpa_range.start, cxlhdm);
 	size = range_len(&cxld->hpa_range);
 
 	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
@@ -746,22 +776,27 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
 	int which, struct cxl_endpoint_dvsec_info *info)
 {
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	struct cxl_endpoint_decoder *cxled;
-	u64 len;
+	u64 base, size;
 	int rc;
 
 	if (!is_cxl_endpoint(port))
 		return -EOPNOTSUPP;
 
 	cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	len = range_len(&info->dvsec_range[which]);
-	if (!len)
+	size = range_len(&info->dvsec_range[which]);
+	if (!size)
 		return -ENOENT;
+	base = cxl_xlat_to_hpa(info->dvsec_range[which].start, cxlhdm);
 
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->commit = NULL;
 	cxld->reset = NULL;
-	cxld->hpa_range = info->dvsec_range[which];
+	cxld->hpa_range = (struct range) {
+		.start = base,
+		.end = base + size -1,
+	};
 
 	/*
 	 * Set the emulated decoder as locked pending additional support to
@@ -770,14 +805,14 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
 	port->commit_end = cxld->id;
 
-	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
+	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, size, 0);
 	if (rc) {
 		dev_err(&port->dev,
 			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
-			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
+			port->id, cxld->id, *dpa_base, *dpa_base + size - 1, rc);
 		return rc;
 	}
-	*dpa_base += len;
+	*dpa_base += size;
 	cxled->state = CXL_DECODER_STATE_AUTO;
 
 	return 0;
@@ -787,6 +822,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size, lo, hi;
 	bool committed;
@@ -823,6 +859,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+	base = cxl_xlat_to_hpa(base, cxlhdm);
+
 	cxld->hpa_range = (struct range) {
 		.start = base,
 		.end = base + size - 1,
@@ -1107,16 +1146,20 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	}
 
 	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
-		struct device *cxld_dev;
-
-		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
-					     dvsec_range_allowed);
+		u64 base = cxl_xlat_to_hpa(info->dvsec_range[i].start, cxlhdm);
+		u64 size = range_len(&info->dvsec_range[i]);
+		struct range hpa_range = {
+			.start = base,
+			.end = base + size -1,
+		};
+		struct device *cxld_dev __free(put_device) =
+			cxld_dev = device_find_child(&root->dev, &hpa_range,
+						     dvsec_range_allowed);
 		if (!cxld_dev) {
 			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
 			continue;
 		}
 		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
-		put_device(cxld_dev);
 		allowed++;
 	}
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 61d9f4e00921..849ea97385c9 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -856,6 +856,7 @@ struct cxl_hdm {
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
+	u64 base_hpa;
 	struct cxl_port *port;
 };
 
-- 
2.39.2

