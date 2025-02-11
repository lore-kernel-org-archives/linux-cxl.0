Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBA1F37DF;
	Tue, 11 Feb 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267703; cv=fail; b=s6zw6Ix/zwajedf4Kgtuy8TGdE2lWN15eLkp9HO4lhut4QZgbee+ial4xP66EmaCPOwnRQxsjfml+SpYXgJE329K0eXAmKK0IJ6so6Ul7NKyBNQf+4+ukiEfyTs/ctVohHE9o2nw7xJbcqIGMuSvTT/tOv4WObWlJnDicGBNiS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267703; c=relaxed/simple;
	bh=GVKx+vJLsCKf0FbCZz1tBozoKr6Du0QGSzlElVlZ5t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O93Bi2VycLPRkZrX2Bap2wIacjnI8p/Oud1X/3mj5opskY8VYV2ch2LcyyqoOwLON+kE5/11PSofH1KwAki5wFZuDEpFVED0hfEsQF7ioAVfU5GpkSdbt/ZHyuJ2uQ5TQiCxK9z4xJbKPi/3OfcgJOn2Rtjo7FJiKYbDEs/viR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QPGW6jD+; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QPGW6jD+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URKdqgnGWN3dKQYIrtg3Iong87M23x00pCwuZVTZuI0BubGiNffNwgCS/XSbdQeHmBi+bNFihwhmHlldZN8WzDAR4gpetUKmxFPTOig3VYvbXPnuIvOUchzyRRAgAW0nIcVWwir+7nGUdxSrnxaRSb0XzqHzqYeva0Kr1bFAOn69m64bpm0Vm1dbCVBnreiZMimayJcEV4B4+AEy9TtDGp1WI+k0YHtrPU8a4DKjavcXQUoCheTvgQbZIv24mJ8Of2XQwfvUNRA8WhKXT/bDh4Uu7AQuC7seZzbJRCa64nVydLUNKkh1ouMFDiWV6hVRZTsZuAhvxe51U7w6hGDUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulduHYv9CZdNYvIBqQQvu0AZx6KmOHBaf6H5eBMFH3o=;
 b=LesZPc8E4rRZjbWItD/amdRMdJhQkZ+Ep4eaRC7zJdqcq9VNzaWsl/SVU0WB54tZxxv85lyknaHhW4EES4D27ZgtrgduMahYenyTzXoEiKP8z5Vm4PxcgfnPNjALe3yguIEy8h2sEeUPbVcSMlCFlNzjlu4YL6Dbq3++3IIgrA/dhXyNFDvukJ7A4PtjrkTqUnef5DUqEo6QflO+koKVMMMDkU6J5TxiL4C9NObH47KrKWTrgEOBJCsEd9zde8IkFmQY/qjgumfM/gKQMS5T2gFbDzSw1gc0WcErA/rPlXF9JRecDzjqV3yfGkUbFfSol+OjO+zFSymgjlEQnvUWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulduHYv9CZdNYvIBqQQvu0AZx6KmOHBaf6H5eBMFH3o=;
 b=QPGW6jD++i39OnHhDijBjhtxsKNNbGwJJWRdvJ4AiJzPOvILJQk8tcFdq27A3OjDLv4bTt2uLSrhw6rCs5JVU2hSv7jXTdUspspk+eqATRFBIoNgslQkMKOefIK25bJz7ax0dd0IV14902qr/Qyo5+PdTygTv6gvY4H/y099rhY=
Received: from BLAPR03CA0157.namprd03.prod.outlook.com (2603:10b6:208:32f::27)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 09:54:58 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::fb) by BLAPR03CA0157.outlook.office365.com
 (2603:10b6:208:32f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Tue,
 11 Feb 2025 09:54:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 09:54:58 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 03:54:55 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 11/18] cxl/region: Split region registration into an initialization and adding part
Date: Tue, 11 Feb 2025 10:53:41 +0100
Message-ID: <20250211095349.981096-12-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 66001b09-8268-4c6f-262a-08dd4a8224df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WGALT/LlId1eb/lY/If7NdGjZ0zEsrq0C0UC5W8srk1S/mTcaFH/at4o3YvO?=
 =?us-ascii?Q?FzznADhiIGvB8OAnl6AKSvQtirEhl1ngn1n0QSySPbcH/tp+UoWstUYg0ZV2?=
 =?us-ascii?Q?5js9WXLznYTeEAnHOEiOqA4AKT5hovnOEkb7FIsopSNI+RLPPRyhUlqL0Hrt?=
 =?us-ascii?Q?xzGnj+kJtLFIN8TgL7oSqNDXya5HiUns8gNAAwR7Z6J0Zh2OY+iTWy0sen1x?=
 =?us-ascii?Q?I15SLYHrj123ByHHkmAdqn0R2aIv1vd/En0cFKUvfaX4DlNn7mV3qmkDI773?=
 =?us-ascii?Q?i/rcHw8BmkK67TTj9oq04+KLmRJLystbt+GEjyt4PA24M2YE5Hsz4tgzEGA/?=
 =?us-ascii?Q?OseWpvDZJ7bbecoXOpJlMvjubRQcldHAhdq3QICrihiorpcXYJGv4RPz9v2+?=
 =?us-ascii?Q?QXwGwlQwvypjbF6Dl7EOKiytdItQmrkjj4dNUoQM5A1vpKIp2dWuH/5l1JH/?=
 =?us-ascii?Q?kPSMFUT47utaEl5tfvUE8ziF6gYwkRkwUqzU/WzC2vaTyDgPmnC2wo/C0xyC?=
 =?us-ascii?Q?QXJnhUjy/OmKnPouayG1nj99kn4BuJ09cwPS5rd5iOyqmVqR0cajcNjyIIkV?=
 =?us-ascii?Q?tRm/085z/q3PK7cBvgwXcZwIfvrMGrYfrU6MroFpUycglUGF1pJQqLT3aask?=
 =?us-ascii?Q?4geKbRCai921mDcNKVHFVtGlavh6L2hgvB5PqnbZAWhvzszCv6ur6HE91S75?=
 =?us-ascii?Q?p4Lfj5Exml6hEdiQsrSUuGzjJyvpwxzOS5D3a3EgXvqNITTZeXitsLSiZXO4?=
 =?us-ascii?Q?bC/1gUt0dCQxDv7YdKL46o9zPYPBWWqfo53AGFz2Y+GKYvBSPMwSQdcIUjJV?=
 =?us-ascii?Q?r47PfjmanPG88mR+p83Ov0YI+1tjZAu/3xlmXLZ4TuSit6OboTSLAf6GzU/X?=
 =?us-ascii?Q?GqOLwbAZTNcjVoIkhmKm72P2pbVyL/bAYlv1919//ikGJZahlasNu+urSpfX?=
 =?us-ascii?Q?2k0N6zXasos6eYaMjaX7kqKvLZvva6L61ZtbZRXjnyG0r3CsnPeIQCsXCtw5?=
 =?us-ascii?Q?JWJjG+n87miAhRE/fYmweR6wz2bocvYcSYNOn8LMhnHQnb69SiPUnLxK/t2k?=
 =?us-ascii?Q?/x5OoFUO0j7Knjo63DCBGu/WLH2Jt4AMvA8v9wXXB3DMrJdBp8LAA56ypAXj?=
 =?us-ascii?Q?5zb25nW6Xg5pvvHRf57qwfoLjbaGzKC2arRl6+JIJqTSRwyKA8rAnRBPWhBw?=
 =?us-ascii?Q?bdCyV40X4nWiPgR8K4EBODR1z82lPtZKF4TyZk8z6exhkRVV0GBm31WKwoOP?=
 =?us-ascii?Q?TpyB+/fc5F9sXGHQOl8fzWTpZcvjusGxGuSlp9bMc87oWmh5Pv4QjQgl9kJt?=
 =?us-ascii?Q?IwLOZUG7K9xOkakacCittAZNd023FUim7EkLB7PnFxdoPmm+lN6sFioFWSEi?=
 =?us-ascii?Q?XekiNaCfFv8ygilkU6nvgZekxTrnuhTAbrmj2gd1FoXjl3FqJmZ5Y1ZsR0O8?=
 =?us-ascii?Q?pDVfT1PYezkUUrbV80HpVnjqbsN/HV467v77kHXqArWOGt9FpGIn/Em1M3Of?=
 =?us-ascii?Q?DFdJ5cFEBRh+K8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 09:54:58.0505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66001b09-8268-4c6f-262a-08dd4a8224df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408

Before adding an endpoint to a region, the endpoint is initialized
first. Move that part to a new function
cxl_endpoint_decoder_initialize(). The function is in preparation of
adding more parameters that need to be determined in a setup.

The split also helps better separating the code. After initialization
the addition of an endpoint may fail with an error code and all the
data would need to be reverted to not leave the endpoint in an
undefined state. With separate functions the init part can succeed
even if the endpoint cannot be added.

Function naming follows the style of device_register() etc. Thus,
rename function cxl_add_to_region() to
cxl_endpoint_decoder_register().

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h         |  6 ++++--
 drivers/cxl/port.c        |  9 +++++----
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9ce0282c0042..fb43e154c7b9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3345,7 +3345,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 		dev_name(&cxlr->dev), p->res, p->interleave_ways,
 		p->interleave_granularity);
 
-	/* ...to match put_device() in cxl_add_to_region() */
+	/* ...to match put_device() in cxl_endpoint_decoder_add() */
 	get_device(&cxlr->dev);
 	up_write(&cxl_region_rwsem);
 
@@ -3357,19 +3357,28 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
-int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
+static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
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
+static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
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
@@ -3406,7 +3415,18 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	return rc;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
+
+int cxl_endpoint_decoder_register(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	rc = cxl_endpoint_decoder_initialize(cxled);
+	if (rc)
+		return rc;
+
+	return cxl_endpoint_decoder_add(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_register, "CXL");
 
 static int is_system_ram(struct resource *res, void *arg)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 85dfc8df0a80..50e7d878bb6f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -392,6 +392,7 @@ enum cxl_decoder_state {
  */
 struct cxl_endpoint_decoder {
 	struct cxl_decoder cxld;
+	struct cxl_root_decoder *cxlrd;
 	struct resource *dpa_res;
 	resource_size_t skip;
 	enum cxl_decoder_state state;
@@ -854,7 +855,7 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_port *port);
 #ifdef CONFIG_CXL_REGION
 bool is_cxl_pmem_region(struct device *dev);
 struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
-int cxl_add_to_region(struct cxl_endpoint_decoder *cxled);
+int cxl_endpoint_decoder_register(struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
@@ -865,7 +866,8 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 {
 	return NULL;
 }
-static inline int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
+static inline int
+cxl_endpoint_decoder_register(struct cxl_endpoint_decoder *cxled)
 {
 	return 0;
 }
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 74587a403e3d..36e487366c7a 100644
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
+	rc = cxl_endpoint_decoder_register(cxled);
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

