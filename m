Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80724078FF
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184842; cv=fail; b=KqHx4g+bGgKOapJIgfkc8BWDLjNaPDb0jFJ3jRcbYHS2op4ok9eP80fHlr7cbYnWgsBIpmGSNNlLlzxR2MYo+f8lbP46k2bmwhE0rEBk0Q2o0rWSTzC3jB2fXSZczgUMnaYxAmQfJYPsG7cOZMfnF7ZrHt2du+1hB14GFYyjOrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184842; c=relaxed/simple;
	bh=Ishy5CAbr6UstIGfsQbp15qSaBJlgV2lB1bpI0niN5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itCVWc5k6bzY+Zmo2KLljbMA6yFP2dbrcFyhopSmLVaLmj6NaxKpSdn8P23RxCEPEeaUT6KbOj8byEecbKQrrL6K83QF5M0Jl1hsK6GZsx7SDlNENvAfhaJZf+2XlxU9i+N/CRYvF1WlNkCt5TnpC43MZJXhGKY6b+NJP3uZufE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XrA9NM4V; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XrA9NM4V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYYXlnH2zjak4DR4TgwDASKSkBarx806JFo6goZnQvS08mxa0z31yioTqTuyT58ZhMiD5kugZufBFiaBdiuyJgeM2PPdX7wj1RPvbe2JDZ+m9SHIcMekz8txbVvVjNZPA4gVs7t/pIm+NlmMDX4GBYz6rYbc9AB1RD7Uaw72gsem1V48FTtdeNKrPfkKztpfmdKLGDHHwKTgdzhU3v+YexUjgSJZEFzplAeM2phoaQnGlsisrV4N+k8VYxKiFTLJwj1A5Z2kj8mujtZMUXjwOglNgR4Rrg5lwZNH2FAC7phHu9BmMCwdJS9WR4p1cGuwq20/dVZR9jL6VVzMKWHFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B41bbIkQBBi4FATkvNkRM3bUzyoWvx8seiAZ9Vu1H4=;
 b=y8fvEa/3R/46GyxnEJhg3DLdbsl70x9JH+0N6wmBvYk38G0hEmNP7bAqFesnH5HKvBMDoboKMXdUnT3r1qg8O0SLygOZgSRe1Yr5KNRPv2MQUHTqAcsM8c4flemwfpLkYgeD0XUqhRGXXwW6ybyQhlPVp3/YPRsvBy5h87MxAWTcRiKvPTWitYNAvBlWKpmToMHm8K5cNOKKSMTJYm65PqfQPtfpGspjWTOl5iAs3I813rAFtHg4Ty8RVHHcsFTNFjK+EfiYXwceJLqQe+5y/XDlbGOSS3Y+RD+AQ2MuY8uWnKP/gWrXVQ1Y2zFoNjKAPgTqlyVzs16exfL2FqLitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B41bbIkQBBi4FATkvNkRM3bUzyoWvx8seiAZ9Vu1H4=;
 b=XrA9NM4VACSkoBCgscVg5qx1dBVoxMZPF32ArBnn4h8RdesBg4IIphGRhwlK+G0f78Z8SRtUOFGXLkN/9k38DtKH1ST9qON5MYWpwmbftH5aowVxdW7F7uUpM7pWrfwysURCcV1ET0XgrRmtLNWOYeckhi8vZerjKcur7kMwbJY=
Received: from CH2PR19CA0010.namprd19.prod.outlook.com (2603:10b6:610:4d::20)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 17:33:57 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::7e) by CH2PR19CA0010.outlook.office365.com
 (2603:10b6:610:4d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 17:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:56 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:55 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 09/15] cxl/core: Add Cache ID verification
Date: Wed, 23 Sep 2026 12:33:36 -0500
Message-ID: <20260923173342.5584-10-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9fd77b-a77e-4409-a11a-08df1998d891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|11063799006|10067099003|56012099006|6133799003|3023799007|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uyesw3m0FSDc3mann6nw5CatBMm6qKF9iGX5VU9fcfuatO5yNX74KL38hzW0K/uJoF5ATCatCscv6hbNUWhN4c7tsXAKhGFvhSR1q9wN9CSdKZwjzTdkzO2gQAnxoMU32z5EpJ4UyhHBgQaJ62NM75Gnhlbq4lLAJHzkC9aOiwG3CKtMAMRZ09Euk1USmA+93y7jFDrGseCSanjeg8cV6zjj0tm3oHHpsIwN+3PDFPgwP86gQ7tZ4l2C0DXQrxZQwmnn3augkOl7XnVRMJUpb/xIhc65gWjes7N0RWe8nbsNjTSU01YKCOl7cBznpDc93mkgAbCYhBldcyzNZWgygoShZVwF1U6JoNNYmkPosSiQbbz/Q4He46EL1Lh2NzSUS4V1U3zofELvBo/0quT+yFiPw/IX7U0Wxp67Ev38aptuH2rIJ59Udc7FFlmP7+Ffu5hnIRQ7B+RIgK/rjzGvHbkufGahJxchOY2g03I/mCQny+CplDDOKOefwEXeegR6oL9s6ByR2vS1acAE7CbWXKOfAHmq4ERewva4bravO0ZMICsY9Cgki6UjIYl505k4I2XJJZqN5SKWU4M+HjLa46nwt/C9cCJY03AQ30h9AlIpIh6fLy38VSIrygiRnlNYVuIgfkNW8wog7NII2zsZ3g5LGetCkJu/m+I12+8yYJIQSSrvokb4ckXHbMh9VhrUdYhIo3GVV91F2euMuwji7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(6133799003)(3023799007)(10063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VT6KqFDdITAYiGzeY0Lp9wy5KuBwfngybRY/g+ZK8irhiweZ56PEcY8R6NIqZJAGIX31fJ6nqy85+kN1smax1K0wfGfxlX6b5YLUsaqnwRPAY/VO+PaCGMfDvvr5EgZDoq+mnvGLAoCn8J8KnuVUKIF6tSm9iz8UDIuHJhdpz1u/Pzga26Uy5M0GZHDk3DJ1sq8flZSrqc2/W1eRN9W322t1oV2KfaJex6I0knVPKRIOBBFZYVG3mnFZUuYIIoDsLZz6yqRCD6XIaooWTk4JOYK9wmFao5AUd7r/I+U8B2q4mM8sFfwDo1FZ52nb83OmMfpUZHVxWNiVO7tRb7IbZ0qRm/MjFatCml8uXmYk/J4qf0HoakfLVrkoHm0Rl93ba+dfcqLJ/XfTJc2IQpqnZcKx2xCGqoXsX3uxpLEUG4OEIdypvVCtKgt1y+7uHD3m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:56.8258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9fd77b-a77e-4409-a11a-08df1998d891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866

Check if system firmware has pre-programmed a CXL.cache device's cache
id as part of cxl_cache::probe(). A cache id is required when multiple
CXL.cache devices are present under a host bridge, so fail probe if the
id has not been programmed and another device is present.

Also add @hdmd to struct cxl_dev_state for endpoint drivers to indicate
whether their device is using HDM-D flows. This is required for
correctly validating cache id programming.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c         |  94 ++++++++++++++++++++-
 drivers/cxl/core/cache.c    | 158 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/cachedev.c |   1 +
 drivers/cxl/core/port.c     |   1 +
 drivers/cxl/cxl.h           |  16 ++++
 drivers/cxl/cxlcache.h      |   6 ++
 include/cxl/cxl.h           |   4 +
 7 files changed, 278 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index dfefd301696a..6c098010149a 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -84,6 +84,90 @@ static int cxl_endpoint_cache_enabled(struct cxl_port *endpoint)
 	return 0;
 }
 
+static struct cxl_port *find_host_bridge(struct cxl_port *endpoint)
+{
+	struct cxl_port *parent = endpoint->parent_dport->port;
+	struct cxl_port *hb = endpoint;
+
+	if (is_cxl_root(parent))
+		return NULL;
+
+	while (!is_cxl_root(parent)) {
+		hb = parent;
+		parent = hb->parent_dport->port;
+	}
+
+	return hb;
+}
+
+static int get_num_cachedevs_present(struct cxl_port *host_bridge, u32 *num)
+{
+	u32 num_cachedevs = 0;
+	unsigned long index;
+	struct cxl_ep *ep;
+
+	xa_for_each(&host_bridge->endpoints, index, ep) {
+		if (is_cxl_cachedev(ep->ep))
+			num_cachedevs++;
+	}
+
+	*num = num_cachedevs;
+	return 0;
+}
+
+static void deprogram_cache_id(void *_cxlcd)
+{
+	struct cxl_cachedev *cxlcd = _cxlcd;
+	struct cxl_port *hb = find_host_bridge(cxlcd->endpoint);
+
+	if (cxlcd->cache_id == CXL_CACHE_ID_NO_ID)
+		return;
+
+	guard(device)(&hb->dev);
+	cxl_free_cache_id(cxlcd);
+}
+
+static int program_cache_id(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_port *endpoint = cxlcd->endpoint;
+	struct cxl_port *hb = find_host_bridge(endpoint);
+	struct device *dev = &cxlcd->dev;
+	u32 num_cachedevs;
+	int rc;
+
+	if (!hb)
+		return -ENODEV;
+
+	/*
+	 * Cache ids are unique to the host bridge, so synchronize programming
+	 * around the bridge's device lock
+	 */
+
+	guard(device)(&hb->dev);
+	rc = get_num_cachedevs_present(hb, &num_cachedevs);
+	if (rc)
+		return rc;
+
+	if (!cxl_cache_id_supported(cxlcd))
+		return num_cachedevs > 1 ? -ENXIO : 0;
+
+	rc = cxl_cachedev_validate_cache_id(cxlcd);
+	if (rc && num_cachedevs > 1) {
+		dev_err(dev,
+			"Cache id not programmed with other CXL.cache devices present: %d\n",
+			rc);
+		return rc;
+	} else if (rc) {
+		cxlcd->cache_id = 0;
+	}
+
+	rc = cxl_allocate_cache_id(cxlcd);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 /**
  * devm_cxl_add_cachedev - Add a CXL cache device
  * @cxlds: CXL device state to associate with the cachedev
@@ -142,10 +226,16 @@ static int cxl_cache_probe(struct device *dev)
 	}
 
 	rc = cxl_endpoint_cache_enabled(cxlcd->endpoint);
-	if (rc)
+	if (rc) {
 		dev_err(dev, "CXL.cache not enabled on parent port(s)");
+		return rc;
+	}
+
+	rc = program_cache_id(cxlcd);
+	if (rc)
+		return rc;
 
-	return rc;
+	return devm_add_action_or_reset(dev, deprogram_cache_id, cxlcd);
 }
 
 static struct cxl_driver cxl_cache_driver = {
diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
index 17df0e603b68..be570d3dc609 100644
--- a/drivers/cxl/core/cache.c
+++ b/drivers/cxl/core/cache.c
@@ -39,3 +39,161 @@ int cxl_dport_map_cache_id_dc(struct cxl_dport *dport)
 	return cxl_map_component_regs(map, &dport->regs.component,
 				      BIT(CXL_CM_CAP_CAP_ID_CACHE_ID_DC));
 }
+
+static int cache_decoder_committed(struct cxl_dport *dport)
+{
+	u32 cap, stat;
+
+	cap = readl(dport->regs.ciddc + CXL_CACHE_ID_DC_CAP_OFFSET);
+	if (!FIELD_GET(CXL_CACHE_ID_DC_CAP_COMMIT_REQ, cap))
+		return -ENXIO;
+
+	stat = readl(dport->regs.ciddc + CXL_CACHE_ID_DC_STATUS_OFFSET);
+	return FIELD_GET(CXL_CACHE_ID_DC_STATUS_COMMITTED, stat);
+}
+
+static int cache_decoder_get_id(struct cxl_dport *dport)
+{
+	u32 ctrl;
+
+	ctrl = readl(dport->regs.ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
+	if (FIELD_GET(CXL_CACHE_ID_DC_CTRL_HDMD_PRESENT, ctrl))
+		 return FIELD_GET(CXL_CACHE_ID_DC_CTRL_HDMD_ID, ctrl);
+
+	return FIELD_GET(CXL_CACHE_ID_DC_CTRL_LOCAL_ID, ctrl);
+}
+
+static bool cache_decoder_valid(struct cxl_dport *dport, int id, bool endpoint)
+{
+	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
+	bool flit_256b;
+	u32 ctrl;
+
+	if (!dev_is_pci(dport->dport_dev))
+		return false;
+
+	flit_256b = cxl_pci_flit_256(pdev);
+	if (id && !flit_256b)
+		return false;
+
+	ctrl = readl(dport->regs.ciddc + CXL_CACHE_ID_DC_CTRL_OFFSET);
+	if (endpoint || !flit_256b) {
+		if (!FIELD_GET(CXL_CACHE_ID_DC_CTRL_ASGN_ID, ctrl))
+			return false;
+	} else if (!FIELD_GET(CXL_CACHE_ID_DC_CTRL_FWD_ID, ctrl)) {
+		return false;
+	}
+
+	return cache_decoder_get_id(dport) == id;
+}
+
+static int cache_idrt_committed(struct cxl_port *port)
+{
+	u32 cap, stat;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_ID_RT_CAP_OFFSET);
+	if (!FIELD_GET(CXL_CACHE_ID_RT_CAP_COMMIT_REQ, cap))
+		return true;
+
+	stat = readl(port->regs.cidrt + CXL_CACHE_ID_RT_STATUS_OFFSET);
+	return FIELD_GET(CXL_CACHE_ID_RT_STATUS_COMMITTED, stat);
+}
+
+static int cache_idrt_entry_valid(struct cxl_port *port, int id)
+{
+	u16 entry;
+	u32 cap;
+
+	cap = readl(port->regs.cidrt + CXL_CACHE_ID_RT_CAP_OFFSET);
+	if (id >= FIELD_GET(CXL_CACHE_ID_RT_CAP_TARGET_CNT, cap))
+		return false;
+
+	entry = readw(port->regs.cidrt + CXL_CACHE_ID_RT_TARGETN_OFFSET(id));
+	return FIELD_GET(CXL_CACHE_ID_RT_TARGETN_VALID, entry);
+}
+
+static struct ida *find_cache_id_ida(struct cxl_port *port)
+{
+	struct cxl_port *parent = parent_port_of(port);
+
+	while (parent) {
+		if (is_cxl_root(parent))
+			return &port->cache_ida;
+
+		port = parent;
+		parent = parent_port_of(port);
+	}
+
+	return NULL;
+}
+
+int cxl_allocate_cache_id(struct cxl_cachedev *cxlcd)
+{
+	struct ida *ida = find_cache_id_ida(cxlcd->endpoint);
+	int id;
+
+	if (!ida)
+		return -ENOSPC;
+
+	id = ida_alloc_range(ida, cxlcd->cache_id, cxlcd->cache_id, GFP_KERNEL);
+	if (id != cxlcd->cache_id)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_allocate_cache_id, "cxl_cache");
+
+void cxl_free_cache_id(struct cxl_cachedev *cxlcd)
+{
+	struct ida *ida = find_cache_id_ida(cxlcd->endpoint);
+
+	if (ida)
+		ida_free(ida, cxlcd->cache_id);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_free_cache_id, "cxl_cache");
+
+bool cxl_cache_id_supported(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_dport *dport = cxlcd->endpoint->parent_dport;
+	struct cxl_port *port = dport->port;
+
+	for (; !is_cxl_root(port);
+	     dport = port->parent_dport, port = dport->port) {
+		if (!port->regs.cidrt || !dport->regs.ciddc)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_cache_id_supported, "cxl_cache");
+
+int cxl_cachedev_validate_cache_id(struct cxl_cachedev *cxlcd)
+{
+	struct cxl_dport *dport = cxlcd->endpoint->parent_dport;
+	struct cxl_port *port = dport->port;
+	int id = CXL_CACHE_ID_NO_ID;
+	bool endpoint = true;
+
+	cxlcd->cache_id = CXL_CACHE_ID_NO_ID;
+	id = cache_decoder_get_id(dport);
+
+	while (!is_cxl_root(port)) {
+		if (!cache_decoder_valid(dport, id, endpoint) ||
+		    !cache_decoder_committed(dport))
+			return -EINVAL;
+
+		endpoint = false;
+
+		if (!cache_idrt_entry_valid(port, id) ||
+		    !cache_idrt_committed(port))
+			return -EINVAL;
+
+		dport = port->parent_dport;
+		port = dport->port;
+	}
+
+	cxlcd->cache_id = id;
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_cachedev_validate_cache_id, "cxl_cache");
+>>>>>>> conflict 1 of 1 ends
diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
index 2bd69133c631..38f0adf2b197 100644
--- a/drivers/cxl/core/cachedev.c
+++ b/drivers/cxl/core/cachedev.c
@@ -72,6 +72,7 @@ static struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds)
 	cxlcd->id = rc;
 	cxlcd->depth = -1;
 	cxlcd->endpoint = ERR_PTR(-ENODEV);
+	cxlcd->cache_id = CXL_CACHE_ID_NO_ID;
 
 	dev = &cxlcd->dev;
 	device_initialize(dev);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6da11d28bb5e..047801faa020 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -740,6 +740,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 		dev->parent = uport_dev;
 
 	ida_init(&port->decoder_ida);
+	ida_init(&port->cache_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
 	xa_init(&port->dports);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9f0c1a39aaeb..ed6b56a269ee 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -229,9 +229,23 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 /* CXL 4.0 8.2.4.28.1 CXL Cache ID Route Table Capability Structure */
 #define CXL_CACHE_ID_RT_CAP_OFFSET 0x0
 #define   CXL_CACHE_ID_RT_CAP_TARGET_CNT GENMASK(4, 0)
+#define   CXL_CACHE_ID_RT_CAP_COMMIT_REQ BIT(16)
+#define CXL_CACHE_ID_RT_STATUS_OFFSET 0x8
+#define   CXL_CACHE_ID_RT_STATUS_COMMITTED BIT(0)
 #define CXL_CACHE_ID_RT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
+#define   CXL_CACHE_ID_RT_TARGETN_VALID BIT(0)
 
 /* CXL 4.0 8.2.4.29.1 CXL Cache ID Decoder Capability Structure */
+#define CXL_CACHE_ID_DC_CAP_OFFSET 0x0
+#define   CXL_CACHE_ID_DC_CAP_COMMIT_REQ BIT(0)
+#define CXL_CACHE_ID_DC_CTRL_OFFSET 0x4
+#define   CXL_CACHE_ID_DC_CTRL_FWD_ID BIT(0)
+#define   CXL_CACHE_ID_DC_CTRL_ASGN_ID BIT(1)
+#define   CXL_CACHE_ID_DC_CTRL_HDMD_PRESENT BIT(2)
+#define   CXL_CACHE_ID_DC_CTRL_HDMD_ID GENMASK(11, 8)
+#define   CXL_CACHE_ID_DC_CTRL_LOCAL_ID GENMASK(19, 16)
+#define CXL_CACHE_ID_DC_STATUS_OFFSET 0x8
+#define   CXL_CACHE_ID_DC_STATUS_COMMITTED BIT(0)
 #define CXL_CACHE_ID_DC_CAPABILITY_LENGTH 0xC
 
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
@@ -578,6 +592,7 @@ struct cxl_dax_region {
  * @cdat_available: Should a CDAT attribute be available in sysfs
  * @pci_latency: Upstream latency in picoseconds
  * @component_reg_phys: Physical address of component register
+ * @cache_ida: ida used for cache id allocations on host bridges
  */
 struct cxl_port {
 	struct device dev;
@@ -603,6 +618,7 @@ struct cxl_port {
 	bool cdat_available;
 	long pci_latency;
 	resource_size_t component_reg_phys;
+	struct ida cache_ida;
 };
 
 struct cxl_root;
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index e9a4567b7f2c..1e4a1e61ad7b 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -11,6 +11,7 @@
  * @cxlds: device state backing this device
  * @detach_work: active cachedev lost a port in its ancestry
  * @endpoint: connection to the CXL port topology for this device
+ * @cache_id: id used for CXL cache routing capabilities
  * @id: id number of this cachedev instance
  * @depth: endpoint port depth in hierarchy
  */
@@ -19,6 +20,7 @@ struct cxl_cachedev {
 	struct cxl_dev_state *cxlds;
 	struct work_struct detach_work;
 	struct cxl_port *endpoint;
+	int cache_id;
 	int id;
 	int depth;
 };
@@ -39,4 +41,8 @@ struct cxl_cachedev *__devm_cxl_add_cachedev(struct cxl_dev_state *cxlds,
 int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds);
 void cxl_clear_cache_enable(struct cxl_dev_state *cxlds);
 int devm_cxl_enable_cache(struct device *host, struct cxl_dev_state *cxlds);
+bool cxl_cache_id_supported(struct cxl_cachedev *cxlcd);
+int cxl_allocate_cache_id(struct cxl_cachedev *cxlcd);
+void cxl_free_cache_id(struct cxl_cachedev *cxlcd);
+int cxl_cachedev_validate_cache_id(struct cxl_cachedev *cxlcd);
 #endif
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 7a5ed64904a6..b99a9727e284 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -155,6 +155,8 @@ struct cxl_dpa_partition {
 
 #define CXL_NR_PARTITIONS_MAX 2
 
+#define CXL_CACHE_ID_NO_ID (-1)
+ 
 /**
  * struct cxl_cache_state - CXL cache device state for use by external drivers
  * @size: Size of device's cache
@@ -182,6 +184,7 @@ struct cxl_cache_state {
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
  * @cxlcd: The device representing the CXL.cache capabilities of @dev
  * @cstate: CXL.cache information for @dev
+ * @hdmd: Whether the device is using HDM-D flows for CXL.cache
  * @reg_map: component and ras register mapping parameters
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
@@ -201,6 +204,7 @@ struct cxl_dev_state {
 	struct cxl_memdev *cxlmd;
 	struct cxl_cachedev *cxlcd;
  	struct cxl_cache_state cstate;
+	bool hdmd;
 
 	/* private for Type2 drivers */
 	struct cxl_register_map reg_map;
-- 
2.53.0

