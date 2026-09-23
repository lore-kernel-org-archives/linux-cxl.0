Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446C2D6E64
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184844; cv=fail; b=CXPURHT5F/ihzN2N1F2iXD1bP0LF88auEJZMMYsZO9Z6BBE0EsQjvpeAC+pmhdVuU+EFYmzVLaqeVP3wbEHPD3jO4AifM8hhEnmBie5THwxErMZ5YeaksxS4Iv34O9bGFTadxeV7CeZFT6MopDdl1YexggL9Q/nDDc94qNS5+ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184844; c=relaxed/simple;
	bh=n/mpCoTqtvmsqxf0Xi/zHK+OQ6HmOoLFVB65urkn2lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxcKnroD22z2bLdO47Ur+8nWuERGj/wu81mMVxE/UGMOIlO13E7NE3J1pYuQkfXXqBTH3S2FA4gdgJRnzzkzBS/L2RBDbxDoJm2G2f7azuP0LY69ZibBZQ33flMy4XGCCjNI8/xs2gJGCg6mRPGoiZESx0XZrVgmPdKoeyrujIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kMQXmEv6; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kMQXmEv6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rS867WNivUsc/d6esqQMRfMNPH+7TAcUfYtum+vbz14qNSaPRyt6OitGbGVQamanbaJ3Gl7G0HIM36Oe+J9LR+d9z7u+hT358N3VV60XmGu3WaEF7/flTcpsMKamI0VkjUc0Tk/PU0KycilD2RXG2SEJ8d2ajTjh440wXu7w2TqsPAGkyH4r5DqgUTACdArRJPJkBzSn0Jy1p7i9rkllr+CYyjVYhhH22MwrCZQtdFAXl8l+ssLNa8m8e2pmYXZMzfbToL0yggf1qVn7iAhliMb81+NmPK83JgaDZqpFhdU93U4nAHJ7a04XwNS9J7qfmB0JUTrunP5BJR4rA1kLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66usyFU3S3exijZSLhcKvmBBMohPNjP+DgeXcLd6yUU=;
 b=bLO3KJJND5Xal/7erFeviU6E2tj2DRGx59Y6eMYBbuoMVEPqDsuuqky/T3wfjd5ilt/xpyO3B+S8dcs5Q3vFJAzdx8cQjsfQy6x7zx68CTRGVuA7xUvOfM2CO2sk2sqxTPYGw3jNPMguJkPwIZWLY6putnZ8MZt/sJarj0PgiCMmtr5sQ4CyNsa3vMDacUmuOpFIqBlM05PaWbfNszvaEiPVMY3fr1Eer00TIAFPNM7Yee/xJ3WcdlbV/yfZvOWB1HHMPZk2rfaBguDiJ/JP1GhlJtdS2b7kJvG/5Lu7xWo+r3x6lY/94iFGagXGvMS7m2vY+bHBmhnIx2+iJ/d2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66usyFU3S3exijZSLhcKvmBBMohPNjP+DgeXcLd6yUU=;
 b=kMQXmEv6O8IJ48Tq4vIHx+gmcaz92rBu1ama9fnnBPUKdXQ3uPCMAaIRPZDZcKrISreiA0FaNvlgc7qa4GvdvRbc/KCJ49jv3HiKdOGJru8GPPcKUMLKzaYQ/biI41VmOQ99L0u8+LdrsjugvVHFwEKE9QSA6sDwm/FQ9k6NAuc=
Received: from CH0PR03CA0297.namprd03.prod.outlook.com (2603:10b6:610:e6::32)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 23 Sep
 2026 17:33:53 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::16) by CH0PR03CA0297.outlook.office365.com
 (2603:10b6:610:e6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 17:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:52 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:51 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 04/15] cxl/core: Update devm_cxl_enumerate_ports() for cxl_cachedevs
Date: Wed, 23 Sep 2026 12:33:31 -0500
Message-ID: <20260923173342.5584-5-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d362bef-373d-490f-0cda-08df1998d625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7YvOFv9XGsnDi70mrwY8yzwcu5rkLNUP8xRm3NhFEHFpchus5khczm6j1uYa1N/HrJeGtvPCYdKyJfh23qZK5lIO+bRewzIWm5XcyeXdcwGT41+opK31a3BFig2esZb28POSmEM3oSeVwPO9KNZ69i3OgL+FH2ie9NyU3LFYL/TWbMUOLCoseMsU8IrdoUAJt/2ySotOVSeDNVY081DvfJwXAB3GCkONuDqZ/qIViWL8ttBU4c9Sq7A6wkHRGdMFQuH+QXLKERPlwDAXPlD3D6mIql5/0+qx8B9JuCi6/miNq6YmMZkXDW0BPzyciHdJ1H0I8PBNs12pSgEqopjNDgy0z6qlDaQpblUMKl3t+B2kIzgzInePK+vQQ7wSQ9fOCQ5S+Af2cZqZ3BvympJqPgyVMDeCWAPTkf0pI27dwrO3gGPF4NVdy+uhdMQsk7wfDjzaArPhOtqwwg5gaG9gq3ihVd1D5OaFoG8exrzd41zU7FXG4Ms+2B5x0eI9J+kuFkW/SbYRt4/diBvMx8BLHMCMxNyT9axeQ6IaTNpl7BvlUqalI5MGNTJfxPAL+mfGKBJxP6wdJMpYtYsE9ZNaLH03jcq1vZnp0fMOZvYmgrsKYnAxdB7TjraT77vn4eOMtDpD6ewqYC980Jx9RpEjqO8Cpi7IfbM1vWQAVhimI00bDne7KuvY7/uuOJlCJ2mVJ/NatCDo2IWjEH24y7lLxA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qT4UVaXne3UJ/20Viq3nh+u7qPLvQ0chBLsBaEScpDSw/a3VCxCXlmkg7zEPDiJT/v4u5MGApsQsYfBvJixTh7MLqGUQ0wM2jM/k+J2eyC3sH85b0CjlOKhPu/vFxAWIR29ZEKrbM9kYK1VrhY8MFDbUDRSUirJBP0XWZ7PBHX3ZiHB/0QCOL+avOI9wtawML/ODCauFIxk/9OkQkYumf69flyF+FMzqbmeYl2x23krjrzQymFyHQ+Bm/ocOaTDAqBS5CYzZxh9A6crR/05xwHdNdtvSw4+663qk2+D2HNPaxZC4z++3w4WJ3D9zQphQQhKQY8wCnusEk3SvqVSpZ5Or7Bim+mTHX8cPFeRIarPRuGggSjh7n+qB7Yy1ZxzfnQ7Ix8WOaAe34o3V0NIEBfSZuhE5UpCA8BhRvRFw7rTO8acHGYBUeH05SxTWlbTE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:52.7513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d362bef-373d-490f-0cda-08df1998d625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

Update devm_cxl_enumerate_ports() to use a struct device pointer instead
of struct cxl_memdev pointer to prepare for adding cxl_cachedevs to the
port hierarchy.

No functional change intended.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c | 95 ++++++++++++++++++++++++++++-------------
 drivers/cxl/cxl.h       |  2 +-
 drivers/cxl/mem.c       |  2 +-
 3 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6181ec730ec2..506461d5db22 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -839,6 +839,28 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
+static struct cxl_dev_state *cxl_ep_to_cxlds(struct device *ep_dev)
+{
+	if (is_cxl_memdev(ep_dev))
+		return to_cxl_memdev(ep_dev)->cxlds;
+
+	if (is_cxl_cachedev(ep_dev))
+		return to_cxl_cachedev(ep_dev)->cxlds;
+
+	return NULL;
+}
+
+static struct cxl_port **cxl_ep_get_endpoint_port(struct device *ep_dev)
+{
+	if (is_cxl_memdev(ep_dev))
+		return &to_cxl_memdev(ep_dev)->endpoint;
+
+	if (is_cxl_cachedev(ep_dev))
+		return &to_cxl_cachedev(ep_dev)->endpoint;
+
+	return NULL;
+}
+
 static int cxl_port_add(struct cxl_port *port,
 			resource_size_t component_reg_phys,
 			struct cxl_dport *parent_dport)
@@ -846,9 +868,10 @@ static int cxl_port_add(struct cxl_port *port,
 	struct device *dev __free(put_device) = &port->dev;
 	int rc;
 
-	if (is_cxl_memdev(port->uport_dev)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
-		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	if (is_cxl_memdev(port->uport_dev) ||
+	    is_cxl_cachedev(port->uport_dev)) {
+		struct cxl_dev_state *cxlds = cxl_ep_to_cxlds(port->uport_dev);
+		struct cxl_port **endpoint = cxl_ep_get_endpoint_port(port->uport_dev);
 
 		rc = dev_set_name(dev, "endpoint%d", port->id);
 		if (rc)
@@ -861,7 +884,7 @@ static int cxl_port_add(struct cxl_port *port,
 		 */
 		port->reg_map = cxlds->reg_map;
 		port->reg_map.host = &port->dev;
-		cxlmd->endpoint = port;
+		*endpoint = port;
 	} else if (parent_dport) {
 		rc = dev_set_name(dev, "port%d", port->id);
 		if (rc)
@@ -1488,11 +1511,11 @@ static void del_dports(struct cxl_port *port)
 }
 
 struct detach_ctx {
-	struct cxl_memdev *cxlmd;
+	struct device *ep_dev;
 	int depth;
 };
 
-static int port_has_memdev(struct device *dev, const void *data)
+static int port_has_ep_dev(struct device *dev, const void *data)
 {
 	const struct detach_ctx *ctx = data;
 	struct cxl_port *port;
@@ -1504,24 +1527,33 @@ static int port_has_memdev(struct device *dev, const void *data)
 	if (port->depth != ctx->depth)
 		return 0;
 
-	return !!cxl_ep_load(port, &ctx->cxlmd->dev);
+	return !!cxl_ep_load(port, ctx->ep_dev);
+}
+
+static int cxl_ep_get_depth(struct device *ep_dev)
+{
+	if (is_cxl_memdev(ep_dev))
+		return to_cxl_memdev(ep_dev)->depth;
+	else
+		return to_cxl_cachedev(ep_dev)->depth;
 }
 
 static void cxl_detach_ep(void *data)
 {
-	struct cxl_memdev *cxlmd = data;
+	struct device *ep_dev = data;
+	int depth = cxl_ep_get_depth(ep_dev);
 
-	for (int i = cxlmd->depth - 1; i >= 1; i--) {
+	for (int i = depth - 1; i >= 1; i--) {
 		struct cxl_port *port, *parent_port;
 		struct detach_ctx ctx = {
-			.cxlmd = cxlmd,
+			.ep_dev = ep_dev,
 			.depth = i,
 		};
 		struct cxl_ep *ep;
 		bool died = false;
 
 		struct device *dev __free(put_device) =
-			bus_find_device(&cxl_bus_type, NULL, &ctx, port_has_memdev);
+			bus_find_device(&cxl_bus_type, NULL, &ctx, port_has_ep_dev);
 		if (!dev)
 			continue;
 		port = to_cxl_port(dev);
@@ -1529,8 +1561,8 @@ static void cxl_detach_ep(void *data)
 		parent_port = to_cxl_port(port->dev.parent);
 		device_lock(&parent_port->dev);
 		device_lock(&port->dev);
-		ep = cxl_ep_load(port, &cxlmd->dev);
-		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
+		ep = cxl_ep_load(port, ep_dev);
+		dev_dbg(ep_dev, "disconnect %s from %s\n",
 			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
 		cxl_ep_remove(port, ep);
 		if (ep && !port->dead && xa_empty(&port->endpoints) &&
@@ -1547,7 +1579,7 @@ static void cxl_detach_ep(void *data)
 		device_unlock(&port->dev);
 
 		if (died) {
-			dev_dbg(&cxlmd->dev, "delete %s\n",
+			dev_dbg(ep_dev, "delete %s\n",
 				dev_name(&port->dev));
 			delete_switch_port(port);
 		}
@@ -1582,8 +1614,8 @@ static int match_port_by_uport(struct device *dev, const void *data)
 		return 0;
 
 	port = to_cxl_port(dev);
-	/* Endpoint ports are hosted by memdevs */
-	if (is_cxl_memdev(port->uport_dev))
+	/* Endpoint ports are hosted by memdevs or cachedevs */
+	if (is_cxl_memdev(port->uport_dev) || is_cxl_cachedev(port->uport_dev))
 		return uport_dev == port->uport_dev->parent;
 	return uport_dev == port->uport_dev;
 }
@@ -1722,7 +1754,7 @@ static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
 	return probe_dport(port, dport_dev);
 }
 
-static int add_port_attach_ep(struct cxl_memdev *cxlmd,
+static int add_port_attach_ep(struct device *ep_dev,
 			      struct device *uport_dev,
 			      struct device *dport_dev)
 {
@@ -1736,7 +1768,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 * CXL-root 'cxl_port' on a previous iteration, fail for now to
 		 * be re-probed after platform driver attaches.
 		 */
-		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
+		dev_dbg(ep_dev, "%s is a root dport\n",
 			dev_name(dport_dev));
 		return -ENXIO;
 	}
@@ -1756,7 +1788,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 				return PTR_ERR(parent_dport);
 		}
 
-		dport = devm_cxl_create_port(&cxlmd->dev, parent_port,
+		dport = devm_cxl_create_port(ep_dev, parent_port,
 					     parent_dport, uport_dev,
 					     dport_dev);
 		if (IS_ERR(dport)) {
@@ -1767,7 +1799,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		}
 	}
 
-	rc = cxl_add_ep(dport, &cxlmd->dev);
+	rc = cxl_add_ep(dport, ep_dev);
 	if (rc == -EBUSY) {
 		/*
 		 * "can't" happen, but this error code means
@@ -1807,20 +1839,23 @@ static struct cxl_dport *find_or_add_dport(struct cxl_port *port,
 	return dport;
 }
 
-int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
+int devm_cxl_enumerate_ports(struct device *ep_dev)
 {
-	struct device *dev = &cxlmd->dev;
+	struct cxl_dev_state *cxlds = cxl_ep_to_cxlds(ep_dev);
 	struct device *iter;
 	int rc;
 
+	if (!cxlds)
+		return -EINVAL;
+
 	/*
 	 * Skip intermediate port enumeration in the RCH case, there
 	 * are no ports in between a host bridge and an endpoint.
 	 */
-	if (cxlmd->cxlds->rcd)
+	if (cxlds->rcd)
 		return 0;
 
-	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
+	rc = devm_add_action_or_reset(ep_dev, cxl_detach_ep, ep_dev);
 	if (rc)
 		return rc;
 
@@ -1830,7 +1865,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	 * attempt fails.
 	 */
 retry:
-	for (iter = dev; iter; iter = grandparent(iter)) {
+	for (iter = ep_dev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
 		struct cxl_dport *dport;
@@ -1840,18 +1875,18 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 
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
@@ -1867,7 +1902,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 				return PTR_ERR(dport);
 			}
 
-			rc = cxl_add_ep(dport, &cxlmd->dev);
+			rc = cxl_add_ep(dport, ep_dev);
 
 			/*
 			 * If the endpoint already exists in the port's list,
@@ -1888,7 +1923,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			return 0;
 		}
 
-		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
+		rc = add_port_attach_ep(ep_dev, uport_dev, dport_dev);
 		/* port missing, try to add parent */
 		if (rc == -EAGAIN)
 			continue;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 72d2686a408b..7d369030198a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -744,7 +744,7 @@ DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
-int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
+int devm_cxl_enumerate_ports(struct device *epdev);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 798e5c369cfc..b18dcce2e8a6 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -128,7 +128,7 @@ static int cxl_mem_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	rc = devm_cxl_enumerate_ports(cxlmd);
+	rc = devm_cxl_enumerate_ports(&cxlmd->dev);
 	if (rc)
 		return rc;
 
-- 
2.53.0

