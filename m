Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E15314A82;
	Sat, 10 Jan 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768045647; cv=fail; b=VH1MXWfBW21z+2fZ5UAFWcoIxEZTMMF9zK11x6vu3XziPURoGVuXrxA+1K8lI6eVlx8rnJImgRH7mUkeyABDSiPMoCjYse0wmBKZlPIpshEocgxTqNhC9V0JDyG/4tp/ir77Ut4UpNuW/Ig4+SvwrHWeE5NMU/jvMNNf/xW6iTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768045647; c=relaxed/simple;
	bh=WwVs8iz4IdKLGv3bRZvjkjIjEuNukr4Zx0uAedTwPzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULscY6E0iDDjSpi5OVwNjKr7aaNvcbuW9D05znOobIMeFRlnqOFxT5veeZV4F7D4UlZ6C6tvbfKO2g3OTv8QtVhiR1XpI0MkrDi1IUk1Xr9XJZAgB71UqpHTwmZjl97vl7QuVDg66aJCrkp3i2e8KAQNQYW++NiXR+y+pzt41Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HlP6vm9/; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HlP6vm9/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiYWjQVDDb0R0nDeVANBPFgMWtBsFjGqVnRVquPz3Nruoo4i03lD0uK9QtEqsxgzNjEyIZdBlRH4nevJ5+HRLgo/vcfioEONvuAQ99GH6W5FkaY8LVLfCiBvYoWILyg2DxJ7Xjp/+iwDP456IC5TGfIZotAAd2O85TdITetXXP/0xTKxfC9dxyMaH6AeP+/nS/z7WchyVzV+OVZJUNgHzJ8bRfxKHOP5hpUh1Ay8ogukB5jpIvoHzUuqXLH72C5gpECJ19JUSTdMjnZdg8+9apljJIGHUTBtaRZUjBvkVIBMHHzgst4zmT8P+oTwXmwfxyF3QyVWVVkYSKuJjlTrWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXuHkq+voVCRZ3cQcYuPx5vazBkVN8g1cqyT8zfmWVg=;
 b=hoTb01DEPOACK7GpN7BlhQFRurFv5LHGLxkrWBiZZtXdgvPKkOQWZmzGJSdEM6HTko2IoxKNAFBWIrXGFr2JvH4LE+UAtL+aQBRPBIyRVjci/ZBPnJQfbZ3lzfixVt4oc8l3xF0+Zj7reqA52Idbg4mnA9sB7cbB2ls4fCyOKDrG5PzWo6HEhmsrICjuyrZUbTBA5ugjYyRO26EdpurflBywFGEk7IhqbkiAZBBWoG4KiIqqCXzqM1k9UbMkv+KDgweGnQB7hYSRsXoPJMHAVuE9L8b3pNHujj3OXEnnCGbUNCgPjHERMHghEPk6UtvsHLZDdaNYHTNCoOYRsZsMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXuHkq+voVCRZ3cQcYuPx5vazBkVN8g1cqyT8zfmWVg=;
 b=HlP6vm9/p0/Vx9LsvrIgR+k7XtsMfYQ9noTjDPg+QQf+IBr5/u9Nw7yTcq47YRbCa8AQHjJy7/ZekBW8DLB4bAVd+Jm4Yd/yD6uQF93Z4kTKy9EJ4beFrlkMoYdRQUfImE9wGTo+99T0z4COm3PrgqbN78vAkmPVPS8Dv1lFuKo=
Received: from SA0PR11CA0178.namprd11.prod.outlook.com (2603:10b6:806:1bb::33)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 11:47:21 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::54) by SA0PR11CA0178.outlook.office365.com
 (2603:10b6:806:1bb::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.6 via Frontend Transport; Sat,
 10 Jan 2026 11:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 11:47:21 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 05:47:17 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v9 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Sat, 10 Jan 2026 12:46:45 +0100
Message-ID: <20260110114705.681676-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e14ee1-1269-45d4-9e6c-08de503e03c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFdFdnJHNWhtbkU0ME1VNGpSUVpnTWl2ZTJrZ3FGVGFRV1I1TkdxOGpZMVNU?=
 =?utf-8?B?anZsVHJLUno4UWxiWXdYQmI2cDFyM0JtRnRpQXJpakFUQnJzWDBGWDQyRGJm?=
 =?utf-8?B?NHhZMEZIZnBPZEhnNkIwMS9xY1BoMCt5VGg4ODBWR2FCZkRvaEhPMDZzVTJw?=
 =?utf-8?B?MXFuZVdUSWpTcVU2TEhxVDEraGd1cGl5OE1WNVhUUjB5dVUxWE51aS83V1Ba?=
 =?utf-8?B?Zit5SXBqeFh4RFdpMldqc3g4cDhrZkdOcExXdUovUmlidi8zeGNJU09PRlBu?=
 =?utf-8?B?czdXZDNzeENScFNpaWRrVVJSaVdCME53SHpnY2ZnNWxNS3RHL0QrSHZwRERu?=
 =?utf-8?B?em05RlY2MVRvOFBLQy9YNTUwOXgrUy96WTFybXFmU0JmTnRwV3lUZVBNdnZM?=
 =?utf-8?B?eno3Q1o4V1JZY3h0bUI1cXM1L3hNQU9aQUZ4Mk5scVpFa1B1UlpFOTYwOXgw?=
 =?utf-8?B?RU0vS25rTm5OZGNkd0dkMTZ6WWZka2RmY052Wi9RWWl2MVBiQkhzS2xOaE90?=
 =?utf-8?B?NzRTQ2kwUzFwK2hCSjdLUEZWZUtULy9NWFJOaXk5U3VtYmtZZC9TMURnK01B?=
 =?utf-8?B?V0NMYXN1aEhRcU1JQVpXTkc0NXVvSC9DZFFPcXE3cksxS3hLQWwvbTg4QW9U?=
 =?utf-8?B?eFBkenBLczByd2N1UktHbVFYRHdmZDJrOWl4WW9KdjFKeWVJUWwvOEJvOWxk?=
 =?utf-8?B?ZmNVZkJZVnNkRGJha0ZMUEdpa05iZ2FpSnZseWwzMFFUejgvWmVNNDl6ZCs1?=
 =?utf-8?B?VTFrZU9UTlZFcEVjLzQ4K2cyQUhYb3RtbjFvZFY5dkZJdVdwZnFhK1R5Z1Yy?=
 =?utf-8?B?alRYY1BKY0pzQWx1eFVySTN2dWU2TG04dVBUYkRWeDd0bTgrTG0wZ3BGVUpJ?=
 =?utf-8?B?OGtkRHVJc1F4T0Fsc3NTOENoN1kvL3VVZ0trQlVWNEp4dXZscXMrNGlWY2pK?=
 =?utf-8?B?b0pxYzJFYTFPSjhJa2EzK21jaGJQL3BNU203aG5ZTnljcE9KTkw2V3BDUXE1?=
 =?utf-8?B?Qkc0SUJVa25mYnJ5c2UwQzM1VWU3SjVsZU1sM0lCaXo3VzY1UHIxb1FmK2d6?=
 =?utf-8?B?SkllU01pYVJSaGFtMGh3ZlJkaC9STHNmd0FZQ1NTUEpMZXFZQ2lXSFVRNFNk?=
 =?utf-8?B?SzZaQmVLWmFSUGhZSGxxK3VOVHo2Lzc3VVJhT0huenk5YjRlZktFTCtmcW4x?=
 =?utf-8?B?RTJNZEZpdFNIbjUrRm1Kb2owN25vQUVRbml6OEx2VDFLMFNGdjBQa3VKTVpL?=
 =?utf-8?B?WGZHY3VRUm9YUnI5OTVsWE5JNGFaZlQ4STlYVUl1RGNDSEJua2NhNTNISHVw?=
 =?utf-8?B?bzZDU0ZEZWVxNWhoK0ZEQlZXUmxYLys3eVF1MVdQajNMaCtWRmJGZ2t5K2FF?=
 =?utf-8?B?clZxdGV1N0FMdEFxQmwya0JXUTBxMHdKVnZiZ3pENVUrR0RJS0dSUFoxNEdS?=
 =?utf-8?B?Tlc2elByUjJ0TmpCOWJnYnRIMzN1NDdvdHFpZnM4KzM3a2h0RXpCSDVKK3BG?=
 =?utf-8?B?d0NsTFVMTm1HbStJZGkxWTFSbkhJdm5YM2k5TkozWlZkV1RENHRtV1RSYmh2?=
 =?utf-8?B?ZVNxcmxybGlqSENLUDdMMVplY3IrZHhvUDBSSGs0NnlvZ1d4ZENXMk1FOVNo?=
 =?utf-8?B?dGR4OHg4Q1BVYit5ZWVmR1NtbDY0U1BjSDNlODZmLzQrOUZDOEN6WUpndDJ1?=
 =?utf-8?B?Snc2cDlaNEtnQ1BSOXNZQitWMDE3bTE3S1Q0NWJUeGJJdCtxcXNMYWF6TUFm?=
 =?utf-8?B?OUxXUnV2Sm1FYkpob1NqMTZLM2NieXlCOUhyY3BnRERyMHZDYStnelNUbFkv?=
 =?utf-8?B?bjkvRnpJS1NRaWZNQzhZZlZpb3U2WUNKUmcwQVBRSFRJNVpKVUVPbEYrMmp1?=
 =?utf-8?B?U2ptcG90b24vRnVvVDVhbTJMeGpnRCtySnJVZTl3VkpSVm9aS0M1NDhSek9m?=
 =?utf-8?B?NGRyYW5EVFpRWmp3U1dpcEUvMmxEd0JEWURHLzJZMUxLUVVGM2E3UlpueUxs?=
 =?utf-8?B?a1k1K1ZmNHRyZ2EwRU5PbktjTjBNMW1BeURCQ1ZjT3FoYTZsK1RlNm83L3pI?=
 =?utf-8?B?SmQva2Vkdy92M1FSdDhTSU5iQjVaMWUra21UNlBWbFhVSmlhaEFnY3FjTkJl?=
 =?utf-8?Q?jkAM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 11:47:21.4076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e14ee1-1269-45d4-9e6c-08de503e03c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717

This patch set adds support for address translation using ACPI PRM and
enables this for AMD Zen5 platforms. The current approach bases on v4
and is in response to earlier attempts to implement CXL address
translation:

 * v1: [1] and the comments on it, esp. Dan's [2],
 * v2: [3] and comments on [4], esp. Dave's [5],
 * v3: [6] and comments on it, esp. Dave's [7],
 * v4: [8].

This version addresses Alison's review comments to change the
implementation to disable HPA/SPA translation handler. There are a
view minor but no major changes otherwise. See the changelog for
details. Thank you all for your reviews and testing.

Documentation of CXL Address Translation Support will be added to the
Kernel's "Compute Express Link: Linux Conventions". This patch
submission will be the base for a documentation patch that describes CXL
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

This series bases on v6.19-rc1.

V9:
 * rebased onto v6.19-rc1,
 * updated sob-chains,
 * removed alignment check in cxl_prm_setup_root() for DPA ranges,
 * moved assignment to variable len in cxl_prm_setup_root() closer to user,
 * removed patch from series (Alison):
   [PATCH v8 12/13] cxl: Check if ULLONG_MAX was returned from translation functions
 * added patch to factor out poison setup code,
 * changed implementation to disable HPA/SPA translation handlers (Alison),

V8:
 * rebased onto cxl-for-6.19,
 * updated sob-chains,
 * renamed cxl_root callback to translation_setup_root,
 * renamed functions to cxl_root_setup_translation and cxl_prm_setup_root,
 * added comment around cxl_root_setup_translation(),
 * added check for ULLONG_MAX of return value of translation functions,
 * added callback to setup translation for regions
   (cxl_region_setup_translation, cxl_prm_setup_region),
 * add HPA/SPA callback handlers that return ULLONG_MAX (Alison),

V7:
 * rebased onto cxl/for-6.19/cxl-prm,
 * reworded comment and description of 11/11 (decoder lock),

V6:
 * rebased onto v6.18-rc5 and CXL updates for v6.19,
 * note: applies on top of: [PATCH v3 0/3] CXL updates for v6.19,

V5:
 * fixed build error with !CXL_REGION (kbot),
 * updated sob-chains,
 * added note to get_cxl_root_decoder() to drop reference after use
   (Dave),
 * moved initialization of base* variables in
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
 * move handler initialization to acpi_probe() (Dave),
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
 * added several patches around interleaving and SPA calculation in
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

Robert Richter (13):
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
  cxl/region: Factor out code into cxl_region_setup_poison()
  cxl: Disable HPA/SPA translation handlers for Normalized Addressing

 drivers/cxl/Kconfig       |   5 +
 drivers/cxl/acpi.c        |  17 +--
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 211 ++++++++++++++++++++++++++++++++
 drivers/cxl/core/cdat.c   |   8 +-
 drivers/cxl/core/core.h   |   8 ++
 drivers/cxl/core/port.c   |   8 +-
 drivers/cxl/core/region.c | 247 ++++++++++++++++++++++++--------------
 drivers/cxl/cxl.h         |  40 ++++--
 9 files changed, 426 insertions(+), 119 deletions(-)
 create mode 100644 drivers/cxl/core/atl.c


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.47.3

