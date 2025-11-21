Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BB23D2AB;
	Fri, 21 Nov 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763727443; cv=fail; b=QEzuRPto5oozfxBj30FzzL2iivVUO5eNdrsPei84mk8f5w4emscvc5u0j4OxA6vpQ2yHljc9Akenrrhu/nZ1Ie8fqSAX9ZjxIoYaxL2oPP7NHERLjHI+W3xVyNPSvELlsPyzOUboxBGgjFLmLQerxMa5dny2hzwXEKFQDkYdOWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763727443; c=relaxed/simple;
	bh=icyI1N94Mj9XqPKzwPqh+noc9NvIVCXMpuapeZZOojk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=idLEJKmk2o2bdHp44vIbxP+dSAv7ncmRE6B3U37YClYx5jdKB/hIaqALOlfQ6KkHNqRNebOSVCrwQIDXh7LgXXPw4M1weB612k2TxdmWYxLv3nVIUc/ysTLME1SyPPj2nRl6JSpc2GRP6XR5rQ1opplHu5jUHC/TOk94OrGkJ2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OmcAQGw6; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OmcAQGw6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nN3xCg8HSUAkv/XjMrGvZfJ1RCxi107ojFRFkYiUUyVun6b+bXP7dtJwmRrH4LnYCzSKug4gEEIuKjOqXmGS4GAhNXXp7+ZSqzSUOnNem6Z3o/sQO8msFEF8wY5vIauBKlO2nbwRil1LQsKvtbL4AV2KNcECaux8AWfGRJ7nQYlWrdcdbjy1byCozUmz6l9utqTi1u5SyhqVuh3udZVG7FfWWNtfBbnAAP5KtscRRfKOX6uvIrXiUCxzja9Gich6I0TynynENDNKHlecZcemhrMFp3U+X8Y7dH/wtDzZ9BEoTXhmLNq3SUnhmbRGACJqG/ycrGAjpOKS5CJca4xung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pB1rjG4Q1PSjlJ1HQMPHgjdifRUoapknHO+N4H34c4k=;
 b=XGfVBFINwaks3JQt7jfMISZh5swXIKq1+ccfGhCApQ6bIkyvzipgoP7dqU7Lq/xIPdzaLK8M8XG2We0ZIEbzUEBJRCMX6kqkW87hvzZ6omIl/GXRuvIVIYMxiuQmi2QmbD1Kwl6ZREAVeHa3E/JBOz/BR/ol0UirjX+X5Fs1l3tZcdwKo9a0N4YDrOomVFvHMHukZw4EnvAO1f89cyZECQNr0dF0kSpnMOGKBGH/j4Su70V9AHGTvDPbFlHhiQDos0yR48bAdbLzLT7tYl4qkXopp5E+JrtGJym1J2yVRF0OSOwLGM/Is/MHtHrkaUdY6u+xXPfB9/xa8GheLFKbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pB1rjG4Q1PSjlJ1HQMPHgjdifRUoapknHO+N4H34c4k=;
 b=OmcAQGw6nJUPSXq1aIX17bH1/PXVosnx4SCDpv9k28ECpAdygauRYULS285EjHTjj++YxsDmIbDhK0YLFrOF6COxvNv/Ed8l2W9EDtKpogr9NioL2oPENB9xLfcWoeScqAkuH0qdGJ6Wm6pThs9ng8/iN3aP79Bt2L046Rh91m4=
Received: from BN9PR03CA0758.namprd03.prod.outlook.com (2603:10b6:408:13a::13)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 12:17:13 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::6b) by BN9PR03CA0758.outlook.office365.com
 (2603:10b6:408:13a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Fri,
 21 Nov 2025 12:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Fri, 21 Nov 2025 12:17:12 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 04:17:06 -0800
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
Subject: [PATCH v1 1/2] cxl, doc: Moving conventions in separate files
Date: Fri, 21 Nov 2025 13:16:50 +0100
Message-ID: <20251121121655.338491-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: e02136db-29d9-42ef-ebcf-08de28f7e6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjVaL0ZUc0h4Ni9ROWp1eHowQ3VKdUppVXA2UUFncys0SWFqVk9pK0lqcFA1?=
 =?utf-8?B?MmRPemlKb2FFbWJveXVUOGx3MW1IS2NlV0pGUnlScnVBVWR4ZWdhRHQzQVhS?=
 =?utf-8?B?djNEZ2JtV0NycnZlcWowSXJpdXlNSGtUUlZ3UGE1bUtDLzk1QklVc2x1RnVx?=
 =?utf-8?B?Z29wMkRZcUk2VUlTRU9ERkpZTzNDSnY4NFp4OEwvWDJaN0RlVjVOT3V4SGJr?=
 =?utf-8?B?bWtJdDlQODY4VEpRSHZCTUE0aVJJWXYrakkyMjROSXNJSDRrUFo2RFhSbEV6?=
 =?utf-8?B?c3VDNy9oaHRjaEpNanM5aGZjcEJaaEpFelFkVlc0MUlaZkhnLzh1Rzc1SU9T?=
 =?utf-8?B?RnE4YnBRMXFMdk5kM2dHSlB1VE1iN3FJSXdRalI3RHZ1NyswRmxSTDl2WEo2?=
 =?utf-8?B?YXBKZEthZXN3QUhoSHBHcWdxTFdFR3paUDBFNnloQjFac2d1UG82cDNNcndi?=
 =?utf-8?B?V0gva0l5cWZPb2hUbmZlVHFrVDRHYWtaNG0xbGlOdE4wM0lpWlZNdjhNMUM1?=
 =?utf-8?B?T1VuTHFEaUc5YnBzdU9LdEJpTjFUV1FYWDJWWFF2NFVBcTdJaTdXR3VsOTZi?=
 =?utf-8?B?enhNZzlXQmtFcmdVY2YxMHZGUlJlMWVLUWZtaC9wRUFOMU93Y0l2KzZnMFZm?=
 =?utf-8?B?UFRJMHVVZklQaDlRVFVCbHZEb1B2ZkFtYlIrSmYySGplRWxyZTF3MUhOZVhL?=
 =?utf-8?B?bWZSWjh1SGIwT2dDbGdQYzFZcmJ5U1V1M3ZTN2N6cU5yMXZsTWM2UkZrbHN2?=
 =?utf-8?B?T055UkRhMHNaa0dtSUNSc2ZKd2hiRFFnbFVuVFEvellsOXE4L2hCSmlxa0s4?=
 =?utf-8?B?YnZ1VlFxSFpSODZzYmFhYlpmdHVvaUlWWE93N3R5aVpYUm1KS1pyNllyUGla?=
 =?utf-8?B?eGlUQ1l3aU5PM2s4NlVyMTQ4bmNrWlZPdmp4OE56dzE1cjRCUk9Cb0lZUm9M?=
 =?utf-8?B?OTNKVlg0bEZVWlU2dUo0VVNyZFZjWjcrbVV3MUVZdWVVSklxaE5SNXRmL1Qy?=
 =?utf-8?B?Rmh5ZlIwbDU0dHhUWEZ0akMwUmFTK2dkZ0ZZNy8xSkNYYUx0eDN3dHVBWHNa?=
 =?utf-8?B?RGNxZnpCT0ltY0lpcEE2cXZqVk9jdVhDVGlZT0FMaEhmRkJwQjVvMWpEVjh5?=
 =?utf-8?B?eU5NZUtTY0NMQldwM3Q2Ni9xMWZUR1kvbVFoQWdzNDZmR043S0d6QWhYQk9F?=
 =?utf-8?B?bEJ3WlZyZ2RjL2dlTUhLTzBkVHoxYXN4YUh2QStGNXpwc3hmRzYrWElZVU5K?=
 =?utf-8?B?RGdhbUwxNWtWc05YdFRORUpKWnFGeDBSdWtVMEZ3eWhhSTRSL0NrNVFnTHBr?=
 =?utf-8?B?SjdVWlBuM1Y4LzNVS3JjQmdVWmpYU0txNXhTcG8xOHZWT1NPTDdpa25saXZu?=
 =?utf-8?B?dE8vbUJxZHRZcTBXQWM5Uk92RU42OFpUZ0JUSkpuWHQwWUR3YnZtL3NoaE13?=
 =?utf-8?B?NEo2Q1NNTXVqamt6S1lITDRENy9KTk1zSXVwWGlndHdwaUcxNC9UZW4vRTEw?=
 =?utf-8?B?TVZYcGIzT3ZTU2dlL0V3bTF0enhybXQyTXlYUWJ0MWo1MnJ2aXIvZnNuTkRs?=
 =?utf-8?B?MVcwK1BKVTF0eFlpZ0ZJZkxuZzJGMnI4bm9IR05MM1FQa1NuQ1grRE9wcGZt?=
 =?utf-8?B?aGtRUGdYdkJJRE1BazVkTmZSTEFYVVpJRVRRaU8weGxpb2NVMlVIbzhlOHVP?=
 =?utf-8?B?RVh3RmFmL1l3NFhXMC9IYXBIZnpZRWZDUjF5cXF0MVJld3B4OWhMZW8yWExE?=
 =?utf-8?B?L0daNTBGTXNnOHIzZTE0Zm9wdmdkc3hnQThRaVo5bzJ4YzRoM0xLVUtidUw0?=
 =?utf-8?B?bXk0OHA2MWEzWE5qY1NCMS9Ndit3QXEyN0RiTTUwWE1sTWMyWksxdnJpU2d4?=
 =?utf-8?B?cWFWaE5aZWVQcWFaOEpDL2xhMDBCKy9MUVhURmp2RjBEVURCcXZoUzJvMngw?=
 =?utf-8?B?Tmw5dUV3UlhPdUd1U0ZvdkRuQkFrbUxRR1oweTBLY29TdUErMFhGaDBDcnEx?=
 =?utf-8?Q?5taock8KZbOnED6GdDlNjLAUxpIR0A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:17:12.9680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02136db-29d9-42ef-ebcf-08de28f7e6f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446

Moving conventions in separate files.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 Documentation/driver-api/cxl/conventions.rst  | 183 +-----------------
 .../driver-api/cxl/conventions/cxl-lmh.rst    | 136 +++++++++++++
 .../driver-api/cxl/conventions/template.rst   |  39 ++++
 3 files changed, 181 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/conventions/cxl-lmh.rst
 create mode 100644 Documentation/driver-api/cxl/conventions/template.rst

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index e37336d7b116..53f31a229c8d 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -1,182 +1,11 @@
 .. SPDX-License-Identifier: GPL-2.0
-.. include:: <isonum.txt>
 
-=======================================
 Compute Express Link: Linux Conventions
-=======================================
+#######################################
 
-There exists shipping platforms that bend or break CXL specification
-expectations. Record the details and the rationale for those deviations.
-Borrow the ACPI Code First template format to capture the assumptions
-and tradeoffs such that multiple platform implementations can follow the
-same convention.
+.. toctree::
+   :maxdepth: 1
+   :caption: Contents
 
-<(template) Title>
-==================
-
-Document
---------
-CXL Revision <rev>, Version <ver>
-
-License
--------
-SPDX-License Identifier: CC-BY-4.0
-
-Creator/Contributors
---------------------
-
-Summary of the Change
----------------------
-
-<Detail the conflict with the specification and where available the
-assumptions and tradeoffs taken by the hardware platform.>
-
-
-Benefits of the Change
-----------------------
-
-<Detail what happens if platforms and Linux do not adopt this
-convention.>
-
-References
-----------
-
-Detailed Description of the Change
-----------------------------------
-
-<Propose spec language that corrects the conflict.>
-
-
-Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
-============================================================================
-
-Document
---------
-
-CXL Revision 3.2, Version 1.0
-
-License
--------
-
-SPDX-License Identifier: CC-BY-4.0
-
-Creator/Contributors
---------------------
-
-- Fabio M. De Francesco, Intel
-- Dan J. Williams, Intel
-- Mahesh Natu, Intel
-
-Summary of the Change
----------------------
-
-According to the current Compute Express Link (CXL) Specifications (Revision
-3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
-or more Host Physical Address (HPA) windows associated with each CXL Host
-Bridge. Each window represents a contiguous HPA range that may be interleaved
-across one or more targets, including CXL Host Bridges. Each window has a set
-of restrictions that govern its usage. It is the Operating System-directed
-configuration and Power Management (OSPM) responsibility to utilize each window
-for the specified use.
-
-Table 9-22 of the current CXL Specifications states that the Window Size field
-contains the total number of consecutive bytes of HPA this window describes.
-This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
-
-Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
-memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
-the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
-
-The HPA represents the actual physical memory address space that the CXL devices
-can decode and respond to, while the System Physical Address (SPA), a related
-but distinct concept, represents the system-visible address space that users can
-direct transaction to and so it excludes reserved regions.
-
-BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
-with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
-resulting in lost capacity in the Endpoints with no SPA to map to that part of
-the HPA range that intersects the hole.
-
-E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB:
-
- +--------+------------+-------------------+------------------+-------------------+------+
- | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
- +========+============+===================+==================+===================+======+
- |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
- +--------+------------+-------------------+------------------+-------------------+------+
- |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
- +--------+------------+-------------------+------------------+-------------------+------+
-
-HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
-a 12 ways region and all the intermediate Switch Decoders. They are configured
-by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
-3GB. Instead, the CFMWS Base and CFMWS Size are used to configure the Root
-Decoder HPA range that results smaller (2GB) than that of the Switch and
-Endpoint Decoders in the hierarchy (3GB).
-
-This creates 2 issues which lead to a failure to construct a region:
-
-1) A mismatch in region size between root and any HDM decoder. The root decoders
-   will always be smaller due to the trim.
-
-2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
-
-This change allows a region with a base address of 0GB to bypass these checks to
-allow for region creation with the trimmed root decoder address range.
-
-This change does not allow for any other arbitrary region to violate these
-checks - it is intended exclusively to enable x86 platforms which map CXL memory
-under 4GB.
-
-Despite the HDM decoders covering the PCIE hole HPA region, it is expected that
-the platform will never route address accesses to the CXL complex because the
-root decoder only covers the trimmed region (which excludes this). This is
-outside the ability of Linux to enforce.
-
-On the example platform, only the first 2GB will be potentially usable, but
-Linux, aiming to adhere to the current specifications, fails to construct
-Regions and attach Endpoint and intermediate Switch Decoders to them.
-
-There are several points of failure that due to the expectation that the Root
-Decoder HPA size, that is equal to the CFMWS from which it is configured, has
-to be greater or equal to the matching Switch and Endpoint HDM Decoders.
-
-In order to succeed with construction and attachment, Linux must construct a
-Region with Root Decoder HPA range size, and then attach to that all the
-intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
-regardless of their range sizes.
-
-Benefits of the Change
-----------------------
-
-Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
-Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
-with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
-
-This change allows the OSPM to construct Regions and attach intermediate Switch
-and Endpoint Decoders to them, so that the addressable part of the memory
-devices total capacity is made available to the users.
-
-References
-----------
-
-Compute Express Link Specification Revision 3.2, Version 1.0
-<https://www.computeexpresslink.org/>
-
-Detailed Description of the Change
-----------------------------------
-
-The description of the Window Size field in table 9-22 needs to account for
-platforms with Low Memory Holes, where SPA ranges might be subsets of the
-endpoints HPA. Therefore, it has to be changed to the following:
-
-"The total number of consecutive bytes of HPA this window represents. This value
-shall be a multiple of NIW * 256 MB.
-
-On platforms that reserve physical addresses below 4 GB, such as the Low Memory
-Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
-have a size that doesn't align with the NIW * 256 MB constraint.
-
-Note that the matching intermediate Switch Decoders and the Endpoint Decoders
-HPA range sizes must still align to the above-mentioned rule, but the memory
-capacity that exceeds the CFMWS window size won't be accessible.".
+   conventions/cxl-lmh.rst
+   conventions/template.rst
diff --git a/Documentation/driver-api/cxl/conventions/cxl-lmh.rst b/Documentation/driver-api/cxl/conventions/cxl-lmh.rst
new file mode 100644
index 000000000000..3049c1f58f7d
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/cxl-lmh.rst
@@ -0,0 +1,136 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
+============================================================================
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
+- Fabio M. De Francesco, Intel
+- Dan J. Williams, Intel
+- Mahesh Natu, Intel
+
+Summary of the Change
+---------------------
+
+According to the current Compute Express Link (CXL) Specifications (Revision
+3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
+or more Host Physical Address (HPA) windows associated with each CXL Host
+Bridge. Each window represents a contiguous HPA range that may be interleaved
+across one or more targets, including CXL Host Bridges. Each window has a set
+of restrictions that govern its usage. It is the Operating System-directed
+configuration and Power Management (OSPM) responsibility to utilize each window
+for the specified use.
+
+Table 9-22 of the current CXL Specifications states that the Window Size field
+contains the total number of consecutive bytes of HPA this window describes.
+This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
+
+Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
+memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
+the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
+
+The HPA represents the actual physical memory address space that the CXL devices
+can decode and respond to, while the System Physical Address (SPA), a related
+but distinct concept, represents the system-visible address space that users can
+direct transaction to and so it excludes reserved regions.
+
+BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
+with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
+resulting in lost capacity in the Endpoints with no SPA to map to that part of
+the HPA range that intersects the hole.
+
+E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB:
+
+ +--------+------------+-------------------+------------------+-------------------+------+
+ | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
+ +========+============+===================+==================+===================+======+
+ |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
+ +--------+------------+-------------------+------------------+-------------------+------+
+ |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
+ +--------+------------+-------------------+------------------+-------------------+------+
+
+HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
+a 12 ways region and all the intermediate Switch Decoders. They are configured
+by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
+3GB. Instead, the CFMWS Base and CFMWS Size are used to configure the Root
+Decoder HPA range that results smaller (2GB) than that of the Switch and
+Endpoint Decoders in the hierarchy (3GB).
+
+This creates 2 issues which lead to a failure to construct a region:
+
+1) A mismatch in region size between root and any HDM decoder. The root decoders
+   will always be smaller due to the trim.
+
+2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
+
+This change allows a region with a base address of 0GB to bypass these checks to
+allow for region creation with the trimmed root decoder address range.
+
+This change does not allow for any other arbitrary region to violate these
+checks - it is intended exclusively to enable x86 platforms which map CXL memory
+under 4GB.
+
+Despite the HDM decoders covering the PCIE hole HPA region, it is expected that
+the platform will never route address accesses to the CXL complex because the
+root decoder only covers the trimmed region (which excludes this). This is
+outside the ability of Linux to enforce.
+
+On the example platform, only the first 2GB will be potentially usable, but
+Linux, aiming to adhere to the current specifications, fails to construct
+Regions and attach Endpoint and intermediate Switch Decoders to them.
+
+There are several points of failure that due to the expectation that the Root
+Decoder HPA size, that is equal to the CFMWS from which it is configured, has
+to be greater or equal to the matching Switch and Endpoint HDM Decoders.
+
+In order to succeed with construction and attachment, Linux must construct a
+Region with Root Decoder HPA range size, and then attach to that all the
+intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
+regardless of their range sizes.
+
+Benefits of the Change
+----------------------
+
+Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
+Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
+with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
+
+This change allows the OSPM to construct Regions and attach intermediate Switch
+and Endpoint Decoders to them, so that the addressable part of the memory
+devices total capacity is made available to the users.
+
+References
+----------
+
+Compute Express Link Specification Revision 3.2, Version 1.0
+<https://www.computeexpresslink.org/>
+
+Detailed Description of the Change
+----------------------------------
+
+The description of the Window Size field in table 9-22 needs to account for
+platforms with Low Memory Holes, where SPA ranges might be subsets of the
+endpoints HPA. Therefore, it has to be changed to the following:
+
+"The total number of consecutive bytes of HPA this window represents. This value
+shall be a multiple of NIW * 256 MB.
+
+On platforms that reserve physical addresses below 4 GB, such as the Low Memory
+Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
+have a size that doesn't align with the NIW * 256 MB constraint.
+
+Note that the matching intermediate Switch Decoders and the Endpoint Decoders
+HPA range sizes must still align to the above-mentioned rule, but the memory
+capacity that exceeds the CFMWS window size won't be accessible.".
diff --git a/Documentation/driver-api/cxl/conventions/template.rst b/Documentation/driver-api/cxl/conventions/template.rst
new file mode 100644
index 000000000000..ced7493f4bb2
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/template.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+.. :: Template Title here:
+
+Template File
+=============
+
+Document
+--------
+CXL Revision <rev>, Version <ver>
+
+License
+-------
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+Summary of the Change
+---------------------
+
+<Detail the conflict with the specification and where available the
+assumptions and tradeoffs taken by the hardware platform.>
+
+
+Benefits of the Change
+----------------------
+
+<Detail what happens if platforms and Linux do not adopt this
+convention.>
+
+References
+----------
+
+Detailed Description of the Change
+----------------------------------
+
+<Propose spec language that corrects the conflict.>
-- 
2.47.3

