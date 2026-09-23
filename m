Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0440861C
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184868; cv=fail; b=Yyv0AC9SHGmlCGsa+v5NhLYcWDf9R7oengU6WSxYlCWcOSK7VpxZognWZPhquUXo5D6sU4aMcebXltMZPHnLIZMKc4GLH6Ty6sdOKAlf3ucfrZABNDGUm2ct4v2j+2rnC8sc8s1kiwSneHzGWDiJRATwpGG3DjAxE88lIyjjDLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184868; c=relaxed/simple;
	bh=whkZ2wR3B7sJoqTVU2R2H6KtG4mYUkQQAqaFKRK4BB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJUYswGIFRbTSwNpmIPvsthRsLSM39aJAlXWyF9cG/hmDN8jEWsu4EJ+zLQPne10dLZEX3AubwlZe9TN33uhJOTAoLbGko13LtWPfUr6bokbPKx4y/ACxyfD4aysvU2lUt9kDuI44H5yKq8YL15NY9LheSrkalTxfvMfTBMnKDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zi03V4HL; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zi03V4HL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJQjMtL+PhMkgCnw3NCv5RvAd764jeqJ3srMVQgcDOHa7+YWIvZbot/OPH1Jm/F2/ivSrOOTlOmGTi6j0lXPhU98LIItN1Pb7Bg8e0rI/KkyBYm9aM9h4P6BowiiSr5h7Pa/j0tW2ikPMU8+htQPikUQODHMNYaFlS/3VfA5FuNQqQz5uxQrq8w5rRbA8bFdqkfPFN69UYi42clTRa0tq3I0FFH5LtsLK/P2eAUpZt5n+Gcrkdzn8/CcdyakAUKGqh43qBto1SQQ6LkzrLv647AcDTNCC/idvGtcGK5sUZC7O73QqJeaY1Q2S3z3FTtTh/eZjKdd9SthluWh+Xgjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz9PDmruETcNiWhVRYTOog0pHSYVEezqM9D9KM8CeCc=;
 b=O8AxVnXDnoSmuPVXvzoSUDk4QqvHymZlB9jJCM5zT52bNDqQQaWj9pkRgcI7po88KXalu5fbdAcXI4L2L3YPmvdnMd8L/LZv6KmskqY5/HPA2vUKG51hW9hxVIZ6te1Pd5HqqjWYOhtjAbcTaA//3ibaoMKOp9fDWiYDAygYGuHjo+pCfDsrlzRgD/QFgXuDufYPEBy7dX8d5cgSMvDedynO+rHfTJfXf13QAt3qhzQD4lXCgDTF09XJyapgtbgf6GnfeupexlG4vVmnnWzZzIJNwix6ozUU79UOcujiiE36Ba0R9qs6ah0jgawJbLTjzghe5XV5dyHB9XrPYlfEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz9PDmruETcNiWhVRYTOog0pHSYVEezqM9D9KM8CeCc=;
 b=Zi03V4HLah5CofUkbMQijEwhSfFNK8mIt7FqlilgAya6dx0o/W8N44TaspeAybUp/TuFg/NLkaV5dfRB6y6lS++jVAFoziKdc45CrpLaB9u8UCh748OB+YyN2LFMhlZ5n/p+34X4UmVdM5ofsfBQBZjY4k1cRv6CMA25FkBoIj0=
Received: from CH0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:610:e6::15)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 17:33:53 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::6c) by CH0PR03CA0280.outlook.office365.com
 (2603:10b6:610:e6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 17:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:53 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:52 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 05/15] cxl/port: Split endpoint port probe on device type
Date: Wed, 23 Sep 2026 12:33:32 -0500
Message-ID: <20260923173342.5584-6-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: 3427680a-93df-413d-71bd-08df1998d68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OPimC5/NXaxMtsh2dFZhpXXWIWSyFiT62i/ThKmQfRf6yDLHon8GRdD9+wgdG3uDAl+a7Oonyk/Xizs0CD4f2ar5HwJUCYYGjMppk3owueeyhna12Ahl35QQxrdBjsP03+yVC/gogDDByP+Q5beImZn579WcNBJoorlXwoeZ5bLODHOksS2u7nsAbbUYoK6zIMGeJLIfTNXVK6m6nkToJr6gt1w+KHET5FHnxDnDf3p67fefMf3fNd2CkVI4oa6iMVjXdlWihVoUWerpfblAjHq6vSckBVwG/X0YVPDx/it6KK6pAIrpIg+woew/WCHl6mzuAmpBx4mB0Bdxl6CqgOdxnfIBqdWAbF6mJk92DB8jjW0O98HkKZnl4dIn+1EkdoP828JGIvZjJvpu1iBcwF0Vif0zaTdvVf8xBhq8Y7PMwWvl3ebznob7/oNIBIwhJHAHuvzW3++iip0Hdw0TsMN+uU7ic1nVEAyLI0Sx65/1Z6lGjOFXJlKmWS1WuzBEz54m6W6U6XQ7kZglwlKSOxAbcu+yrGg0PlXaKMQiJ2Z70sMkD/0IlZ+3J3zhRfDw9DoxWr4ppQbkyUsHHMQJPj5mqloYTvcdfG53JpKZksmBt8hPWIL2us5IAuSKd0iLmXAzugpqwCkd6hsGkCNgGJmjxxKdW1GllDgGtpfkLLuy2cc1N21KVh8z10kKn4d3r5hehP+A4kFp5KWsDQ0lLQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2hQXmVmYFJ54VXSnhqu6E3ecxoKHVv38o8LeTQ+QTkFF7GFX7Ctbof2VoPn2ibrWU8EDnR1Fa+cfvcyJdiumAaL87lFjCi0rlDKUfCLUfXAFv1HrTU/3QaluYdm+gqBFt0boJ78YsyIduJuDvH00+VS0eK9IV7ecT3qQqkKIJnD9I1falGkltOoJifnHCjUzQLPO+PioLpveSpT5kRfw2Doid3n+7EOYRGuGH6E9uYOGzKA8HaBaJSqHtL2MRwqY2J3qC1xejhvt1J54s/mgmyFSQRq2xDCIdNLeMJTFARZ9GBLRzG3q0nNH6MEj6JDr8EO3F1JhXG+bUuo0diWTtImY4LrGo7T95v4kn7WlLYgFTQ/uPKWil0gfK1nfqgWHH0IHFCp26xBGZq6Ml8XaHJ/unVSJEyq3doUlUmJ6HhBhA0+fBCQwUctCMkJkOMn4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:53.4475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3427680a-93df-413d-71bd-08df1998d68b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056

CXL.cache devices (struct cxl_cachedev) don't support or need all of the
set up done by endpoint port probe for CXL.mem devices (struct
cxl_memdev). Split endpoint port probe on device type and refactor dport
RAS set up into a common routine. The CXL.cache endpoint probe function
will be used when cxl_cachedevs are added to the port heirarchy in a
later commit.

No functional change intended for cxl_memdev path.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c         |  4 +++
 drivers/cxl/core/cachedev.c | 11 ++++++
 drivers/cxl/core/port.c     |  6 ++++
 drivers/cxl/cxl.h           |  1 +
 drivers/cxl/cxlcache.h      |  2 ++
 drivers/cxl/port.c          | 69 ++++++++++++++++++++++++++-----------
 6 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 1815ae3a37d5..2ab783f7c365 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -33,6 +33,10 @@ static int cxl_cache_probe(struct device *dev)
 	/* Disable CXL.cache until we can validate the device configuration */
 	cxl_clear_cache_enable(cxlds);
 
+	/* See comment in cxl_mem_probe() */
+	if (work_pending(&cxlcd->detach_work))
+		return -EBUSY;
+
 	rc = cxl_accel_read_cache_info(cxlds);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
index 25a24c3bd817..2bd69133c631 100644
--- a/drivers/cxl/core/cachedev.c
+++ b/drivers/cxl/core/cachedev.c
@@ -43,6 +43,16 @@ bool is_cxl_cachedev(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_cachedev, "CXL");
 
+static void detach_cachedev(struct work_struct *work)
+{
+	struct cxl_cachedev *cxlcd;
+
+	cxlcd = container_of(work, typeof(*cxlcd), detach_work);
+
+	device_release_driver(&cxlcd->dev);
+	put_device(&cxlcd->dev);
+}
+
 static struct lock_class_key cxl_cachedev_key;
 
 static struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds)
@@ -70,6 +80,7 @@ static struct cxl_cachedev *cxl_cachedev_alloc(struct cxl_dev_state *cxlds)
 	dev->bus = &cxl_bus_type;
 	dev->type = &cxl_cachedev_type;
 	device_set_pm_not_required(dev);
+	INIT_WORK(&cxlcd->detach_work, detach_cachedev);
 
 	return_ptr(cxlcd);
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 506461d5db22..125e175b1c0d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2356,6 +2356,12 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, "CXL");
 
+bool schedule_cxl_cachedev_detach(struct cxl_cachedev *cxlcd)
+{
+	return queue_work(cxl_bus_wq, &cxlcd->detach_work);
+}
+EXPORT_SYMBOL_NS_GPL(schedule_cxl_cachedev_detach, "CXL");
+
 static void add_latency(struct access_coordinate *c, long latency)
 {
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7d369030198a..5cc2fe844396 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -752,6 +752,7 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
+bool schedule_cxl_cachedev_detach(struct cxl_cachedev *cxlcd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     struct device *dport, int port_id,
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
index be6dac93b91e..e9a4567b7f2c 100644
--- a/drivers/cxl/cxlcache.h
+++ b/drivers/cxl/cxlcache.h
@@ -9,6 +9,7 @@
  * a CXL device
  * @dev: driver core device object
  * @cxlds: device state backing this device
+ * @detach_work: active cachedev lost a port in its ancestry
  * @endpoint: connection to the CXL port topology for this device
  * @id: id number of this cachedev instance
  * @depth: endpoint port depth in hierarchy
@@ -16,6 +17,7 @@
 struct cxl_cachedev {
 	struct device dev;
 	struct cxl_dev_state *cxlds;
+	struct work_struct detach_work;
 	struct cxl_port *endpoint;
 	int id;
 	int depth;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index edf0ff759fbf..7c93fabfb095 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
+#include "cxlcache.h"
 #include "cxlmem.h"
 #include "cxlpci.h"
 
@@ -26,9 +27,13 @@
  * PCIe topology.
  */
 
-static void schedule_detach(void *cxlmd)
+static void schedule_detach(void *ep_dev)
 {
-	schedule_cxl_memdev_detach(cxlmd);
+	if (is_cxl_memdev(ep_dev))
+		schedule_cxl_memdev_detach(ep_dev);
+
+	if (is_cxl_cachedev(ep_dev))
+		schedule_cxl_cachedev_detach(ep_dev);
 }
 
 static int discover_region(struct device *dev, void *unused)
@@ -118,24 +123,9 @@ static int cxl_ras_unmask(struct cxl_port *port)
 	return 0;
 }
 
-static int cxl_endpoint_port_probe(struct cxl_port *port)
+static void cxl_endpoint_setup_dport_ras(struct cxl_port *port)
 {
-	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dport *dport = port->parent_dport;
-	int rc;
-
-	/* Cache the data early to ensure is_visible() works */
-	read_cdat_data(port);
-	cxl_endpoint_parse_cdat(port);
-
-	get_device(&cxlmd->dev);
-	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
-	if (rc)
-		return rc;
-
-	rc = devm_cxl_endpoint_decoders_setup(port);
-	if (rc)
-		return rc;
 
 	/*
 	 * With VH (CXL Virtual Host) topology the cxl_port::add_dport() method
@@ -151,6 +141,27 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	devm_cxl_port_ras_setup(port);
 	if (cxl_ras_unmask(port))
 		dev_dbg(&port->dev, "failed to unmask RAS interrupts\n");
+}
+
+static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+	int rc;
+
+	/* Cache the data early to ensure is_visible() works */
+	read_cdat_data(port);
+	cxl_endpoint_parse_cdat(port);
+
+	get_device(&cxlmd->dev);
+	rc = devm_add_action_or_reset(&port->dev, schedule_detach, &cxlmd->dev);
+	if (rc)
+		return rc;
+
+	rc = devm_cxl_endpoint_decoders_setup(port);
+	if (rc)
+		return rc;
+
+	cxl_endpoint_setup_dport_ras(port);
 
 	/*
 	 * Now that all endpoint decoders are successfully enumerated, try to
@@ -161,12 +172,30 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	return 0;
 }
 
+static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
+{
+	struct cxl_cachedev *cxlcd = to_cxl_cachedev(port->uport_dev);
+	int rc;
+
+	get_device(&cxlcd->dev);
+	rc = devm_add_action_or_reset(&port->dev, schedule_detach,
+				      &cxlcd->dev);
+	if (rc)
+		return rc;
+
+	cxl_endpoint_setup_dport_ras(port);
+
+	return rc;
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
 
-	if (is_cxl_endpoint(port))
-		return cxl_endpoint_port_probe(port);
+	if (is_cxl_memdev(port->uport_dev))
+		return cxl_mem_endpoint_port_probe(port);
+	else if (is_cxl_cachedev(port->uport_dev))
+		return cxl_cache_endpoint_port_probe(port);
 	return cxl_switch_port_probe(port);
 }
 
-- 
2.53.0

