Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834C388379
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184842; cv=fail; b=XKemP4vO7a96QiJqLPLrvl+TeRWrVeAWvdW3CvUN4nJ6HU5YWQ/KU86D9SYTuT2e3rFMT4i1JIJnG0Vlj2UHfhADPNciqeuMsaIa4Uey1dFyv5qyLKfT4YVkMXgf0wZu/rUOeEvnu9VhbjEK11ZIsLcl7ArXsjRqJLCFZaxctks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184842; c=relaxed/simple;
	bh=6XOO5vwydUtGfJ2qzZNX37w7J2vmdmICbgOPpy6muKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqjfhWi5T+M/dUAKDkpapV4B4AaqRe8Rhx3vZCuNkd9MnGLlUF3iQx+uqnodFOntLmP8GB91mIH/QaJyIoDP9mLFfnfSJGNTW/ivv19AV4orkWjemgew11JR3U7nYWY6QrNbVcpj3l8w9POJhA/6Iw13hayJMawKbXFKZlWXwOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjXqchom; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjXqchom"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2suLZyANAMIJeYZPlvnEwPGEgYPgXolAscoQ3PkBcZf7CcazcnpAnnOVBH6tyqoziAxqxTlyp7UDCfEOqblD74xiXb8y8U0wBLamVATGzqkl23c7YZ8nq6B0FVKZ9NQgkTN3b7YR67rhXIP56jkzJtI0qiXpdSbBoU5sivvSkbNd0pty+stxgWhJL/9P/lfyUVWYzheUcUsT00uUI6gjwrfhjAUyjBFLvzKIcwqAvl8hpNr58mkE+z3T+by+k1IY6ZXuXdWGVUQ5yoEMJ1OYS4jfK8aVyV0UgEzFA+QpT0Rwe6K0XVQVty8VL/r32sdG9rIIfIposUO4dtJi+2Kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqLnn8AN7DzUKMTwckhssbqMggFMByP/F8ZkcDQjF+E=;
 b=Mg4HqlFAjs1tqhWOzVN/3dGMK3QrcdMq/ELFSxYJ/kxk5a2uFmTWcGPrWP88698XJlQRjpK8UcIlsHqRslq2x9uNfhsOJAXbcp3la4O89DWI0wAjSEYuF+sNTaURbXNHQ83DAr4hYO0VMXSb2LuqoN/qqZzotST/8IXfCstIVSZ2lRXDYbZcJBv/vnx5LQWIXSEZv3H9wnZp9mD2JIVw21J+auD//pJ9iijcOju9sx0Z6m0Ww8JyarVOzWGw0tIuNxBdRnKhPJmujGrTaaR2E2M7RmD2Sx0+NFe7GkXpBlIVgY57pGpZ0nTd6lmrS/Je2D2v1KRTE+uxIbkUh27K1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqLnn8AN7DzUKMTwckhssbqMggFMByP/F8ZkcDQjF+E=;
 b=yjXqchomZv9zoMvCZbem+DEyaYzGfytnOKTdPmu1DWMVDq6Gm0gAcjzOeHe5aamKyQ3qFcnCcNHTbKhWfSicxrt6yM2T9YdFWfbHCrE128mtlZFIz/HG60LKqkyWcWF8TD71LA+qRhBzB27/270Duvfaq/kHhvt9LrsGPvr5nWk=
Received: from CH0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:610:e6::10)
 by CH3PR12MB8936.namprd12.prod.outlook.com (2603:10b6:610:179::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 17:33:54 +0000
Received: from DS2PEPF000061C3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::5d) by CH0PR03CA0275.outlook.office365.com
 (2603:10b6:610:e6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 17:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C3.mail.protection.outlook.com (10.167.23.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:54 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:53 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 06/15] cxl/core: Update devm_cxl_add_endpoint() for cxl_cachedevs
Date: Wed, 23 Sep 2026 12:33:33 -0500
Message-ID: <20260923173342.5584-7-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C3:EE_|CH3PR12MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bc7817-4768-4d61-a1e4-08df1998d6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	23IJtPa4NduDlr9lSMecQDvxsY4Vm3pyhRWOxMmood0II+2QS62DAbv6mnlfd+Mvj+lqS0f1mvRTRAj6oInpl3jcrouXt1cc7Snxu0Ez/GwUExp1juhHaYs00hf4xjWzqBw+nenADRaRojZVRwzvyInbUrTjzMB2syLeMZOBpDp33wVBkFXjpxxA7eU1Dp8fF0PPN40pnAtc9WNdBsDB7NjWj/Dp1MLSktDa45oPgtizKEHbIoH3Qbs4PntE7bXMjuaxQawAbjWx+D8XsVEAKlbbTNXFRmFRZPytPNDOgecA9clSY+8WtQ6eO37HBSBU9GyWRzklvIyJgPYyjmmhjPTPDOjgCcBgpx9edpz3ACZ51euUnyQ3UGUJ2RWlncRrXiLcsi3bWvu2UY6tW95AT39T2z01kBxd9lZ3ZP9nCCE4QNMUP49kBc/+duRRBpsMAusccAKh1JBu21BSTwyjYQeL3n2vHB/s2wWBQR8/h7wgxM0WWgz8ODmaEcmXmKkUSgSTXMDQ9+5PqkPnLAbCUFHjp88DMDCqAAyKwIf1i0Ozt8z5adlEPFBFOTdJyZoiAwzuOhqN+qsQqMdvXE3rFyM4KElwPLTXneIiW6BZjbOiqkCLwgaQxgJ+yaYOI5ZRz/GYO4LtI+MECFzYVWVImtDSuW0yBL5PjtHhrDIsQtJZiuVCjylJkZBnIJDpWcCRdTleINpIrzIywuf56ybfYA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8aXGwNta30NnWcIOWBfT3+4b8se1W+UnlVYwUz5H0TY6oj7CVHHx5qvqa9nCfOEQoK6sDwCeFUFKCtCU3Wa9paM1uV1+wNQSq51v25PNYuAdVz8+BrfalZnbBz7vZYMFjkJKzubnb2N3FpYov5E1/o0BXMYmp+cOwl/Nmoi0mbfVnnu15gKaqqWVLLGYwZgD2NHn3H1BVxMMMJwks/P0RlzLzb9uyUL5mXdgRklGMqdBrIROfoYz/5iM7S1p7drcICcKd6M02Gl0cVAMuDQirXg2zdkmzEjCHRJ7mdarGkLgdYSKuXLGZBZSKrLDcp7uqlpAV3jmyqHwi/B0nbxiLOg0aqwoHZlUDyytoIs01F4f01/A/s+JpR1QEIVAp1TQs3ijokt6WpsZPI5x2KBPxQaFmuLBJjN+nIdiLghfnQ+MOAkBH/OqEHH6+OtqIfUC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:54.1642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bc7817-4768-4d61-a1e4-08df1998d6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8936

Update devm_cxl_add_endpoint() to allow for cxl_cachedevs as well as
cxl_memdevs. Add cxl_cachedevs to the port heirarchy.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/cache.c     | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c | 36 ++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h       |  6 ++++--
 drivers/cxl/mem.c       |  2 +-
 drivers/cxl/port.c      | 12 ++++++------
 5 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/cache.c b/drivers/cxl/cache.c
index 2ab783f7c365..dea5af7b2d3f 100644
--- a/drivers/cxl/cache.c
+++ b/drivers/cxl/cache.c
@@ -28,6 +28,8 @@ static int cxl_cache_probe(struct device *dev)
 {
 	struct cxl_cachedev *cxlcd = to_cxl_cachedev(dev);
 	struct cxl_dev_state *cxlds = cxlcd->cxlds;
+	struct device *endpoint_parent;
+	struct cxl_dport *dport;
 	int rc;
 
 	/* Disable CXL.cache until we can validate the device configuration */
@@ -41,6 +43,34 @@ static int cxl_cache_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	rc = devm_cxl_enumerate_ports(&cxlcd->dev);
+	if (rc)
+		return rc;
+
+	struct cxl_port *parent_port __free(put_cxl_port) =
+		cxl_cache_find_port(cxlcd, &dport);
+	if (!parent_port) {
+		dev_err(dev, "CXL port topology not found\n");
+		return -ENXIO;
+	}
+
+	if (dport->rch)
+		endpoint_parent = parent_port->uport_dev;
+	else
+		endpoint_parent = &parent_port->dev;
+
+	scoped_guard(device, endpoint_parent) {
+		if (!endpoint_parent->driver) {
+			dev_err(dev, "CXL port topology %s not enabled\n",
+				dev_name(endpoint_parent));
+			return -ENXIO;
+		}
+
+		rc = devm_cxl_add_endpoint(endpoint_parent, &cxlcd->dev, dport);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 125e175b1c0d..f6e981d87088 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1453,10 +1453,9 @@ static struct device *grandparent(struct device *dev)
 	return NULL;
 }
 
-static void delete_endpoint(void *data)
+static void __delete_endpoint(struct cxl_port **ep_port)
 {
-	struct cxl_memdev *cxlmd = data;
-	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_port *endpoint = *ep_port;
 	struct device *host = port_to_host(endpoint);
 
 	scoped_guard(device, host) {
@@ -1465,21 +1464,35 @@ static void delete_endpoint(void *data)
 			devm_release_action(host, cxl_unlink_uport, endpoint);
 			devm_release_action(host, unregister_port, endpoint);
 		}
-		cxlmd->endpoint = NULL;
+		*ep_port = NULL;
 	}
 	put_device(&endpoint->dev);
 	put_device(host);
 }
 
-int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+static void delete_endpoint(void *data)
+{
+	struct device *ep_dev = data;
+
+	if (is_cxl_memdev(ep_dev))
+		__delete_endpoint(&to_cxl_memdev(ep_dev)->endpoint);
+	else
+		__delete_endpoint(&to_cxl_cachedev(ep_dev)->endpoint);
+}
+
+int cxl_endpoint_autoremove(struct device *ep_dev, struct cxl_port *endpoint)
 {
 	struct device *host = port_to_host(endpoint);
-	struct device *dev = &cxlmd->dev;
 
 	get_device(host);
 	get_device(&endpoint->dev);
-	cxlmd->depth = endpoint->depth;
-	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
+
+	if (is_cxl_memdev(ep_dev))
+		to_cxl_memdev(ep_dev)->depth = endpoint->depth;
+	else
+		to_cxl_cachedev(ep_dev)->depth = endpoint->depth;
+
+	return devm_add_action_or_reset(ep_dev, delete_endpoint, ep_dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, "CXL");
 
@@ -1952,6 +1965,13 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
 
+struct cxl_port *cxl_cache_find_port(struct cxl_cachedev *cxlcd,
+				     struct cxl_dport **dport)
+{
+	return find_cxl_port_by_dport(grandparent(&cxlcd->dev), dport);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_cache_find_port, "CXL");
+
 static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5cc2fe844396..9711b8499508 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -734,7 +734,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
 struct cxl_root *devm_cxl_add_root(struct device *host);
-int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+int devm_cxl_add_endpoint(struct device *host, struct device *ep_dev,
 			  struct cxl_dport *parent_dport);
 struct cxl_root *find_cxl_root(struct cxl_port *port);
 
@@ -751,6 +751,8 @@ struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 				   struct cxl_dport **dport);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport);
+struct cxl_port *cxl_cache_find_port(struct cxl_cachedev *cxlcd,
+				     struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 bool schedule_cxl_cachedev_detach(struct cxl_cachedev *cxlcd);
 
@@ -788,7 +790,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
 {
 	return cxl_decoder_autoremove(host, &cxlrd->cxlsd.cxld);
 }
-int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+int cxl_endpoint_autoremove(struct device *ep_dev, struct cxl_port *endpoint);
 
 /**
  * struct cxl_endpoint_dvsec_info - Cached DVSEC info
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index b18dcce2e8a6..178ca937ee82 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -160,7 +160,7 @@ static int cxl_mem_probe(struct device *dev)
 			return -ENXIO;
 		}
 
-		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
+		rc = devm_cxl_add_endpoint(endpoint_parent, &cxlmd->dev, dport);
 		if (rc)
 			return rc;
 	}
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 7c93fabfb095..44d978d4205a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -312,7 +312,7 @@ static struct cxl_driver cxl_port_driver = {
 	},
 };
 
-int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+int devm_cxl_add_endpoint(struct device *host, struct device *ep_dev,
 			  struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
@@ -327,29 +327,29 @@ int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
 		struct cxl_ep *ep;
 
-		ep = cxl_ep_load(iter, &cxlmd->dev);
+		ep = cxl_ep_load(iter, ep_dev);
 		ep->next = down;
 	}
 
 	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
+	endpoint = devm_cxl_add_port(host, ep_dev, CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	rc = cxl_endpoint_autoremove(ep_dev, endpoint);
 	if (rc)
 		return rc;
 
 	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
+		dev_err(ep_dev, "%s failed probe\n",
 			dev_name(&endpoint->dev));
 		return -ENXIO;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL_FOR_MODULES(devm_cxl_add_endpoint, "cxl_mem");
+EXPORT_SYMBOL_FOR_MODULES(devm_cxl_add_endpoint, "cxl_mem,cxl_cache");
 
 static int __init cxl_port_init(void)
 {
-- 
2.53.0

