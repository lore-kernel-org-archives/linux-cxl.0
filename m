Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F43DC4AB
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184847; cv=fail; b=bbPGVXA/TkNAJ2In0BbFeGcr+NSOf37dKnYz2mIKggTqu1NI205IelZ+v0LsIbdRQq8boRH+Tyc06BvDqpa/+gpGNSAmpoYH7AlBLlsxFL4sR5j1PRFJYY58v12ZO/JXMaGoDNNY5CXEBdermgidrXSHZ8Z+G3P0KuAW+HQ/MPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184847; c=relaxed/simple;
	bh=3ftY8pkKHRMOOFGov8InL5xLZJF6PBU2Kvyf3IMszDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3DwyBqhx4XqL22h1zwwiv27nDCIMD2LVs6+dFrlgbh68kmvnRhocyi9VS9qYeA52XuL20PbQwbKJYWX8Fc5+witINAOEp+mI46GsFA8wYRQaHqlF1wkQy49Kcvp6jcR0HkdRGHpggMQKaS7fyUNVINaM7frMmMx1+vXbCFuiXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3NVDa0sY; arc=fail smtp.client-ip=52.101.46.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3NVDa0sY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1votZ52Gw/6xsbtl9v37x7D2vzaIKhfc9uVxMGjCTIaqsEf1fG9ugw1BcSYUxjcpvY9PjDbilAQaT8JQp84XfKjFAq6jHoap7gYDlcNWAMLXXEJ9YmfvBNMnocB8ATJQNQaArZ6/1xuclBaeL5jj+V19Mp6DncHCu1i/+vL3+WYBSOU09XIiY9x2+29Wg0vXiQQSwTYR2jqHMyYa5D9VOvNLFxu/kloBsMZPwpEMdVFV8NESTGnUl6QWZVX8qO3nTOxLz2nFf4rSj2ZSSHtFMc6zt6Y1aB/UR8ikpyga33Zgv+abaTcKlz43MRqNasIL7WlVErWoTnzplsJxIg2Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU7E2xiyODQts62REXNIjuv9Xt5VsGn0MsHVUBmJN0s=;
 b=mW3mY7HoT3KX4VuxfQfYG5AtFLYeVp0feaAulvMRl0LjHMbpWAK1WRHC348Lmbm5cgS6vrUr4qaYzoeJDJ9fX54ud9RNvvHiOc2DKiP2/Ilg5BIALmUMATIDPLFceOR/vM5mTgv9hJ9xmRRZVwpQqF84YGVyWi6feYPkOFrNlDm6we4/P6mNJb1kgxqVj8Z2P9eKt26yGsDvDHGOPjg/TJfna2rie+fwRRjAb/bvCJZW+ys9/egVMO+4x7Nd73ffeMFhntMhGHEqAX19kNomjgcaPqL1MiaCnsMdGE0lNaZ26qpxP6j4NeZTFRvJaiK6o/fRGNmEtn23u4JGKQEjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU7E2xiyODQts62REXNIjuv9Xt5VsGn0MsHVUBmJN0s=;
 b=3NVDa0sYIf8HRSiufDZLuYUHVeViuE9v9Qh1BN4XR2P4sFacaXZ0cXOZPoCkuq0gv/wOr98h4w3QQ7gtX68RhNTPiDJdQc5jGpowdU6cjLISnGHrGFoHllwaStCmD5iaqG7yYWw7PI52jYoius3oMmNlNWMxvQiSUsS3JyDkiFM=
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:33:58 +0000
Received: from DS2PEPF000061C2.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::87) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8 via Frontend Transport; Wed, 23
 Sep 2026 17:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C2.mail.protection.outlook.com (10.167.23.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:58 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:56 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 11/15] cxl/core: Add support for HDM-D cache id programming
Date: Wed, 23 Sep 2026 12:33:38 -0500
Message-ID: <20260923173342.5584-12-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C2:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 54aa610d-aa32-4a74-cc78-08df1998d98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	z6eNiVWRXW0o/l9xC25ywQjDRHZrhy6At0SY3j1+zHuk0oA/iRWY7D+qqCuUXV3yNIi3cR7+r/qvVW0W59mUCDmEeDq5+J5eTYN+KzNEhfyXcOxbbvqTsWCR9P9HS7q6aL18jKtq9dPXQylgE644FFpwMcVyffNE4u6mES2lAhmW46Y2uTp6qPBw9WCYM7ZnswAXAIHytCZvJvxpj/na55nyEDMtdbXeMfbHw4i/fQS/QXAhZuT/TNbdvdSFgG4MMYKuVuf0Lfe+Ci2AZorQQtlYTMLO9UTpyCxkTBTV8JpVzL2qUjfTI7qEy3y8hheytjnsI8bs2LofjJ5YGICfiKMwm+2xTyfH46O+mcYnEAf67WQadptQcVdwgS+PIyb214Du0VmIxa8FjLs90DabRfuEgxbKXH9sf0kQ4m+XEXN8EZGz1Tj4tX8lf0cmK+MZmmwWV5W89+8Q7NnhcSxwDy6TaZmEAJJ0ztgeNtQyiUE8tqi7aFnm8e600tz1Weinn6RKUG8UgVfx7pc3CqvdsWWSYapjYO0MUjmLueIPJGmxQb5a8jmXwfqsjkAHMQ43kgSGgtmPsMIaQDG0eOH6ijclCKbtX20Er5YKh44+EoEaqHFUx8TRoxKC3NY22u2oa00IIGAqRbvvFIQmq7Ju7jHaV6vsz9qRUsfRlJ7iMJ6lRAjSRurwbOL6a6fI7xVpiO8mtr2GQMlL0ekA2nEJpA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tbmswhsnN7VIprQL/HXe9UL8gFjzxEpcyzBXpogn8izgttV3DFjy+fm/5xJRqoVcXPgXiQEr9WEhSSBEhnB88Xqt8yE4Qunl+1qwJrxWFarR8Wonqfiv8N0h/NaYw0Ne901pi0Qn6IzqzLs+QgL1Dujokp2iIXmHXUfsfcL4Bt/FvNIfdXK2yCidFcJ6zB9vc9UcvMrxvuP3vbuP/YbNXui1ga6iOEcUtftNwW7gD+DmGqS7LX2lGCZEDX4AnI6SNCbsvpLe+flbJF7kxIjdL6N+b1AeY9gQuZgMYxTqxuYroAt8u3ulozuth2NPL68D7Ns+m5KaDfi5Lclrn3IpDiQE34aqvUpxwUD0lKgZ4fGM2ElB3tzizQrapZJH/Fr7tFaGgE0Ri/HycsftZb9ehDNDRqpOvJQDv0DSeRqY9jTM+bBL/ii9harHk4usV/LV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:58.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aa610d-aa32-4a74-cc78-08df1998d98d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0

Add cache id allocation and programming to the pre-existing cache id
programming routines.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c      |  6 -----
 drivers/cxl/core/cache.c | 52 +++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h        |  3 +++
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 0fc8f413c638..40d1e8330df7 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -156,12 +156,6 @@ static int program_cache_id(struct cxl_cachedev *cxlcd)
 	if (!rc)
 		return cxl_allocate_cache_id(cxlcd);
 
-	if (cxlcd->cxlds->hdmd) {
-		dev_err(dev,
-			"Cache id programming not supported for HDM-D devices\n");
-		return -ENXIO;
-	}
-
 	rc = cxl_allocate_cache_id(cxlcd);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
index 9c6c8ea713ef..7810772326e9 100644
--- a/drivers/cxl/core/cache.c
+++ b/drivers/cxl/core/cache.c
@@ -204,7 +204,7 @@ static int cxl_cid_commit_decoder(struct cxl_dport *dport)
 }
 
 static int cxl_cid_program_decoder(struct cxl_dport *dport, int cid,
-				   bool endpoint)
+				   bool endpoint, bool hdmd)
 {
 	void __iomem *ciddc = dport->regs.ciddc;
 	u32 ctrl;
@@ -225,7 +225,14 @@ static int cxl_cid_program_decoder(struct cxl_dport *dport, int cid,
 		ctrl |= CXL_CACHE_ID_DC_CTRL_FWD_ID;
 	}
 
-	FIELD_MODIFY(CXL_CACHE_ID_DC_CTRL_LOCAL_ID, &ctrl, cid);
+	if (hdmd) {
+		ctrl |= CXL_CACHE_ID_DC_CTRL_HDMD_PRESENT;
+		FIELD_MODIFY(CXL_CACHE_ID_DC_CTRL_HDMD_ID, &ctrl, cid);
+	} else {
+		ctrl &= ~CXL_CACHE_ID_DC_CTRL_HDMD_PRESENT;
+		FIELD_MODIFY(CXL_CACHE_ID_DC_CTRL_LOCAL_ID, &ctrl, cid);
+	}
+
 	writel(ctrl, ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
 
 	return cxl_cid_commit_decoder(dport);
@@ -269,10 +276,10 @@ static int cxl_cid_commit_table(struct cxl_port *port)
 }
 
 static int cxl_cid_program_table_entry(struct cxl_port *port, int cid,
-				       unsigned int dport_id)
+				       unsigned int dport_id, bool hdmd)
 {
 	void __iomem *cidrt = port->regs.cidrt;
-	u8 target_cnt, portn;
+	u8 target_cnt, hdmd_max, portn;
 	u16 target_n;
 	u32 cap;
 
@@ -290,6 +297,16 @@ static int cxl_cid_program_table_entry(struct cxl_port *port, int cid,
 		return -EINVAL;
 	}
 
+	if (is_cxl_root(parent_port_of(port)) && hdmd) {
+		hdmd_max = FIELD_GET(CXL_CACHE_ID_RT_CAP_HDMD_MAX, cap);
+
+		if (port->num_hdmd > hdmd_max) {
+			dev_err(&port->dev,
+				"Maximum number of devices using HDM-D reached\n");
+			return -EINVAL;
+		}
+	}
+
 	target_n = readw(cidrt + CXL_CACHE_ID_RT_TARGETN_OFFSET(cid));
 	if (FIELD_GET(CXL_CACHE_ID_RT_TARGETN_VALID, target_n)) {
 		portn = FIELD_GET(CXL_CACHE_ID_RT_TARGETN_PORTN, target_n);
@@ -385,6 +402,22 @@ static struct ida *find_cache_id_ida(struct cxl_port *port)
 	return NULL;
 }
 
+static void cxl_port_add_hdmd(struct cxl_port *endpoint, int val)
+{
+	struct cxl_port *parent = parent_port_of(endpoint);
+	struct cxl_port *port = endpoint;
+
+	if (!parent || !is_cxl_cachedev(endpoint->uport_dev))
+		return;
+
+	while (parent && !is_cxl_root(parent)) {
+		port = parent;
+		parent = parent_port_of(port);
+	}
+
+	port->num_hdmd += val;
+}
+
 int cxl_allocate_cache_id(struct cxl_cachedev *cxlcd)
 {
 	struct ida *ida = find_cache_id_ida(cxlcd->endpoint);
@@ -407,6 +440,9 @@ int cxl_allocate_cache_id(struct cxl_cachedev *cxlcd)
 	if (id < 0)
 		return id;
 
+	if (cxlcd->cxlds->hdmd)
+		cxl_port_add_hdmd(cxlcd->endpoint, 1);
+
 	cxlcd->cache_id = id;
 	return 0;
 }
@@ -418,6 +454,9 @@ void cxl_free_cache_id(struct cxl_cachedev *cxlcd)
 
 	if (ida)
 		ida_free(ida, cxlcd->cache_id);
+
+	if (cxlcd->cxlds->hdmd)
+		cxl_port_add_hdmd(cxlcd->endpoint, -1);
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_free_cache_id, "cxl_cache");
 
@@ -489,17 +528,18 @@ int cxl_cachedev_program_cache_id(struct cxl_cachedev *cxlcd)
 {
 	struct cxl_dport *dport = cxlcd->endpoint->parent_dport;
 	struct cxl_port *port = dport->port;
+	bool hdmd = cxlcd->cxlds->hdmd;
 	bool endpoint = true;
 	int rc;
 
 	while (!is_cxl_root(port)) {
 		rc = cxl_cid_program_decoder(dport, cxlcd->cache_id,
-					     endpoint);
+					     endpoint, hdmd);
 		if (rc)
 			goto err;
 
 		rc = cxl_cid_program_table_entry(port, cxlcd->cache_id,
-						 dport->port_id);
+						 dport->port_id, hdmd);
 		if (rc)
 			goto err;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4cdc26dbdb6a..63efe98d1c89 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -229,6 +229,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 /* CXL 4.0 8.2.4.28.1 CXL Cache ID Route Table Capability Structure */
 #define CXL_CACHE_ID_RT_CAP_OFFSET 0x0
 #define   CXL_CACHE_ID_RT_CAP_TARGET_CNT GENMASK(4, 0)
+#define   CXL_CACHE_ID_RT_CAP_HDMD_MAX GENMASK(11, 8)
 #define   CXL_CACHE_ID_RT_CAP_COMMIT_REQ BIT(16)
 #define CXL_CACHE_ID_RT_CTRL_OFFSET 0x4
 #define   CXL_CACHE_ID_RT_CTRL_COMMIT BIT(0)
@@ -603,6 +604,7 @@ struct cxl_dax_region {
  * @pci_latency: Upstream latency in picoseconds
  * @component_reg_phys: Physical address of component register
  * @cache_ida: ida used for cache id allocations on host bridges
+ * @num_hdmd: Number of devices using HDM-D flows below this port
  */
 struct cxl_port {
 	struct device dev;
@@ -629,6 +631,7 @@ struct cxl_port {
 	long pci_latency;
 	resource_size_t component_reg_phys;
 	struct ida cache_ida;
+	u32 num_hdmd;
 };
 
 struct cxl_root;
-- 
2.53.0

