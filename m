Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5927740B0E8
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184843; cv=fail; b=nQYU/3d0lGur8j7Afrs5t4oWYAkiuEwTR9tcNWWrA75Ug5uCQUArqM998vwnZ4UYvw7X1VDmk22fELBtxcgnELpj2d1xqZGQ0J/s/UoI/ggHATrfde0yeejTeQ6Oe38q9DyQrYd3YnNbwdhJytt7iEW5p+CS6fgakZp19LofjuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184843; c=relaxed/simple;
	bh=ku/BlaQkqwiMIbyFaC9f/NoNrhFLynchlrV2kXb7LiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYhZNwz2gVmOAiyUon96a4UbH79A8iSqQhxN3CEv4rKQthUvuaerwCOnxHEr+/H59BbeNAT37eW1cR3Lt8Ves1dTGHmHbHV9NFZJqSUnM9tiGMv4ydWK3hm3N5pyrwbOj+5vwVT7My/6DW4a+oOjB5LuwmgsyK8sXpPBfEkBr0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0pPbhPKO; arc=fail smtp.client-ip=52.101.53.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0pPbhPKO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuADMPLJfi+g5q/xo0cv5XiXMSqdZvhmnZyVPcVf3mfYvV59mLPeEdQQ3AxZQAfEIX4lD8Ubik1jxSrGVB7ABAr+cGJ0vKwz2Sj38cWou7g3Gb2mpixw47umiDSFEdTkiH+WG5oHFP2qw0RIiPLsF+tAN2hr/9zP2qw4+sObCXKOTj98QrWcPoQktoqK5BjU5Ei1Hu33x4hM0weu+wwJWioEL45G2PYxn/s/LTl1f+C9Lff3+hTUzeBjETYN/DNxcyZAIgC4R/vNjWC8ZgIlPJts9lBoIJEowJSJWctpv4R+aDvb4g49Lx1ApG3jF/WUiY0y9RtPPsqmlW1cMuPtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt38QniHSXQQkPoBH8c9SPizaHrvVuQMTdkc9XTxBAs=;
 b=WEc1WwlOemqO+Di0OycXlNrttLgpkWkrC0FVpTlKzTRVGIawYb2HvALm6hML+xlnMl3k4IRdmu3uX+52Rh8U+lBVlYZf/jsPxCWZrv1qnf4C/jGWwPj3B6nJQvD5RjO5zwe8oi4EJ0HqLCS5kRIpukfbDF3MMP45VOhTSQ5LfgeY2/obowMQu/0HhIJ+g77cvNLROXPu4xItJXNOBIISj2tLJgtRXIs+n6NEMkI/RcHGHVUpLisHLB/cV1hhswDBC75P5R4DY5miyK3hwgMKY0U3nWj/Ev8BeJg9+Irbj7YzTgnLr7Z7gtuSw47UeO37MT0UCtVcSEV6xeVR2TE4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt38QniHSXQQkPoBH8c9SPizaHrvVuQMTdkc9XTxBAs=;
 b=0pPbhPKO/gY1BLkpuIi0FMWac+Lsq7beZg83qLqE7uQjdjMAKUc0ZF6TH8EBlTmZ/ctCw7+agJnoIwZtZ5j0R2pQzFGZo2/O5W1EcrVIagavVDupE4tbSyj1X8Rg4Pj1kgJxwKr+mN6DRP7Tm2XRh5moRwNZLtlvEWXzxtNd/Ts=
Received: from CH2PR19CA0017.namprd19.prod.outlook.com (2603:10b6:610:4d::27)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 17:33:55 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::6b) by CH2PR19CA0017.outlook.office365.com
 (2603:10b6:610:4d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 17:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:55 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:53 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 07/15] cxl/cache: Verify port hierarchy has CXL.cache enabled
Date: Wed, 23 Sep 2026 12:33:34 -0500
Message-ID: <20260923173342.5584-8-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 089a7f86-2e5d-49ae-53ab-08df1998d7a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|3023799007|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	FyMoQ1tWFGxjCIyT7CwVDLxkyOCcTEl+epFhMjYfcAdHrFyP21bY6p+Ta7m/5zXUteFYYPKOAGxr6KID0vE8TVkmSNNzKXHRicvoNYjEGs4h5wLFPbe/bjbt1X++17PHtHDsnZHvcYlP60FPFGYu3sAcgRu3Ukj3CZn2e6cuRpdtqDF+oCNheFZpWOjt9gOc5GfJZ1oTx+Cx76sc+a1HTfTkhiqInSeGAwpgsbcxsR10UZWYKpYOhj3qptxJQ5F/NO1u50kK6spFBst4CgMTz066HCsE4V2g3MyGMPQkem0exbYJEZRk1aKKVaMh+iGj9pYk7BR8Psuh2NSrV9YPWhpVB3viXETL3l3naSrKjQwP7Wv+Lzo9VXY7FfcWS42x6SmQXk9/lfdAmNgWozf+v3zCYr6CArgv1GMuOotwuwlTh3YTHciXeOsX+DiQ/k4/DbeCJyZzZ9wxBLt4yveKfA6Sq3NgtkeASWKCiLnULsrZ0Q72UdlpOf9Qx7RdscrEBCFX5Tf0t6iSIOmeXB0hvXvWaw2bIwfep78T4QjXGVdYFIHplMsy9oMB9hbIMon+ayFGzFVzNbsKMjiF7kyyZKFXfBHoPeBatqpNM5WKVBvNzS3Rkhet/K677wtUtIZCHbOxd2Yk6Ygu2GVEhgXOmgsBzr9irfk1YU6/wWiD1jRSbymimrk9l3Jfja8BH7hXuH6GFV0Y2kre320V0KiFzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(3023799007)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bzyrAgaXwJj3MWPnL1xduV7tXbkrJB9dIG4tgztRHlixeq7mBaaA1zTT/ntbckTwrCrL3RWO4HsBy2ljoP9rIqX2TCrgrWR8U7dh4G3SmHg96FxH5Ag5Wc2HjLsCpOqFFxcK6N3kRBIyOt8ESwTvJqPqiA/WfPsTTo7UscNDaNoaZrTQgQyVeRJKKhAleYREt3YgdAEkSupYgQ4zfaT0v//secnXYX4QF8GqgbTgv2vVeEatLwAsPoRZ8rQn/8eAlZo7ynYuf5ud9GBYvsMRTR4Vox969rYie9JtRKpnN7hiPrWJe6nuoYFyfYyri/8Xo3epH5gG00dRzT2POhLJVeUKgS4dnF+c1YiNBt3VLxJcLvscHOB/MQRo0d9tVzleq3ZuIfsNUReXDfdkohPyRD+O5pcTQ/6/kCzLrqnHADa6Me2uslZUMuGvlFj++g/K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:55.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 089a7f86-2e5d-49ae-53ab-08df1998d7a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353

Check that the ports above a CXL.cache device support CXL.cache and have
the protocol enabled. The device's CXL.cache enable bit will be set in a
later commit.

CXL.cache should be enabled as part of link negotiation by firmware
during boot. Upstream ports can't be programmed after boot, but
downstream ports can. Reprogramming downstream ports requires a link
reset and is may have implications for the underlying PCI device, so
fail probe instead of reprogramming the downstream port.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c           | 76 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h |  4 ++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index dea5af7b2d3f..dfefd301696a 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2026 Advanced Micro Devices, Inc. */
 
+#include <linux/pci.h>
 #include <cxl/cxl.h>
 
 #include "cxlcache.h"
@@ -14,6 +15,75 @@
  * device-specific driver is required for discovery and portions of set up.
  */
 
+static bool cxl_flexbus_cache_enabled(struct device *host)
+{
+
+	u16 dvsec, cap, status;
+	struct pci_dev *pdev;
+	int rc;
+
+	if (!dev_is_pci(host))
+		return false;
+	pdev = to_pci_dev(host);
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_FLEXBUS_PORT);
+	if (!dvsec)
+		return false;
+
+	rc = pci_read_config_word(pdev,
+				  dvsec + PCI_DVSEC_CXL_FLEXBUS_PORT_CAPABILITY,
+				  &cap);
+	if (rc)
+		return false;
+
+	if (!FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_CAP_CACHE, cap))
+		return false;
+
+	rc = pci_read_config_word(pdev,
+				  dvsec + PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS,
+				  &status);
+	if (rc)
+		return false;
+
+	return FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE, status);
+}
+
+static int cxl_endpoint_cache_enabled(struct cxl_port *endpoint)
+{
+	struct cxl_dport *dport_iter = endpoint->parent_dport;
+	struct cxl_port *port_iter = dport_iter->port;
+
+	while (!is_cxl_root(port_iter)) {
+		/* 
+		 * CXL host bridge isn't a PCI device, but we still need to
+		 * check the PCIe root port
+		 */
+		if (dev_is_pci(port_iter->uport_dev) &&
+		    !cxl_flexbus_cache_enabled(port_iter->uport_dev)) {
+			dev_dbg(port_iter->uport_dev,
+				"CXL.cache not supported or enabled\n");
+			return -ENXIO;
+		}
+
+		/*
+		 * Cache can be enabled for dports, but it requires a link
+		 * reset. Could be done here, but should probably be done
+		 * by the endpoint's driver.
+		 */
+		if (!cxl_flexbus_cache_enabled(dport_iter->dport_dev)) {
+			dev_dbg(dport_iter->dport_dev,
+				"CXL.cache not supported or enabled\n");
+			return -ENXIO;
+		}
+
+		dport_iter = port_iter->parent_dport;
+		port_iter = dport_iter->port;
+	}
+
+	return 0;
+}
+
 /**
  * devm_cxl_add_cachedev - Add a CXL cache device
  * @cxlds: CXL device state to associate with the cachedev
@@ -71,7 +141,11 @@ static int cxl_cache_probe(struct device *dev)
 			return rc;
 	}
 
-	return 0;
+	rc = cxl_endpoint_cache_enabled(cxlcd->endpoint);
+	if (rc)
+		dev_err(dev, "CXL.cache not enabled on parent port(s)");
+
+	return rc;
 }
 
 static struct cxl_driver cxl_cache_driver = {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 5383b54ede96..9146ee574de8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1392,6 +1392,10 @@
 
 /* CXL r4.0, 8.1.8: Flex Bus DVSEC */
 #define PCI_DVSEC_CXL_FLEXBUS_PORT			7
+#define  PCI_DVSEC_CXL_FLEXBUS_PORT_CAPABILITY		0xA
+#define   PCI_DVSEC_CXL_FLEXBUS_PORT_CAP_CACHE		_BITUL(0)
+#define  PCI_DVSEC_CXL_FLEXBUS_PORT_CONTROL		0xC
+#define   PCI_DVSEC_CXL_FLEXBUS_PORT_CTRL_CACHE_EN	_BITUL(0)
 #define  PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS		0xE
 #define   PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE	_BITUL(0)
 #define   PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM		_BITUL(2)
-- 
2.53.0

