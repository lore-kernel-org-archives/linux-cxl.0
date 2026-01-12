Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEEA3563D4;
	Mon, 12 Jan 2026 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216667; cv=fail; b=IHZ2RK8nnvnjHgr2DCsmeld0E0Cr8uhoTybEJnXM6T+aRhie0eSqcApFi10BggPP8MhrUWshXI0kAh45tOc0rESxo5IVhfkr869YRAkRRcd2w4WhDvaFnIkPAf5u1ap33j48GwldtLYg71xsEOWFsTz6oNodiokGyCUSLaaHwWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216667; c=relaxed/simple;
	bh=bKXGy31p0ifMZXwNzooa0/dD2nIglxs3gp13jZ2m3Yk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kbrt2YBHd/23+0yk2caJI60JoYwVHj4lNnK5IuqJjRgJtC8McGwoDP1a7Xdw+8t7v4peo4MxKHFNtQjClCLrx56+uZqJFLbVD5xsiEOtgKwd4bg86rht/HYsxIYNq4Y+Bv2Mh0ImCJXTm7lcWGUTDJrLe/gb6dBcMgxFDktiXG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=px64YsSv; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="px64YsSv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQZ1DXi1BD3I0s9GQvEavmmQ5YTIblxS8bv94WxZxEh1+/g/xlSjlj5Nlmu1VfxjNltzrHeDP5q6JxatjuIg0BKLAI4tzmZJHR99UXWGpbJ9cjRLF/1aY3gvkPiT4k1bryC0tz78CbcZeDbG6hr3vjfcR3aFibgT3RWUx3IHBPw3Sw0JPviBnI83okLmhdC+gtdjy4+rfxTuKoox/CT33VHuKuSH83zou7KlxHk/IPKrza+b/FAM2oqlA6es0GlelJCHrZi1OFluxCkyPghpKeQbMGrHPNzPb9cCjgjKNabG6ITmT2ZS5rTMDJbB1S9XY6w0HhlcbBQNAPdXbCO/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKXeFHGv/wGbiJVmCjcqjw0U+k6b2Q6HghUQ+4YIFFU=;
 b=KLYDdol/e+DFTCR9ofvrkVQzUA15AP3Kzl1H/Tv5Rqmkwzu3ciDqKMeQBhO2J2siqigKvGvYcjmS3j5jy8Un7NYF59Ro8xTRBVSvfM1mRAOVL/HLuvk/raYD+5M+SIbAAuVaXTO2kt2RyfHjgd6ICqmEYQEdqgd0ugEmtpGkuKOwj0wF3uMdZjej+3KGZu0Ojnf3wP18lsAAxFxT+Q7AIsITxl9zGra34/h86ZdrJU+Qi+sBjwa1I5phQen3tSTj5yxhl6ZVDcn6pYLcw6fYs8Tb/rAw47rJoqt/O+Ag1bYg82raFioK6pRzGJuld82L6s3W9UIgGH0zm9/2qbbw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKXeFHGv/wGbiJVmCjcqjw0U+k6b2Q6HghUQ+4YIFFU=;
 b=px64YsSvUqxpcmB5rM1wRs2vpMHZPPRS4ilDCSI0YNuRAQTPpXEWO61BthYJxcxjfYCaDoYEYkkZ26lBR+Y40OqghNUQZvdP2+Kkihhj2z0zgEB5MGrMymt22m/79owm6L55lgshGCB6pPpn51fT9KrU6h70zREfgxRW2epK8vY=
Received: from BYAPR21CA0027.namprd21.prod.outlook.com (2603:10b6:a03:114::37)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:17:36 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::d9) by BYAPR21CA0027.outlook.office365.com
 (2603:10b6:a03:114::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.1 via Frontend Transport; Mon,
 12 Jan 2026 11:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 11:17:35 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 05:17:30 -0600
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
Subject: [PATCH v3 2/3] cxl, doc: Moving conventions in separate files
Date: Mon, 12 Jan 2026 12:16:44 +0100
Message-ID: <20260112111707.794526-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd35333-69ad-48bd-490b-08de51cc304b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0kzajdjT0d5NXVPbGhYREd6bUY5bjM0ZG1ZY04rbkNLNStOVEF0NlAvRWZX?=
 =?utf-8?B?c1NncGJ5SlBmeUtLMmlJMGljenRYdko1ck9Ta2dDNDg4ckFFTS9xcUJVdkZY?=
 =?utf-8?B?MjZTcHFJbDZlT3FsRkl5MWE2bEdpTlV5dFdyZVlzQU9jSDFCRy80dlNmbDYz?=
 =?utf-8?B?UEpkSVhCOWVZU24zK24vVEE5YWRYSTBoUHhxTWovRXNVVVF5ZmU2ejVVQklD?=
 =?utf-8?B?a2t0TmVNa1RoT3R2YVBwdXljVU5kV3liVUdCUVNUdmVuZlplNjAvV1ozYmt1?=
 =?utf-8?B?WUNrSUhVVzRia3VSV2lEV3k0SHRGWFlzNVlGUS9qZUpOdHE2STQ3Z1BrMXc1?=
 =?utf-8?B?WUtCN01OREFxZisvdksxQVUwMVVZK1I2bVY4V2JaUmhqRGYyQjI5Ny9UNWx2?=
 =?utf-8?B?YjdXbEoxL3Z1SktDd1RVTjRjTkQxeGdreS9MdkIwRUdKWkJGd3dDUmk4SW9j?=
 =?utf-8?B?R1RMRUdZdjFnZWlSSHJoZTEzWTNKQ3pZUnRkQnFrZVpDdmYyaWlxVlU1UDhU?=
 =?utf-8?B?ZFZCZ0xNTnQ3dGxHbnIzSDlxenVqZ2Y1TWpnQkxFb0Fwa0tKcWp2ZStQRlEr?=
 =?utf-8?B?M2pzYTkycHRQN3VqdnNaYXZYbHZpOWZyUkRaM25VSWcrMFUreG4yWHNxbTlX?=
 =?utf-8?B?VGZvN0lhZEgxMm4ra2ZWVTBHZGxzTnRGcWJMQmdKK1JWYVNPMzNvRGJUclM4?=
 =?utf-8?B?b01GbXpnWGdVZktHT2NaZXh0cGJFdmRPb0QvN1ArUEhaS042NVAvcnFDc0V0?=
 =?utf-8?B?a3Bncm1hZ2QycXdQZlNEUnViNk9UOXVmblkwRzdSbGxUcHdkREQyWmI5YjV6?=
 =?utf-8?B?N3NjVnBBR2NxMnpDRlZRUVZrQVJmWFRZSEhRTUNyN3BFcFVHK09PdG0vb3FJ?=
 =?utf-8?B?dlhxM1A0OUpFZE1TcGcxYU5VSHpZNWgvYy9uTXVzME9uWDVyaENrelhPYVJu?=
 =?utf-8?B?K3FYNHJhMWd5UGE5c25XU3hUZ2tZaGhYUVVlYXp6YWhWMGY1ejRZbVpTOUF5?=
 =?utf-8?B?alpma3pmNy9BSzFRQTNmZklaZVN5V25ldVhRZ09vaUZiWnpTMGlZYkFpbG1Q?=
 =?utf-8?B?K3JCbjNTZTd0aHdjZFAxTVFyZWdRRjB4R0VhOHRVOEtRK3UzNy82M3JEM2tm?=
 =?utf-8?B?dkVVRmRSYUplb3l6N2Q1dlNRUEdsV2xOY3NUakR1aUNDOWpSK0FKazE4RFNn?=
 =?utf-8?B?czh6akpjNG9WejJuR3pZRW92eG51REVhUXBPNVBDZUVHSEdCVlBwZFlJck9r?=
 =?utf-8?B?WUZxZ21xWkpXMENGUkMzd1lmRjVnT3VMR0tEZHJaMlV4LzlJazVMaUU3bWlL?=
 =?utf-8?B?cVc3OWVOdzVoeFJLcEtxT1hrTDRwMk53RGFWY2Q2WTlxajJoNWQwQ0k4ZjNV?=
 =?utf-8?B?WjFTL0lsVFdmaHNvb3pYTXV0TjMwMVRueXBCaXdhY0VrNVdkY3JURFJLdlRz?=
 =?utf-8?B?WGgyZExmZmpVWVJCZzNlaGdISElQY1dUaFFkTHRKVWVoTHlybjliYzhOSUV6?=
 =?utf-8?B?SHcwcTRXWFBuQnB0VDJBOVkrcVJPVGtjR1V1WkVwYWM5Z25XSUVBS3hZTWNP?=
 =?utf-8?B?SGR5YWY4bDNIMHdQU1JqUGlnb3F5c2hTaHphOHBhRGxqMElRYTgvWGJTVHgz?=
 =?utf-8?B?YjdqcXNiZkJOSzlldmRjWlJxSUhXQVZVY2lCUXNqUkZ3aEtES2ZLUWFPNXBw?=
 =?utf-8?B?bkhGbEUxcGRGYTNYTTFvK3RxdGZxR3BEMXl5K2NMRFpKVlVOaHFrSWI5SllT?=
 =?utf-8?B?SWxrclR2ckNmeWhXN256d01mR3cvV0RMdi9RVU5rTllIeERCNzlMUGtQdk91?=
 =?utf-8?B?eEk4eDhmdE93WUtYNXlyaW13UkFSUTdiaTlIcSttWnpkQXp3TlBvOGZyRDJ6?=
 =?utf-8?B?cUpFaGdOQU53UEdWZlJ1L1hoMWFpeVpOdUZ6UFVTSHdOb3NubnNLajN3ZGoy?=
 =?utf-8?B?Q2tMdkRrY3pDWWlLWDN2UGJRUUMwaEg4VmREdlkySHBnRnNORHhqdG80WXZQ?=
 =?utf-8?Q?kLbURyPEZN6mZlDmAJovXotcDLYls4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:17:35.7799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd35333-69ad-48bd-490b-08de51cc304b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359

Moving conventions in separate files.

Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v3:
 * updated sob-chain,
 * move isonum.txt removal to separate patch (Jonathan Cameron),
 * kept intro in conventions.rst (Jonathan Cameron),
 * removed additional blank line in template (Jonathan Cameron),
v2:
 * removed include:: <isonum.txt> line (Jonathan Corbet).
---
 Documentation/driver-api/cxl/conventions.rst  | 176 +-----------------
 .../driver-api/cxl/conventions/cxl-lmh.rst    | 135 ++++++++++++++
 .../driver-api/cxl/conventions/template.rst   |  37 ++++
 3 files changed, 178 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/conventions/cxl-lmh.rst
 create mode 100644 Documentation/driver-api/cxl/conventions/template.rst

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index ed4237583d36..9267a697b2fe 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -1,8 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=======================================
 Compute Express Link: Linux Conventions
-=======================================
+#######################################
 
 There exists shipping platforms that bend or break CXL specification
 expectations. Record the details and the rationale for those deviations.
@@ -10,172 +9,9 @@ Borrow the ACPI Code First template format to capture the assumptions
 and tradeoffs such that multiple platform implementations can follow the
 same convention.
 
-<(template) Title>
-==================
+.. toctree::
+   :maxdepth: 1
+   :caption: Contents
 
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
index 000000000000..baece5c35345
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/cxl-lmh.rst
@@ -0,0 +1,135 @@
+.. SPDX-License-Identifier: GPL-2.0
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
index 000000000000..ff2fcf1b5e24
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/template.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
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

