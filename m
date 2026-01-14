Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E42D2441A6;
	Wed, 14 Jan 2026 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409355; cv=fail; b=VyOHsFM9cE6ZagnVEjyxH7RTKnHk/irJBVKL63o1g8wH8StQPGzPofpXQO0ELIVQiT9VKoA5WJx+zZUA+IMXIVDDGmLNI3zZ24jwTg0VErX8X6ulTbdtZq9QavkqliPX72xUTBaVT582/dZXcIcug1rQs7TSCK5qAzOm4P0VUYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409355; c=relaxed/simple;
	bh=vZ+u0DJM6dK3Od8fH+Rw5FyV20CHFps6iFl6tYJgYw8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ViUkdRrgdUxTqLHcEeKvwnISuvPZNmK9EWNRq17tLYsJB1CRA8jPxAQHtScJloyd9QxH3Y/gEOR/urScnzU+wtrkonNkFLuBg4nLU8mUX5Ze53UsvY/l3trArmcJVbHEuxax+ospY+2FZAv8Ad6I+JkYeRi8cdDfpXVEISELtTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jP2UhN/G; arc=fail smtp.client-ip=52.101.46.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jP2UhN/G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if6gXrlURt7C06VJtGlru9RxgxuUxdSJCrjDnsDx54PR89X6n3MkP+OPEgK4cGKmX1pSG+g2MmZTVhHJsgvRSXj3SvH5bLJ0If2NKCsfJnJVA3fWFKrjocgdGN9BroFTJurLHz9NFh+AfEeU8tsl4AdAXMdLj/3DF/Id70ZO01O42D00vB6smTxP/J+FbmGWRhYBCVoeTwvfPZFZHW0jyFG1iq1JWs/6yP7+Y+vRbvdVsUEcpuP9QEmNAoafCWX63+U2HLeu2ifMmO194T/+m67er/dHnUH4qvkQ9/cFj7JK3lBnOiJUr+Bm4QAgTVhZqqAzPWY7x6/UF8BZpI7Icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHsy24O5mmKoTUXqqfDUSr7zFS2Kww6wVKE00szzsAs=;
 b=NXTIfNtYpffurxdchdpTjIQkYWdLo8qcAj35LMLVkgnXhusLbZZ8vz71EEHHjXZdy12FOCZPivNs/yzHkiDpn4/X/KcB/Z5BfhOTaJqilZlOPoINmxlPmDZAzHLd0HahTYvub4RzYvZG1QORR4KH2xW7b+d/lNTTHFP3BH+zyn1U41onL02KR8e0kseyyUPGazwQlG4a8iwOVHMwQJxlKw5U3mBhMuhB6jBOJHla1yoV6X4jdexyhpaXcvfNJaUwvK/uiAhykW+/Nxd0qy/NnOfkb+vt8JWso+jXN0SUnw+qM7ytZ1tIM0qO08RpNj5wqchM32rMrJqWmzrIR+NPoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHsy24O5mmKoTUXqqfDUSr7zFS2Kww6wVKE00szzsAs=;
 b=jP2UhN/GKsbRohA18COyZXAR2odk4MBeExKaQ1GjnI5I3HxD1w1D6Hs1dqXTTActWrllZiWcXldLFnkEeX2qdwfMuCCDgWGGO2AjSLG/amVGCjttMk/5GGCUBTCx12xkCQHF7ToXmeU/xCHyanhX/f7Wmf3/+cet7H+TMuJ/g8w=
Received: from CY5PR13CA0077.namprd13.prod.outlook.com (2603:10b6:930:a::34)
 by SA1PR12MB9514.namprd12.prod.outlook.com (2603:10b6:806:458::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:49:04 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:a:cafe::35) by CY5PR13CA0077.outlook.office365.com
 (2603:10b6:930:a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 16:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:49:04 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 10:49:01 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v10 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Wed, 14 Jan 2026 17:48:16 +0100
Message-ID: <20260114164837.1076338-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SA1PR12MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 530e2b94-9125-4f6c-e244-08de538cd3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjlES04wcDQ4WURlUDVEVUtObkJkUC9NZnNTTWRGMm1rV2tKR2hpSEdTMUpz?=
 =?utf-8?B?enBBeEFQdjZBREVDZU1Oa1d3ZzN5clVZSkIwZkpITmdOYVYvczNZUDFLQ1B3?=
 =?utf-8?B?UnorZ2ljenlleXR0bGpUYUdnNW5lTnNYSmV0bjgxSHF1c1ozbFB3eWI0dHA1?=
 =?utf-8?B?eFNlSENUb29VdnFRK2luMTZGQUJFdWNlbVI1UXljdFpBcWNrekJ3ZUxvVW02?=
 =?utf-8?B?WU5ObFltRDZySDdCQS9POE1KQ3RNeThFZUJTOFBJNENudmdGdGRCYXptQUNs?=
 =?utf-8?B?QytiaHVKb3ZBU1grYWhVSzl2bjFpcjZEUjUzMlAzVjhrR3VtS3QwOGJNWmZi?=
 =?utf-8?B?KzF1Uk1sMGUrUWpaMTdsVTREaWV4ck1PTnh5dXlLaDVQY3ZFZkZnQUFVeFBC?=
 =?utf-8?B?aUF5ZS8rQmM0Nm9YMHBSNEV5eWV5bEZ6VDl4OUYzdU4zbW9kaHpuR2N5bSt1?=
 =?utf-8?B?WXRROXhvdEN4aThFSHY3eG1oWndZcmd4ZytyczlyZk9LSWdZTHBBZlh1U3V3?=
 =?utf-8?B?dUNURjJnWENPS2s2OGFCa0dZTXpaQi9MaW1JaklSOVRoYXhFMk1neGlXZzhk?=
 =?utf-8?B?TjNnUmliS29qWm9ibjdjZU1lUlFVRWFnWUc0MURMZWpOS3kzdEZobEhLMzlI?=
 =?utf-8?B?L0Zvd1ZaZGV4TEloVFo3VlM3dFNxRmxLVjEzUEF0YjluMFlQT2lwc0tHVFp4?=
 =?utf-8?B?YWljT0ZJNFpSc3QzT0drTzgwQ0NjMWhKZW5SdVk1WFBTdzZ4K0VLNjRxVDND?=
 =?utf-8?B?M3FtODhyWlo4UGxYOEx1bXFCZERpc3VwbGtkdFFLOUdCKzJWdHRRU2JDSHY2?=
 =?utf-8?B?ZlpSNVMvejJoaDF1VXZyKzNZRGFRVjhMcEpCdm4vcXdJcU9NOHpLY1JMN3VL?=
 =?utf-8?B?T2lueDY2OTFTK3IzanBMdGZlUDhoQ1VzOEhRSS9FdFlQZ285MDRtWVgxa2g4?=
 =?utf-8?B?ZlY2aTVoeWtlY0JVNmc5NWRtZVdTOXllUGxrZThxcHhGTUtNTHBZVmV4SHVp?=
 =?utf-8?B?SWVqL2cxemUvNHFyU2w1QUY0Z2FmelBJdUl0RFByL3h0ekRHcFFzVE9DMHdU?=
 =?utf-8?B?NjcwckxVa3lnQmYwNkRFei8yNnR1M25HZ09LK2UzTDBmdDdKRGJIYXBMMGtV?=
 =?utf-8?B?VXByaVp6OVBnNWYrblhRR2xtOWo0cWk0THgwd3VwRDF2a1hXZTh3RXU0U0VN?=
 =?utf-8?B?eWZKOG5Fa3ZoZEVkMXVOd1pQMFczZlBUK3laaFo3dkxQci9KT0xwMlB0Wk5U?=
 =?utf-8?B?NURGcjRPVGYxR3JSN0JYek83QmNtclBtWUUrS3JMVVU2NURRT0szaVp1RE9N?=
 =?utf-8?B?OGdodHA1M0IyNU5MUnh0em92eGM5LzFIUjFIR0dJNzh4QXljOGZCdzJYQ0dZ?=
 =?utf-8?B?eFJDOHBGTVoxUWdjSVpudXJiV2kzbTR6L2FEeVM3Smtpb1g5Mjc2U0F4ZWhp?=
 =?utf-8?B?ZXZqWHZTd0RkWmFlZTBadzRkL3phaHAwOTVuY0g0QlE5Vmp2bFNtckVscTU0?=
 =?utf-8?B?bGphK25SbjZsQ0ppbG84ZWJOWkxoR3FkUXYyUnZSMWJHbkl2R2F2ZXdiS2lX?=
 =?utf-8?B?ZWdNcUNpbE9kdGk2VTJhQW4reVZlRTQvS2tZUFc4dGcvS3oraHoyRm5zaGUx?=
 =?utf-8?B?Z2xIYmRHWEZVdkhHZUk1Ync1bWdZd1R2aytHam1mZ3NUbGN5QURSL0ticU1T?=
 =?utf-8?B?cGdnVzlWNUhkWmZtRVI2TXBDZ1lhanhaY1lGakhOSFRsN0pMUjdwZTRBYXAy?=
 =?utf-8?B?b21qVGh6V2tiTFVmcHFSbTJkTSt3Q3BUbyt5enQyMWxaOHJtbzdEZCswSmdG?=
 =?utf-8?B?enFHdFkvYmRKMk1xMU5WZXZsNGlmMVlIOEN1S1JyNVJkOCthd29zRjZhdHFn?=
 =?utf-8?B?Y08wdmJTYkhDSDFWczhMQktyK3krZWkvTnpkMEswK3JTbmdib2dHMjVlaWZy?=
 =?utf-8?B?RHhQSjhxcVlPendmbENjWlNxOVo2VjJmY09VZUQvamR1YWlJTHRmbkl0bElF?=
 =?utf-8?B?dThLMVM5L2hSeUFFTGZnUUp1NW9tbG9Tb1k5Qi8yY2F0empWZFpJV1Y1V2M1?=
 =?utf-8?B?Ym9jS05aaXNwaVp6M2VKcEpQOWFXZUs4Rjc5ODRkQ1p1NGtkZjV6RW5QZU9U?=
 =?utf-8?B?Y2wrRURQdW14Wmgwam5SMU5Bbm83UWhqQ1dYRG5iRi9ISU1VUmZzakNUaFlL?=
 =?utf-8?B?ckRjU1QvOWIwRmx5OXJqeU9YM0R6NDhCL2srMG5nS0xWVUFCUCt5cUxrMXlM?=
 =?utf-8?Q?fbyuMyl68VyK7rZz52EmIjT/lOhGQyW5K6d0EbUXwE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:49:04.4288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530e2b94-9125-4f6c-e244-08de538cd3ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9514

This patch set adds support for address translation using ACPI PRM and
enables this for AMD Zen5 platforms. The current approach bases on v4
and is in response to earlier attempts to implement CXL address
translation:

 * v1: [1] and the comments on it, esp. Dan's [2],
 * v2: [3] and comments on [4], esp. Dave's [5],
 * v3: [6] and comments on it, esp. Dave's [7],
 * v4: [8].

In this version there are a view minor but no major changes. See the
changelog for details. Thank you all for your reviews and testing.

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

V10:
 * updated sob-chains,
 * renamed flags to CXL_*_F_NORMALIZED_ADDRESSING (Dave),
 * fixed spelling in 07/13 patch description (Alison),
 * be more precise on poison support in 12/13 patch description (Alison),

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

