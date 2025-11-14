Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEC35C18A;
	Fri, 14 Nov 2025 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156397; cv=fail; b=ZCbH1w4uGYNYJsHhomTWPafheMuRa9U/Bf7JznsmtKbSro1DRdtr4uXUhCYn5lDO681Ng/+CvbQ1pVk8CBxQiZSeg+wk06N3iIuFmXwiCxm2nfTKjQdZyLiWDurmDB7df6C1VD9QmIIx2YceKJ9PMUPRSRit33Ft5tKpQYnvQiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156397; c=relaxed/simple;
	bh=N2sN9SRmu18Y5+5lSDPP3e2QZ7dYUj951ewqvKKD2DM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ds/WFrwJ5JaohQmTFi0CIhSU6doKV1pNq0i2JvvVlI1ZuIN73cQsw11op5Ko8BRRtSUfIOeV2S2D14sQbXHP0jnWPCLHLmCE35mxPspYoblSfjKWDIK1poAnwirIVn0YJOqIRD89Pwwwnk3cZV4inpSmdJxEvGGLAS38ud0YIuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tWE1JC/9; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tWE1JC/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgDqY5l97Nv/pMbcC+uOoV2ns10itXHRc0T6ZvGBN4ORNMnI1KiuN1Drvug3dwyTupuojzN8cjMI0WknNqnovoSmbXOMsE4RB9vBHtKUCLiwnem9xRD6XA3/GVFXnl+hqbt6bxpZfkEY9R1Vw+7YG7YM5DK8gWc2xzf03KVY+gWDynvueG4FXGkfrB7ackYt8qc4uTqrEDLbcRAr03UR27MycO6/kTgLZyS5swV/P5O9F53k9zePWGsjLgLslVKyZHE2LDwEJ25aNj5QQpVsNBZpq6tjtBC9ojRuAQDOjwkwZBGLW79MssZHo2z4o/iR5WL3CSulBYTFkltfl09BMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsvHXZKu//jGMyzgXqxMBSpuW4D0KCLoUdL7KUgN38Y=;
 b=cRAuM3BDbpJch9MGbnuv/LFyw0lh8rCgBHnSdILABirUuxw7K1pxf3Fyj/SOyXstcN6e1KkS/0CF96wrI+UqKpqSMKuH9wOAQu5+F8aAqmSgDOnITG1oiYJKDeUvE6M3Tuq3tqrBmQw7MdJdPCN+BESlMMWUeV63/NM/oncY7EXopZ9gGTsVQ78uZlA3Pe0nMh0G6JEcRiFmPRm/Xak2//in00qkG85pTWVO/BLHFQXXcKgao8mdA2TK2TJg5XZaekwZqmL/2fJDrYHaeclQ0hEFik8HGdRiS6Nnlw8jcC8dZHHceLL0TyNimb1vvJr+O5jYuBu2fdSD7OOeRX+gWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsvHXZKu//jGMyzgXqxMBSpuW4D0KCLoUdL7KUgN38Y=;
 b=tWE1JC/9D58YwcWaLk7VhT7TMCrsVJIag6pbND6cw28uDvAygAfe/owaJa8D2Ga7Q7R0+w6xTEccalHblDcXpQI2pGj6HGxXMX1HQiDJ0F6tYu5Ty4cuJern+fYmT2dH5TwUhIt7YfSNI7B6J7xxeyOquHHpcrh8DNe4B272gZI=
Received: from CH3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::11)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 21:39:46 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::73) by CH3P220CA0029.outlook.office365.com
 (2603:10b6:610:1e8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 21:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 21:39:46 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 13:39:42 -0800
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v7 00/11] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Fri, 14 Nov 2025 22:39:13 +0100
Message-ID: <20251114213931.30754-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: ac8364b5-e928-4e63-076d-08de23c654dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnNxZjlpV1V1MTN5QXhLMSt6ckJuWWZjKzA5RHAySHhCTkNHUDNDWGo4RzFN?=
 =?utf-8?B?V3lnZ1lUSDJRd3VWTmVsREV1em44NjY5VUl1bndPM0xyM2d0aHVSZTR1dysy?=
 =?utf-8?B?UUFxc3RZVzJWOFlIdDdHc0ZUaFNLemZTRUZNTmFvU1FrcGVBbjNJZHU4aVYz?=
 =?utf-8?B?SzAxVnM0TW9HbEhTbzl2VE1zOUxoU1Q1N1VPckd4c1U3WkFwVVNlME5ObUZx?=
 =?utf-8?B?cjNpaTlQU2NqZTR4MmYzT3RUVTFJQTVHdDRXNDJoZ2N5N3FLaHFrUkx4b2ZL?=
 =?utf-8?B?YktndXUwYzZObG5ESlJaNXVoQzN3NDFhMFJDQXlKTTRBckc5blRqL3JZRlBq?=
 =?utf-8?B?TytkS0RjdE94aWZTeU1XQVNmYnF5RjM0OFd1Mm8zNkdiT2ExRHJPaUxyN0FN?=
 =?utf-8?B?Ty9vcEpIV1Nhbjk0ei8xcVdiZ2g1WGpMK0RFaDJCVnNZb0VoUU9HVUlFdlFz?=
 =?utf-8?B?Titvc3pDcmY5Z3p0eHBpV0FqMjJLN2tndnphdHNlSXlQdnBXa1Z0TVZNY1ph?=
 =?utf-8?B?QkRpbkhUMEFuN2I2NUxlWjBvaWlIVjUxUFpFVXI2SGV2dFFrY2M2K2liYktK?=
 =?utf-8?B?MVFlMVBHRHBQU21TMUZSQVBtSUQ2Zmh2SWRqc2xRTVNtSktCd2FTSi94SHVP?=
 =?utf-8?B?L2FBQmdxTlpjRk1aVjN4ZWFaY2QvUW1ka0dpc2U4ZjZiUTBKdk9UeE54SW9a?=
 =?utf-8?B?cEJ2ZjcrK0NsNDZVS3RVaUJiTXNYVHpOTDhxd0RSZm8yWEJmM3plZWtjbkpk?=
 =?utf-8?B?dWFtTTNBc1dhTTJ3SnYxU3hpd3diM0JJMXBUeGxuZnZzWlNmc1ZjcDlZWThL?=
 =?utf-8?B?ZHJDaS9XdzZXZktFbkFSTm5zSysrR1JqRjl3ZVhxeDJaSUZIMFY5UUVDMVpk?=
 =?utf-8?B?bkFuR0FpZ3oxL3AxSHJtT0NyMGNwa25VYnR1dnppQjVRWUd3RmlBcUNuVGht?=
 =?utf-8?B?Umh2K2d0MmsveFBmMWsxbjZQbmRhQW5KZldETXAxWXNLc2hEcWc5dDZ3VERx?=
 =?utf-8?B?RGg4WTNVRlRJWTRMVGtIUlJ6VVVTT250QWFsZnNoUE9BTXpXVU1FcmNOMkhN?=
 =?utf-8?B?dTV0MldIS1l4blAzNmxFWUhEYUJkQ241d0EybEpIQ1JLZk1SWmNFb2JNc25h?=
 =?utf-8?B?SXdZbTlMb3IxeVRjamZzY1BOdUpkSFJiRStrUjc5RHA2Wk9PUlh2dFdMRVE3?=
 =?utf-8?B?SjM0ODEvc1hLalNHZEV1dGdSUUcyeHE5WDB2VGluckJpU3JBcnR0T3BqSWVC?=
 =?utf-8?B?QXNjRnlCdUE2RFUwSTFJMVNFL0RwR3oxOWlUaHVHVExLYy9kRzc0a3laU3pT?=
 =?utf-8?B?dDB4THA4V25EYVlzRzd5SC9MdlhvY3pJUWZrWVQ5VGpiTHRjZzBZRlV5UlZw?=
 =?utf-8?B?c0pKaHRkQVNuZ3VMeUZJc2VUcmNHdHBpc0lDc2d1cGdaOWZtWDdjK3dPdGxX?=
 =?utf-8?B?Smp6K01iTWZQeDl2QzBLNUE2ZDBMWiswZnJEQ0loN1VmSGt1d1duQlgrMFFv?=
 =?utf-8?B?MHdRV2dEb084L00wQWo1WGlmckhaTkxJZW1IVlBQWUpoYWN6Y0M2QW9yWXFr?=
 =?utf-8?B?S1ozeG9LT0hieXJLcFB6Ris2SW0xR1FOV0JLNUpBYWgrODRUbkh4U3pkNDRU?=
 =?utf-8?B?Mi9HRTUvalVUWU41Y2lqMGVYbWRjSk1NM25DQ3oyVzdUK3lkWklCN2FDZXN6?=
 =?utf-8?B?SGl4M1ZpbkRiWWptRWNMNk9iQ2lDcU81L2pvZkpqaGh0Q3FaN3B5LzBHdDRk?=
 =?utf-8?B?VnhGVys0ZGZNeTh4Y01sZEF2b25lcEs0R05oVzVaTmlNeWZ6T0ZLWlRhcjhL?=
 =?utf-8?B?ajdWVUVCdjdBWDM1YVNQRG9TWERiNTB3QzFHeE03OStidDJZN2p6NWxOenBR?=
 =?utf-8?B?V0hvU2JkaGw5STRXUDh4VGg5Smhpa2I2cTRLRnpGOHpuZzExZDRoWEdrQ1pP?=
 =?utf-8?B?VWhBc0c2SmREdGlxNGhGRjBoTDFMOUNQUVFTWHM2WVdVanVUNy92enp2UjFD?=
 =?utf-8?B?ZG1CUjVYOUZmdk9XSzNEV0JJSkpIS0taVEtlU2xHejRSMFJsY1BqVWlqb1pZ?=
 =?utf-8?B?b1d2YzF4QU5EVjdvNmVPeENlSzRacndrWjVNNGNHYXJsZG8zSjNBYkhmME1a?=
 =?utf-8?Q?5cKU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 21:39:46.6856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8364b5-e928-4e63-076d-08de23c654dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719

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

V7:
 * rebased onto cxl/for-6.19/cxl-prm,
 * reworded comment and description of 11/11 (decoder lock),

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
 drivers/cxl/acpi.c        |  17 +--
 drivers/cxl/core/Makefile |   1 +
 drivers/cxl/core/atl.c    | 215 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/cdat.c   |   8 +-
 drivers/cxl/core/core.h   |   8 ++
 drivers/cxl/core/port.c   |   8 +-
 drivers/cxl/core/region.c | 156 ++++++++++++++++-----------
 drivers/cxl/cxl.h         |  31 ++++--
 9 files changed, 364 insertions(+), 85 deletions(-)
 create mode 100644 drivers/cxl/core/atl.c


base-commit: 7e71fa6e015e46275efd900a728a42d5fcd75179
-- 
2.47.3

