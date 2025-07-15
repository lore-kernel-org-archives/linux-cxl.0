Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E725F2C033C;
	Tue, 15 Jul 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606752; cv=fail; b=XApdKBweRLRPc1UOX8speDpYDrMhwm/AFAzZUkqgyWxSGQtdxBqbbUhUJFgLq1faOQezjRrnNN99xftA9yBJd33SOij/gN9RaITQP01XydMI38u4RUplRn6dYmaITUoMa34Q3/K/QfdH+56PlvfatIlczFA+CLUSLf7OX9hWPko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606752; c=relaxed/simple;
	bh=KnSDYoRsx/kYW84iZ+pr87WT0nABJmWv1udbmEw3zfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnON8+wHSvbpi3nomiMDPdWGWQ/Adt7ok0NUzsQMFny4YDUd+5KIbtYntbdJzK8yv3b1W5SWo38dn54BAaW91LW/D+15cXJhTSFsjypsuL7lzFkogBiRfCosRG/RX1ufiWru4kyI6gSwUvyjw/LiwT6LdykpX/i+CbLzx1fVqZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5dKwcXkT; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5dKwcXkT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idm0IkzfYKA9TV7p9ZXN/NlJ2IxLBe/CG2NF6A/sVVRjejAXctb7IVOy7dXRPmP9u7fZI8OdEyaay/buB7AHXXWxbRna70T5Mg0OkDiuTQXeV6Wbj+wtJRCWh9emFqYmRB4u89OuP9Q6IrqJyxfYvIMxEEMLLE3eUEA32Jrg6MSBBPpglRow8Vj+pykkAEZPx7Np7XtThUEbOXYaNg+IiHrhCGfIy8cHwEn+r+Rkx+rHR6LfVWWPFjT/jqgZAARXyG9p4qljjn0vvfT6SUdI+VfTdXXFnIiFnTNpN45voNuKTPYhrB0CAvaruBw2FkSrbXw8+OYruaCDF3/EC9OYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8qHLuVPCC0yF2XZxAr/H7oKMAeY7Acs70I9Os36jfA=;
 b=CVVRIztdPbyyOFxV3EDfsING4Vm0fhVaxF4WYEyDDo5I44JPep7lIyKBKqxYkIgTrWRYqzuIidB5ZyttiEU5wN4arz1YDk8yjAYXbaJOB5RrH3NQa/kuSFNLi1zFB04YQOdKIWNCdg//oOk+2hsT8BX8fMhT43pJTZqLqqeXEg0aeIp8mn1NUrWneO7cLY+GjR3QVtDsBhB/fHcAbJzyDupyGvzFLAQK2Ut3+siHHkMSynTZZ3CTEr7vhp9yATpePMU1m/H960emdGC1m+YPAQA5BCl3pPjpZLqanNPOvYehZtROqchn01YnW6yGcT9jrdU2Y6/W2lMyvzpDvfNQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8qHLuVPCC0yF2XZxAr/H7oKMAeY7Acs70I9Os36jfA=;
 b=5dKwcXkTs8BTIHMPZNfzigRbv21XTFWSmPdRxf1LlPXxfuQ/1IFIw8Zdqs2kcfDqpDJv+TzQXmjpA62uZ51tiyC6yOuuM7urkGvtUpO559922o7GDauFD9ORSExtyIgmKyNHDel/HVVxDbLR42lQxqpP1FecstJgjLIqgcWHeZ0=
Received: from BN9PR03CA0323.namprd03.prod.outlook.com (2603:10b6:408:112::28)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 19:12:28 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::44) by BN9PR03CA0323.outlook.office365.com
 (2603:10b6:408:112::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Tue,
 15 Jul 2025 19:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 19:12:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 14:12:24 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 04/20] cxl/region: Add region registration code to new function register_region()
Date: Tue, 15 Jul 2025 21:11:27 +0200
Message-ID: <20250715191143.1023512-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715191143.1023512-1-rrichter@amd.com>
References: <20250715191143.1023512-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b4de4f-ecda-4920-b898-08ddc3d38a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pm4IXbmCzMtpOBLrPf5RqTmxnIrPoA2pvujh43MAcDXPFTECxG9td1CR5SCt?=
 =?us-ascii?Q?BmhqDsQd0sM6IKamNokkzf3x1wfsnnfyRXKZW8enoxBKowWHRmcEQD2zp1gR?=
 =?us-ascii?Q?mNAUEdb0G8TWTOuEmdSH+bvvAWWrxULOx67bdT1ewCLjKi4IkVixW1qe51Wl?=
 =?us-ascii?Q?82h6omQAPytWkUZg8cti58Tx3/z1nesgZMhwH645U8DWrBF+L0ppfzl1PU0s?=
 =?us-ascii?Q?ICSiaNYiOvvQ/OIU5JREiej3V8BtnMMQo2Lj04lgU36ZXvs2AOrY435PwpTu?=
 =?us-ascii?Q?EURHGutu4BL1XjZkfUZpYi9xQy5Jm/WOEV9DrY8pDmOG72U6etiXvkdBa+UJ?=
 =?us-ascii?Q?89D/emrWb1nIwOdakOZjBoSw8SXfewbIiwYquf9DtSj7hqoIk3wVe+37Dlv9?=
 =?us-ascii?Q?Cj+B49UCg7VlTXx25nckXOMK5KYwnaE6eHdYFWrD4Q+Puc/HciqW3qkj4hCV?=
 =?us-ascii?Q?MkVmE6BnSn5VFhG9tAZt25UgKsNAw2AjS3/n75eKvsGuHXjiWH1MAHicHOBX?=
 =?us-ascii?Q?RMOZELVyHujsoYvjmhvhxkCMDkQoH6wL1Dgrl+mey5S7jdECpVr9sGJB+ZNI?=
 =?us-ascii?Q?+8Q+PY87U/qY9qv/slyEjA3X5CBJf6EDJCXWFtDiQHu/eoNwNJq8C5xw+DCS?=
 =?us-ascii?Q?jqQ9CJcbbvMlef9MdHi4D0DQWf9l1XAM+WO3k9tb44g2H3zA/pD8fDt101vY?=
 =?us-ascii?Q?LPIEqe3qFTzlvuRjBD1COvSsi2FNquUhhEpBOYi1vHRuvwAYhLK25ZRVUqvu?=
 =?us-ascii?Q?M2mlrdWIAPkMCa8EfkiaBbY/66QxQmTZpysFtmne8bCdFpT6i65sGcmVAE/E?=
 =?us-ascii?Q?j3+6ANB0AACtszX1P5sQQb94AXauQMWHnCLdnycqAxwkecsVA4iElmvcbj6F?=
 =?us-ascii?Q?An/ygpTAn0/uXt97A0SFInmZ+f3i2GXN79ORJUyMRYPqVOA/BD5e7e010zHR?=
 =?us-ascii?Q?B0mLnHiCB7Vt0iNdZvkyt0IoonBWL2Y6QzyHZOKeO+7gSqtexcDESW1V2VdU?=
 =?us-ascii?Q?ijH9sB0rh0dNay63BAVd7ipLRWR3M4yBVO5cBvVOMNHJojXggDb6gJ4I/K1O?=
 =?us-ascii?Q?tckdLyDhni8iRnHBC+NOxHBDMTeYm+ekx0yw/5UlRLmrjnM+wP/zAyiswTU9?=
 =?us-ascii?Q?vMdZWXKtw9FgwoNQrDdvkjPT8B+WGV7A60vfAKk5xZKp0F5lXlAijMD1Nym+?=
 =?us-ascii?Q?tKg9ccZSSfEkCz+xQu/vzN+sfVkxhwG25kg7EQoGEo8fUhd59m2bNn0upXfv?=
 =?us-ascii?Q?YuS6EDor8lDktmRrquyNmvXVerx+d9YDmS/QKbCYHoxyxTTOwO0X+NyoRgic?=
 =?us-ascii?Q?oQiD3z4OyJS5snDu1Ix6FnvbL8jRYL5dKbX1Q1B7TP+r8VGw5SVVKFQR2Nb2?=
 =?us-ascii?Q?CLGLdxcjNbpyJ7LRIQELHkUkK3NvxzxO2No4vK5hrIFsob62JNFhjGTbRJDr?=
 =?us-ascii?Q?pKIu39eOJDtLyupmNVeCywDiz2drvEXNssfkc0zf3mjAZvcW8GZz8+x/fxYj?=
 =?us-ascii?Q?oF0+rsD9xpbI5QkCJCt7j/5PqgGf+oxZV/tq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 19:12:27.8279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b4de4f-ecda-4920-b898-08ddc3d38a16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582

Separate code to register a region from its creation. This splits the
region setup into a creation and registration part. This helps
grouping the code, adds a counterpart to unregister_region() and esp.
simplifies the error handling paths as there is a single exit for a
put_device() on errors.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 66 +++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b968050ad3d7..8e2521c6c845 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2326,6 +2326,9 @@ static void cxl_region_release(struct device *dev)
 	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
 	int id = atomic_read(&cxlrd->region_id);
 
+	if (cxlr->id < 0)
+		goto out;
+
 	/*
 	 * Try to reuse the recently idled id rather than the cached
 	 * next id to prevent the region id space from increasing
@@ -2468,6 +2471,7 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd)
 	 */
 	get_device(dev->parent);
 	cxlr->cxlrd = cxlrd;
+	cxlr->id = -1;
 
 	device_set_pm_not_required(dev);
 	dev->bus = &cxl_bus_type;
@@ -2496,6 +2500,30 @@ static void unregister_region(void *_cxlr)
 	put_device(&cxlr->dev);
 }
 
+static int register_region(struct cxl_region *cxlr, int id)
+{
+	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
+	struct device *dev = &cxlr->dev;
+	int rc;
+
+	rc = memregion_alloc(GFP_KERNEL);
+	if (rc < 0)
+		return rc;
+
+	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
+		memregion_free(rc);
+		return -EBUSY;
+	}
+
+	cxlr->id = id;
+
+	rc = dev_set_name(dev, "region%d", cxlr->id);
+	if (rc)
+		return rc;
+
+	return device_add(dev);
+}
+
 /**
  * devm_cxl_add_region - Adds a region to a decoder
  * @cxlrd: root decoder
@@ -2516,40 +2544,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 {
 	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
 	struct cxl_region *cxlr;
-	struct device *dev;
 	int rc;
 
 	cxlr = cxl_region_alloc(cxlrd);
-	if (IS_ERR(cxlr)) {
-		memregion_free(id);
+	if (IS_ERR(cxlr))
 		return cxlr;
-	}
 
 	cxlr->mode = mode;
 	cxlr->type = type;
 
-	dev = &cxlr->dev;
-	cxlr->id = id;
-
-	rc = dev_set_name(dev, "region%d", id);
-	if (rc)
-		goto err;
-
-	rc = device_add(dev);
-	if (rc)
-		goto err;
+	rc = register_region(cxlr, id);
+	if (rc) {
+		put_device(&cxlr->dev);
+		return ERR_PTR(rc);
+	}
 
 	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
 	if (rc)
 		return ERR_PTR(rc);
 
 	dev_dbg(port->uport_dev, "%s: created %s\n",
-		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
-	return cxlr;
+		dev_name(cxlr->dev.parent), dev_name(&cxlr->dev));
 
-err:
-	put_device(dev);
-	return ERR_PTR(rc);
+	return cxlr;
 }
 
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
@@ -2572,8 +2589,6 @@ static ssize_t create_ram_region_show(struct device *dev,
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 					  enum cxl_partition_mode mode, int id)
 {
-	int rc;
-
 	switch (mode) {
 	case CXL_PARTMODE_RAM:
 	case CXL_PARTMODE_PMEM:
@@ -2583,15 +2598,6 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EINVAL);
 	}
 
-	rc = memregion_alloc(GFP_KERNEL);
-	if (rc < 0)
-		return ERR_PTR(rc);
-
-	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
-		memregion_free(rc);
-		return ERR_PTR(-EBUSY);
-	}
-
 	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
 }
 
-- 
2.39.5

