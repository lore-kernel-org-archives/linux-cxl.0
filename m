Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CCB6D1AF
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847146; cv=fail; b=W7hrfSlpaCoFBlG0Pd2z1ayX45lBtBRcWCgw87sm9NS+FCn3picYfRAK0hA8fW0KKzIsyRxps9o8zyIHXAdc901j5kCN6DGdNiei0o+DLhjEPvw8v12koa4Pj6AU3Cg1bgNXynsHvGxXIhi1I3K9pvS/QSiaq6ZRwa0NdjVEado=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847146; c=relaxed/simple;
	bh=sYtScOyt2+HUl8hlmRirCLGYcJyJ7c+fT2UyEdgaqww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/oHacIAJT6ca4lEAhGsCZu99cSCh6N8gYbMSwHPcH4iJQkKluGNGrilUpICNy8LRS2njCXnAmdnRG92REODqDkn1Ua6kbfP5B2x01ar1lKVDITvHlmyEi3HmfFCU8nq2KDY3FC9ws+5ohdHvVt57ZkHCLX74OquweaVlvcqTik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K93DKNWn; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K93DKNWn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFdyzEd82VvyRyOSziNDETpwct+id8ZKiVM5nJXlp49Ph4YuxAf+a/R9dTMkYWs/9VGEbESRbg3Iyd60j1MkpkBiTRT5d7rDC7CmQB0hXejJXzM09n3cabIdCP5F9OGJcXFOs4Tu5+hPAaZqH85J+GI4oplXvQpzkWkFcVizffNfZObdFSMYoOJxNi0neEGe4d31n/YdvDaXtLXQFkdZmEFHvPAa6kl7BhO8N0wZ07Cw24k8c3AHK5HvjAh+ZzUg078fnLfxDAOibc+mQ/cd/yZsXLdth/GzHKW5Wj1SYZn9qRXGXsVPbeX/5gkwnupoSgqVUFgzb/HreFFoBOBiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3phZK3QgOJ4Pl9zYuH99pBW0qIbJp8+/7ufTT+RyRQw=;
 b=ZT1jSyOjenoRtiQJcyPED8VN7NladYHRVFeoOXVHcBuD0Fj8eqGKB3N6TutkwyP+58pz9SK67sImmj8veOTbC/VT/yVZIuhZNXW1ErdxYp3bX4nLara/vNuSOOlMWmyyHKKNUDntWGyVpL50amjEF8GVXKjnFefdcprwNjQF0FIaKUIA4ggBK5a2friZmQO9FBPOYOGD8t/xk+BQCh1F1siNEYoMHKzdUKepgAxm9hrafQ7S3kaYue2lQhK/+nJy0fgy2iZu1ENl0/XrshrZcS/hZ7+iYH2jRb3/exZ1YX2vmLS6GxJ5drwENzGeH0mORxvqtsljhUWUyzB1urY9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3phZK3QgOJ4Pl9zYuH99pBW0qIbJp8+/7ufTT+RyRQw=;
 b=K93DKNWnvkvKNjoHnE0OdehHuSjWZCsYEidCRKl1stTTWE2dcetbzJeNr6vTXnagqOuwKECJ9ZsGvpffKKEIbdvhrsyRhsoxT4JY/t/ZkL6hrF3mDeHIJDDHZIjX5wGmlPFxhF11p6wY61fA7weqmHl4u0ittzJX3xQGS6bMOAc=
Received: from BN8PR04CA0036.namprd04.prod.outlook.com (2603:10b6:408:70::49)
 by DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.30; Thu, 16 May 2024 08:12:19 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:70:cafe::1) by BN8PR04CA0036.outlook.office365.com
 (2603:10b6:408:70::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.29 via Frontend
 Transport; Thu, 16 May 2024 08:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 08:12:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 03:12:16 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 03:12:16 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<pieter.jansen-van-vuuren@amd.com>, <richard.hughes@amd.com>,
	<dinan.gunawardena@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC PATCH 01/13] cxl: move header files for absolute references
Date: Thu, 16 May 2024 09:11:50 +0100
Message-ID: <20240516081202.27023-2-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240516081202.27023-1-alucerop@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd61ccd-481b-4824-78e0-08dc757fe7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oXfbYf1hDgvY0Jqs+OIjs3RmYMUUgpl8cmfaZG7Xd9Ctuz37W/KRU7oboF8G?=
 =?us-ascii?Q?MPBQVqbm3+p34VTp4NeiXsTJdS6ALsrM+w++D7uEBA8JGXsR52qUqHj6AMK2?=
 =?us-ascii?Q?iCfXa3qabE71sK1x6LgSoFHystCTISGM7XDNGRGZ5/K30Qy/OOZ7a5Iomyjr?=
 =?us-ascii?Q?5556Jv7cp0SbNcEbpuApfskAjdjZUCMXbGKeX5OseZaT9nsqZqwcdcXyI3og?=
 =?us-ascii?Q?FTNmtlFqBtOFhCEvaRIIHl7Y98+/2FoQeyo+26kmfe/VXN+LXt3IgFGNrqw4?=
 =?us-ascii?Q?w84Wv8gK8SjBduEhWmQOxC0M1/LZ9YhYYXecBmzsmP/DK0Wifty6y3RQnLZ4?=
 =?us-ascii?Q?Ie8TijwmhmGI8+yOPbt9qWE+OeXr18WBeMSGwKZiwCHkK6H7yRgZwV5ousXM?=
 =?us-ascii?Q?u7APowFciHewZ+eFgubVOogw66l/C7IACAsfK7cuXyLmeKcrfJyrGAShLvNn?=
 =?us-ascii?Q?zd3TkXuJIZTnQ/Dc7CxgIERr673C5/Bgq4ei64mJwHwR4mGNKpsTjcZymCD2?=
 =?us-ascii?Q?LPcntL5M0H4C+bIkoyCZ9lsU4m8Lz1jqH8mZMpR5ZibdrdMzr3sAzeZk9Vpe?=
 =?us-ascii?Q?lr1n3WGuH/mK7ZbyM8Y94p8Oc+BS8q0Gh4bflCZpODDPo5pHho0L6ojo5BBr?=
 =?us-ascii?Q?AgVP0yYkrCV0Oi5+hvYwWd7OcfKR2LG5bCsAzsCtUVgac2VOf4lvytVcig53?=
 =?us-ascii?Q?6uwrPUrwo+mxs94143FYI81taEsmlVxaZAWbbLIEDungzq9zY5wGgl+Ld9J1?=
 =?us-ascii?Q?WOIEsOee8GBFNiW2VO0YNyswsM1oEpH01TpIfiRzdTDJZrgFI+8qXQ76f8yf?=
 =?us-ascii?Q?3mDDpzuj0WGEHaJ7h0OZW53vnZuCl+riR9Nwbdy2ZjIOMMct4Cwh6ncPdloL?=
 =?us-ascii?Q?XLa2DsOXbxevuGjNEbrmEsnzUvdhJhdP/id6jt/1t5zPlxoYncsI5p0vOeoM?=
 =?us-ascii?Q?gNnqIDZ+8I33sbDUX/jLORaqw1sqmY/rDb/ab2orFEQZ7nMYgcKeMbkBfvJi?=
 =?us-ascii?Q?vnEf5d3CCO80Mf8a13Qcqb0h0pO+ALngetotHXALXC7G23UU7Fd2YZayBRvL?=
 =?us-ascii?Q?N8V2r5DwKLVkLqy89V10wJdRjlzWHqgufZ07Bfl8quLxz9z9GBAcST6XuiDs?=
 =?us-ascii?Q?OwxCGwOlx6hgnGG62Y2ZAgiaPPLM0UXLszVS4u0iRC7bQKGIsVyTVBRCfQHJ?=
 =?us-ascii?Q?U9+Fm9loNwquN8fZE2/rYl044eitkdzBuwPFkvx0Drh/XrBtIb9Ytt9HFrS2?=
 =?us-ascii?Q?5G8YJ7LMaOtXJ/IfZtr5PjmbGf0sPGYQ5iSzkzpPGeRdVHnRHGwSdDs0V+3Q?=
 =?us-ascii?Q?bRH/+nO7pHFPkomf776mItgeyODOe1FMZ3C62+zxwmHmx/h0yzFIZ1awmDDI?=
 =?us-ascii?Q?K8KvYIO1GhWQ2UKiW3Jz+YksiLBN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:12:19.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd61ccd-481b-4824-78e0-08dc757fe7ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256

From: Alejandro Lucero <alucerop@amd.com>

CXL Type 2 devices imply specific vendor drivers binding to those
devices instead of generic ones offered by CXL core like the PCI driver.
Those drivers need to use CXL core functions and structs for
initialization, create memdevs and create CXL regions.

This patch avoids referencing those files based on relative paths from
inside the kernel sources tree.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/acpi.c                      | 4 ++--
 drivers/cxl/core/cdat.c                 | 6 +++---
 drivers/cxl/core/hdm.c                  | 2 +-
 drivers/cxl/core/mbox.c                 | 6 +++---
 drivers/cxl/core/memdev.c               | 2 +-
 drivers/cxl/core/pci.c                  | 6 +++---
 drivers/cxl/core/pmem.c                 | 4 ++--
 drivers/cxl/core/pmu.c                  | 4 ++--
 drivers/cxl/core/port.c                 | 6 +++---
 drivers/cxl/core/region.c               | 4 ++--
 drivers/cxl/core/regs.c                 | 4 ++--
 drivers/cxl/core/suspend.c              | 2 +-
 drivers/cxl/core/trace.c                | 2 +-
 drivers/cxl/core/trace.h                | 4 ++--
 drivers/cxl/mem.c                       | 4 ++--
 drivers/cxl/pci.c                       | 6 +++---
 drivers/cxl/pmem.c                      | 4 ++--
 drivers/cxl/port.c                      | 4 ++--
 drivers/cxl/security.c                  | 4 ++--
 drivers/dax/cxl.c                       | 2 +-
 drivers/perf/cxl_pmu.c                  | 4 ++--
 {drivers/cxl => include/linux}/cxl.h    | 0
 {drivers/cxl => include/linux}/cxlmem.h | 2 +-
 {drivers/cxl => include/linux}/cxlpci.h | 0
 tools/testing/cxl/cxl_core_exports.c    | 2 +-
 tools/testing/cxl/mock_acpi.c           | 2 +-
 tools/testing/cxl/test/cxl.c            | 2 +-
 tools/testing/cxl/test/mem.c            | 2 +-
 tools/testing/cxl/test/mock.c           | 4 ++--
 tools/testing/cxl/test/mock.h           | 2 +-
 30 files changed, 50 insertions(+), 50 deletions(-)
 rename {drivers/cxl => include/linux}/cxl.h (100%)
 rename {drivers/cxl => include/linux}/cxlmem.h (99%)
 rename {drivers/cxl => include/linux}/cxlpci.h (100%)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index cb8c155a2c9b..f023898382bc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -8,8 +8,8 @@
 #include <linux/pci.h>
 #include <linux/node.h>
 #include <asm/div64.h>
-#include "cxlpci.h"
-#include "cxl.h"
+#include <linux/cxlpci.h>
+#include <linux/cxl.h>
 
 #define CXL_RCRB_SIZE	SZ_8K
 
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bb83867d9fec..97ff1dfd63d6 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -5,10 +5,10 @@
 #include <linux/fw_table.h>
 #include <linux/node.h>
 #include <linux/overflow.h>
-#include "cxlpci.h"
-#include "cxlmem.h"
+#include <linux/cxlpci.h>
+#include <linux/cxlmem.h>
 #include "core.h"
-#include "cxl.h"
+#include <linux/cxl.h>
 #include "core.h"
 
 struct dsmas_entry {
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..47d9faf5897f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -4,7 +4,7 @@
 #include <linux/device.h>
 #include <linux/delay.h>
 
-#include "cxlmem.h"
+#include <linux/cxlmem.h>
 #include "core.h"
 
 /**
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f0f54aeccc87..d312b82f7f36 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -5,9 +5,9 @@
 #include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <asm/unaligned.h>
-#include <cxlpci.h>
-#include <cxlmem.h>
-#include <cxl.h>
+#include <linux/cxlpci.h>
+#include <linux/cxlmem.h>
+#include <linux/cxl.h>
 
 #include "core.h"
 #include "trace.h"
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index d4e259f3a7e9..07cd0b8b026f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -7,7 +7,7 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
-#include <cxlmem.h>
+#include <linux/cxlmem.h>
 #include "trace.h"
 #include "core.h"
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0df09bd79408..a494a03b4a83 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -7,9 +7,9 @@
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
-#include <cxlpci.h>
-#include <cxlmem.h>
-#include <cxl.h>
+#include <linux/cxlpci.h>
+#include <linux/cxlmem.h>
+#include <linux/cxl.h>
 #include "core.h"
 #include "trace.h"
 
diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index e69625a8d6a1..d1a5f8d9cf91 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -3,8 +3,8 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
-#include <cxlmem.h>
-#include <cxl.h>
+#include <linux/cxlmem.h>
+#include <linux/cxl.h>
 #include "core.h"
 
 /**
diff --git a/drivers/cxl/core/pmu.c b/drivers/cxl/core/pmu.c
index 5d8e06b0ba6e..aa02ea582184 100644
--- a/drivers/cxl/core/pmu.c
+++ b/drivers/cxl/core/pmu.c
@@ -4,9 +4,9 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
-#include <cxlmem.h>
+#include <linux/cxlmem.h>
 #include <pmu.h>
-#include <cxl.h>
+#include <linux/cxl.h>
 #include "core.h"
 
 static void cxl_pmu_release(struct device *dev)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 762783bb091a..fdd76306260d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -11,9 +11,9 @@
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/node.h>
-#include <cxlmem.h>
-#include <cxlpci.h>
-#include <cxl.h>
+#include <linux/cxlmem.h>
+#include <linux/cxlpci.h>
+#include <linux/cxl.h>
 #include "core.h"
 
 /**
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..70e86a7c241d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -9,8 +9,8 @@
 #include <linux/uuid.h>
 #include <linux/sort.h>
 #include <linux/idr.h>
-#include <cxlmem.h>
-#include <cxl.h>
+#include <linux/cxlmem.h>
+#include <linux/cxl.h>
 #include "core.h"
 
 /**
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 3c42f984eeaf..fd165e718cf2 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -4,8 +4,8 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
-#include <cxlmem.h>
-#include <cxlpci.h>
+#include <linux/cxlmem.h>
+#include <linux/cxlpci.h>
 #include <pmu.h>
 
 #include "core.h"
diff --git a/drivers/cxl/core/suspend.c b/drivers/cxl/core/suspend.c
index a5984d96ea1d..117b3398ee56 100644
--- a/drivers/cxl/core/suspend.c
+++ b/drivers/cxl/core/suspend.c
@@ -2,7 +2,7 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/atomic.h>
 #include <linux/export.h>
-#include "cxlmem.h"
+#include <linux/cxlmem.h>
 
 static atomic_t mem_active;
 
diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
index d0403dc3c8ab..1e6ba0de237a 100644
--- a/drivers/cxl/core/trace.c
+++ b/drivers/cxl/core/trace.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
-#include <cxl.h>
+#include <linux/cxl.h>
 #include "core.h"
 
 #define CREATE_TRACE_POINTS
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e5f13260fc52..e3b1156a01ad 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -10,8 +10,8 @@
 #include <linux/pci.h>
 #include <asm-generic/unaligned.h>
 
-#include <cxl.h>
-#include <cxlmem.h>
+#include <linux/cxl.h>
+#include <linux/cxlmem.h>
 #include "core.h"
 
 #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0c79d9ce877c..6dc2bf1e2b1a 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -5,8 +5,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
-#include "cxlmem.h"
-#include "cxlpci.h"
+#include <linux/cxlmem.h>
+#include <linux/cxlpci.h>
 
 /**
  * DOC: cxl mem
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2ff361e756d6..ccde33ac9c1c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -11,9 +11,9 @@
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/io.h>
-#include "cxlmem.h"
-#include "cxlpci.h"
-#include "cxl.h"
+#include <linux/cxlmem.h>
+#include <linux/cxlpci.h>
+#include <linux/cxl.h>
 #include "pmu.h"
 
 /**
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 7cb8994f8809..deadc5ffc2c2 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -8,8 +8,8 @@
 #include <linux/async.h>
 #include <linux/slab.h>
 #include <linux/nd.h>
-#include "cxlmem.h"
-#include "cxl.h"
+#include <linux/cxlmem.h>
+#include <linux/cxl.h>
 
 extern const struct nvdimm_security_ops *cxl_security_ops;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 97c21566677a..928ebff774ce 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -4,8 +4,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-#include "cxlmem.h"
-#include "cxlpci.h"
+#include <linux/cxlmem.h>
+#include <linux/cxlpci.h>
 
 /**
  * DOC: cxl port
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 21856a3f408e..129b36928a05 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -6,8 +6,8 @@
 #include <linux/async.h>
 #include <linux/slab.h>
 #include <linux/memregion.h>
-#include "cxlmem.h"
-#include "cxl.h"
+#include <linux/cxlmem.h>
+#include <linux/cxl.h>
 
 static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 						 enum nvdimm_passphrase_type ptype)
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index c696837ab23c..89a5c8eb666e 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -3,7 +3,7 @@
 #include <linux/module.h>
 #include <linux/dax.h>
 
-#include "../cxl/cxl.h"
+#include <linux/cxl.h>
 #include "bus.h"
 
 static int cxl_dax_region_probe(struct device *dev)
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 308c9969642e..9b93ba215bdb 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -20,8 +20,8 @@
 #include <linux/bug.h>
 #include <linux/pci.h>
 
-#include "../cxl/cxlpci.h"
-#include "../cxl/cxl.h"
+#include <linux/cxlpci.h>
+#include <linux/cxl.h>
 #include "../cxl/pmu.h"
 
 #define CXL_PMU_CAP_REG			0x0
diff --git a/drivers/cxl/cxl.h b/include/linux/cxl.h
similarity index 100%
rename from drivers/cxl/cxl.h
rename to include/linux/cxl.h
diff --git a/drivers/cxl/cxlmem.h b/include/linux/cxlmem.h
similarity index 99%
rename from drivers/cxl/cxlmem.h
rename to include/linux/cxlmem.h
index 36cee9c30ceb..0d26a45a4af2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/include/linux/cxlmem.h
@@ -8,7 +8,7 @@
 #include <linux/rcuwait.h>
 #include <linux/cxl-event.h>
 #include <linux/node.h>
-#include "cxl.h"
+#include <linux/cxl.h>
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
 #define CXLMDEV_STATUS_OFFSET 0x0
diff --git a/drivers/cxl/cxlpci.h b/include/linux/cxlpci.h
similarity index 100%
rename from drivers/cxl/cxlpci.h
rename to include/linux/cxlpci.h
diff --git a/tools/testing/cxl/cxl_core_exports.c b/tools/testing/cxl/cxl_core_exports.c
index 077e6883921d..737b49ed3e46 100644
--- a/tools/testing/cxl/cxl_core_exports.c
+++ b/tools/testing/cxl/cxl_core_exports.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
-#include "cxl.h"
+#include <linux/cxl.h>
 
 /* Exporting of cxl_core symbols that are only used by cxl_test */
 EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed, CXL);
diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
index 55813de26d46..4e440a9c0cb2 100644
--- a/tools/testing/cxl/mock_acpi.c
+++ b/tools/testing/cxl/mock_acpi.c
@@ -4,7 +4,7 @@
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/acpi.h>
-#include <cxl.h>
+#include <linux/cxl.h>
 #include "test/mock.h"
 
 struct acpi_device *to_cxl_host_bridge(struct device *host, struct device *dev)
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 61c69297e797..848c42c2c158 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -8,7 +8,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/mm.h>
-#include <cxlmem.h>
+#include <linux/cxlmem.h>
 
 #include "../watermark.h"
 #include "mock.h"
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 35ee41e435ab..dcddb6affc0d 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -9,7 +9,7 @@
 #include <linux/bits.h>
 #include <asm/unaligned.h>
 #include <crypto/sha2.h>
-#include <cxlmem.h>
+#include <linux/cxlmem.h>
 
 #include "trace.h"
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6f737941dc0e..a1366a24677f 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -7,8 +7,8 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
-#include <cxlmem.h>
-#include <cxlpci.h>
+#include <linux/cxlmem.h>
+#include <linux/cxlpci.h>
 #include "mock.h"
 
 static LIST_HEAD(mock);
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index d1b0271d2822..bf7ec147ea80 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -2,7 +2,7 @@
 
 #include <linux/list.h>
 #include <linux/acpi.h>
-#include <cxl.h>
+#include <linux/cxl.h>
 
 struct cxl_mock_ops {
 	struct list_head list;
-- 
2.17.1

