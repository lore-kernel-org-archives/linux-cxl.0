Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0C25333F;
	Fri, 14 Nov 2025 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080859; cv=fail; b=gmZLk6U+CtBMCyl8slx6UfkCLGZGuFT2nK6tqzz2AkICQBEJUyPADto5nd2p33amSFVKytOAt4+0uPVHh4/SIbRkmkHcg/zn5mP/FN9xODEEz87lKDDHh8gYT3Dvds8qnQOeK8m/17kT+NiQHA4lUsj2Ug6QPg66M1PiXzMY9KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080859; c=relaxed/simple;
	bh=yIDyq55ZESXQDm/ourM9S002/LLKUSzWeFjro/zaH+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvxWScNFFm6M/AQ9/Qn3DT0ELIH8+tq8iq9NkTG1LbkraQkIUxWGKeJ+FFbeih3/ktJ7sYsQRQrjbWy1Z0KD3UVh6srjFDiJMzHiowliTtrgx8clzLD5lsUCNJRpfMA/MFx7GPKnX47uUzGf8RwJWTfNkaVPdp6pBPJ6mhKGN+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q3uQY87l; arc=fail smtp.client-ip=40.93.194.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q3uQY87l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH0gf7KGrBehk3nGDhXhAoeTGrv8k/L481Pvbq3GRveGsEtaEamU3OV+f2aUtTsLbwWww/NuPJBcXtxIJRs6zN8fBRJLOocnvuEcg5ArOAo5M/Xssha0ZC8Oo3oXB/GZ11JjWzZtHtg7jKk/4mfBIJ4bJJ9Mzk2Fuvt8U/v2RjD5wfto8F6S+6UURI7RA0d6i5Y2y3UHSVaCbJE5YNZrEVThwOGG4UIbbnF7coUQMd1xMSiVqoIrQm3ot1ia3osTgWlMSmtCBQSDevt2LRbXJOYhkZE6aLuFRs1opS0jsCbNNgQ0MvupcNpS6/4j6P6QykDdeAj0uyv1k5ePGqO7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFmTwGpJIFoDu4QOt5hsiUWx2tioHli7/tnfcvQqdkU=;
 b=xNwdYOiTYoN5uChYrv0LvwF+z52P0E2jeeel92ldtJOefW2l1v3D7wNZXYO9CzsPDAdw6KB5N4dSPJOUH7mdkL5DVzzv6OoXPapaHCDFX7zv4sRvwPwbmkjVyUt7/5Hj6EGdYCkotDjTftBGF123WKXmcEf7rrsT4s56lZp9LOQJJjQO4HDzD0K/NBD6+/3eJNQaEK05LIfvNvEBy2RG8tNlYnNaKS1fzOQH7E+v9TsO46g5v4LulqvOrKfCBXBVretCCgQPAXOoaFLUZ+5fBNOOWO9mPvT7RcoY8B7oD8PfCin0JoRZ8wnt24f8KmCW1XZDtE16maAOkZBb/zIbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFmTwGpJIFoDu4QOt5hsiUWx2tioHli7/tnfcvQqdkU=;
 b=Q3uQY87lC6WEydKHHR1NGoB9/+mIjuExKuOAliQmoqFqK3Hf6eWaA3kJxe2eW3UdorEAR2C2Sg1UKZcpT3ioO4Rq++LTlW10FOnR8VE+5liQOrOsHv6kyNAO6CjumfOiVqsLqIsXl30TA3Xuavseeajt+E9t7VXkOwZBryhhYfg=
Received: from BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::17)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 14 Nov
 2025 00:40:49 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::55) by BY1P220CA0013.outlook.office365.com
 (2603:10b6:a03:59d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 00:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 00:40:49 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:40:44 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v6 00/11] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Fri, 14 Nov 2025 01:40:05 +0100
Message-ID: <20251114004021.1310661-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: b5633790-d7ea-48da-69e5-08de2316753e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3ppckJKKzdrSnhjT2JKR1kyOVVtSFZDOUFsNjNPN2xhZU44c3NubFlWYjNY?=
 =?utf-8?B?aTc3ZElLR3dlVXdjdHBTUFZtRjFRMUJIekNqWmNaUnFaWHBRbkFTb3JscXIv?=
 =?utf-8?B?eGcvK2VabGNOcXFGVzlSK1R3czhLUDI5Ym5tSUxpUXV2a1V5bFZIMEEzWFhh?=
 =?utf-8?B?OE00WGFHM3dIalcybEwrZzA4RWNuK2h2LzJWa0xmMSsxZXd3WFQzZWYxYUc3?=
 =?utf-8?B?MWF2TWs2L1dZOGJOMUZKdUQxaHdyVVQvRHI1MTVPWUR3d2ErQkgzdXdxbGtD?=
 =?utf-8?B?YWxKQkQ3RUp2L09UUndyaHBUZmF0TmowTXJjcE5XWFNVSXFxUGN1NDlaNHJH?=
 =?utf-8?B?R0U2cWQxT1dKVWZPSDVoYzhVSWVHYnJ0RkNudjBCM0FxMXJ6VDdmQkl1QUxw?=
 =?utf-8?B?ZnJQT1ordDVQb1FySEFtUnpiSStVc25Na0VvYzlmZ3BIUHI2bWVNQUt0S2Vm?=
 =?utf-8?B?VDNVbXBmZW9rTG9uSnRPRFJXSTJ6aHlMaTFtYjN5RERaK3lYMDBGaXFKWkJP?=
 =?utf-8?B?aWtUbkRIaG1NdHcwMzJTR1VsWUlDRGUvQ05TcjV1aytSYkhFWkpubndXYlp5?=
 =?utf-8?B?dW8yelRNeTZQRTJlc1pOZU15NWJQT2VONEF4VlJxU001VkJlYVVZbVE5SlFk?=
 =?utf-8?B?dktDYWZYdTVHVCs4Vko2a1JKdWNnUmpiY2VPdnhhbnlPbVlpZjBFYWZUYmpw?=
 =?utf-8?B?WjVCV0FUZ0w2TTVZdDFWKzNLQlFTWjk1aGs4VFlPUXFCRm91UUd1ZU1LMHBZ?=
 =?utf-8?B?SG95RDFTSGpQZkRxWHZpaDF1OVg0SWtCWEdKa2xXN1AyK1pmdXArcno4b3Fi?=
 =?utf-8?B?WEFwMEdiYUZwK1ErK013bU1tNWtnVng5cHZFaU42RDExalBkRklkQ25ocW82?=
 =?utf-8?B?RGRUQ0o0a0M4bTREQVZ3THBZTmQ3SUxwdVc3cllPN25RY2xWRnJMQ3JVWDRt?=
 =?utf-8?B?MW82MXBJenNxeTNxWTB1cU16RFpLYkRSU0VSUXR1YmhndjZyNktBVm5tbGha?=
 =?utf-8?B?bXE2eVM2OXl1RHlCWTBxeEY4WDY2MWZwQ3AzdkZndXhjek1IaVBobzFTMkls?=
 =?utf-8?B?elNEVG5NeFJhcm9DUlF2Z0pWcUt4VkFVcE9zRGN5L1BQRXBsWkxQeFd3enU1?=
 =?utf-8?B?SDQ0b2pYNDlpTGxoSUk0K09iTUt4YTRMdkRxRjNqRHcyZDhHUjFOc21YTjlX?=
 =?utf-8?B?WnpJRkN3WlNQSFlncnBiUWRxMDMvYkpPQjQvVkduVWtBZGV0bTFLUGVldXdi?=
 =?utf-8?B?KytsUk1VYWx6L0pNWVUySXQ4aTFYVVU1S0FrdTZYMmgyZUw4cXA4bUxQUU83?=
 =?utf-8?B?eGFvZmVwN2liZ1dNV1lDMGdrVTc1d1hpRGlqLzZxcUd1Y3FWajFhZTQvdVhI?=
 =?utf-8?B?ditpZythRUNCZDhHM0pmZUdTazRDc2dHYXc5em9wbnRwTnM1RmNSd0tmMFVH?=
 =?utf-8?B?SElHeGdjb2J0M1Bpd0xOcmFzRDJ4WmJXcFJGVUxvbHB0MFg2b3VyV0I4dTlD?=
 =?utf-8?B?amdxUi9tSlpXTTd1TU9yU3dpbTYvY2t0UzRHaTRqejc0OVI4UjNhWlBrYUNN?=
 =?utf-8?B?TlprYUNlbnNHejZYUjRiZXVYbFd1b0x6MEdQZHVmaXBvM3ZqWW9tOE1qWW9T?=
 =?utf-8?B?NnQ0R29xMWl6cVE1dkcyRExsWWFJclowRTJCN2g0Y3M0Y00wS01hL2w4ZlRn?=
 =?utf-8?B?LzdJU2ZWODArM2JYZVk1Z3BpWWlmZEUwc0tIa0xWd21taHJpcXZ6WDlXeXox?=
 =?utf-8?B?VmZONFFiL3R4cFdRVFJkbHlFdkhaczdUWGxnVXBYWmhaNnVLQ0hOMitGTmUz?=
 =?utf-8?B?WkJ1RDI0UTQ0MXYrU2k4YUNLU20yL0QrS0lITnNqaVljNXpSTVFYMnIwZ2d2?=
 =?utf-8?B?YW5kYmJib2ZIVk1ZS29uZmFZUnNPUUt3QkE0TlFMSVc4OEZCMWV5djBpTHBY?=
 =?utf-8?B?SEptRkFJQ1ZZQXFqamJYV2xzM2swOGRTK08xdVZRcjZKLzBkOXRJb3NpWDFM?=
 =?utf-8?B?SHFwZHVqVk9adHp6TnZBVWZqZEtYVVpqdU9Hc2JIa05Ca011RE15VDBpLzVa?=
 =?utf-8?Q?3KIyFb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 00:40:49.5110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5633790-d7ea-48da-69e5-08de2316753e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

This patch set adds support for address translation using ACPI PRM and
enables this for AMD Zen5 platforms. v4 is the current appoach in
response to earlier attempts to implement CXL address translation:

 * v1: [1] and the comments on it, esp. Dan's [2],
 * v2: [3] and comments on [4], esp. Dave's [5],
 * v3: [6] and comments on it, esp. Dave's [7],
 * v4: [8].

This version addresses review comments. No major changes compared to
the previous submission. See the changelog for details. Thank you all
for your reviews and testing.

Documentation of CXL Address Translation Support will be added to the
Kernel's "Compute Express Link: Linux Conventions". This patch
submission will be the base for a documention patch that describes CXL
Address Translation support accordingly.

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
introduced to translate a decoder's HPA to the CXL host bridge's
address range. The callback is then used to determine the region
parameters which includes the SPA translated address range of the
endpoint decoder and the interleaving configuration. This is stored in
struct cxl_region which allows an endpoint decoder to determine that
parameters based on its assigned region.

Note that only auto-discovery of decoders is supported. Thus, decoders
are locked and cannot be configured manually.

Finally, Zen5 address translation is enabled using ACPI PRMT.

This series bases on cxl/next.

V6:
 * rebased onto v6.18-rc5 and CXL updates for v6.19
 * note: applies on top of: [PATCH v3 0/3] CXL updates for v6.19

V5:
 * fixed build error with !CXL_REGION (kbot),
 * updated sob-chains,
 * added note to get_cxl_root_decoder() to drop reference after use
   (Dave),
 * moved initialziation of base* variables in
   cxl_prm_translate_hpa_range() (Dave, Jonathan),
 * fixed initialization of cxlr->hpa_range for the non-auto case
   (Alison),
 * added description of the @hpa_range arg to
   cxl_calc_interleave_pos() (kbot),
 * removed optional patches 12-14 to send them separately (Alison,
   Dave),
 * reordered patches 1-6 to reduce dependencies between them and give
   way for early pick up candidates,
 * rebased onto cxl/next (c692f5a947ad),
 * added commas in comment in cxl_add_to_region() (Jonathan),
 * removed cxlmd from struct cxl_region_context (Dave, Jonathan),
 * removed use of PTR_ERR_OR_ZERO() (Jonathan),
 * increased wrap width to 80 chars for comments in cxl_atl.c (Jonathan),
 * moved (ways > 1) check out of while loop in cxl_prm_translate_hpa_range()
   (Jonathan),
 * removed trailing comma in struct prm_cxl_dpa_spa_data initializer (Jonathan),
 * updated patch description on locking the decoders (Dave, Jonathan),
 * spell fix in patch description (Jonathan),

V4:
 * rebased onto v6.18-rc2 (cxl/next),
 * updated sob-chain,
 * reworked and simplified code to use an address translation callback
   bound to the root port,
 * moved all address translation code to core/atl.c,
 * cxlr->cxlrd change, updated patch description (Alison),
 * use DEFINE_RANGE() (Jonathan),
 * change name to @hpa_range (Dave, Jonathan),
 * updated patch description if there is a no-op (Gregory),
 * use Designated initializers for struct cxl_region_context (Dave),
 * move callback handler to struct cxl_root_ops (Dave),
 * move hanler inialization to acpi_probe() (Dave),
 * updated comment where Normalized Addressing is checked (Dave),
 * limit PRM enablement only to AMD supported kernel configs (AMD_NB)
   (Jonathan),
 * added 3 related optional cleanup patches at the end of the series,

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
[6] https://patchwork.kernel.org/project/cxl/cover/20250912144514.526441-1-rrichter@amd.com/
[7] https://lore.kernel.org/all/20250912144514.526441-8-rrichter@amd.com/T/#m23c2adb9d1e20770ccd5d11475288bda382b0af5
[8] https://patchwork.kernel.org/project/cxl/cover/20251103184804.509762-1-rrichter@amd.com/

Robert Richter (11):
  cxl/region: Rename misleading variable name @hpa to @hpa_range
  cxl/region: Store root decoder in struct cxl_region
  cxl/region: Store HPA range in struct cxl_region
  cxl: Simplify cxl_root_ops allocation and handling
  cxl/region: Separate region parameter setup and region construction
  cxl/region: Add @hpa_range argument to function
    cxl_calc_interleave_pos()
  cxl/region: Use region data to get the root decoder
  cxl: Introduce callback for HPA address ranges translation
  cxl/acpi: Prepare use of EFI runtime services
  cxl: Enable AMD Zen5 address translation using ACPI PRMT
  cxl/atl: Lock decoders that need address translation

 drivers/cxl/Kconfig       |   5 +
 drivers/cxl/acpi.c        |  17 ++--
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 207 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/cdat.c   |   8 +-
 drivers/cxl/core/core.h   |   8 ++
 drivers/cxl/core/port.c   |   8 +-
 drivers/cxl/core/region.c | 156 +++++++++++++++++-----------
 drivers/cxl/cxl.h         |  31 ++++--
 9 files changed, 356 insertions(+), 85 deletions(-)
 create mode 100644 drivers/cxl/core/atl.c

-- 
2.47.3

