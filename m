Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D470809;
	Mon,  3 Nov 2025 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762195720; cv=fail; b=MFNva6ptiCe7inm5KUeOxxQl1oCkH+08VV3+sammn99Qy7rBQPJSF/2tCRAWRx17gvjQAZuKH9d2K0KKw/oYudH05LwDFiOsTukLwy6xTYjN5HeYB4jSxhZwTeSdCO3DTGrE/mUuB+fzhzrrf4RxosCkDp8GGYymsCbtu4+jrWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762195720; c=relaxed/simple;
	bh=VWalNu9b5DWcvgpw/yLx+q03sGrywBPCYzlu2wYdANQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=admuvJffXghXuBGwGfYKO4GWVUBcmW+HOZoD+oDlpiOYvzztC3O0jKSdQ7oyqswgM1Wd1Z4CJOcRBgt91WHxvFOsgJFHW1fruzQ6VRSnXVb+0mGYPi6ANxdvbgP+f1lxpB4klszCZ829QSgfmyjr0AW2yHx5LExKk+OKAW5ee6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hiC5cgRb; arc=fail smtp.client-ip=40.93.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hiC5cgRb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0cvg/ZTSJmaxXMDUZaVqqK7uVWJDjR5KZ4efJtIRBN3gT4RBrbOSWxaUPFpFgaYYuO7q7gttKY6ur2kNxqHUS61vU91tG6u0AEURiiHLpayfBWV1SuAOl8EGJ/3oaDB9ZPtUnvwLi49bnKouSkG8W4GBo147Eqz0Z0s65fJfgSRIPOpCCMPTAC9cAWlBOWoPQ4mWHhy093+LAcZPPF9ry99sc1ePU69SPbCWhNuHGPENzlTERH5nlIoSFjTrTBBvxBLnbgBuvU57eF0fk2YRBT3n6ijhXHdJ8T/D8+HIVlZpZ2ihNhSYKnz1c9XZm85ZMl3bvVFC9uzO0ZNBCl5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSBDJd0eQZmJU5wQYzML6PVvkviPO0p1PIK7SBPvdzA=;
 b=pKvqeRPTrRsL9UIhfiaVQRFwCvrgqkrMgm3j/cs1o/adz32rx1do0vg2rbk0w9qpEZRYsMRrrzsOf5qO4pa4JmP/V1IGD5JXVs/QYyu1CQoQEjxvPDyJS3wZliGXYERCNfJSa8xmEbCMipTyunIHzpUlbBFi0mZm4OqDoVR7UGC/tIrrYpu8of5TNN3773tFB3yOZEdAko2MvJnBtE1PP5JmDJcCfkqQ8YkeQ8rJQKyExz+4ghYe5s3Xmd+xVwSalouJSp0cdLQbhAG6DHClekTK8Ph64qkpJ6gfrVQ+VLl9/4eejpXil6B2Be21MmySyymQEx8TGfDBNoiF57E1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSBDJd0eQZmJU5wQYzML6PVvkviPO0p1PIK7SBPvdzA=;
 b=hiC5cgRb4yqFhSSJpSvnEn0L/oVY4TIjPHLIlJ9A9vzlj3Tc3/lbYmQN1cO3Xbp1s/5Wa088AqNcvHWKTWUOosVogNNA5UHivz3mcuZBqC3ZkdNVm4ScpDzF+I5pRsWHb94w66laVKw+0vY+uW65bQS4buMsmnzTODb1SsyDBQM=
Received: from BL1PR13CA0093.namprd13.prod.outlook.com (2603:10b6:208:2b9::8)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:48:34 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::7f) by BL1PR13CA0093.outlook.office365.com
 (2603:10b6:208:2b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 18:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 18:48:33 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 10:48:27 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v4 00/14] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Mon, 3 Nov 2025 19:47:41 +0100
Message-ID: <20251103184804.509762-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e8332d-ad98-4d8c-6f4a-08de1b09972d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1k0U2ZvaEE5SFJLSklBMmZGSGtqaVJHYVRDL0lvMWFjZERGdHBncDFOQzhZ?=
 =?utf-8?B?SUpmeEtUNnNBbWlnQ2dNWWFEZk00R25SMG9IZnVNcE5GRjdPeWNZRDAzNjRR?=
 =?utf-8?B?S3hmS0tncDhPQ2ppZXptLzEvRmpLVkVHSnordVJPTXFPaHNXVE9jbHp4VGJ6?=
 =?utf-8?B?YmpLK2RsTmxCYkZzWEttYlZ2NXJrcnRYSC9vZzJjOVZQRnVhUFlLQVNjUXVz?=
 =?utf-8?B?d096ZGZKNGhEekhHSGx2Z2NFSDJHMVdmZCt0bTg4eFZVZHBNTEVSUmdDNUJJ?=
 =?utf-8?B?S3JiNWx2eE9TdUpGRkNCTXBtU1VEelBqUVJwSnhsbk9KaWhML1BaVndQcGJt?=
 =?utf-8?B?OFZwYVlVVlRSbzllQ0JNbnBWRVBzaFR6ZDI3eGlOQTczYXJNY0dwVHhzbE4z?=
 =?utf-8?B?T3NxbnFoOERDdG1MaVd3VEdLU1ZHWVJCbndYdXlyUkhtcmVocTdxeFhnYWRS?=
 =?utf-8?B?a1VHWmg0NWpZOUZxbFZ2WGk4SEtkMjhvNS9ka2lRMFRGTGhHQWNvcC9sR0Mw?=
 =?utf-8?B?a1dDbXZLSlIyUTkwWmJWWGJaNUtjQ2d3MHp6bUZqOHhYWS9pT2RyUExyYVhE?=
 =?utf-8?B?RTVlekxReGhkK2VuQndnQXV6aG9RREFGQkk0ZGFiTlVqZTZrMjM1WjFObWlq?=
 =?utf-8?B?SEZZZm9CVW1sRE9vOGJkem5hUy9zZmNrbGpOcmlQT2lNSVB2NHZPQTNnYW9K?=
 =?utf-8?B?bDdwMDNZdWtsbFZtKzZEWjB6VFJYL21jSFVIMEc5Rm1ocWwrcFhRU1Z3T2tl?=
 =?utf-8?B?MGpxdkV6b1o1ZElmVm01YUdiMWxvT0ZoOW1sVTdrajArdW01OWxJRmhETytt?=
 =?utf-8?B?OFk0c1p1dmo4QnNVaHUwS051aktjVXNCNVV0NzRXalBiUUpmK2hYWXlKMk11?=
 =?utf-8?B?ZXZTenl3STN2Z0RsTGR4NHlaaEtRRDFaZjRmRHZUV3lidTFHRWNIMVNEWU1y?=
 =?utf-8?B?T0tHc0wzMSsxdG5VenAzeEVaOExpcjFlOXdQQ1V5Szc2R05VWTg2eXFmVlls?=
 =?utf-8?B?Qm5yQmVBSFRkRnh0WFY1ZDlFVzhtYzBEaENDcVFMdUxDTWdnWTVDUWdxY2o5?=
 =?utf-8?B?bk5EcDhOcE9tOUFUY3V5cGJRWWpxNzR4RjNHaHNSVDhsUFl4b2lHd3kzbDlL?=
 =?utf-8?B?VE9vS1dFMzVUcFBlcW1wWTcyVzNPQ2VJMHZTQUM2TDhlbncveTZJVEp5K2xo?=
 =?utf-8?B?a2FtNHMzSHZETHEzUi9McStNaTBRRG1mR1FGV2dqUEsxMWhqYVRYc1FiUzBa?=
 =?utf-8?B?Z0ZHR3JFYVF5QitpUWsrYVd6K1NVcHRKRklpcjFDNW1JNVVHSXJpaVZKWkkz?=
 =?utf-8?B?c1hiWjYyVVpIVUlPaERFeTB1dHVKNWY1QVlVajY1NDVMMlRha2VxVG9MYUgx?=
 =?utf-8?B?OVFoM1VDU25BZ25GcllFVjlGeTltT3VUYXRPMWJud210K1JXeXNJdCthWXBZ?=
 =?utf-8?B?RTBabmtJK0FRbENkUVJiamhwRWxDTWtZYmZrUWhnY280SGIxdzI1Ni9NRnp5?=
 =?utf-8?B?d0RsWEswanlJV05jY3VHZWtoNTBkNDl4azEyTkVGakRTOCsrSm1oSXh1UXFW?=
 =?utf-8?B?YXZIYTYxVnFFREpSVGJkTVVkclVMWkJFWnVGNHZjMFhNSVVWOTZnTXJaa2FC?=
 =?utf-8?B?Y2kzUDRLUzArenlVM0RtWXlhVkUvUG1HNWQ3bnUrMUZ2Skc3am16MlFoSVhr?=
 =?utf-8?B?bWxDN2tFR1Yxc1VRMlc0R1hWQ1NZWU94Nzk5TEFZZC9sdVB2VkE3b0IxM2cx?=
 =?utf-8?B?NDlEZ0lxYzBHMDVBSC8raHZGQlE0RzkrSDVFUHNaeGFhVzVHT3NnVElFaUta?=
 =?utf-8?B?Q1pVQXkxbkg5NlpSdjUxclNXUXJLZUhyM01rOHo1Qkg2aHk3UjVBNVliUzZX?=
 =?utf-8?B?Qnh4T0pqWHl1S1hYWGV6RnlZd3dmRFBsSngvSW0xV3F0Szd2NDU5MXV1b1do?=
 =?utf-8?B?TEs1ZzJGZDRwMTFyakNpMXVhUVA3OG1TTDduMVZkUjQ2VHNIdnhYQ0VCMEpD?=
 =?utf-8?B?NU9XbUJQMG9XNDV1Mk11U0hwdXBjWm9rM3Q3T1BXaXNxOG9ycXVmSXVkZWVE?=
 =?utf-8?B?dEo1TjYrWHBYdGVRZmk1dGhkMGpEZW92YkxVTXhCTmFmRnJuaERqMkp3V1dx?=
 =?utf-8?Q?LjkgEjFFWEq1bam4J+lRX5rOE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:48:33.7749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e8332d-ad98-4d8c-6f4a-08de1b09972d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165

This patch set adds support for address translation using ACPI PRM and
enables this for AMD Zen5 platforms. This is another new appoach in
response to earlier attempts to implement CXL address translation:

 * v1: [1] and the comments on it, esp. Dan's [2],
 * v2: [3] and comments on [4], esp. Dave's [5]
 * v3: [6] and comments on it, esp. Dave's [7]

This version 4 reworks and simplifies code to use an address
translation callback bound to the root port. It moves all address
translation code to a single file, core/atl.c.

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

There are 3 additional cleanup patches at the end of the series. It
might be worth to add them too, but could be dropped if there are
concerns.

This series bases on cxl/next.

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

Robert Richter (14):
  cxl/region: Store root decoder in struct cxl_region
  cxl/region: Store HPA range in struct cxl_region
  cxl/region: Rename misleading variable name @hpa to @hpa_range
  cxl/region: Add @hpa_range argument to function
    cxl_calc_interleave_pos()
  cxl: Simplify cxl_root_ops allocation and handling
  cxl/region: Separate region parameter setup and region construction
  cxl/region: Use region data to get the root decoder
  cxl: Introduce callback for HPA address ranges translation
  cxl/acpi: Prepare use of EFI runtime services
  cxl: Enable AMD Zen5 address translation using ACPI PRMT
  cxl/atl: Lock decoders that need address translation
  cxl: Simplify cxl_rd_ops allocation and handling
  cxl/acpi: Group xor arithmetric setup code in a single block
  cxl/region: Remove local variable @inc in cxl_port_setup_targets()

 drivers/cxl/Kconfig       |   4 +
 drivers/cxl/acpi.c        |  32 +++---
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 205 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/cdat.c   |   8 +-
 drivers/cxl/core/core.h   |   9 ++
 drivers/cxl/core/port.c   |   9 +-
 drivers/cxl/core/region.c | 185 +++++++++++++++++++---------------
 drivers/cxl/cxl.h         |  33 ++++--
 9 files changed, 366 insertions(+), 120 deletions(-)
 create mode 100644 drivers/cxl/core/atl.c


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.47.3

