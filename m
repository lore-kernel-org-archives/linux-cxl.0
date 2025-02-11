Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FBD1F2386;
	Tue, 11 Feb 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267691; cv=fail; b=B32wuvGIXPH4XlnD32RtSxUhhBYNK8/1/0pH9cmMQ09CANB6QMvlD+G/fSKv3HMsDoye1OKkXa2+lAiOHVProCDNR1kTony4Dx39EHrNulzL9A6+tAKS8Hwy1X/wlgO+kJfPinwpN5cbqihXojxB0JY5F2HDwJeXS17Rtr8wTGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267691; c=relaxed/simple;
	bh=shY17caxCUY6O6323OXq/Dd+xLofJzXRrJVF7k/qsnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZdHylFMp+HLW1/Twr3ycgS8ECtj6fdNAQJRTA6Oq8bsizGTufCPnEJ3Y/kylXjAfiuAl4mCI2iPCsAaKP2BEO+Rpt1XPTnkU0AUjrNp+cGUHlix6J7RdcG4JD6+KeBY2OUrxYJOeialPsR7fbT0s/EFokLlF1UaEG2MgkM4n2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UCgF2N+y; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UCgF2N+y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIJ7K3U3dylNoLtKhWglk39PZYW7EKWcA/l7536kasYJwwTp2h3p+rw6k98i+SQv61q8RUayk+WAU6a2TW8ugFVKKPibFxCcLbbY6Kj40GokOnoBwzv/PdPLgjVcZg78l1XzeLWKGNzFw/krNJvSB+ehr1qORF55pAr+SkAzJz6XaoGkYzMghUSmftmEcnvCIB7Pv88P3GzCpkNf6fXBn/HFnS/4ik0xbSehhxp1B5ohqEvIBJr9x44dzl4RJ+keKFq1loPKXxlKc9Q2bWWoe2eBbtnyWgDbklPQRdkZT5bL1ZMkZfr+usFnKTFlXlig5UA0STeH02KFnTjKjC17VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzsJEXZKZ9RauGukjRNPo3JdDHwxJOUsrtRN41/C47U=;
 b=bhBTeGJRlMeX5nwC7YNf7ICrJwFlBvYi2CxC9m0I6ln8jm6oRSjoc/w8aKISYYfl3d2NtYw2UPVcZ0gqSvOCJZvpbuqr+3K3u3hX/Wx5pddQaTYHMYldC9Y29Qjed5NP4ZNVJFQG1vQ+xhF19RY7zZMoNPjo0aDoRJA39dsmldQskzExnExqYsqht7+01q3TgPjuRt76hL4S+K0v4b8GAGsmiDt8Q602ozTGjYU/2XEK2rYOIQZorFV6frr72GA2ndTf6exBLSXJ2lZKi2qzxuIlUT8LdYMqBp0t0YQTSROE1/qG+EXcHNzf8LcZ/sKZ18cLvLcy/4ANIpL03XKkxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzsJEXZKZ9RauGukjRNPo3JdDHwxJOUsrtRN41/C47U=;
 b=UCgF2N+y5Xk1aFUljZNQn27WzDROD/44CR8XYIEXZqiZHfRfpCXR/PypHbDraJUxJ0EOndc9RJX/WpkzUkzKTIjeO7ra6MGc1pHLrY8+8Y1KxHVWJBOqDcynJTT0UlUeWNVBhxmVwX7vbtryW0AJb8MtJxcYebgHY1ukec8lzMg=
Received: from BN9P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::22)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:54:46 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::4d) by BN9P222CA0017.outlook.office365.com
 (2603:10b6:408:10c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:46 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:43 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 08/18] cxl/region: Move find_cxl_root() to cxl_add_to_region()
Date: Tue, 11 Feb 2025 10:53:38 +0100
Message-ID: <20250211095349.981096-9-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211095349.981096-1-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 47df4ece-f538-4e93-4b01-08dd4a821df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJvLeTOtirCeRyNLw74ojihpqGRhN0da5bEGa/6DNWsExS2Hw1vNmL7UhSaQ?=
 =?us-ascii?Q?gx5G0aG6YF32jfxpnfdTHNeXf+BXHW1gdVX3cOIwQyDaQ60X3av4FQU+oOYS?=
 =?us-ascii?Q?idqf93LvZ6LDCp4WAafUU5CIgQV61CGYw9g5ss+/hWMLQgNFcG2tbIaCKsll?=
 =?us-ascii?Q?AsyUxBjebGjYJkSEZ1cGXGnu5D8YCRyHW60sy7Po5UIZ+wJk+IW4+5/VKKCD?=
 =?us-ascii?Q?a26CPpbkINIUSXELPTlSbKccFeb6N8+Uzz27sBD6gfL60C88UmN2fVy6TjCy?=
 =?us-ascii?Q?2c/5FRw8vbWeRDTRMe6yROaSsDea1+Sm4lNHbsJZEhXMtFITfmAKxAFK7ldM?=
 =?us-ascii?Q?gczIKzihE5j+QuvRdbODPddJDj4zHidLyja54sGO7HJpYZ7WjE89RivKGOOh?=
 =?us-ascii?Q?XdgjU6l/p2VXjIq06u7XLTZdQf02QNZcsrkTQJHGAO3HJrm4eoyGf6mLT3wc?=
 =?us-ascii?Q?6rNl9j1JrazQrCnqosW3zpd4riWHIH10d01HiBa24tTmp2z0WfD97FjxHnwD?=
 =?us-ascii?Q?p6iS2wn+f26qL18YqYioP7nAZeqqc1xoEfFhasKYZvqM/0VORIhhfH7G8TqF?=
 =?us-ascii?Q?/WqeipjGv+daAYGEne3aOUh0SIHzNtcY5RwnIKBiZl95pgUyDieuvRq7Jp04?=
 =?us-ascii?Q?cZwREjF5JI4QETgxmZMKufU5ifggGHDKLseONvOYW+MsHX6bi116PnAKTZ9m?=
 =?us-ascii?Q?QI8xDsBFzTf9eEaXwsr568Vg+ACyd0jIhPoU8C3wlgMdDbYk/UoI8PaSAcKo?=
 =?us-ascii?Q?bTyM6fTkBYp/7OzQDSJ1Z2IOt6gzUVegJJ81YsqKBcfv0uaP8UNJwhiNVI/a?=
 =?us-ascii?Q?jRdZFaRmTSE2ElAh6FpC5JHK/qo2PBdaXBatEF9XYMJyxZ3paAWWi3HiUU0d?=
 =?us-ascii?Q?vtXHkTdOEdfQRCqgOKdqvg69Rzo8Kl0JC5BmL2+5AWOt06ApTOMfSzFy6Uyq?=
 =?us-ascii?Q?JvpQIvtOcgWtP6iiA0B0+/sjMnp4mzJ1+8GQ97VLOpIl122vbuxftvjyuh9O?=
 =?us-ascii?Q?qHDkAgSze1PzoBnd53QatxXnpuaRhTpwBbeq8IDJPjmmPPfzZ6qvPk6wrtfC?=
 =?us-ascii?Q?BAuzenOTiNfdMydPY1xOnL/JGf+yw3nuMykHjxrRLuZ6GnIg0r6g6qdnM6v3?=
 =?us-ascii?Q?I4Y8T3//0GigArOj3tnwzl/24ODbWRUTFEucTzYoVxr5Go134hfAy8klKs+G?=
 =?us-ascii?Q?TEphIKJEDMm+fHFkcGOse5SauOA0NIXnP1czw/xiE5eCncGX659SO+lDKzEs?=
 =?us-ascii?Q?tp6gbxva8dzLmb2C0I5BRQdwMhvx4p6P8n2fbtNwRdBTLCEeOjJlp4VkZuSj?=
 =?us-ascii?Q?rvdwYHaId94Li9DzmT3zRBJunl74lR8Co6xkx5nMPaAfTU0lsRn/LXl7Zk75?=
 =?us-ascii?Q?UwhDwiZpkmGfdPo9exisYASrdJLVv7m97l/twFRMwhxQHg430THf/HuzuozE?=
 =?us-ascii?Q?yMMAXcX+t6LwZN4YcKuQ5GXzMpjEtY6aQg7Plk0hWwjdtmoKQaJCk09iWzKt?=
 =?us-ascii?Q?FBxXGS9m+FKbO94=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:46.4606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47df4ece-f538-4e93-4b01-08dd4a821df4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359

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
Tested-by: Gregory Price <gourry@gourry.net>
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

