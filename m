Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A9126E15D
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034337; cv=fail; b=YtKk/Gk9JE1IaaicozuNGMnX+4Uw+dRDkyF67e3CBjOTeqwpL+axa+Asru7e7wmnZItVnV91ywTwH8H+pDFCWM1JnAnn1QhZn1sZURp5VB4px4yFY61phPXjrPOLv55bY5Pdt5ZVP4a7y8x02NPJjO9+i78m7stowINK0+iD51w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034337; c=relaxed/simple;
	bh=Fhfr/xTCF6l45Id+LJ4A1pktd6xW38F11sN+k754Rrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8bPjGbLk72CcfXbwXTqvzDWzTgp0sCx0b5mMqmem0lZILw0Pu0lx/sREOCPrAgOWXrynyaTLmTjddf40jmP1r6kkKyehH9Gwna5/VitYZEYbOCVsNslgyVgxLjVk8j740SkHI6oJTQETlXkntvob+u87UJXaoH1JYu7N8VT/GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rpEs0kS5; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rpEs0kS5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlDPfQ0YE9HbpnR1g5CTSKBDH5Vz5v8EBb1UL12302L9V6A7popfVIRkj4aUAiVyO0TzikefO+8P6SHosEe7IqFyvKojCMTB5UPDvRCHpC7vtXLCFeTwXP1AuoPILdLFGx5/AK+J0nxlQUkGprXOjCmkMoPObtNXW8D/uirR/w4Z50YWgsUWZzaReBWr3BAH8ldDsGhTii4shCGYwp9SDwtqNdRAmLczQ2NI1Jf+rag1T+FiiJW4RxnlWb6b4UIGCANBlP1YgPQPHI1zQB6DF6bxqMrCZLVxJegULBb/nQlYrs+WVFIfcNRlXDOQf2e424GLHU/ZDtdQ5eeHl78g/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p3X6xYOExjBu+QAiNiiKRr4/xbn81oYHI3Qlffymq0=;
 b=PV2yV2WtXHgN1KLTw5NuOsN8jmUO5nqekh/tfMV9xpiyEEJGneFaoGujtfRVZzV8rk/Nmlp4NHAoHy2Dj+AIsHmuN6+RElReeA82Zt1gyv96fSlk20Z+bYGP3t9s4LzXASfY1vc7J0Zgz4R+ylSOWTlc5k7ZmFuyin5o6uHfKgrzJCDThGQ/Qm7eOdRfE0Xvmm25raEkwD7EaYU0telKcv2Nb9bqHdD5k2DfWR2964p93oLautN10Q0mtYhabSJaN6WAzLKnulxKq8gzkl0t+wJ0QAKGvNCqyYJvdPSZgv0UYnloTXcPmUVx8IqvxhqpNQH1Ox6SUKM9vbr74ADtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p3X6xYOExjBu+QAiNiiKRr4/xbn81oYHI3Qlffymq0=;
 b=rpEs0kS5UBAR1MGehrFZyqpe4Qrx58TvIg0VeDcu1uu8xYt91iTmRYceXdrFoMq5KVRb4f7sWzBzYqxeDq5i8CYGe4lQBzpTfNgsBFaZEuqrXx9mo5Ay5uSe3SuAGSHhEJ6gII202n3HrRvJPSaVzsxpfa5eMHq4gLSf5Nay93g=
Received: from DM6PR13CA0036.namprd13.prod.outlook.com (2603:10b6:5:bc::49) by
 MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Tue, 12 Aug
 2025 21:32:12 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::99) by DM6PR13CA0036.outlook.office365.com
 (2603:10b6:5:bc::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 21:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 21:32:11 +0000
Received: from SCS-L-bcheatha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 16:32:11 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [RFC PATCH 11/18] cxl/core: Add CXL snoop filter setup and checking
Date: Tue, 12 Aug 2025 16:29:14 -0500
Message-ID: <20250812212921.9548-12-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ff939e-ae7b-4d99-94fe-08ddd9e7b2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bakc+LygCz191L7JBEPPfm90+fAwGzegZbiCkEHaTZ0bzKnzFoCR0oXul08n?=
 =?us-ascii?Q?a09ScgT440qnrXokfex/cBZc8CsoGv+p+4iBA32ST1ajZrBsBFonQ/yjASxI?=
 =?us-ascii?Q?5xDD66JdvDdWUE4bMvUlweSp3vGJF/S9lH2inReZ7VM2Arw36ErANpaHwMeL?=
 =?us-ascii?Q?90QjkaFqvGVyPmOH2N6rn5oNnx3p3r4DQliLco0OS+HMa776MjHYeAfcTAF4?=
 =?us-ascii?Q?hrkGxeWHKF1AQLE3R1eNXUmruYY58MBudKRLBekQmz1y4ffG/wvkHwAMRbhL?=
 =?us-ascii?Q?J0tlb0pIWeLOPk5gfTqFqCRvL0qFF0Cz4zc9RjKSAxpqbOjZuzG1vHDsX37g?=
 =?us-ascii?Q?JjQF1SvSZzUFOHb/zVJtQeXHY3/iN4iKDx32AK8+f4dPG3JvR3QUdB6JfYpV?=
 =?us-ascii?Q?BDFJXTawD8IZCeqFkhyz00FoAaX+WPP8dnCeuBxc0UxcRZ/mqnZjsk8c8n94?=
 =?us-ascii?Q?NCRqeKXU3I/ajn1ahtiG8KsYUaH1bf8ixhlQFV8jg6yY+kI/4RCiWDLXLvYt?=
 =?us-ascii?Q?L7USJOM119qe4lbnYnyLjTOX7NI71S8DYiFObcjogKvC8VIyQXk18jE0XNRG?=
 =?us-ascii?Q?qf6+KfAo5OWx0nfGXETTVEIdHyu2FfnwerrWV22pLHbNftTX+Bb8mCvJ4pXX?=
 =?us-ascii?Q?f7SOY3YnAJkcYDxqx0rYSVJz54cnPSBiSDd+wGKi5HrFo9uPLiqgmJ8BjEyf?=
 =?us-ascii?Q?2N2QxNaPIi4wVIMUYmJjH1/GchoDgcdISqtLuX0UrYAVHyFREdHZSPh3Gapk?=
 =?us-ascii?Q?DbXs0qqHGaWGmcNP7+Qxh47Pn7bnbMKNCRsowPbk+PMw45FUVOa74o0BSHvr?=
 =?us-ascii?Q?MVOwa4a+4qgp409skvtjpapMQ19vcEVDEJkw65b+aM3mEJJFIN32HMcaK6Z+?=
 =?us-ascii?Q?XiVVh0gX8IPWBtiy5b2h8r8hpSgGR6wHQqIKfBcK8xSsMdGuAeLvQHCptgdK?=
 =?us-ascii?Q?+EtUOaYXIfJd5qf3TmQLCIAdmq3dV/x+nWSlzzfYUqJ1/kf2ZuBr2VFSXwwf?=
 =?us-ascii?Q?6//Hi2PTW30bE+6e8XlqcT1aeGFFgCd2/q9MsHkgxtN0CshvZjXkopdbjQym?=
 =?us-ascii?Q?mCi8hB85nlrLZQFwojHMiEzAQvKLQwCN7COWgvX/c/jKk1XmqJcDUeAyUXal?=
 =?us-ascii?Q?SQbmdP1isWA3ZDhmCrpRLCh3HHQGwl1olrKVu8PM1J3TTtE9wSeQTqneMsps?=
 =?us-ascii?Q?w4JyqisT4kRUSdAywAp4jiXydY9TfLVdVuQ9/wa8RZv6NLIoG3VV8KwxJJNW?=
 =?us-ascii?Q?Wt29uxkzDQEutuRI4HUJNlLgstkvGVjJ/Bf8WOLaf2lEyVt24rqkNAug/DUd?=
 =?us-ascii?Q?AcxKfFBC6ysSqHyqW6yqrYJLkJYkjZG9vkwQErgAvBoTbKHmh+SeWWkL5Bc0?=
 =?us-ascii?Q?rA5SJg30WniStapdUPX+oNjlNujCR9hicBE0JzLuBwngDv43CIAzxO5/EWEU?=
 =?us-ascii?Q?YbNk3+08M0x6+mh0UT1AfWvO1TC0ibqW0EOc9/3Fg1NXwPB32quKY6KipAC4?=
 =?us-ascii?Q?I18x3Yr0j7NXkVY91lqcXWtODLQKwtDCfWQb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 21:32:11.7469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ff939e-ae7b-4d99-94fe-08ddd9e7b2e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333

Add functions to set up and validate the snoop filter configuration of a
CXL-capable PCIe Root Port (struct cxl_dport). Allocate space in the
snoop filter as part of cxl_cachedev probe.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     |  26 +++++++
 drivers/cxl/core/port.c | 145 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |   7 ++
 drivers/cxl/cxl.h       |  14 ++++
 drivers/cxl/cxlcache.h  |   3 +
 5 files changed, 195 insertions(+)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 6e5161ae3107..7ef36e4bbce8 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -55,11 +55,29 @@ struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_cachedev, "CXL");
 
+static int find_snoop_gid(struct cxl_cachedev *cxlcd, u32 *gid)
+{
+	struct cxl_dport *iter = cxlcd->endpoint->parent_dport;
+
+	while (iter && !is_cxl_root(iter->port)) {
+		if (iter->snoop_id != CXL_SNOOP_ID_NO_ID) {
+			*gid = iter->snoop_id;
+			return 0;
+		}
+
+		iter = iter->port->parent_dport;
+	}
+
+	*gid = CXL_SNOOP_ID_NO_ID;
+	return -ENXIO;
+}
+
 static int cxl_cache_probe(struct device *dev)
 {
 	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
 	struct device *endpoint_parent;
 	struct cxl_dport *dport;
+	u32 gid;
 	int rc;
 
 	rc = devm_cxl_enumerate_ports(&cxlcd->dev);
@@ -96,6 +114,14 @@ static int cxl_cache_probe(struct device *dev)
 			return rc;
 	}
 
+	rc = find_snoop_gid(cxlcd, &gid);
+	if (rc)
+		return rc;
+
+	rc = devm_cxl_snoop_filter_alloc(gid, cxlcd->cxlds);
+	if (rc)
+		return rc;
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5144ddac7145..26ea22a2638c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -35,6 +35,9 @@ static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 static DEFINE_XARRAY(cxl_root_ports);
 
+DECLARE_RWSEM(cxl_snoop_rwsem);
+static DEFINE_XARRAY(cxl_snoop_filters);
+
 /*
  * The terminal device in PCI is NULL and @platform_bus
  * for platform devices (for cxl_test)
@@ -809,6 +812,139 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
 	return rc;
 }
 
+struct cxl_snoop_filter {
+	u64 size;
+	struct xarray dports;
+	struct xarray devs;
+	struct mutex lock; /* Used for filter allocations */
+};
+
+static struct cxl_snoop_filter *cxl_create_snoop_filter(struct cxl_dport *dport,
+							u32 gid, u32 size)
+{
+	struct cxl_snoop_filter *sf;
+	int rc;
+
+	sf = xa_load(&cxl_snoop_filters, gid);
+	if (sf)
+		return sf;
+
+	guard(rwsem_write)(&cxl_snoop_rwsem);
+	sf = kzalloc(sizeof(*sf), GFP_KERNEL);
+	if (!sf)
+		return ERR_PTR(-ENOMEM);
+
+	sf->size = size;
+	xa_init(&sf->dports);
+	xa_init(&sf->devs);
+	mutex_init(&sf->lock);
+
+	rc = xa_insert(&sf->dports, (unsigned long)dport->dport_dev, dport,
+		       GFP_KERNEL);
+	if (rc)
+		goto err;
+
+	rc = xa_insert(&cxl_snoop_filters, gid, sf, GFP_KERNEL);
+	if (rc)
+		goto err;
+
+	return 0;
+
+err:
+	xa_destroy(&sf->dports);
+	xa_destroy(&sf->devs);
+	mutex_destroy(&sf->lock);
+	kfree(sf);
+	return ERR_PTR(rc);
+}
+
+static void cxl_destroy_snoop_filters(void)
+{
+	struct cxl_snoop_filter *sf;
+	unsigned long gid;
+
+	guard(rwsem_write)(&cxl_snoop_rwsem);
+	xa_for_each(&cxl_snoop_filters, gid, sf) {
+		xa_destroy(&sf->dports);
+		xa_destroy(&sf->devs);
+		mutex_destroy(&sf->lock);
+	}
+
+	xa_destroy(&cxl_snoop_filters);
+}
+
+static void cxl_snoop_filter_free(void *data)
+{
+	struct cxl_cache_state *cstate = data;
+	struct cxl_snoop_filter *sf;
+
+	sf = xa_load(&cxl_snoop_filters, cstate->snoop_id);
+	if (!sf)
+		return;
+
+	guard(mutex)(&sf->lock);
+	sf->size += cstate->size;
+}
+
+int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds)
+{
+	struct cxl_cache_state *cstate = &cxlds->cstate;
+	struct cxl_snoop_filter *sf;
+
+	sf = xa_load(&cxl_snoop_filters, gid);
+	if (!sf)
+		return -ENODEV;
+
+	guard(mutex)(&sf->lock);
+	if (cstate->size > sf->size)
+		return -EBUSY;
+
+	sf->size -= cstate->size;
+	cstate->snoop_id = gid;
+	return devm_add_action_or_reset(cxlds->dev, cxl_snoop_filter_free,
+					cstate);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_snoop_filter_alloc, "CXL");
+
+int cxl_dport_setup_snoop_filter(struct cxl_dport *dport)
+{
+	struct cxl_port *port = dport->port, *parent_port;
+	struct cxl_snoop_filter *sf;
+	u32 snoop, gid, size;
+	int rc;
+
+	/* Only supported by CXL-enabled PCIe root ports */
+	parent_port = parent_port_of(port);
+	if (!parent_port || !is_cxl_root(parent_port))
+		return 0;
+
+	if (!dport->reg_map.component_map.snoop.valid) {
+		dev_dbg(dport->dport_dev, "missing snoop filter capability\n");
+		return -ENXIO;
+	}
+
+	rc = cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_SNOOP));
+	if (rc)
+		return rc;
+
+	snoop = readl(dport->regs.snoop + CXL_SNOOP_GROUP_ID_OFFSET);
+	gid = FIELD_GET(CXL_SNOOP_GROUP_ID_MASK, snoop);
+
+	snoop = readl(dport->regs.snoop + CXL_SNOOP_FILTER_SIZE_OFFSET);
+	size = FIELD_GET(CXL_SNOOP_FILTER_SIZE_MASK, snoop);
+	if (!size)
+		return -ENXIO;
+
+	sf = cxl_create_snoop_filter(dport, gid, size);
+	if (IS_ERR(sf))
+		return PTR_ERR(sf);
+
+	dport->snoop_id = gid;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dport_setup_snoop_filter, "CXL");
+
 DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
 
 static int cxl_einj_inject(void *data, u64 type)
@@ -1202,6 +1338,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	dport->dport_dev = dport_dev;
 	dport->port_id = port_id;
 	dport->port = port;
+	dport->snoop_id = CXL_SNOOP_ID_NO_ID;
 
 	if (rcrb == CXL_RESOURCE_NONE) {
 		rc = cxl_dport_setup_regs(&port->dev, dport,
@@ -1686,10 +1823,17 @@ static int update_decoders_with_dport(struct cxl_port *port, struct cxl_dport *d
 static int cxl_port_setup_with_dport(struct cxl_port *port,
 				     struct cxl_dport *dport)
 {
+	int rc;
+
 	device_lock_assert(&port->dev);
 
 	cxl_switch_parse_cdat(dport);
 
+	rc = cxl_dport_setup_snoop_filter(dport);
+	if (rc)
+		dev_dbg(dport->dport_dev,
+			"failed to set up snoop filter capability: %d\n", rc);
+
 	return update_decoders_with_dport(port, dport);
 }
 
@@ -2711,6 +2855,7 @@ static void cxl_core_exit(void)
 	bus_unregister(&cxl_bus_type);
 	destroy_workqueue(cxl_bus_wq);
 	cxl_memdev_exit();
+	cxl_destroy_snoop_filters();
 	debugfs_remove_recursive(cxl_debugfs);
 }
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 5ca7b0eed568..0c8962fcad9b 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -92,6 +92,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_SNOOP:
+			dev_dbg(dev, "found Snoop filter capability (0x%x)\n",
+				offset);
+			length = CXL_SNOOP_FILTER_CAPABILITY_LENGTH;
+			rmap = &map->snoop;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -211,6 +217,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.snoop, &regs->snoop },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1771c42a1e3b..2881e0826829 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -40,6 +40,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_ID_SNOOP 0x9
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -151,6 +152,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXL_HEADERLOG_SIZE SZ_512
 #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
 
+/* CXL 3.2 8.2.4.23 CXL Snoop Filter Capability Structure */
+#define CXL_SNOOP_GROUP_ID_OFFSET 0x0
+#define   CXL_SNOOP_GROUP_ID_MASK GENMASK(15, 0)
+#define CXL_SNOOP_FILTER_SIZE_OFFSET 0x4
+#define   CXL_SNOOP_FILTER_SIZE_MASK GENMASK(31, 0)
+#define CXL_SNOOP_FILTER_CAPABILITY_LENGTH 0x8
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -214,6 +222,7 @@ struct cxl_regs {
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *snoop;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -256,6 +265,7 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map snoop;
 };
 
 struct cxl_device_reg_map {
@@ -658,6 +668,8 @@ struct cxl_rcrb_info {
 	u16 aer_cap;
 };
 
+#define CXL_SNOOP_ID_NO_ID (-1)
+
 /**
  * struct cxl_dport - CXL downstream port
  * @dport_dev: PCI bridge or firmware device representing the downstream link
@@ -682,6 +694,7 @@ struct cxl_dport {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 	int gpf_dvsec;
+	int snoop_id;
 };
 
 /**
@@ -756,6 +769,7 @@ struct cxl_dev_ops {
 struct cxl_cache_state {
 	u64 size;
 	u32 unit;
+	u16 snoop_id;
 };
 
 /**
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index a707e402b000..c4862f7e6edc 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -25,4 +25,7 @@ int cxl_accel_get_cache_info(struct cxl_dev_state *cxlds);
 struct cxl_cachedev *devm_cxl_add_cachedev(struct device *host,
 					   struct cxl_dev_state *cxlds,
 					   const struct cxl_dev_ops *ops);
+
+int cxl_dport_setup_snoop_filter(struct cxl_dport *dport);
+int devm_cxl_snoop_filter_alloc(u32 gid, struct cxl_dev_state *cxlds);
 #endif
-- 
2.34.1

