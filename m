Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883551F2371;
	Fri, 12 Sep 2025 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688341; cv=fail; b=ibxuv4ZG6ZA921wyWdxtJb0u3BXY75dm6yrDRH04NX05xJ9TDJ8getZ1rE5WHfMVF3xwNIiBp29YXBgvrBGo/vCvbjfb+MTbfnMzdbFTmtrnvHSFE4Cl99l3rVLpKn/ZJxg6rthLIDHDWJK7/pAWUK7eB8MRElSy8qfK9+6oc0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688341; c=relaxed/simple;
	bh=cyPnX65BWft+hrpOc6ZsiNMj3NgiRsaWjPVAFfj/X0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgLkrtTc6nxPjj+MBh/5DKfbbgcfOAKT9xgQVlbYJ1dA71Al/PT095qfNaIQgUqcPHW1+FBxmsruj1MNiERg6stV49zFM70WGwkSUoZyTtROxAN1Adh1yLwc3eabvywZ0sk36BawqieLt1og2NjOVg/OypCom1Q/kMtynKqhe7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PNMR44Bf; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PNMR44Bf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkhOzDdZsShUrZTwuv8MBX+XBka2/FGP5pOSo7XFiDPHytdQ/hSsMMRhBMyV9NPd9XiK/Wy59sz+boxnsgE1d6HE/FJjPxkibenHa/vVeQrZWWwlu6ZACl1RXv583EVfx0aMpTmcVlHmip13zKATF77Sb7IyUUQ6ni0esg7h2lscaZ8SopD48Q+vkVKqnlgOv6OAs46X2Iyd0UeI6nZ+XRmflFAHY/9CHx7cGidj2+2OnAflnCNj7sOnb6C6IYrQGblnpZb+ekwVEx9whMM4pBjhiiAQHoOWEBBOYwr+MoS4OKt6y06MfAaddgmWQYfuanXeJPByXWgOcOR1aVqqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj4k2kwNN5u6FEnLVppUBxjfMCJl7u+F27i0U3GC3mI=;
 b=TwH2v+6nFbkqH5S/iOOlUCtcruKP7EpaCVTYQjAP7BI2nugT+cJFPE3SMHSDNlz7/TXr/u3yNeqCFQczXNePd+danc/DQ8M1P8p6gD+TYrciAgHJhzQp0kl/clAC74OavTz+sUZPQDq69jNK16A/MAKUMbeOEtFWAoyOTdby6sk/h1XG7H8axlOGcqSEXHYIgXgpBOTxtTkz65oxTPjQdq10qzFxvw3ugD3hQl/pAG8jzq0w1wW9cJcSlqnLH3GB6gcDVHTCMbgLX7AKjue1G3+1cVmgctWjGdiQQZD8Dn+q1Hjio4Jly5t42a4f9DhYkb+dbAoNLWGDqiN+MboDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj4k2kwNN5u6FEnLVppUBxjfMCJl7u+F27i0U3GC3mI=;
 b=PNMR44BfKTlyhgsEkoC71euLmsq2PLVw4jh24h5GaD/ENiq8AgW0A+NcsxUivBYPll2JafNyvqqkONwZNIM0mBMDquBJq8MYCvxKQB/86wzPOh+pTfBQ63H2qiPEQx9BkaQtJZ3Yui+dbvsROkkak6dFDbOXR+h2A5yzDHU73Bg=
Received: from SN4PR0501CA0013.namprd05.prod.outlook.com
 (2603:10b6:803:40::26) by PH7PR12MB5975.namprd12.prod.outlook.com
 (2603:10b6:510:1da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:45:36 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:803:40:cafe::c1) by SN4PR0501CA0013.outlook.office365.com
 (2603:10b6:803:40::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 14:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:45:35 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:45:32 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 00/11] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Fri, 12 Sep 2025 16:45:02 +0200
Message-ID: <20250912144514.526441-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: a46233f8-faa8-4935-754e-08ddf20b083d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGdNd0NTSzJseU8zQkFGK2pZd0tIcmFVUXFIVjgvbkZZcU1saGo4ZDk3eVln?=
 =?utf-8?B?UnBNNk56bXRjbVh5YWw1cHFScFRQb3JEYjloWjhKQ0ZKdUI2dE1FOGlUdjNq?=
 =?utf-8?B?aTZIMTRpc3drOEF3TU41eFIzM0FBMmpTY3c2TVBSb1RPVXh0VmlLbUJaUW1U?=
 =?utf-8?B?aTZHK0I5SjVxS1ZHL0xTOVp5UUFwQmFnM04vcFlqVDNVb0d2WWFWTG96YW9l?=
 =?utf-8?B?NUNKSW4wTFI1YXE4TWNQMU1KekpDZDhNYSs1QWtSdU45U3dqQmNpdVJ0a3Jm?=
 =?utf-8?B?NGZZdFRBdDd1WVFtTStXSS85b0NSYkhBUVdNYk1sNjBhSjVwRWRia0dLQXRT?=
 =?utf-8?B?OVV6YStmdm44Y09oNW1nb2JvT2J4Y3k5UjZEV3Z4TkZEVUppVHBXbzZQZXdO?=
 =?utf-8?B?R2RvMmJrcDFCeTBWTy9rR1Q2a0V6dkYvcG9RQ3ArWGdYS1pjZEZ0RkdSK2dV?=
 =?utf-8?B?VHRVWnNQSEU3cmxHd2pTaG9Nd0RVMDFOb0Z2dTRWNlVBVDVXRGZKSlhGOUEr?=
 =?utf-8?B?cmZKUHV1RkVRa0RabTdVdno2a3lyL0ZvOC9uSld0MkI0eU1jYW56YUxUb2li?=
 =?utf-8?B?QnEwejVOZzN3RWV2ZVFQbExxUU0wOWxzTTArZkk3WnFCekhLNEtJWk1NVHQ2?=
 =?utf-8?B?cmwvVGtPM0dsQTNDZXdkU1dpeW5DYXRhYit5REU4OGdwMWk1cEE5c0lSdEpI?=
 =?utf-8?B?ZHJEcnhGS2wwSDFGV3FMNExPS1BPNWdFUjdEZGIxOFIyUkhtNDN4VHZoZlE1?=
 =?utf-8?B?Rkl2dGRaQ2VEY1ZZQmVQRUN0NG1ENUkvSkR4QlA3c0NTclltL2h2NG9IdTgr?=
 =?utf-8?B?Q1dZaTFSbENEUmZqbkIyNmh4eFJTTW5YWDB5SklKV2hpUlhnaElobE9Qa0d1?=
 =?utf-8?B?d0c5OFNaTUZUYW81N3grVGV1Vm90NGJ2RERweVpEV2ppdUdsejQyRFkzMk5s?=
 =?utf-8?B?cXAxcE9YcnU5RlczU2diaXFXbWNxTlFNZVJUbEozbVYrMGlhZDh4cUxyVHpp?=
 =?utf-8?B?dVJtbFhLcHNRU2hVZ1FhdGRCQjhzcE1TSzQwWTBCVG1BVmJpdW1QWmlka2Vz?=
 =?utf-8?B?bVZRMHlSVTErcEt6QzNhUzNJTVYwb29STWd0TTZGT1dHZE4wenVRZCt3ajl0?=
 =?utf-8?B?TkludUpTaWUxeEJkU0FvcVA5TjBsdzdMSEZjT0VSUWxvT2ZIalQwQm5SeDFO?=
 =?utf-8?B?K3lLamhIZWIxZ25JSEZuQ2NQQ29ZcThGdDRmdWFETEpvVUlqWmlIUjhOWm9v?=
 =?utf-8?B?R1hMdlBtTXMwZG01N0tCM050YUF5enljdkE5ai9vQkFnVGhpY3I4d3FJeUVa?=
 =?utf-8?B?d0luajZNbDVST1QraTA4Z2Z0Q05NeTJrUmRGREFRVG1ucE9mbll2dk1wWmlT?=
 =?utf-8?B?ajhva3hXNTJMR3ZLZVRiTkJBSUxEUDNNOVR6c1prZnVRSG5tTnFjdGg0UEt2?=
 =?utf-8?B?MWRtWTZOYWhST251OFhpVkdyK1Frc3F0b25tOWNQTFVxWk1vTzNLRVhTNW83?=
 =?utf-8?B?cGlKSnhIdldFRHd0clFFVDNxU1VKNndGRzNOM3NFbjNsZ2h1bmVLcWRwaVJM?=
 =?utf-8?B?OTdKM1ZPUG9vTGtFZ1lqaGZaTzR0andodVBQbGZvNXhhMVB1Ly9zNFJMcGZr?=
 =?utf-8?B?aWNiR2Z0M24yemttbkR0QkpTSUhJSDBWVjNQYlNhSEk0eVdGVkFmelFFcmJa?=
 =?utf-8?B?VHVvZjF4ZmJxekJLVGtVNDMzejBUb0JnTENxWEZzYkc2ZnpXLzhrOHZ1QWNy?=
 =?utf-8?B?TFcrNUc5anZBVTlndm5yMVRRdGgrZ1hwSFdyY2RTR3gzenpiY05TZWsvYUtF?=
 =?utf-8?B?MytZdXpVRCtCRnlZOHJiNkgwM1ZFQTdjVW9LM0V1ZVVPMTlCNThnQlVlc1dJ?=
 =?utf-8?B?dVMwL2F0MGloTnNjc2xYNnFtMXloUWlocVd3OWVKOEZvclY1R2REVzAyNVVC?=
 =?utf-8?B?ZlhHNU8xN3BhRCtrVVdnZjJ2MkV2bEpxNSt6V3pxbkJobXRBVmxjVWxKNTEw?=
 =?utf-8?Q?lQaMnN/O5FKYtnnhNqhYcJFtmId5+g=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:45:35.2586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46233f8-faa8-4935-754e-08ddf20b083d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975

This patch set adds support for address translation using ACPI PRM and
enables this for AMD Zen5 platforms. This is another new appoach in
response to earlier attempts to implement CXL address translation:

 * v1: [1] and the comments on it, esp. Dan's [2],
 * v2: [3] and comments on [4], esp. Dave's [5]

This version 3 addresses the requests to reduce the number of patches
to a minimum and also to remove platform specific implementations
allowing the Documentation of CXL Address Translation Support in the
Kernel's "Compute Express Link: Linux Conventions" document and an
update of the CXL specification in the longterm. This patch submission
will be the base for a documention patch that describes CXL Address
Translation support accordingly. The documentation patch will be sent
in the very next step.

The CXL driver currently does not implement address translation which
assumes the host physical addresses (HPA) and system physical
addresses (SPA) are equal.

Systems with different HPA and SPA addresses need address translation.
If this is the case, the hardware addresses esp. used in the HDM
decoder configurations are different to the system's or parent port
address ranges. E.g. AMD Zen5 systems may be configured to use
'Normalized addresses'. Then, CXL endpoints have their own physical
address base which is not the same as the SPA used by the CXL host
bridge. Thus, addresses need to be translated from the endpoint's to
its CXL host bridge's address range.

To enable address translation, the endpoint's HPA range must be
translated to the CXL host bridge's address range. A callback is
introduced to translate a decoder's HPA to the next parent port's
address range. This allows the enablement of address translation for
individual ports as needed. The callback is then used to determine the
region parameters which includes the SPA translated address range of
the endpoint decoder and the interleaving configuration. This is
stored in struct cxl_region which allows an endpoint decoder to
determine that parameters based on its assigned region.

Note that only auto-discovery of decoders is supported. Thus, decoders
are locked and cannot be configured manually.

Finally, Zen5 address translation is enabled using ACPI PRMT.

This series bases on cxl/next.

V3:
 * rebased onto cxl/next,
 * complete rework to reduce number of required changes/patches and to
   remove platform specific code (Dan and Dave),
 * changed implementation allowing to add address translation to the
   CXL specification (documention patch in preparation),
 * simplified and generalized determination of interleaving
   parameters using the address translation callback,
 * depend only on the existence of the ACPI PRM GUID for CXL Address
   Translation enablement, removed platform checks,
 * small changes to region code only which does not require a full
   rework and refactoring of the code, just separating region
   parameter setup and region construction,
 * moved code to new core/atl.c file,
 * fixed subsys_initcall order dependency of EFI runtime services
   (Gregory and Joshua),

V2:
 * rebased onto cxl/next,
 * split of v1 in two parts:
   * removed cleanups and updates from this series to post them as a
     separate series (Dave),
   * this part 2 applies on top of part 1, v3,
 * added tags to SOB chain,
 * reworked architecture, vendor and platform setup (Jonathan):
   * added patch "cxl/x86: Prepare for architectural platform setup",
   * added function arch_cxl_port_platform_setup() plus a __weak
     versions for archs other than x86,
   * moved code to core/x86,
 * added comment to cxl_to_hpa_fn (Ben),
 * updated year in copyright statement (Ben),
 * cxl_port_calc_hpa(): Removed HPA check for zero (Jonathan), return
   1 if modified,
 * cxl_port_calc_pos(): Updated description and wording (Ben),
 * added sereral patches around interleaving and SPA calculation in
   cxl_endpoint_decoder_initialize(),
 * reworked iterator in cxl_endpoint_decoder_initialize() (Gregory),
 * fixed region interleaving parameters() (Alison),
 * fixed check in cxl_region_attach() (Alison),
 * Clarified in coverletter that not all ports in a system must
   implement the to_hpa() callback (Terry).

[1] https://lore.kernel.org/linux-cxl/20240701174754.967954-1-rrichter@amd.com/
[2] https://lore.kernel.org/linux-cxl/669086821f136_5fffa29473@dwillia2-xfh.jf.intel.com.notmuch/
[3] https://patchwork.kernel.org/project/cxl/cover/20250218132356.1809075-1-rrichter@amd.com/
[4] https://patchwork.kernel.org/project/cxl/cover/20250715191143.1023512-1-rrichter@amd.com/
[5] https://lore.kernel.org/all/78284b12-3e0b-4758-af18-397f32136c3f@intel.com/

Robert Richter (11):
  cxl/region: Store root decoder in struct cxl_region
  cxl/region: Store HPA range in struct cxl_region
  cxl/region: Rename misleading variable name @hpa to @range
  cxl/region: Add @range argument to function cxl_find_root_decoder()
  cxl/region: Add @range argument to function cxl_calc_interleave_pos()
  cxl/region: Separate region parameter setup and region construction
  cxl: Introduce callback to translate a decoder's HPA to the next
    parent port
  cxl/region: Implement endpoint decoder address translation
  cxl/region: Lock decoders that need address translation
  cxl/acpi: Prepare use of EFI runtime services
  cxl: Enable AMD Zen5 address translation using ACPI PRMT

 drivers/cxl/Kconfig       |   4 +
 drivers/cxl/acpi.c        |   8 +-
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 138 ++++++++++++++++++++++
 drivers/cxl/core/core.h   |   1 +
 drivers/cxl/core/port.c   |   8 ++
 drivers/cxl/core/region.c | 239 ++++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h         |  17 +++
 8 files changed, 368 insertions(+), 48 deletions(-)
 create mode 100644 drivers/cxl/core/atl.c


base-commit: 561c4e30bff93b3c33e694a459f8580f8a6b3c8c
-- 
2.39.5

