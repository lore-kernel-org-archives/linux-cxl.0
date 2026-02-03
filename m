Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AAE325711;
	Tue,  3 Feb 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140218; cv=fail; b=k5CSfz8eEOVFi4SqcjfRZ12vPsUMW6CbKkY9nfMEYPOyuSCQ6dCujfg9mDCnw+7qJk3njkwPslxWAOuczeWYGjI3mDIg0Tq8gqTiOMyspoghTumJnGKbW2Z6Y84ibqqbIL8QsOwvtsFCziTXeZWjoGXkR9/9NVFRaSrvYDaK5BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140218; c=relaxed/simple;
	bh=loKctYcgkaOolNq7Vs9Z4BMN8884fTjffQoBTFIXusI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ond9otGEwUlmGxbVdFfs6r9GTk7b6wPxCoB2devsGq+OQ8QxEhpozWagc/BTQzbsvrBziAoQxyF186G+Vb1XdOTtnGle3ER/MQR382LhNapYug9Wul6hMfGkIoQNbhXdXWuHkalvYMFBcb48XRsTXtv7EJ9UW8x/ZhwR4F1d8xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DaMTCD24; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DaMTCD24"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgTEQop0Po3ulWtn7Zp8PwfpuXYl5e8wE/Ix+X4kSeY6c7dDYVq1QuV1L/MBxOOdXs41UT+YkIjQEVoyXQCB0a1xtf22Cyx+G3DXag4cr0+OVcdo7XcILCm2IEeTZuGRBBiDCH/y0Dla7rod9OlhX2vkL9m3npUADaX8XVyCagpVHdOAjM11HNtVBy0R+XHAW22X3mSLIOcIOpTR5pCPguKI5QIml1v2cL/LA2pBhyDqeJtWytpBdGeuI1epRPtenXiUBZxjR1yy68Y1QqQrO4MUM788r8x/Ae+w9puo2SODx3x2/DLWfdR5YEbWVf2USBmxxfUdSRaLalx5mpAPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1IMnAkkRipu+p7nZaIhlLNlwllEr063M6Qnd6io+ms=;
 b=cxAwGC29n85+V3aEXjcTyprYmsP2uKPsxATP45YmG1OWMIYftZb5DdBpe9w34hWfDOV+l54WPBpR0Vs4OfeBYB3ugS8Ya0PhZbBZDJhsBx9mFReNqXi1Ff55Ue+MBuBRePHtklsDA+O0U/NbME7Ii1hpQfrPmeVMmy4qn9WS58/tmE3xTiBuAC6dsJGTV/6LLcvnyptOZYHczIgAYkBfwJiHmXY2F+OVgag6UdsWf2jHvl1xfegalpaCfWMBDo801ucPd+ufFGqdfWjK50uFX4Hb4PUASmVDrsM/rTUlj+2wc+R9Y4hfVlmgdsxKLeBr2WyNUYPHnwXa+kTMupMGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1IMnAkkRipu+p7nZaIhlLNlwllEr063M6Qnd6io+ms=;
 b=DaMTCD24O6rrwMtEAVC9Q3SyqgDxcS7zlbu0N/8n1jrDHKmRADGkbkg+XoYSGX9LKf4MsURSsHBlqml7CN3FxRDQsVgcMHPzfJhFXSOzBypEY3l5NAqcPSnLcn3oTGXVQm/uzWzsLX+18kiy0ahJlxEPMVVelS6moLNuj5xDx7U=
Received: from BN9P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::12)
 by PH7PR12MB7354.namprd12.prod.outlook.com (2603:10b6:510:20d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Tue, 3 Feb
 2026 17:36:48 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::b2) by BN9P221CA0004.outlook.office365.com
 (2603:10b6:408:10a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 17:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 17:36:48 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:36:44 -0600
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
Subject: [PATCH v5 2/3] cxl, doc: Moving conventions in separate files
Date: Tue, 3 Feb 2026 18:35:59 +0100
Message-ID: <20260203173604.1440334-2-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203173604.1440334-1-rrichter@amd.com>
References: <20260203173604.1440334-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: cb99473f-8725-4550-95d0-08de634acf06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEdxQ3IyejQyRGtWaks1bU9iUjRzU0ZnVnU3VjRFcjVvQnVNRzFCTkY1bStL?=
 =?utf-8?B?bGpsRGdmdEJDZms3RUpKY09obGhHQUNFK0hPdE5ybE1keTRzWklVUGY5MCs2?=
 =?utf-8?B?dk9NZzljV2tWTExsTkpHellNMzc1WHF0S3dBbE9KSGpsZWhZRUFRZW1vVXRh?=
 =?utf-8?B?YUVIdGVUS3VSeVU1VnBrV2N0ZmFyZ2FIRkwxQlEzUW11cWpoTHo3MHZETUkw?=
 =?utf-8?B?L0NQbVhwTW1vL0VFam9UcmpORVEvOUZ5dkdzQzlRanlMUEp0MTlOYjJhRGt1?=
 =?utf-8?B?NGp2VzBOaHQzNU9YMnIvdXJPZnNETjY1bUtPRDFuR0lLUm5rSGtDSnU4UVlB?=
 =?utf-8?B?cmJldVNlMzdxSlZ5dGVneWFHMVVHN21PY0xLaG9BRzhpSlo2MVlBaXhManVt?=
 =?utf-8?B?Tkl1aDFyUUtXT1N5NGwxQXFZY0ZhZlkvOHB4d1pLK1ltcE5sc1dtbTRSRkZj?=
 =?utf-8?B?djVHS1VVRHZPWGQxa0hNZVVTYnMvd0pJbjhNbUY4U3lLc0gzSHF6Rm15Q0Vy?=
 =?utf-8?B?SldhcjVkYUY4anh1UEpDZVl0am91OFN2dzV6WHVHbWZZaTI2OFZhMk9ORW5D?=
 =?utf-8?B?a0F2cUhTdllueDFabDN3WE5DTi84NTZXMjdDL2NyRld0U2hwSVZ5QzE2SE9Q?=
 =?utf-8?B?VmhRVEVuWjdZd0RLeGZtSkJ6UWowTllIM1hTM0hhQjRhSURLNUp0Rk9vQjI4?=
 =?utf-8?B?UjRqUUkzK0Eyb0VwZlBaY3JlUGk3cFQrclBpcWdSZGcxWWdqZCttZEdUaVl6?=
 =?utf-8?B?bVFhM0llcGxMU0l0OS94aXloeWhBRDRFcEd6ZmxnMUNsajhLRnpyOCtqQ203?=
 =?utf-8?B?bTRUNFh2RGZNYVprSGVFcDB4ZVk3NlNSMk1hY2k2ZmlUbWhKdEhtVGJ2NzR2?=
 =?utf-8?B?bVpoSG40Vmc0WjU2b3NIK2cvK3RDSWEvaldEaHQyTGZ3Rkh0dGpyVjFOOHYr?=
 =?utf-8?B?cTVQZjhpSHNuQlJ3cUNHV2VXems1algxSlhSTHYzU1Z2TjllVFFTQlQ5Tys1?=
 =?utf-8?B?WWt4VW5sYXhMYThMS1BONEhRQnQ3WU1NaWlSZGhOMHlpcE9UT2I2VHhDazJs?=
 =?utf-8?B?aG04cUZ2ZWgvOFNaUS81MEtOYVVYdHV1S2grdVV6TTlwR0lZZk5HQUxkSkV1?=
 =?utf-8?B?ZGxCQ2JWR1lwQkV3RURMdjIwYkhoRmx0U2pwMlpmSU0xaXhiYWwwTDZLbDZP?=
 =?utf-8?B?L2tKMVFuUFlqeVhCRjlkZlJTeXF3Nkg0ejNDTEpkM3JKY2MrMjQ2NG42ckx1?=
 =?utf-8?B?aW9paVphbVdmUWlHZzhsSEl4d1JwcENyVVBiOVZ2Z0hZVlVoMVVUQ3V6MnF4?=
 =?utf-8?B?NkJoUEpwTUY5a3lSVXlpYUNWOEFPOUQ1WVlGWmwvc1BHL3JHY3BnMitESEtl?=
 =?utf-8?B?T2p3UURUNnF5Mm5WZW4raytqZ00zL0pYU2Z3b3o0TWhheHdRVE5JdGdZZVcr?=
 =?utf-8?B?MjZYNlhaZjZWakJVUU1IWWhLTlF3Rm1EdFFGZitVeXRUYWNjRFJtcUtiaCta?=
 =?utf-8?B?MkZTYU96dm9taWxZbXRoalJEUkdQZnNvTVdIZVEwSWJGY0tjdGY3NlZLcE1P?=
 =?utf-8?B?TDYrQTVZTFRqbElhQ3llOHJKY25qYVdrcmQ0M0FVV1RUMzAyUCtFNnZ3ZTAv?=
 =?utf-8?B?a3pOd0RaKzN6ZnNCTzdpTTk4dUM2dFdBVUlhQmgxY1NnNVBGVkF1OXEzWEF0?=
 =?utf-8?B?MnR1WnRiQ1F4T3hQK2xtTmhscmpyTGVIdmlZYmpCV0dCT2lrbmlFRzBiR29o?=
 =?utf-8?B?eVJQelcrUjVYS3JrSDg1aHBIZXUxVGo2VU5JOUY1ek8rcDFDUzM5VHdCWkxO?=
 =?utf-8?B?RGZYUEJlelNlcGZYUnJGYVFUWVhaakJCWjNEaEx1TnFVbG5Ha0lSWVc2RXZ6?=
 =?utf-8?B?WS9ZMkFoNG9NTlo1cEx2NFJ5dTY0N0VDN0EwaU5HSHUxN2NMQW5yUGJyRmJu?=
 =?utf-8?B?YUQ3alRkUGZxSENaVnRXb0NWcStxS0lVV1FoQ1FJa3RsK0htNXR1bnk1N3Az?=
 =?utf-8?B?QUJoMVovOGVzOHFMM1kvdU9DUUtZNDJTSXp3OHNMN2JXdHJ1ODNtT09Qbjhx?=
 =?utf-8?B?aWpVc2xZRDNDWGJkQ0d0UnlkcUxRWWJLbEJmY2pzeFhxN3E0bDllVWF3NVFW?=
 =?utf-8?B?WjdmN2NUaDJrRkxUL3J6QWhOQ0IwSUNrN3poQzBnTDVkNE11d1hEMWhmbC85?=
 =?utf-8?B?VHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sEwSNDTi2vPQO2G4dmMUi7L055K6lopTxdLeCJLjzLpKHzLrmhO07mRT0q56tSQwEdW5dxW95yiyyz67gwogSL4kelG3FhI5szpXO0/kiPxLP8ZxLuMreuEgp7EvJaPkD/LzXcKCVeentPu9An3aU145naNK3SKe0s9tKVUJ4GtwUHNp6pQ0FCHOQhFjm41B1RCd+PzbmMg1Xjf77URGHYEOt6wK3Hc8Sd4krkXGCQzVXWiTLIInGswDUh4Df+MT999Nlcv/K4yp94HxaTFObF1uf9br1uh1kNVr1EoGlZcnOtIXXYqQIeGCeCQxK3G5YZjVvkI+p3HtWFIRxyd20w2UkmlsWSOFn4mwAP7t4qZhF227rxwaRfFbGMOZ0Zz5oswjj6pYmRTl+abTyxqn83j2gEq5skgpdrizPcrBn3Xzcy1/SDhpkU7QvjL4ZZKj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:36:48.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb99473f-8725-4550-95d0-08de634acf06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7354

Moving conventions in separate files.

Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v4:
 * updated sob-chain,
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

