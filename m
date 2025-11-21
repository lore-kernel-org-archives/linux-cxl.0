Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267F2989B5;
	Fri, 21 Nov 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763727447; cv=fail; b=uzK3L/HUwQdt4tFwK8lnBTb/DuGp4E8liPP9JroOcZf3j0L/LiQKGn9A7wgh1Se0qUCTLF5mhj78k41wtmxrcufz3sRa+HfBQUXSzbKs5Yr3MCwkXwmocVbA/mDWaXZ8P9G7Ja/UlNwP2Q1jBuEcPuQ+vlJPdtU7+5ek4Ih7Q8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763727447; c=relaxed/simple;
	bh=diRLHIMg5nqxw2Ex+F3YACDiMbilHxzTCHq/m1fNEj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLqWgx3K1rgMUtRusKVPHlbg60pDvOSOeSAynPxUJcez2i/yWeH2kzKThPDahQLB6toPNexvXJZmu1ofPRYu5SI8KrouVPm2zO+8hQIFSW7OQuuRdhqqdHwcY4aeKCcE6MJKWi3xOsAyhb5LrIOwiKLuMg8xQt6fSTQwnO6scdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pSU6xCWA; arc=fail smtp.client-ip=52.101.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pSU6xCWA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fA50EdhaqJnhIpN7uyWavW6lS0vQUudO0sDNY6hPBbWLFGbaza+b9L2Sp07wUfor7otdeX2GlnQ7wKa14KXnlh66LdSPwtcVa9qKpwwxyYSbkKL9Jf4w69yFfPw5WtMwquiHkPRlIzYILD5BoHXvIUkdFtttiWTmXsPIvN+zBG2T48kyJVjyx4WsWh94OQvZKzbwrYwO+4RZ6m3W1Be/WxomnuSowapSm8gFaJedgNB8ns6R8p9LBtCcgLLXxyr1poaIwIraz2pRMD5YLp6mJeFvskIb7Z2lrgtNu66YlJE2l1VAbo9CD2fx/E265rnBzIa9fvDrE8zTmwK6BPq0EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd34vCUBOirASchP9G/JWEw4nKEapGeBMjpsSkx1LMo=;
 b=x1T5mxyTT7AsTgYQoWc1m+/TW/YVVV/urCNMHOUAn8zc1OFYPPJAUJWYt2sLm8hTC6xg8wOd+vp0O/nEhoytIvSznJKPXUDk9fe64+kcd9PJjzWbmV3j+52Cfd9E2/B7A0NZkAusZvoJuPDe5vkx1QCc5QFVC4Z3pHHIkB3Ydke1RGNjiGPILVc09nqn8OyL7AP8BPzLCc5CyU4txIUudwgASdi9zNBL5G1cQURBRkgqqvZQ8UMftu+PwbUgtRT73Xqx6OCS1n1rzTTWU8+Xcyw4rd60JSi+jLTD+BR+UH6nsYfpwais+g6ksFaDpRiogiyxcYW8qnYJTiKZ74leXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd34vCUBOirASchP9G/JWEw4nKEapGeBMjpsSkx1LMo=;
 b=pSU6xCWArVivz6oGBvasScMxw6SwxOKsGuUNc21MWd/LHGj23wF2RqzLlZ9Rh1NX8DsfKXHfB4DgOA9nFB4hILBZT2eKl9CAqkBcs8KM0PI+YGpNZ4z9mcWbWpqCxrFdyoeWt4SLCPI+piBjibpAPzwjBzBLOGA9iIsgnFSr3+Y=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.14; Fri, 21 Nov 2025 12:17:18 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::26) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.12 via Frontend Transport; Fri,
 21 Nov 2025 12:17:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Fri, 21 Nov 2025 12:17:17 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 04:17:13 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH v1 2/2] Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Fri, 21 Nov 2025 13:16:51 +0100
Message-ID: <20251121121655.338491-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251121121655.338491-1-rrichter@amd.com>
References: <20251121121655.338491-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 18987167-940e-424b-a733-08de28f7e9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3NGRDJLS3BwcUxHd0tmYlc0Sk5tUHdzVHU0ZGZ5MjlmN3R2TWZMMElxR1pZ?=
 =?utf-8?B?YUNvWVJpUDdzdGc0ZHArTHIvQithbWJPMkhCNUU2aDFHcEViNk5sb1hWZk5j?=
 =?utf-8?B?NEM4azVhb29hRGVDYnhVTkRZVGhFMzNuUUh0QXlRaWtzMlFML2RVSVhNcTRU?=
 =?utf-8?B?bmpsZ2hvSHNFaFRQdllOSzh2SnFsT2xPZjNWK09VNm5BZFJIRnJaai9OVnBl?=
 =?utf-8?B?cGRxak5IUW43ZjJCcjJ6d0R0ZlhreHBWWmxTb3JKb1dETUtZKyttQ2M5TXVo?=
 =?utf-8?B?RzUySFZqd3p5dE5tSG9ad2tURDVqVVNGTGM3dFBmYkJWVll5UnZBVGpkUmdW?=
 =?utf-8?B?akkvVjVLendKWUFQSGVZbHF0OXFhRnhlVGVmNVljMzdjNU5HeWY1TTFCbjVa?=
 =?utf-8?B?SFowVFhJL2hvZ3ZwRU5RdUczL0Q3cE1HVTFENHRlN2RJa1RRT0RuWlFyUDZP?=
 =?utf-8?B?SmdNOGJERy85SHJzMHQxMm8zS2dwcW1xc1B4cFlCdE8zWlZ2M3dyYXUyTHdi?=
 =?utf-8?B?TW9rcmYveGh2dHV6U1FreTZHQ3VCZUZEdmdqdlV0eXhkWmRpalQvVDA5U2Ro?=
 =?utf-8?B?WFI4d0kxQWFveWI2aUxacTJydTZtdHRoT0ZXZUNTcEZiM3pWK2tQUEl3TDhu?=
 =?utf-8?B?Mk5jYXF1Wm02UkEyNjF0ZHo3UStlcXE4anAxekZMKzNyVWNwMXowbTB1MWtr?=
 =?utf-8?B?MGFaaWd0MzB5b2Nzd3BJY0ttTHBWU3JzVWdLdmxiTGtCTEtjQlpKZmU1Wm05?=
 =?utf-8?B?UWtEOHdOSThYQld2UEs0UmQwaXkySW1FZ3dPV1hqeHNIYk50Q0dVSlhyaFlP?=
 =?utf-8?B?VmFWc0YzMDZnajdOYjZuMTQza3R6ZkxZNWJpa2xLTzJFZTRtMnVzZnJrR1F6?=
 =?utf-8?B?QzA2bWQ1bUU1SCtUdDE4TWVQbENXTGQ3cityUm5qZjhsbkdTUmF3VFg4cklE?=
 =?utf-8?B?c3JYRWpIN0pvazloaVk3RkduMmFTZjFybVVNMzhrSnlRUGZVaDg4aGxpTTI3?=
 =?utf-8?B?QmNCdDJzdkhNZU5kaEVEVnBMbVMzenBmRVY0RGZTL2ZVOVVIODBQNXVUTkRD?=
 =?utf-8?B?TmlQOTRHOG5pbkVsVllid1FCNnphQkNUdThOSDQxZGRFVTBMTTB3V25hUXUw?=
 =?utf-8?B?N05oMG5DcVFHRnBNekhaNXRTblBmMXlqZlZ5M28wK2ZiTDlNRWxGOFd2eUhM?=
 =?utf-8?B?V2ptMlhrY2ZhaHZ1N1dMMFUwOC95Tm9UYVN6NGRBSVFNdHMvbTYwY0NQTlNm?=
 =?utf-8?B?QklKOXZhM3NxZ0hVZC9mNDNtU3llblZkVTRtcnFwYmcxbXlFNUw4d2Z4MWlT?=
 =?utf-8?B?MlNwUFJITzJ4clBDMzVlMWdvSlZURndPbm1JWWdha0ladCsrSWV2aFJVTHBz?=
 =?utf-8?B?YWRjN3VaNkhNZmZnaTZNNzZaWC9EM0dEZjNpV1ZlZmIzQ0VJL0E4YUZTbXdW?=
 =?utf-8?B?RlRHaExob2NPV0xPMWNOQ1h4a1Z2bVFFUEVXMzhLam95dm9PQ0F4YTdYWFZG?=
 =?utf-8?B?YWdkQmllc2NFVTdlQ3VXVXZ3d1VYbjh3MStEb3B2UEd1TVlteURaQ0FaYWRj?=
 =?utf-8?B?K1Y2b3BEa1dkcUJIWFN5NzI4ZThFWmtrR0hLUmZFYk9GZ2NreDZkTWFwQXVS?=
 =?utf-8?B?MlhwNTRycEdDUHNhV3RVMktsWjRYU1RTQjREQ0RjU0dKeDloVS8rNnZUQ0c0?=
 =?utf-8?B?YW50UEFLNGtWSDRyOFhlZnhvQzBoT0YySkRaV0FUVklBelRKRXg5YmdKK0JB?=
 =?utf-8?B?OVh3NnM2bHRIS2VsaHFrZ0M4amNwWm81TGFzU0ZZMnE3S0ZweWxINXNYeFBs?=
 =?utf-8?B?QzJXRlduUUI5VnQ2aWI2NEVPaEIzajNkREErTisvUktJUG1PeHhxc2lCUCtX?=
 =?utf-8?B?cDQrczg3eS9NZEFONWFDRWpzR1JCc2lweHNjNVJYOHN5cHluZFZkOFVIbjln?=
 =?utf-8?B?S0ZIczcrL2RSRnBDVU5qYkk4K3FHWUxPcFUyY2RmNXQ4eWF4b3hnTnpxTVQ3?=
 =?utf-8?B?QWl3cFU3L3g1NjJMWlhLdzFJcHN2UkxkVHJzZ0ZNbS9VUnh6MGxHaW5FZ3kw?=
 =?utf-8?Q?L6x1tz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:17:17.9597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18987167-940e-424b-a733-08de28f7e9ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

This adds a convetion document for the following patch series:

 [v7,00/11] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
 https://patchwork.kernel.org/project/cxl/cover/20251114213931.30754-1-rrichter@amd.com/

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 Documentation/driver-api/cxl/conventions.rst  |   1 +
 .../driver-api/cxl/conventions/cxl-atl.rst    | 175 ++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index 53f31a229c8d..cf427afac58b 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -8,4 +8,5 @@ Compute Express Link: Linux Conventions
    :caption: Contents
 
    conventions/cxl-lmh.rst
+   conventions/cxl-atl.rst
    conventions/template.rst
diff --git a/Documentation/driver-api/cxl/conventions/cxl-atl.rst b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
new file mode 100644
index 000000000000..9c14856e1782
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
@@ -0,0 +1,175 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+ACPI PRM CXL Address Translation
+================================
+
+Document
+--------
+
+CXL Revision 3.2, Version 1.0
+
+License
+-------
+
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+- Robert Richter, AMD
+
+Summary of the Change
+---------------------
+
+The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
+Host Physical Address (HPA) windows that are associated with each CXL
+Host Bridge. The HPA ranges of an CFMWS may include addresses that are
+currently assigned to CXL.mem devices, or an OS may assign ranges from
+an address window to a device.
+
+Host-managed Device Memory is Device-attached memory that is mapped to
+system coherent address space and accessible to the Host using
+standard write-back semantics. The managed address range is configured
+in the CXL HDM Decoder registers of the device. An HDM Decoder in a
+device is responsible for converting HPA into DPA by stripping off
+specific address bits.
+
+CXL devices and CXL bridges use the same HPA space. It is common
+across all components that belong to the same host domain. The view of
+the address region must be consistent on the CXL.mem path between the
+Host and the Device.
+
+This is described in the current CXL specification (Table 1-1, 3.3.1,
+8.2.4.20, 9.13.1, 9.18.1.3). [#cxl-spec-3.2]_
+
+Depending on the interconnect architecture of the platform, components
+attached to a host may not share the same host physical address space.
+Those platforms need address translation to convert an HPA between the
+host and the attached component, such as a CXL device. The translation
+mechanism is host-specific and implementation dependent.
+
+E.g., x86 AMD platforms use a Data Fabric that manages access to
+physical memory. Devices have an own memory space and can be
+configured to use 'Normalized addresses' different to System Physical
+Addresses (SPA). Address translation is needed then. Details are
+described also under x86 AMD
+Documentation/admin-guide/RAS/address-translation.rst.
+
+Those AMD platforms provide PRM handlers in firmware to perform
+various types of address translation, including for CXL endpoints.
+AMD Zen5 systems implement the ACPI PRM CXL Address Translation
+firmware call. The ACPI PRM handler has a specific GUID to uniquely
+identify platforms with support of Normalized addressing. This is
+documented in the ACPI v6.5 Porting Guide, Address Translation - CXL
+DPA to System Physical Address.  [#amd-ppr-58088]_
+
+When in Normalized address mode, HDM decoder address ranges must be
+configured and handled differently. Hardware addresses used in the HDM
+decoder configurations of an endpoint are not SPA and need to be
+translated from the endpoint's to its CXL host bridge's address range.
+This is esp. important to find an endpoint's associated CXL Host
+Bridge and HPA window described in the CFMWS. Also, the interleave
+decoding is done by the Data Fabric and the endpoint does not perform
+decoding when converting HPA to DPA. Instead, interleaving is switched
+off for the endpoint (1 way). Finally, address translation might also
+be needed to inspect the Endpoint's hardware addresses, such as during
+profiling, tracing or error handling.
+
+For example, with Normalized addressing the HDM decoders could look as
+following:
+
+.. code-block:: none
+
+ /sys/bus/cxl/devices/endpoint5/decoder5.0/interleave_granularity:256
+ /sys/bus/cxl/devices/endpoint5/decoder5.0/interleave_ways:1
+ /sys/bus/cxl/devices/endpoint5/decoder5.0/size:0x2000000000
+ /sys/bus/cxl/devices/endpoint5/decoder5.0/start:0x0
+ /sys/bus/cxl/devices/endpoint8/decoder8.0/interleave_granularity:256
+ /sys/bus/cxl/devices/endpoint8/decoder8.0/interleave_ways:1
+ /sys/bus/cxl/devices/endpoint8/decoder8.0/size:0x2000000000
+ /sys/bus/cxl/devices/endpoint8/decoder8.0/start:0x0
+ /sys/bus/cxl/devices/endpoint11/decoder11.0/interleave_granularity:256
+ /sys/bus/cxl/devices/endpoint11/decoder11.0/interleave_ways:1
+ /sys/bus/cxl/devices/endpoint11/decoder11.0/size:0x2000000000
+ /sys/bus/cxl/devices/endpoint11/decoder11.0/start:0x0
+ /sys/bus/cxl/devices/endpoint13/decoder13.0/interleave_granularity:256
+ /sys/bus/cxl/devices/endpoint13/decoder13.0/interleave_ways:1
+ /sys/bus/cxl/devices/endpoint13/decoder13.0/size:0x2000000000
+ /sys/bus/cxl/devices/endpoint13/decoder13.0/start:0x0
+
+Note the endpoint interleaving configurations with a direct mapping
+(1-way).
+
+With PRM calls, the kernel can determine the following mappings:
+
+.. code-block:: none
+
+ cxl decoder5.0: address mapping found for 0000:e2:00.0 (hpa -> spa):
+   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
+ cxl decoder8.0: address mapping found for 0000:e3:00.0 (hpa -> spa):
+   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
+ cxl decoder11.0: address mapping found for 0000:e4:00.0 (hpa -> spa):
+   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
+ cxl decoder13.0: address mapping found for 0000:e1:00.0 (hpa -> spa):
+   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
+
+The corresponding CXL host bridge (HDM) decoders and root decoder
+(CFMWS) show and match with the calculated endpoint mappings:
+
+.. code-block:: none
+
+ /sys/bus/cxl/devices/port1/decoder1.0/interleave_granularity:256
+ /sys/bus/cxl/devices/port1/decoder1.0/interleave_ways:4
+ /sys/bus/cxl/devices/port1/decoder1.0/size:0x8000000000
+ /sys/bus/cxl/devices/port1/decoder1.0/start:0x850000000
+ /sys/bus/cxl/devices/port1/decoder1.0/target_list:0,1,2,3
+ /sys/bus/cxl/devices/port1/decoder1.0/target_type:expander
+ /sys/bus/cxl/devices/root0/decoder0.0/interleave_granularity:256
+ /sys/bus/cxl/devices/root0/decoder0.0/interleave_ways:1
+ /sys/bus/cxl/devices/root0/decoder0.0/size:0x8000000000
+ /sys/bus/cxl/devices/root0/decoder0.0/start:0x850000000
+ /sys/bus/cxl/devices/root0/decoder0.0/target_list:7
+
+The following changes of the specification are needed:
+
+* Allow a CXL device to be in a different HPA space other than the
+  host's space.
+
+* The platform can use implementation-specific address translation
+  when crossing memory domains on the CXL.mem path between the Host
+  and the Device.
+
+* The kernel (OSPM) determines Endpoint SPA range and interleaving
+  configuration using platform specific address translation methods.
+
+Benefits of the Change
+----------------------
+
+Without the change, the OSPM may not determine the memory region and
+Root Decoder of an Endpoint and its corresponding HDM decoder. Region
+creation would fail. Platforms with a different interconnect
+architecture would fail to setup and use CXL.
+
+References
+----------
+
+.. [#cxl-spec-3.2] Compute Express Link Specification, Revision 3.2, Version 1.0,
+   https://www.computeexpresslink.org/
+
+.. [#amd-ppr-58088] AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh,
+   ACPI v6.5 Porting Guide, Publication # 58088,
+   https://www.amd.com/en/search/documentation/hub.html
+
+Detailed Description of the Change
+----------------------------------
+
+Add the following paragraph in 8.2.4.20 CXL HDM Decoder Capability
+Structure of the specification [#cxl-spec-3.2]_ to the end:
+
+"A device may use a different HPA space that is not common to other
+components of the host domain. The platform is responsible for address
+translation when crossing HPA spaces. The OSPM must determine the
+interleaving configuration and perform address translation to HPA
+ranges of the HDM decoders as needed. The translation mechanism is
+host-specific and implementation dependent."
-- 
2.47.3

