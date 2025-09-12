Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F623191DB;
	Fri, 12 Sep 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688382; cv=fail; b=eudc4a1db8Z/FsB7Ab4EuQEGZwVvw8s2LQKdWUE7ln/dMbUoFHvVc0fUbz/RhMY6GK+AA115hPcBgC/H21exOscpWYB4T8c+ME8nm/HLvI+jgTGQE0KpwRUQE8CaK3DyNlV7FUGR7pqcG4aLk5BaCB1aztJ3CZ9K4t41pzbdcAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688382; c=relaxed/simple;
	bh=0o2uOr++iTse2VBzlNHtsPO1iqmWJT2cGPGxBNekH8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7qP+o8tUS8q2wZJvTq9OQkFSkyDidbMM1i4/Yk4ykLLAZbabdSo8bbnvIJ9LbZWQwb+d+rwpHJ0XGCUSuGhKChcoJCJKMZclPRl0KoVc9+ZHrsTXutJYs4/CFoVZeRID4yxTg1TN+LbrvxZD7sXBzl+sYeazH3xq5aC4ULAbrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WFZM9LbJ; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WFZM9LbJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iva3L5xHT25kLTJPhE+fdIN8lIvprsIHYMwek22MyOO/mj3dU0POdu0knPD6wuYBWnHGcr7JiDEqV2Kwgn+p8WOz0YRzHQRDwnz1qqGGbtKtov2lQcfwC+IVvE0a+u/CFA0rPt+mEoVTGQO0vmH+md9+AOFFWHY2qIN5c5pBD+05nM27qYNcxqZSjTCN33kzdlowLxIv9Np2heA+xbgK4Gg9RuDnMNlBpHImxoeBWFgIlAEUVYD+bp5DUSfeUH79U/aYDwpH9vIAGMmX522F2UdNviN65z/8POssyTlsXToF/HdreY2sqBvoKRsQIv5UTNlobkX3nd9fTcgjllnlAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75kHxqarCC4uRNpDe3FyHw/qmHur/xNhaHQIjDm6KRM=;
 b=t6ZigdYmx64BOvqADSRkU5P2tbbEXTp6taiYlvUVJoQ5G2ARHolVZf56jAgNUI20+fYfcUPWgi0O7lA8ZZY7e3URVCioAZhzwltDSKsAw/i9oZcD4fqkwNnNChgU8sKMsRjv0pxV0MFgJAm/7jHVL/TAkToF0eKnG///8Cz8Fk7Sxir+BMulLLomorBkyjOhhsZfh48gmJDe8su0Jg+Sbx7FVU3/s1LU7BlpFV4muLJgGL2h3f1T1UDodtLkY8xGekfKWpit+ZPDiRDvUm8gzufYuUlJh8+O0EPdJVLdDue8OyMdZAz5mVPlDxixiC3evnwZw1X6OaHyXAS3yrohjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75kHxqarCC4uRNpDe3FyHw/qmHur/xNhaHQIjDm6KRM=;
 b=WFZM9LbJAp98zzPS5CkGiBd7jT9sgxDBaBpDrekacpFD/4Y1rtg393qFT5BP7cBheDd7OwqF3sVHoSMyrBJIxDX0hRl1r4wvfENJXqX0omGrdjKNpFjYmrbwT7nGTv/boJ/DHeRq5j5FXyxUt7tJj3mxs1UWUrF7m+zOEr4SsLc=
Received: from SN4PR0501CA0110.namprd05.prod.outlook.com
 (2603:10b6:803:42::27) by SA0PR12MB4351.namprd12.prod.outlook.com
 (2603:10b6:806:71::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:46:18 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:803:42:cafe::89) by SN4PR0501CA0110.outlook.office365.com
 (2603:10b6:803:42::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Fri,
 12 Sep 2025 14:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:46:18 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:46:13 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using ACPI PRMT
Date: Fri, 12 Sep 2025 16:45:13 +0200
Message-ID: <20250912144514.526441-12-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 296c6c8b-d4ff-4818-19b1-08ddf20b21eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnlxWDkrSEpvMkl4OS9hTzVZUEFIekpXSm9pRzU0MXhFTEN3dHk4WU8wUGNl?=
 =?utf-8?B?RVVGeFAycnRTQStjN1ZaUWVMT2dTVnJySkNsRkQwUmEycDFvYy80UU80blpw?=
 =?utf-8?B?cGhMb1BBUE1NdERGMlhGc2lZSzZqVFJCMnJNbHdDVSsrSXZ2YmxEVzFXOHFs?=
 =?utf-8?B?ckthaE90cE9uSWtySVdtYmtZUnR4QVdkaVVlRUhQVk03SDRnbFBWVXFuMGZa?=
 =?utf-8?B?bG9tVDZyZGh5S0hWOXdVajlIcHNuVGZwbjJMRk01RGRUV05iRmVEMHNKZ00x?=
 =?utf-8?B?NmE4YnFQKzJwTmljZWhUUXFWRjRKUHkzRUFFaUR1UmdyOUxHb3lCZUJVS2g3?=
 =?utf-8?B?Vitqc2FreHJxdTVKUmNyS2hLUXQzV1pGT0JkS2lpa25MYnFQQTJrcnJWVER4?=
 =?utf-8?B?ellib0s5Zkh2Nkd6aklQWjcwSXpDb1NIb2FDMXNMWnMzcTJzVy9xd1psR0Jo?=
 =?utf-8?B?b0FBMHJvWC9tZVdmd2duLzErNjVFQ0ZLU21RSVZzSW9iTDRacnQyNG96UXRj?=
 =?utf-8?B?ZjlDWTAvcHZTc25BZzRkT2Y4RzY1RDd4L0xBSk5tamlRcXdmeXF4Vk9WdkU0?=
 =?utf-8?B?a3Bxc2pFNG5DMTFQcERrdTh4KzljYzlna0tkdm8zaTloSnZsTEpJKzI0MGYr?=
 =?utf-8?B?c0p4SWVLMVFxaklGalhOc2lKMVlTWDBYVEVjYmZwR2Z6Nndwckw4ZVk5NnhW?=
 =?utf-8?B?a3dMcWFiSUQ5NGcrUmt5NmhJWWs2UXlXaGY5SXhkL1FBRjg4bUtFYmFueTFq?=
 =?utf-8?B?ZEIzR1JxTlVUcmw3NEp1NTVKTkFFYm1LZFpUYzVIN2x6bDZnc0hMeWdmcElJ?=
 =?utf-8?B?SUxlRHlTZGhobHV4ajY1bjdXSk04bjBhRjJweE5qTVpLV0Z5T3ROWXFiRWh4?=
 =?utf-8?B?UkIvY2kwMnIzbUtFVDNZbldBV2h3c2JIODUzV1JrZVRBd0lpZkNsWHc4V2M2?=
 =?utf-8?B?VGhYajZJL0VBRmZPSkFLekRKbUErZ3ByWVNmSjAwL0VTT2pvRXArMXNQeXhB?=
 =?utf-8?B?TVdrRTVMTll4UHZZdWg4YkpLbWozQTFGNW1HbCtma3ZLaUlXQTE3MXhHejZr?=
 =?utf-8?B?VWVGWHJ2bEZNb01TYzJ1dnFUZk5rbEE1QVkvNVlZUHNueEh4OXM2TjEyWGdk?=
 =?utf-8?B?QnNRRjJVVGM1YTBZdEdIbEZxZ0tyTERRWUNVUjVsc0x5Q2FPY2piYmlVTnVL?=
 =?utf-8?B?endCR2R4aXJtQkptSGUvZE5XZXY4SDJFYmROZ1ZEWFU4ck1NWW8zOUNWYVJP?=
 =?utf-8?B?TGZOdjJweXNCa1QveHluZFFVWk1BWmJvOGZKUUMvOWRGRG82OWNkYlhwdFRs?=
 =?utf-8?B?OXBIRmlvb3ExbjdYZitKQkhZTWw3V2JWaXF6UnduSUJLOCtham1GVHlKa0Zo?=
 =?utf-8?B?NERRKzY5SVpKeCtlVFR1RFhTN0l0ZVJNeUcwSTJPYjFJeU5sbHBwSXVMdjFY?=
 =?utf-8?B?aXVxK0Z2RFo1QjFMU1h0RFJubWpjcWd4ekVtVW5vL0JRSTNyZXFXbCtWdm5H?=
 =?utf-8?B?N1dRQzZReFBhWXNaaVJtanM5Y0xzWDNaTnlDVURXUHJIUWxCSW5iejgzUVQz?=
 =?utf-8?B?dmNWc1ZqTzhLbXFTN2hma0ppQmlIQzBwc002Q2wwT2ljK1duSy9BRkVwYlpM?=
 =?utf-8?B?WVhoRlk4L3hHSWswSmpNa2RhU1c2bnRrWWhUeWpaMkxNemgyK3NJbWh3WXFm?=
 =?utf-8?B?czlmTVVHaW16OTQzOTFyOE41M05CL2ZvY25aWlVValFEWXQ0TUFMeVVoaUty?=
 =?utf-8?B?RmgzRnhmcTc2V0tGdE4zYWdoSmdieUxrd3k2QUZnMUJvME1wRi9VUUlad1li?=
 =?utf-8?B?ZkFXaTgxN1haeFBrNzAxRVNBOE5vTzU0b3grUUJFU2tTNWhuN0FIa0Zncm5x?=
 =?utf-8?B?SjhEM1ovNlB5SmxkR3lzUkNqcHlya1RIU0I0NjZaNFQ3NDdRLzFOenZwWnBG?=
 =?utf-8?B?aEZSUFE3SzVSdnYzNldiall2S2xvNVB6eXRYRmo0elVuaU05amgxRjhXMnFj?=
 =?utf-8?B?QnRqL2U2UzNLb29nQzJqajF0d01DNmpmM2w0eC9NNEJuTE92VUFKcmZIeTla?=
 =?utf-8?B?dDJWclduaUlXVUdNMCt1STRyNUZRdjNrb3E0UT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:46:18.3484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 296c6c8b-d4ff-4818-19b1-08ddf20b21eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351

Add AMD Zen5 support for address translation.

Zen5 systems may be configured to use 'Normalized addresses'. Then,
CXL endpoints use their own physical address space and are programmed
passthrough (DPA == HPA), the number of interleaving ways for the
endpoint is set to one. The Host Physical Addresses (HPAs) need to be
translated from the endpoint to its CXL host bridge. The HPA of a CXL
host bridge is equivalent to the System Physical Address (SPA).

ACPI Platform Runtime Mechanism (PRM) is used to translate the CXL
Device Physical Address (DPA) to its System Physical Address. This is
documented in:

 AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
 ACPI v6.5 Porting Guide, Publication # 58088
 https://www.amd.com/en/search/documentation/hub.html

To implement AMD Zen5 address translation the following steps are
needed:

AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
call (Address Translation - CXL DPA to System Physical Address, see
ACPI v6.5 Porting Guide above) when address translation is enabled.
The existence of the callback can be identified using a specific GUID
as documented. The initialization code checks firmware and kernel
support of ACPI PRM.

Introduce a new file core/atl.c to handle ACPI PRM specific address
translation code. Naming is loosely related to the kernel's AMD
Address Translation Library (CONFIG_AMD_ATL) but implementation does
not dependent on it, nor it is vendor specific. Use Kbuild and Kconfig
options respectively to enable the code depending on architecture and
platform options.

Implement an ACPI PRM firmware call for CXL address translation in the
new function cxl_prm_to_hpa(). This includes sanity checks. Enable the
callback for applicable CXL host bridges using the new cxl_atl_init()
function.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/Kconfig       |   4 ++
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 138 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/core.h   |   1 +
 drivers/cxl/core/port.c   |   8 +++
 5 files changed, 152 insertions(+)
 create mode 100644 drivers/cxl/core/atl.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..31f9c96ef908 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,8 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_ATL
+       def_bool y
+       depends on ACPI_PRMT
+
 endif
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
index 000000000000..5fc21eddaade
--- /dev/null
+++ b/drivers/cxl/core/atl.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/prmt.h>
+#include <linux/pci.h>
+
+#include <cxlmem.h>
+#include "core.h"
+
+static bool check_prm_address_translation(struct cxl_port *port)
+{
+	/* Applies to CXL host bridges only */
+	return !is_cxl_root(port) && port->host_bridge &&
+	       is_cxl_root(to_cxl_port(port->dev.parent));
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
+static u64 cxl_prm_to_hpa(struct cxl_decoder *cxld, u64 hpa)
+{
+	struct cxl_memdev *cxlmd;
+	struct pci_dev *pci_dev;
+	struct cxl_port *port;
+	struct cxl_endpoint_decoder *cxled;
+
+	/* Only translate from endpoint to its parent port. */
+	if (!is_endpoint_decoder(&cxld->dev))
+		return hpa;
+
+	cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
+	/*
+	 * Nothing to do if base is non-zero and Normalized Addressing
+	 * is disabled.
+	 */
+	if (cxld->hpa_range.start != cxled->dpa_res->start)
+		return hpa;
+
+	/*
+	 * Endpoints are programmed passthrough in Normalized
+	 * Addressing mode.
+	 */
+	if (cxld->interleave_ways != 1) {
+		dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
+			cxld->interleave_ways, cxld->interleave_granularity);
+		return ULLONG_MAX;
+	}
+
+	if (hpa < cxld->hpa_range.start || hpa > cxld->hpa_range.end) {
+		dev_dbg(&cxld->dev, "hpa addr %#llx out of range %#llx-%#llx\n",
+			hpa, cxld->hpa_range.start, cxld->hpa_range.end);
+		return ULLONG_MAX;
+	}
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
+	return prm_cxl_dpa_spa(pci_dev, hpa);
+}
+
+static void cxl_prm_init(struct cxl_port *port)
+{
+	u64 spa;
+	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
+	int rc;
+
+	if (!check_prm_address_translation(port))
+		return;
+
+	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
+	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
+	if (rc == -EOPNOTSUPP || rc == -ENODEV)
+		return;
+
+	port->to_hpa = cxl_prm_to_hpa;
+
+	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
+		dev_name(&port->dev));
+}
+
+void cxl_atl_init(struct cxl_port *port)
+{
+	cxl_prm_init(port);
+}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index eac8cc1bdaa0..624e438d052a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -150,6 +150,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 int cxl_ras_init(void);
 void cxl_ras_exit(void);
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+void cxl_atl_init(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_FEATURES
 struct cxl_feat_entry *
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8f36ff413f5d..8007e002888e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -831,6 +831,12 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 			    &cxl_einj_inject_fops);
 }
 
+static void setup_address_translation(struct cxl_port *port)
+{
+	if (IS_ENABLED(CONFIG_CXL_ATL))
+		cxl_atl_init(port);
+}
+
 static int cxl_port_add(struct cxl_port *port,
 			resource_size_t component_reg_phys,
 			struct cxl_dport *parent_dport)
@@ -868,6 +874,8 @@ static int cxl_port_add(struct cxl_port *port,
 			return rc;
 	}
 
+	setup_address_translation(port);
+
 	rc = device_add(dev);
 	if (rc)
 		return rc;
-- 
2.39.5

