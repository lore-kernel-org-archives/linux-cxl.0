Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92926323417;
	Mon,  3 Nov 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195779; cv=fail; b=sNl3uOoi9kVffDk1KcbZcBJpBWitTMOXT3M0V3gTZNM8p1ZosuSEXvbPzqraP8/WKdJ7dz4hbpTU/XBq3mND3Mp0qRZEsu5OYzV35gyi6mjR7RH8hz8iol12k1svUNomT6EhKEhuRx6h+FLrQSWEK0Cru0/a2aDl2erXz4+Wcv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195779; c=relaxed/simple;
	bh=8/Wxy7LBRDcYtD+9KVuNzbKFFTQbF0p0ZqSvl4mG0MA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V174vFSk9WJnX1Wz98J/zMj9zZ39TNUJbYem4dBoKMQ1Q68kbRLkmx4RCT2bHrRokLwG0tpOqzUvfxMSmAXTVQ6G6Oyq/2DgJtKqFPjtFb5CUWhCsLLQY0A2SIi7UqkOhvIBW9h/BdH6cWnA3BO464LIJUQKm5fCMMdPeTtw2Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IlugACai; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IlugACai"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AErff3XhjDRkXWQ71MZsajmwWc+K9gKD+2Fu0oBMlNhfO7GpaxZZlQWj9N3XfzQTu/e2xURchOnnXEebvSfSy0AY5id0U6vMPm/ID5e+DZqG6KLAji66u5U5+MXR6PbQ8/55kmTA3q8h3I/vyYjzDzH2xPlXueMCPkjIYQU67Y/iHP3SKLilWrdS/m+J5NvnLTDLE+8ZHHKxd5Bv1Z2Gk8zUOb+Z3k2MVOW4qlAe+OncepVci0jrT9DvJBOw6OW2rkI/8ohYiSYeIgRGcEJc0Ad0MqjCgXD/JkoEgV1BS9CsmiXdXZUtu8y8D9eiVVwVgWoq6ItxyALyQp05L/rh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV/SLH2zzt4Qyu6tUdrRtVgSMXkopDS+FMa+1iY6GRs=;
 b=DFwb3c7JdOdWD/IBGY/71AfVpJIiUEZ5jYaNK6bTkH8LGk690d+/ETr7u2v8Wdm5Idel6HJqjyNc22B3Ot52VbjSpqRsatYA5sEvIV5g/Anb6sXCxv8zDBnkO4+MY1igU4Hh/unSKoPEGtboSBRfC3bawlU1oSbGCd20dqF5FWY1VTQJpl8Xf18RFUetw+A+2R/RsqWoKS71mxaMSGiP7INh1vflhe/yjbpJAxOHNb89QSDGZGPhior3gRXM0yWAZJawrQ5CKTUWwhdi7629lq5nCIpgtVEBzCEWnWZ8qgtJJBt/L+4TwLap2F29v9BTSjQnbLc8APFBUCcHKLDAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV/SLH2zzt4Qyu6tUdrRtVgSMXkopDS+FMa+1iY6GRs=;
 b=IlugACai8V30LvG5klivFlsuX6TxF+A9nwDPcXoFk8tIGnQEBflBGs2fSEAXKk9w2rQjRfJC/ni268qM/KjXu/9SN8v1sUgIkEsLuJTiy4g9BJXClSI4SjXxTju9Slv6CrkHG0icvshJL/mJMOPlIX4fEtSl6vAltcXiYNzjq1c=
Received: from BLAPR03CA0150.namprd03.prod.outlook.com (2603:10b6:208:32e::35)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:49:35 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::9a) by BLAPR03CA0150.outlook.office365.com
 (2603:10b6:208:32e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 18:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:49:34 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:49:29 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using ACPI PRMT
Date: Mon, 3 Nov 2025 19:47:51 +0100
Message-ID: <20251103184804.509762-11-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103184804.509762-1-rrichter@amd.com>
References: <20251103184804.509762-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: 7583b269-8271-45e4-873b-08de1b09bbab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nks4bG1qczkrcm5NTXVIWk9heG9ZTXVKY2wrNS81a0x4amYxNG9seTRTVFh3?=
 =?utf-8?B?SUhxVngzSXBVaVp5cHZzV1VEMXVzbXRYWW9LbWwwSjl3dmxtZUpYT1dZdkY4?=
 =?utf-8?B?dUVBRW1vaUF2cnlZK3FNWHBhQnZ6YU9DZ0ZiSUhPdGZ0VFRXNFRBdkZOZ3VE?=
 =?utf-8?B?anFSejdoaTFaWGtmWWY3WGlyeGJjcWcwWVdZcU5jQnNsZFhaeCtZL3NuM2xt?=
 =?utf-8?B?Szl3b0ZhV3N0cVd0Q2dIeTlNR0JUMUJrbFZQeU5zL2FDQzhFcHdYZmNYYmRL?=
 =?utf-8?B?ZGVEbkRyTjNzN2I4VFlBdndEMDhzZld0RmpxVzhwTFk5Q1g5bWRsblNrZDV3?=
 =?utf-8?B?V1B5MmNERFdheStqL3RPNTdpbEVyWjVXb2h2NjdSR0ZQVCtEcjNHdGU2Q3di?=
 =?utf-8?B?TmcySVBUV2NsRTNaK3h3eFB5OGVlWE1xN0hSTVFxMThxeUd2TXFEaUFIYlRP?=
 =?utf-8?B?VXJldCtKQVdTVGV4clZlZlJZT0krZXhObTREY2tSVG9MVUFwWm5NRWlTanV0?=
 =?utf-8?B?MkdZVTZEZlp5LzV5TnB5RUZsVUg0VEFtTjVNeThlUEpDcDBXNEgzMVplRkJM?=
 =?utf-8?B?eTF6T2NjNGczbjhSdDcwVG51UTJnak4rd3Q3akxFWHA5M1RVdEdGbVl0aDV5?=
 =?utf-8?B?ZmFMaTJHb3RIemZJRDY2dXgzZVRuYXVBUlpsUmpWN2hxTWRNbjhPSitwK0VI?=
 =?utf-8?B?ZjFENUZRWG82SFVzYmpxQU1POTc2RVpmeDZNRjh2T0VsT1RqZTM5VTNRelBy?=
 =?utf-8?B?SkgrNW1MTVRmYUx5emhzWituZ3pKb1pwSUt3Mk5sNDVXdVFwbGhBU0JGWUNH?=
 =?utf-8?B?YzlNUFVVUWFGUmpqY3pJYmx0eUhFMmtnV1BoS09WZy9SS3dWbGowRGQwMGY0?=
 =?utf-8?B?SDJzZUxWYkMxelBaQStualM2SlZMYTQweGROcHZRb29DbmxlZzNpc1N6ajJC?=
 =?utf-8?B?djBBUzYxeWtpVUpEVjRuNWt2MkNhUHNIWnJNeGtRT05xdlh6NDNIbW9CZjd4?=
 =?utf-8?B?NjZCa2pQRjJQNTFIZEQyT1VFYk43WUEvWWRFOThXSmVJcGdhazlVS2FVNWFD?=
 =?utf-8?B?RjNRNWhmbkdHdDZacm1VRldFUi9hdnY0NkhlQjE5VHZuSkhpM2w1b0krUkRF?=
 =?utf-8?B?T3p0QkdJcmQ4Zk5oWnNSRXErcjZzdkxTYzN4TUV5T2NLNE5lVEwwQmVFUUlp?=
 =?utf-8?B?cnhxRlYxR0dma0tXN2JheW81NTg0UGF4UHU5STA2dFJjbkVCcEs2eUlvdUJp?=
 =?utf-8?B?WnE4cXFpWTNYT0tkUGFZd1NTb3plclVqQVV1bnBhK2JYbXU2d0x1M1dLN2x5?=
 =?utf-8?B?emJORm1EaFoxU1dYVDJmZU1RekxTV2VsUkllUjAwZnZ1K1NnQ2NRNFR2aCtu?=
 =?utf-8?B?UEl4R2d5UVZGSXBCbi9ldG83VFlWbFljclJJelphaVZqNlFqSnBUVS9HWkJE?=
 =?utf-8?B?NjZJQkdNYU5NL2VqTjQyVlVTOEZyS3I4NW9TekVhVHJ6bElUYzBVWCtqcDV4?=
 =?utf-8?B?aTRlMXZNZVYzN2lNQk9wTm83S1NXc25pbWltY1laRzcxWjRDa01MdkdsQWVC?=
 =?utf-8?B?SUdBRDU3dWNOMWZLRmF1OUxXemFQQ1BHRS9VZkhlS1pKZkxRc25BaXdsaHd1?=
 =?utf-8?B?WmVBdzhwaXROYTZIM3VTWVJMOHFSekNxcmRJTS9UTXZIUTRvOXBGQUdtSTk0?=
 =?utf-8?B?MEZUamhJWTNSai8zWEVQSFhBUndqVitIblZjK2ZvVVg5ZmcwTFJGVDBua3g3?=
 =?utf-8?B?Tk5NMHNZNXpVMUFVemtjSDZoZzFYSTF2MVByQmsrM2taemRoa0hzRm5LWFIx?=
 =?utf-8?B?bnJ1cjJjVWt6dDNEaVNVMWVLMDFVQ0xRVXNYK2dHeGZGeFk2Q0t2elY3ZHQ5?=
 =?utf-8?B?RGpjWm1mWWwvc24reWcvMWx5MFhnRWlpUnZEb1BQZzl0RTB4UG5ndUVkR1BL?=
 =?utf-8?B?RG1CbUFkTENUZ0FBZFNNQVBldVQvK0thTHBhajI5bnp5eXpwb01lWGtnSDh6?=
 =?utf-8?B?cUZwUUo2WjcvbnpjcXp1aWI2cjM2d2ZISlB0azB1NExLaGNlTnR3SlExcE05?=
 =?utf-8?B?S2EvUXAvWVlkMVQ2QkpHaG5QaStIb1FGQ3FYbFVZRVZKdndWSDM4Yk9DQzBC?=
 =?utf-8?Q?SktY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:49:34.9988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7583b269-8271-45e4-873b-08de1b09bbab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511

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

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/Kconfig       |   4 +
 drivers/cxl/acpi.c        |   2 +
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 195 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   7 ++
 5 files changed, 209 insertions(+)
 create mode 100644 drivers/cxl/core/atl.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..e599badba69b 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -233,4 +233,8 @@ config CXL_MCE
 	def_bool y
 	depends on X86_MCE && MEMORY_FAILURE
 
+config CXL_ATL
+       def_bool y
+       depends on ACPI_PRMT && AMD_NB
+
 endif
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a54d56376787..f9bbc77f3ec2 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -916,6 +916,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
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
index 000000000000..d6aa7e6d0ac5
--- /dev/null
+++ b/drivers/cxl/core/atl.c
@@ -0,0 +1,195 @@
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
+	struct cxl_memdev *cxlmd = ctx->cxlmd;
+	struct range hpa_range = ctx->hpa_range;
+	struct pci_dev *pci_dev;
+	u64 spa_len, len = range_len(&hpa_range);
+	u64 addr, base_spa, base = hpa_range.start;
+	int ways, gran;
+
+	/*
+	 * When Normalized Addressing is enabled, the endpoint
+	 * maintains a 1:1 mapping between HPA and DPA. If disabled,
+	 * skip address translation and perform only a range check.
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
+	 * Endpoints are programmed passthrough in Normalized
+	 * Addressing mode.
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
+	hpa_range.start = base_spa = prm_cxl_dpa_spa(pci_dev, hpa_range.start);
+	hpa_range.end = prm_cxl_dpa_spa(pci_dev, hpa_range.end);
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
+	 * Since translated addresses include the interleaving
+	 * offsets, align the range to 256 MB.
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
+	 * Note: The position of the chunk from one interleaving block
+	 * to the next may vary and thus cannot be considered
+	 * constant. Address offsets larger than the interleaving
+	 * block size cannot be used to calculate the granularity.
+	 */
+	while (ways > 1 && gran <= SZ_16M) {
+		addr = prm_cxl_dpa_spa(pci_dev, base + gran);
+		if (addr != base_spa + gran)
+			break;
+		gran <<= 1;
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
+		dev_name(ctx->cxlmd->dev.parent), base, len, hpa_range.start,
+		spa_len, ways, gran);
+
+	return 0;
+}
+
+void cxl_setup_prm_address_translation(struct cxl_root *cxl_root)
+{
+	struct device *host = cxl_root->port.uport_dev;
+	u64 spa;
+	struct prm_cxl_dpa_spa_data data = { .spa = &spa, };
+	int rc;
+
+	/*
+	 * Applies only to PCIe Host Bridges which are children of the
+	 * CXL Root Device (HID=“ACPI0017”). Check this and drop
+	 * cxl_test instances.
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
index 94b9fcc07469..0af46d1b0abc 100644
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

