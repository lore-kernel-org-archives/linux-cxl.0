Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD21F426F;
	Tue,  7 Jan 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259084; cv=fail; b=clS7SULmyXDKFpy4o2TE8wothT545q/yGUgRVvDFQ2Lhg4d7AjBYL8Uq4DIn807y06PMJIU3m9PDbE2BL2dI9iZ5BzccvyemKqYl8rB/Ux8Ms/1CLDTn15KvEc4izM4vblMgMXwlGgGFrjbLBkP7r+uz7U027rQxamg43ebspvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259084; c=relaxed/simple;
	bh=D8D4TiZr2Mr5x74yHIEneazaWUKU94MjpZPQQrtjSqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdzht2pvvVDt1GdbPsXNQND76QKJKDTBhapaBR9RLdD8W7Jh1zEXDlY//hZMAbeW1cPsEnDuDLOimi57h0D+fiE3ENL+BsEC8FesojZLOOykQYn8gYXhI6LKyyO+m3Mr+WmqUTP89TB+6Iz5D1+y+MWvrY9uKo/beo9jfALLsUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2hVPlTlf; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2hVPlTlf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNq4oPOOFcBLj6pitEZFEUYfkU9PRszlAGX5i23o/Joxxzu+LKxhC4t5ODhfGECEcRdIh+zzrzJSrde9PC//EEX1SzQzMpeCY/p36sJrtiANnpiDv1fBJjxDz4doy7XDoAwR6BU+QSGCQMmdEou6Wo1oP6GJ8NSEdDhQYqGoqZNgjH+8urvUbbYIV8pdD7d/95KkFDmWH1DOLJR+Ko7B7oADR5ltr+K4Du/Gk8lLhxoygkoaUwUDxMc/O2sUOIsFhzzqjYC8V+Fxf5fvxBadKfhnda3U5uze099O1RBGFtA3Hzn/FWf58Aubjiw0zNg08bPDwS0FQhktfB/P6oOKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmALJ4MCR0cxq6nfoulbQnITOkOCtVHtbUVe2nKR3Dg=;
 b=oRAu6rzYtUGwYIgl5s5jLrKvXg1Pxf+I4CZGmPLr9kGQqmAfW+Ok+cisbEoJ0WsikfO2ir31xkvzeIgNCTV0XsH6cHLLprn4VdCLc3YWr3BWcVAh0Y5hSDiX5N0rIQRFvwL1sauxugntIdaox8bPW8OgmD9tiL5QI6LEgiucbHITP6AoUl2tYyY/b9Szv0zQbVJIceBxi4phPVIVStEPexZ0Pulcs4V16NPsMkDr+pAkdoLvkvcaJOhUaSlEIpxtYwcupV2ZUbHtRvoLAlVgbfC831J5MgYKpBjSkPhcnDRea5RWJZyPh0O0EdIypyOttVosyFxyiwxbyfaj3cvrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmALJ4MCR0cxq6nfoulbQnITOkOCtVHtbUVe2nKR3Dg=;
 b=2hVPlTlfvKWscstkplfGdltqDuwFcGCvkg4QgE2ztEfXKeL0yJvkAw2Lg8z0p5bU+0RxCCYhT4DrJCyrXCVoehNdiic2srAcaiEdcus59atm1LHbcyU5zU8O3mHBoeb0iatCFg/BE2AiWoM0fPagwvrNhnmpWtRFH8/OVJ584KU=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 14:11:11 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::74) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:07 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 08/29] cxl/region: Split region registration into an initialization and adding part
Date: Tue, 7 Jan 2025 15:09:54 +0100
Message-ID: <20250107141015.3367194-9-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: d99f7582-f6b0-4a9d-3b08-08dd2f2523c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Liq+QoX1PCxgQ6NSKw3WBD5nKvmFbCDVVbaRvTap5z/ovG8pnJciLFac+kT?=
 =?us-ascii?Q?CoFRp/npDNP+FbIjOcl8Ebyba0zBOK0JcsXZtkbas5Vpb3/21Y3zd8528xsj?=
 =?us-ascii?Q?3kssNbPEMA4IgfzGW93uNcaHyqjPcBg2rAJDtUokze0cxggRYiqTQvEklph9?=
 =?us-ascii?Q?NrCJiHPz0mDZug9fPCPShN3ezSzGkcXysSGsmXebAGuLHOLk29x6xDEGzl9X?=
 =?us-ascii?Q?umcghmIT1PxArwiYbFQSN46e8VTsmj7coAiDVAHKxv0RCODq9sJyJxi8zfCb?=
 =?us-ascii?Q?7jdfPEITyyTaoFrzb0aBCISnzYOCyBqVfKf8NjD3C+jWoi/svRG2Uxc7JWVc?=
 =?us-ascii?Q?3c/BWOdi/zbfbeNuEzHZdUXUz7lGu+YgSKmR07f/c380UokKpflHVmr6q8fo?=
 =?us-ascii?Q?/RCJV1WSvpsJeSTBQLNSAxd5uhclHFookRUHD+zz6QkxtCVuGS5bd1tDOzLM?=
 =?us-ascii?Q?gGuNiJZPSneChWFUs4Y6JekxwXD2VWyabVuOd5OmW22LsVRh7M709m+IvfdT?=
 =?us-ascii?Q?vCXY/gkbtwVoOxu0QQKI5CavAk5/P9HkS7kRHgrUYggc2lnsX8siOdeIhB4A?=
 =?us-ascii?Q?8TUXPIybaNwWAQ86FYpjH+Yr5HeBgjjMl4Whn/U9AhIrhTzx9W4edCik3p+V?=
 =?us-ascii?Q?n6B676AuNaOUve4443oVGJp1V8yHFHi+hf5pxTMTREq4pcMYbKX3V9rbijBz?=
 =?us-ascii?Q?64BAmdcmg0TAOb/nF/gwRtdrz0gUXZ7Z3gvET7eGK1EMFYv6DrSCEtxyw69l?=
 =?us-ascii?Q?/trNl4ud6yreo/Jce+hBvhYRaZ1xS9/xGqJGr53W8kGNUnc4R9Sjx1rXB064?=
 =?us-ascii?Q?Ybj3E5fQFYY4vIYzk9EPak1A2C3CcYe1sp+ljoMiPSYPeqm15h2VHc0h1cFJ?=
 =?us-ascii?Q?OMF1xLbmhMlAlt5reXB2o0CKj727ZVv+nZ94vM7O7HD1z6aR3CTHbpYYA6QZ?=
 =?us-ascii?Q?bYvbXl/1Ivx2N1QmLlWIztdDdJdM5OniiQge7xU6k3YplAO//BdDGQDcGMRo?=
 =?us-ascii?Q?AZnexlopkSdQskTdzHw36i3HsrWTlN2bRczcgCyKEOzduMj2nmRb4oKaIgFo?=
 =?us-ascii?Q?90SWonv5xCTQC0/Q00D4eNI/chDjRfcKW1ykFlpOAjiBq0hZpJgjZv5jlCAK?=
 =?us-ascii?Q?5PftDGoZbbeSmnpTf1h+/bn+x9YQ5YEs5w0NpzJPiFGX9wbokAoxH2n7Vpd8?=
 =?us-ascii?Q?1TalCZZ8fIOU1jhA00K5YniXbU9gASW/3wxjejrgKyby7SISCvWDFF6YHJxR?=
 =?us-ascii?Q?11UpF89NnRR9Pk0xSVN4SiOVsBu+KUT64xMKw8/osFJa47iuQ1Eu3/wZTEMz?=
 =?us-ascii?Q?32AjODSwmjHMCwYE6vinaEwp0HEPKBf6VgAK9+Pbe8hwL2NDn1OjptaLUU/+?=
 =?us-ascii?Q?TFuTgiynQAnGKG6PRxr/hsOlagtX6JcXJNbq46rPgJ/Y34ww8feRXHorua2C?=
 =?us-ascii?Q?njwvAV8Vc1kVBJAP3k7sF3AzUZ6eKeViVX0pR0TusIjkRS0Vzr9tjnQlBqWz?=
 =?us-ascii?Q?KLOBxmxOxBJKBAc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:11.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99f7582-f6b0-4a9d-3b08-08dd2f2523c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933

Before adding an endpoint to a region, the endpoint is initialized
first. Move that part to a new function cxl_endpoint_initialize().
The function is in preparation of adding more parameters that need to
be determined in a setup.

The split also helps better separating the code. After initialization
the addition of an endpoint may fail with an error code and all the
data would need to be reverted to not leave the endpoint in an
undefined state. With separate functions the init part can succeed
even if the endpoint cannot be added.

Function naming follows the style of device_register() etc. Thus,
rename function cxl_add_to_region() to cxl_endpoint_register().

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h         |  5 +++--
 drivers/cxl/port.c        |  9 +++++----
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d5dcc94df0a5..5132c689b1f2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3340,7 +3340,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		dev_name(&cxlr->dev), p->res, p->interleave_ways,
 		p->interleave_granularity);
 
-	/* ...to match put_device() in cxl_add_to_region() */
+	/* ...to match put_device() in cxl_endpoint_add() */
 	get_device(&cxlr->dev);
 	up_write(&cxl_region_rwsem);
 
@@ -3352,19 +3352,28 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
-int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
+static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
 {
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_root_decoder *cxlrd;
-	struct cxl_region_params *p;
-	struct cxl_region *cxlr;
-	bool attach = false;
-	int rc;
 
 	cxlrd = cxl_find_root_decoder(cxled);
 	if (!cxlrd)
 		return -ENXIO;
 
+	cxled->cxlrd = cxlrd;
+
+	return 0;
+}
+
+static int cxl_endpoint_add(struct cxl_endpoint_decoder *cxled)
+{
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	bool attach = false;
+	int rc;
+
 	/*
 	 * Ensure that if multiple threads race to construct_region() for @hpa
 	 * one does the construction and the others add to that.
@@ -3401,7 +3410,18 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	return rc;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
+
+int cxl_endpoint_register(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	rc = cxl_endpoint_initialize(cxled);
+	if (rc)
+		return rc;
+
+	return cxl_endpoint_add(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_register, "CXL");
 
 static int is_system_ram(struct resource *res, void *arg)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5c1a55181e0f..b3989dc58ed1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -417,6 +417,7 @@ enum cxl_decoder_state {
  */
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
+	struct cxl_root_decoder *cxlrd;
 	struct resource *dpa_res;
 	resource_size_t skip;
 	enum cxl_decoder_mode mode;
@@ -872,7 +873,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
-int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
+int cxl_endpoint_register(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -883,7 +884,7 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 {
 	return NULL;
 }
-static inline int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
+static inline int cxl_endpoint_register(struct cxl_endpoint_decoder *cxled)
 {
 	return 0;
 }
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 74587a403e3d..6eb82a118bd5 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -46,13 +46,14 @@ static int discover_region(struct device *dev, void *unused)
 		return 0;
 
 	/*
-	 * Region enumeration is opportunistic, if this add-event fails,
+	 * Region enumeration is opportunistic, ignore errors and
 	 * continue to the next endpoint decoder.
 	 */
-	rc = cxl_add_to_region(cxled);
+	rc = cxl_endpoint_register(cxled);
 	if (rc)
-		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
-			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
+		dev_warn(cxled->cxld.dev.parent,
+			"failed to register %s: %d\n",
+			dev_name(&cxled->cxld.dev), rc);
 
 	return 0;
 }
-- 
2.39.5

