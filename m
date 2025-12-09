Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23E2F3630;
	Tue,  9 Dec 2025 18:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304430; cv=fail; b=rE9ay4Aa0tKJlpsUiCGyzvhlWDz6RcOomQrottMRRQW59cBht8secMElXHKvF+0h5immRZrWEhQTtLCF3hM1uI2TJPnYpX80qsCRdazK4wg6RKHQEtrk7AoCochVt8rSG1vL5BKB4DWK+3blCLYTwg7+D2i4jYUw/oe1HIBXKU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304430; c=relaxed/simple;
	bh=46ByyVBhyfjAx0uLX/vi4AQGmAlVjNmJPjHn54cSg/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVTE4JvhLHy/zxUW8moDINrYYRM2lbRF9lnla/J/vVzE7gsFwXdcYpWBklBYdME/8VyjzRb8JuaxRcQkJrVCoP1maqFhbv3vSEzQHXU1EKRekavrywc4BK+2dqmZhjjD92OcsfI9533EY4QAeU/yLmT8VHjBb7ii0uEd/esgDPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ULrzhzmZ; arc=fail smtp.client-ip=52.101.48.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ULrzhzmZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOfEsLwH8rrKAAtiTC1L1xn0Zy8Zl6czE9w1ZhEtKrmgrTv6+JExqZqII+OqHMu3pysHUzg38LBIea5HUBUlXj8vGN+ew5wVUPOmGcbyaKFdNxyqoudQbMbbcB+WWq72BcSVtJp2nCh1DCykDuRFo4gkvnZERDLm7ncCVNV/HBPI/aVdUIPHzAW2ikYHb52DjsJlVyXMLPANcryAF8s3MpI1MziOKFenSWtv95b3NK5imRaUaWczgN+JAFUyDM84QzPc4/O3Ft+y7AH+cP2JP4I0Lx7F02o16WTQQVZ9TxHJfN80WatGIuOblmvjsjLU88bdlAp05F5DHcLgUVAMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH+7cs/dInz98jfDA+du67dxJp86V3mhl25uxTPwd8Q=;
 b=vUxl/f1xRDXKinJsGrI4ACvKqolHthl7lKVVGALmQmazl0xDC6urWPd5K35nS0T92ZvMP3kEc6IGrRMBBYP65jayfsfUB52QulQtGVXvhJAYk+gkk12a4rftmc30a9xq1ubWuLJad2YCn5nXSeZPOYcoXt4tmhG7xw3KIu0wlqLy6vL4WHaJED0xT+7V9C9IQqh0F+2uOwbeBJXIgjRG70T+nUHrGHVOFr/QNWnEIWTbFXOtRr7ce8siXXENnvaeYEkCXY9nnTGdrztGXvqWdRUy1/HOCzUAwmFkVBFskG4orJfQrepJJ5++M/0zgcgZ+DR+8OiiT8aTuvFVF/P9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH+7cs/dInz98jfDA+du67dxJp86V3mhl25uxTPwd8Q=;
 b=ULrzhzmZXGxpO01jimVpcRuFcTp6Zt5BNgx5nx9NEakg6k91vpeuSRIPpDEl67+1dxfOuev7+yWZg1Vl1pjX5nKscW/BpLaCChgrBa+xG5wru8X9JYp69cW+fylhmOzCkM32Cb+utdvlN0i10cJYjeznkTCoGDknI0aGKbm/j8M=
Received: from BY3PR04CA0026.namprd04.prod.outlook.com (2603:10b6:a03:217::31)
 by DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 18:20:21 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::6c) by BY3PR04CA0026.outlook.office365.com
 (2603:10b6:a03:217::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:20:20 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:20:14 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
	Robert Richter <rrichter@amd.com>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 2/2] Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Tue, 9 Dec 2025 19:19:56 +0100
Message-ID: <20251209181959.210533-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209181959.210533-1-rrichter@amd.com>
References: <20251209181959.210533-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2f251f-12a0-49c0-86e4-08de374f9cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGlFemVDOThSM0ZKcFpFcXpXV3c5OHNpbmR3VkwxTjk5b1NmZEZpTnpRdy9i?=
 =?utf-8?B?U2FVVHA0SkVPUEZHUlVjbzBXaHAxOUFvWXB4cnZPcWZmVGt4SUFzWHVJWUlw?=
 =?utf-8?B?N0VMd1l5dmJseWxZbmhScVVoVjZJN0lJY0tHdmZaSmd6cjJhNWMrNDBlRVcz?=
 =?utf-8?B?UE9MM05HRXNyMnBiOFR0Yk4xVGNWRVJaMU5GTUdOZENOVTVrSnJKbDVHL2Fa?=
 =?utf-8?B?ZEJ6dGNISE5HWGhRTjc2RWxMeGE0citQWVFpam9qL21uVnlVZ09KWVpkanZF?=
 =?utf-8?B?RlVEYUs0OTRSbEVOU3kzejloWGZmMVVMTlM4Tk5vZ1d6WHkvakYzeTBacWhp?=
 =?utf-8?B?UzFHYnJnRFRSTkU5dDllMTFsNkl0eU5zNFBmRTllZlZhUkhsSGRObXNXbHpU?=
 =?utf-8?B?TW5jbWp2WUtzcVM3Mmc5WVBjTGJyeXlzemIzZTVsRUhIRkwyaW84eE9DS0dT?=
 =?utf-8?B?UnQxakFQOWJtanJMaDN4MTZ0a2M1QW1HVzlKNG1CR05LNDhJZTFMYm5iWkt3?=
 =?utf-8?B?Mm9rZGE2dnMvLzAzVGRxYld5bEc4Z2ozSWlzZ0hnVHBlMXBkV09NaHRZS0dq?=
 =?utf-8?B?b1k0cVl0OEVYcjlSc2thZ0RaQ3NRRTdnT0FZWTdpeTlQR3huZWpQRHJrNU9t?=
 =?utf-8?B?d2F0ek1vMWU5bUNrc2FLQ0dGbmNwa2RUWVNDaUFncm9RNEJHRXN0ejZCcmts?=
 =?utf-8?B?V05CTzQxcEFjZVV2cGRYSTdrdzJaaGRkczBIUDZ6NTVCeFVSQW05Z1JHaFRq?=
 =?utf-8?B?NG5CeDI2ajlLNzZ4OHphd29heis3WUpVU2Jrb2xtQ0FhMHE5WXpYN2Y5aGto?=
 =?utf-8?B?cklOdWlRQnBwbmdIUEJDa1J0cWlOQVhhQlRoQ2NRYjZMZzZyRDQ2OU4wZHZT?=
 =?utf-8?B?czBXODBUVjVteHBUdWtRdWVhNFVGa2JwVkZVVkU4OVZBdkZMZEFVQ1pFUmlr?=
 =?utf-8?B?MTVETUR5S01iTjNSMzZacm05OEJ6d0FsNXNtd1Ayb1N1TDNWZVNnaUgyLzho?=
 =?utf-8?B?QVhRR3plSjFKQlpPQVNxZXhZSUMxMDl6ZDc3Z3VwZXJ4eFc4OHlVSWxPdDQ4?=
 =?utf-8?B?MVpCQmQ5Zy9YYncwbUY0em9JVkpIVFNRQlBVeDZRenhWNjhWcXJwbkdrbmEr?=
 =?utf-8?B?SW1PYmtDaFBINWVWM3VYeDZTMkJzMytjY0VJQ05YUEUwd010bFduU0E2SFJW?=
 =?utf-8?B?SFVYZ1BDcDAxUjYzU2hTem4wNlROQzc5aUF3T1Nxb0lXOGl6a2RoQlRra3R2?=
 =?utf-8?B?ME5HaEg1b0tKN09aYVlXUHBOT0EvcG85RnA3WGFWNElPNm1rR0FPRlFTSnFJ?=
 =?utf-8?B?b011azIyQXdLUVFqT0U3MHFCZ2hEQkNhUk5lODV1dU1GcVViL2UwYXdLWkRh?=
 =?utf-8?B?TFhNWDRKQW53UkxzdHV4TThFTzlPNHZpcTB4eW5QYlVHSzBOYUJLTUs4MEo1?=
 =?utf-8?B?YXM4MUJJSENFTGxkcGc2RU15MlhBNVJtWVd0djFqc0RhR1VSU1V0T2JhUHcr?=
 =?utf-8?B?YS96M3hsZ1Y0dDNVUXovQUt3RnhmN1k5b3FHcXNIWEJOS0ZGSlcyaGczNkhk?=
 =?utf-8?B?aENBN3p4cUlJdE5vMS9FNFpZMWVsOHFxWFNDOWRVZFFhUTV0OUYrTHBUczRw?=
 =?utf-8?B?RDlnTmRGL0llUm51N21McmdIaVBIbVQ5NWc5OGN5bFliSVQyckNTRTNYMDkx?=
 =?utf-8?B?VjJPb3paSC84N2wyVTJ0bis4T3UyamNwT1hGSFFMWTBCNTk2ekNSQUZUZ0I5?=
 =?utf-8?B?aDQvc0QwTTJjWTZJZE1Yd1MzWGR0SkxTWGNIK2M4bTdCTHhRSEllQzZzSkUz?=
 =?utf-8?B?a1Z5bkZwYWNOR0poTzhlNTlhVk8wZnFob2tHMFJyWXprODM3TjdwSFQ5WGl1?=
 =?utf-8?B?bFNoR3MyOWcvSW9aUGl0N1J1TWpSRTVoVVVIb09odCtjcGFlSVcxY2lwdTRm?=
 =?utf-8?B?NUxPMEJOa3ZjSkt5Q3h5bmtEMS9hZnppeC9XRUtzOXNQMWV4YWpuYmJ1Nlkr?=
 =?utf-8?B?d28vUjFtRmVSRUxHRklEMFQ4c1hsZWdLeituYTlTRVgraHltSUs3NmVFSXZU?=
 =?utf-8?Q?1gDtkJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:20:20.5634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2f251f-12a0-49c0-86e4-08de374f9cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230

This adds a convention document for the following patch series:

 cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement

Version 7 and later:

 https://patchwork.kernel.org/project/cxl/cover/20251114213931.30754-1-rrichter@amd.com/

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v2:
 * updated sob-chain,
 * spell fix in patch description (Randy),
 * made small changes as suggested by Randy,
 * Removed include:: <isonum.txt> line (Jon).
---
---
 Documentation/driver-api/cxl/conventions.rst  |   1 +
 .../driver-api/cxl/conventions/cxl-atl.rst    | 174 ++++++++++++++++++
 2 files changed, 175 insertions(+)
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
index 000000000000..955263dcbb3a
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
@@ -0,0 +1,174 @@
+.. SPDX-License-Identifier: GPL-2.0
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
+Host Bridge. The HPA ranges of a CFMWS may include addresses that are
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
+physical memory. Devices have their own memory space and can be
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
+This is especially important to find an endpoint's associated CXL Host
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
+  configuration using platform-specific address translation methods.
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

