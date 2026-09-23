Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84E39A4A4
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184844; cv=fail; b=TvrTOuj454cZNkfnLLXM0l/DRgz2jCBvv6JYubUAQx0jcYXRYs8ozESUyMoGo+cN4ZOWfby8PkXd0w+bMfr3IuIUdE2OdoQVnr/6n2mFkf1Au6jnAMNyuKzTpUpRZiMcw7yQwm3X5n/yHoKGpxXG6UMbqBqWdc0uFoSLlZ5dsuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184844; c=relaxed/simple;
	bh=Q8JlIVODPROWuL3o8GCCrYzGd737u+45YLvUebJXD9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fi1txwQmYyKAat1wFFU/pdKbbqzkXT111/x+mv9YM5X4sqgAZG5yhfwrgNaTLyhfrlZd5k8lBIYl5CR2kL65s8fHqKC5HiAmBW5dWUiTPSFO5gdtcyqG9LxcwoD6E/DtsCeywAYg+7tgv/N1giRZ1As9gPm8k3y/U+elUYS7Q4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iV8Ox0au; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iV8Ox0au"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga3w0X0dXxkDeVWzguzkIxc1rNSNaDMD+ZQvY+ruVZH+0Eh/2E8e5mv0rPx3C9zxk0yP5bcj93Tv/ebOydmr+plc+3LxQOdRd9C7Vn8BBKTLFyynSoy1jfmyWpa0EN8eEE6uIDcfEiyX0L2En6ax0jvc3DqrNL2kR4K6q+zUBr8cHlpEJjVGlSXz96iwN2v08aKDdhMQyIvZKEp1u8C2vk2LV3kYwZh6Nmkt4B1BIsZ3mmEujirCSXddpJwrLsPaZ6Nb9WMH4XHCF8SV2GkjDVGTyGEtmSvbljeVpCP1ltLuzDUrYrUmsvMzyD9ttIWF8eUb9V84vK4RprsPUY13Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6btHCZkKE4mO4JBywfFdsCkCGccH4ntgx0+Lryw9LyY=;
 b=cKcSCVXGUo2+9oic3hp5klyE2Kyzs9V3qCTUWXP1bkRk7OT2V6EluARpfNWxfx+waIvZysDlKfxu+HYoLaHeGdxb7uLSAHi2oYrtBbkt2wH8wkTuZW2H1HjD3i0+Vk8wt8XMtipS8cdnfFKIzL3kmU17qHqRvM8jQtLzkUXS6VsJOxmEFI+TstGzPjB3wdGlfs0niM4PhrNUYDW0eV6Lf4dzj2KnjQ0n3s4hzlGMaZC0pZ/dT1Aw3mcJcIRth0FqVMBvrUKdeTMSxm7pqhCTL7iUmTmwOW0FBR0xesNaourAX9lPvpK5Qo3BJ99Q5IQt016GlBTHuyiVRNLGc7qS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6btHCZkKE4mO4JBywfFdsCkCGccH4ntgx0+Lryw9LyY=;
 b=iV8Ox0auNPNFCXc3Ta9UpBBT8Z1ooJjza71oUYQ1HoH+fQCMR3ENkpDHF1B4ZfwmmM14GTzwDhyn85ILjS9RlaBFw9r1Oe6bG7/ax6IvS8KjNdcqjQ0tQLT7IWvimx9wEO6D6jsSIiNkA/TlwgDGRdiAm8PJ39n8L9qIj+YwNmM=
Received: from CH2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:610:4d::11)
 by IA1PR12MB310634.namprd12.prod.outlook.com (2603:10b6:208:5a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:33:55 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::74) by CH2PR19CA0001.outlook.office365.com
 (2603:10b6:610:4d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.15 via Frontend Transport; Wed,
 23 Sep 2026 17:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 17:33:55 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 12:33:54 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <jic23@kernel.org>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>
CC: <linux-iommu@vger.kernel.org>, <benjamin.cheatham@amd.com>,
	<terry.bowman@amd.com>, <robert.richter@amd.com>
Subject: [PATCH 08/15] cxl/core, cache: Add Cache ID register probing and init
Date: Wed, 23 Sep 2026 12:33:35 -0500
Message-ID: <20260923173342.5584-9-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|IA1PR12MB310634:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8f1e26-e50d-4c14-994a-08df1998d7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gKdJHQHXxW+gtVaOUPN5DJJHarhwx6aNP1KsaeFHVQ3NKBTYpymANBW+x2UWQXw5hEWe6AL7eTgml9WpTrjFi4eyliS4nxfXf/gpN4zAB1e761kTEy8zCkDvSdntEzJiOHsrOpNb59X25Oo+9deGf6dhRLBTED0BcJib1buqoFNhyCJ4lyIsBCUrHiSx6qp9qFvpv/PYly1AL3duzk9143T/7RTs+PZDLgVLmlmtrAuYTpH4zOmBipqbpH6Mly1WTVmq9IJC3m2KddENCDImX/Pjyj/vfsuhCc/XhqJscQKFL8sQ5R+LgEQy2AvYwxvrYlHV01c6eXSuEjLfUkYOZN4X/5eI5LkYGxva3DdbaH1xxJceq88wZFbZYnIDEUGGAZUyQGqbDNwNzxMG8HIdT19lIdSH1CO+R/DRjJvViPzNH6vCDgrdOn5l5bANLXbf4MlFWtnMlDYOfqa4y1ZCk38m3NfrsUDxiiNZYCYmwb7D93d3rxkplRrI2AWMHBlKUcLFdWiA691h53BoqVzkzvWRAVcUN49lg/9SfRqyAMcdWePN5IGrlf0Q8rgXhSPYKI3pSp85+PEj5VluI/MU81w4SGkl+lMKMCMYK2guKHhP7+cmtFNgAxZj8bK56Jgt8VzOEbi2upjy9dAaOraXcl0sACHgimLXIyB4snSlwN6XMVyT3oB6JugchpkR1syvgC4s6Uu0tUuOm228hyiCrA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jQK57OD2a3XypT48oLE8JMicmTzYbAKwD02XjJEMcUOeBQYrZL6XhRyiBBklSRhQIyEI0wVToo9IdiCU1ATaV7Lq8NTNIbvGXGB7IADoAwtcyk+zKDn/86Q9btjuk/eiTC1I2ITTx1qqbs996NqyGa208pUk5gnJxl7AkfjwPEM2fS3FvTCgr3qugMDCvpgT5aONdy9naYWbIFeZXb+tuvDmmZsSa/xlDeXCcYzl204lIudQ3iGgXrvWJF6U4h6OnZHO2Dn/jDQMEeK+fDQoX2Lm1H1wsyy7u5E4IoNQpAjawyfajJi64seY2/m0ynYyC0dTMED7HSKzqjj9vppmUB4mjiymecqBdwg2xWTqupuKREykRp+oDsSFf6gT5PKGacRpJ8f8vsr5NyVAupvhJozoPuq0OAx9zb6LVUDCQZpBKqOquEUYTQ2rkDD5Qjme
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:33:55.7444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8f1e26-e50d-4c14-994a-08df1998d7ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB310634

The CXL Cache ID Route Table capability (CXL 4.0 8.2.4.28) and CXL Cache
ID Decoder capability (CXL 4.0 8.2.4.29) are optional capabilities that
are required when more than one CXL.cache device is enabled under a host
bridge.

Probe for cache id route table and decoder registers as part of
cxl_probe_component_regs(). Map these registers, if found, as part of
cxl_port probe.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/cache.c  | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c   |  5 +++++
 drivers/cxl/core/regs.c   | 23 ++++++++++++++++++++++
 drivers/cxl/cxl.h         | 21 ++++++++++++++++++++
 drivers/cxl/port.c        |  6 ++++++
 include/cxl/cxl.h         |  6 ++++++
 7 files changed, 103 insertions(+)
 create mode 100644 drivers/cxl/core/cache.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index f51575abe5af..33420aaf40db 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -15,6 +15,7 @@ cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
+cxl_core-y += cache.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o region_pmem.o region_dax.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
diff --git a/drivers/cxl/core/cache.c b/drivers/cxl/core/cache.c
new file mode 100644
index 000000000000..17df0e603b68
--- /dev/null
+++ b/drivers/cxl/core/cache.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) Advanced Micro Device, Inc. */
+
+#include <linux/pci.h>
+#include <cxlcache.h>
+
+#include "cxlpci.h"
+
+int cxl_port_map_cache_id_rt(struct cxl_port *port)
+{
+	struct cxl_register_map *map = &port->reg_map;
+
+	if (is_cxl_root(port) || is_cxl_cachedev(port->uport_dev))
+		return -EINVAL;
+
+	if (!dev_is_pci(port->uport_dev) ||
+	    !cxl_pci_flit_256(to_pci_dev(port->uport_dev)))
+		return -EINVAL;
+
+	if (!map->component_map.cidrt.valid)
+		return -ENXIO;
+
+	return cxl_map_component_regs(map, &port->regs,
+				      BIT(CXL_CM_CAP_CAP_ID_CACHE_ID_RT));
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_port_map_cache_id_rt, "cxl_port");
+
+int cxl_dport_map_cache_id_dc(struct cxl_dport *dport)
+{
+	struct cxl_register_map *map = &dport->reg_map;
+	struct cxl_port *port = dport->port;
+
+	if (is_cxl_root(port) || is_cxl_cachedev(port->uport_dev))
+		return -EINVAL;
+
+	if (!map->component_map.ciddc.valid)
+		return -ENXIO;
+
+	return cxl_map_component_regs(map, &dport->regs.component,
+				      BIT(CXL_CM_CAP_CAP_ID_CACHE_ID_DC));
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f6e981d87088..6da11d28bb5e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1271,6 +1271,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (!dport->rch)
 		devm_cxl_dport_ras_setup(dport);
 
+	rc = cxl_dport_map_cache_id_dc(dport);
+	if (rc)
+		dev_dbg(dport->dport_dev,
+			"Failed to map cache id decoder capability: %d\n", rc);
+
 	/* keep the group, and mark the end of devm actions */
 	cxl_dport_close_dr_group(dport, no_free_ptr(dport_dr_group));
 
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..2809c72fb2eb 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -93,6 +93,27 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			length = CXL_RAS_CAPABILITY_LENGTH;
 			rmap = &map->ras;
 			break;
+		case CXL_CM_CAP_CAP_ID_CACHE_ID_RT: {
+			int target_cnt;
+
+			dev_dbg(dev,
+				"found Cache ID Route Table capability (0x%x)\n",
+				offset);
+
+			target_cnt = FIELD_GET(CXL_CACHE_ID_RT_CAP_TARGET_CNT,
+					       hdr);
+			length = 0x10 + 2 * target_cnt;
+			rmap = &map->cidrt;
+			break;
+		}
+		case CXL_CM_CAP_CAP_ID_CACHE_ID_DC:
+			dev_dbg(dev,
+				"found Cache ID Decoder capability (0x%x)\n",
+				offset);
+
+			length = CXL_CACHE_ID_DC_CAPABILITY_LENGTH;
+			rmap = &map->ciddc;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -212,6 +233,8 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
 		{ &map->component_map.ras, &regs->ras },
+		{ &map->component_map.cidrt, &regs->cidrt },
+		{ &map->component_map.ciddc, &regs->ciddc },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9711b8499508..9f0c1a39aaeb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -41,6 +41,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 
 #define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
+#define   CXL_CM_CAP_CAP_ID_CACHE_ID_RT 0xD
+#define   CXL_CM_CAP_CAP_ID_CACHE_ID_DC 0xE
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
@@ -223,6 +225,15 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define   CXLDEV_MBOX_BG_CMD_COMMAND_VENDOR_MASK GENMASK_ULL(63, 48)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
+
+/* CXL 4.0 8.2.4.28.1 CXL Cache ID Route Table Capability Structure */
+#define CXL_CACHE_ID_RT_CAP_OFFSET 0x0
+#define   CXL_CACHE_ID_RT_CAP_TARGET_CNT GENMASK(4, 0)
+#define CXL_CACHE_ID_RT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
+
+/* CXL 4.0 8.2.4.29.1 CXL Cache ID Decoder Capability Structure */
+#define CXL_CACHE_ID_DC_CAPABILITY_LENGTH 0xC
+
 void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
@@ -930,4 +941,14 @@ struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
 
 u16 cxl_gpf_get_dvsec(struct device *dev);
 
+#if IS_ENABLED(CONFIG_CXL_CACHE)
+int cxl_port_map_cache_id_rt(struct cxl_port *port);
+int cxl_dport_map_cache_id_dc(struct cxl_dport *dport);
+#else
+static inline int cxl_port_map_cache_id_rt(struct cxl_port *port)
+{ return -ENXIO; }
+static inline int cxl_dport_map_cache_id_dc(struct cxl_dport *dport)
+{ return -ENXIO; }
+#endif
+ 
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 44d978d4205a..942b92af55d9 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -281,6 +281,12 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
 		 * on failure, or the device does not implement RAS registers.
 		 */
 		devm_cxl_port_ras_setup(port);
+
+		rc = cxl_port_map_cache_id_rt(port);
+		if (rc)
+			dev_dbg(&port->dev,
+				"Failed to map cache id route table capability: %d\n",
+				rc);
 	}
 
 	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 29c0687e4ac2..7a5ed64904a6 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -34,10 +34,14 @@ struct cxl_regs {
 	 * Common set of CXL Component register block base pointers
 	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
 	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
+	 * @cidrt: CXL 4.0 8.2.4.28 CXL Cache ID Route Table Capability Structure
+	 * @ciddc: CXL 4.0 8.2.4.29 CXL Cache ID Decoder Capability Structure
 	 */
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
 		void __iomem *ras;
+		void __iomem *cidrt;
+		void __iomem *ciddc;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -80,6 +84,8 @@ struct cxl_reg_map {
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
 	struct cxl_reg_map ras;
+	struct cxl_reg_map cidrt;
+	struct cxl_reg_map ciddc;
 };
 
 struct cxl_device_reg_map {
-- 
2.53.0

