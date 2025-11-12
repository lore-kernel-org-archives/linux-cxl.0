Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D72D12F1;
	Wed, 12 Nov 2025 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979560; cv=fail; b=oZ3zUWGVX7T8Vn+dqXITD6ZDKYFsZVrj0tnd2zjQo6hTirD0zSgS2dwcvqH/OeI05ypSXBRmRm7jd4+F2rzjTHdPDB1PGoajsGXRwyXyi7y1RkJsMEDZrqrhe95h+T3+QyxxWKDkF2KZ6xxicHEBfmDfaRhQiQS3DqkQUrdsvtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979560; c=relaxed/simple;
	bh=uM5JrNiyQ+aBsosjuRqBzdokOyPz0C/NxTBEFwjxJ+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvzUeiJHXpH7gDBB6zsWUmTu+taI1jSnkZ6Lhi6tqaJnLUzSOWgZxbMhGMVOPxPAqMKfqZ1T1GxRFLvntWW++KWR2H2ZvSJ5jdaPm6YVquqZgHmlcvkHMQ1liLcpqzuDjMkzgIjQc8Y9nxP7NEGbI9VLOissw9Lse/bSXMoiWOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iVUJDHx0; arc=fail smtp.client-ip=52.101.61.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iVUJDHx0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHMmnmbpFAnhk1r7snRmvGAOeAWZzlYmJonPTG7VCdgamExfpe2IQdSSWzkqgzlf6TGvej61mGhQhhy4K1uA04uCdIiEfl24P4fQh/FFTZA3oqKu5EwvXABl2XadnbKZY9tsd8d7p+sS3ehEtNustPQAAUbhUKxsUC84xo+jmra82zdpNqzqBjCEHMSq9xsFqTASeUgLM/1IrrrX8oAjM68P8SXXlb6uZwe4Vlb3Z63mn06RTGSYGTusRbvSxJnbu0JHSMoed+rJUqwTCvAGx3Lpe9HEMrsoW9Mn4wJWcW6WmQ/USPsi9mXkTcNt/PaMhqynGDNSoXEVrNSFd8W36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XG4IORp+ReIyPAJg4VqSX0ZUp6V1hZny1BXl47d9+cQ=;
 b=VydPk1NEBH48F4Ch+bmDtOFFu2nhY5cYj6yMVnspd6PeY371izwGd3U1hjPDkzWFD7Ww0L3s1ICsiq5FmfCGK6ai4ilkolMsqcTQfHW4/uD6H/EYB5BpitWSqyrC8ue4GTlofRIFRsWTWg49VUg/X9qpCyRA1sFq7V/mRsi3hBkLQ6YEXx3tqU60q6b+/j1AdIIs8HImqRuguo+I3NFP49EeDsVS3vKN/gcU5u3YKltyPao+jaiWQp7hdUCx8h9J/DLtdOOD66AMJkB+UMrUAg05vYQNym2trzzjXIsX39mFGSA8xZVxw/RdGvu3Ud+VfJiwifcQpXuekrRh/Cg82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XG4IORp+ReIyPAJg4VqSX0ZUp6V1hZny1BXl47d9+cQ=;
 b=iVUJDHx0hPgXL8n2OiEXQDhjv+5GzDXed11Yx+DF1a50R0XSivVjNJzSiKi9RHnwg0yaYAoiwCEMde76Ja9Bl4ZRWjHumc/6golyrLHVblfvF2P2D2ryQXL8yRvrXpDlgtw2/ejKMRAZMQ0UMnRR1YcXfK3A9HgSjhkWkM4yAcI=
Received: from CH2PR18CA0038.namprd18.prod.outlook.com (2603:10b6:610:55::18)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 20:32:30 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::af) by CH2PR18CA0038.outlook.office365.com
 (2603:10b6:610:55::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 20:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:32:30 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:32:27 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 10/11] cxl: Enable AMD Zen5 address translation using ACPI PRMT
Date: Wed, 12 Nov 2025 21:31:37 +0100
Message-ID: <20251112203143.1269944-11-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251112203143.1269944-1-rrichter@amd.com>
References: <20251112203143.1269944-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: ff723e9a-666a-4e18-e24a-08de222a9a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTBMaXM4aXJlYzBPTjVxZlBVWTFtRERzT0pNU0pUZVdzTkNZd3ZLVklmd0xU?=
 =?utf-8?B?YzFXWCtqQUVJUStmajZZcFNVL1lZMm5OZC9IaEFhLzBTYjI0TFFjcVBSY3pK?=
 =?utf-8?B?UG41d2x1TGorZXlBZS9jbVZCenM1RmM1bGpVTWM0d0lEbzQ0TTRUQmhZem9y?=
 =?utf-8?B?aDl3eVNPQTlvWTVjQkkrUU1CbzdvcTdsckZ4d0hzYTVGUisrdEtWTHY5bjJR?=
 =?utf-8?B?eEo3MzVtQWhRakx0aGZVazIxTDVhL1RMbGlRK2Z6UjlMZ0Zub2cwSXFNWWtX?=
 =?utf-8?B?bHByallSMVFrT3BSM3VTL2ZPeVFzVWkrRVBNbFpHVVo0N3lFUHhjVW9qNTBR?=
 =?utf-8?B?RytRZks2SnJKSHEwR2ZVcHBPVUc5OGVpbHdiYS9UZ1NmcEh3NW5vUUt4ZXNh?=
 =?utf-8?B?YzN5cS8rSk9kOGhtMDNFVnR5UkxNdzBvUXVXcGNpaXZldElnQkt2RDF1QnF1?=
 =?utf-8?B?UlJuSC92dkkzeitZdUtUWmtVck5YaGlWMFozdTA0OXQ4TUhlVUovL2h3YnNH?=
 =?utf-8?B?UlhNL3c1OVg5bDIzN2EzZUpWdk5DNmwvK0FqcFFqNGFvV1Boa1RGMUFQWDZW?=
 =?utf-8?B?VldFMmhGMW1UOTlDb3J2NUsyY2FuM1UreTZ3alVGN1JZUlpuKzAvOTVEVi92?=
 =?utf-8?B?Q2tLbVE3QmlaMVZhQ1F4bm1oVFFka0QxMktSdE1NU0Y5ZFI5VjdlcUx2UEE1?=
 =?utf-8?B?YnUyZGRMSlZ3ZG9JT0NuTGNVREpuNlA1Y3VSdnp6eVd0WVZyNUo3c3YzZEVV?=
 =?utf-8?B?U3NIeThNV2tpSUwrVm9JQitTZUlxMFl3NTRwbE11NXRBV2Vjd1ltNTdGZUpn?=
 =?utf-8?B?aWtIdXRuTHRac1JWMVRZNWxBQ21zN2IrWkhpNXYzeXBlTGlxRjNXM1htNzhE?=
 =?utf-8?B?VTNjdjBoR1NhL1pvdElJZWpIeFhqTXhBY01uMXBJVGdXMklzRnhSZHJrUkdO?=
 =?utf-8?B?bVhxd3RCalVjZ1NnTkQvSlpFQ0MvSEtvaElBaXd1a0dkeVVuT3Z3M1o2aXFp?=
 =?utf-8?B?cnphL0lyM2pQOWkyYWNMU2F5dDgrRjc4NzhiTWQ5VEFKaWROVUQzRnl2ZzFr?=
 =?utf-8?B?VGRkRFoyT2RISjFkYmk2VzdVZFYyOGVSc0xFYm01WjNsMktCcFZram4rVDRR?=
 =?utf-8?B?WFI2dWNBN0pSbGVUVlhhVTBhOWw3YnA1VXllc05yMG14SzNDb2h2UGN1TEFL?=
 =?utf-8?B?MkhqZm5kZlA0ZGMxUFMrZGlNb3JLcHR0VjEzem1veDd5Y1hxYk5YTnBlRDJS?=
 =?utf-8?B?UGlFRFlTNUlkbk54YlVDcWtuQ2g3MDkrcHA4MjdKQS9IaVNQWWg5WUNXZWtR?=
 =?utf-8?B?cStLMzdtYnNVQ1poYURSdTBlZkxyYitjbHRLZGk5WVZpQU1YN251dENEL1FH?=
 =?utf-8?B?RkhhbWt5bUloUmUzalk4cy8yMllxa0dRejA0c0hyQnVlTURoMmlDamJlR0oy?=
 =?utf-8?B?bTZpRTBZaWhZVzBFOTB5azIrdk5TdkZpaDdrb1o4S1RtK1RTMnhBVHE2ODM4?=
 =?utf-8?B?T29GcGZzcTlybytoMTJKdHlLNXJOdTZTSDlXMmw1S1BDcFlib3EwTkVxM0xK?=
 =?utf-8?B?YXNwOHdIWkFMMXFNMEFCSmptS01XbHhzdG1pOTRzLzV4eW1SbHNlMkh5bGVB?=
 =?utf-8?B?d2szT0NDR05xc2dkblloYUM0VElUV1YzMWptQjViZUU2ci9ZWWFhcU9zNzBP?=
 =?utf-8?B?eWdrUGRLeE5BVkJvUGZERjdySE4vVUNoVlZCcEpURmpqWXVTdUtBNWpsZ1N1?=
 =?utf-8?B?WmU2eDFTM3dOODc0aTV0ajE4eWlaUEFpZU03NFpNejA3bzVrQWVVNzBkUkJZ?=
 =?utf-8?B?N2sycHpLbnVBZG5nMTNpb01heTlwenRNZXRRcktlSmRpWkl1ZnpGRTlWSEh1?=
 =?utf-8?B?b2FRcHVLaXVrYzBqQ1ZkRDJXTENQOGtvR3JsSXd0VDJrOWhlL2pPblk5VXpY?=
 =?utf-8?B?ZlVXV0lnb25vSVNvaWQ4WVlwR3FrM2lCOU5ueldDc29lK2x1NzQrYUhnaDJF?=
 =?utf-8?B?cFBKVkxCWDlBbEV5eHRSQmplSUswVWlwWUdWNUxLdWlXeEdQZm9iOVlibm1t?=
 =?utf-8?B?VW45cGY5VXZ1TFlzQU5DalNLU05WSzFiQmozNXc3ODB0MENSeU4vakU5Y0pQ?=
 =?utf-8?Q?czaM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:32:30.6531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff723e9a-666a-4e18-e24a-08de222a9a61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675

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
index 52b3c162a564..d5119de7f5a9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -932,6 +932,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
index 8d056095402a..0481679eb109 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -809,6 +809,13 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
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

