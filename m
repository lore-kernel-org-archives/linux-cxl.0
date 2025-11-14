Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4463135F8B5;
	Fri, 14 Nov 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156427; cv=fail; b=amF5MVprvEvSqudtfB0vGJVdVlaq8jHU6o2HbVpY4L1Yyfip6MXJQcmz/aQ+68G5qLRQt7f+B+pZ9d7VT3r/86HbmGq67ufySL0eW8buqQaQjX/ZPsNoIu3zi3yc8rjDFmtWNp0OWAuGRd6OdHz8WbrsO7ebglIdo0NtXmGQoU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156427; c=relaxed/simple;
	bh=miiZW+wiLtdC3ubhN4wSwOXpWqfScEy+lsDAJI3zjnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwSqOtg71/aNI5crDQXx6RiVi3StEuHwLSrqvVDRYQ988UANO0tB4RHn43ryEY8Ddmp0XF9RLD9pAd0vlej+jTk4UWDcRS5bK7+jDwm/bgHhIH4n6zPy4VZ5rDV+1zb/6gNxhQDJQZD7I51Zd+L0jPyojg9GMSiyRzXrUNOvUso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AKnE1UBN; arc=fail smtp.client-ip=52.101.85.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AKnE1UBN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2Z86Dd1LTz1UWWdmsO3TlYTcUE9C8BJB6yjqPpS2a/CSCZdN5h+fLTVyiD8Pc/UHPfhydjqq9lKP8sJvku10oONEANtvaLbFgVSAEKObIVZXpC1oBz/t4+fEibnFbkcT/DMP7X475dTnzGdYRxAGn3IFmk57TN1mfGnmtJXBFh9dR7Do/SvBcAsDXhDRMfYpEEoTEVSrIopbzWKScY7jQaJW/kJ2KfvvDAV4LKBBiMCtnbZEkwIRUq3zpe6j5UttWuXpnHomtm1K2l4NoK9Ou5al18eLIEzSOe+sl+g2mO7RqDYWj4N+eBt5xLGauCHZfzVJV8IRv9U9BoB5rj+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHv/K83xOVk8rRklnTr6zF0kOzT8Mv9gvRnocBImKJw=;
 b=IXrVuKEkuNH1U64lExsLwimQPDlpFzVucJjPZy2AA+kNSNQVsObwJHUdo+P41lk9/Wy8xOHBVoQjDaV55oRNYVsgh9p9ZfhmaUv9LY7Hpl4r3wY91qZZgyDwCEwaPzEFxQnmrqe6EYGSfOLpYv3YQq7TzUc4EweM1os66ChlGku8SdK8bqsArCqLWNJit42nd0Be+K7d8hjHYAQ6e+c1mjAc+h0qfPhPFiDkuv7ZkLuj/M6qZ7xhpmd+a6iZvw5lvd0BHhU/kDVMVtMAYSR/GUC+pLXK+TMgxALXdL4U1kFd+g+OyoyVp+qi5BFHxCnG50CrJk8cWpLncqQSLvn8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHv/K83xOVk8rRklnTr6zF0kOzT8Mv9gvRnocBImKJw=;
 b=AKnE1UBNEpDwur5C72NelY/bAHC35/8ttVMsBKewpJFjdTt8S9BFB4Njd9wmCYcb+kv3ZTcD6sRcbJy08WQwh7ftTLnB6uREj0TSYb1xssawD43wLNCbTSM0NPC86JYqtK35G5WoTJG4ymSAErZOqqOubtwW/d0MuOWsTQEeUlE=
Received: from CH0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:610:119::9)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 21:40:22 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::6c) by CH0PR03CA0362.outlook.office365.com
 (2603:10b6:610:119::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:40:22 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:40:19 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 10/11] cxl: Enable AMD Zen5 address translation using ACPI PRMT
Date: Fri, 14 Nov 2025 22:39:23 +0100
Message-ID: <20251114213931.30754-11-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114213931.30754-1-rrichter@amd.com>
References: <20251114213931.30754-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a29e83-9fd3-4ce7-c656-08de23c66a38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEV1clhEZ2hxUm9LUWtCRG91VWYvNVY3QVRjUjZJYjRmSDlPOVpmdFFadUVH?=
 =?utf-8?B?aGtKWjQwODVBZk5BbGxFYXYyeXFqaXpURVdyWnFrK25ueVpGdE5ySW1iWTln?=
 =?utf-8?B?ODhpVWczNk5YRkVsUXRVdDhGWVQxUGYreHBpckFKRmRmMVBHUVJSbXBxRUhN?=
 =?utf-8?B?ZXNYakZvelhJWjQ2Vm5mazR5UlFCUXViaFFDVkJ2N2t4cHlaZjBPVVc2c2pq?=
 =?utf-8?B?MytxQ1NGMnlOSGNqYlVxbTRBbml4WkZkZlFvcDZQdXA2MHVMcGJrRlk5ajZV?=
 =?utf-8?B?cTYxa0NoZnNwbTdxeXlMemdvZStyWDVuVmFNekZqaW03aGVJdy8rYnV1VE84?=
 =?utf-8?B?R2xHYXN6Y3FrQzZDTnJTSVpwMUJuQStUMHVnTzJHanIwK1lDTUVPN2d2QkpG?=
 =?utf-8?B?Yi92OGxWUVVSSE0rblg0ckk0a1dMaWptayszQ1owOGhFNERpTDJsS1gvZlFm?=
 =?utf-8?B?VXkvRUQyTDVmL0xDWWhxZnlJaHQ3TFRIeWRxMlZ5c3R0L0F1WjA3c2lnUldI?=
 =?utf-8?B?Z2I4Z1B2T3orUnFBUWhDRzhvV0FOQmZMMnkwOFhQbVl5NmRSWk8veDZHUFpr?=
 =?utf-8?B?NFZZV3hINW81VTErc1lCWldBUXAyRlMyRGZyVXFVTFU0QnZ4NHpjV3VwdFRy?=
 =?utf-8?B?UTZnb2dHSzhzRkYyNUlnNDZWUnMzWXhsYzNBQVd3RmRyN2NxVHV3bWcvOTB4?=
 =?utf-8?B?ZzE0VXNpVmt6STZJL2pEZ1JoUlRiV011eGNUQkJIMUdLTVRZSWo0aDRNekdM?=
 =?utf-8?B?NmlYa2VOdllUb0dURkRucytpRW1GdUduRkJ0bTBZZkh5U29LVVJhdzQzV2Vr?=
 =?utf-8?B?S05NWm4wQURrYi9ucFNjQjVnRkhrQkZlVVlrbWMvQlJCL2dWMmI3aGl1UW9N?=
 =?utf-8?B?b1NyQmhQS0hZVGdZSTU1aWo4VjhibWlBSGFuMTRGWEhUN2VuT2VXVWtQQ2JV?=
 =?utf-8?B?cmlTaE45TEQvV1h6dEpzNXJ6c2NnNm1KWjVBVUwzck0wbVVSR2p6UEY0aWU2?=
 =?utf-8?B?WTZHVXJjd3J3YWFacXpUZWtqSzF5bWlsWnZ3NnN0VXgzc1FKeFBwTy9FV0xN?=
 =?utf-8?B?RDdBM05mcGV1RWRFWU55WlV4VVhjeVFRTXBJSDFmaFgvZ3llUUlTUXlGUnJD?=
 =?utf-8?B?Z0o0bFVlM2xQWXNmcndQSzBGNzZtME1PZmtRdFgvZUxDUU9YSWRXck9OOURR?=
 =?utf-8?B?czF0NnBLWWhYeDkwbVBTNUNXdnhtbVBUTHZCeGQ2TUtBTzhuL2xIcVczVWt5?=
 =?utf-8?B?R3pxYmVraWU5MUd2UXhrT0lLY2sydEp5YWorTno5VndsRUtTb1NpdVpzYjd3?=
 =?utf-8?B?WG5nQUEyM1BUdk45VWdTejdwelVtY3ltN21Pd1FFRE1PYklucFVpNDUzRGI2?=
 =?utf-8?B?VlkveVJMN3BuMUVGWlFHaFpCTmlVb0lHN0JPZFNpL2k3eGRKYlBZV2J5ampa?=
 =?utf-8?B?L0ZhSkt6endmdkFyZnpmQmhBc3N1TFRsTWI3V3c2Vmc3ZmJtMEhaWXQzdjJk?=
 =?utf-8?B?TGxTOGhYT1JrSzZualN0ckgySVlCWWdKYldoUnBSWGpuWjFRUlNmU3pjekdX?=
 =?utf-8?B?bDBpOENRKzI3SUpxZWVJODlpd2pXTUI0RER5Ny9QYTdkUURybnozTzhCSTdZ?=
 =?utf-8?B?RFJQU0c1S05JWXo5N2RYVVRVS203emNLdTlyUzFpK3grT2FxcmdaMUlBMW9k?=
 =?utf-8?B?YmN1V1ZpWkdQN2N0Rk41TDZTdlh5UVZZTWRiVXUvSzludHhqZkhMY3lEL0xa?=
 =?utf-8?B?SFh6ZUVKWi9Gb2U5clRIOTY5MDlMcldmUDhsWitrV1ZJWHh4RHc4WHNMNlhN?=
 =?utf-8?B?alp4NVFTWGlpaE9KVWcrTXRrdGxaaVkySWJNSS9hMzRwcGNKOWlMU1FkaG5F?=
 =?utf-8?B?TUEzV05WT3YwaW9tNXFmNXBhVklJeWVLT2VaVjZNYWJzWkQ4dC84TTVHeFp2?=
 =?utf-8?B?UDFpWDEvU0VaaHBoMHBaT1FZeWxwbTU3RVNqWEtFRFZZdW1wbGgxbGk5SjV4?=
 =?utf-8?B?Y3NEM3FteFBHK0c0MHFDQ0EvY1VxakZUYVh6NzZlQUxmMDVFMnkrWGFmSEo3?=
 =?utf-8?B?MTQwL3dscXd2V2psTDRxYXptL1lsYzdSWXRBS3VWWUlEZ0NaSlVsQk1ZWG1F?=
 =?utf-8?Q?ibuY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:40:22.5246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a29e83-9fd3-4ce7-c656-08de23c66a38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679

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

