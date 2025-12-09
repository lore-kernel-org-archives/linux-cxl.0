Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0C221FCA;
	Tue,  9 Dec 2025 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303684; cv=fail; b=ODFQVxIvs1b2D/D+L7JoBV1Vqp9eDfUbRR2z0NpO4HGcsggIMZg4/Pxvr2DHRrF7NLv9sdqIy41eTOOk5BfmaKnNskyHv52S7d2fyCIKVEhxgIFGJQC4bpyG6m7eswQxGn86AFDjMtahhd2aKgL0CGDccoupfaCvALqcltjgfWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303684; c=relaxed/simple;
	bh=7Inpzi1TEJ3QZZrj+FF57R81aaTWZGlcyXrhfPQI/C0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ACFRkaEYtaVWlbudtyq6UZEFccvl4geNH/4/BjKNv+pYEseGYdwYIiYO/6XJckwOFjzUjSQ2x2H0Gta6CluC84pBMq4vQX9j5bZCcFFJIi3JrStrKHpAuZ0LAygaggwmyIdeseF/XXHh3qYnrB3pT1Zw6V197Z1bw+SmUt17sh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X4dbnUHS; arc=fail smtp.client-ip=40.93.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X4dbnUHS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttbxBnBDbJEoKKJFKNvlupmJwGBhwRETWjJBOY50qtiW6hsuZj/DGrf4/BbON9zp5arFJBLQsreNxTFchqte4iKYHy71WroFFYaTFBcQf0rNRbf2csaNJUCRP/M96dGwISLRtonZkjR2job8OCsiYWbF/dISLRpbuhclF03k1uDJPG51RqBnzZxL15v4TrBj96yQAWVKYKU7v9CeXpopdJGMcXQ+S7W6quQ11viMwat3P6VbH9e3xJnPz3syEC0qekPLRYUAl+3B8u4/K0RCpZSE8Z2tFd6sMNpk/N4qabUH1LzOL/oo+uHQ/1pyVpt2oUMLTUBb833TIwUqSWOQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3JgDG0sFPNE4wOn18fgegwjeufq/TKTNpUK0CiEf6g=;
 b=lHSMEHmlTGYOyHjCMDzPW2WQXSYG+CLX1EOBX8VRXhjuaom3xY7+z5xxizCvSeb6NrUsZh/gog1HExel5EO7qJPS88ORUaa+NkE+DsmrFSZXn6OhomhXSZVyCK/xjd0pqojdRfZKIWFCwGfKoigRv/qJiDe/jenCutT1uSTMp2LCYEf+EUTh2wXDuMT7O4sK+QYg9Wki/N24u6eRJEzrGh5qncD+TT/NJUDOJN5PXlUm1XbPBM/ZZYykHDBoKgC91OjhGet/JxC4khQqwyeADurFDDfuXHNQcgC2zsxUZJSYNv9GkUYpy7iv1R8A+VgMYPGMbyhYaKmJCnZttMa96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3JgDG0sFPNE4wOn18fgegwjeufq/TKTNpUK0CiEf6g=;
 b=X4dbnUHSsah7QsmYyLcfyW1w0bdnIB1leI8Voqk6Eg9Dd6x3GqPSlN6gCtoDNNSSvsOp1v5Vloq4sWi8PlcEJBqF2D5634cnKvm3drR6Zko6uee9WuO+aTl3Mb64VJhLMUF2PxaeQ1dtg3kKuA0GF+BMZy3ma16lM5vBRjLNcfo=
Received: from BY3PR10CA0016.namprd10.prod.outlook.com (2603:10b6:a03:255::21)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 18:07:59 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::ed) by BY3PR10CA0016.outlook.office365.com
 (2603:10b6:a03:255::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 18:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 18:07:58 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 12:07:55 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v8 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Tue, 9 Dec 2025 19:06:36 +0100
Message-ID: <20251209180659.208842-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: 09846745-e913-4506-2be0-08de374de2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UElvZ2UrMEtsN3ZBeXRndi9Lc3l0ZnloL3JnM3VNODU4NWlWSUpxb205cEdR?=
 =?utf-8?B?SmltYlk3NmFzN1VnNE5sME1NSlBndFMyV3cwUGRwQ1krek5CMUlHYXNJYkxo?=
 =?utf-8?B?NlpReThKQ1hIMTN5YVJQWlZWWk9GeDlUcCtsc1k4V1FrY0F2SUtLYlhQaElq?=
 =?utf-8?B?U3F6RVFTdVh4ZEQ2MnVMNHF6bnM0cmtlMzVSbjZTTk0rNytvbHNONzljbGtQ?=
 =?utf-8?B?NFRXZlNMS2ZlWlVBSE55RUc4NXBORnlwWC9zYllZMmRpeFFUYlhyQWhqUzNp?=
 =?utf-8?B?RU5lL1VqZEV0RGRUTmZ6cm9obmdnS1djaGdXdWVaeWkxdGJFUjIyTWVNZC9G?=
 =?utf-8?B?bHpCMnFPNEl1NVpOcEt0bGpMK1NveFgwOHpLTFQxNktjZGFSM2ZBeFN4QWVa?=
 =?utf-8?B?U05IK1RqdnNMaVpPUytuWW5BUCtSVTI4cVo4eUMzVEZDZ3V0QkFwSm5hSlBm?=
 =?utf-8?B?WHl3c3hrdDNwTnJHSTRFVWFrbDJMRFRwYThDMVVGM2xjOXU2TjlmWXo5RGll?=
 =?utf-8?B?M2FFWkVkb1c1Um1DR3FCaittOExGRWI5UDBIQTQ5MEZSMTdISGRlbkY3M0xy?=
 =?utf-8?B?RDZzOFJtYlJ4dVMrVllZMDUzVy9qVVdOTi9CYUFCbmQ3SzJvSWlTeHZoVVFa?=
 =?utf-8?B?K1VqSDhGdTRKZHUyTmp4ci96UnpEWG8zcWN6bWVyVlc4SXNsWXRKUDVNak5z?=
 =?utf-8?B?R1VIYzkzMGtweFQ2VkZsaU9veUdvUFRrNlBCMlNURUhrYkgxTmc4eVFVeGRD?=
 =?utf-8?B?Y1dvWlBoOGRtcGVndjlYMEVUTE9zS09wdVZGMTA2VzU5czVsOEkrdmVMQ2Q2?=
 =?utf-8?B?SmdkcncrenBKU3BJa0tOVDBKZWFmWnBiT3FLY2FhMkx2S3N6bE5ISmdiOVRt?=
 =?utf-8?B?VmUvNktnbHkvd1p0QmZzaUErSGtheGtNczdsQnJVL0VaRWFvc1NWSWo1M2RQ?=
 =?utf-8?B?d3g0b3BuYkJUa2xCQUppZGcyQy9SVThCdjg0alFxWU1XVzgvaEFMOG84aW96?=
 =?utf-8?B?amtEUUJDWWtnOVNDZ1BkZFowSUNKT1hjNEYwTHZpbGExUUhqeTJXRzlDWXZC?=
 =?utf-8?B?SlZhUDJvSUxlUjAyVGp2VzJjMXBLdGJVZStKOVc5cDgvbjJVMlI1SFo0ZEpZ?=
 =?utf-8?B?RVQ3djFENDBxcnZhZlBrL1l6OGdXakFvajJ1Y2RxUTdlaVJxOXdpRDJYTFJi?=
 =?utf-8?B?clRLTi84QVhOWVRqN1FxYTZKZUhEYnNXNVZTMFFNM2xHaVJyRm94eWlPOE1Z?=
 =?utf-8?B?VzF6NFpLVHJOZmRmR3lWU0FHRFN3azRScG4rM1Y0UHBQWjlydXNsS1hCVWQz?=
 =?utf-8?B?cUtuMjBTM2IzYlFBeS9QL25OcklpYmd1M1VvMXZCQUdZejRSaEhrU3doWUIx?=
 =?utf-8?B?dWhtMEkvSWh3eUNrQW1Kc3hYeTZVREpTUzVlVkFvZEdoakQwZVFLR3hUb09h?=
 =?utf-8?B?YnZ3cVpFa1hZV1ZiSTNlTTg4a2dVdmR1YWJQcnh2aUtzUS9pck5yRlIyMnQw?=
 =?utf-8?B?Zkw2WDQ2WXM4ekRjYVplQkdUeDZPRUxSNWFqVGxQQURPM1pUK2RWdWRJRzNy?=
 =?utf-8?B?Wjl4QWFHSWNORnd0V044d3RqK0RMN1dlWjRXTUFGUCtqSytYR21wZzR5KzI3?=
 =?utf-8?B?aWFHWmtMbmZiRC9rOExjZEhLZXZyV0NxaXo0TGlBWlNPYlZQTUlEbEhLUVhE?=
 =?utf-8?B?YkhOY2hQc1FkZE1raTdMZmZ6alEzSWRHMGVJdlBvUld0UFUwNFlma05HbHRO?=
 =?utf-8?B?SUhVZytubDNQTVNWOUxLL1Z5RXhYdXJud1JDc040bmZIYmRHblJIRUwyc2hD?=
 =?utf-8?B?RVorZThaMW9KdlFpWStMSnFuZ3E2Z3Jvb3RCVUJkTFRXelE5M3VlNDdRQlBC?=
 =?utf-8?B?K2hEMjhkKzNVNHY5aDd3VGVZYmN6ajhJZzN2ajJ4cVVCODlsakVpT2tEa2x3?=
 =?utf-8?B?dlQxUU9Zb2g5Tmt2Z3JHb1hzRUV6OTRoNFpYV0pxZ25mOFh6YlplVm90ZHUr?=
 =?utf-8?B?ZDlsZ0dSTkJCTXlHRTBZMXVBS1B3aXo4blhmem0xdmxyRVNZNlo1QVhFMitm?=
 =?utf-8?B?VkNoa094RWEyUW1nRjdKS2FNbnlFRDZPaWlxQWRmZDg4c0htSjZiU0grRHQv?=
 =?utf-8?Q?vYgkfJzwDhkXGgFsOglHJ2CbK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 18:07:58.9610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09846745-e913-4506-2be0-08de374de2d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

This patch set adds support for address translation using ACPI PRM and
enables this for AMD Zen5 platforms. v4 is the current appoach in
response to earlier attempts to implement CXL address translation:

 * v1: [1] and the comments on it, esp. Dan's [2],
 * v2: [3] and comments on [4], esp. Dave's [5],
 * v3: [6] and comments on it, esp. Dave's [7],
 * v4: [8].

This version addresses review comments. Compared to v7 it adds two
additional patches to support HPA/SPA root decoder translation
callbacks. No major changes otherwise. See the changelog for
details. Thank you all for your reviews and testing.

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
  cxl: Check if ULLONG_MAX was returned from translation functions
  cxl: Disable HPA/SPA translation handlers for Normalized addressing

 drivers/cxl/Kconfig                    |   5 +
 drivers/cxl/acpi.c                     |  17 +-
 drivers/cxl/core/Makefile              |   1 +
 drivers/cxl/core/atl.c                 | 250 +++++++++++++++++++++++++
 drivers/cxl/core/cdat.c                |   8 +-
 drivers/cxl/core/core.h                |   8 +
 drivers/cxl/core/hdm.c                 |   2 +-
 drivers/cxl/core/port.c                |   8 +-
 drivers/cxl/core/region.c              | 218 ++++++++++++++-------
 drivers/cxl/cxl.h                      |  32 +++-
 tools/testing/cxl/test/cxl_translate.c |   4 +-
 11 files changed, 454 insertions(+), 99 deletions(-)
 create mode 100644 drivers/cxl/core/atl.c


base-commit: ea5514e300568cbe8f19431c3e424d4791db8291
-- 
2.47.3

