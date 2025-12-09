Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5982EFD81;
	Tue,  9 Dec 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304424; cv=fail; b=ZKpX7kdierueRy7YleAtcnND/C/DKCC42Bmip3VClYPgxOLPBxNwIiACLkpR+KoxPiI6F17gdCCApb3Ok5J7PEQCWKloPZ1Yj9pvVLEZSiML1sEiXxqm6+Ms2DrnIdv1n/NKno4z7bFCUGfIlbfFGS5kocOg6ZXPTETz1gkWTg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304424; c=relaxed/simple;
	bh=+cMW+EEC6IYZ/5Cyipj1mRHKQZLlKpSvueRyOb5l1Wg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXaXyG2FORBVpHbXeXTqc999Ixvyju6pUDp/iVbZqzsBFnQcxxmIc34edQPC5dUnxL1+/HxA7OBSb60+5QQBXC4LWd1trSE9jEhp9FkXrb14axVcutbQB7sFhsDJSiKttr4iXFhfu0EPca4CJD8s0I3dwn1k6YZX3UEH4+cLDFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1CYQhlNT; arc=fail smtp.client-ip=52.101.193.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1CYQhlNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0T4vH3mOdJ3qZmgBf2zBaey8LYybQDVf+usu5aUzW9aKk1Wy920D5vSL9+j2squNgNsXFd1LIBHvdH3x+XUkCHdknxfHLwKhOa2STOY/Bz1b/q9qwp2tIihTii2wkiB+RvNgRnc/Q2HmAFMbEK6pq6ZFI7OGP3OhrQEGuZ2JU9eC5OLDoCoTw/fR7pZWm9CdKlrJqRb8Hp+Tlriz2q6bXPnpUhZngekwRz2n7tnN5fqMYSwRiE6pWxn0qCBRe1s2M/MQ/G8jdU7QspqfL+6DKyKdYsv2uneCm2KR3NRCgeWDCTZDfxuTQ9V/85TznEOhWtvzZk1ZBip14MiCr20Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThYL5fTH0I2JiR+CE2VbrvpnnteUTKznQD4d/Hgg1eM=;
 b=safWLUonagbaN9mxwIjQcBgVrdt8C9wTk/R05u5/b1g5a2kkCRgQ7T7V5FtCeMu1IvQAizSGzt5HQBwzJbGW6dvM9axtgwqdH6DnPiMtZpbmw6OeKNuEDXU9EE6dWF8yhHYwqHwCutyuYWYT76h70CaeXUachJDsYrHisJ6LD3QUL1JO9bsxQjF8iFqzwplEik/qQ9+zr0JXrWKUsGNRkWMN/UO5l76/kRiEtn3HCrRgrNsc+7dRROAmFryJDLEon+TgXOiZn6uqFNeSCS4mN4vuQI+qixckoC6RXLKu+Tuh6V0wkV5kb+nrlwChlwEBcC3N2lNgdFlgT+rBlZ7HgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThYL5fTH0I2JiR+CE2VbrvpnnteUTKznQD4d/Hgg1eM=;
 b=1CYQhlNTUzvUqi5Ld1gGcIqKXLX+T/jbmGZ2lQcwmIfZ75nytiGvVsR0b765+4XaqEWcVIkfNP20n+vyq5HI3DFcAXFGrAkEoxzDYSlgGMgdFLMR77/9PFdgCuFf2GsVApTRl2gdrVkzlGLnBKC1f1TnGZUUbikHtU1DD6boN8s=
Received: from BY3PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:217::33)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 18:20:15 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::d2) by BY3PR04CA0028.outlook.office365.com
 (2603:10b6:a03:217::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.7 via Frontend Transport; Tue, 9
 Dec 2025 18:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:20:13 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:20:10 -0600
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
Subject: [PATCH v2 1/2] cxl, doc: Moving conventions in separate files
Date: Tue, 9 Dec 2025 19:19:55 +0100
Message-ID: <20251209181959.210533-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 942a8f35-2f42-49bb-640c-08de374f98f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TklvS0JpRnZaS3h4a1lGUmpvUitjWUhOU3BtY0R2bWY4QnRUWDh1QmRNdTNQ?=
 =?utf-8?B?S2w1TFRjSFp4WEx1WU1zYmsxeFNPUXUzN0xjSCs0Y0NCTEZRN0V6bXRDeHRl?=
 =?utf-8?B?cmREaEtQaFd5MWUzekFtditBRDVMMHNTK1QyTURSa0dPUlF1ZWJEcEFIcCtO?=
 =?utf-8?B?clkxbWJTMW1lWjdlSEp3Q0g2N0xXeEF1L0hIMVF1UFpRTnVxV2xXUVFIclFk?=
 =?utf-8?B?aFpBdTI5UW1tOC9RempTNEt6ZnRkalVVSURJdDI2R2lmYVBDdzFndGhEZVJ4?=
 =?utf-8?B?ZnJZRmRkSkk1Zm5pY2NsNFFDT0ZVMTErSFVlMmhQYXdpOWtDQzJ6RnYrQmRB?=
 =?utf-8?B?TmR3bXNFNlpyV0ZTWHhjN0RaRjlkUlJad0NoeGxxZXRxaHFpa1poWSszcDFE?=
 =?utf-8?B?Z0pOdUNoSk9IeG50QTg5ZjRWM2ZkSlI1UHdxR1BQMEwzNm12akYrOVlteEJK?=
 =?utf-8?B?MS8zNEV4Qmh2UGZKMDBEeXBtOTNxQ0p1QmNBVUhFcDhvVzVmM1lYUUg1dmNB?=
 =?utf-8?B?cTYzenVhcjR5U1ppMUJYcndqbG9UTDVoM3BYRGFFYng3cExEUXhBN2lLWTRj?=
 =?utf-8?B?bEVrSUZtaVgzNTJ6RWVhRThRbzNVS3dXMUlwZm5DdG9jZGZncTR0cGFDcXIw?=
 =?utf-8?B?MmhDR0VlakN3LzZVeTBObVptR1cvU3htZHRWcitmVzBRVGovemZ1UE0yMDlu?=
 =?utf-8?B?VnZ1MnJRRlUwcnE3cUZvT0FYcnRJWjFabFVVWWZnK2FDTTFROUQvbGNvOGZV?=
 =?utf-8?B?WktUcW4wYkNWWmNsQ25adXJhVGwwdURMeFJwYVZHQlEwNk5UOWJBNWUxTitU?=
 =?utf-8?B?bmJMamZqcjFVd25lTXBrQlVDVm5jVkdFclZHalA0VCsra3c1VGkvaTBuT0VB?=
 =?utf-8?B?bGt5ei9WVFNiMmVPYlVJVWpjdVc4T3hoRDk5RmM5QmJnSS9aSzlFU1pYc2tS?=
 =?utf-8?B?ckV3Y0JYb0pHSWZhR0JOQldzVEZuZzg2VGhubU5vMjhxcVowdWVHRFM5Rmk3?=
 =?utf-8?B?YXY2WW1uaVFCYnd6bjNud2JQS3RVSU5QZndwcm1velNQN1J5MEZjc2RvaU5Q?=
 =?utf-8?B?MTJjdG5KcXJjbVhLQU9wN1pKL0U0TmZ3alFlcFhtSVNxdk5rU0tDUm9YMGZt?=
 =?utf-8?B?WU40QlFVb1hBSGRodnl0S1hHSGdmUHZaMjVyeG1XRm9ONnZjTVJuSDdMSzIz?=
 =?utf-8?B?bjR4bS84d0NSamJCQlpuNjFnaUNJblA4OXZ5aUY2dFpZU0llMzgwdUJrQk5o?=
 =?utf-8?B?S1JnV21Ea3dTcTZtY1ppOVo5c0Q0Nm0zT2VWd1N2NTA0aEZRRXNFN1RFbTBa?=
 =?utf-8?B?cGxpMWFuQnlLNlF4Q1JrUk5Oait6SnptMHFmTUJCRXoxWmhVRXU4NW11Kzc1?=
 =?utf-8?B?TGpvUGw4UmF6ZTF5RlgrREdRWnc2cHlCZHdQakJ5SUhOTmpvZnl4ekh5R0pH?=
 =?utf-8?B?NWJrMi9VZ1JtMjl3MzI1WW5DMDRTR3JZL0R6YW1UNFpqWkJDMGhxN01IY1JV?=
 =?utf-8?B?RHc2Y0gzSnVLdFo0WUJ6anozQzJzWVhMVk83OUVsK2tFSWpSVjZQN0sxYkVN?=
 =?utf-8?B?a1VwcDNHWGd3SUVFMFQzVkt1RkwwU1R1YjVXdEd4NEZPbms0TmRqa2pUTFAz?=
 =?utf-8?B?U3hObEtiVGxmRFluNGc2Q2dKRmF6dExhTmhaUXJDZnNoekVzNXh4cnJVUG9a?=
 =?utf-8?B?aU80Wm9CbzVjS05CdDhPZm9KYk1QcEgvUFI3MzVCK2xoS3RZVCtYZkJscndv?=
 =?utf-8?B?NVJES2FjbldrcFpsbGZlLytZVS9RSi96VGh5N1lueEZGUnNheTVTV1NiVUNO?=
 =?utf-8?B?b0JmZTFGSUE0OHg1Q1dTUjNNNThLQWY3QVJUNEN0Y0c1SU8wRTdKdHFNUlk3?=
 =?utf-8?B?VG1lK0h3aVFHeVkzNUVPNFYzeFFpQWFZdWd1Y081NkpKbG9uUm0vWlU5RU9C?=
 =?utf-8?B?YWNXaHYydlljTWJlc0Zrc0REakNaeDB3ZTRFcmRmcVRSdlpwaU11Q3F5cjF0?=
 =?utf-8?Q?jToXpj4b1//8q70corwQZH4b28zsMg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:20:13.9824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942a8f35-2f42-49bb-640c-08de374f98f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

Moving conventions in separate files.

Note this patch removes the line to include:: <isonum.txt>. From Jon:

"This include has been cargo-culted around the docs...the only real
use of it is to write |copy| rather than ©, but these docs don't even
do that. It can be taken out."

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v2:
 * Removed include:: <isonum.txt> line (Jon).
---
---
 Documentation/driver-api/cxl/conventions.rst  | 183 +-----------------
 .../driver-api/cxl/conventions/cxl-lmh.rst    | 135 +++++++++++++
 .../driver-api/cxl/conventions/template.rst   |  38 ++++
 3 files changed, 179 insertions(+), 177 deletions(-)
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
index 000000000000..39a9ca87cf92
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/template.rst
@@ -0,0 +1,38 @@
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

base-commit: 9d887fa9036f64331038b48199ae07da89777160
-- 
2.47.3

