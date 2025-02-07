Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAA91EB181;
	Fri,  7 Feb 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942732; cv=fail; b=XsvVBv0EyTaBh4YOE2e7odoGywPMTDleAWMo2gyU4RioapRx/F2uN+XXcl0l0/kkcpKL3GlxX4C4M+JpSDMiwQYEKeQJtWV6p2SQvk62BUN9W7zm+vXPHSk4EBfVHbmJFiewbeY/YBIyfbf+MPzGk6RuxiUDNib8qIc3Vd+iYFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942732; c=relaxed/simple;
	bh=yyXKr7QpKsofWgeKbuJBjxGDNgbtbC5J0ogIhqoONO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8v5Xuffq2BYIKgwEpSTiDa8YXhD5DoSzD87emk8EkOa/arG4QB9sAewE2ClHFGCf5Dq3fN33jXOTTTCBFKhoCmk75r/+F5epz8xtbgSlz33wegE/wI5+1RCrF4ZRmpDkdxzWYlyust2rz+jhA5Xs5ne8UC2J/p6zrBUHQOKec0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qm6WrCQW; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qm6WrCQW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMzFeMXt0WxyNExZX178irfMbdKk4emGNUQVV2MiLj12Nx7umGI6TI6Tq2UwceubIDzdmx62z8uuQC8o8ebYqprU17m2IOF70df/QafObOmc0ucGw36az7POm0CjS4KhOKvZZ5jcLgJ8xgQ6lOIZLj30Zfz8mjV519N1moBVAh7XikHxHjvUu6eb3Yjf7Y/9qBUAmZD+nJkvk3oVSDkIJpGjWa8RG8jo0Mo7veZGKWGv3mhrnkC25ZTOdVQRk5LMQ941rojUmeTU+2OY1Szy/EBkctctN8WiBEXNrtaczE2CTfdA9eizAfK8dKyybveIOyyAq4kJHC1wRfzGLAKxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTtWcdcAMKpesdorBJRSbfX1aoHKLHIe/f0+O3YqYb0=;
 b=sz/gRVjheI9OgAutq0dDzUwhrgXQYv0lJp8vZbLd49SKc7eUa+B2kg9dtBw5SrQTPGFBGPq8QFkG1VWsI/AwERlr8eVs3sH8nqCBd/EM+hWDOpZASea1wnFJ6BP4PxUTJi5xHuN0GREz3bpD6/eh+owRgNGCa3uEv19qzv8UeW6pHRmZZOFNHNQpw2WrTU/si+FmLcIWEeA4SL3jQTK5buoIHl9mGfIrBHKxgt83HqadX7CWq3W/dmg3zWbSVqtdovJJuU+SQyBLozrIPfjG793hGAqqsq5Bo7d932HGUfgHgrgNHdvHNEtjMlRUGwihi1AQiUxv8Cgi+U7n58LSIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTtWcdcAMKpesdorBJRSbfX1aoHKLHIe/f0+O3YqYb0=;
 b=qm6WrCQWVBF+hGRbDSfgbl2sDg9sGRospMRpnXrr1esgILYZ16I/FG7Bk+mFSLDW7+KQayI9BoidlarqQ5ZOGPYIX1IMHKwf0nI35CEeO4jHlv+7mQa6bawGgk3Fs9enlomeB0/AWhjCjHOqGxPM6qbSz3IprnExCm/06j8d9XU=
Received: from BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:38:47 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::74) by BYAPR11CA0095.outlook.office365.com
 (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Fri,
 7 Feb 2025 15:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 15:38:45 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 09:38:42 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 08/18] cxl/region: Move find_cxl_root() to cxl_add_to_region()
Date: Fri, 7 Feb 2025 16:37:43 +0100
Message-ID: <20250207153753.418849-9-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153753.418849-1-rrichter@amd.com>
References: <20250207153753.418849-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: f76d36f1-0f7d-4ed7-6d66-08dd478d823a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kj89OldsQevEg8O+EtTMmyhxd4xm92EROxw5C67lOoOsHg63wJY2fSSvH9YQ?=
 =?us-ascii?Q?g4ogBuEjSzLJXYO8L8QPrml7urDsUQvSkz2g7Mkop/gpr/ukyaio9QMNFU9S?=
 =?us-ascii?Q?CHQWWFmirRPGwBXv2btbh/z/ZeCobxc7HPR+dODrEjnqe4cT/BNxiGjowXYJ?=
 =?us-ascii?Q?xaEl8iUpc9fKrckHlgeIObrIhdfKpMlNmk9HOZNEfuzcM0e/YUWcI6kEPa9D?=
 =?us-ascii?Q?URnaCG5PApUNCgCFw25HkZ/lnY36MEtc2pxERYKoBKmseRIsy54KDQFdkuwj?=
 =?us-ascii?Q?kZF8Y/0DaRISWigwYxKu936MXGQN6HJO4QZEM6MdStFCbKkzx1ajy1zNydIN?=
 =?us-ascii?Q?ZjWsWkp+NbtdDk27rgawdJVCEna9U+VjoMBnvN3GIA6nnjM82TAZv2jujWEr?=
 =?us-ascii?Q?DZAT1wVMqRr53pD0n971DtFsFYYJNklXXg7izVB108Cta71XfuVT8FAnZaZo?=
 =?us-ascii?Q?EUgar6lH93Z4VtCX5m8Fwz7z/iE+iMrlKIV3xvDOrm0qf/c7ucmA+590Fwai?=
 =?us-ascii?Q?HHp8oonHjF1SSnw4gjOA8ux5ksbOaQZcfr7uhKZ5U/xmGmkhb6bt2Q24mE/2?=
 =?us-ascii?Q?9xuRxTkUo2CTLDKEoPKs8MKv29AsF7xsqNaXHrJJB8rmrwDTbhAXW+qd/I7y?=
 =?us-ascii?Q?NnZmfHe9gr1jfroKZXMONlbfF+yaXrq50SOOJ8Muwie3kFFHYGD1miDw5c2h?=
 =?us-ascii?Q?iyrLPqeMcK2cjpXG10h8y82EObDoIeiVoVQZwfFketPnGZQgh7OOkCCC6rA8?=
 =?us-ascii?Q?S55muhZ473q1+gRYqIsCqz7yNWPerNAYhXUCY4jHbib+NnbCsYlr3OUDyttH?=
 =?us-ascii?Q?p5jh1Sij7d5/UlnqkpDFoFTZzJaksEm9amsPKFXIbCPkyR516Wm46lVmlwQE?=
 =?us-ascii?Q?WOfP1kmfuZP8UZomhoybIHZaRGLGcdt+cMaM0uRRUqfDcDuhQSaee7+pBMU5?=
 =?us-ascii?Q?S9JXVZv7d5Eln1JJ7Iim1foGfxk1GUF6rvgzgI9Rb1nLwrZ6anw6sLc0rbOR?=
 =?us-ascii?Q?/yzi9G56mUotoK657HXM/e2aO3XEEn1b8ew2OxkkknXTwlEC07osofLQKbvz?=
 =?us-ascii?Q?xLTSwFuwd0K0jRUt+W520YQCKFW0ZuU5mDpdatU321knI8zvwL3BbqkiMBK2?=
 =?us-ascii?Q?akMUPn/oR23bxablZ/iz8sq7Mvi6D48EPUBW8lCh6RJcWKAsCSbdZjMxZ034?=
 =?us-ascii?Q?HHKaJmWuwGQuAt4qpiKrlcNzFWLIxGvzvNqyO5b8l+2l56rbskwHthSIxOa6?=
 =?us-ascii?Q?48KJPDQFDg7EoK4UhRuByI4ZrwHG0LUr1JR2K8XkO1rK9OTcqM5BILptkIkb?=
 =?us-ascii?Q?da4gcAQ1U5sTAGPkYYEUwh18fHsoDxUzvdPg3elUlu7017j6TLwX9WDUVue/?=
 =?us-ascii?Q?EFkgZG/ct0yvxy4gncekV0SLoZgHzA65gH+yCGBeX0pdKI1a3Z6JF49FHaH8?=
 =?us-ascii?Q?FlHsFFMdEpNifP6eZIDxMkT4t4ewZIn+P6lIC2nS9+0Km5KCr6oaJZKWEgbe?=
 =?us-ascii?Q?X7yWYqyHp9Bs6Y8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:38:45.5587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76d36f1-0f7d-4ed7-6d66-08dd478d823a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872

When adding an endpoint to a region, the root port is determined
first. Move this directly into cxl_add_to_region(). This is in
preparation of the initialization of endpoints that iterates the port
hierarchy from the endpoint up to the root port.

As a side-effect the root argument is removed from the argument lists
of cxl_add_to_region() and related functions. Now, the endpoint is the
only parameter to add a region. This simplifies the function
interface.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c |  6 ++++--
 drivers/cxl/cxl.h         |  6 ++----
 drivers/cxl/port.c        | 15 +++------------
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b8201c2faa87..0e38bcb43be6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3312,9 +3312,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
-int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
+int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_decoder *cxld = &cxled->cxld;
 	struct device *cxlrd_dev, *region_dev;
@@ -3324,7 +3326,7 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 	bool attach = false;
 	int rc;
 
-	cxlrd_dev = device_find_child(&root->dev, &cxld->hpa_range,
+	cxlrd_dev = device_find_child(&cxl_root->port.dev, &cxld->hpa_range,
 				      match_root_decoder_by_range);
 	if (!cxlrd_dev) {
 		dev_err(cxlmd->dev.parent,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0d7aff8b97b3..85dfc8df0a80 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -854,8 +854,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
-int cxl_add_to_region(struct cxl_port *root,
-		      struct cxl_endpoint_decoder *cxled);
+int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -866,8 +865,7 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 {
 	return NULL;
 }
-static inline int cxl_add_to_region(struct cxl_port *root,
-				    struct cxl_endpoint_decoder *cxled)
+static inline int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 {
 	return 0;
 }
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d2bfd1ff5492..74587a403e3d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -30,7 +30,7 @@ static void schedule_detach(void *cxlmd)
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
-static int discover_region(struct device *dev, void *root)
+static int discover_region(struct device *dev, void *unused)
 {
 	struct cxl_endpoint_decoder *cxled;
 	int rc;
@@ -49,7 +49,7 @@ static int discover_region(struct device *dev, void *root)
 	 * Region enumeration is opportunistic, if this add-event fails,
 	 * continue to the next endpoint decoder.
 	 */
-	rc = cxl_add_to_region(root, cxled);
+	rc = cxl_add_to_region(cxled);
 	if (rc)
 		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
 			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
@@ -95,7 +95,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_hdm *cxlhdm;
-	struct cxl_port *root;
 	int rc;
 
 	rc = cxl_dvsec_rr_decode(cxlds, &info);
@@ -126,19 +125,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	/*
-	 * This can't fail in practice as CXL root exit unregisters all
-	 * descendant ports and that in turn synchronizes with cxl_port_probe()
-	 */
-	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
-
-	root = &cxl_root->port;
-
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
 	 * assemble regions from committed decoders
 	 */
-	device_for_each_child(&port->dev, root, discover_region);
+	device_for_each_child(&port->dev, NULL, discover_region);
 
 	return 0;
 }
-- 
2.39.5

