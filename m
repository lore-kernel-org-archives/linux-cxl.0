Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0F269886;
	Tue, 18 Feb 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885137; cv=fail; b=b5F65FquNS6kVMqxL01vp5JFcFKHW/jY9CiFhH7GjcxWk8DpI/9gqMUL/+ZhAAbbNT2IDFV/GawSt+P9RGhPKuY6rPDF2hk1abxGsgqodhOzXzuy0wbqzi+PYbXxQp3lmO+Gi1kQkQvjWyETLgVj50kgsOvpp4on3q6tuXETnes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885137; c=relaxed/simple;
	bh=UHeY1F6V2ElaR7y9xEbfujBkC47629s13r5eXbhB3/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+6OXpY9UZl3e282Zn/P44IT/gbnItD61eel2lIr+TCWtkwbPBhGV5MrGZXBxpefudr2h8MBakYVxV31Xfv41l95Pwtr5d329ni1vBBoie7JweuwqeMeq0M/Yr37kOTqtiZ3lgPLrQVZZOjH+KpAh5fmZedoS68a/+WA9ejrnc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B8x8Fy6Z; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B8x8Fy6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqXhP/Bo5xKLZBnfiQWkFVAcXBNUXe8dRGxRiO45EG1LqmihGK0MJKnLyW+ILEh81GUUZhpqDBvRk/vqXXvHP9qdBfOUWtvpwTkBuap7Io2dwtIJX++1Y9QCwCz+1/ZY3S9eKHjWMlEKVfBSz0cwl7nrTwRA50KnmJYPGAO5QglKxL2B8YbwtQPcvoiTHUHzP4OWyf7HvkMGn56ME12CtANE6C0419dQmeCc8q3hyy4N+PMzNvMwf7zQ2yGWEel/yEu6Flx6oFkbevlc87s+tQbBkugSPfy2pcS5qSqM+elryR6VxwgaedGF8T9ZtZdZX1a7qrYn6tab1ZeOHm6Yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xf4qVBpUQ0Fp5R6OMijQ7zVj7KhB2R6SDYvYz2CwNAg=;
 b=cpuvg3VsWXDC5Lj9nT6Zz2HUVujoOvjHYXan5tHbmIg/n5XNUapRoIE59NULpZMEhZblZhPrpRp1Ft8PAxg0xwGrQg7RHoMunouGSxtXIcgTaxGCkVhjnUf8TvJ0e3Wl9GmO4Us7uonK3qfLeWMfd21UE/BkFFhl8dVQgOgSfIniyDhDiM8qUODOeLw3oRRZMwSM6RzJlTd8C3psBxC8pnN+pCP5kG5v+IIkzkeRI9eWFmQ1qc68fjEgPDiKeUOlN9ifgMIIVDAwEwrAb88f99XGOVvxyAU4oc+76bvmu+tlTn8xU1NGx8XHTuhLmKp3a4XWuzH7p+wRR04yZye4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xf4qVBpUQ0Fp5R6OMijQ7zVj7KhB2R6SDYvYz2CwNAg=;
 b=B8x8Fy6ZsBYmbkE7nMKaxg9D9MF5uqiyTSiwBzQX7+tposmUgG5QoZcwiEvbJa2KysV5cxE7BQKJyOUnmRQiTlaxIJPm/iEevi8Z+bU73pp/Cv84BvjHnRHsD00u+Ez03F+WNRujzH4EkUnIH8VoP9Q/1Z3153uRIFbEHHnbQaQ=
Received: from BN1PR14CA0002.namprd14.prod.outlook.com (2603:10b6:408:e3::7)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 13:25:25 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::39) by BN1PR14CA0002.outlook.office365.com
 (2603:10b6:408:e3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.19 via Frontend Transport; Tue,
 18 Feb 2025 13:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 13:25:25 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 07:25:22 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Robert Richter <rrichter@amd.com>, Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2 14/15] cxl/amd: Enable Zen5 address translation using ACPI PRMT
Date: Tue, 18 Feb 2025 14:23:55 +0100
Message-ID: <20250218132356.1809075-15-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218132356.1809075-1-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8d9539-87a3-4d0c-be09-08dd501fb441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGVhOUUzWXBVVm1zUlN4Z3NUak9UeVA5V1grQ3NNMmU2SFpXdk9EYXZUVE05?=
 =?utf-8?B?NThGYjd0d3diUmxTT2xLdjRaS3FhcnpuZDdzV3Q3K0lQbzU1Rjl1MGR6Qllk?=
 =?utf-8?B?UERVODBoV1M5Y3lRS0lnT242dFdhOG1LdXpsTkQyNmUwY2IrSVVxZTAwV3Rx?=
 =?utf-8?B?T0NsNENtUU1panp0K1RJV3dDTkdBbUJsRUd5Z1R2OTljOU94TUZqMzYvZmJx?=
 =?utf-8?B?OG9mT3I4UDlEc1VPYnVYeGFha2E4eDlXdE9HWDdrTjc4cUJVWkNzTUthVlNN?=
 =?utf-8?B?eS9xdWlzTGdlb2lzWDU1dDdZSGYxZWpQbFovS0JQdjZBbHY2WDJ2dHk5RUM0?=
 =?utf-8?B?a0k1VGdYRTFsUnk2b1JqSnNjUlhrKzRrMm9VQ0Z5YnZUdC9iSUx5RS83QzFD?=
 =?utf-8?B?S0RUbE41Ry9MYWc1OU91T2FXSnUzZjRqVit3M2p1T0JmTkFveGZjVk9seURD?=
 =?utf-8?B?SmU1dTFjTW0yT2diNmZFYWRuMzBrSU42SVA4M0JVRXpvbGxrQlVwY0RmYU8x?=
 =?utf-8?B?MWpTQ09HbnYrQk1UaEkyV01vaDlKeHhFbllDYnFvU3hzR3d5cXF6Qk0rMEZ1?=
 =?utf-8?B?Vy9yd3RhbWs5cW9FKzdpSTRQY0xBbVRoOFc3THJLVzdyRThJcXhtQlNGSS93?=
 =?utf-8?B?M09CNXBIc2dLcjRmaThTdVloVU92ZERJREorNG54YWRzaWFkWHllekhvQTJr?=
 =?utf-8?B?RFFGd2VoOGZiU00rU1lWL3d0N3NHNm5ORWRoZytEMzdDa202MVZkZndZeE5E?=
 =?utf-8?B?YzZXR3JLdkZKbVF3MEROOThMWUE5dC91QXVzb0l5S3NqdzBnMzloYk9TZ2Qv?=
 =?utf-8?B?UUtsR1lvVkZSQ21KV2lpTWcrbEc4elQzNnZZYXBPU3ducEREejBuek9CblEz?=
 =?utf-8?B?WlVObi9LbEpGSXpzcXliemhvOGpzZUxVbVdyWjFJajgyQjdkNVBFOXdLaUs5?=
 =?utf-8?B?eFRGUmd2YkdOT0ducWRBMFNVOWRXYWg4dUNWVlFOa2F3QUZ6ZjlEZVR5MFRP?=
 =?utf-8?B?aEtTSFplblovZHYwYmErUHB5alpiWTYvOHE3b0lzL3NPRStPT1QwMlBHc2xY?=
 =?utf-8?B?aGdxMmF3QU9uQmkxQnNRYnFHRGJsOTZKaG96Q1JrZlU0T2pZR1hxSmwybXU2?=
 =?utf-8?B?YmJ0RTN5WnhkSW5WRGFvZnk1NnI3Y1A3Mm95TFRYTHFlZXhsTFdSMU1aeWVK?=
 =?utf-8?B?dGRSalRHU3pQY2ZZUXVOdU5hQStGQTI3cmJPNkhVVHliZEQ1ZC83SktJOVY0?=
 =?utf-8?B?ZkdSR0E2c1FrSk5ER2phdkc0U3p6VUlSeERNSW11Uk5GQzlNNmNRSFNWRlhW?=
 =?utf-8?B?cmZPT2kwM0p2OERQMC9tdGxFby9uMjlHUVZpaDlTK1N2NEYrMldBY0ppRm5k?=
 =?utf-8?B?N21pYmpHOWxWUWhLN3hKTm9BT0h6Z0lwZlBlSmpsRFIvdVZIWk9NZFhjZDhK?=
 =?utf-8?B?dkxpQlRPeXpxUndRQmM4aTNEeElnTS9sVS91QkU1VFJKZUJvWU9jc0MzNk5P?=
 =?utf-8?B?SG9KMVNLUEZ4dFdGcmVCVFBqcXlPWWpMTHJSSEphem5TYTd5bmcySm1PRitl?=
 =?utf-8?B?WC8wQjRDbzRKZjd6TFZad01NR28xdnc5M1RQeDVQRGpwSzJsTXhiWTlrZjBn?=
 =?utf-8?B?bXdQMzlsOUlPaDhOMDA1SW5PekRLV3IyRHl5V2hSTGJYWTd3bFpraUM4TFRi?=
 =?utf-8?B?TVpBblJMNGlkSVRJa3pvOVNVNGgyVUMvRmNUQjZDdDlqU0hjYkxSVjlyT0ZX?=
 =?utf-8?B?ZURPeEdObE0vblVzT1pHUUFPSFg1a2MzYXVXaGdXMVJ0QlZteGFVS2VRVk5X?=
 =?utf-8?B?b21DVXljdTExV2NaaTNnbENJR0p2dHR0Q2ZFR3hBV0dET2hVVENQMlpydHd2?=
 =?utf-8?B?Z2NXRWpJektZVkpSRlVTTjVhaFhHOXBPSThqdTQ3T0gwcFZZTkpXVFVzWDll?=
 =?utf-8?B?WmdEcThLUFVZQ2pBbXU0MnVyOEt0b1B5cHNyYjU0UHNRbUpDdVVvQ2hrUjU5?=
 =?utf-8?Q?M1J3I7IxcpXEzmGAT0h8rL29PL6cAY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:25:25.4425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8d9539-87a3-4d0c-be09-08dd501fb441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

Add AMD platform specific Zen5 support for address translation.

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

Apply platform specific changes to each port where necessary using
platform detection and the existing architectural framework.

Add a function cxl_port_setup_amd() to implement AMD platform specific
code. Use Kbuild and Kconfig options respectively to enable the code
depending on architecture and platform options. Handle architecture
specifics in arch_cxl_port_platform_setup() and create a new file
core/x86/amd.c for this.

Introduce a function cxl_zen5_init() to handle Zen5 specific
enablement. Zen5 platforms are detected using the PCIe vendor and
device ID of the corresponding CXL root port. There is a check for
ACPI PRMT CXL address translation support.

Apply cxl_zen5_to_hpa() as cxl_port->to_hpa() callback to Zen5 CXL
host bridges to enable platform specific address translation.

Use ACPI PRM DPA-to-SPA translation to determine an endpoint's
interleaving configuration and base address during the early
initialization process. This is used to determine an endpoint's SPA
range and to check the address translation setup.

The configuration can be determined calling the PRM for specific HPAs
given. The resulting SPAs are used to calculate interleaving
parameters of the host bridge and root port. The maximum granularity
(chunk size) is 16k, minimum is 256. Use the following calculation for
the given HPAs:

 ways    = hpa_len(SZ_16K) / SZ_16K
 gran    = (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
          / (ways - 1)
 pos     = (hpa_len(SZ_16K) - ways * SZ_16K) / gran

Before the endpoint is attached to a region the translation is checked
for reasonable values.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/Kconfig           |   4 +
 drivers/cxl/core/Makefile     |   1 +
 drivers/cxl/core/core.h       |   3 +
 drivers/cxl/core/region.c     |  25 +++-
 drivers/cxl/core/x86/amd.c    | 259 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/x86/common.c |   2 +
 6 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cxl/core/x86/amd.c

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
index db1d16d39037..cfe41b8edfd3 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -18,3 +18,4 @@ cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
 
 cxl_core-$(CONFIG_X86)		+= x86/common.o
+cxl_core-$(CONFIG_CXL_AMD)	+= x86/amd.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e2955f91fd98..d5c94e8cea42 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -119,5 +119,8 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 
 int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
 void arch_cxl_port_platform_setup(struct cxl_port *port);
+#if defined(CONFIG_X86)
+void cxl_port_setup_amd(struct cxl_port *port);
+#endif
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dab059ee26ef..b6806e67c62a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -837,10 +837,24 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
 {
 	struct range hpa = *hpa_range;
 	u64 len = range_len(&hpa);
+	int bits;
 
 	if (!port->to_hpa)
 		return 0;
 
+	/*
+	 * Check range and length alignment of 256 MB for the
+	 * interleaved address range. With max. 16-way interleaving
+	 * applied this is at least 16 KB.
+	 */
+
+	if (!len || hpa_range->start & (SZ_16K - 1) || len & (SZ_16K - 1)) {
+		dev_warn(&port->dev,
+			"HPA range not aligned or multiple of 16 kB: %#llx-%#llx(%s)\n",
+			hpa_range->start, hpa_range->end, dev_name(&cxld->dev));
+		return -ENXIO;
+	}
+
 	/* Translate HPA to the next upper domain. */
 	hpa.start = port->to_hpa(cxld, hpa.start);
 	hpa.end = port->to_hpa(cxld, hpa.end);
@@ -853,7 +867,16 @@ static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
 		return -ENXIO;
 	}
 
-	if (range_len(&hpa) != len * cxld->interleave_ways) {
+	/*
+	 *  Apply min and max interleaving addresses to the range.
+	 *  Determine the interleave ways and expand the 16 KB range
+	 *  by the power-of-2 part it.
+	 */
+	bits = range_len(&hpa) > len ? __ffs(range_len(&hpa) / len) : 0;
+	hpa.start &= ~((SZ_16K << bits) - 1);
+	hpa.end |= (SZ_16K << bits) - 1;
+
+	if (range_len(&hpa) % len) {
 		dev_warn(&port->dev,
 			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
 			hpa.start, hpa.end, hpa_range->start,
diff --git a/drivers/cxl/core/x86/amd.c b/drivers/cxl/core/x86/amd.c
new file mode 100644
index 000000000000..483c92c18054
--- /dev/null
+++ b/drivers/cxl/core/x86/amd.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/prmt.h>
+#include <linux/pci.h>
+
+#include <cxlmem.h>
+#include "../core.h"
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
+/* Bits used for interleaving. */
+#define SPA_INTERLEAVING_BITS	GENMASK_ULL(14, 8)
+
+static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)
+{
+	struct cxl_memdev *cxlmd;
+	struct pci_dev *pci_dev;
+	struct cxl_port *port;
+	u64 base, spa, spa2, len, len2, offset, granularity, gran_mask;
+	int ways, pos, ways_bits, gran_bits;
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
+	if (hpa > cxld->hpa_range.end) {
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
+	/*
+	 * If the decoder is already attached we are past the decoder
+	 * initialization, do not determine the address mapping and
+	 * just return here.
+	 */
+	if (cxld->region)
+		return prm_cxl_dpa_spa(pci_dev, hpa);
+
+	/*
+	 * Determine the interleaving config. Maximum granularity
+	 * (chunk size) is 16k, minimum is 256. Calculated with:
+	 *
+	 *	ways	= hpa_len(SZ_16K) / SZ_16K
+	 * 	gran	= (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
+	 *                / (ways - 1)
+	 *	pos	= (hpa_len(SZ_16K) - ways * SZ_16K) / gran
+	 */
+
+	base = prm_cxl_dpa_spa(pci_dev, 0);
+	spa  = prm_cxl_dpa_spa(pci_dev, SZ_16K);
+	spa2 = prm_cxl_dpa_spa(pci_dev, SZ_16K - SZ_256);
+
+	/* Includes checks to avoid div by zero */
+	if (!base || base == ULLONG_MAX || spa == ULLONG_MAX ||
+	    spa2 == ULLONG_MAX || spa < base + SZ_16K || spa2 <= base ||
+	    (spa > base + SZ_16K && spa - spa2 < SZ_256 * 2)) {
+		dev_dbg(&cxld->dev, "Error translating HPA: base: %#llx spa: %#llx spa2: %#llx\n",
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
+		granularity = SZ_256;
+		pos = 0;
+		ways_bits = 0;
+		gran_bits = 8;
+	} else {
+		ways = len / SZ_16K;
+		offset = spa & (SZ_16K - 1);
+		granularity = (len - len2 - SZ_256) / (ways - 1);
+		ways_bits = __ffs(ways);
+		gran_bits = __ffs(granularity);
+		pos = offset >> gran_bits;
+	}
+
+	/*
+	 * Check the mapping: Number of ways is power of 2 or a
+	 * multiple of 3 ways (len == ways * SZ_16K), granularitys is
+	 * power of 2.
+	 */
+	if (len & ~(3ULL << (ways_bits + 14)) ||
+	    granularity != 1 << gran_bits || offset != pos << gran_bits) {
+		dev_dbg(&cxld->dev, "Error determining address mapping: base: %#llx spa: %#llx spa2: %#llx ways: %d pos: %d granularity: %llu\n",
+			base, spa, spa2, ways, pos, granularity);
+		return ULLONG_MAX;
+	}
+
+	spa = prm_cxl_dpa_spa(pci_dev, hpa);
+
+	/*
+	 * Check SPA using a PRM call for the closest DPA calculated
+	 * for the HPA. If the HPA matches a different interleaving
+	 * position other than the decoder's, determine its offset to
+	 * adjust the SPA.
+	 */
+
+	gran_mask = GENMASK_ULL(gran_bits, 0);
+	spa2 = base + (hpa & ~gran_mask) * ways + (hpa & gran_mask);
+	base = base - pos * granularity;
+
+	dev_dbg(&cxld->dev,
+		"address mapping found for %s (hpa -> spa): %#llx -> %#llx (%#llx+%#llx) ways: %d pos: %d granularity: %llu\n",
+		pci_name(pci_dev), hpa, spa, base, spa - base, ways, pos,
+		granularity);
+
+
+	if ((spa ^ spa2) & ~SPA_INTERLEAVING_BITS) {
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
+	u64 spa;
+	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
+	int rc;
+
+	if (!is_zen5(port))
+		return;
+
+	/* Check kernel and firmware support */
+	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
+
+	if (rc == -EOPNOTSUPP) {
+		pr_warn_once("ACPI PRMT: PRM address translation not supported by kernel\n");
+		return;
+	}
+
+	if (rc == -ENODEV) {
+		pr_warn_once("ACPI PRMT: PRM address translation not supported by firmware\n");
+		return;
+	}
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
diff --git a/drivers/cxl/core/x86/common.c b/drivers/cxl/core/x86/common.c
index eeb9bdadb26d..7ccd68b035e6 100644
--- a/drivers/cxl/core/x86/common.c
+++ b/drivers/cxl/core/x86/common.c
@@ -9,4 +9,6 @@
 
 void arch_cxl_port_platform_setup(struct cxl_port *port)
 {
+	if (IS_ENABLED(CONFIG_CXL_AMD))
+		cxl_port_setup_amd(port);
 }
-- 
2.39.5

