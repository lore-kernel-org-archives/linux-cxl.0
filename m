Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D40283FCD;
	Mon, 12 Jan 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216668; cv=fail; b=Fe/gmOnAloIYHJfsWfcFazenXn++Rf4+kHJwB4X62fQII4k0FI/ft/E8wzrqy1+bejtvVuem4gsZ/LTew0zAw0VWEW5TDAlgQl95ANKHI5EDZkGtCLVmvwyWzPPrrm6dIXPVcEPLYVfMKxrxsexrqwR9hzzMDV7OVgLe+Vi8GQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216668; c=relaxed/simple;
	bh=OS69rG/LeaZxAEtVKsvoDl1wzxoe4F47ID1tIXCpiKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5gqn1f/33tt1DRuwXq+BG7NgEiCh+1YdaIOzewWpptupCjuGOAPNDjDh4nJE2KEuSVfyMSCsLc92aDWUhbg1rzOpxu/yjC32Do0UNqU/pEYHP/NLuwGqI6rpyUZPN/Dse74mzoxV9TBQ415dlb8BVDXvpeyi6zIexQKjZqTDo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yau9FcTd; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yau9FcTd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCXTO4AYLXHDYvFT/FZf0ETvRp7zroQ5NH72RiE9LA4GCTvgDwft9fnkS7uaDdbnMzMRxkfcg/aE+WPUTMG5YHVPk8M2QGRaPXbiLMa524WPOPgSjqnCznWEsX67boxFteLKbiDY43XmmYkVQYlY3VXEYsV8cfl2uSY4uZbo9RpAYVCf/S8t2bARu6Blkb6zR22QRbpwFE9IutfvvcOd6pHfRoiicvI2+zizKISjzuStU526cBR68elKKt3TR3/6M230EfZEAecpj5zT5Q62qolhno4oJYvq+FRbKhdgrw+C2lhvRVd6zko1wEakrumW00eDGsXzjpBhXQYTdBOX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HND7v4IkfHl58k0qxfmGK3BKhXZGrZG5s5VlALGQB4s=;
 b=iypxqQICw0YvQ+kMNV3j3647GeRk1QMxNtOu5MZtl49paLHPqYq9wOW25L/NE5eBR7fIA9tpeqdoPBQfJ4ARG7jFEzLjlZ7bfoJcE+jVB+0tbxWOsBA4+Cs9ONpf7JO1/a5J+L/SXasFC/IyBfIBSvChkJQ3WrLFalOblnnuom7ylFkiiKZVlzKI9DyU4oJJ1b5dVzPPKiAILAZMHvPu8AbctkDY6LLK167wuhrzQD+v/QEzlwC1l0dprElZuRRQiHayAfAaER708R80qGGU6/l2c9XBvlBeqLRSyCimWuTNJjK8HMmI/oW0scPVoEk8+n93yjtFDW9YrLk2v2bGcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HND7v4IkfHl58k0qxfmGK3BKhXZGrZG5s5VlALGQB4s=;
 b=yau9FcTdXETvLKwRUK8a1yYzX3sD2cw9coxqd2tGW6zJPtiw1VYPacOek1auDYkL7dbl3GcLfT34CiP6R4EG8+6hojSHOTuYutaSwGgQZOlwAYM8NajWmHdudaJfi/xGBJ45tdsJhPvPEHRpL05MIDkoZEGwbBV2jkdYyXDh/dg=
Received: from BYAPR06CA0064.namprd06.prod.outlook.com (2603:10b6:a03:14b::41)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:17:41 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::a3) by BYAPR06CA0064.outlook.office365.com
 (2603:10b6:a03:14b::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 11:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 11:17:41 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 05:17:36 -0600
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
Subject: [PATCH v3 3/3] Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Mon, 12 Jan 2026 12:16:45 +0100
Message-ID: <20260112111707.794526-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112111707.794526-1-rrichter@amd.com>
References: <20260112111707.794526-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|IA0PR12MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 669697bb-3f6c-415c-1f32-08de51cc3398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWtFdUNvWXN2ZnZocUtJQm45V20vbXBMRGc2WitWa3NnK2JXWWVuVWt1b1R6?=
 =?utf-8?B?UmN1MnBDZnhtQi9jaTZRdGIrREFBUUMwdFB6bjRTN0hNTXZDR2xSRzNJei9F?=
 =?utf-8?B?THNOaGhvU0ZGNytpMDdkQUozQ1ZEanVVVzdoeFFkM1pvRFpXRVBxdTVZbW44?=
 =?utf-8?B?UDZvY0ZkUmpkVDRNOUFwQ3pzVnhlM3BRZW5hOWRjYVVQSDMyWG5DQjA5VVdn?=
 =?utf-8?B?NEZWMWZ4U3FGcyt1NStqUFdRaXNJWkFidmVVVEJxQVdwNVlrLzhvM05MdXdu?=
 =?utf-8?B?YVZuTXl0OWluRnM0WjdyZDJzK2xxTTF1VnF3amN2MTZYY0NiZ1E1bS93SUFU?=
 =?utf-8?B?dDU2OS9hTlhDWW84clZMM3NYZ2YyMjZTRG9tUE5nWVh1UHh4anFINUU4eDAw?=
 =?utf-8?B?b3h2aXhYS0JXcHJEV3lkd0Ziajh5SDFxSmJsRU1RU2ZCMUNPMnludEp3WXcy?=
 =?utf-8?B?cXNvd0hJVFBtb09MSDRMSWZPNlRmeU8zM0lLVDkvSG10TmMzTkk0QTVHTkto?=
 =?utf-8?B?UnFpVzBTSjl4THkzUUlZZ1JhZFY1RVE1Vm1ucVJ2cmRFVXpNQkJTU1Q2cE1w?=
 =?utf-8?B?TFdTZ24wcjJ5SDcyY3YzS0h6RDNLWmhWS0ZqYUU2UHRqUVVGQVl2R09kYnhu?=
 =?utf-8?B?d2xLRWcxRWljSUJ2UVFGKzJaZXczdm53aHJpOW5JS0JXeG1zS3ZmMWJlYlcv?=
 =?utf-8?B?aU9CM3lQeHM5c2NzdjVPVERuZVdoZUZnZWl3MGRVVnlBRW5WNzdOT25SQUtJ?=
 =?utf-8?B?NE1EOUY0alZIZmlWZjdDeEJHd0ZtSnNVNW9IVlNub2RNT0ZZRDZTNHdrVCtN?=
 =?utf-8?B?aEhyemNKd3NoUW5EWEc2czdqeEZJMUtlYzU4L3cxdlJyS0VVTW8yMFh1L3ox?=
 =?utf-8?B?MVcwNWxkbGVPSWlOMFd4bVdYVVZPZWFzQ2ZOZXREYmdjTkRYckZ3dW4ybUJa?=
 =?utf-8?B?ZFZpSDR2Rzc1eUFXbkpaVnNXK2NtZ2IrM0pQWUp4d1AzMW5FbCtTYUU3VDFk?=
 =?utf-8?B?WHdZSHN1Qjd4b1diZDB0UjNlWWdjYm1DbklkeGNqeWVVNEZuWCtWNjdMc1h6?=
 =?utf-8?B?ZmxKM1UvYWFlSUZyb1FPTXFxcnJTZkc5UFVhSENYa1prbWl2YzB4dkJhV2lm?=
 =?utf-8?B?SitZRjVRb3RIVnk3dkZOMmN0aDI1Vy90RStmYkltYk9PM0JrWDNxOUo1cU9P?=
 =?utf-8?B?TmptMHVnSkR6ekE5cWUvTTBzekRibWRlZVhsaGlPZjF4ZWFKalA1MHVkNUR3?=
 =?utf-8?B?OWFDaERka2RwdTVEaFozeGhKbk05TFA5SHVkSjRXOFh1VkxuNVVkcW1FZ3p3?=
 =?utf-8?B?MGM3d05YL0tqZzhzcW9YekI4VXF0NTVnVjNZZjBPblpiTjlkcEhBK3ZlT3lU?=
 =?utf-8?B?OGp1bCtJcndjTnZWU1Jkc3BaSUw0TXB1ZElhSEIzNXRkanFUWmE4bnFOU01a?=
 =?utf-8?B?YjYzRHI5aHF3ekhrQ3B1UnVUNjQ0bWIrQzJiK0VEV0dNOUNNMCtZcWlBQ2VJ?=
 =?utf-8?B?dFcvS3B0N0lmdmxWbG5iaDVNWGxhUGEyOHhjLzFIWUhLcWthNXFJV0FQR09C?=
 =?utf-8?B?RDAyK3VBbGhjOUVqT2ZtUXlKNkFHNHkwbnBUcWh4T1orMXA5VnJHcHZuSC9U?=
 =?utf-8?B?SXdWMHRpZ1ZjL2FOc2RhNDFpZTZQSEZ1eDZJeFdjVkc3N3owNmhvaENBYWkx?=
 =?utf-8?B?UG90Z0VrMHhlMHdCd05WWHdJVC9kbG9iZC95ZVcwQVBVb1VtOHRCbE1sY0pl?=
 =?utf-8?B?ODRhKzFLRVVJSGhwSllGWElCQ05Mc1Y2ZzIzeTM0YTFrblo4L1BNY3dQZEVG?=
 =?utf-8?B?U2drTnpTOWlnbXhZL0s3UDJCaG1zMHErNWlBUk9ZVU1OelhEM0paWjdLekxs?=
 =?utf-8?B?N0U5UmR3WWQ5NjJ6SHJqc1E4bDIwY0xscGdLTDBxbEN6Y1ZoaXN3cTdMOCtq?=
 =?utf-8?B?SnFJTnFZbU0weFZuOWVKMTh3dHBTU1B3SmtneUE1c0xxQUhPME9BVWVLZGV0?=
 =?utf-8?B?bVBnZG0vR3JVbXFncTViN3Fic0ZHdUt6QTc1VE12R1N5TzdtWDgrR1E0YnpT?=
 =?utf-8?Q?G4vRV8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:17:41.2636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 669697bb-3f6c-415c-1f32-08de51cc3398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254

This adds a convention document for the following patch series:

 cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement

Version 7 and later:

 https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/

Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v3:
 * updated link in descriptions and add Link: tag (Jonathan Cameron),
 * clarified CFMWS and HPA range description (Jonathan Cameron),
 * use 80 chars line limit (Jonathan Cameron),
 * added block diagram to illustrate the example address mappings (Dave),
v2:
 * updated sob-chain,
 * spell fix in patch description (Randy),
 * made small changes as suggested by Randy,
 * Removed include:: <isonum.txt> line (Jon).
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 Documentation/driver-api/cxl/conventions.rst  |   1 +
 .../driver-api/cxl/conventions/cxl-atl.rst    | 205 ++++++++++++++++++
 2 files changed, 206 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index 9267a697b2fe..0d2e07279ad9 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -14,4 +14,5 @@ same convention.
    :caption: Contents
 
    conventions/cxl-lmh.rst
+   conventions/cxl-atl.rst
    conventions/template.rst
diff --git a/Documentation/driver-api/cxl/conventions/cxl-atl.rst b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
new file mode 100644
index 000000000000..69fed0044b52
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
@@ -0,0 +1,205 @@
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
+The CXL Fixed Memory Window Structures (CFMWS) describe zero or more Host
+Physical Address (HPA) windows associated with one or more CXL Host Bridges.
+Each HPA range of a CXL Host Bridge is represented by a CFMWS entry. An HPA
+range may include addresses currently assigned to CXL.mem devices, or an OS may
+assign ranges from an address window to a device.
+
+Host-managed Device Memory is Device-attached memory that is mapped to system
+coherent address space and accessible to the Host using standard write-back
+semantics. The managed address range is configured in the CXL HDM Decoder
+registers of the device. An HDM Decoder in a device is responsible for
+converting HPA into DPA by stripping off specific address bits.
+
+CXL devices and CXL bridges use the same HPA space. It is common across all
+components that belong to the same host domain. The view of the address region
+must be consistent on the CXL.mem path between the Host and the Device.
+
+This is described in the current CXL specification (Table 1-1, 3.3.1, 8.2.4.20,
+9.13.1, 9.18.1.3). [#cxl-spec-3.2]_
+
+Depending on the interconnect architecture of the platform, components attached
+to a host may not share the same host physical address space. Those platforms
+need address translation to convert an HPA between the host and the attached
+component, such as a CXL device. The translation mechanism is host-specific and
+implementation dependent.
+
+E.g., x86 AMD platforms use a Data Fabric that manages access to physical
+memory. Devices have their own memory space and can be configured to use
+'Normalized addresses' different to System Physical Addresses (SPA). Address
+translation is needed then. Details are described also under x86 AMD
+Documentation/admin-guide/RAS/address-translation.rst.
+
+Those AMD platforms provide PRM handlers in firmware to perform various types of
+address translation, including for CXL endpoints. AMD Zen5 systems implement the
+ACPI PRM CXL Address Translation firmware call. The ACPI PRM handler has a
+specific GUID to uniquely identify platforms with support of Normalized
+addressing. This is documented in the ACPI v6.5 Porting Guide, Address
+Translation - CXL DPA to System Physical Address. [#amd-ppr-58088]_
+
+When in Normalized address mode, HDM decoder address ranges must be configured
+and handled differently. Hardware addresses used in the HDM decoder
+configurations of an endpoint are not SPA and need to be translated from the
+endpoint's to its CXL host bridge's address range. This is especially important
+to find an endpoint's associated CXL Host Bridge and HPA window described in the
+CFMWS. Also, the interleave decoding is done by the Data Fabric and the endpoint
+does not perform decoding when converting HPA to DPA. Instead, interleaving is
+switched off for the endpoint (1 way). Finally, address translation might also
+be needed to inspect the Endpoint's hardware addresses, such as during
+profiling, tracing or error handling.
+
+For example, with Normalized addressing the HDM decoders could look as
+following::
+
+                          -------------------------------
+                          | Root Decoder (CFMWS)        |
+                          | SPA Range: 0x850000000      |
+                          | Size: 0x8000000000 (512 GB) |
+                          | Interleave Ways: 1          |
+                          -------------------------------
+                                        |
+                                        v
+                          -------------------------------
+                          | Host Bridge Decoder (HDM)   |
+                          | SPA Range: 0x850000000      |
+                          | Size: 0x8000000000 (512 GB) |
+                          | Interleave Ways: 4          |
+                          | Targets: endpoint5,8,11,13  |
+                          | Granularity: 256            |
+                          -------------------------------
+                                        |
+           -----------------------------+------------------------------
+           |                  |                   |                   |
+           v                  v                   v                   v
+ ------------------- ------------------- ------------------- -------------------
+ | endpoint5       | | endpoint8       | | endpoint11      | | endpoint13      |
+ | decoder5.0      | | decoder8.0      | | decoder11.0     | | decoder13.0     |
+ | PCIe:           | | PCIe:           | | PCIe:           | | PCIe:           |
+ |   0000:e2:00.0  | |   0000:e3:00.0  | |   0000:e4:00.0  | |   0000:e1:00.0  |
+ | DPA:            | | DPA:            | | DPA:            | | DPA:            |
+ |   Start: 0x0    | |   Start: 0x0    | |   Start: 0x0    | |   Start: 0x0    |
+ |   Size:         | |   Size:         | |   Size:         | |   Size:         |
+ |    0x2000000000 | |    0x2000000000 | |    0x2000000000 | |    0x2000000000 |
+ |    (128 GB)     | |    (128 GB)     | |    (128 GB)     | |    (128 GB)     |
+ | Interleaving:   | | Interleaving:   | | Interleaving:   | | Interleaving:   |
+ |   Ways: 1       | |   Ways: 1       | |   Ways: 1       | |   Ways: 1       |
+ |   Gran: 256     | |   Gran: 256     | |   Gran: 256     | |   Gran: 256     |
+ ------------------- ------------------- ------------------- -------------------
+          |                   |                   |                   |
+          v                   v                   v                   v
+         DPA                 DPA                 DPA                 DPA
+
+This shows the representation in sysfs:
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
+Note the endpoint interleaving configurations with a direct mapping (1-way).
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
+The corresponding CXL host bridge (HDM) decoders and root decoder (CFMWS) show
+and match with the calculated endpoint mappings:
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
+* Allow a CXL device to be in a different HPA space other than the host's space.
+
+* The platform can use implementation-specific address translation when crossing
+  memory domains on the CXL.mem path between the Host and the Device.
+
+* The kernel (OSPM) determines Endpoint SPA range and interleaving configuration
+  using platform-specific address translation methods.
+
+Benefits of the Change
+----------------------
+
+Without the change, the OSPM may not determine the memory region and Root
+Decoder of an Endpoint and its corresponding HDM decoder. Region creation would
+fail. Platforms with a different interconnect architecture would fail to setup
+and use CXL.
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
+Add the following paragraph in 8.2.4.20 CXL HDM Decoder Capability Structure of
+the specification [#cxl-spec-3.2]_ to the end:
+
+"A device may use a different HPA space that is not common to other components
+of the host domain. The platform is responsible for address translation when
+crossing HPA spaces. The OSPM must determine the interleaving configuration and
+perform address translation to HPA ranges of the HDM decoders as needed. The
+translation mechanism is host-specific and implementation dependent."
-- 
2.47.3

