Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14A33BBD2;
	Mon, 12 Jan 2026 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252258; cv=fail; b=I53o3uPajCVaUohLiDeHLwL4Hiva4UI7sccUoltDfLrzxCj03DGHHPqknp28c2XTv0iFD4r3e8dDdBC1uoU3PGibnGLvP3WqVkMxrUCiPvqq/7S4pcP8LKh8X5E5PxWxhEJKKlwRHZeDTciQg/CBtQStnUng8YCouLBElZWxSl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252258; c=relaxed/simple;
	bh=kBhFzLOQvsBtNoUdM0v2UWyX/L2EnbwyioG/VvXUdYo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=jO1GYU9KXN5KBcai2A8BE4s/L5MrMIelpvUgiiIY5keMa7G5Hn3csNPUZPdg8Pbx7wr3YT/2XqYCR03C/cJsKKwmeViNOr/IBCjTZNbDtDSzWHHkR8Oz3SBCei4Yrmvokm2HJ6ylpR+8ie7qnBTlkcQ5ZD+I78nReao0VpYF4TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LxRX87B6; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LxRX87B6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwUIr6Q7yCnufXIqxu6GpeRcd2MYJVOdvQIbxoBiC4bLuORlufvp9cLkMLSBcEIrMlk8KDSe0UJzgV8W5zCzb8JlkD1GAentnksS2uo1qzJamHMsZn9+ixnO2XsTmDUpjM3eCC1EKdACsmADvXEWiuy7w3BJW6s3ur9HxcjHh8yerP5G1cE/w7MIi+7hq4IHO4XkBytE8vcgnoOli7/O8amHABkw5x/PkTrGT6b/h1gf3MOnQf6EJ5LwQ0xmgruDa2d7aumQjekVHPDi/+cFoO4sWvse2xHpItTiaYnOUUYg1Jfy6H4z9Kavms3EzXh0WvqLlk3EcvZs/HDZQxs32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2H28MORB60WhoCEwuUdODhOtw11eqV4Vxgw49CveIhI=;
 b=Q2cotE0AP6d1858LGk/K49IZnmF3/gLRUfr0Cguj5khFCATicBVxyLeoQULOKgN3tRxfACRyXNO4Yu3bkwvMGjhRFl/MZxMVbNUcMUb/tTZgd2YZEmHl66FM9WMoh/I8EODv2kHHTUlYtDZYXZDP1uuui1TSbKkpiyLwfBAEKpmAQFja9fwgcETKrtI1ELoxEkztfY4i7RVdD4GhCMRlC85QUzvzsb+b0MFNhJiBI1JK1gWCXteyYy+Ykl12/yMQCY9guT/69Urp0bvVUUn3BXsiRCiqlAO5Ga8EpC/9tZdSCUD35H7O+3/R6uXkpaiydcHgk2+3KQfDmBLtUItnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2H28MORB60WhoCEwuUdODhOtw11eqV4Vxgw49CveIhI=;
 b=LxRX87B6fwBimzNzIiHZLKenx8N2pBpTTr8PHExcw6JbncxD1QztLFfHuq+uij6KYq8eMuryoZGrYn/+dVWHQvW0ee2YqcSl5Afa6jDL+3RnPz3mGqy8ZDwlWYwsF2jHngrqHRW9ID0DgM9eZF3Tabih7DFvwnR+DsVP+jWDEFc=
Received: from BYAPR11CA0063.namprd11.prod.outlook.com (2603:10b6:a03:80::40)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:10:49 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::ad) by BYAPR11CA0063.outlook.office365.com
 (2603:10b6:a03:80::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 21:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 21:10:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 15:10:48 -0600
Received: from [10.236.181.95] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 13:10:47 -0800
Message-ID: <1b9d3e1c-7b8a-4c9d-8788-4f901f985079@amd.com>
Date: Mon, 12 Jan 2026 15:10:47 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/6] cxl/core/region: move pmem memctrl logic into
 memctrl/pmem_region
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-4-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20260112163514.2551809-4-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a32e5c-3338-4fac-0b8c-08de521f0f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFZ2Yjg4Mzc4OVJ4Wnk0eVhoeENaK0N6WDdOZHgrRGMzR0hmTXNYRHdrWFY3?=
 =?utf-8?B?VXp5UjVLUHZ3dGNsaEVMSFowQUVRM1VWQlB2eWplcmo3SkdkZFM1WUhYOHpj?=
 =?utf-8?B?ZVdQMzZrSE1PN0JtK0JBZi9yQk13TW5BaTBQUmJpL3NOK3NTL3cyS3lzWDVt?=
 =?utf-8?B?dnRGUEtoaFdTbThtQlB4S2h3ZnFybmtnRm9TUUFaVU1ETHQvcklsRURJK0tQ?=
 =?utf-8?B?dVZQWjNGMkNkbWl5SngzL1Y0R2h5SXdEZFNsd3l4MTBRRC91dmI0TGtySVVJ?=
 =?utf-8?B?bm1PNm8rY05uOVZienNQQnJYUDhrNGNxVk02ZVVGajlTOVhOZUgycVgrTXBy?=
 =?utf-8?B?b09Qam1UbGVPQ054V3pDZmxJUUFOVXg0SWsrclNZRGhDMm5qb2JzeHJ4dzgz?=
 =?utf-8?B?bk9ocTg1Qy9Jck9seHV1Nko0cUNMSGxDUURQdkJrc2FGNnFjY1Bja2xUMGgr?=
 =?utf-8?B?bGVmMmtqd2xqZ3BlWVdmblJqU1VEcjNMZndoc29PMURjVWNISkhHTVRudnlv?=
 =?utf-8?B?dFhTZFZLQ0IrN3ZnOTk5Sk0vVmd3enJyTm5zVzZ0b2tvaTcyVlpDWmVydnBH?=
 =?utf-8?B?cFFTZGFNNjVOdlUxOGQ5NU5CeEMzbm1mTlY2bUV1czZpOTRhWE1SUk9NSGRU?=
 =?utf-8?B?NVljL2IyblQ0V01xY3dXUDNOMzRnalR6cFEyWVlwSTVOUlRnbGY0ckhQWUk2?=
 =?utf-8?B?QVJJRkRXSlBwU0tjUzBOT0hod0FxTjlpdmpHMkpmcmx5MEJUck5HTzdUV01a?=
 =?utf-8?B?YU5ENnRqallkMUJqR1dzS3F3VmZzbTQ4NHVXbGM5TzZQTU1VTkFzM2ZtUkd4?=
 =?utf-8?B?T3dVY0dta2V3Sy9NT3plNHlFNVJuNTBHUVdTMlhMRGJEUFkrYmJKV1ZXWFM1?=
 =?utf-8?B?SC83ZUtlSmpvY2Y1MzBFOEU2UnpNcW84S2orWTl3OXZ0Q2FxUlpVMmc1S2Uy?=
 =?utf-8?B?OHJuSngvd1h5RnpaYjh0U2Z2U2V1NUJqQ01NaWdqeHFJOUdEMkFQV3UySlpa?=
 =?utf-8?B?c2w5aDlrUnpiMHpIWjVwRkNUTWw5blg5WnJ3dmtVdTBNVFB3UFVYbEFEMHV5?=
 =?utf-8?B?WFRWendYSHBjeUVNd2tuOXZXNjZucHlXeEFlaVhPZjBpM09nbml3S0ZYY0sz?=
 =?utf-8?B?cXNEMTVIOW1sazREWjIrV0ZMSnVzSHMzQVZWdXF1YWVFOGlXZ2g4ZDl1Qmt6?=
 =?utf-8?B?VWVuYXJBYzNBejQxZmx3UWtsa1MvTngzZ29BOUdYTHpDZm5PbzAwZmlXYVhW?=
 =?utf-8?B?c2RJSFdMeWNLQ3ZwQ2l4NUJlZHQ3bjBFUk5CNzN6aWJjbnJFT0tuRDk5TUFi?=
 =?utf-8?B?L2hxZnN4K3VkaFNva2d4YWJPOEU3TG1aSXI1NnBFTi9HempxWTVVS3RmbHJs?=
 =?utf-8?B?Y2JSMjJSWkN4UlpzMUI0dzNlbWY5U21nTGxXZHl5NUU2MEY0d3Bhb3ZUVUoy?=
 =?utf-8?B?NFpTUlVOdmdCTnp6OGdBOGk3c1ZIUWxwKzU0MGo2cTFGbzFkcFh2TzBiNWJr?=
 =?utf-8?B?VzBwYW5waXdqOWF1bEpaRHlQeGRIT0FOd25XSy9MMFpDQ3o5WCtULy9nN1J4?=
 =?utf-8?B?VUY4NkRiWU9Db0RrNFBKMjdvNnpGYkVCdUptVHlrbXduSHBJdEpCMTM0N0dL?=
 =?utf-8?B?eWt0SmR6QVlRVmQwbVNVRG9DV1pzaktrQ0NEZ2ljWGN2NFBGazFOT0Z3TDI3?=
 =?utf-8?B?UWRYb1UzdHlKN21KeGQ4UDB4UTFzV1pDSlRVMDhoNW40ZC95WU5Oczl0WTZQ?=
 =?utf-8?B?VjN3TXlSM2Y1V1RYbXcyMXFCZTFkUXo1Tnd3OEJzdEh6VTR1ZDhQUnpxQ3VG?=
 =?utf-8?B?dXo5bDVFaXFrMmtPZDArT1Vpd3VKNjZKdDVPUFpMYU1hcmpmN2dTcm9NajZC?=
 =?utf-8?B?WGhYdnBObkRCKzMrbTNqM1VjOUtEVUxWWEt5Vlh6RDhRR1VFTDFsZE45STll?=
 =?utf-8?B?c25EV2hta3hhbXlPTzZDMkVTSS9GbnhKNmVUQWl2RkpkRW9aWXV6L0V6UEpS?=
 =?utf-8?B?TkZ1Q0hPT09FUDFtRmVtdXF0cjhYdk9xNSs2aDM1RVFrL2xKWjZ6Vi92Q3A1?=
 =?utf-8?B?MklxMGlocVRpaG5xcnVFUVlJQmUvaklXc0NlOWpQbWR5MVU0VlNKOElDbW1t?=
 =?utf-8?Q?1hks=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:10:48.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a32e5c-3338-4fac-0b8c-08de521f0f62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

On 1/12/2026 10:35 AM, Gregory Price wrote:
> Move the pmem_region logic from region.c into memctrl/pmem_region.c.
> Restrict the valid controllers for pmem to the pmem controller.
> Simplify the controller selection logic in region probe.
> 
> Cc: 

May want to forward this to whoever this Cc tag was meant for :).

One nit below, otherwise this looks good to me:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/core.h                |   1 +
>  drivers/cxl/core/memctrl/Makefile      |   1 +
>  drivers/cxl/core/memctrl/memctrl.c     |   2 +
>  drivers/cxl/core/memctrl/pmem_region.c | 191 +++++++++++++++++++++
>  drivers/cxl/core/region.c              | 221 +++----------------------
>  drivers/cxl/cxl.h                      |   2 +
>  6 files changed, 217 insertions(+), 201 deletions(-)
>  create mode 100644 drivers/cxl/core/memctrl/pmem_region.c
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 18cb84950500..59175890a6ac 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -46,6 +46,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
>  int cxl_enable_memctrl(struct cxl_region *cxlr);
>  int devm_cxl_add_dax_region(struct cxl_region *cxlr);
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr);
>  
>  #else
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> diff --git a/drivers/cxl/core/memctrl/Makefile b/drivers/cxl/core/memctrl/Makefile
> index 1c52c7d75570..efffc8ba2c0b 100644
> --- a/drivers/cxl/core/memctrl/Makefile
> +++ b/drivers/cxl/core/memctrl/Makefile
> @@ -3,3 +3,4 @@
>  cxl_core-$(CONFIG_CXL_REGION) += memctrl/memctrl.o
>  cxl_core-$(CONFIG_CXL_REGION) += memctrl/dax_region.o
>  cxl_core-$(CONFIG_CXL_REGION) += memctrl/sysram_region.o
> +cxl_core-$(CONFIG_CXL_REGION) += memctrl/pmem_region.o
> diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
> index 40ffb59353bb..1b661465bdeb 100644
> --- a/drivers/cxl/core/memctrl/memctrl.c
> +++ b/drivers/cxl/core/memctrl/memctrl.c
> @@ -36,6 +36,8 @@ int cxl_enable_memctrl(struct cxl_region *cxlr)
>  		return devm_cxl_add_dax_region(cxlr);
>  	case CXL_MEMCTRL_SYSRAM:
>  		return devm_cxl_add_sysram_region(cxlr);
> +	case CXL_MEMCTRL_PMEM:
> +		return devm_cxl_add_pmem_region(cxlr);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/cxl/core/memctrl/pmem_region.c b/drivers/cxl/core/memctrl/pmem_region.c
> new file mode 100644
> index 000000000000..57668dd82d71
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/pmem_region.c
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "../core.h"
> +
> +static void cxl_pmem_region_release(struct device *dev)
> +{
> +	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
> +	int i;
> +
> +	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> +		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
> +
> +		put_device(&cxlmd->dev);
> +	}
> +
> +	kfree(cxlr_pmem);
> +}
> +
> +static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
> +	&cxl_base_attribute_group,
> +	NULL,
> +};
> +
> +const struct device_type cxl_pmem_region_type = {
> +	.name = "cxl_pmem_region",
> +	.release = cxl_pmem_region_release,
> +	.groups = cxl_pmem_region_attribute_groups,
> +};
> +bool is_cxl_pmem_region(struct device *dev)
> +{
> +	return dev->type == &cxl_pmem_region_type;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
> +
> +struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
> +				"not a cxl_pmem_region device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_pmem_region, dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");

Missing blank line above.
> +static struct lock_class_key cxl_pmem_region_key;
> +
> +static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int i;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return -ENXIO;
> +
> +	struct cxl_pmem_region *cxlr_pmem __free(kfree) =
> +		kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
> +	if (!cxlr_pmem)
> +		return -ENOMEM;
> +
> +	cxlr_pmem->hpa_range.start = p->res->start;
> +	cxlr_pmem->hpa_range.end = p->res->end;
> +
> +	/* Snapshot the region configuration underneath the cxl_rwsem.region */
> +	cxlr_pmem->nr_mappings = p->nr_targets;
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> +
> +		/*
> +		 * Regions never span CXL root devices, so by definition the
> +		 * bridge for one device is the same for all.
> +		 */
> +		if (i == 0) {
> +			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
> +			if (!cxl_nvb)
> +				return -ENODEV;
> +			cxlr->cxl_nvb = cxl_nvb;
> +		}
> +		m->cxlmd = cxlmd;
> +		get_device(&cxlmd->dev);
> +		m->start = cxled->dpa_res->start;
> +		m->size = resource_size(cxled->dpa_res);
> +		m->position = i;
> +	}
> +
> +	dev = &cxlr_pmem->dev;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_pmem_region_type;
> +	cxlr_pmem->cxlr = cxlr;
> +	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
> +
> +	return 0;
> +}
> +
> +static void cxlr_pmem_unregister(void *_cxlr_pmem)
> +{
> +	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
> +	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> +	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +
> +	/*
> +	 * Either the bridge is in ->remove() context under the device_lock(),
> +	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
> +	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
> +	 * lock).
> +	 */
> +	device_lock_assert(&cxl_nvb->dev);
> +	cxlr->cxlr_pmem = NULL;
> +	cxlr_pmem->cxlr = NULL;
> +	device_unregister(&cxlr_pmem->dev);
> +}
> +
> +static void cxlr_release_nvdimm(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxlr->cxlr_pmem)
> +			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> +					cxlr->cxlr_pmem);
> +	}
> +	cxlr->cxl_nvb = NULL;
> +	put_device(&cxl_nvb->dev);
> +}
> +
> +/**
> + * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> + * @cxlr: parent CXL region for this pmem region bridge device
> + *
> + * Return: 0 on success negative error code on failure.
> + */
> +int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct device *dev;
> +	int rc;
> +
> +	rc = cxl_pmem_region_alloc(cxlr);
> +	if (rc)
> +		return rc;
> +	cxlr_pmem = cxlr->cxlr_pmem;
> +	cxl_nvb = cxlr->cxl_nvb;
> +
> +	dev = &cxlr_pmem->dev;
> +	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +			dev_name(dev));
> +
> +	scoped_guard(device, &cxl_nvb->dev) {
> +		if (cxl_nvb->dev.driver)
> +			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> +					cxlr_pmem_unregister,
> +					cxlr_pmem);
> +		else
> +			rc = -ENXIO;
> +	}
> +
> +	if (rc)
> +		goto err_bridge;
> +
> +	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
> +
> +err:
> +	put_device(dev);
> +err_bridge:
> +	put_device(&cxl_nvb->dev);
> +	cxlr->cxl_nvb = NULL;
> +	return rc;
> +}
> +
> +
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index eeab091f043a..85c20a09246d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -642,6 +642,9 @@ static ssize_t ctrl_show(struct device *dev, struct device_attribute *attr,
>  	case CXL_MEMCTRL_SYSRAM:
>  		desc = "sysram";
>  		break;
> +	case CXL_MEMCTRL_PMEM:
> +		desc = "pmem";
> +		break;
>  	default:
>  		desc = "";
>  		break;
> @@ -661,6 +664,10 @@ static ssize_t ctrl_store(struct device *dev, struct device_attribute *attr,
>  	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>  		return rc;
>  
> +	/* PMEM only has one controller - the pmem controller */
> +	if (cxlr->mode == CXL_PARTMODE_PMEM)
> +		return -EBUSY;
> +
>  	if (p->state >= CXL_CONFIG_COMMIT)
>  		return -EBUSY;
>  
> @@ -2648,7 +2655,11 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  		return cxlr;
>  	cxlr->mode = mode;
>  	cxlr->type = type;
> -	cxlr->memctrl = CXL_MEMCTRL_NONE;
> +
> +	if (mode == CXL_PARTMODE_PMEM)
> +		cxlr->memctrl = CXL_MEMCTRL_PMEM;
> +	else
> +		cxlr->memctrl = CXL_MEMCTRL_NONE;
>  
>  	dev = &cxlr->dev;
>  	rc = dev_set_name(dev, "region%d", id);
> @@ -2797,46 +2808,6 @@ static ssize_t delete_region_store(struct device *dev,
>  }
>  DEVICE_ATTR_WO(delete_region);
>  
> -static void cxl_pmem_region_release(struct device *dev)
> -{
> -	struct cxl_pmem_region *cxlr_pmem = to_cxl_pmem_region(dev);
> -	int i;
> -
> -	for (i = 0; i < cxlr_pmem->nr_mappings; i++) {
> -		struct cxl_memdev *cxlmd = cxlr_pmem->mapping[i].cxlmd;
> -
> -		put_device(&cxlmd->dev);
> -	}
> -
> -	kfree(cxlr_pmem);
> -}
> -
> -static const struct attribute_group *cxl_pmem_region_attribute_groups[] = {
> -	&cxl_base_attribute_group,
> -	NULL,
> -};
> -
> -const struct device_type cxl_pmem_region_type = {
> -	.name = "cxl_pmem_region",
> -	.release = cxl_pmem_region_release,
> -	.groups = cxl_pmem_region_attribute_groups,
> -};
> -
> -bool is_cxl_pmem_region(struct device *dev)
> -{
> -	return dev->type == &cxl_pmem_region_type;
> -}
> -EXPORT_SYMBOL_NS_GPL(is_cxl_pmem_region, "CXL");
> -
> -struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> -{
> -	if (dev_WARN_ONCE(dev, !is_cxl_pmem_region(dev),
> -			  "not a cxl_pmem_region device\n"))
> -		return NULL;
> -	return container_of(dev, struct cxl_pmem_region, dev);
> -}
> -EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, "CXL");
> -
>  struct cxl_poison_context {
>  	struct cxl_port *port;
>  	int part;
> @@ -3268,64 +3239,6 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	return -ENXIO;
>  }
>  
> -static struct lock_class_key cxl_pmem_region_key;
> -
> -static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *dev;
> -	int i;
> -
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->state != CXL_CONFIG_COMMIT)
> -		return -ENXIO;
> -
> -	struct cxl_pmem_region *cxlr_pmem __free(kfree) =
> -		kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);
> -	if (!cxlr_pmem)
> -		return -ENOMEM;
> -
> -	cxlr_pmem->hpa_range.start = p->res->start;
> -	cxlr_pmem->hpa_range.end = p->res->end;
> -
> -	/* Snapshot the region configuration underneath the cxl_rwsem.region */
> -	cxlr_pmem->nr_mappings = p->nr_targets;
> -	for (i = 0; i < p->nr_targets; i++) {
> -		struct cxl_endpoint_decoder *cxled = p->targets[i];
> -		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -		struct cxl_pmem_region_mapping *m = &cxlr_pmem->mapping[i];
> -
> -		/*
> -		 * Regions never span CXL root devices, so by definition the
> -		 * bridge for one device is the same for all.
> -		 */
> -		if (i == 0) {
> -			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd->endpoint);
> -			if (!cxl_nvb)
> -				return -ENODEV;
> -			cxlr->cxl_nvb = cxl_nvb;
> -		}
> -		m->cxlmd = cxlmd;
> -		get_device(&cxlmd->dev);
> -		m->start = cxled->dpa_res->start;
> -		m->size = resource_size(cxled->dpa_res);
> -		m->position = i;
> -	}
> -
> -	dev = &cxlr_pmem->dev;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
> -	device_set_pm_not_required(dev);
> -	dev->parent = &cxlr->dev;
> -	dev->bus = &cxl_bus_type;
> -	dev->type = &cxl_pmem_region_type;
> -	cxlr_pmem->cxlr = cxlr;
> -	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
> -
> -	return 0;
> -}
> -
>  static void cxl_dax_region_release(struct device *dev)
>  {
>  	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> @@ -3358,92 +3271,6 @@ struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
>  
> -static void cxlr_pmem_unregister(void *_cxlr_pmem)
> -{
> -	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
> -	struct cxl_region *cxlr = cxlr_pmem->cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> -
> -	/*
> -	 * Either the bridge is in ->remove() context under the device_lock(),
> -	 * or cxlr_release_nvdimm() is cancelling the bridge's release action
> -	 * for @cxlr_pmem and doing it itself (while manually holding the bridge
> -	 * lock).
> -	 */
> -	device_lock_assert(&cxl_nvb->dev);
> -	cxlr->cxlr_pmem = NULL;
> -	cxlr_pmem->cxlr = NULL;
> -	device_unregister(&cxlr_pmem->dev);
> -}
> -
> -static void cxlr_release_nvdimm(void *_cxlr)
> -{
> -	struct cxl_region *cxlr = _cxlr;
> -	struct cxl_nvdimm_bridge *cxl_nvb = cxlr->cxl_nvb;
> -
> -	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxlr->cxlr_pmem)
> -			devm_release_action(&cxl_nvb->dev, cxlr_pmem_unregister,
> -					    cxlr->cxlr_pmem);
> -	}
> -	cxlr->cxl_nvb = NULL;
> -	put_device(&cxl_nvb->dev);
> -}
> -
> -/**
> - * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
> - * @cxlr: parent CXL region for this pmem region bridge device
> - *
> - * Return: 0 on success negative error code on failure.
> - */
> -static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
> -{
> -	struct cxl_pmem_region *cxlr_pmem;
> -	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct device *dev;
> -	int rc;
> -
> -	rc = cxl_pmem_region_alloc(cxlr);
> -	if (rc)
> -		return rc;
> -	cxlr_pmem = cxlr->cxlr_pmem;
> -	cxl_nvb = cxlr->cxl_nvb;
> -
> -	dev = &cxlr_pmem->dev;
> -	rc = dev_set_name(dev, "pmem_region%d", cxlr->id);
> -	if (rc)
> -		goto err;
> -
> -	rc = device_add(dev);
> -	if (rc)
> -		goto err;
> -
> -	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> -		dev_name(dev));
> -
> -	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> -			rc = devm_add_action_or_reset(&cxl_nvb->dev,
> -						      cxlr_pmem_unregister,
> -						      cxlr_pmem);
> -		else
> -			rc = -ENXIO;
> -	}
> -
> -	if (rc)
> -		goto err_bridge;
> -
> -	/* @cxlr carries a reference on @cxl_nvb until cxlr_release_nvdimm */
> -	return devm_add_action_or_reset(&cxlr->dev, cxlr_release_nvdimm, cxlr);
> -
> -err:
> -	put_device(dev);
> -err_bridge:
> -	put_device(&cxl_nvb->dev);
> -	cxlr->cxl_nvb = NULL;
> -	return rc;
> -}
> -
>  static int match_decoder_by_range(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 = data;
> @@ -3929,26 +3756,18 @@ static int cxl_region_probe(struct device *dev)
>  			return rc;
>  	}
>  
> -	switch (cxlr->mode) {
> -	case CXL_PARTMODE_PMEM:
> -		rc = devm_cxl_region_edac_register(cxlr);
> -		if (rc)
> -			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> -				cxlr->id);
> -
> -		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_PARTMODE_RAM:
> -		rc = devm_cxl_region_edac_register(cxlr);
> -		if (rc)
> -			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> -				cxlr->id);
> -
> -		return cxl_enable_memctrl(cxlr);
> -	default:
> +	if (cxlr->mode > CXL_PARTMODE_PMEM) {
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>  			cxlr->mode);
>  		return -ENXIO;
>  	}
> +
> +	rc = devm_cxl_region_edac_register(cxlr);
> +	if (rc)
> +		dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> +			cxlr->id);
> +
> +	return cxl_enable_memctrl(cxlr);
>  }
>  
>  static struct cxl_driver cxl_region_driver = {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index bb4f877b4e8f..c69d27a2e97d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -509,12 +509,14 @@ enum cxl_partition_mode {
>   *   Auto   - either BIOS-configured as SysRAM, or default to DAX
>   *   DAX    - creates a dax_region controller for the cxl_region
>   *   SYSRAM - hotplugs the region directly as System RAM
> + *   PMEM   - persistent memory controller (nvdimm)
>   */
>  enum cxl_memctrl_mode {
>  	CXL_MEMCTRL_NONE,
>  	CXL_MEMCTRL_AUTO,
>  	CXL_MEMCTRL_DAX,
>  	CXL_MEMCTRL_SYSRAM,
> +	CXL_MEMCTRL_PMEM,
>  };
>  
>  /*

