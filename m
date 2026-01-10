Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012000.outbound.protection.outlook.com [40.93.195.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04633A718;
	Sat, 10 Jan 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045697; cv=fail; b=SLMq7oV3PCIgftucVZ2GMVJ2VGiaK99U0t5/8B7iUS0YKfs95xpe2iUYyPHejIWJ/v5MXoyxqGtpH8548vWUwkdQxuZMRzfwydZEfry/ARg5Gr4AjSGvgcRdzy0CgCBzp++eg41IGBsyFk7HsM3uvuuPPYGVJp2f9ZdiRT13lFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045697; c=relaxed/simple;
	bh=NzCf99GYN03DBfAOAcmuubc6tBqWe9SLSB8N9200/z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAWMARIEpTWIzkoXfDXP3VEhuC0rbNdE/SoH99E5mNfcPPfUbld0IOSSZrpGHDbBqoydbSjwYyIE/PsE0HZpx24VaYdeWLImAggODFdNJkoU8Q1HvNhyJXX/BP2zKvcK7Ph7Z3oBua8j9uPU0jk9Gx9aXr5QVrK+znRsqhsnh6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZCuUnCly; arc=fail smtp.client-ip=40.93.195.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZCuUnCly"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHvIMwOhiJeNZpxytH+YRj4BSH1cwv2qz+ZjWcmSaSvRJDDYKjI8T9gvp+ZUbMODEt06XvcxWT/+6Zln8+UZ1uADmJqcZABOcG7MIw7siLRfzW1bbN266eRPrUNJEhonGSnBpn25f9YQm87/7Mi+/Wb1KFyCROfKs1egiL3RIObW6FuFXZKXPLOJeiu8dVzTEqf8Ad9bXXdmuC8U7a4bYXbPGI26kQMm7w0rh8dAPnTWuMhhOl6hgVPrlAZXy7qQ+WfCvKJyLF2WQLGuyG1qjkxNbQDaAEI6ZXabrMKJ/L00YWJyxtzrvwokVzZ0Uxu8C/N6dfNH7uwrQaDDemJ9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85r4L+xywSogYPdRiKqsvJWd9nfRBG7MiV7bEsM86WA=;
 b=tlD9xsOPGgiVx55Pg1PiiHuargX3sAV1d6fWZFAGXgiiRYM4diCW+LdwnngJ57Nl36zKLoUbxE3X/QX36fGo6ec+j3bMQSF8FvHaVlocz341a4tgqjUUBeAYw4iYldfcNjPVhch8O8MMTdJAUnkH5YGvtF5ASLE+52OPCuWZ2YlXJSD+rd7Q7Xi+EdXZzFdtXLjiaPUVHNghVTsCD6vRc3R5g+STcmkOH+TZmpncGSnz3fVxAE6l9NMk+vSCQ4wauU20IVN3fNx1CMVtW5KgHiEJAK/d7eYzIe18XZkOrSvFb3XOaMzVNzjpf7QqIg6pwUaxHhQ2NYHtW7UYBB2sRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85r4L+xywSogYPdRiKqsvJWd9nfRBG7MiV7bEsM86WA=;
 b=ZCuUnCly6vkYdSRAO/9Y1TtUIRePDC5gbJ2XVNosMzG3y91GhnIhIB6Xq+zrZLEqSdSm72C3X16mbmCzFEbZZJaIiXK9LJiX0lTdgu/CKFP3L3fFfJYlYSs6CCMjKNjo9Ttk6kR0VCuSeHgAZ6WkQnChP4tcEFPEjyV8hmI7eXw=
Received: from MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:48:09 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::3f) by MN2PR15CA0054.outlook.office365.com
 (2603:10b6:208:237::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Sat, 10 Jan 2026 11:48:09 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:48:04 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using ACPI PRMT
Date: Sat, 10 Jan 2026 12:46:55 +0100
Message-ID: <20260110114705.681676-11-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260110114705.681676-1-rrichter@amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fec85ef-b1a3-4710-e5b0-08de503e2030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEJLVERkRU8rWVZ6azlTWTkvQndSVVN2UkY1UFY2VVJVcGFXZm8vY1Z3MWdM?=
 =?utf-8?B?WnJVTUZJV1dIRlZRK1B4UVI5aGRjWm9VWFZXM3VrK2FjNXY2eG5QOFo5Sm1R?=
 =?utf-8?B?MHVlc0hyODdia1hmcld5WFNMODRxVU02VWhkVEQ2SGxaaVJyZDBqemxoVFZy?=
 =?utf-8?B?dnZaLzlRMzhmM3E4R1k5Zlo1RndvS0RRclJXbXBRUzhNZmZtcWs0Y0JYcHlH?=
 =?utf-8?B?SWpTNFptSXlJM1ErZ29PMXRNdFdQR0t0eVVNNHR4TFhMeFZGUUloeExsUm11?=
 =?utf-8?B?a1AxbkFMSTdWVnNvS3RTUENJS20yMDZkVFVXb0NYZ1FSdjZSSXM4dTVhVXU0?=
 =?utf-8?B?YlAxZ3ZaaHVUbEYrQzNOWWdYZTRDVkRsNDFoU1BjelBVN2JEUUU4Y1lSL1VJ?=
 =?utf-8?B?VE9VaWUwTG5wTkpBS09zTDgyYmJ1a2diOFpVSmt2bC9seWtuWi9nWG9SakJP?=
 =?utf-8?B?UnFQSzZycCtuZnNFRjFsZ3RzTlFCTFFBbHB5OE56YlRjdE9VU2FOSlp1ZGdP?=
 =?utf-8?B?andJOUdsbnhQSFJxUnBCTUJtZ0N5Y2l1c2FjUnlpbGk2SEpYcDNTbVVCbmZI?=
 =?utf-8?B?dUxnaVF0TXRYY3VXSzNWeXJ6NENWVCsvZHhUSHhsQ1M1cnBVNjVhRzEvTGpJ?=
 =?utf-8?B?eGdQKzF5NzkxR2V0dnJNZmNidVpScTZyTmxJb1J6SE5nTDFDYk1LSFk1SlhW?=
 =?utf-8?B?amxhZ0UwQW03S2NQTzBzbU9MQlEvNGs2WGYrZXdQOXhzcjFjMUZPcVRKanBG?=
 =?utf-8?B?aUM1Tzh0Qmcxd1Bia0RydVZmRmxUZmNseHJzN211bS9tcWZZL3NUci84UnRF?=
 =?utf-8?B?TWhzVTY0VHNLRU5hMEF4WG1Nb28rZTVuVG5RUzFwZFJPUWcwUER2TVllZVh3?=
 =?utf-8?B?b3dYL3UvaW5vaXRIek5CRXI3MFZIeGtsdEtGeEZNZE1xeEVoWUZjc1Z1bUti?=
 =?utf-8?B?Sy9CbEcwQjJqNXNzQU82TEF4d2wrbU0xczlmYkFWbW1ObnhVZ2tnZTNLV2VM?=
 =?utf-8?B?NU9ZUVhuUUNwQmpKNmZPNVRFQTFTVzZxNXlibmp3Nnh1VWFsKy8vaXVEWVhF?=
 =?utf-8?B?Syt4SHBqVHAxdElYb3RhT0JWeGlaYmUybC83M1MxN0phcUV1b25WNjJLdXM5?=
 =?utf-8?B?UFlLM0YzMXRrYkdTYnhNYkRFRW9LODBKTkF3eXR0d3h2KzVkdFBNb0NOL1lm?=
 =?utf-8?B?aHdieDJZVmZmVUl6Vnc2TG5OUmNvQjVCZmM2YUc3Q1BjTGVheDNjeUNUZjFD?=
 =?utf-8?B?U3FFLzFYWHdJVFA0VFVYS3pKN3hIc0NtTjdVSnJUS3lFK0RjLzBiVGNjbFN3?=
 =?utf-8?B?SXZtUURaaUlBT3VDaGtXWTFZR1FzU3k3bDRPQ0lHZDJ3WW8ycEhOL3p5eXJj?=
 =?utf-8?B?N25GbE5LbklCNGRkWkdsTnB1dE1YNjVIOW1zbDBnMDZRa203aTNIbmpqUXQ0?=
 =?utf-8?B?OU9vRm4yUGpZTVMxRlJaUEtJMDBlWVQ1eVY2cytSOWpEWnlLRW1ra1lUb3Fy?=
 =?utf-8?B?MHlnNkhkNUpJQUlhOCtjWGdiRDdZa3hQSXdpaWZpSzdaQkYzaVR4NXZhVE9I?=
 =?utf-8?B?Z2h6TUYvMk56bGppWjZnOXZveVlkSVlqanhJOTRkb3BXdU03K1g3bTNsY1N4?=
 =?utf-8?B?ekg1V05BdTZ6b3kvMS9yZWcxNkZIbzBFQzZ2UDUrSWkydTgvRlB5bGdzT2Na?=
 =?utf-8?B?WC9aaHJaL0NuSkJvaHBIREdMa2VDWkU3NTN6K1R1WnpUbDJXMzhVa3RtaFNx?=
 =?utf-8?B?cEhpODBoNHhZNFk1UHRkaWZGTG9YajhFUnhmWFZwZXRKSkJBMGo1T3g4aURL?=
 =?utf-8?B?Vm90VUJIRlh2Ykh1b3JsR1FhR0MzaXRXQk41VW9qLzM5ODhqbDM0UU00Q3p0?=
 =?utf-8?B?Mkp2NndjMjMreHp6emxZcVJsZ3FkUGdPSUYzd0FQS3d0cmhBaUx4ZUJZcExr?=
 =?utf-8?B?S0hRT1UvLzZXcWRDNVJVeHlYNTJxREp2eEJ1V1Q5UU9Tak9hY296LytCN01R?=
 =?utf-8?B?eENUc2tlQnlrUlJLaTBLbzVLRkhJeXMxcER4aWhraFRpL3hwMjFVR2g4WHRh?=
 =?utf-8?B?U01iYmU1Y25ocDAzZzdYVEF0UjZTdXFUSEp3VGVzTHpGalhXRkc0MHBYK3Fp?=
 =?utf-8?Q?MTZ8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:48:09.1059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fec85ef-b1a3-4710-e5b0-08de503e2030
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

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
callback, see function cxl_prm_setup_translation(). Setup is done in
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
 drivers/cxl/core/atl.c    | 190 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   7 ++
 5 files changed, 205 insertions(+)
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
index a31d0f97f916..50c2987e0459 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -925,6 +925,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
index 000000000000..c36984686fb0
--- /dev/null
+++ b/drivers/cxl/core/atl.c
@@ -0,0 +1,190 @@
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
+static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
+{
+	struct cxl_region_context *ctx = data;
+	struct cxl_endpoint_decoder *cxled = ctx->cxled;
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range hpa_range = ctx->hpa_range;
+	struct pci_dev *pci_dev;
+	u64 spa_len, len;
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
+	len = range_len(&ctx->hpa_range);
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
+	cxl_root->ops.translation_setup_root = cxl_prm_setup_root;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_setup_prm_address_translation, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8ea334d81edf..20b0fd43fa7b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -817,6 +817,13 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
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

