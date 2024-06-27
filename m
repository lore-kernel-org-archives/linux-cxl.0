Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019419E7CF;
	Thu, 27 Jun 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528421; cv=fail; b=krhnG2gRsHXkUcTBdLy3hDCTDfos8BsmBAMyPiUXs5z5ZWyz75lXplTMVvodsN6yDn+La8ZsxdtWQq+bGcHdLQ64RuSRF6yBIRD+94jenhiaeMgl7ZGqPJswv27o/PTdOJAQctyaLDjMZdAH4ux8b/f+3bQW+q0/FLut/ARs4RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528421; c=relaxed/simple;
	bh=kfBgx1cN9MGxCeqW04wWSTxZ31ki+m1SrHTU6OvWjJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tyw5V1DCPyWEQnCjn7CJf+jlyx14vXeKcVOydK5ivhnbVTIZjvz5W7+vOJjHoxKpzpb4sFqRPKbBxBms80moGq0olEYc0Mgx8UwkMUJvWp4YhedXoFH2XMdyNBZkk3UmVUbjZRX9b9GLRYhOPrpUgPJc6r4+2NOEJJD61zf2xYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2KCbgkf3; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2KCbgkf3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dghg8UU9hjOwP9k/dxSFmEfgJJcMQ5GuexNiGSdIZ+BgPZxTOx4FFNURXENoj2UGINhHGXoYfVheahOOCAIWBpIWFMJQt4m+cmyzirj3N/5lA8mMSAbMxJVWatytWBnrm45MHyqCONkmlbqyTtrfUl2k/vRP+I0nIbmvufxaStOlstulzKY/C1O5i9depXbZVoWr7gi/xuSBeVIu2bMecLqllZGd9rZvZaCvB/BUZuifheXmLgsmdu8JAEK8sgKl12ZaA+G01MZmci8v2bKaHSMCfzrERmTCerYss8uz1Kp86SuZUrvKzAzNtlEN680ROjx+YfkICobt/uHPk+GHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjP5YshW8yxPb5hSTf2Cu12fdT4c3VRWLRHit/0vJJA=;
 b=CH4BNkcvCD0+aGVPkWkuUwvT6+a1NGYj3L/XTOLRwknnI+c/w4O791wvPYJq4LFE5O8C/SxfQk0hdWMd/h3Xz3egTOncB5LN61xlWC/ve2rc9YvNqp3LHvA0oSsY/H66tXxjAsz3DWcxazfMedgn9dgpa5a0AWBJmw1BIdMknvyHNjPZMA5UsusWEHpYWM+cpKlfl3a18SwVB1gH7rfVroThvAyza1RFaE/Mg5+THuW9YUexWkN5iItYD0YnzZ+H9kll58kQSnM93rQjq+u4BZNK87w6meun5o+5chCr0AP540QdZyF0agslfjTTYVagkTaOXEeDYE9lYg9hjrd/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjP5YshW8yxPb5hSTf2Cu12fdT4c3VRWLRHit/0vJJA=;
 b=2KCbgkf3C3M186ruM9trZ6e08gKkFnSuc3R7bw2131kt+DojEylg26L2vPURFqSe0ojwh4wVrSH8XHAho4521Mzgf2QsgTQn4BAVCbYP7QKuPeXV/EWJEPKaAy0vXgDI0koAOIt2wk1kszxnboD/jWrl/npBv5AgVS+cz9OFI1I=
Received: from CH0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:610:e6::11)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Thu, 27 Jun
 2024 22:46:54 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::68) by CH0PR03CA0276.outlook.office365.com
 (2603:10b6:610:e6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 22:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 22:46:54 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 17:46:51 -0500
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, "Robert
 Richter" <rrichter@amd.com>
Subject: [PATCH 2/5] cxl/hdm: Implement address translation for HDM decoding
Date: Fri, 28 Jun 2024 00:46:11 +0200
Message-ID: <20240627224615.854162-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ad03b8-2f01-4eb8-9540-08dc96fb0b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?muqH0WU573FOolY/8qpvDaq+UMx2j8Vl/LFy8DYnw5rvIHHtfIwRi/Z8HPZ5?=
 =?us-ascii?Q?Iyr6svJh46X0O4mkDYrgU3HS5bRYI9dJgijTQt2/uRRvmjABSWCVXAHxB85u?=
 =?us-ascii?Q?nI3HwyZ3rDP41Ge8q06Z5XVF50eHfnYVjN7X32HccbyAiEhLdJLaFh+P3Oiq?=
 =?us-ascii?Q?S3MXO6RIi1d5RoCGc99Yrg026LipIkuSEvrzKFe+emlwSYkA8ARh3bd1oHT8?=
 =?us-ascii?Q?ryi36ou8qm0qlyVX+osorE1qknmp2UdgLrACMK3H8bSHIqWMZzkchV7u8kBr?=
 =?us-ascii?Q?LFROGJqkg9z6d23Hc35KpDHrWlhNzHfXEmBM5TeopfmT2fcx3YLjD50ajBt6?=
 =?us-ascii?Q?Sm5wMUfkavWhYBSpB2P5Mgs4uxebUCJ0ZrgPVTmzwQZVanx4DKmis8ZErsvk?=
 =?us-ascii?Q?M6Ktb6gSP5bxgqTm94cP7zVIHayho80/RB6/QIBzb0J+OJ2MlnzjNeOqw4yF?=
 =?us-ascii?Q?hsmSmvKRz428p7QJBFwl5aOdvjCVD684jdB9SMor61hkNpaPnMFl4lAfNrb9?=
 =?us-ascii?Q?Lp9bit83rss8ZYEUijRf1JL7r/iAC1sSw7FlekdaYS53NwndM+Hg4SGTfwZy?=
 =?us-ascii?Q?ZGKWAjJq/232Y3qLMI6AWehvAf+gIQGGvtyDf9817z6HWyykQqCPhaW6/9en?=
 =?us-ascii?Q?2egGIex6KRUjSTUg87g1ZPQFSv8OKYuKgMV1srGpGPFXHkZXHtXuS8L0IA1/?=
 =?us-ascii?Q?VD8yycAAJRPCppZyDu9X2O/9ANocaKgdR9S1iMyOIOtUb9N7u/jdBVZy1KuE?=
 =?us-ascii?Q?GFGl9+JMSNP3q/Rhsb3qW8BNm4cXekb4IhBTQX9V7iC6jxmTZXwaYxau5Maz?=
 =?us-ascii?Q?ZunJmXptCov8gWFjEXifZw3zLvAO+TbGQYbwaN2zHJCKblaPPOufUphdOD7P?=
 =?us-ascii?Q?5Y1/PCVNqfUIgaltZ7Ien9nV1SfwGYGl5ww1MfDiQ1+GH7Q9Zex3T+GUsrXv?=
 =?us-ascii?Q?SL2K881XbSFVgCXqyvTvbqfE2Puuvi1qXRkCqhYWXsyWqdfv508zF6oxjnyZ?=
 =?us-ascii?Q?eSge/+e1rrhtCcp7ob7Wppi1OR9Bw8/7qq0b851XZ/nf0KPrNJBPHOn13tpM?=
 =?us-ascii?Q?dnzts9utKD6CA0/E7mnc9BEHNjq1p+jmEMR3f5OoMEw+dG/jZPmVf7YaS55v?=
 =?us-ascii?Q?Tlaf6IrH4zUt0nPy2xZq1CoMQ6FpyY0N22PMSFVRiwcqyO79/2bkRU16SPMA?=
 =?us-ascii?Q?FerD6CtxDL6ZcmM8PweWpiN6rwfZRioNPZdkcNu6S8qsAVL5MaoOW/xtxWZ+?=
 =?us-ascii?Q?qbXTPXLg2224mqfG4hkVNki6lC2rh4/FBuouvI4HY+FAxscWzZLvGUUppmlh?=
 =?us-ascii?Q?8IRyujKcmOTFALHA4DXe2MuBKcVwwYdjQKAAcdvgLwkTbRTlr91F7aTq7TU6?=
 =?us-ascii?Q?o02R2cu4vRxdxCM8+LBfkmSkrrWvsfm2W3nJV0bUIn+tj3xxIw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:46:54.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ad03b8-2f01-4eb8-9540-08dc96fb0b20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715

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

