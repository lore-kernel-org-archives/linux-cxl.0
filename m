Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70E258CF0;
	Fri, 14 Nov 2025 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080911; cv=fail; b=AgijaANiBfjFD1wNrm8sFfEPnZZIZyoTUW1aIeXpJGp3wI8SUgNNHFRf0YAEr8+Kcmngp8RTDU2eBOsvzuDbDPQmj2JNxB37SCHDdGZlEgQKXOxpuLwFOaiv5u4jMx3LLCYp741WvhHaV8VO7FuLTns+mx4rhbJd3naOaXKPo+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080911; c=relaxed/simple;
	bh=miiZW+wiLtdC3ubhN4wSwOXpWqfScEy+lsDAJI3zjnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLsVfufZZPVpchbG8AzUBW7andzUiMQpL1wt9Es9yJ2Le1+GgmgTdGRsra057+xtHBM6o/c8XMix/wFt/JUe+VXDEeEOIjBY+nod2feVvQmSZBtshgvvTTu40ePpZb2D7a3r2mdOhTslWqB8j9in6UC0/beaS0zFMhSeC/t+Wew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VdHz0tJ0; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VdHz0tJ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaAbG9rmiXqra0fSrPLwJjUD3WxQBw+87XCNyszRBzhlEZrIgN3mH0XeCF2Z5COsV0EX/e2yiji8NLdmIuwool2NjVa+dIyB5tPEYkniSkXdXulJzIRE4rPrC5DkIaO848qabIdBhdO9wdK1UhyacXMfwCOLdDwLy3lkFkC8lyk7wgXkDXdySO2uaf++eH+o4B+MJybI+WtA6GA15+XLHvsiBsUzdoAdfjQanAfNi1dQbR/gd++gM1g9WD+b/SI7PAscp4varN3V8Lx7lr7WvadWh59H32j0YUqIuRbyzQDuBr/W7UQILoyVfnGyTbn4mjlOnU/c8h7dzMb0ETi40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHv/K83xOVk8rRklnTr6zF0kOzT8Mv9gvRnocBImKJw=;
 b=Ysn+r3Iynr22HTvG/H4ynXMrUdX60Vlb2xyQLKD3sd70FmzTd1MI/5usyE+ySf2vTjX+hJhZv8t90antvrvZnUiF0qkfmJyXshZVAlZhMCOvIJg8SARd0aIQ3ozfvw7Kl8OcfIYnBjc0wGCHGqehFO7J1/ly0Qd9DbMK/C8zsvmZQOanvM5RG27KqMqvc6aSTlKDT7g9fXlLELUdUhaVKcj15LJ6d4wjAG+r9btAVJ8awLQu0vClRx/FB0gFqgpOxzkg/d0twM1UZfXlLDEH6iWpSgTK1TgXSVHeYmTo4w170Zt2DSA6dbS4hUUspMxqiYnh1JBYPH24KXnAoj28JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHv/K83xOVk8rRklnTr6zF0kOzT8Mv9gvRnocBImKJw=;
 b=VdHz0tJ0ZayX4y8X2fmr72dME3/P0kKDrizZ0npc0UxdKWKMV1VClGlP8NTZwvLF0bvkie2A0F4P1cVOwtLnW0QY+ZJB3Boh/Ca1ylXZTE3kQfYGAynO15t/LxUOJ/FtiLJb71BexM37FwK7R+gdV4/QawL521K9AN1g5Zt+QKI=
Received: from MW4PR04CA0370.namprd04.prod.outlook.com (2603:10b6:303:81::15)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 00:41:43 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::7) by MW4PR04CA0370.outlook.office365.com
 (2603:10b6:303:81::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:41:43 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:41:35 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 10/11] cxl: Enable AMD Zen5 address translation using ACPI PRMT
Date: Fri, 14 Nov 2025 01:40:15 +0100
Message-ID: <20251114004021.1310661-11-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114004021.1310661-1-rrichter@amd.com>
References: <20251114004021.1310661-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d5c03e-21be-4bd1-7ed6-08de23169529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDYyMFVpMk5OZEJVQUxCWWhDOTRWK1RhVzIzajNUeEdIQm5ySkJMdEtkTGdV?=
 =?utf-8?B?OUZhUzVobWVkSi9iaUR6UUV2ZEcwUWw4UlRRMHZLdTQ1dXhaSmk1NXc3OVNX?=
 =?utf-8?B?V0packJqOEhuK0svcGJOUnFpSkFGSDd1YWFzRmd0TS9CbUtZTTNWQ290MG9E?=
 =?utf-8?B?c1BMNmFmT2RYd0hrSHIvT1BDRkxpTmtYQ2FjU3crS0xOQmE2WGN3VlliT3d4?=
 =?utf-8?B?K3RmdzFRdTgzN1V0Yi9nRFMzWm80K2N0YUowcG9GQWFPZDM0US9oc2VQanZF?=
 =?utf-8?B?NTVXUFhhdFoveW5vM01yYzdsTDJLZHV6dmxOUFhoVFFFaVdyNjI2UWVVVWo5?=
 =?utf-8?B?VnZBZmRPckNWWFd0NlJuTEZhcjlnbkdlaFJDbFEyZTZtRzRGNktIYVNUdGp2?=
 =?utf-8?B?MkxyazFRSmtoaWQ4MDdSQXVzc09zVmM2dyt2dlU5Rjd1YnpkNnRFcTlLRnV6?=
 =?utf-8?B?dXdtazI2aXF1VEVGM0VXQVNwaktuZU9wT2R4N2EwZ2xrVHFXSWpiY1BvU1dl?=
 =?utf-8?B?N0ZpaElVTGZjbFA1WFlEQ2lMNUV4OWpPYWUyenFycG1KcDNvOHdYMlh1elF4?=
 =?utf-8?B?clR6U2xsbDZhczJ5ZXNJZFFTRzFGYVBEQWgrUnlRaDU3RTJLQmJkY0ZveG9G?=
 =?utf-8?B?d3BldGVqODFPZWcxTmRoTGVUQ1pQaCtNVnZId201ZUxtU3RjU2VNY2xmOTBU?=
 =?utf-8?B?ZVpGL1ZYc3FXN0hXRHJ4azhONVMxbEFmdmx1Y3NyNEpZem9rMm5yUkhyWC9P?=
 =?utf-8?B?RVMyNklpY1JjM3RWNEl4ZjNHcFFwckZWUUhCSVNUVFhaTm9Cb0t2V1NXU0Jl?=
 =?utf-8?B?UVNPUUdTN3RUS1NGeFRWZGw3RmtzMk4yQkNocWpqdWFlakJDamwrY3RSY0tj?=
 =?utf-8?B?VG5rbW9hNDBKZXRWRnBlMEhpK1hBVVMzMXF2ZXVZRy9yZWI3em1tYkZKVlEv?=
 =?utf-8?B?YjkrRXJraWpPK0dLelVoM1d3TDFJV2MwUEEwTDR4djZhUmpPdTJwazRNZnNI?=
 =?utf-8?B?dXRiK05RWnFLdVZKaDZuMDJJeTJ4V1g0dXpsVU1xNFR2aTBqSzRvUERGRitI?=
 =?utf-8?B?VHhFSGhZdDQrMUZVK21VZ1E1aFF6Myt1V3ZHcTRHbWRvOUhReW1QUkUwemJU?=
 =?utf-8?B?YkVRcTFHRStSU29tQ1RaaTJtMDNwSTJiVkp4VHR0eExWbG5UeGx5TmNCeHBE?=
 =?utf-8?B?ZklabmNJVmpBd2RTOWxtUzlVUVhEVmF2ZWZSUVZ4RDFUODBVZnRkeldIQW04?=
 =?utf-8?B?eWlRUkxkQ0lndDJmNDFyb0lzald5eDg3NTdRVFR3d1NJQTJnbjVMbklvQnk0?=
 =?utf-8?B?NGxDb2Y1REY4SWs5cElpWWJ3bW56VGIrd0VXd3lqS1hURGJMeWY0Qm45ZDVy?=
 =?utf-8?B?cDZQSjVTUzRjMU05RWRQVmsyUzczM2J5WjVhQkw0ekNGRk5YTHF4RWFCeDZt?=
 =?utf-8?B?VDRyRUhvOGtSU1ZObFUyckY5ZmR6b29lSXFBc0kwUTV4RG5CRHFHaVFWQ2kw?=
 =?utf-8?B?UmlmNDhsY0doZW40OU5CUnc4VUVWQXZGRG8zcUFBU2tTdTBDeFQxOXNITW9Y?=
 =?utf-8?B?S1ZZVXR0ZTRPell0QVRkaXAvMS8vcVFMQnllMEN6T3hOWVdvUzFwMmdielFZ?=
 =?utf-8?B?eFRQUlI2a2ZBZ3BIUk9hQmVqWkVDYWsvWGNKZ3BXNExocUE1K0VtZ3Vqdm1G?=
 =?utf-8?B?VGF3cFRkUEJCV25vZFU1bXczcHRvM2hFWWV1dXVCRER5bkdzZ090QlgwSmFB?=
 =?utf-8?B?ZlNVQTVPcGRZRlJlR0pDb1JiMFpZcmhjUmdsQUFPZVdjcVczWS9PQXdLcmVP?=
 =?utf-8?B?Yk8yeGEyd05Gdi9EdFJJa0V3SjJSbE9hMXBDM2RVcUI1RENGcm1WY1JlQnl0?=
 =?utf-8?B?R3hYbTEvVi9maWtiZDlkaEFMMDl1eCs0ajRtVXJlUFVqRW12WEJYVnZtV0Z1?=
 =?utf-8?B?YVpSTGhaZG5PSEZYOGRtczN3Q1pSZXByT3ovWGRUWjhOSUt0Ymc4STVXYklZ?=
 =?utf-8?B?UitGNW9XNU9XZlRmUHp2SHZEajJ3ZUlaYlJ2R0FDek9SL1BOVEdtOWdHQjJr?=
 =?utf-8?B?VnFDTmJrL3YvUTlUMWk0cTA5OG1KRmYrTnMzSnlPV2dZT1ZFRThPSDN6Njdm?=
 =?utf-8?Q?c46A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:41:43.0629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d5c03e-21be-4bd1-7ed6-08de23169529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

Add AMD Zen5 support for address translation.

Zen5 systems may be configured to use 'Normalized addresses'. Then,
host physical addresses (HPA) are different from their system physical
addresses (SPA). The endpoint has its own physical address space and
an incoming HPA is already converted to the device's physical address
(DPA). Thus it has interleaving disabled and CXL endpoints are
programmed passthrough (DPA == HPA).

Host Physical Addresses (HPAs) need to be translated from the endpoint
to its CXL host bridge, esp. to identify the endpoint's root decoder
and region's address range. ACPI Platform Runtime Mechanism (PRM)
provides a handler to translate the DPA to its SPA. This is documented
in:

 AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
 ACPI v6.5 Porting Guide, Publication # 58088
 https://www.amd.com/en/search/documentation/hub.html

With Normalized Addressing this PRM handler must be used to translate
an HPA of an endpoint to its SPA.

Do the following to implement AMD Zen5 address translation:

Introduce a new file core/atl.c to handle ACPI PRM specific address
translation code. Naming is loosely related to the kernel's AMD
Address Translation Library (CONFIG_AMD_ATL) but implementation does
not depend on it, nor it is vendor specific. Use Kbuild and Kconfig
options respectively to enable the code depending on architecture and
platform options.

AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
call (see ACPI v6.5 Porting Guide, Address Translation - CXL DPA to
System Physical Address). Firmware enables the PRM handler if the
platform has address translation implemented. Check firmware and
kernel support of ACPI PRM using the specific GUID. On success enable
address translation by setting up the earlier introduced root port
callback, see function cxl_prm_translate_hpa_range(). Setup is done in
cxl_setup_prm_address_translation(), it is the only function that
needs to be exported. For low level PRM firmware calls, use the ACPI
framework.

Identify the region's interleaving ways by inspecting the address
ranges. Also determine the interleaving granularity using the address
translation callback. Note that the position of the chunk from one
interleaving block to the next may vary and thus cannot be considered
constant. Address offsets larger than the interleaving block size
cannot be used to calculate the granularity. Thus, probe the
granularity using address translation for various HPAs in the same
interleaving block.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/Kconfig       |   5 +
 drivers/cxl/acpi.c        |   2 +
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 197 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   7 ++
 5 files changed, 212 insertions(+)
 create mode 100644 drivers/cxl/core/atl.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..103950a9b73e 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,9 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_ATL
+	def_bool y
+	depends on CXL_REGION
+	depends on ACPI_PRMT && AMD_NB
+
 endif
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 604cf995d0e4..40894e2156ce 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -909,6 +909,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	cxl_root->ops.qos_class = cxl_acpi_qos_class;
 	root_port = &cxl_root->port;
 
+	cxl_setup_prm_address_translation(cxl_root);
+
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 5ad8fef210b5..11fe272a6e29 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
 cxl_core-$(CONFIG_CXL_MCE) += mce.o
 cxl_core-$(CONFIG_CXL_FEATURES) += features.o
 cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
+cxl_core-$(CONFIG_CXL_ATL) += atl.o
diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
new file mode 100644
index 000000000000..3b02999d3c59
--- /dev/null
+++ b/drivers/cxl/core/atl.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/prmt.h>
+#include <linux/pci.h>
+#include <linux/acpi.h>
+
+#include <cxlmem.h>
+#include "core.h"
+
+/*
+ * PRM Address Translation - CXL DPA to System Physical Address
+ *
+ * Reference:
+ *
+ * AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
+ * ACPI v6.5 Porting Guide, Publication # 58088
+ */
+
+static const guid_t prm_cxl_dpa_spa_guid =
+	GUID_INIT(0xee41b397, 0x25d4, 0x452c, 0xad, 0x54, 0x48, 0xc6, 0xe3,
+		  0x48, 0x0b, 0x94);
+
+struct prm_cxl_dpa_spa_data {
+	u64 dpa;
+	u8 reserved;
+	u8 devfn;
+	u8 bus;
+	u8 segment;
+	u64 *spa;
+} __packed;
+
+static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
+{
+	struct prm_cxl_dpa_spa_data data;
+	u64 spa;
+	int rc;
+
+	data = (struct prm_cxl_dpa_spa_data) {
+		.dpa     = dpa,
+		.devfn   = pci_dev->devfn,
+		.bus     = pci_dev->bus->number,
+		.segment = pci_domain_nr(pci_dev->bus),
+		.spa     = &spa,
+	};
+
+	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
+	if (rc) {
+		pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
+		return ULLONG_MAX;
+	}
+
+	pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n", dpa, spa);
+
+	return spa;
+}
+
+static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
+{
+	struct cxl_region_context *ctx = data;
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range hpa_range = ctx->hpa_range;
+	struct pci_dev *pci_dev;
+	u64 spa_len, len = range_len(&hpa_range);
+	u64 addr, base_spa, base;
+	int ways, gran;
+
+	/*
+	 * When Normalized Addressing is enabled, the endpoint maintains a 1:1
+	 * mapping between HPA and DPA. If disabled, skip address translation
+	 * and perform only a range check.
+	 */
+	if (hpa_range.start != cxled->dpa_res->start)
+		return 0;
+
+	if (!IS_ALIGNED(hpa_range.start, SZ_256M) ||
+	    !IS_ALIGNED(hpa_range.end + 1, SZ_256M)) {
+		dev_dbg(cxld->dev.parent,
+			"CXL address translation: Unaligned decoder HPA range: %#llx-%#llx(%s)\n",
+			hpa_range.start, hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	/*
+	 * Endpoints are programmed passthrough in Normalized Addressing mode.
+	 */
+	if (ctx->interleave_ways != 1) {
+		dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
+			ctx->interleave_ways, ctx->interleave_granularity);
+		return -ENXIO;
+	}
+
+	if (!cxlmd || !dev_is_pci(cxlmd->dev.parent)) {
+		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
+			dev_name(cxld->dev.parent), hpa_range.start,
+			hpa_range.end);
+		return -ENXIO;
+	}
+
+	pci_dev = to_pci_dev(cxlmd->dev.parent);
+
+	/* Translate HPA range to SPA. */
+	base = hpa_range.start;
+	hpa_range.start = prm_cxl_dpa_spa(pci_dev, hpa_range.start);
+	hpa_range.end = prm_cxl_dpa_spa(pci_dev, hpa_range.end);
+	base_spa = hpa_range.start;
+
+	if (hpa_range.start == ULLONG_MAX || hpa_range.end == ULLONG_MAX) {
+		dev_dbg(cxld->dev.parent,
+			"CXL address translation: Failed to translate HPA range: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	/*
+	 * Since translated addresses include the interleaving offsets, align
+	 * the range to 256 MB.
+	 */
+	hpa_range.start = ALIGN_DOWN(hpa_range.start, SZ_256M);
+	hpa_range.end = ALIGN(hpa_range.end, SZ_256M) - 1;
+
+	spa_len = range_len(&hpa_range);
+	if (!len || !spa_len || spa_len % len) {
+		dev_dbg(cxld->dev.parent,
+			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	ways = spa_len / len;
+	gran = SZ_256;
+
+	/*
+	 * Determine interleave granularity
+	 *
+	 * Note: The position of the chunk from one interleaving block to the
+	 * next may vary and thus cannot be considered constant. Address offsets
+	 * larger than the interleaving block size cannot be used to calculate
+	 * the granularity.
+	 */
+	if (ways > 1) {
+		while (gran <= SZ_16M) {
+			addr = prm_cxl_dpa_spa(pci_dev, base + gran);
+			if (addr != base_spa + gran)
+				break;
+			gran <<= 1;
+		}
+	}
+
+	if (gran > SZ_16M) {
+		dev_dbg(cxld->dev.parent,
+			"CXL address translation: Cannot determine granularity: %#llx-%#llx:%#llx-%#llx(%s)\n",
+			hpa_range.start, hpa_range.end, ctx->hpa_range.start,
+			ctx->hpa_range.end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
+	ctx->hpa_range = hpa_range;
+	ctx->interleave_ways = ways;
+	ctx->interleave_granularity = gran;
+
+	dev_dbg(&cxld->dev,
+		"address mapping found for %s (hpa -> spa): %#llx+%#llx -> %#llx+%#llx ways:%d granularity:%d\n",
+		dev_name(cxlmd->dev.parent), base, len, hpa_range.start,
+		spa_len, ways, gran);
+
+	return 0;
+}
+
+void cxl_setup_prm_address_translation(struct cxl_root *cxl_root)
+{
+	struct device *host = cxl_root->port.uport_dev;
+	u64 spa;
+	struct prm_cxl_dpa_spa_data data = { .spa = &spa };
+	int rc;
+
+	/*
+	 * Applies only to PCIe Host Bridges which are children of the CXL Root
+	 * Device (HID=“ACPI0017”). Check this and drop cxl_test instances.
+	 */
+	if (!acpi_match_device(host->driver->acpi_match_table, host))
+		return;
+
+	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
+	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
+	if (rc == -EOPNOTSUPP || rc == -ENODEV)
+		return;
+
+	cxl_root->ops.translate_hpa_range = cxl_prm_translate_hpa_range;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_setup_prm_address_translation, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e67e37322ee9..75fd45ddca38 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -790,6 +790,13 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
 #endif
 
+#ifdef CONFIG_CXL_ATL
+void cxl_setup_prm_address_translation(struct cxl_root *cxl_root);
+#else
+static inline
+void cxl_setup_prm_address_translation(struct cxl_root *cxl_root) {}
+#endif
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
 struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
-- 
2.47.3

