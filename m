Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301E2C08AD;
	Wed, 12 Nov 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979523; cv=fail; b=CzWPl1BO/Ny1r8xlRRhK5MCV4ZA2dEucRS7CRbznxa56QwtTsmzFkZ+Of2H/ljRNt6JNsbqPH0Y+R1PdkX5UnU87LsdOj0xscGcB4zT7W2AdKfLpRbm+hNzicRk48guOvWC6sUbpdGCnIDaTbLnF8y3nGHsQFv+WRyrfnTry1VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979523; c=relaxed/simple;
	bh=M4EkzQkbquA6WJrZCFNWHH/wEIBCdXy9UDDXyf9SC+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N9bhB+QoyYuvnuDj+9SNlmu6aMq/X4xJQ00IAlw/DRupg1q51Uz6C9zXzpBLesTHfD++BNiSKAJW2QhBSfChfDuXVPDTmVLqMJPN6AYlRIUcOr7whVM+XvSEKtyBSnTDktwMosLnENj2YPX/ZvEqSVz9FyftyLTQjZcAPbA3Ghc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qd7x3q/d; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qd7x3q/d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzM02K20OR1OaqDv2ChKxZ/Odw+cPwYlSrhs9dTXIV1FqQP+VOXhCxKgsUVdljkLEzhq2sIyyMHt7JKXRn0AIdrVl0FpUkvdgqq1zZ2L+t9qymtnbxnzEDVUEm9rVIaBqmbjbMahw3c7kSxTxh+FuTA/v82UxqtjDfJ34BK/swgGkhCT8FOAUftgBMwyTsH9TiaOR6sY9rPrUvMJbUSmcYQ/whZnvhB6hF1Si4uKfjao/SyCePJahjftV1UtD9sO/TK6x6zdR2vKpLVm8vW6mFE3I9jv2tnLNNhWYuceCoOxVvRZ0tsa5bVgYXIQX2ndBD6GoP7tmXlRTXPHBEmf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvUX0JH2uCoLfhLjeH+NbDVdP8JQ2VfjBfKbvjaGIEI=;
 b=eTGUBjBICWz6SxF9Q8xs/zkDG1Y8i/24hVpfqGs/gWCtJAEClVanFXLmAEzxWKXAWNQCy/LihyocnC3aTwlzf/9+FREEBo5l6nbbBRycuoA/dAQTB3ThYJRecmkRduFUMWscNwX1ZBrUaDyG0FXbIQb6vmocd9xzqn7fzcWem3fSXhtXgseDSzZTnEKmanQ+JsjnyV9HC3IyHnGdoUlyjXfEYPLbaMGJH9jcA3HtN13yeuvlwvJCQb0SKmJNXq6V+NNLgokNCZfQ+NruH+8Gpj7xPBW2wyWbDcBKrYR08FP3uR7LK9JuQGPsD7nNngbUrkduU1XFc5EFWLI6lV+84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvUX0JH2uCoLfhLjeH+NbDVdP8JQ2VfjBfKbvjaGIEI=;
 b=qd7x3q/dpFi7+z5gOXAkufF7xMDgaWaolzzyjld0Msw/mpzryGaPYNHB5+ITdz5/WQknMjecADMIJd8zC227U3WnCO3xi/JdIDPzQDMmVuta/pMKO+/iUbw2TZfI+Z3sdMhDzHLwM9O0UrPevSiYYPW0RYctMTJprYvt2uJOS50=
Received: from CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::19)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 20:31:57 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::33) by CH0P221CA0046.outlook.office365.com
 (2603:10b6:610:11d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 20:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 20:31:56 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 12:31:54 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v5 00/11] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Wed, 12 Nov 2025 21:31:27 +0100
Message-ID: <20251112203143.1269944-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c624c86-3085-46ef-15cc-08de222a864e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3RWcm1KMWh6YWlEVFpkb1phRDdXNE03WVVGMDNYbW1FU29MekpLTjRMd00x?=
 =?utf-8?B?c2lIUUdPSGc5WFJScDJHZ0lFMlJjNWVqSUJlTkxjTzdDV05yQ2lBQjZSWits?=
 =?utf-8?B?N2RubkRYVGlCMWx1YjBpeGlQcTBCU1IzYm9KK2ExcHhVVlVWQXN0c0F0eXVP?=
 =?utf-8?B?RnZ2cXhHNHc0THY3dERRaVU2WDBwYkhRNHhtTlFIdHd5NG9ud2RUc0IvWlZv?=
 =?utf-8?B?S2Qyc3c1TUxTd3FvSE9UVlc2d01XdWdkbGlUUXZGK2IxNUtXMXkyVFpzT1No?=
 =?utf-8?B?ZmxrcG4zZEdkTWplZExPcHF1bFN4SDNRalh0S0F0VU5hdlNEbHpjOXg1aWdM?=
 =?utf-8?B?MUQ3RTl3WWZCcTVpOHpLSFFPQlNYWE5KeE1QQXh1dTlSWkE2WUFaSHg3N25L?=
 =?utf-8?B?M3FubHpwbVdGc2FCbzlHQ0hiMFFCc0NocWpPYzFNWHNoc0tTelU3cDA4TUMr?=
 =?utf-8?B?ZUpQeXh5MlRnZE9Rb1A1SVZkQTgyWjNYY3JZZjV1TWllaXNVMS9tTVI3MU91?=
 =?utf-8?B?V3JuWGFHeFJsY2loVHRVdCtldUJVSEVJaU4xRkNRSTRTZUFzTStoaWd3aWl6?=
 =?utf-8?B?UEViL3hCaEhOYTk2ditiaTdPQ3dSaFF0WWJGRzZzTElpMGVZZkQyNFBFaWZZ?=
 =?utf-8?B?VzdxblJJYytiWG15aTA2Mmc1MStxdm5ONlRDS1Jod1lqb2pyekpycXFxSUJh?=
 =?utf-8?B?NmlBQUIvTlBWTldlR2l0eXhCcXN0QzJVZTZaRk1UTWJHcXVDaDVkdjZORUc4?=
 =?utf-8?B?Z2RucVRHRURNUS9lN29weitseXJVMEVKSzkxeFVyNVFEbmpaeEJWM0swOVFY?=
 =?utf-8?B?ZFEySUVmMkxUUnVLUTNzUGJKNWlOeUtsa3hoaHpKN3hCeE83NW5HNXRFWWRO?=
 =?utf-8?B?cUFaRFBMT0tBbFhYZkp3aGgwMkI5K3V4Q1Z1MFlRZTZpZGdURnYwOEYzcC8x?=
 =?utf-8?B?bnJId2hkdm55NzJDRnhwcmdPalcrWEczMWhmR0ppNzJ2ZStOaWN5MjNTWEJN?=
 =?utf-8?B?MVovTktNZ0w5MitXZWVnTEdxaERRN28wSGx0NU5SWE0vaUw5djdmcjdOZ3Fn?=
 =?utf-8?B?T3VmT09vUWZnL0MvaUgyQjIvNWwxY210Z0dhY1M1Y1pDVGJ5Ny8rZ3dIdGtB?=
 =?utf-8?B?MjlZeGZSY1Vwb0c1cmpHdnhpQzJENThEUzJHeG80TjA4bjBuL0tXQ0k3M2Ey?=
 =?utf-8?B?TEZHU2lyNDYyaWREVDVNRnJpL2hQSWJiRzFZSnJ6cWxHZVhhYmhrQ2U5MmlU?=
 =?utf-8?B?b3h0Q2ZyYzVreE1qdnYrdEZTKzJ5NHN5dWs2citkS0M1VEsrMm9KdEFvejNi?=
 =?utf-8?B?SEZTVVB5dmlXUXRkVFBmeDM1T1Z3cjVSY1pZVGZyU2U1V1hITlFqOE90SHE1?=
 =?utf-8?B?OG13OXA4c1l2ZHVKd2psWVlUQlA1SCtlVjNwWkxmSGRkaUlBSXczaFMwVE1W?=
 =?utf-8?B?UW9LNFlaTGNNY2pxd0Fhbm5JdkxRSmhCYjN2UWhZTitqWHpWZkZNWE5rQkk4?=
 =?utf-8?B?SzJEUEkvaGp5YWZWcTdMaVUwOGp3NFNnZFJwTlBwUy9SNStLdTdrY3RTYzNV?=
 =?utf-8?B?SEVTVG9DS1g1VENaakdGbURjVTJTN2kvT2Q0U2RGVEFqN1JFQkVzc21UL3hm?=
 =?utf-8?B?SVk5MGdSVStINGthR1VpOW5PNUEzSytDdFYvZmNxcU5ZcG45VExtMWpFQStz?=
 =?utf-8?B?RXBaSUhFM3JPOW82MWdpenhNYUJEblkrT3ZIdUhpZk1NQ2p4Z0VTTHhiaVUr?=
 =?utf-8?B?cVZCTldiTytNODNhNDQ1aDF2YmNyOHIzZUVjak8xaTJ1emFvR2daN1NnMGpN?=
 =?utf-8?B?UHFuK1pVQlhaVExXalVCRmFha2lFdTZkaWZpUE1uQW5VdzNHNGplR0ZXVzZm?=
 =?utf-8?B?ajU4SFJyQWRqTjBYd1NxbytYV3hvQXRLRnN3SWJwWCthUWI0a1hOb1E3RS9i?=
 =?utf-8?B?UjVBZDArNEVTZ3BCdUhESEJFTk1DNjUyNzAwd25kbjA3UWNESW5BQTcyTk5n?=
 =?utf-8?B?eDNPZEsxb04wVHc2Zy9yazdsY2NpblVNZ0lIMmh5WnluUUJ0dXp1VkFJU3A1?=
 =?utf-8?Q?k4MxXI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 20:31:56.9880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c624c86-3085-46ef-15cc-08de222a864e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

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
 drivers/cxl/core/port.c   |   9 +-
 drivers/cxl/core/region.c | 156 +++++++++++++++++-----------
 drivers/cxl/cxl.h         |  31 ++++--
 9 files changed, 356 insertions(+), 86 deletions(-)
 create mode 100644 drivers/cxl/core/atl.c


base-commit: c692f5a947ad17ab155dc78631342b44acce5a96
-- 
2.47.3

