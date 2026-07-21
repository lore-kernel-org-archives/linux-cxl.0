Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4983911CE;
	Tue, 21 Jul 2026 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623221; cv=fail; b=rb1JKJVZhcL+AMVIdYlWO0qJBj8qg9vxTyjkBpBVyyxlpqaV5izRl4gGKVko2U7ep121iEkgDeeM7RT0LPdxybIwaN96rGxDCYMq6SvooWZVRi8ztLE5G4N3oT+FJKyiq9Cr6+ko+wRH85+zzrqP4JGzTMq+vESkhJV5dowcnfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623221; c=relaxed/simple;
	bh=KrOQY3U33OyFgeiVzw0eXfZXOgDgMWpnBY3L64OUCtg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HKhuq/HvLCh0z+EoA7yrxDxolRO20OTyB8LRpqTQm6w7hkvdPG5H43F2gYdshHMjNnEagTiHrNB4kmt19NBMQFSqOcMH7XnIdFaw6F41C6GUbCTkzBT6Or71IwFCFLYnt6SEe81EONja96WCTOZDvrHGvKCHSa7D4qeu193y+UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FcPUP67G; arc=fail smtp.client-ip=40.107.209.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FcPUP67G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqDO9ymKJK1YxZq/TnfmOwp3I/vFiOCFGy4Efgn7OESwA4jidoQT7BbqyJ8LvDul0aFB2fuiuRseB0wFQtYf+JM12DtvqGC/zL41qYbXDuvG+afTruxhqFSgen9AiX52r4zcwkMI0We72VF9CtMEq8piGkXmYDrG411K7ftd7M8M6gz9ZaBo3cpEQhh3BD/1Df2xP4SMh5S2Pw8j7Ups59jK2g1soTDQvFxmlE8/Hc3QvkAlFX6oMbKaaupH2pOxpXtv++ozRq6uZXgmuBaxPCz5KJuSH42L/dibSzF6dVhhVvW/JttpJ8zgoeQTiY3s7A1buUsKjs06fl4F/ZHJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSD7WmqQB3oij7nrcamkZtsFazdQN231s2pa10tohtQ=;
 b=bk4GgdJTLbnKQ53Kmonn4EfWkmHQ7aCf8/+20f2XTmkh7owtU+fre+PMczYpAdQdYkSkZhi9CG3KApM4iH6b3f+Kjwc2S7i9q5p1JC9g3avYqj/yh8mlI17yUwYG2RVtx8dgoVKADIzXC81v9plvYYdxEHwoO83h5Ob3H0htPDHdOypM15FsGU1qJKbScRbPmZdcGPbZVUi5ZPZYmTI6mIR7XfeS0AqixnIL/bHhPDn+SK2TXgSIQoQnBoDR8FkXL5Keg8nhmyIsRLo9+FDUDXCXzF9wGFVRDFvx50dlq9dL54/pZ21xfEwOZch/B3FCwBpMwjdqHmWe8DP1yNN1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSD7WmqQB3oij7nrcamkZtsFazdQN231s2pa10tohtQ=;
 b=FcPUP67GOcT4GoQvuq4xC6FZQHdSB+t2EN9yh+s9WlvxkV3g9Bn/4ohAKjpF6v/Vmmop/rRdN2DYOhMj9MZSxGhYv/RZIJyls9pc5kuLFVrIfiuyDxVyevIUwv98OXV0Eqk3p4Vu4NA/Xu+MmRTaWDdqrN9A75OVGjpiraqALjHFTAgbNL0h21zcmR2h/4ebDM28+nTXPIH7SaYVl46GapwqvfVdEv21uZkxoba98mteWJneqosmASSnfM1UKApVfNMZ6y/rtZJO6X0OdHUD4eBI+PGX3Uu15vGE21kgg4argkGu9PvEalMZxh8tBFSygpnWHbweGl+MAAK9b5PvuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 08:40:16 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 08:40:16 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH] tools/testing/cxl: Don't wrap cxl_core's own exported symbols
Date: Tue, 21 Jul 2026 16:40:09 +0800
Message-ID: <20260721084009.38100-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0045.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a52a42-a788-48a4-3cab-08dee703b00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8kYQLS+Y4N/8VcCufbGNtQxgjSyF0szCk+WN0Dw7maDSwgngDZZNvhzEqdoP0dffS1c/V1iOxNGnC4nfmXEEIi9DHMu4N+W/h7SIsdWQ6WfvynHBAhuzIFxJduMq3nlH+IyBMNbiFPm4XNlxSl9AZ82DIliLNG9YI6ao8FTDbu+97v0RAml3HHE22BUjoSNlxPT3vtqOyKOdutCF1Mgps1xnrgPDow/nspwtpv02mzlAkpFIdHQHiYRxgxRTIOETJaRlMopW3chZHaTs0stsn7dHvrmd2OJ8AxYAipYjUm7/c5CSM0Cp+y8lP4hhhnqYSiuxVV6OmC12mT6239I/sUk9uHzJ8TSxnJmMSeTrF8U7YSdm9qpOymhZw6c7Xfj0/1m9ckMffoula+HtpDDgVHRbXcYgSvQBAPobmlzFDlBL5k1PAtRCrpcoEEpdF+GmxcpND1MxbFQcRzxbjP1lF0CU/bNGx8/WfnGhEBYcIyS8JW8D2Q6ApmygFVdmPLIFTGu326+sUFB1C/NsEAHAPnI+fY0ijOsO6sX2B1DSfmK8Om9QSC494s99GEROVa/VEEkve7e3Ed1UGxOKwJcJXE8DMLrBzM8Y7X6SxIKhOwJI7wKcMYBVDFEBeJ1kUN6kToBJxUElb/0WM7yxC8YRlOE5wugbw14z6nEGT0/+hzQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NI/WbmCkSuyLO/gOGKlKDDTggMJT4RwKh+0jnWn8EWzbCwKgVlBZeDfuGaA/?=
 =?us-ascii?Q?1A7sN3RwDA/TmT3UEuRriUrk3psoIXIYvv/bTFsD2ltegDNE/cmprnMNPz1h?=
 =?us-ascii?Q?PFyxRLusH5LCWENzos9/lo8dAeddiPdHFmhwkUgLr40k58ficM+fHJqbZE9R?=
 =?us-ascii?Q?gpJngVKz8UI5LUtsUdJ0hSgLo/FPshUZWorWZQLx3JoLxqHGjNUsyPbCM/49?=
 =?us-ascii?Q?OIcSsxwkXp1X5STT1f684gUZy1tBcR+X1yMv6js4hm8AebUJm6GOJZqBcJR1?=
 =?us-ascii?Q?MyDgaj7xwL+BtYB1L35l3gYgF8NVMVB2hY+A6sjPBqkLXcglXHahYOYZE4Fi?=
 =?us-ascii?Q?b489RXuTP+holHx514MAZIApubE9cv01/sYWQji/1z6AWrgkzCgWIfPcCQGa?=
 =?us-ascii?Q?fp7k3+kGr4zv+iQDjkNz//51kUBOatNqNe4Au5gMheo2+iVLxJX9d712CT07?=
 =?us-ascii?Q?LclyEStfef8hL6YBtc0a/3/9TqoMUSESgQHTL9GJBSd1cBOUZakiatRNBsVs?=
 =?us-ascii?Q?/jxsMwxrWpk5bnPXOhUDVPETjgZkAjXQtw515yj3WLujfz3QQS+8td5HZang?=
 =?us-ascii?Q?QPj4372CecCQEZ06NmOkvFEbpmuap41MDfoPcdHQ20Lunyq0fL+s6HZmSXtw?=
 =?us-ascii?Q?V0zUUdi6/n65kodt44QrdDr0youtqwZx61gn4mFlOVDKi01kvu/vFZfqREmT?=
 =?us-ascii?Q?tjYOcmUS0JTUvobplj+zVBy6G5/DoZInpRdthFmNupTjSqxCO22AUZrhOSyI?=
 =?us-ascii?Q?vJAuP8qp/TAmZ37+fSzXTqm/5frSWHarSv3NtFTuvKLU5Tx7I5cym+xjZIaT?=
 =?us-ascii?Q?gLVx4gzYS6HUTs6suy7jGPWq0+PXxGH0KfUIN5WEHO4d6KTUEoXtTQKhUSXk?=
 =?us-ascii?Q?VFG2EhkWwmfMO6E3iGZVDjxhXY7ivx2ZN7xD/74s7o6tzdA2P8QihI6H0Aee?=
 =?us-ascii?Q?PyEWQS7kVp5YCWhWBVF4F6RS6QnuwrxxOapsXfy5RTJnCuMzgvXPtVh0nUAX?=
 =?us-ascii?Q?8dCQvvt8cS1ACHcq4yZ3Az0FNli0cWSP4bbdfinBIkWxzLfQOWVEdEAB+7WM?=
 =?us-ascii?Q?ocjTFi43A7HGqWq1uTYK3AYmnUlmk33Po2BpuLcXxQPz5ZKANhL74PhRbb4J?=
 =?us-ascii?Q?3uBzyTh6NTrdBmIutd5t37J33ktdzT+80xi/j6RS8yuEDbRKv5z/w9PsG1Ym?=
 =?us-ascii?Q?XYOvWcGN7i4OaFzrOYzKQVrO5Fav7HuyjtUwrL9Qwb86c1MNcGNbbLBc2jFv?=
 =?us-ascii?Q?RQGId7wcOnjKMyY1DI1DXfvx0o9XJAlwCTGfWF6a94kLU+or7E6WDDDBY5ym?=
 =?us-ascii?Q?DFv0V16J6P9sftBAahaFjsoUMoGNBY97diuJ0vdyvMtxaZutngknQXX2BQ7k?=
 =?us-ascii?Q?C70906yL+yMN8Da3CL9Wiml7l83phlaADRW+Q3u1UN81dBKrIPBp1DDdgL6Z?=
 =?us-ascii?Q?3nSStuf3NUgyAYx1Vrno/sGMjuwte/Fd5rbDodZunNxWoAYPJDY8/O50hdhr?=
 =?us-ascii?Q?Mfr8VTPtMA1u4g4MLBiai/fdOBlIqPUtNUjhXlZsxlrBdWth2YUWx1GMIUGH?=
 =?us-ascii?Q?AeYT6AiRMn7SO84KGrgO9aMfolrUMGfRtg9gNGByKyzhINdmW82lJP98wLBH?=
 =?us-ascii?Q?KhQkU3OjPzMpungNQmRS/trZz7LgtGpS+72LqJiN2IASdOMqNZnBp9VDpIvF?=
 =?us-ascii?Q?imRUsqWDw2Cp9hFz1QZ0k7vxygLXVm06WPfSg0BB7IUDnoE/2FhJn+Afr8mn?=
 =?us-ascii?Q?Cvs0Z8XIXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a52a42-a788-48a4-3cab-08dee703b00d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:40:16.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3qkCbuLb9PuDtu5ixUPfnf0/uIGyhl1zDQIlmIAaNjbpngHuRYm/StuUzwkXntpDbTDlwmoc1+sBQqEDncS3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779

Building cxl_test with LLVM=1 (ld.lld) fails in modpost:

"""
  cxl_core: .export_symbol section references '__wrap_...', but it
  does not seem to be an export symbol
"""

cxl_test --wraps 6 symbols that cxl_core both defines and exports.
GNU ld only wraps undefined references, but ld.lld also redirects
references to defined symbols, so cxl_core's own EXPORT_SYMBOL entries
get rewritten to __wrap_* and modpost rejects them.

cxl_core never calls these symbols, so wrap them only in the caller
modules via LDFLAGS_<module>.o instead of the global ldflags-y.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 tools/testing/cxl/Kbuild | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc9..e49ce644b4b1 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -4,16 +4,20 @@ ldflags-y += --wrap=is_acpi_device_node
 ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
-ldflags-y += --wrap=cxl_await_media_ready
-ldflags-y += --wrap=devm_cxl_add_rch_dport
-ldflags-y += --wrap=cxl_endpoint_parse_cdat
-ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 ldflags-y += --wrap=hmat_get_extended_linear_cache_size
-ldflags-y += --wrap=devm_cxl_add_dport_by_dev
-ldflags-y += --wrap=devm_cxl_switch_port_decoders_setup
 ldflags-y += --wrap=walk_hmem_resources
 ldflags-y += --wrap=region_intersects
 ldflags-y += --wrap=region_intersects_soft_reserve
+wrap_cxl_core := --wrap=cxl_await_media_ready
+wrap_cxl_core += --wrap=devm_cxl_add_rch_dport
+wrap_cxl_core += --wrap=devm_cxl_add_dport_by_dev
+wrap_cxl_core += --wrap=devm_cxl_switch_port_decoders_setup
+wrap_cxl_core += --wrap=devm_cxl_endpoint_decoders_setup
+wrap_cxl_core += --wrap=cxl_endpoint_parse_cdat
+LDFLAGS_cxl_acpi.o += $(wrap_cxl_core)
+LDFLAGS_cxl_pmem.o += $(wrap_cxl_core)
+LDFLAGS_cxl_port.o += $(wrap_cxl_core)
+LDFLAGS_cxl_mem.o  += $(wrap_cxl_core)
 
 DRIVERS := ../../../drivers
 DAX_HMEM_SRC := $(DRIVERS)/dax/hmem
-- 
2.43.0

