Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406AC32D7F9;
	Mon, 12 Jan 2026 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252241; cv=fail; b=jiizIusJHvWrzv72LkscW0hrD0FY1S1nwOMjQE+kUW5j6gTXpcdID5xqnBkWaya3CGXSTIO4f1bKPUEmgM/uv6Yu9brqf3U0p4siqn59zNXx96Veh7XDJMW40ydcTUlIUcjSH6h+stPrGrfEnaSEa4ycuvxOMZdgPbKAOV74St8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252241; c=relaxed/simple;
	bh=gtMSxujjyytvtEMPW4otuBTNJ4AqulI/FHWZGgk+ayg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ugHMA/Wpw6UGsW6XRx6WuAxIOUM33SWkuL49JCd9FC7v+Ci+LlsvbxEyM0BhMUuyanKz1VeL5QC3xQmCv5IhkUr+2x4dQvoSR4oS8cktXZOy30rZDFEqp9hcbJO5EyN47Wamo7VSWf0MQ7L8gw7bIk0yFN+alUhdlLL55GtSdVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rt/jc+hY; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rt/jc+hY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y39YXIC3u7e20Ihc6Hk6gWOM9smW9P83Oezsd9wTFiNgHrmOCIWFIfb/TrbzFuhB5EfM1B79VcRo6j8NI8wPKO5j4edlfOhfjgcBSJNrrC20NxhCzhZt+FEO0astgHpynegFDgKxlcha/duNbjXZ60SV7qUAOavyVPP55vePk5OCW3ltJPTXStVTKeqI46A9rDrC60rpRKHxhi3M8JhLOhNLtPlICZi64e/GINFqvdBhOTSHlyGnUwjDQfm30fK6zIvf5nyPk+/kDHM9c7x6IEMM4yxVNBt8bS8E3VpeLA3q2tqdeQ3NY7HlcX8XUe+jMz+GBoorHGWdRcpPibFVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPZ6j3eh+6e6qZ3VUw4VEGssWdscQc8Hf05vmuchj90=;
 b=PBakQQ1GCYKZUz6cGKmx1mug+Xw19AgRWmFuiOmDOErY2knFfnM6Lb+Fxczd2ZltGe6Ybpm541WCa31Sj8F1k1IMzP8y2cemL9LDikifN8YifpoFnORX/xjkh6uXHataOiyOCkP8Oa1P3hinpnq9KN7VXtVwDxkzB51Mmd6Bi5wQrlOE/SXg3Xnx/Ofw1TXab6/xKDwpDo21ZNhUneOPj9fUOMnK0wrMsBRDvK+C4HbfO1j+R38tkaSJJft5iiDY8uWTMW19BfB7EvTegKFUca5uNGsM4MTUV6SNfE+KmpMKCPrgAxA8eZrT9EXjRxQDlpnM6HJkSHalw5jDq4HqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPZ6j3eh+6e6qZ3VUw4VEGssWdscQc8Hf05vmuchj90=;
 b=Rt/jc+hYh8hNwbuOsBS+AsK0vYiau/nBEr6dbewrKCdZ/KpykjyHDzpEqsL0nvDimPj4yj7AlPN1c8OVC2mW0LOEGDy08N95xWcUl5b8m8bYDOFqIOWp5oBgBAWUk7bY+VZ8BX6/7RAWAzq/OB2XvoGChO4/VA9zTVUqGM5o32M=
Received: from BYAPR11CA0051.namprd11.prod.outlook.com (2603:10b6:a03:80::28)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:10:31 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::4c) by BYAPR11CA0051.outlook.office365.com
 (2603:10b6:a03:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 21:10:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 21:10:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 15:10:30 -0600
Received: from [10.236.181.95] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 13:10:30 -0800
Message-ID: <4fc3ee3e-d764-46c7-ae45-a835e0080c98@amd.com>
Date: Mon, 12 Jan 2026 15:10:29 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 1/6] drivers/cxl: add cxl_memctrl_mode and region->memctrl
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-2-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20260112163514.2551809-2-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: bad2582b-e412-4799-fb82-08de521f04bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|18082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnN3Q0JwZG5WcVg2YWtqTzlpSk8rN0FLTENwSWlJYUljRzFIVE1RWDYxQ05R?=
 =?utf-8?B?ZGIvaFV3NVVDbUY0clJIOS82WlI3MlowcFJ2VUFCZnZDSHFhbHdVbTdvRkc4?=
 =?utf-8?B?Nkd2UlZpZGorc0JUM0JGTDI2R2ptbWlBMXdoU0tEOUlhSlAvcnFGK0RQR0xG?=
 =?utf-8?B?a1pjMm0xWnZqN3Urb0xaTm16dDdmR3ZoOW1JU3FXOWxXU1I2eEptYy9oTkxM?=
 =?utf-8?B?WHM3aHNmS0hWZFBqd1NwWXBtNHZ6bkU4bGZHWDJ3c2ppUkcrYkZIWVp4UjNM?=
 =?utf-8?B?YkNZUDRobVJaSHM2YXR0bkp0RHEyeVVPeHNNSHEzK2hpTS9ZQmJhZy9tNVV4?=
 =?utf-8?B?bEFxS3VWbDhDaGNtaWxMWTc2LzJjS3UwMTlFcmhwakNNZnZIdEhiaHVwaFBh?=
 =?utf-8?B?YXplRVNXZUxyTTJML2hlZzQrUkRpNG0ySXRvMVhTYTIzOHYrOWxITjBzV1p0?=
 =?utf-8?B?U2xwdmtyVUwxcHNub1o4ZGVkcU9WdWxCREl2QTVZMFkxVEZLdk1lYmR4a1ps?=
 =?utf-8?B?OHhPTGVCbU9BeCtzVTNrVk9tU29aQTBiTXkxVkIxMHJudFZjc3VleEgvTEdZ?=
 =?utf-8?B?Yjhrd0kvSmNIZGZGZm5OcjNLYkk0dFh6blNLQXhabU14Z29iY0xXZ2pTZ1l0?=
 =?utf-8?B?Z1NaL29sT04xWFc4ZGxmUFhPWm1qbWxocFU4eEszYUhsc0IwNGMwQWt3KzAv?=
 =?utf-8?B?UXZ6YWs0eitBZjd1Nm85eUV5dEhaQkxxc2l1NFhUQVZLcXE4bUNVVm8zRUl4?=
 =?utf-8?B?clBrS1JFMi9pSHpRQVlLa1BTNmNna1NxOC83V1V2Vm9CQnRERWRBWnRJVFRT?=
 =?utf-8?B?YXpuYlF0MlVJZFprZFdRTEhtMzhiMmZsTUpjRUp4Z3VSZ050dzNVU2xieTd4?=
 =?utf-8?B?L091Rm1mRUd1VDFhakhmMUtYTmNldlVwdDNFWThYZEszNlk3UmJkd2NzRFdJ?=
 =?utf-8?B?U212SnhDcDdCbFY5a2YxSkh6bUR1YS9xR1h5aDR6T3AzU1pYeHN6QmF0ckdN?=
 =?utf-8?B?VGdkZVd6Y1k4L3YxU0gzbFdSeTdsVlFVcm93MVRqZHNTM28wUjVnalhNSkcv?=
 =?utf-8?B?UmIzRG5NMVdqcENDQThDT21pVW1heGtZZ25JY3RrZWxKMWhZUEJYcEZIcGNB?=
 =?utf-8?B?MENFbTd2T0hUWENNbTFac3IrTzBrREFkZHhrS2NCZDlTYVpSeWpHTnlRcWJ0?=
 =?utf-8?B?K1FPd0IraFhFRHcrSmRySjRVN21rb2lDYlN3a0VMYVpvYVhOS3V4WU92Z09H?=
 =?utf-8?B?bG1UbTc2NWdWQWZxV2NGZTZWdWRaZks3VHNtZnUwdnhxOGVyVStrRlVyTC9n?=
 =?utf-8?B?NDVYTlBqTlJrSkxkL2FZaC9CK2YwSEdYTUQ0S3FVVlpYQlZXQURTeDZsNDVl?=
 =?utf-8?B?WWJsaW1DUVUzTjViQSt5aUhZWUl0OER1Rk15VEJqR3BWNkVseFlaZ2JCY3Zh?=
 =?utf-8?B?OUxUbDd5c2VuanY1MkhVOWYwYjdBVC9ZWWdHb3ZBYytreDAwMVY4TTlrTFk5?=
 =?utf-8?B?QXlvQnVHbHRBcUxNUnVtdzNkT1NCb2ZuY3p3a3gvRDVvTi8zbHUwaFUrem4x?=
 =?utf-8?B?L3M0Y3dGT3BjTjlPRkJFSG16QU13blJOVW1oNENveVBKa1JRWnFlVlJ0T0Jr?=
 =?utf-8?B?WXREblZRRjd4RnFPMER0ZGg1dGNnZzR0NkRMUTFNU3VibDMwOWxqZ3B6bXNk?=
 =?utf-8?B?YUVMaHV6Q1pUdlpib2RqUndwNWZveDNEWGFXZDdJZWNwRUdubU5QU3pjcEVi?=
 =?utf-8?B?a1hOdkd5TVlwOXk1S2NpZzJlK0ltZ0RzYjliaThEY0pYSTIxOFhkYXMyeE84?=
 =?utf-8?B?Q014WVptN0YzZEc1K3pVbzFrQWhRYW9BZUI3a2F5L2VVUWRWV1lCQzdDVVl3?=
 =?utf-8?B?ZHhueTUvOTdHTjNJWXdaV3NweFFJQktURkNXQ25zeThlbGJaOHdXQ0NkOGlw?=
 =?utf-8?B?dlBYZG5mQ1JBOHViQzhERlExY0dORHpqWS9PL2cyNEI1RTN6QlJ2ZnVtd1Yz?=
 =?utf-8?B?TTNRR2xEUUlaQUN0blhnVnliNndvSnJUZmxKYW1ad3YyMEc4VkNFaHIrN0xS?=
 =?utf-8?B?NEprK2E4T0Q4a0EvWjU0bVZ4RTRyc05LU2NBeThkOUVGdVFZejNPbDZDRHAx?=
 =?utf-8?Q?qpBI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(18082099003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:10:30.9134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad2582b-e412-4799-fb82-08de521f04bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351

On 1/12/2026 10:35 AM, Gregory Price wrote:
> The CXL driver presently hands policy management over to DAX subsystem
> for sysram regions, which makes building policy around the entire region
> clunky and at time difficult (e.g. multiple actions to offline and
> hot-unplug memory reliably).
> 
> To support multiple backend controllers for memory regions (for example
> dax vs direct hotplug), implement a memctrl field in cxl_region allows
> switching uncomitted regions between different "memory controllers".
> 
> CXL_CONTROL_NONE: No selected controller, probe will fail.
> CXL_CONTROL_AUTO: If memory is already online as SysRAM, no controller
>                   otherwise register a dax_region

I think you can streamline this to get rid of CXL_CONTROL_AUTO. If BIOS set up
the memory you can just set the mode to CXL_CONTROL_NONE, otherwise use CXL_CONTROL_DAX.
This patch would be a bit less complicated at the very least, and I don't think it
would require much reworking of later patches.

> CXL_CONTROL_DAX : register a dax_region
> 
> Auto regions will either be static sysram (BIOS-onlined) and has no
> region controller associated with it - or if the SP bit was set a
> DAX device will be created.
> 
> Rather than default all regions to the auto-controller, only default
> auto-regions to the auto controller.
> 
> Non-auto regions will be defaulted to CXL_CONTROL_NONE, which will cause
> a failure to probe unless a controller is selected.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/Makefile             |   1 +
>  drivers/cxl/core/core.h               |   2 +
>  drivers/cxl/core/memctrl/Makefile     |   4 +
>  drivers/cxl/core/memctrl/dax_region.c |  79 +++++++++++++++
>  drivers/cxl/core/memctrl/memctrl.c    |  42 ++++++++
>  drivers/cxl/core/region.c             | 136 ++++++++++----------------
>  drivers/cxl/cxl.h                     |  14 +++
>  7 files changed, 192 insertions(+), 86 deletions(-)
>  create mode 100644 drivers/cxl/core/memctrl/Makefile
>  create mode 100644 drivers/cxl/core/memctrl/dax_region.c
>  create mode 100644 drivers/cxl/core/memctrl/memctrl.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 5ad8fef210b5..79de20e3f8aa 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,6 +17,7 @@ cxl_core-y += cdat.o
>  cxl_core-y += ras.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +include $(src)/memctrl/Makefile
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1fb66132b777..1156a4bd0080 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -42,6 +42,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
> +int cxl_enable_memctrl(struct cxl_region *cxlr);
> +int devm_cxl_add_dax_region(struct cxl_region *cxlr);
>  
>  #else
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
> diff --git a/drivers/cxl/core/memctrl/Makefile b/drivers/cxl/core/memctrl/Makefile
> new file mode 100644
> index 000000000000..8165aad5a52a
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +cxl_core-$(CONFIG_CXL_REGION) += memctrl/memctrl.o
> +cxl_core-$(CONFIG_CXL_REGION) += memctrl/dax_region.o
> diff --git a/drivers/cxl/core/memctrl/dax_region.c b/drivers/cxl/core/memctrl/dax_region.c
> new file mode 100644
> index 000000000000..90d7fdb97013
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/dax_region.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "../core.h"
> +
> +static struct lock_class_key cxl_dax_region_key;
> +
> +static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return ERR_PTR(-ENXIO);
> +
> +	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
> +	if (!cxlr_dax)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlr_dax->hpa_range.start = p->res->start;
> +	cxlr_dax->hpa_range.end = p->res->end;
> +
> +	dev = &cxlr_dax->dev;
> +	cxlr_dax->cxlr = cxlr;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> +	device_set_pm_not_required(dev);
> +	dev->parent = &cxlr->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_dax_region_type;
> +
> +	return cxlr_dax;
> +}
> +
> +static void cxlr_dax_unregister(void *_cxlr_dax)
> +{
> +	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> +
> +	device_unregister(&cxlr_dax->dev);
> +}
> +
> +/*
> + * The dax controller is the default controller and simply hands the
> + * control pattern over to the dax driver.  It does with a dax_region
> + * built by dax/cxl.c
> + */
> +int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +	int rc;
> +
> +	cxlr_dax = cxl_dax_region_alloc(cxlr);
> +	if (IS_ERR(cxlr_dax))
> +		return PTR_ERR(cxlr_dax);
> +
> +	dev = &cxlr_dax->dev;
> +	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +		dev_name(dev));
> +
> +	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> +					cxlr_dax);
> +err:
> +	put_device(dev);
> +	return rc;
> +}
> diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
> new file mode 100644
> index 000000000000..24e0e14b39c7
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/memctrl.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +/* Copyright(c) 2026 Meta Inc. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/ioport.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "../core.h"
> +
> +static int is_system_ram(struct resource *res, void *arg)
> +{
> +	struct cxl_region *cxlr = arg;
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	dev_dbg(&cxlr->dev, "%pr has System RAM: %pr\n", p->res, res);
> +	return 1;
> +}
> +
> +int cxl_enable_memctrl(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	switch (cxlr->memctrl) {
> +	case CXL_MEMCTRL_AUTO:
> +		/*
> +		 * The region can not be manged by CXL if any portion of

s/manged/managed. May as well fix it since it's being moved.
> +		 * it is already online as 'System RAM'
> +		 */
> +		if (walk_iomem_res_desc(IORES_DESC_NONE,
> +					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +					p->res->start, p->res->end, cxlr,
> +					is_system_ram) > 0)
> +			return 0;
> +		return devm_cxl_add_dax_region(cxlr);

If you take my suggestion at the top about removing MEMCTRL_AUTO, this case become
the MEMCTRL_DAX case.

> +	case CXL_MEMCTRL_DAX:
> +		return devm_cxl_add_dax_region(cxlr);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index ae899f68551f..02d7d9ae0252 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -626,6 +626,50 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(mode);
>  
> +static ssize_t ctrl_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	const char *desc;
> +
> +	switch (cxlr->memctrl) {
> +	case CXL_MEMCTRL_AUTO:
> +		desc = "auto";
> +		break;
> +	case CXL_MEMCTRL_DAX:
> +		desc = "dax";
> +		break;
> +	default:
> +		desc = "";

Nit: I would prefer this say "none" instead of being blank to match the code.
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", desc);
> +}
> +
> +static ssize_t ctrl_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	if (p->state >= CXL_CONFIG_COMMIT)
> +		return -EBUSY;
> +
> +	if (sysfs_streq(buf, "dax"))
> +		cxlr->memctrl = CXL_MEMCTRL_DAX;
> +	else
> +		return -EINVAL;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RW(ctrl);
> +
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> @@ -772,6 +816,7 @@ static struct attribute *cxl_region_attrs[] = {
>  	&dev_attr_size.attr,
>  	&dev_attr_mode.attr,
>  	&dev_attr_extended_linear_cache_size.attr,
> +	&dev_attr_ctrl.attr,
>  	NULL,
>  };
>  
> @@ -2598,6 +2643,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  		return cxlr;
>  	cxlr->mode = mode;
>  	cxlr->type = type;
> +	cxlr->memctrl = CXL_MEMCTRL_NONE;
>  
>  	dev = &cxlr->dev;
>  	rc = dev_set_name(dev, "region%d", id);
> @@ -3307,37 +3353,6 @@ struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_dax_region, "CXL");
>  
> -static struct lock_class_key cxl_dax_region_key;
> -
> -static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> -{
> -	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_dax_region *cxlr_dax;
> -	struct device *dev;
> -
> -	guard(rwsem_read)(&cxl_rwsem.region);
> -	if (p->state != CXL_CONFIG_COMMIT)
> -		return ERR_PTR(-ENXIO);
> -
> -	cxlr_dax = kzalloc(sizeof(*cxlr_dax), GFP_KERNEL);
> -	if (!cxlr_dax)
> -		return ERR_PTR(-ENOMEM);
> -
> -	cxlr_dax->hpa_range.start = p->res->start;
> -	cxlr_dax->hpa_range.end = p->res->end;
> -
> -	dev = &cxlr_dax->dev;
> -	cxlr_dax->cxlr = cxlr;
> -	device_initialize(dev);
> -	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> -	device_set_pm_not_required(dev);
> -	dev->parent = &cxlr->dev;
> -	dev->bus = &cxl_bus_type;
> -	dev->type = &cxl_dax_region_type;
> -
> -	return cxlr_dax;
> -}
> -
>  static void cxlr_pmem_unregister(void *_cxlr_pmem)
>  {
>  	struct cxl_pmem_region *cxlr_pmem = _cxlr_pmem;
> @@ -3424,42 +3439,6 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static void cxlr_dax_unregister(void *_cxlr_dax)
> -{
> -	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> -
> -	device_unregister(&cxlr_dax->dev);
> -}
> -
> -static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> -{
> -	struct cxl_dax_region *cxlr_dax;
> -	struct device *dev;
> -	int rc;
> -
> -	cxlr_dax = cxl_dax_region_alloc(cxlr);
> -	if (IS_ERR(cxlr_dax))
> -		return PTR_ERR(cxlr_dax);
> -
> -	dev = &cxlr_dax->dev;
> -	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
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
> -	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> -					cxlr_dax);
> -err:
> -	put_device(dev);
> -	return rc;
> -}
> -
>  static int match_decoder_by_range(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 = data;
> @@ -3579,6 +3558,9 @@ static int __construct_region(struct cxl_region *cxlr,
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>  
> +	/* Auto-regions will either be static sysram (onlined by BIOS) or DAX */
> +	cxlr->memctrl = CXL_MEMCTRL_AUTO;

And this would be set to CXL_MEM_CTRL_DAX instead.

> +
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
>  	if (!res)
>  		return -ENOMEM;
> @@ -3755,15 +3737,6 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_port_get_spa_cache_alias, "CXL");
>  
> -static int is_system_ram(struct resource *res, void *arg)
> -{
> -	struct cxl_region *cxlr = arg;
> -	struct cxl_region_params *p = &cxlr->params;
> -
> -	dev_dbg(&cxlr->dev, "%pr has System RAM: %pr\n", p->res, res);
> -	return 1;
> -}
> -
>  static void shutdown_notifiers(void *_cxlr)
>  {
>  	struct cxl_region *cxlr = _cxlr;
> @@ -3965,16 +3938,7 @@ static int cxl_region_probe(struct device *dev)
>  			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
>  				cxlr->id);
>  
> -		/*
> -		 * The region can not be manged by CXL if any portion of
> -		 * it is already online as 'System RAM'
> -		 */
> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -					p->res->start, p->res->end, cxlr,
> -					is_system_ram) > 0)
> -			return 0;
> -		return devm_cxl_add_dax_region(cxlr);
> +		return cxl_enable_memctrl(cxlr);
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>  			cxlr->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ba17fa86d249..b8fabaa77262 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -502,6 +502,19 @@ enum cxl_partition_mode {
>  	CXL_PARTMODE_PMEM,
>  };
>  
> +
> +/*
> + * Memory Controller modes:
> + *   None - No controller selected
> + *   Auto - either BIOS-configured as SysRAM, or default to DAX
> + *   DAX  - creates a dax_region controller for the cxl_region
> + */
> +enum cxl_memctrl_mode {
> +	CXL_MEMCTRL_NONE,
> +	CXL_MEMCTRL_AUTO,
> +	CXL_MEMCTRL_DAX,
> +};
> +
>  /*
>   * Indicate whether this region has been assembled by autodetection or
>   * userspace assembly. Prevent endpoint decoders outside of automatic
> @@ -543,6 +556,7 @@ struct cxl_region {
>  	struct device dev;
>  	int id;
>  	enum cxl_partition_mode mode;
> +	enum cxl_memctrl_mode memctrl;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;

