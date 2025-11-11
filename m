Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3E281508
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897258; cv=fail; b=ItIXLxWovgB/DzJkcjGAs7WqK23Zte1DEU+jOEVrEhNya4FyiRi5GobSrfUJzfBiaMkotqPOJ0Kq3FzNULmgpaYyANHc5qf7iPiueuIQleCeijEVL8o0LPC7DsDF5JRodAnURptrtXKnjgBJQOWiX6sUbUQxol93FjgEpy+CeVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897258; c=relaxed/simple;
	bh=rSTvSJ9CoShQNtAyclIXdrSnavq93EsLjG1EPHgualI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkpccuvQRLW3tHPMsq22KF55CWZzHQhQX2zMeOu8dn8XB0onj7W2R+EobqhoaJgVuhqlmSY+uBPifI1JcNCk1pdDpe5RIkRUv4XvMmYlw0OPPJS8AdAxmDomiRuAQ3dHu7S93+4RRWLvX1Ekm//3Eugz3ATOFXrVoe1MdRfFQnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TbVRtm7l; arc=fail smtp.client-ip=40.107.209.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TbVRtm7l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTopn0nfXNs7Zlva1XmdpfQA2SpTIE/Pyjd3yTpSSBp7P+e/zfluTZ8wO4l7Zm3al4R6O9aM0PCwhpgZ6Tbzo4ESH05bkpNO0r6AtDAOX6ihYl1QFDEgN3ZFSjuuS1nj1jQ6h70jN38Gm9TkRGJOqP1fLn/fVZJSuyvHZyZmBmBgNSe9lus1OcdRrlK19eRKvWTREvckQ/t/CJjlzCxQgAGfLNxAOkr7RkS7lNeyVFhfkNL3jTzf8K0yU17Tdr3ru9vEdNVAM20c17iO+8fJ6uBSQwfpacczhgK4Z8lPyvSCSW0LdMgyWLq4XSLz/x+HirUve9IN+xopfy77DWRsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YSAtvUVKKAVLmStPELtM9gBKiQpJTA7K/kmwhPmmYQ=;
 b=yj5e1C5Ta27Nb33JOc2EkZmn/8ncy2ZoEH6PyqtDFjN2fIAyHvzm3aexVfYTTzu8dY7JR0rDRdKT9IADgFgOBpLmwAFcQL0pbpoHjT6V6/VOI2uTwxTevAJAootU/sngavcU+aAGa0yGOJyvTrpJS5JW4z2RB+B9ekuu73Os5a2axEQL9D3YsTs7zEdlSo5o1mCD39NOlS+b2okjHZwE/EO2Tkkv86MkCOnDPnKJwUu+k5eMfmyb2sjdNXuBMmc1VP5VJc+B5InmSNdxroaHD20LCAUETgEzhEMUx+XDzH5MvMz7iwSBykYv2l7ugqlyPWdc3NB4l/4NQEsC3VVZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YSAtvUVKKAVLmStPELtM9gBKiQpJTA7K/kmwhPmmYQ=;
 b=TbVRtm7lju3vD2x2O933MU1GST9UYvD4Cm1mDFC/1xVkjJOm64rmxhu7++Ix0uNh7iEuEXS7XwjhkbiNdOT3kYDon6hb6qDiMGPp1lDNNxOw3TqJEhPU+01FZD7L8g176l8swV2VuFutVtHw+azZBSC3fV2gNMbl7PQIoEw2jKI=
Received: from BN0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:408:ec::16)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 21:40:54 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::d6) by BN0PR04CA0101.outlook.office365.com
 (2603:10b6:408:ec::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 21:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:40:54 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:40:53 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 01/17] cxl/port: Arrange for always synchronous endpoint attach
Date: Tue, 11 Nov 2025 15:40:16 -0600
Message-ID: <20251111214032.8188-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4df50d-a14a-4496-c454-08de216afdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtweRiDaDgUh0gS6PlSdnBFK9u2efbOITLgQmzreNLyy9D+ea5Rx6gUwZ4MB?=
 =?us-ascii?Q?g7HNVVp83wZx5/SIPxRpjM0W4WmbyF9CwzSlNzdvsL1HuafFj5KTxLt08Wpe?=
 =?us-ascii?Q?c3sXWDBMgmTQHQjg4vxjPNRZjwgvVofAQT6aD2tVH8aXWT8Q4Rvoc3+kBEKA?=
 =?us-ascii?Q?/Bsmgdis2Gl/L6f3ze/wenlVGNdBPL1vmT/r/Z9TD5+dE5tMvVYt8Nt9VVvU?=
 =?us-ascii?Q?yROzDQ1FZEnwrt663176FfYQWsusSfG2X78nizkhi4Dc4+IIw1iTDiNDEYLO?=
 =?us-ascii?Q?WlO4Qg+bgId0Yfp3E8pkmyi3cvNEK3A6Vh9wqr53IppWm4qd664dyOZlZecY?=
 =?us-ascii?Q?V7436CPW9kPEhuTAuH6EHTKKGbibRiICqUtmjseJxCL4qj/7wk0rDkta3R8H?=
 =?us-ascii?Q?V4SllrGO15w5wv2ygtVORSmCSmPGR21YJyjNGpq/28le5vzcg+hU71ZT7BMc?=
 =?us-ascii?Q?9b6sjda+nkjV6R1f/yhrGWSGC7Jn0vCxqU8vHzpf/wflWv1IcqhLO36heq1h?=
 =?us-ascii?Q?jsEMguSuyVMx+AkwUUeE4AiLXZ8AAJjxZtc4NkPavypOSUHsE8bwuwj5AYj1?=
 =?us-ascii?Q?nLE+CgKZIKz6RXlE7zV+iYot8WfaJw710NDzhU4F6RU9eQ530w/NWNlDuQcW?=
 =?us-ascii?Q?YlOatKTrZv/LYNrDQXRIiIE0rj6g5SVwaz4cypyK1sKFwnJ9pGS4l7/RFqNE?=
 =?us-ascii?Q?8JSqIn7nE3mzsBEdE4zqvX2n8zKY9/fO8Ab+F2t0O8Bta5qv59X3sveK8h6L?=
 =?us-ascii?Q?5d3RsCH1qSke/3pcgFeltsrQjLty6kjSpJd7yCE1NFXivZAKGxU8iHex1J+Q?=
 =?us-ascii?Q?kLV5sY4HijZPxi2J0UbKK0DnMmMbpcEFPtwVoXPN6PEMI4/68W8LXqodPpdY?=
 =?us-ascii?Q?c5xwLqLgcR5pu6W5hcB/dbDE+seVTcsNq9IhW1T3ObGuPwCTo4imEtJUpjak?=
 =?us-ascii?Q?1X0Y+pK8H/pyf3zUO+fzxpLBUo5HoYJhVVLzQUFlpyU/kjJ3ynY4zjVVDo5q?=
 =?us-ascii?Q?sgwSSCRmrhYu7TcXonwyOYSnGykL5JBLTsPUQMJYRidPhp6V5RZEWUSE9J3n?=
 =?us-ascii?Q?wEZFfEo9i9eIT1gBVqw0d4j5ByVfwIeagIfhbfmkBCadJ5GiJF+qXh/q2qV8?=
 =?us-ascii?Q?E/OOYL0Y/9PiNMPrPpT3iiwTO8e4vI1gerIjZ6px9fvFJIxSXngQU2w7qG3Q?=
 =?us-ascii?Q?waGNWBjWT4NX4IzcYJ+OvDVQfditny26pF+cOr52DABGWIEOrlyyp+3XVqsI?=
 =?us-ascii?Q?wgSk4I1ZrnEmczHtcxzmG97vZhn7+nllMlHRdX7Ug+P+odjqoqnB3NEN/Ll9?=
 =?us-ascii?Q?0XsDheF5Ry0yV1BnuhjBoyFlcWoP5U3ggzvV8bulGgcyoKCvOhFpyqrLVidg?=
 =?us-ascii?Q?YlFBVtHC1GlhfVmYqT7iiUEE2FDkHrQnHtGwR5ROP9m1y3EyavDidy30Mv5/?=
 =?us-ascii?Q?T9B9itH/Mz4Yq08LMDu8yb8+IuSTHzv29W5yBjnQgYPiiNNKbGHesbyQLE69?=
 =?us-ascii?Q?BNOHVjnD4OFv+A6xFZsmAd2HR1/ts6JMzCXl+AbzfhX+9D4bzYya2ruP94jj?=
 =?us-ascii?Q?uSjqLQxZi5CzT71sXyM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:40:54.1130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4df50d-a14a-4496-c454-08de216afdcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125

From: Dan Williams <dan.j.williams@intel.com>

Make it so that upon return from devm_cxl_add_endpoint() that cxl_mem_probe() can
assume that the endpoint has had a chance to complete cxl_port_probe().
I.e. cxl_port module loading has completed prior to device registration.

MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
dependency is reliable.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

This patch is just for context, I'm aware that Smita is picking this up
in her soft reserve set.

---
 drivers/cxl/mem.c     | 44 +------------------------------------------
 drivers/cxl/port.c    | 41 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/private.h | 15 +++++++++++++++
 3 files changed, 57 insertions(+), 43 deletions(-)
 create mode 100644 drivers/cxl/private.h

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6e6777b7bafb..e49d57bee2e9 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "private.h"
 #include "cxlmem.h"
 #include "cxlpci.h"
 
@@ -45,44 +46,6 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-				 struct cxl_dport *parent_dport)
-{
-	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_port *endpoint, *iter, *down;
-	int rc;
-
-	/*
-	 * Now that the path to the root is established record all the
-	 * intervening ports in the chain.
-	 */
-	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
-	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
-		struct cxl_ep *ep;
-
-		ep = cxl_ep_load(iter, cxlmd);
-		ep->next = down;
-	}
-
-	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
-				     parent_dport);
-	if (IS_ERR(endpoint))
-		return PTR_ERR(endpoint);
-
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
-	if (rc)
-		return rc;
-
-	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
-			dev_name(&endpoint->dev));
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
@@ -258,8 +221,3 @@ MODULE_DESCRIPTION("CXL: Memory Expansion");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("CXL");
 MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
-/*
- * create_endpoint() wants to validate port driver attach immediately after
- * endpoint registration.
- */
-MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 51c8f2f84717..d5fd0c5ae49b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 
 /**
  * DOC: cxl port
@@ -156,10 +157,50 @@ static struct cxl_driver cxl_port_driver = {
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_port_attribute_groups,
 	},
 };
 
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport)
+{
+	struct cxl_port *parent_port = parent_dport->port;
+	struct cxl_port *endpoint, *iter, *down;
+	int rc;
+
+	/*
+	 * Now that the path to the root is established record all the
+	 * intervening ports in the chain.
+	 */
+	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
+	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_ep *ep;
+
+		ep = cxl_ep_load(iter, cxlmd);
+		ep->next = down;
+	}
+
+	/* Note: endpoint port component registers are derived from @cxlds */
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
+				     parent_dport);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	if (rc)
+		return rc;
+
+	if (!endpoint->dev.driver) {
+		dev_err(&cxlmd->dev, "%s failed probe\n",
+			dev_name(&endpoint->dev));
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_endpoint, "CXL");
+
 static int __init cxl_port_init(void)
 {
 	return cxl_driver_register(&cxl_port_driver);
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
new file mode 100644
index 000000000000..ff517452e735
--- /dev/null
+++ b/drivers/cxl/private.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2025 Intel Corporation. */
+
+/*
+ * Private interfaces betwen common drivers ("cxl_mem", "cxl_port") and
+ * the cxl_core.
+ */
+
+#include "cxl.h"
+
+#ifndef __CXL_PRIVATE_H__
+#define __CXL_PRIVATE_H__
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport);
+#endif /* __CXL_PRIVATE_H__ */
-- 
2.51.1

