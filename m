Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C861FA16F;
	Tue,  7 Jan 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259143; cv=fail; b=N7Ui2ZF8aAUxOj5tyg/UA6N/LKc2h23j4z9abvEBtO/7pLSCJpvf0yNbKId5GEMHEgpJEsqT4wjm0aWyJqoFAHsMPTzXGJx1eNPzCFHr3gEuiHzqdBAP4d7bn0b+OPmHh7jp3Ta61jNhZY1q65NXhFy39/53CKC7hB0cz2Zvewc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259143; c=relaxed/simple;
	bh=kjN0O0cUIlFyHd4lfeiO0KE5UmK08ypeWssTVuYSqtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfCXBVVYZ9lIkwyLAlnB3ilruAFFqCZkpRYOjBLSnoE6xP0/Bl9Pp8sApkgXM3ieghTfEs530KoVMJz0G4ULe6Yg+eH+vFMCL4B86xhRmuvJ1QAypo5EUPO8dBXXFRL+Zsalmx0fNDZrVpp7H0xTvee0NwPJxsG/IBREIP03pkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zcVjvsHp; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zcVjvsHp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH7xIfdAW0Amx71OAb/7HpQAZzIISJyzv0qT5Dqk8HVlYc20yMXAdoQ2K4yAFKsALChW7km4lAI8aMhAP7+ZXNaKJEJX/b5pe/AWRZn7Xfsrr3U3jRFf+5d35kBWTbfGhiMv5GVd9v6MLAAFaJbdWsGooZLeZwExg75LXL7NXsGCFzlgbxhHltA80j2d52nTtMS9gpeVilzenzc4B1PnoE5QPoGe5pkl7rnaEyItp0jbX2Y3BuV8ZrEHqoljSybwa2uzvDXwhaT+04PYxGX9LKxOXEv19ifriqgOmHZwuWaputJ+dnBiYZeOfGK4pDMC3/sOBdUBt4zf1og3qf4r5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y994vWkys0g7zEti2U9zKv+Zm5YNcPqW/j/BZnGvMsQ=;
 b=Y+UvLbJiOsr2+CuXw1YUewfRtkfknq+zE5cEVQ675yTuVLm2B7tPpvot218htx8u0wGQhwyQeQ+0Yc+i5IlcD1WBuYBXIoEzzYgooWaEO+Yf7pWRNKwPP6A59kMwEkA5sgveg7NBfeCiElwmAC3dp8modC/cItubIUpeOlCbPJBTyeJQIjGwMkcjxIu9q/Ks8obaEpa0UhsH/DyxFb/swd15hj6kTLUHlKw4I4AmvB+Whb7UIApQGJdBugAZCxQEoE0c8+UpaQJUr7Tbzz3y65Tv1meUdaC6b0aNtWQTd2pZG177YHz0J88vGXkR4uQytavzDgVE7wCzPCgCJWl7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y994vWkys0g7zEti2U9zKv+Zm5YNcPqW/j/BZnGvMsQ=;
 b=zcVjvsHp9fd2qVWWYyQQHdG9msvrXHocuG2CaDsUKqT/Tw730bSu5SMs/BK7fucW2UVER3/dTgFZLXTQNXUowFe9DzfuSffplH68sn25Wh1XDqDpkT4C7N+P3nHnvpFqDkYQkNQyDM2Q3+V83wHVqpnVswbfXWCYUmtxsnwKODk=
Received: from MW3PR06CA0002.namprd06.prod.outlook.com (2603:10b6:303:2a::7)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 14:12:14 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::42) by MW3PR06CA0002.outlook.office365.com
 (2603:10b6:303:2a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 14:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:12:13 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:12:09 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Robert Richter <rrichter@amd.com>, Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using ACPI PRMT
Date: Tue, 7 Jan 2025 15:10:11 +0100
Message-ID: <20250107141015.3367194-26-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 81adc4e5-6f84-4304-e606-08dd2f2548a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzJiS1dDREFNczNxRDVsQnl6L0l4Zmd1MEd2NnhKNWlFTkFzOTBWa3gzbnVm?=
 =?utf-8?B?ZExmWE9URjVqZ3FRWkJyaWpaRFBTMlp0VWVWaVFGZzlVRmR1Ti9HejU4ZFpj?=
 =?utf-8?B?K0lDWFg0NnNuYk80RmRlZUpJQWpXVXpCMWFzbWlRRzhKcG1aTlYrbFg2ZHN1?=
 =?utf-8?B?TFUxM2NNaEVxbFVRSkNaNjAvbXlOa3JCajJHR3lQb05lNWhkVStaWUtpYkRj?=
 =?utf-8?B?Wm1VcUJKSnVzeDNWc3ZqSDBSb2xFNFdKbExGcUpSNEN3S3NmTDc2Umg2cUZH?=
 =?utf-8?B?SzJHb01rZzBodWdGZzNMRVlCSW5DbnMzcnpoR3ZLdlFrMk8wNHdyZTg1TVZr?=
 =?utf-8?B?ZU1jSk9hOFk1a1VLVldXOUx2NFZpbGtlcG1xZ0Q2OUJVSE53MFVSd1pwUTd0?=
 =?utf-8?B?dEZaa2o5bnlYSGJuY0ZRMnZNSm5SSncvaU45ZUM1RC81UmNxWGFtUCtMNC9u?=
 =?utf-8?B?ZGtSZ1dVZ1E1WnNWckNiNnFHNlBTNldQa2h2c0lybjFlZ0tTblFBclc0Mm9Q?=
 =?utf-8?B?RlFzdnhIMFN2MjFoUWt2SWNVZTFBK1NNdGo2cHRBeUVPSGUwTlc1dXNNZURz?=
 =?utf-8?B?b1FCTHRZaXVQMURlczc1UkpVOFNES2JiSmVTN2ROakNaalVlUHlJUHkxZWJz?=
 =?utf-8?B?NGlsTzZ3bkJHQUpiQStiMmYrMmt0ZTNGWVMwZjh0UGsyM2hwa0xaYW1sbWpw?=
 =?utf-8?B?b0VBQU5RTGV0bzZTSGZ3LzBJb3Q0WVIveHZXUTZjKzFVUER4NDBTSjhlbWtN?=
 =?utf-8?B?UTEyMWJjZnJJc01aaUIzQlFqa25jaXZjN0dTVU5DMzhXc0VyVnk0b2kvQ0tm?=
 =?utf-8?B?aWVSdWliamE0eUVEVzV2MkgyYTNKTTZoSEE3eXlLb2o5M3NBa3dEZVZYTlNv?=
 =?utf-8?B?UjUwMEVPeDFDbXlmN04vcmZab0ttb2VPMU40c2lNZE9NRUhPRXlub0FqdzFo?=
 =?utf-8?B?aHY1OGVLWFRJT2wyMTMxMXNiaFE2R1BNU1JNQTVZM3Y1UlRONG9NenZYOGJG?=
 =?utf-8?B?elVvalpHOFFOM0QyVk5jVE5zTlVQYnNRWWxiQnZJbGo1U1pHbzcwMS8rZUNw?=
 =?utf-8?B?Y2R4K1liaG1KalpxeGQ3SDZmK1RrdkdxQkpIUHFJUmcyeDc2SjFNT1lGWmFD?=
 =?utf-8?B?TjhyV2FjMDdVQVdxd3FRQWoralBXTFFDUGRoMklpYVdmZDdZQ1ExaERqL3U3?=
 =?utf-8?B?ZGNNc28yTGdvK1NPSDNXcm15cjFRWlV3MnQ1UVZwNllWZ2JDdzhmM0RJTXFP?=
 =?utf-8?B?NmlTakpuTVlZR3pTNEV6RnVvUi9Udm5Gb013L2c5dDd4VkY3cERBZVg4cVhW?=
 =?utf-8?B?RHlqNklXL2EzbUlGcGRkTGdHYTk0MEhrMjlFZ0dTc3JaUlhvVzllc2ovS1A2?=
 =?utf-8?B?RUhUYmxZWUZtWTJGeWVVbFl1N0JhUVhvZktlb2Z5Zjl4M01IOUpBRWZJeGsr?=
 =?utf-8?B?ZUd3NDFKR2tUS1FMS2VVem1iQkpVZkFnL1N6ZVFpNW83SDhFYjlTVnk4RFhw?=
 =?utf-8?B?c0pEUFlENkhWTWRzTDVFTjdVNUhQT2UxU3ZsaGdXc2JBQXNIckhGTnVXUjJl?=
 =?utf-8?B?WlM2dWxaK1IwY0UvUHhGZ1NQWTREY3dWQ0VvZ2RiWUlmTlVtaEswRjYrUHFG?=
 =?utf-8?B?UjE3bVljTEYxaVAzN01JcFV6eGQ1UHlkVW9oYjdoMjhmcW83UnhkM0w0RU9F?=
 =?utf-8?B?QXJuc2dvbWE0YisyaUt3dm5Bc2pmSFJhRHNxa3NWcnArWUhnNEJpczBxd25S?=
 =?utf-8?B?WEJDNzVRNlZ2MFlMa1hVcTIxZnJVWUNMSFpuNXJmQlZxdmUrMzdNUTRmS2gz?=
 =?utf-8?B?TVpLeVd3d1Z3ZGhnV0VlcFpkaGxVandWdElQRFJYTE5zZTFkZ0xNSUt2WEVm?=
 =?utf-8?B?ZUFzazhZSXhoMTJBcHl6aXJQU054MWNGS3NBSW9VLzBjZjVCakEyWHRmdDk0?=
 =?utf-8?B?ZHJCNy9HdlA3ampLYVNCYU1UL3Y5YUpFVTF2SVFReW5IaDVlTm81V3RtQk1C?=
 =?utf-8?Q?fnx1HrQlBYVacmuXxG5twvAtHCtZJM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:12:13.4083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81adc4e5-6f84-4304-e606-08dd2f2548a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116

Add AMD platform specific Zen5 support for address translation.

Zen5 systems may be configured to use 'Normalized addresses'. Then,
CXL endpoints use their own physical address space and Host Physical
Addresses (HPAs) need address translation from the endpoint to its CXL
host bridge. The HPA of a CXL host bridge is equivalent to the System
Physical Address (SPA).

ACPI Platform Runtime Mechanism (PRM) is used to translate the CXL
Device Physical Address (DPA) to its System Physical Address. This is
documented in:

 AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
 ACPI v6.5 Porting Guide, Publication # 58088
 https://www.amd.com/en/search/documentation/hub.html

Note that DPA and HPA of an endpoint may differ depending on the
interleaving configuration. That is, an additional calculation between
DPA and HPA is needed.

To implement AMD Zen5 address translation the following steps are
needed:

Introduce the generic function cxl_port_platform_setup() that allows
to apply platform specific changes to each port where necessary.

Add a function cxl_port_setup_amd() to implement AMD platform specific
code. Use Kbuild and Kconfig options respectivly to enable the code
depending on architecture and platform options. Create a new file
core/amd.c for this.

Introduce a function cxl_zen5_init() to handle Zen5 specific
enablement. Zen5 platforms are detected using the PCIe vendor and
device ID of the corresponding CXL root port.

Apply cxl_zen5_to_hpa() as cxl_port->to_hpa() callback to Zen5 CXL
host bridges to enable platform specific address translation.

Use ACPI PRM DPA to SPA translation to determine an endpoint's
interleaving configuration and base address during the early
initialization proces. This is used to determine an endpoint's SPA
range.

Since the PRM translates DPA->SPA, but HPA->SPA is needed, determine
the interleaving config and base address of the endpoint first, then
calculate the SPA based on the given HPA using the address base.

The config can be determined calling the PRM for specific DPAs
given. Since the interleaving configuration is still unknown, chose
DPAs starting at 0xd20000. This address is factor for all values from
1 to 8 and thus valid for all possible interleaving configuration.
The resulting SPAs are used to calculate interleaving paramters and
the SPA base address of the endpoint. The maximum granularity (chunk
size) is 16k, minimum is 256. Use the following calculation for a
given DPA:

 ways    = hpa_len(SZ_16K) / SZ_16K
 gran    = (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
          / (ways - 1)
 pos     = (hpa_len(SZ_16K) - ways * SZ_16K) / gran

Once the endpoint is attached to a region and its SPA range is know,
calling the PRM is no longer needed, the SPA base can be used.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/Kconfig       |   4 +
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/amd.c    | 227 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/core.h   |   6 +
 drivers/cxl/core/port.c   |   7 ++
 5 files changed, 245 insertions(+)
 create mode 100644 drivers/cxl/core/amd.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 876469e23f7a..e576028dd983 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -146,4 +146,8 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_AMD
+       def_bool y
+       depends on AMD_NB
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..dc368e61d281 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -16,3 +16,4 @@ cxl_core-y += pmu.o
 cxl_core-y += cdat.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_AMD) += amd.o
diff --git a/drivers/cxl/core/amd.c b/drivers/cxl/core/amd.c
new file mode 100644
index 000000000000..553b7d0caefd
--- /dev/null
+++ b/drivers/cxl/core/amd.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/prmt.h>
+#include <linux/pci.h>
+
+#include "cxlmem.h"
+#include "core.h"
+
+#define PCI_DEVICE_ID_AMD_ZEN5_ROOT		0x153e
+
+static const struct pci_device_id zen5_root_port_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ZEN5_ROOT) },
+	{},
+};
+
+static int is_zen5_root_port(struct device *dev, void *unused)
+{
+	if (!dev_is_pci(dev))
+		return 0;
+
+	return !!pci_match_id(zen5_root_port_ids, to_pci_dev(dev));
+}
+
+static bool is_zen5(struct cxl_port *port)
+{
+	if (!IS_ENABLED(CONFIG_ACPI_PRMT))
+		return false;
+
+	/* To get the CXL root port, find the CXL host bridge first. */
+	if (is_cxl_root(port) ||
+	    !port->host_bridge ||
+	    !is_cxl_root(to_cxl_port(port->dev.parent)))
+		return false;
+
+	return !!device_for_each_child(port->host_bridge, NULL,
+				       is_zen5_root_port);
+}
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
+	void *out;
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
+		.out     = &spa,
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
+static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)
+{
+	struct cxl_memdev *cxlmd;
+	struct pci_dev *pci_dev;
+	struct cxl_port *port;
+	u64 dpa, base, spa, spa2, len, len2, offset, granularity;
+	int ways, pos;
+
+	/*
+	 * Nothing to do if base is non-zero and Normalized Addressing
+	 * is disabled.
+	 */
+	if (cxld->hpa_range.start)
+		return hpa;
+
+	/* Only translate from endpoint to its parent port. */
+	if (!is_endpoint_decoder(&cxld->dev))
+		return hpa;
+
+	if (hpa > cxld->hpa_range.end) {
+		dev_dbg(&cxld->dev, "hpa addr %#llx out of range %#llx-%#llx\n",
+			hpa, cxld->hpa_range.start, cxld->hpa_range.end);
+		return ULLONG_MAX;
+	}
+
+	/*
+	 * If the decoder is already attached, the region's base can
+	 * be used.
+	 */
+	if (cxld->region)
+		return cxld->region->params.res->start + hpa;
+
+	port = to_cxl_port(cxld->dev.parent);
+	cxlmd = port ? to_cxl_memdev(port->uport_dev) : NULL;
+	if (!port || !dev_is_pci(cxlmd->dev.parent)) {
+		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
+			dev_name(cxld->dev.parent), cxld->hpa_range.start,
+			cxld->hpa_range.end);
+		return ULLONG_MAX;
+	}
+	pci_dev = to_pci_dev(cxlmd->dev.parent);
+
+	/*
+	 * The PRM translates DPA->SPA, but we need HPA->SPA.
+	 * Determine the interleaving config first, then calculate the
+	 * DPA. Maximum granularity (chunk size) is 16k, minimum is
+	 * 256. Calculated with:
+	 *
+	 *	ways	= hpa_len(SZ_16K) / SZ_16K
+	 * 	gran	= (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
+	 *                / (ways - 1)
+	 *	pos	= (hpa_len(SZ_16K) - ways * SZ_16K) / gran
+	 */
+
+	/*
+	 * DPA magic:
+	 *
+	 * Position and granularity are unknown yet, use an always
+	 * valid DPA:
+	 *
+	 * 0xd20000 = 13762560 = 16k * 2 * 3 * 2 * 5 * 7 * 2
+	 *
+	 * It is divisible by all positions 1 to 8. The DPA is valid
+	 * for all positions and granularities.
+	 */
+#define DPA_MAGIC	0xd20000
+	base = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC);
+	spa  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K);
+	spa2 = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K - SZ_256);
+
+	/* Includes checks to avoid div by zero */
+	if (!base || base == ULLONG_MAX || spa == ULLONG_MAX ||
+	    spa2 == ULLONG_MAX || spa < base + SZ_16K || spa2 <= base ||
+	    (spa > base + SZ_16K && spa - spa2 < SZ_256 * 2)) {
+		dev_dbg(&cxld->dev, "Error translating HPA: base %#llx, spa %#llx, spa2 %#llx\n",
+			base, spa, spa2);
+		return ULLONG_MAX;
+	}
+
+	len = spa - base;
+	len2 = spa2 - base;
+
+	/* offset = pos * granularity */
+	if (len == SZ_16K && len2 == SZ_16K - SZ_256) {
+		ways = 1;
+		offset = 0;
+		granularity = 0;
+		pos = 0;
+	} else {
+		ways = len / SZ_16K;
+		offset = spa & (SZ_16K - 1);
+		granularity = (len - len2 - SZ_256) / (ways - 1);
+		pos = offset / granularity;
+	}
+
+	base = base - DPA_MAGIC * ways - pos * granularity;
+	spa = base + hpa;
+
+	/*
+	 * Check SPA using a PRM call for the closest DPA calculated
+	 * for the HPA. If the HPA matches a different interleaving
+	 * position other than the decoder's, determine its offset to
+	 * adjust the SPA.
+	 */
+
+	dpa = (hpa & ~(granularity * ways - 1)) / ways
+		+ (hpa & (granularity - 1));
+	offset = hpa & (granularity * ways - 1) & ~(granularity - 1);
+	offset -= pos * granularity;
+	spa2 = prm_cxl_dpa_spa(pci_dev, dpa) + offset;
+
+	dev_dbg(&cxld->dev,
+		"address mapping found for %s (dpa -> hpa -> spa): %#llx -> %#llx -> %#llx base: %#llx ways: %d pos: %d granularity: %llu\n",
+		pci_name(pci_dev), dpa, hpa, spa, base, ways, pos, granularity);
+
+	if (spa != spa2) {
+		dev_dbg(&cxld->dev, "SPA calculation failed: %#llx:%#llx\n",
+			spa, spa2);
+		return ULLONG_MAX;
+	}
+
+	return spa;
+}
+
+static void cxl_zen5_init(struct cxl_port *port)
+{
+	if (!is_zen5(port))
+		return;
+
+	port->to_hpa = cxl_zen5_to_hpa;
+
+	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
+		dev_name(&port->dev));
+}
+
+void cxl_port_setup_amd(struct cxl_port *port)
+{
+	cxl_zen5_init(port);
+}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 800466f96a68..efe34ae6943e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -115,4 +115,10 @@ bool cxl_need_node_perf_attrs_update(int nid);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+#ifdef CONFIG_CXL_AMD
+void cxl_port_setup_amd(struct cxl_port *port);
+#else
+static inline void cxl_port_setup_amd(struct cxl_port *port) {};
+#endif
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 901555bf4b73..c8176265c15c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -831,6 +831,11 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
+static void cxl_port_platform_setup(struct cxl_port *port)
+{
+	cxl_port_setup_amd(port);
+}
+
 static int cxl_port_add(struct cxl_port *port,
 			resource_size_t component_reg_phys,
 			struct cxl_dport *parent_dport)
@@ -868,6 +873,8 @@ static int cxl_port_add(struct cxl_port *port,
 			return rc;
 	}
 
+	cxl_port_platform_setup(port);
+
 	rc = device_add(dev);
 	if (rc)
 		return rc;
-- 
2.39.5

