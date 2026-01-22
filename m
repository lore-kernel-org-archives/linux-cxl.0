Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846B3904ED;
	Thu, 22 Jan 2026 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102727; cv=fail; b=Fw6y4AjM3m2YNOhzF/2jxZBkJXVKG4nmv+9GRm3RrevblAAKMBmPkqTlYmw+Tp3CE92sPXnq9eIu8vMzbfQkB/0JH/lM6dO2LxIESUW0L6AR380wQUemIc7zs6WjynO6PDOUpmZ+0dc4QRNEvwc0pb+DeTSW7ViVlrvcTwRf/Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102727; c=relaxed/simple;
	bh=jD2F8mYItX5Hb7iUAKv9SVnZ06CTXiq7Qv2TjKswLuo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nO7orzm7jc+A9Nk0Uik4NQzesucooZcdo7YDOtbwVbbc4bZUpi2NFHSsbUFuJzzg4sK8uy7MwIjxhixwFVMaK4OfEkIyl46btPNkyyrvLqhVsa0x/Mgvdc9oHLoItyV/3kNQ0baKt+v7kyDnFnVyGqrPTnRHgVTorCPaHt4HmSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=44ObUa+t; arc=fail smtp.client-ip=40.93.198.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="44ObUa+t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOrwfsYToZCCtYsy5NlNMqJMog2saOik4dhldH46b5uccVEmeaVRPLefFvVsAvinI+N9yVxf04YiNgAVpjuxXBdKn04/rOw1irfI2gO/BmJE107LMS0wCQHAEoo2FQfyENmeuxn78EYv/XcXjGyH61OzHrInUY1UURHi04pl3WwCDZE359QFbmxMwLGLmZ3PpqI2t+JthU/OuKArO8zfeq3jvXd4H4F99a6LKrLyC8xlgIEXjTM0zeD55bWIWHN9KijZqMUH300ZdnCFdbG3B+Fnt3KJ5QjK41q2EyuCRbtmadlZzu5f1b58KBEQNVTvFJ5sCBkeJoxszlxyADLYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyjeTEATgQrUe/y8m70zFyCFjamfBB0epOnuhoFkrjg=;
 b=pX4IGlb3gyAZ0JT9WUHbbGCuSjuUVaipg/+xO5REIbXzZiO8Q6UV2lTHu12UhJjgOEHWXq1v9RhkAC1K6wAIn5cp+qF4eIq58Hz8q9eCgmYnU2dRSatJlyT7Y2wJ6ZCnmI1WLzYLtsf51fcXSbEcSVbaIlo2o5fmmByMkpTwDGs8/vMT9qcUn0KRna3x1HWtiheiFNCMbjRmzHHyQVVq9hFGChemp1/qXoPfGTVK7gb5/Q5P3rFCDxBIHGEBrCcMAGM9a47rW4CBOJDJKr/ML8ibnjW3bK5sJrEKy1Xztl5DullCFVhJ3S6HBw2zAsAUWevS5NfQqjXEj5/Emuk5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyjeTEATgQrUe/y8m70zFyCFjamfBB0epOnuhoFkrjg=;
 b=44ObUa+tqsIqsiHsKiEAdvwGG7d/L0SWoNAnLz7kTyJYqhCHDFxKrEXBZXgERueyb+lIYfnJwwShuAV5CUm0Mk1KWioQcMwKLCSHNPfJBYpz6wyyNEj5Pp8vzFKWlcl/v7+G/rm+jvpUYNKJ7w5AT2yW2rM7Fu0cNN3CB9Fwc4c=
Received: from PH7PR10CA0021.namprd10.prod.outlook.com (2603:10b6:510:23d::20)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 17:25:02 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::bd) by PH7PR10CA0021.outlook.office365.com
 (2603:10b6:510:23d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 17:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 17:25:00 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 11:24:55 -0600
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
Subject: [PATCH v4 3/3] Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Thu, 22 Jan 2026 18:24:29 +0100
Message-ID: <20260122172432.369215-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122172432.369215-1-rrichter@amd.com>
References: <20260122172432.369215-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a9a978-7040-450d-44ab-08de59db2c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm55TGJSSm10VGwyTDk1d3VYYXNBTmV0VSsyT3ZNRVZvbzVrejBnVGNKbXIx?=
 =?utf-8?B?TnRkNW9hdkthQWY2WHZEQlMwVG1Gc3AwdnhrMXpOVSszNmhQM0J6TmtTUzBj?=
 =?utf-8?B?T2FpZVk2RUcxY0ZybEFQaGN1dkY1UVRPRm9PY2NKM0p5NzJGeDNmQlVkNUtI?=
 =?utf-8?B?MitMUVdTY01zZnhHZkdtUW0zb1dJanl4T0ZrRU1JZ2dsZXZ1bCtiaDRZN1RL?=
 =?utf-8?B?Uit4Y1gvWlo4N1NOZFNnWllFT3p1QUl4RjdEZlhRSTBrdTFBWGJ0eHk1cjVK?=
 =?utf-8?B?aEg0d1FhQ1JraW1paFRLU28zTW9oZmtKZVpyRmJaOUFCWWJTZDJzK0dLWEMw?=
 =?utf-8?B?bWIyMWVoU1RMcFRXckRYcDlNLzBNSkNaeW5QOFUxZmQzNm00ZDlta2FUWkRa?=
 =?utf-8?B?cW5DeVdSYmNUU3V5Zzk3K2h4YTVjeURKNjlZck1OeTk4WnlrWW5UMGtIK2Jy?=
 =?utf-8?B?ci9EVk5CYXVOMGpCekNOaVZ1UkJ4eDFZczdCelRObFRkMWI4V25LNjNqNmJO?=
 =?utf-8?B?aHdzNVRBWXB2WUdEN2tHYXd0UnhSUDFLL1gwR0NBbDQzTTVIMHhvTFlYNXNS?=
 =?utf-8?B?YkZ1eWI0KzhpL2VWV3J3T3lmNnN6TWNJb2xJb3g3YlNIVDBiekVSYUFqMEl6?=
 =?utf-8?B?elptUEQvWUlDSk9lenZIb2RBQzdQY1lhY0tYL0c2Skpaamx1VTNiYnkwNUlx?=
 =?utf-8?B?M1FRRG5BOFlLQjhlWlltQ2hLSFZWMlg4SS9SUGtWNjZtemlVRFFMcmRMY2NT?=
 =?utf-8?B?NldIcHVKMzkvZ3ZLWUJSYTdLMXI2K2p0QUpHVm5QUlc4dTUyVG5KODNaNXNL?=
 =?utf-8?B?NlowM0pzRjhZUFFVRG1KU01uOXc2aTBVQ21LY2hwZU9mNXhKYVExUGhYN1M2?=
 =?utf-8?B?WjRPRG9sb0tRbVhUM2JTWTlWVEJSWXBINEVJaUdOS0xuR1pEaUxFQkptbjBw?=
 =?utf-8?B?cEVVb282aFBMMHYvakkxUHlUQ2NkcXh1S2hyaUZnaU5uZDNsVFI3R3R4U2Jy?=
 =?utf-8?B?MEpMSjJDd05ndm80WXo5Mm1NYzM2ZS9IUFN1R0IrVVVvZ0xqM1VmK1BpVXow?=
 =?utf-8?B?RDRtSVlRaFdUVVZlYWJEZWo3dEQ0NmhVZ2dBRWVrZG1kSHozYWpvdlQ3VHNj?=
 =?utf-8?B?WGw4L0RUSk5GcVZ6aUYrWU1XdDkwWDBFRy9sMFY3U216T0Q2OHcxTy82dFdo?=
 =?utf-8?B?YmNWMzdjd3dLdVhUOXluWG1iWTlYMnEwNWNTbXlSRktiOFhZYlJUYlA2WDBF?=
 =?utf-8?B?VWJnc3hvT2NhTDhJQ3pjT2xlVWQzRjF1Slg3Y2F4OEk2cVJxWXMxcW42N3lD?=
 =?utf-8?B?NmF1bXZKTTRRVlo4Q3F5TXUwU3hRRnNrejkrUzVqdW1uVktrUW9XSjNTQ1Er?=
 =?utf-8?B?UmlidTB0RTBzcmo2ekRhTFM2WWY2RnFOZXoxUTF5TFJLakhWRVFzcmlnUG8r?=
 =?utf-8?B?ZldGRjhBSThxZ2QrWW9xeDRyTm03RTlJUVJ0aXZEUjJld2VTbWVsMjlWekhw?=
 =?utf-8?B?V2RDVjc5RGswNVhxWFpONVFZU1paSTEwQXBjc3Nsa2x2bU9xOUtBaE01Z1RG?=
 =?utf-8?B?aXFKODIrVWpPTzhvZjg4QkRkd1lvQXNUK04ramcvcjI5SG02dDByWHZGRjFK?=
 =?utf-8?B?ZktTQVNnUVc3NW1BS1dsN3oxZU8rbjZYY01yU3dYcE9JbXl0YUk1aXM4c1Va?=
 =?utf-8?B?NjRVKzBCNjJCZHFRTHgzd011bDhkNkJVU1V4eU4yL3JIWXA0aVBKTzRGK2hy?=
 =?utf-8?B?VXY2bDV3ZlNoMlByZlVxb21KR1Q4MTJybW16UGx1TTFJaDVQdnM0OVc3VFAz?=
 =?utf-8?B?NXNtb3p1RU80NDRuN1UybDh3NTlSV1kvMHg2dlFvUXFKK3dWMStLZlRMelk3?=
 =?utf-8?B?V1R3Y1ltT0JoeXJQU1F6YTJ4dlhkb00wMlFYc2VxZlZZZ21RSHI1a3ZVcm82?=
 =?utf-8?B?MFQ3QXNuVU1jdVVCNjFhdG9Qa3V1U1FYV0R6TVRGRmhVbms4N3ptV0t1Qm1S?=
 =?utf-8?B?czFPOUxBQXNERS9DNHFmdG5ySVZIcWJ0V0RpTjlLWnZtNXRuTUp5eTdIRVc3?=
 =?utf-8?B?d01VWjNYQVhubFFTQXhyanBSM3E3bnhrMnZWVW9oSUxia0ZpNlJWTkxmeXB6?=
 =?utf-8?B?VjZ0bU1RMzVwVldYdkxKZi9QMlBPSWZubzM5cG1KWWxSNitWQUVGWUJ6N1py?=
 =?utf-8?Q?WbAnAJv1WWS/u9rEsSgx8S8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 17:25:00.7430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a9a978-7040-450d-44ab-08de59db2c40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492

This adds a convention document for the following patch series:

 cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement

Version 7 and later:

 https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/

Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v4:
 * updated sob-chain (Dave, Alison, Jonathan, Dan),
 * added additional spec change for Normalized addressing and _DSM
   definition for address translation (Dan),
 * revised the entire doc and made small format and grammar fixups and
   wording improvements,
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
 .../driver-api/cxl/conventions/cxl-atl.rst    | 272 ++++++++++++++++++
 2 files changed, 273 insertions(+)
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
index 000000000000..26429fe80ec9
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
@@ -0,0 +1,272 @@
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
+- Robert Richter, AMD et al.
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
+This is described in the *CXL 3.2 specification* (Table 1-1, 3.3.1,
+8.2.4.20, 9.13.1, 9.18.1.3). [#cxl-spec-3.2]_
+
+Depending on the interconnect architecture of the platform, components attached
+to a host may not share the same host physical address space. Those platforms
+need address translation to convert an HPA between the host and the attached
+component, such as a CXL device. The translation mechanism is host-specific and
+implementation dependent.
+
+For example, x86 AMD platforms use a Data Fabric that manages access to physical
+memory. Devices have their own memory space and can be configured to use
+'Normalized addresses' different from System Physical Addresses (SPA). Address
+translation is then needed. Details are described also under x86 AMD
+Documentation/admin-guide/RAS/address-translation.rst.
+
+Those AMD platforms provide PRM handlers in firmware to perform various types of
+address translation, including for CXL endpoints. AMD Zen5 systems implement the
+ACPI PRM CXL Address Translation firmware call. The ACPI PRM handler has a
+specific GUID to uniquely identify platforms with support for Normalized
+addressing. This is documented in the *ACPI v6.5 Porting Guide* (Address
+Translation - CXL DPA to System Physical Address). [#amd-ppr-58088]_
+
+When in Normalized address mode, HDM decoder address ranges must be configured
+and handled differently. Hardware addresses used in the HDM decoder
+configurations of an endpoint are not SPA and need to be translated from the
+endpoint's to its CXL host bridge's address range. This is especially important
+for finding an endpoint's associated CXL Host Bridge and HPA window described in
+the CFMWS. Additionally, the interleave decoding is done by the Data Fabric and
+the endpoint does not perform decoding when converting HPA to DPA. Instead,
+interleaving is switched off for the endpoint (1-way). Finally, address
+translation might also be needed to inspect the endpoint's hardware addresses,
+such as during profiling, tracing, or error handling.
+
+For example, with Normalized addressing the HDM decoders could look as follows::
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
+Note that the endpoint interleaving configurations use direct mapping (1-way).
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
+The corresponding CXL host bridge (HDM) decoders and root decoder (CFMWS) match
+the calculated endpoint mappings shown:
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
+The following changes to the specification are needed:
+
+* Allow a CXL device to be in an HPA space other than the host's address space.
+
+* Allow the platform to use implementation-specific address translation when
+  crossing memory domains on the CXL.mem path between the host and the device.
+
+* Recommend that the platform provide a method for the OS to convert device
+  addresses to SPAs, such as a PRM handler or _DSM. Document _DSM as the
+  preferred method.
+
+* Specify that the kernel (Operating System) determines Endpoint SPA ranges and
+  interleaving configurations using platform-specific address translation
+  methods.
+
+Benefits of the Change
+----------------------
+
+Without the change, the Operating System may be unable to determine the memory
+region and Root Decoder for an Endpoint and its corresponding HDM decoder.
+Region creation would fail. Platforms with a different interconnect architecture
+would fail to set up and use CXL.
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
+The following describes the necessary changes to the *CXL 3.2 specification*
+[#cxl-spec-3.2]_:
+
+Add the following paragraph to the end of the section:
+
+**8.2.4.20 CXL HDM Decoder Capability Structure**
+
+"A device may use an HPA space that is not common to other components of the
+host domain. The platform is responsible for address translation when crossing
+HPA spaces. The Operating System must determine the interleaving configuration
+and perform address translation to the HPA ranges of the HDM decoders as
+needed. The translation mechanism is host-specific and implementation dependent.
+
+The platform may provide an interface that can be used by the Operating System
+to translate a DPA and determine its corresponding SPA, such as a Platform
+Runtime Mechanism (PRM) handler or a Device-Specific Method (_DSM). Section
+9.18.3.2 defines the *_DSM function for DPA to System Physical Address
+translation*, which is associated with the CXL Root Device (HID = “ACPI0017”).
+It is the preferred mechanism for the Operating System to translate addresses."
+
+Extend the following table with this _DSM function:
+
+**Table 9-30, _DSM Definitions for CXL Root Device**
+
++--------------------------------------+----------+-----------+---------------------------------------+
+| UUID                                 | Revision | Function  | Description                           |
++======================================+==========+===========+=======================================+
+| E105242A-CD04-F1A9-2D50-B3B870D67396 | 1        | 1         | CXL DPA to SPA (see Section 9.18.3.2) |
+|                                      +----------+-----------+---------------------------------------+
+|                                      | \-       | all other | Reserved                              |
++--------------------------------------+----------+-----------+---------------------------------------+
+
+Add the following section:
+
+**9.18.3.2 _DSM Function for DPA to System Physical Address Translation**
+
+"A platform may be configured to use 'Normalized addresses'. Host physical
+address (HPA) spaces are component-specific and differ from system physical
+addresses (SPAs). The endpoint has its own physical address space. All requests
+presented to the device already use Device Physical Addresses (DPAs). The CXL
+endpoint decoders have interleaving disabled (1-way interleaving) and the device
+does not perform HPA decoding to determine a DPA.
+
+This _DSM function translates a Device Physical Address (DPA) to a System
+Physical Address (SPA) for a specified CXL endpoint. In the host's address
+space, SPA and HPA are equivalent and the Operating System may use this function
+to determine the HPA that corresponds to a device address, for example when
+configuring HDM decoders on platforms with Normalized Addressing."
+
+**Table 9-32, _DSM for DPA to System Physical Address Translation, Inputs, and Outputs**
+
++--------------------------------------+-------+---------------------------------------------------+
+| Field                                | Size  | Description                                       |
++======================================+=======+===================================================+
+| **Input Package:**                                                                               |
++--------------------------------------+-------+---------------------------------------------------+
+| CXL Device Physical Address (DPA)    | QWORD | CXL DPA (e.g., from CXL Component                 |
+|                                      |       | Event Log)                                        |
++--------------------------------------+-------+---------------------------------------------------+
+| CXL Endpoint SBDF                    | DWORD | - Byte 3 - PCIe Segment                           |
+|                                      |       | - Byte 2 - Bus Number                             |
+|                                      |       | - Byte 1 - Device Number Bits[7:3]                |
+|                                      |       |            Function Number Bits[2:0]              |
+|                                      |       | - Byte 0 - RESERVED (MBZ)                         |
++--------------------------------------+-------+---------------------------------------------------+
+| Reserved                             | DWORD | Reserved (MBZ)                                    |
++--------------------------------------+-------+---------------------------------------------------+
+| **Return Package:**                                                                              |
++--------------------------------------+-------+---------------------------------------------------+
+| System Physical Address              | QWORD | System Physical Address                           |
++--------------------------------------+-------+---------------------------------------------------+
-- 
2.47.3

