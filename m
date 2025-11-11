Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899B18A6B0
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897356; cv=fail; b=hP6qJo6mffj7l8rcSkko/UU4llNVnOwi/tMip598ZxjK5MinFhXw6BY+ZHaacyZl+pphL6oSaF407Fo6DLafyuxYxpkq/8aElu3kLPA2W5K9sVuVX5201Uky3lc/PdC7pY72M0kRB4JZdXQ8Noox3Gv2wwUN/ULy/3ftLeGTqlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897356; c=relaxed/simple;
	bh=oP4FmTEEupC1et7hgqQrY9h4bxdJYSTwOtLzfYQRIcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=an+MbD4l9aHjTRFHy8klLjmiAoQIeTYhOL3+OOpI0xn9fUpu1ZMKd50O//VF5x0zYbF6xPk3EI9LIo0CuLqPvjZmuHzNa/w/9ZlCtm5dHhkbEkGCrR2DCQPfbfnsAAE+3MF8lA/H3dJDVdQGVzcWBQHV2A5DyFywDiazLIIr6/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yST5v6qQ; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yST5v6qQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTn+9fblwoHV1CY7BU1Ch43UhgQIlWporHr8LBloOmlwEbcI+F08TWjPP2i3yzdYI9d2b6MfZ01/vf/xQD0fR4wN02aYFEsx5x2YNUttlHEipfH3maIumBoc68ThOsYGJh0TKqyWeoXnD0/1DU8ub5G7GkLyoCUyJdFkicMV2lVr9QXYeUCZkCjoED7OoFOQu1yLMc9aD8DCV653J+ZIIGmBWTjF+KDxgo4JSmwOTAG5BGpySCybcSbVcxHH6Ng6A62RT6NUJd0Dn4dnHSI9m4WrZdRBHygYJ3Ovp5oOoPDQiESPu2/cL/pcyDrWDk31CoDpbMPSem+Cr6HNXQLKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txQhLuBku7h04CxrEIxw19FpBA0xvpKMuxkuWMBc5L4=;
 b=IYYtyDGG1YXyWB6jjbkAVpLTo0c/JzPAP+TtQHokCSL4qWi7WtGSqTgpGtaUy9Pb/N8J4TOW8pGAcToN884F/TMSoo1lKYBB87ofDW3bREF3fZGslGpZxXUq5gDgZuTAegz0qQFvWCfv/LrH1cciW0B+dGv0IVr2iIVYDxbFCgCGhFqS/GpKK1pLsCBGgGnSWvxghXeO7dxYg4y9pCJa16J+7NI3iwxW7qVylkE13biRIMe2PaYIVbJ4jJSTi/KePY9nASxmhU/qQbKJGzVbmzTS1//1qgdwIho63O+BW8acKJS9hAPW2Oyko+qdzbtDv0jkryMrk/Y8Z+wrkpMNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txQhLuBku7h04CxrEIxw19FpBA0xvpKMuxkuWMBc5L4=;
 b=yST5v6qQqB3oA0LOHbvl/NPljhdq+Byq5qzXbeaVovcaldjJvv09//XHAgXPulbu/uoPhQwZS8oPh6BomBnVl4QbawBCGAFiQTvvqVjTTo49bwAtFJl6+3Wk5L0KDq9nm88Zaq6ZtTwM6/s/Sop8tJOrHLVALJmE/dcD+4tkpm0=
Received: from BL1PR13CA0366.namprd13.prod.outlook.com (2603:10b6:208:2c0::11)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:24 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c3) by BL1PR13CA0366.outlook.office365.com
 (2603:10b6:208:2c0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:42:24 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:42:24 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 08/17] cxl/core: Update devm_cxl_enumerate_ports()
Date: Tue, 11 Nov 2025 15:40:23 -0600
Message-ID: <20251111214032.8188-9-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9774b0-d27c-4434-0c64-08de216b33c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lOUhHfEoQ1ob6BDATjQiNGoPJwYUQ/T6Sq2b9a7n8l9vZIoxmRWDLaX2o1y?=
 =?us-ascii?Q?gpNa4bvvPREETnP4wsJcsERzg9FpLjKZcA0PqSw/lsH4jGqduE2An2xVZqdv?=
 =?us-ascii?Q?T/GKU4sd9d6wu7HxT3XDrIrB7CGnrbEpIFvtb0nqq3sGuNytbSa7aP6KO9kK?=
 =?us-ascii?Q?z2jLLhPExbJ4WXSuuHkgN0jHj5m7b17+H+3BwMOtZADU9j+7c+Xy2NYgp1Xo?=
 =?us-ascii?Q?7BVo/znaCUvFjPm/0Xsp/2Nmxwy5SmifbOWulsFYorMa7mpSTTfWLUfSn7cx?=
 =?us-ascii?Q?bsBBhrDYliFA1S96Nx8Ufjc5+I2hr+7tnZzgOzuG2nRojU9pUL70rXY6vca+?=
 =?us-ascii?Q?Zf4vgWjwDbruZqbjTFG9mQPUF0X5GoLrOahUWt/YgcLcWfT4IbUN+Z96f49j?=
 =?us-ascii?Q?dr/SqNN22pMCZF6lXXp3AHd+nmSelX2wLwbM4f5fFdI8QDVwdDOMDCBdNtKr?=
 =?us-ascii?Q?/37sIk3R3zzt9/5L0cP6dmp35B4Xd1igW7k3oQ9/iwNLzGy3870yysdNYKxS?=
 =?us-ascii?Q?pUwo/5NNAql1BtWlKzHGCd2e/Cn+Rwlz4PW25npMAmz6rKfVVY3OOB78/uME?=
 =?us-ascii?Q?5ahlUecbfVeiuADYFASGCnWfM1JQchxrA4oKwbPD6xS+QnIy8OVV664BR1GZ?=
 =?us-ascii?Q?g8JIrhRKCtqCpujFioDffUI6dDNFxLcZaCWdCiHIyPkUF7pSW+wb/prvvcvn?=
 =?us-ascii?Q?B5Ln+vI9GPMr/Kla8Q2zgPbcVQ6rdVvSmLqj1uOZAlaWifBgBkHfJxY166Yg?=
 =?us-ascii?Q?eCADesJc8ydTHXbJWx2sdU0qdF8+rLWtyll90PBWUchnNgLzG9sZWeyoeWXs?=
 =?us-ascii?Q?a8FSR3BoTcSmtJ64N6vnZEHVEpM35XdlYj5G7yFEOt8knK2KhfWJc9OTO8zv?=
 =?us-ascii?Q?4hTysGuaL7pgNJDpwHm5l2jEMNEZtf7M6zh2jgjRjIJe/KBI41PJgMUtcatN?=
 =?us-ascii?Q?Kh+cy5+eJ+10EOg/ya86TwqRKtQH+jEX+IokxmzKY1fkmkkP8SwAhrDv4rpx?=
 =?us-ascii?Q?pIqLOqekJrSxwpdV6MEPeubCM3oEY4/Pl9jeU9TOh0cr73tmNF/1a5ezZV60?=
 =?us-ascii?Q?umd6O2yY/HnArWoq0GJHK+y7J/BRj5kBmAO0hkqNZaRg6ztpM48fBsEIRgNZ?=
 =?us-ascii?Q?+Jvu1Zhtwpf78j1zPIEDunxQaJ83/CKgWPH+OgdkQm+mKb45Pr7HJbTwdUoe?=
 =?us-ascii?Q?54d3kTbxuf4gBjW6Tw/blhM6I10BPvLtJr5VSDC+wFv8yOOTQChht1foi+sU?=
 =?us-ascii?Q?vHadJqXYwso854OVv3hXYLVNUJZUAR/yuAtUUbduSnykXXgE57WpFapE6rwa?=
 =?us-ascii?Q?AzUA9gaWgQdIWj0J96+Rf/z+jFEUhnCQiApkvg+9y46HQ6IH3quPqEP2/Afz?=
 =?us-ascii?Q?J7jl81TQkSpTvzuupq1A0DdJHxG0b/2avYeJ1CyShG041n7+TLGL7CznNrjP?=
 =?us-ascii?Q?yWGyudeju2xD1iU9bfImJghx4tnI14waypry/mxSnmNfsLXhRGciWZtHYa+B?=
 =?us-ascii?Q?j7c2lECglicvTsRRxVeQjQ+T7vLqepFbYHN7DFFDNsJrfo15s5jvZZU39lmy?=
 =?us-ascii?Q?D1sDkcZ9SpwZMb91SXc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:24.6762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9774b0-d27c-4434-0c64-08de216b33c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190

Update devm_cxl_enumerate_ports() to handle cxl_cachedev devices. After
this commit cxl_cachedev's will be added to the CXL port hierarchy, but
immediately fail endpoint port probe.

Endpoint port probe will be updated to allow cxl cache devices in a
following commit.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     |  16 ++++++
 drivers/cxl/core/port.c | 109 ++++++++++++++++++++++++++--------------
 drivers/cxl/cxl.h       |   3 +-
 drivers/cxl/mem.c       |   2 +-
 drivers/cxl/port.c      |   3 ++
 5 files changed, 94 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 6f410fae9437..630452d53acc 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -56,6 +56,22 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
 
 static int cxl_cache_probe(struct device *dev)
 {
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
+	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct cxl_dport *dport;
+	int rc;
+
+	rc = devm_cxl_enumerate_ports(dev, cxlds);
+	if (rc)
+		return rc;
+
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		cxl_dev_find_port(dev, &dport);
+	if (!parent_port) {
+		dev_err(dev, "CXL port topology not found\n");
+		return -ENXIO;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2cccce49e3b4..e79ec29d0bb6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -844,6 +844,45 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
+static bool is_cxl_ep_device(struct device *dev)
+{
+	return is_cxl_memdev(dev) || is_cxl_cachedev(dev);
+}
+
+static int cxl_port_setup_endpoint(struct cxl_port *port)
+{
+	struct device *uport_dev = port->uport_dev;
+	struct cxl_dev_state *cxlds;
+	struct cxl_cachedev *cxlcd;
+	struct cxl_memdev *cxlmd;
+	int rc;
+
+	rc = dev_set_name(&port->dev, "endpoint%d", port->id);
+	if (rc)
+		return rc;
+
+	/*
+	 * The endpoint driver already enumerated the component and RAS
+	 * registers. Reuse that enumeration while prepping them to be
+	 * mapped by the cxl_port driver.
+	 */
+	if (is_cxl_memdev(uport_dev)) {
+		cxlmd = to_cxl_memdev(uport_dev);
+		cxlds = cxlmd->cxlds;
+
+		cxlmd->endpoint = port;
+	} else {
+		cxlcd = to_cxl_cachedev(uport_dev);
+		cxlds = cxlcd->cxlds;
+
+		cxlcd->endpoint = port;
+	}
+
+	port->reg_map = cxlds->reg_map;
+	port->reg_map.host = &port->dev;
+	return 0;
+}
+
 static int cxl_port_add(struct cxl_port *port,
 			resource_size_t component_reg_phys,
 			struct cxl_dport *parent_dport)
@@ -851,22 +890,10 @@ static int cxl_port_add(struct cxl_port *port,
 	struct device *dev __free(put_device) = &port->dev;
 	int rc;
 
-	if (is_cxl_memdev(port->uport_dev)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
-		struct cxl_dev_state *cxlds = cxlmd->cxlds;
-
-		rc = dev_set_name(dev, "endpoint%d", port->id);
+	if (is_cxl_ep_device(port->uport_dev)) {
+		rc = cxl_port_setup_endpoint(port);
 		if (rc)
 			return rc;
-
-		/*
-		 * The endpoint driver already enumerated the component and RAS
-		 * registers. Reuse that enumeration while prepping them to be
-		 * mapped by the cxl_port driver.
-		 */
-		port->reg_map = cxlds->reg_map;
-		port->reg_map.host = &port->dev;
-		cxlmd->endpoint = port;
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
@@ -1603,7 +1630,8 @@ static int update_decoder_targets(struct device *dev, void *data)
 
 DEFINE_FREE(del_cxl_dport, struct cxl_dport *, if (!IS_ERR_OR_NULL(_T)) del_dport(_T))
 static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
-					    struct device *dport_dev)
+					    struct device *dport_dev,
+					    struct device *ep_dev)
 {
 	struct cxl_dport *dport;
 	int rc;
@@ -1624,6 +1652,10 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 	if (IS_ERR(new_dport))
 		return new_dport;
 
+	/* CXL.cache devices aren't expected to have HDM decoders */
+	if (ep_dev && is_cxl_cachedev(ep_dev))
+		return no_free_ptr(new_dport);
+
 	cxl_switch_parse_cdat(new_dport);
 
 	if (ida_is_empty(&port->decoder_ida)) {
@@ -1655,9 +1687,10 @@ static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
 	device_lock_assert(&parent_port->dev);
 	if (!parent_port->dev.driver) {
 		dev_warn(ep_dev,
-			 "port %s:%s:%s disabled, failed to enumerate CXL.mem\n",
+			 "port %s:%s:%s disabled, failed to enumerate CXL.%s\n",
 			 dev_name(&parent_port->dev), dev_name(uport_dev),
-			 dev_name(dport_dev));
+			 dev_name(dport_dev),
+			 is_cxl_memdev(ep_dev) ? "mem" : "cache");
 	}
 
 	struct cxl_port *port __free(put_cxl_port) =
@@ -1688,10 +1721,10 @@ static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
 	}
 
 	guard(device)(&port->dev);
-	return cxl_port_add_dport(port, dport_dev);
+	return cxl_port_add_dport(port, dport_dev, ep_dev);
 }
 
-static int add_port_attach_ep(struct cxl_memdev *cxlmd,
+static int add_port_attach_ep(struct device *ep_dev,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
 {
@@ -1705,8 +1738,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 * CXL-root 'cxl_port' on a previous iteration, fail for now to
 		 * be re-probed after platform driver attaches.
 		 */
-		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
-			dev_name(dport_dev));
+		dev_dbg(ep_dev, "%s is a root dport\n", dev_name(dport_dev));
 		return -ENXIO;
 	}
 
@@ -1720,12 +1752,13 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	scoped_guard(device, &parent_port->dev) {
 		parent_dport = cxl_find_dport_by_dev(parent_port, dparent);
 		if (!parent_dport) {
-			parent_dport = cxl_port_add_dport(parent_port, dparent);
+			parent_dport = cxl_port_add_dport(parent_port, dparent,
+							  ep_dev);
 			if (IS_ERR(parent_dport))
 				return PTR_ERR(parent_dport);
 		}
 
-		dport = devm_cxl_create_port(&cxlmd->dev, parent_port,
+		dport = devm_cxl_create_port(ep_dev, parent_port,
 					     parent_dport, uport_dev,
 					     dport_dev);
 		if (IS_ERR(dport)) {
@@ -1736,7 +1769,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		}
 	}
 
-	rc = cxl_add_ep(dport, &cxlmd->dev);
+	rc = cxl_add_ep(dport, ep_dev);
 	if (rc == -EBUSY) {
 		/*
 		 * "can't" happen, but this error code means
@@ -1756,7 +1789,7 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
 	device_lock_assert(&port->dev);
 	dport = cxl_find_dport_by_dev(port, dport_dev);
 	if (!dport) {
-		dport = cxl_port_add_dport(port, dport_dev);
+		dport = cxl_port_add_dport(port, dport_dev, NULL);
 		if (IS_ERR(dport))
 			return dport;
 
@@ -1767,9 +1800,8 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
 	return dport;
 }
 
-int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
+int devm_cxl_enumerate_ports(struct device *ep_dev, struct cxl_dev_state *cxlds)
 {
-	struct device *dev = &cxlmd->dev;
 	struct device *iter;
 	int rc;
 
@@ -1777,12 +1809,15 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	 * Skip intermediate port enumeration in the RCH case, there
 	 * are no ports in between a host bridge and an endpoint.
 	 */
-	if (cxlmd->cxlds->rcd)
+	if (cxlds->rcd)
 		return 0;
 
-	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
-	if (rc)
-		return rc;
+	if (is_cxl_memdev(ep_dev)) {
+		rc = devm_add_action_or_reset(ep_dev, cxl_detach_ep,
+					      to_cxl_memdev(ep_dev));
+		if (rc)
+			return rc;
+	}
 
 	/*
 	 * Scan for and add all cxl_ports in this device's ancestry.
@@ -1790,7 +1825,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	 * attempt fails.
 	 */
 retry:
-	for (iter = dev; iter; iter = grandparent(iter)) {
+	for (iter = ep_dev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
 		struct cxl_dport *dport;
@@ -1800,18 +1835,18 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
 		uport_dev = dport_dev->parent;
 		if (!uport_dev) {
-			dev_warn(dev, "at %s no parent for dport: %s\n",
+			dev_warn(ep_dev, "at %s no parent for dport: %s\n",
 				 dev_name(iter), dev_name(dport_dev));
 			return -ENXIO;
 		}
 
-		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
+		dev_dbg(ep_dev, "scan: iter: %s dport_dev: %s parent: %s\n",
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
 		struct cxl_port *port __free(put_cxl_port) =
 			find_cxl_port_by_uport(uport_dev);
 		if (port) {
-			dev_dbg(&cxlmd->dev,
+			dev_dbg(ep_dev,
 				"found already registered port %s:%s\n",
 				dev_name(&port->dev),
 				dev_name(port->uport_dev));
@@ -1829,7 +1864,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 				}
 			}
 
-			rc = cxl_add_ep(dport, &cxlmd->dev);
+			rc = cxl_add_ep(dport, ep_dev);
 
 			/*
 			 * If the endpoint already exists in the port's list,
@@ -1850,7 +1885,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			return 0;
 		}
 
-		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
+		rc = add_port_attach_ep(ep_dev, uport_dev, dport_dev);
 		/* port missing, try to add parent */
 		if (rc == -EAGAIN)
 			continue;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5ef0fb71af91..6c7b8278bec3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -885,7 +885,8 @@ DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
-int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
+int devm_cxl_enumerate_ports(struct device *ep_dev,
+			     struct cxl_dev_state *cxlds);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index d12c96b68c82..3b230f8c5925 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -104,7 +104,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = devm_cxl_enumerate_ports(cxlmd);
+	rc = devm_cxl_enumerate_ports(dev, cxlds);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c2fbdbfe0b6b..efea9b04b323 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -74,6 +74,9 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	int rc;
 
+	if (!is_cxl_memdev(port->uport_dev))
+		return -EOPNOTSUPP;
+
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
 	cxl_endpoint_parse_cdat(port);
-- 
2.51.1

