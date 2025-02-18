Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7F26AAB3;
	Tue, 18 Feb 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885125; cv=fail; b=mUNjCyjYwZFheHKr0ter5+EFjPGp5Okn97iTYrkV/8DlUBoN0iph5NOR+s91lLe3rZlCEsfUvhrffE+VcfPZ3iv3xeyiXREBHasXkzoyNpypCpJUiMpkQIjEjzZEhX6btUxn8RHrjd2MpJ8gVxd66aQDZfJn6zcfezM2eS3Cjm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885125; c=relaxed/simple;
	bh=fa5c7xBPLAfEWNSGl+prHVcVGECpVcLCCb1EkkfnH+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOqpXxd2LDnUzVYOTZttPszCCqZDaHdRS/7D4D+J043lFliwLY8IMLlE43qUz/vjDuHH+3qNI/dqhvFfMr9LQNP+elECD7KTCBnqDihYKqSMo57oka57PL8IWaAs88zjr7PExoAKt9yKIExYWYu/amMmISnovV4a8PZqVYQdX1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m8nxQ2vj; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m8nxQ2vj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q92Vmrixa4FDxs5liQrw8vnyCNmExBRvzllU4thz7AlZhveuf/ZtznS60ZhkDwtCEjx/f2C7W1JDLznkBnM9OOLIAfVTH7dAtm3LZxLh/RTr+X4kIVradiAVZxzqp8Ky8EyhfhpLZfQNuEVTUrR+DpwYfePP6i5KwW13cYNOTOwLsRPQctOA6bpu6P1P0buzUTZzzdeSPAyPM9eFWH2Lr3WPoryIvbWwmEZZLcwtd0hbEHa0WGEyyT/Od7BL5iwDgkgjfWrnar4DgUzFs2EYzPndnU79r7d/BXlVkpQXyJtyft0srTzkflOKonVhQ58LUXySdk+s4Ofvexv7f7vpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTPNWHIrm8GI+xXV4wqa3RQvunVrAS5lhvwzBYGzJkA=;
 b=yHQ+qGi3oxmzbvAV9t4tbN9+RgTPLhWbJx0ZMUSSXd/qzT5LECMFhhLpmrCA/cKlLTULfk/j+9a1KqmQQ6ekm6My0cbxBNw3+/at4bEnoMWSvps7xqqcZ9VYrQ1itdc2MBECVR29QcQGkGB95RAKwd6kfvN8GhEMbc0mBX3xx85FA8Vu/hrtkItm/f0eYT/+BRE6io1Y7lp0NVar6AUZA3mQ3ntVzHtYfs1ZM/21EH1mYVWYgU/1p8/XtiTduQuo6uPzLlkVPFDs2OjHdIvlCfEZoOe/sDsJjs3RoNb0t1dZcxdETp8hyhBB8RMF+LGAZ/6Iu41a4P9sW6o2BGvleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTPNWHIrm8GI+xXV4wqa3RQvunVrAS5lhvwzBYGzJkA=;
 b=m8nxQ2vjZptOuxWI//HFFqokN4RCQqvzcdHmuvfq6GANZZ+FgARsbS61PAr+En1XijFT5VTPPoyLpweml6703nBQHgFXJc0D8CU0m8/qbOy5kwsjOfQu/hnnRsen3I1j50z6LagYxSzPPGZ9vShR5EG0R34fajhMgED6ZRIjmME=
Received: from BN1PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:e1::18)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 13:25:20 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::26) by BN1PR12CA0013.outlook.office365.com
 (2603:10b6:408:e1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 13:25:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:25:20 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:25:17 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 13/15] cxl/x86: Prepare for architectural platform setup
Date: Tue, 18 Feb 2025 14:23:54 +0100
Message-ID: <20250218132356.1809075-14-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: a9632fd2-e973-402a-977c-08dd501fb112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0RLuPwYnNzZw6Gob5nWZeWPgZe+oHbtMUBp3/QTDh3leGex2CGOoIBICUz29?=
 =?us-ascii?Q?VGE84hDLo99zE2EtEOb4RFc6iitfLZusc8HhhOLUxF7ONAHR6kC4ma+yGOJ/?=
 =?us-ascii?Q?VfSuiUEPV9xVu4LqFxAv1BgafmJk/Fhgp1U8/4VyQctaW21CqP3dgGZjtWrN?=
 =?us-ascii?Q?N3KqvMZR03AjYGPLpA9iZ81f+VIwhGxsXL0lHhul/VhrlfNfnXFG36lxYNZZ?=
 =?us-ascii?Q?MxcDzU0xdxX8zFgjeNgMoWVKfkq35ax6NeUH9Y6MnpYRy7Cp5XBijqj5gaLg?=
 =?us-ascii?Q?BWXiPO0ZTE2p+v0kG5BLYw7yzky+QuwLAn722iojckTJRuZ3mAxDETFEcCr1?=
 =?us-ascii?Q?sca9l3jWcEFTblG6jj6u9i2Cz7EanieXt/qucIlyPW15i+JBRasjWoIUchal?=
 =?us-ascii?Q?6ds9v0kVEsOHeBQGxrv5yATu1qAOFtkFT0wfxFeX2FZpiAN2R2ru+4P+pAW8?=
 =?us-ascii?Q?9UKg8jwRRWw83pwkLKq7sAo1vAdIzjK+/0WiZvh6baQ0Eqmp6ly7FqBN4Wm6?=
 =?us-ascii?Q?piusgrkAkzgdFGmfWydy+JOmaomILubjq0H0YRb6deD2BMBWwK9reCa8dTvM?=
 =?us-ascii?Q?pDbRtJppMUZ0NIGNBnRirRF1SD9JC1eNwNzh44O7Fcg/XHrWRzwGA1UncWFn?=
 =?us-ascii?Q?Ahv8IsLWucX0RbkC4dLZCck+D7axzOD4bxdm1NprnadG0VG7wyP9YtRAnoBR?=
 =?us-ascii?Q?OyoK/wUwkiWeHUFBH1od4MW0lqDwteHve1WHeAH0K+zKglJRsw6/jpIpLcME?=
 =?us-ascii?Q?iZg/O2ftDzPzvItjoYTTu1BvUDIu8JJgvTuOE0lbfrXXqbhhjwKQGjCjFmLc?=
 =?us-ascii?Q?6xOI9EACkVL7kZx1Ss4eavTcwSyWj90TvKCh66S30AlEgZm6kj8wyiCBXJGr?=
 =?us-ascii?Q?fLfVMg2/6kLcM/OKff/Y9HDAZj31g0kmwo87i1bn+calDOZHiDMHJ+mUkjqP?=
 =?us-ascii?Q?U3ySBUX2pyEOP9vXUG7gKyy/YXcedIneBHydFmoA0zvHMzMcjCDf6YTbKqy4?=
 =?us-ascii?Q?9YPsFZjlx4e4MSB10p98vPTvtVyYNFtazG+cOnN5SgisOcDFgmWkB3B9eBb3?=
 =?us-ascii?Q?VOtGn4GI1FmyYxbFrfCo/suDhQmY9ppLwYIkPikE7s8ph4gQfw7WS9A0pmBb?=
 =?us-ascii?Q?hR12rdwrQwHtWpN9vBlgGyQhncWqT6q4dsjOpEauhzbwX+HqdgqDk3s4Z1yQ?=
 =?us-ascii?Q?wBpeLyXnaJsEfHk4jrURytGc5/Xjo3yCc9EmdmyCT8d6Mbjb4ZDRUyxw/dGZ?=
 =?us-ascii?Q?Bl2GDli+2XkIpJa+E1FXtKO+2mTWHSkfYMhQd2aokDspWlOGZkzv6UnI3iG6?=
 =?us-ascii?Q?VeS9Dqy1andcta0sHSRfWAYwfL9xyaHTFffltWhmeytc5k6xsGhR6QmcTBVF?=
 =?us-ascii?Q?dw2t4gFiyEHXjmj1yfwmWaf1f6PI9s/W34KxhU4AJAGCFO7iwLg1BiE7FDc0?=
 =?us-ascii?Q?h6poVf5nDwoaof+MehEnrZOhw9+qQ0HLYiu24Tc76O3n4JrA5pGIvlknkBiY?=
 =?us-ascii?Q?yuGHHvo+BREIIO0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:25:20.1159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9632fd2-e973-402a-977c-08dd501fb112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432

In preparation of an architectural, vendor and platform specific port
setup, add a function arch_cxl_port_platform_setup() that can be used
to handle and implement architecture and platform specific code.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/Makefile     |  2 ++
 drivers/cxl/core/core.h       |  1 +
 drivers/cxl/core/port.c       |  4 ++++
 drivers/cxl/core/x86/common.c | 12 ++++++++++++
 4 files changed, 19 insertions(+)
 create mode 100644 drivers/cxl/core/x86/common.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..db1d16d39037 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -16,3 +16,5 @@ cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+
+cxl_core-$(CONFIG_X86)		+= x86/common.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a20ea2b7d1a4..e2955f91fd98 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -118,5 +118,6 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
 int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
+void arch_cxl_port_platform_setup(struct cxl_port *port);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d19930c009ce..e94671ea8455 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -841,6 +841,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
+void __weak arch_cxl_port_platform_setup(struct cxl_port *port) { }
+
 static int cxl_port_add(struct cxl_port *port,
 			resource_size_t component_reg_phys,
 			struct cxl_dport *parent_dport)
@@ -878,6 +880,8 @@ static int cxl_port_add(struct cxl_port *port,
 			return rc;
 	}
 
+	arch_cxl_port_platform_setup(port);
+
 	rc = device_add(dev);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/core/x86/common.c b/drivers/cxl/core/x86/common.c
new file mode 100644
index 000000000000..eeb9bdadb26d
--- /dev/null
+++ b/drivers/cxl/core/x86/common.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <cxl.h>
+
+#include "../core.h"
+
+void arch_cxl_port_platform_setup(struct cxl_port *port)
+{
+}
-- 
2.39.5

