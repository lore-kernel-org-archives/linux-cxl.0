Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3B281508
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897295; cv=fail; b=U7GzPdwprsuzSPiACsAtd+h8L09hTZ8OW1ycZgSc58/6oZk3zy3S+qR7zuDgM9CcbZ4AndqBehwz66W7WNLHie4gcmb7k2NMiRCfKeNnUnZWvA9DLX6ZwjlnyDpubMLr/XumqtXRecnQArZ9uuAlCECswj6D7r345kaKJGWnKnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897295; c=relaxed/simple;
	bh=mE0zIOXxP1uacbDnrwnXYcNXFEfJcsH096JIssSO0OQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PytzZ2dLsuNBXRxzu5N3nWxZtM2md2JoaVt6K01VBxsCmcY8d2qcO46rfk1Ik4OU4M2Anj5XrFw2JulxS4E9MQMrzYCton15Wv+FVJKN3X6llFT7mL8RyqO+9Ol1g7se1YlKsfQU9hIq8AtJliPiP/TNAHAX7qq5Ea1SFNEf7GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IdRU4ZuL; arc=fail smtp.client-ip=52.101.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IdRU4ZuL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOQsaJHyHUKFi1oo2a5spTJdqaL8IeH0TJ8KQuTGfGEWYy2jP4C9jepIrOcjpqCouh56MsbGtGm1qxWI+K1VwKHuWY7n6Qme7Z9uiiKU4J1cSXPlA3P2uJC1qTECHrXAz2ROXBAksYpw/Fr2S7SdJWT2+gFgK2+VsO0OWJ5qlFsHbJb56grF5honpalNEWwigj30VGidF8wiejmfi138mPHaTyemY3vEPEXNL27Ym2WYBxI9OR48DYMAOmZo0MQ4Vd8E+1hkn591cAuM007qX5LqmuMYIbLQqAQIof69GqxJb8Nm1URLQnAeKvtQGbw4k+l+dAH01uTRDS8kHxj/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmz4PggW6esBMclzeR7MXfItP7g+/W1fo8mf8NIVhKg=;
 b=hyU0jHHCtEKWo1aVPwv7EVY0v2Mw3YePHMxPXoMJDoDf/tEcULSGoEkRIAzBORR9Kzwo050q7wv/YgUcgCa03dolQr2JzC/jjO7opU4Plgwk644NBOQ80VAKGw1KkvnUCCC9kjlDadGpxB4HRcgW8bYeaAowJk15KeyyagqIGg+ZyNv6adhxZS5XAch/gptUY9rmQgeEG/q/bjKpJQcn8HNdLo5AZIks4jfSv/tp2IdTM9Yyauo3kQ5K2C74QgH5oHGJxdQgN7j8+vNldhPTz95Tj0DgQn+gbHrOr44o3oeuGetClucgXQK9bJqM2KeYrMQd6oz9vL8Ezrpp3VQc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmz4PggW6esBMclzeR7MXfItP7g+/W1fo8mf8NIVhKg=;
 b=IdRU4ZuL88Fq/GURGe8Lwjm6FZxhq2nrhrvoUftwco5vLlFGqdu30jTVjbmmPquatEh+jeW+oDmgLcND2C7e0YL76HwFDN1OZ0mJ/fELLEL3UtSgsRuBv44lpGzJlhSj+HnDCfCVZaxbg/zVpaTYZaQc7y8dqEBL2+6bqu4NuFI=
Received: from BL0PR1501CA0030.namprd15.prod.outlook.com
 (2603:10b6:207:17::43) by DM4PR12MB8451.namprd12.prod.outlook.com
 (2603:10b6:8:182::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:41:26 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::11) by BL0PR1501CA0030.outlook.office365.com
 (2603:10b6:207:17::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 21:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 21:41:25 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 13:41:25 -0800
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <linux-cxl@vger.kernel.org>
CC: <benjamin.cheatham@amd.com>
Subject: [PATCH 03/17] cxl/core: Add function for getting CXL cache info
Date: Tue, 11 Nov 2025 15:40:18 -0600
Message-ID: <20251111214032.8188-4-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2b8cdf-1ad1-44da-0ffe-08de216b10b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/A1xPDRCzMMDRHSQe7lMIStte6lzSBSxAQJoL5w8CuhuwtlAJa3CqsfY5GH?=
 =?us-ascii?Q?bjEcKZ9BwXG/PQpdoDwnn/wl9ma8hDTn5aBo1nX9wIKn/ZCFOAu5xNMTg50o?=
 =?us-ascii?Q?MHT19gvZ+47zdhd3CN2hfHI6eXOxvNKNJ+d4rcVYNIF6acAW4IkrMyUoRmO9?=
 =?us-ascii?Q?94DcRo0fCiyAmSCrum5q8y93pcOvO3fA3EcVGB/1dceS1niSQW6Xf3D5xQOv?=
 =?us-ascii?Q?eYLOfQAKiKyrXN/ijwZ3hug7qvI2b7OqvjJ7fvMj+Iz0N+j1dIXRE3VJgzFD?=
 =?us-ascii?Q?Eoqn9aYckQOtbX5FwjGodg5NYi1IvNh4r82+Ga5/B0LYLq+82PWlggmO2wSK?=
 =?us-ascii?Q?gvfd5GFOhtwaXkHmXKET0KJ76Zt3aqVRohxYAnesSa625m05oaPkst2Xc+xC?=
 =?us-ascii?Q?ebEQgqwdYeJCavSzkpySNzPJyPLSD8XJ5fm3/Kl0nt/S5PQhNuIIUlzLv3YJ?=
 =?us-ascii?Q?xBq4bwaOxKeHpn1pDPCnxHSyR2v7sMH0asVpl1/HmAKmirPw307tSerCn9dZ?=
 =?us-ascii?Q?qgmktclxeJ52Zp2quOnlYgzev48pU5h7UOC6Nkw29QceiBke7YRoFCXRcG7P?=
 =?us-ascii?Q?JOkHv7hN7dPoa06wKZP59TGST6jC8z3i9Jup5EiYDGf8bPJtdve1/p8WF+Gu?=
 =?us-ascii?Q?tEEhp/FrA1EM73xe5NR0nLdJR8mj0vnStMxWWvr1Iey7FmEvrY4gXcmpxfYv?=
 =?us-ascii?Q?7lkGTj88lrJVNSey3Z4gB1Z49SPids3SP+kjtVYQxZNQYPzMjtkPBk8QxKft?=
 =?us-ascii?Q?cMLJfxjZ97kMLSxsaV5QkJhJfa33mhSGWUo3s8goVE/jc8Y/IhxT4FRze3YD?=
 =?us-ascii?Q?H6v3Zu5lNNaFblSSu8c0C134JoF75bUuDNW6cQ0cEwqHosuE+eYscyiJxIlG?=
 =?us-ascii?Q?cEnJN1txdEW+I9tx2V2eSIio45JrbOz8CmWI5VoMhBxquZAfdRrsKLu20yFt?=
 =?us-ascii?Q?+xBVHx6UTI/tVvxsMqO9JWms5B3B62ICOfow3FR5/WXcFpdR+hwOBOgxU1Ww?=
 =?us-ascii?Q?rifKVlTWbqG+qMfHOj4P5tWiy7bbfk2499coLpPfWyJd9P3YYmrGQHlNLgTg?=
 =?us-ascii?Q?hSQ3DHp2/d6lRIQ7E4e9DsEFuFBVss2WhRNGQfuqFO8OxRlejciUvC4k9GCF?=
 =?us-ascii?Q?r09EuaXfSjhbVBw6ctfJvboZIJxOQwlCSNLzUBP/rmCzY5H989cVZGoGHzee?=
 =?us-ascii?Q?sMlcesXpNtRiv7mmzSHY6Qaom4fzm6KRs2BumDjfhSRNTUUedqBI3jUB6g6H?=
 =?us-ascii?Q?JQo40r50eb7DlzB56V+cV4NWhXCG1jnLiYHSKrMc2+U7IPhP1RwyWjswUV7D?=
 =?us-ascii?Q?U1T3AKWXAfdJctizTa+cXNUEUmNhxQfb7LNH4I2FbiZwlt+d/4jCgVXXt+x5?=
 =?us-ascii?Q?ceXwN3sk6voBPxdY7WO93ixSzoqey0yR8IvKFRkhayTYHVpVA7aXPXAlvMBp?=
 =?us-ascii?Q?LBgXN9aPBrshx1atNUn9nlVdigurMe+87delpow8kDCBcBwpvqKbRLyPuhp8?=
 =?us-ascii?Q?34+Ve6XiUkjvbVWtwR06WrNjw4yNKMWMJfeTt3GtG4Bg8BBMZr9oukgwWls3?=
 =?us-ascii?Q?CV4TDCx39RUxau5hAAI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:41:25.8076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2b8cdf-1ad1-44da-0ffe-08de216b10b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451

Add a function for getting common CXL.cache information. This
information will be stored in the struct cxl_cache_state member
(cstate) of struct cxl_dev_state for easy access by endpoint drivers.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/pci.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      | 13 +++++++++++
 drivers/cxl/cxlcache.h |  7 ++++++
 drivers/cxl/cxlpci.h   |  4 ++++
 4 files changed, 77 insertions(+)
 create mode 100644 drivers/cxl/cxlcache.h

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 18825e1505d6..5b1cace8fc0f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
+#include <cxlcache.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1258,3 +1259,55 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
 
 	return ctx.count;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_port_get_possible_dports, "CXL");
+
+/**
+ * cxl_accel_read_cache_info - Get the CXL cache information of a CXL cache device
+ * @cxlds: CXL device state associated with cache device
+ *
+ * Returns 0 and populates the struct cxl_cache_state member of @cxlds on
+ * success, error otherwise.
+ */
+int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds)
+{
+	struct cxl_cache_state *cstate = &cxlds->cstate;
+	struct pci_dev *pdev;
+	int dvsec, rc;
+	u16 cap, cap2;
+
+	if (!dev_is_pci(cxlds->dev))
+		return -EINVAL;
+	pdev = to_pci_dev(cxlds->dev);
+
+	dvsec = cxlds->cxl_dvsec;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	if (!(cap & CXL_DVSEC_CACHE_CAPABLE))
+		return -ENXIO;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAP2_OFFSET, &cap2);
+	if (rc)
+		return rc;
+
+	/* CXL 3.2 8.1.3.7 DVSEC CXL Capability2 for encoding */
+	switch (FIELD_GET(CXL_DVSEC_CACHE_UNIT_MASK, cap2)) {
+	case 1:
+		cstate->unit = 64 * SZ_1K;
+		break;
+	case 2:
+		cstate->unit = SZ_1M;
+		break;
+	default:
+		return -ENXIO;
+	}
+
+	cstate->size = FIELD_GET(CXL_DVSEC_CACHE_SIZE_MASK, cap2) * cstate->unit;
+	if (!cstate->size)
+		return -ENXIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_read_cache_info, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1950cf3d5399..259d806fb3e3 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -759,6 +759,17 @@ struct cxl_dpa_info {
 	int nr_partitions;
 };
 
+
+/**
+ * struct cxl_cache_state - State of a device's CXL cache
+ * @size: Size of cache in bytes
+ * @unit: Unit size of cache in bytes
+ */
+struct cxl_cache_state {
+	u64 size;
+	u32 unit;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -779,6 +790,7 @@ struct cxl_dpa_info {
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  * @cxl_mbox: CXL mailbox context
+ * @cstate: CXL cache state and capabilities
  * @cxlfs: CXL features context
  */
 struct cxl_dev_state {
@@ -795,6 +807,7 @@ struct cxl_dev_state {
 	u64 serial;
 	enum cxl_devtype type;
 	struct cxl_mailbox cxl_mbox;
+	struct cxl_cache_state cstate;
 #ifdef CONFIG_CXL_FEATURES
 	struct cxl_features_state *cxlfs;
 #endif
diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
new file mode 100644
index 000000000000..8f8597755947
--- /dev/null
+++ b/drivers/cxl/cxlcache.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __CXL_CACHE_H__
+#define __CXL_CACHE_H__
+#include "cxl.h"
+
+int cxl_accel_read_cache_info(struct cxl_dev_state *cxlds);
+#endif
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 7ae621e618e7..18230e4f677c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -17,10 +17,14 @@
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_CACHE_CAPABLE	BIT(0)
 #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
 #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
+#define   CXL_DVSEC_CAP2_OFFSET		0x16
+#define     CXL_DVSEC_CACHE_UNIT_MASK	GENMASK(3, 0)
+#define     CXL_DVSEC_CACHE_SIZE_MASK	GENMASK(15, 8)
 #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
 #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
 #define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
-- 
2.51.1

