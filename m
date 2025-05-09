Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57850235045;
	Fri,  9 May 2025 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746803273; cv=fail; b=ToOvUJOJSEwr5EsaTb4PntJv+GwCmrcoqnyW6S0Pi66OS20j+Wvm7Ez+FiezvjAX55MV9Oc3oPN/WanD+qNtVqhBGNTGMRq423DKbFl2pduCkwai0zbaSjBLimm6MOnEdjjEBwrW8sZp+q6hEOyN77PYkCGPcHaWHJR6Fsh/xXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746803273; c=relaxed/simple;
	bh=iHKB39RozHFi/4Func1QyUEN7cQ8diRjz4oBAbrTJZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TICQQZLWY0UAqiMAWYKm7ysJZckTGcqIwskC4O/PX3d5sjjDL0V08si8VaNx9M9bgxSgjTVS8oX+cP6nfPHFKJftT0CCzh9vvcyjjfnU8plqFlrAH3ukR19E0rzwAhekgK0tmjlPO+Q3wjB1sqYjEO+yvEzhXu9e8va4ynbAS/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j7VXMX9L; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j7VXMX9L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvrmZkGwwutSg8cHa+ry2nQHQv7fgABnkYvMAlJU7Sh1ogK204WQtASWaVRuper4jWIiibrpbxX7hV975tugEDemQz5/wV27BQ96DyGvm6uGzAycx6nPKRDMbP2GYM1kTHYXf4iy0Si+X6R9ZC0yp1aZPe3hvnnMF+P0wyj1zoUSJgnJgq5hJB0Bb4zF22h06clqSdjmAu4/raiNoZXILuPiNC9kzJeNjX/O+AooqUrwZBVCafIJglXdX49Z+VZDI/ndd9z1YFJSoxkZfHGNNyMFt3xedOpMyfLGMo1lRpkQpUa1dVzV+kMWVDxo9fkYd1DXaV1L+zOVhNd5UqoAAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmlKz4hckGSzi3kwzs0r9t474z4ZZSc5gHasoxqN2hk=;
 b=ayYx5tvT13GwCf5yGT28BHrr1cCVl/+idsHmkXu3Rcpm+7CtrtsYJcwZp1X1hjQU31nx7rEft8kyoE+S1r+X1Pnn7QuSx7IWLejn1zhFHkZBNT5dptgJzwfKiDiRV/aE1Q/3cYqsc/xk4I/0iT+p+N2D1uKmXINKpt5VlRMmtqFYvr5ou23YEPhieKKOhORHhvaAAywScdiCL7Ac+eKfPBGwnYZsHPB7CyAE9QUCWebR9umkP1V3KUXcj9hO2mun1PPdZGQNXlPX+PJepLpMo0yY8zNWCk0mZtxbLDb8x3n/+0Ri3TiE0wGlStv0g18XTFLc1xOy504YIKCqrq7cIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmlKz4hckGSzi3kwzs0r9t474z4ZZSc5gHasoxqN2hk=;
 b=j7VXMX9LN9Y9AbkY/KNhaIxsAsKI359qzGYbYlJ/c1g4byOhQRCi5XjdvI0wXtbNH9Bq6kMWpVH/rf+H/r8jxX+wn8I51iHFdX7VMpWhQCsPkK4vitvk/YSSNeV+FTHFWQj/vRuTv12q+JyVsQuFg1ow/BQjoY1tYtflLAF1JXI=
Received: from BN9PR03CA0953.namprd03.prod.outlook.com (2603:10b6:408:108::28)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 15:07:47 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::76) by BN9PR03CA0953.outlook.office365.com
 (2603:10b6:408:108::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Fri,
 9 May 2025 15:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 15:07:47 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 10:07:44 -0500
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 03/14] cxl/pci: Add comments to cxl_hdm_decode_init()
Date: Fri, 9 May 2025 17:06:48 +0200
Message-ID: <20250509150700.2817697-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509150700.2817697-1-rrichter@amd.com>
References: <20250509150700.2817697-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b096d34-13fc-4672-52ce-08dd8f0b420f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IYCeXnd07HGdVJJcJuLsbMIOoLOoKh2e1Kd891ihJm+n7sPRGab9EeQRvm2L?=
 =?us-ascii?Q?M40Q4j/GSGZ0/pt9Pfu+RJ1Mi4Fada/jSlqBjo0IDIiz7Rug8N4lx0/VEi4o?=
 =?us-ascii?Q?ZVt9Ux97YqvXyX9gq7987j9NWJBCLjDZ0ZiLmto5g4w8NC1ZEggXOEreGetM?=
 =?us-ascii?Q?IdDkLbIGJ5HdcemOC5se7PGAHIBeCGxP/8QGT5Z8GWLk3BvOljz0Vs/m+miC?=
 =?us-ascii?Q?KJxdYi123WaO3hNmyqrZpIH//JV5oRbaTUWpRr+IDbBEhezYUKki8X2XcQkm?=
 =?us-ascii?Q?x0LN4CCvRWsZPHJHmNoNOF78xSmQFaCkWqaKe8YR3TOxEqQwQSTQwmXaBdln?=
 =?us-ascii?Q?QTWPgISA2oah/bGZYsnZReu0Lg31Zydm/uuWN/VD386dpnzoQxS7g2V1uIBL?=
 =?us-ascii?Q?OaE5yoBlqxK1pu4IaInhKHR0Yvo2gN4JY329qhjBlpF9UplX7TzO4vCOnNRJ?=
 =?us-ascii?Q?jm4PVagpsSI2hAZo583z1J3dkxQy5Au3SVnmKsE4As68VtqcnajkYDGGqT2j?=
 =?us-ascii?Q?rmcdIPjni7zs4lVNGdU7sl0eIVRUwrbTO7K6itGGC49Znbu1lLpxgZt9BshN?=
 =?us-ascii?Q?kw6/jmSSqxydUUrYM6isw6+AixbbW8fTFagSaPTogqHO8n/M8fU+tACwFT/r?=
 =?us-ascii?Q?hq0pULk5ku3Ip2D8KeVHmQ5G5d8IWX10p1GDtz3Aoz84g++3KFQpNkvY/0zM?=
 =?us-ascii?Q?54jVnVKFrhM3vvuYEY+pV9QSSh4PcMC657o5Pe3ITTdJerZJXhz3PzUZ7OjH?=
 =?us-ascii?Q?85fSl8WlgZ16eYDIwAUS2I8jjeJDdQu2dd89NPVNWFJmUZ0iqb/Kygn0ehzX?=
 =?us-ascii?Q?juS2XeCXeIUKrDJQ9dIhI9bjGLr8SjtkcQk+UorlTA4MX8rUgBZ8Afq45k3D?=
 =?us-ascii?Q?IPrXuapUv6VC07LYXzv2DzAHw7sf5ToX1jI3MwyzIJa6HMVj2X6Qvl9KU6DC?=
 =?us-ascii?Q?6qkIwnfyTDKtD/LVId6miAmO/HG+ZeXfc9zNzhYQEJOwMhnukbD/fOASJrh4?=
 =?us-ascii?Q?6QqNfDQxTcJ53c+wTYjqT051ryJTqVxiHeu25mR8Si7DSmo9PFA8wCry5QsX?=
 =?us-ascii?Q?mtjuK2c0Y9MxMYmMmWvlRAdGmzEETF76UbT++CKgnXXcNdZJHfne3d3/Fsd/?=
 =?us-ascii?Q?UeKSLKcr+4ETM9Liz1pKxI2oaJTdQCiDTpNzrvFAbg63cDzvKHIiVDjSdfES?=
 =?us-ascii?Q?wh8kEohfoTRmsCVDaE4ao5x/VElFP0o+bFbo38o3+bueB7tNYfJNqLCPryrD?=
 =?us-ascii?Q?P0yXC1kO+fyvOb5OJplpSRrgUfiXhVaTWNnBf2VY59k3e6qxs34lSjNpx9Lg?=
 =?us-ascii?Q?mN6hlPw2/Kf3kYYEjGzcOnuvTNh1uoEdywAQNPGwQMrsZldQSzL/5WWTBla0?=
 =?us-ascii?Q?7+kWWRrKzFVSTOc/KCotkysiJeD1QQF5xK8Pj7h9SeChSZvOrW2aBM8D5Mnn?=
 =?us-ascii?Q?VlWsW14JFvE6INwKbmQYcOhv2mJZnYKljKEcPQELykJ2j9Gj1jTZ/ior85rh?=
 =?us-ascii?Q?ulZwE4t2CmRx3hnzdKM+HclH2pYWII0UDXEC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:07:47.1738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b096d34-13fc-4672-52ce-08dd8f0b420f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607

There are various configuration cases of HDM decoder registers causing
different code paths. Add comments to cxl_hdm_decode_init() to better
explain them.

Signed-off-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/pci.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 159674c1c71f..b50551601c2e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -416,9 +416,19 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (global_ctrl & CXL_HDM_DECODER_ENABLE || (!hdm && info->mem_enabled))
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 
+	/*
+	 * If the HDM Decoder Capability does not exist and DVSEC was
+	 * not setup, the DVSEC based emulation cannot be used.
+	 */
 	if (!hdm)
 		return -ENODEV;
 
+	/* The HDM Decoder Capability exists but is globally disabled. */
+
+	/*
+	 * If the DVSEC CXL Range registers are not enabled, just
+	 * enable and use the HDM Decoder Capability registers.
+	 */
 	if (!info->mem_enabled) {
 		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 		if (rc)
@@ -427,6 +437,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return devm_cxl_enable_mem(&port->dev, cxlds);
 	}
 
+	/*
+	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
+	 * [High,Low] when HDM operation is enabled the range register values
+	 * are ignored by the device, but the spec also recommends matching the
+	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
+	 * are expected even though Linux does not require or maintain that
+	 * match. Check if at least one DVSEC range is enabled and allowed by
+	 * the platform. That is, the DVSEC range must be covered by a locked
+	 * platform window (CFMWS). Fail otherwise as the endpoint's decoders
+	 * cannot be used.
+	 */
+
 	root = to_cxl_port(port->dev.parent);
 	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
 		root = to_cxl_port(root->dev.parent);
@@ -454,15 +476,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		return -ENXIO;
 	}
 
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
-	 */
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, "CXL");
-- 
2.39.5

