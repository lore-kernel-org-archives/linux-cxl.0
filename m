Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91F3016FA;
	Tue,  9 Dec 2025 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303720; cv=fail; b=aKFDA5vFegK5CUtFLbMtA+x62an5EKCiDfxoM31r1BSUmWGpQgGEqeIw3IR0Klzu6tYkL9W9M4ni9VppLUqz+MaQMkI+IPTNraAqOmJqNpgXN5iS7Mynpa3A1XLm8C1mpqPIJE+b4BBwt1FWC3ARqTFEwS4dO/6T58qV/AGq904=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303720; c=relaxed/simple;
	bh=mzuAmjSzNPsjnoMAFXZiaMLPFhlmq3kTeb1KRaZcwfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tm3nQakfOkYsfBw2HZ0vsk3TKUqMRNF7eWSHVWgcev+2WsWqe7jMSMJpUHlyghK+9HGPZ6HMslBlayRI0pLnGMWWT6U9wTBcKeYvCuwVBWtb1tvPzKC/WgHDYkQw40Q//NR6XESzMYuweGufkxzmF+KdFuLMB58tJ8AflUMWejg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bX3Zy18o; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bX3Zy18o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZmKbVlB4Iqw8/Tjf0l2VFjy+JX43K7oV+ir4QjADzXukxScAiIjgApHolqBmPxSZ76Zhz/S6gUG/joAfp2GL7+1kEx58FzZtZcQPhgJttqf0IfM6yaGwC9nA5WRhL2z3yuDfhWQPfm/N3oSj39sSoEeZHBMkY/rsuI0Id4emReSxBMEOJThcg/uJAlQuZRNJS6cNMuABHE4aaiyvXgkbWC0sSM4T5lj2QaWdycEVltUrk4of/7VvL+lMQzE2b3HAtpofXCb2Ezg/TVyH5UaC6tg7y0m5048lig1u9wm41yqrhr6KNzkwU2Pcd8ynrOx7xYUX/z6NmhiIM2SGJjsiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtanoWrw0USnqarqpTYwQJlGPCMhEhfy+OG24+dv7kw=;
 b=MPW4WVMp/nGVSTV8rHkDrlGNoNscrlF1sx9jkAHvx9QUcedPANrh8el8LMT9B4ov28PkgnF4raCKsparfM+KI/4FhM5FRnlKpFBpzfdXL1UKAR2M9+ZW512MWRi7j/I3uFEzBX+XMW18qOZeo582VU3tzZ4N39PsQ7cKqqCrbIMcm50jeUFMcrfeTpn5t8Q5oZoppUzJdXvlESaMtFDXhy4wAXLqofhNx+Qg99MRXx2T7teSklvsA4NZ1iIWUk1hvvepOb2WmXfJWV8MaAGF2GeRFK+xTHXLyHwsV6j1FY30Yxcfvikfuwo8h3hbPXghMvmTsfTn2291wPlQeEZNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtanoWrw0USnqarqpTYwQJlGPCMhEhfy+OG24+dv7kw=;
 b=bX3Zy18obb5L2ySLmrbeaDVZuk86QW/30ly4TLtsPikOywIl+hpr89PjAlL2VhEgoKOqc68HitCXukGFjFpiP7xA6TDawElWp/TPWvI7y/Q9EzxPHCu25Sjq4NmoWa6k0/5HlP9O6g1A1LkjlcLPH1VvNCq5oMzmb93OTaQPJXs=
Received: from BYAPR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:e0::15)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 18:08:35 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::15) by BYAPR05CA0074.outlook.office365.com
 (2603:10b6:a03:e0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:08:34 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:08:31 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 10/13] cxl: Enable AMD Zen5 address translation using ACPI PRMT
Date: Tue, 9 Dec 2025 19:06:46 +0100
Message-ID: <20251209180659.208842-11-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209180659.208842-1-rrichter@amd.com>
References: <20251209180659.208842-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7ddbe3-92fc-4f7a-9611-08de374df837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVdSR05tQTcxSDBoUjV4VzhOUVJlbk9NQkJOVDE4WlNYdTR3TUhsUGNvMUlX?=
 =?utf-8?B?L1lLS21YNVUwMTJmU2QxdnFQNUF3TkE2b2o4ZW1mYnZaclUwUzhjRWVEbVJo?=
 =?utf-8?B?UDFBRW55VTh4KzVXTDZpdG5aVTFDTW1xcFdwVkl6TGxWWGxjOFVLSmRqMHc3?=
 =?utf-8?B?bEtBc2Fkb0FmeUQ0ZHpybmNRdk10ZmxiZ01GODc3eldLSlA3aklyeVdnZTZw?=
 =?utf-8?B?Vm9vMmgxWmFETHpmVzI4N1g0VTl5UE9NWU1CcVRTNjhYUFhCM3FSV2RVQVVn?=
 =?utf-8?B?M0ZWSW5MYlVmOHNNd250VUEzSzR4QU5XUU15TVpsa0hjb2ZXQ0ZobDdyemw2?=
 =?utf-8?B?Q1haWVp5L0JyTFA0MktzanBVVXdHcnNWWEV4YnRwWGUyUnZZUUFiM3grNi8x?=
 =?utf-8?B?UkFKeENCT2NSSEtnanc0cDRFdlU3U3cyV3djVjFIN21pK1dCUVZmek44Smgz?=
 =?utf-8?B?RVlyRjkvMUQ5RWVWTjNhSkl0VHQ0aHdGeFZuRnRHUEVUNFEzU3lIaEFNSm4r?=
 =?utf-8?B?OFh2V0lLdXpRaTlkMWZqTUw1N04zZnN6bUJVeUZGZDQxalBSb2ZzbmRrbVhS?=
 =?utf-8?B?dEMrRHVTa2h1WjduM1labXNiV2dGRStZWVp2eEtCSm9rN3BKR29vUWZIVStJ?=
 =?utf-8?B?TDkrVnhSL1lPL1Z1TmZ6NHdJeCtQcXJTOUgzRDE4R1V1ckpiZkt3U3NzMWE0?=
 =?utf-8?B?ZW55OVpQcDFlK3Evd1ByZzVqdkk0YmtXN3NMbWtFYlBpM0lwdHRUM24yQmVZ?=
 =?utf-8?B?R3JldjRIbFhzRDdVRHc3dUIxVjhWb1VicWt5MGI2UjdoMHdkVWI4cDJJUFZD?=
 =?utf-8?B?ck5VN013amFwa00zRXZTYXJFWS90cldCcVVEYXJDNnZjWkw1cE9GeHBjSFpm?=
 =?utf-8?B?Nm5aSFhnRTVpTXVIZ2pCVEt6WmlMbTdtQ0hYKzk4TjBPVk9uVU4rTEFRa1ZG?=
 =?utf-8?B?ZHFyMUg0dmpURHJ2MXRRbXppbUROZUxJRmVQaG42S2lYWGNNQUIzK2kwV0Vw?=
 =?utf-8?B?U3RPeU1Eb21CTk9hZW9rdU4zdzdRRmM2R2FqUGFpUTk1VXhRakozSWdsUVBL?=
 =?utf-8?B?ZTNCdktUazl4SmdCZ0QrMkgycDBOd0dhUnFoQmV5dkFkYXJNSmw5UVk3S0xU?=
 =?utf-8?B?cnJJQlN2ak54RVRJWVpTMjZ1ZUljZFFrTk9kNXQyM0oxNzkwQjZYTWZSWHpV?=
 =?utf-8?B?ZUJycVpzWm8wL1ZKQ040Yk5PYUE2bzRSanlMcFdGU3hGQXltNEZiOXJCTHRW?=
 =?utf-8?B?b0wwdFdGN0NtTDd6TWJ6RkxsQzFnNzFuaTZiTS9RNkszdXh0QU5kWjF3M0Zk?=
 =?utf-8?B?dGliRlhGSHlSd3UrV1VEckxRQnJEUkVFaXk5c2RvNzNwQmo5TWhqeWgwaGNo?=
 =?utf-8?B?STJCcklVVjNOcWwwSElGLy9hWkZXbHlock5DUllVTVVoMFQ1am1BdzRvRjBv?=
 =?utf-8?B?MGs5SlYzVXh4eEJGWEVSTWRoTW9jWWloRjVnZHZ1RllhSmRxc3I1b1FMU2NH?=
 =?utf-8?B?VEZYaXRmT25idmpkOVlQdEt1TWtiV1ZsUXMvSjBnRURpV2xOa2E2bTVibm9F?=
 =?utf-8?B?TTRPdHJ3TXh5UlFqWmFDbUcxWVh1ZkZlcUVaRFROcXBYTXdFQjVUc0kxTmp1?=
 =?utf-8?B?d1hPbVZNQStzeUdteXRpK21PUFVLL2d0c1FiRVB6aUNpK2lHaTFwOGFqbytS?=
 =?utf-8?B?Wi9BbDNSdFZKWFlCc2g4ZHRjVFpWUFdPeEN3S3N5Q1NNT3RYYmZqOVJ5allq?=
 =?utf-8?B?VGJESDE1YmR1eHJDc0Z6SDY2eTA5ejJsZ0kzUDR6ajlxWkQ4UlBrWXZla0Zv?=
 =?utf-8?B?Zk9pSjVURTNOWlFlT0FselNtZit0WVpkUEp0SHJ6SGZ2V3Z2WHQwTVVBeWo1?=
 =?utf-8?B?NlF3RWtrN0Q2QnR3aDJ4WUhpQXEwM1FwQXQ0bjMwekZmeFprSWlXR0dRTFI3?=
 =?utf-8?B?S1N1WVhqNTVnMGx2TVZsNTJaV3N0dGZxRUh1clJtWE1NZHkxeksrUUM3ejlZ?=
 =?utf-8?B?WWVJUWhoV2ZYZFNUeS9ISzlTYkxHOWY5dDFReDdTd2tHeFhoVjdDVjMweFFy?=
 =?utf-8?B?cnc0VjNXeElJYWQ2UjBPaEt1ZGQ5cVU0YWNZdnppNVp2VzhOZ2xONjlOekNj?=
 =?utf-8?Q?HmCk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:08:34.8800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7ddbe3-92fc-4f7a-9611-08de374df837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418

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
index 000000000000..8293a55127cb
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
+static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
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

