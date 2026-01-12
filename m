Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F132E120;
	Mon, 12 Jan 2026 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252250; cv=fail; b=Wu1yEygZwuSrQ5CzvaU49FDUF/LxlfugsKXZ3QyR0zWAs4Ek+NmqwNWzpY5xjENnxuQd7nMl01BflKMMUw7BQNEZELSH/PW92jWrJ5qdjehGlRtnKe1zb0d8j9VcUqfu76P1+1weYdMQrAaTE3aNWhCM3Y7KRdUIY6fUe3IoxXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252250; c=relaxed/simple;
	bh=ohxbHYrFhFZA0q3ZHKJHujYbPkg/ncLr0N84V1S7eGA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hg3QWk1KrO+ThJ2jve0nDkb7hpHiV2YfzkzfftXEToPuCIBzoT8e1mQRtli2vKIAmgKNQMMTpP6zDHFEHo2q27qyR26IQXdvzKoFwIK6U0eheddjP18n1zOTCZlvKABTvt0hQTaNI7D575BGwAU2PzkRhfIr9e9jlqO+0NkL0kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LdEZYLr1; arc=fail smtp.client-ip=52.101.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LdEZYLr1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c48iRajcfsfepIm5N9098U3lCcFTm82Gf4L6+qipsPcuJXeUoU6it9Zeoj3k1gWgekDbYRRCbWK72dIOUNZ+tyw4TOTOMiNfnIYWQTEJ8l/PiKUZBroJfSOmrrGrFpOn/VIBj62jg8KKX375uVjp4Ok8FyLy72UM92eo8H1w3J6cutNSco7QgaqIne7YzAWIB/DGMwF9QPeUrbVvSRdP4T+PpNp7ckryW6y9T6eAHULadbtnMlnKZduyqd5gMRMb9yD8+w/fX4EQnbX7YvlIAUQti8ZCXjMVuKejaSPpW/444Oq81CmzNIv6jjzZJg1KG691elfx2JRI4K19FPPm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g4Vb7c5UVrAZvGw+LEo3tdeTwy0gE7kk8BxNMmJ3fc=;
 b=YwOgo2OoqCbGXB8DLRAWCcJkPtzPMgT3O9DlgZk5HP3qjRDAikF/uB7ol3c/leO4xA2Hjt6BMmNEHBH2SSK8y7R6Ob4IqH65U9UAkHMLf70GLaO68x6j+f75YatZJR8M2eoJ7wdcQ685tmmzEjPW2NBisnOGNFOcf/kRt+OtXQoVUVs1EDOTn+5aM7U8WDGPT/kzKvCWr1gYorGcnz11hWVQUH+cFYEWkAiFxiCvLQuLB1HCw32shrwp7xVl3QGw9TF2cPawbyEUAO85kjR3csiVBo8BkLX9SS/rnNljIrpoi30FoTd7UGxCPmAfjuo22scuXcGwfOTk8mjMCBJhTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g4Vb7c5UVrAZvGw+LEo3tdeTwy0gE7kk8BxNMmJ3fc=;
 b=LdEZYLr1YNroyIkWPRjz2D775Aj+IN9yXbFhfIwi9ElnpJjyYYPTubtY9htxaZsTtuGcK34qVIn/qi2kDl5jLnQQsZNBF7aPfGm3BVlnE/LSQs9IZ3sTG5O4uGHrU9S7CVmYJcnuSMRFrGzZ0dNN1fW00a/9Y0CabAtbp6W47OQ=
Received: from DS7PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:3bb::14)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Mon, 12 Jan
 2026 21:10:43 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::c1) by DS7PR03CA0069.outlook.office365.com
 (2603:10b6:5:3bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 21:09:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 21:10:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 15:10:42 -0600
Received: from [10.236.181.95] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 13:10:42 -0800
Message-ID: <0233bdab-9b59-4394-9ce4-c3a5df2be06d@amd.com>
Date: Mon, 12 Jan 2026 15:10:41 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/6] cxl: add sysram_region memory controller
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, David Hildenbrand
	<david@kernel.org>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-3-gourry@gourry.net>
Content-Language: en-US
In-Reply-To: <20260112163514.2551809-3-gourry@gourry.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6fbbe9-2118-4c32-ca18-08de521f0beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDFwUnNlK2hQeE9Pd0dnZ2U3WUJEWlpRV3hjTCt5WU40eGc3blY1R0NDZlF1?=
 =?utf-8?B?OWowbXpSN3dOZDlkQ3dqdTBMUzc0UTFEQkFqZzNJVU5LZDNYSGdlZG5uWW5x?=
 =?utf-8?B?YW1oc1ZKTG0ydklUdDdiRDBRa25QMldBZVYybWpIWkwyZ2RMSytNVG9iZWNN?=
 =?utf-8?B?b2ppWjdSeW14b05nYnBtYTZHU3haMWlpbGhYbkcwNEdTdXpGckJ1KzEyZXhR?=
 =?utf-8?B?SUlEY0gxQ2tyWURubkFLREJXeW80RnNSNUZEdnV4S1MwUHM2SnJGM0tOQWV0?=
 =?utf-8?B?K0NHV3Y1V0ZPQ2I0WGxVVEdxWWtmUGlBa2U3MVdHd2tvSmxqUXNlamxnS2Ry?=
 =?utf-8?B?Mjd2M1EySlUzVjFRWTZKUzgwTkFvYzlQOG04R2JPVDA5dDZUN2drUmZQSGhm?=
 =?utf-8?B?Ulo3d0xtK2NnTkd4T0ttNWdxelNlMnZBaDUyYlRsUVYwVmFwdHF0aVg3cytl?=
 =?utf-8?B?ZEtudXhJd292ZTZZdlZwTjVyVlgvcjNTcno0QUFLcExsZGIweFY3T1FjMFhl?=
 =?utf-8?B?cjdNSnc0VFFRaFBkVzN6KzRmUHplYXlzbnoxeDlCV2NCYnl0cG9wcVlMa2lZ?=
 =?utf-8?B?ZWlIelFEMkZtZzNyZUhTMTR0emRQaXdiL2xXMkVlMFFqVmU1Yjl3Y2NYd21X?=
 =?utf-8?B?WnVZY2tMMWdRbnJrVWUwLzM0RE9JcHAydFUrOGk4d1RMc0UwQ2U3MDBNODVn?=
 =?utf-8?B?TDFHbTFNaWF4Znd6Q2dDVTF0dWEvNDlocHdGZWUzamFteDUycnN2MUpLOEFY?=
 =?utf-8?B?TEc0U1puTzFnMzB5TER4ZzF6YnVDZ25oT1RSSCt1NTNQUFljTVBlaUkxaFlR?=
 =?utf-8?B?bDhzc2tpd2tJWTMzTWROVnpldmZHdWhnN0xId1d4a1NFNFdUUURldVptNU9a?=
 =?utf-8?B?T3JJM0kzcWlpTlpqeWU5c2ZHQi9jNkRqNlRiMmhpbU9GWUNERUJKUFMzZ2Jl?=
 =?utf-8?B?WlFod0E5OFZNN3V2SWZXTGJybHN5WWdXQ1d0RDlqK0dTdTdaQlhnVGxIUlJq?=
 =?utf-8?B?anFNdE5yZFVzY3kvV25LajdOSWlUMkdPWE56ODhXT05mb1o3V1Y5ZHBCSWU3?=
 =?utf-8?B?MStDSG4yYmk2c1dZV0dWdkJSejl3VnFMU3BaKzNKLzRLSFpXdnNUNWpQREI3?=
 =?utf-8?B?RWpYZkFEMm1WVFh6MjkxRXV6NlJLZm82R1ltaDA1N0ltSHhLbEhtUHZhZWhp?=
 =?utf-8?B?eEpxOThLZXAzQnFWdmRBQmJvYTlXeWk0amJlMENhUGdiczJJM3dCdjJDcmhF?=
 =?utf-8?B?WGtsNWtxNlhHK1dWckpNMkY1VTJzeGw3UDVsK3lIaWs1TDQ3SEV2alQ1NmhC?=
 =?utf-8?B?cksxZ2hPTkVXbWMza0h4OThHVmZNdTcxUlFpZHN5L0hkY3duaGxYL2puc1Ny?=
 =?utf-8?B?Uk1ITFpnVFFvRUxkbENzOTVqYXhWVFVJeEZ2SkpBTkcyRmdXREo4NTQzaDgv?=
 =?utf-8?B?eGpJdFdyRjA2LzVWUmFnVkR6OGdWaUJJaXFmZS9SUzgyUHFwUXAreVY3bTlC?=
 =?utf-8?B?ZGpWaFRhZk5pSDBpL0pRei95UTBYZXRlWEc2eTFIb21IdEU4b2xCWU5ZM0E2?=
 =?utf-8?B?QzdaNnVRWUsrMy8vRysybkFrUy9Rd3ZWK3M0TVNNSUhRSi85cTk5TGhjOEJ1?=
 =?utf-8?B?MGxaUTdXVmIrY0RjYURFU0MxNXQvNHAzV2FwclpJR1NxTzBJbWYyRWcyYWN3?=
 =?utf-8?B?S2Q3b0I5YmRxYlFIbXR2bFlaWTYrMUpmM3dCNk9BMkhxdjZITEVsdzRva2lv?=
 =?utf-8?B?MGowS1lhODc1TFhaaTRFUmFuem5HL2lac0xBeVdMYmJ4RTdzQmoxYUlld05F?=
 =?utf-8?B?RGVDTGdHMU1Uc0RITis3UFhFd0t3Tm83QTgybEkwOEVWWjh6TkxYbzN4M3hU?=
 =?utf-8?B?cWdKZnhDQmUvcmRIZDkzdjFtMWpxTDViZWFjRTgrZ1I1N2lrWW5EUFJnMnhQ?=
 =?utf-8?B?TDNuM21oRmlBMGQxMVgrdGVyZUV5SmZwZWdRVE9UV2ZnVG45TTFCZnJFaSsy?=
 =?utf-8?B?elRkV2V4aS91emc0VXdXMmtpVm1ueGlQaWZKR1FYNVhOSlhxdVkvVmIzQ3NT?=
 =?utf-8?B?NXo0VkYxZytXRUtBOVFvVitJNGR3cldmTHdOWjFGTjFHSWh3VU9jcVlKRXBh?=
 =?utf-8?Q?HxJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:10:42.9796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6fbbe9-2118-4c32-ca18-08de521f0beb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450

On 1/12/2026 10:35 AM, Gregory Price wrote:
> Add a sysram memctrl that directly hotplugs memory without needing to
> route through DAX.  This simplifies the sysram usecase considerably.
> 
> The sysram memctl adds new sysfs controls when registered:
> 	region/memctrl/[hotplug, hotunplug, state]
> 
> hotplug:   controller attempts to hotplug the memory region
> hotunplug: controller attempts to offline and hotunplug the memory region

Nit: Would it be better to use hotadd/hotremove here instead of hotplug/hotunplug? The terms
are basically synonymous, but I think hotadd and hotremove are more descriptive.
> state:     [online,online_normal,offline]
>    online       : controller onlines blocks in ZONE_MOVABLE
>    online_normal: controller onlines blocks in ZONE_NORMAL

The naming for online states could be improved imo. I understand and agree with the motivation
behind the names, but I could see the use of the word "normal" being confusing to less savvy users.
You could change it to include the zone for both (online_movable/online_normal), but I think it may
be easier to mark which one has drawbacks, i.e. change "online_normal" to something like "online_nonremovable".
That way, anyone who doesn't want to go find the documentation for these can understand the user-visible
impact.

In any case, all of these attributes need ABI documentation as well.

>    offline      : controller attempts to offline the memory blocks
> 
> Hotplug note - by default the controller will hotplug the blocks, but
> leave them offline (unless MHP auto-online in Kconfig is enabled).
> 
> Setting state to "online_normal" may prevent future hot-unplug of sysram
> regions, and unbinding a memory region with memory online in ZONE_NORMAL
> may result in the device being removed but the memory remaining online.
> 
> This can result in future management functions failing (such as adding a
> new region).  This is why "online_normal" is explicit, and the default
> online zone is ZONE_MOVABLE.
> 
> Cc: David Hildenbrand <david@kernel.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/core.h                  |   2 +
>  drivers/cxl/core/memctrl/Makefile        |   1 +
>  drivers/cxl/core/memctrl/memctrl.c       |   2 +
>  drivers/cxl/core/memctrl/sysram_region.c | 358 +++++++++++++++++++++++
>  drivers/cxl/core/region.c                |   5 +
>  drivers/cxl/cxl.h                        |   6 +-
>  6 files changed, 372 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cxl/core/memctrl/sysram_region.c
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1156a4bd0080..18cb84950500 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -31,6 +31,8 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>  		       struct cxl_endpoint_decoder *cxled, int pos,
>  		       enum cxl_detach_mode mode);
>  
> +int devm_cxl_add_sysram_region(struct cxl_region *cxlr);
> +
>  #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
>  #define CXL_REGION_TYPE(x) (&cxl_region_type)
>  #define SET_CXL_REGION_ATTR(x) (&dev_attr_##x.attr),
> diff --git a/drivers/cxl/core/memctrl/Makefile b/drivers/cxl/core/memctrl/Makefile
> index 8165aad5a52a..1c52c7d75570 100644
> --- a/drivers/cxl/core/memctrl/Makefile
> +++ b/drivers/cxl/core/memctrl/Makefile
> @@ -2,3 +2,4 @@
>  
>  cxl_core-$(CONFIG_CXL_REGION) += memctrl/memctrl.o
>  cxl_core-$(CONFIG_CXL_REGION) += memctrl/dax_region.o
> +cxl_core-$(CONFIG_CXL_REGION) += memctrl/sysram_region.o
> diff --git a/drivers/cxl/core/memctrl/memctrl.c b/drivers/cxl/core/memctrl/memctrl.c
> index 24e0e14b39c7..40ffb59353bb 100644
> --- a/drivers/cxl/core/memctrl/memctrl.c
> +++ b/drivers/cxl/core/memctrl/memctrl.c
> @@ -34,6 +34,8 @@ int cxl_enable_memctrl(struct cxl_region *cxlr)
>  		return devm_cxl_add_dax_region(cxlr);
>  	case CXL_MEMCTRL_DAX:
>  		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_MEMCTRL_SYSRAM:
> +		return devm_cxl_add_sysram_region(cxlr);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/cxl/core/memctrl/sysram_region.c b/drivers/cxl/core/memctrl/sysram_region.c
> new file mode 100644
> index 000000000000..a7570c8a54e1
> --- /dev/null
> +++ b/drivers/cxl/core/memctrl/sysram_region.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 Meta Inc. All rights reserved. */
> +#include <linux/memremap.h>
> +#include <linux/memory.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include <linux/memory-tiers.h>
> +#include <linux/memory_hotplug.h>
> +#include <linux/string_helpers.h>
> +#include <linux/sched/signal.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "../core.h"
> +
> +/* If HMAT was unavailable, assign a default distance. */
> +#define MEMTIER_DEFAULT_CXL_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 5)
> +
> +static const char *sysram_name = "System RAM (CXL)";
> +
> +struct cxl_sysram_data {
> +	const char *res_name;
> +	int mgid;
> +	struct resource *res;
> +};
> +
> +static DEFINE_MUTEX(cxl_memory_type_lock);
> +static LIST_HEAD(cxl_memory_types);
> +
> +static struct cxl_region *to_cxl_region(struct device *dev)
> +{
> +	if (dev->type != &cxl_region_type)
> +		return NULL;
> +	return container_of(dev, struct cxl_region, dev);
> +}

What's the reasoning behind redefining this in this file? It's still defined in cxl/core/region.c,
so I would probably just drop the static there and include it through core.h.

> +
> +static struct memory_dev_type *cxl_find_alloc_memory_type(int adist)
> +{
> +	guard(mutex)(&cxl_memory_type_lock);
> +	return mt_find_alloc_memory_type(adist, &cxl_memory_types);
> +}
> +
> +static void __maybe_unused cxl_put_memory_types(void)
> +{
> +	guard(mutex)(&cxl_memory_type_lock);
> +	mt_put_memory_types(&cxl_memory_types);
> +}
> +
> +static int cxl_sysram_range(struct cxl_region *cxlr, struct range *r)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	if (!p->res)
> +		return -ENODEV;
> +
> +	/* memory-block align the hotplug range */
> +	r->start = ALIGN(p->res->start, memory_block_size_bytes());
> +	r->end = ALIGN_DOWN(p->res->end + 1, memory_block_size_bytes()) - 1;
> +	if (r->start >= r->end) {
> +		r->start = p->res->start;
> +		r->end = p->res->end;
> +		return -ENOSPC;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t hotunplug_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct range range;
> +	int rc;
> +
> +	if (!cxlr)
> +		return -ENODEV;
> +
> +	rc = cxl_sysram_range(cxlr, &range);
> +	if (rc)
> +		return rc;
> +
> +	rc = offline_and_remove_memory(range.start, range_len(&range));
> +
> +	if (rc)

Extra blank line above.
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(hotunplug);
> +
> +struct online_memory_cb_arg {
> +	int online_type;
> +	int rc;
> +};
> +
> +static int online_memory_block_cb(struct memory_block *mem, void *arg)
> +{
> +	struct online_memory_cb_arg *cb_arg = arg;
> +
> +	if (signal_pending(current))
> +		return -EINTR;
> +
> +	cond_resched();
> +
> +	if (mem->state == MEM_ONLINE)
> +		return 0;
> +
> +	mem->online_type = cb_arg->online_type;
> +	cb_arg->rc = device_online(&mem->dev);
> +
> +	return cb_arg->rc;
> +}
> +
> +static int offline_memory_block_cb(struct memory_block *mem, void *arg)
> +{
> +	int *rc = arg;
> +
> +	if (signal_pending(current))
> +		return -EINTR;
> +
> +	cond_resched();
> +
> +	if (mem->state == MEM_OFFLINE)
> +		return 0;
> +
> +	*rc = device_offline(&mem->dev);
> +
> +	return *rc;
> +}
> +
> +static ssize_t state_store(struct device *dev,
> +			   struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct online_memory_cb_arg cb_arg;
> +	struct range range;
> +	int rc;
> +
> +	if (!cxlr)
> +		return -ENODEV;
> +
> +	rc = cxl_sysram_range(cxlr, &range);
> +	if (rc)
> +		return rc;
> +
> +	rc = lock_device_hotplug_sysfs();
> +	if (rc)
> +		return rc;
> +
> +	if (sysfs_streq(buf, "online")) {
> +		cb_arg.online_type = MMOP_ONLINE_MOVABLE;
> +		cb_arg.rc = 0;
> +		rc = walk_memory_blocks(range.start, range_len(&range),
> +					&cb_arg, online_memory_block_cb);
> +		if (!rc)
> +			rc = cb_arg.rc;
> +	} else if (sysfs_streq(buf, "online_normal")) {
> +		cb_arg.online_type = MMOP_ONLINE;
> +		cb_arg.rc = 0;
> +		rc = walk_memory_blocks(range.start, range_len(&range),
> +					&cb_arg, online_memory_block_cb);
> +		if (!rc)
> +			rc = cb_arg.rc;
> +	} else if (sysfs_streq(buf, "offline")) {
> +		int offline_rc = 0;
> +
> +		rc = walk_memory_blocks(range.start, range_len(&range),
> +					&offline_rc, offline_memory_block_cb);
> +		if (!rc)
> +			rc = offline_rc;
> +	} else {
> +		rc = -EINVAL;
> +	}

Nit: You can just set rc = -EINVAL before the if statement instead of doing this else clause.> +
> +	unlock_device_hotplug();
> +
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(state);
> +
> +static ssize_t hotplug_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_sysram_data *data;
> +	struct range range;
> +	int rc;
> +
> +	if (!cxlr)
> +		return -ENODEV;
> +
> +	data = dev_get_drvdata(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	rc = cxl_sysram_range(cxlr, &range);
> +	if (rc)
> +		return rc;
> +
> +	rc = add_memory_driver_managed(data->mgid, range.start,
> +				       range_len(&range), sysram_name,
> +				       MHP_NID_IS_MGID);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(hotplug);
> +
> +static struct attribute *cxl_sysram_region_attrs[] = {
> +	&dev_attr_hotunplug.attr,
> +	&dev_attr_state.attr,
> +	&dev_attr_hotplug.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group cxl_sysram_region_group = {
> +	.name = "memctl",
> +	.attrs = cxl_sysram_region_attrs,
> +};
> +
> +static void cxl_sysram_unregister(void *_data)
> +{
> +	struct cxl_sysram_data *data = _data;
> +	struct range range = {
> +		.start = data->res->start,
> +		.end = data->res->end
> +	};
> +
> +	/* We have one shot for removal, otherwise it's stuck til reboot */
> +	if (!offline_and_remove_memory(range.start, range_len(&range))) {
> +		remove_resource(data->res);
> +		kfree(data->res);
> +		memory_group_unregister(data->mgid);
> +		kfree(data->res_name);
> +		kfree(data);
> +		return;
> +	}
> +	pr_err("CXL: %#llx-%#llx cannot be hotremoved until next reboot\n",
> +	       range.start, range.end);
> +}
> +
> +int devm_cxl_add_sysram_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct device *dev = &cxlr->dev;
> +	struct cxl_sysram_data *data;
> +	struct memory_dev_type *mtype;
> +	unsigned long total_len = 0;
> +	struct resource *res;
> +	struct range range;
> +	mhp_t mhp_flags;
> +	int numa_node;
> +	int adist = MEMTIER_DEFAULT_CXL_ADISTANCE;
> +	int rc;
> +
> +	numa_node = phys_to_target_node(p->res->start);
> +	if (numa_node < 0) {
> +		dev_warn(dev, "rejecting CXL region with invalid node: %d\n",
> +			 numa_node);
> +		return -EINVAL;
> +	}
> +
> +	rc = cxl_sysram_range(cxlr, &range);
> +	if (rc) {
> +		dev_info(dev, "range %#llx-%#llx too small after alignment\n",
> +			 range.start, range.end);

This should probably be a warning instead. You do it for the next check which is essentially the same
case, so may as well do it here.
> +		return rc;
> +	}
> +	total_len = range_len(&range);
> +
> +	if (!total_len) {
> +		dev_warn(dev, "rejecting CXL region without any memory after alignment\n");
> +		return -EINVAL;
> +	}

I don't think this check is needed. cxl_sysram_range() checks if the range->start == range->end (i.e. size == 0)
and errors out. That should cause the above check to error out before this.
> +
> +	mt_calc_adistance(numa_node, &adist);
> +	mtype = cxl_find_alloc_memory_type(adist);
> +	if (IS_ERR(mtype))
> +		return PTR_ERR(mtype);
> +
> +	init_node_memory_type(numa_node, mtype);
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		rc = -ENOMEM;
> +		goto err_data;
> +	}
> +
> +	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
> +	if (!data->res_name) {
> +		rc = -ENOMEM;
> +		goto err_res_name;
> +	}
> +
> +	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
> +	if (rc < 0)
> +		goto err_reg_mgid;
> +	data->mgid = rc;
> +
> +	/* Region is permanently reserved if hotremove fails when unbinding. */
> +	res = request_mem_region(range.start, range_len(&range),
> +				 data->res_name);
> +	if (!res) {
> +		dev_warn(dev, "range %#llx-%#llx could not reserve region\n",
> +			 range.start, range.end);
> +		rc = -EBUSY;
> +		goto err_request_mem;
> +	}
> +	data->res = res;
> +
> +	/*
> +	 * Setup flags for System RAM. Leave _BUSY clear so add_memory() can add
> +	 * a child resource. Do not inherit flags from parent since it may set
> +	 * flags unknown to us that will the break add_memory() below.
> +	 */
> +	res->flags = IORESOURCE_SYSTEM_RAM;
> +	mhp_flags = MHP_NID_IS_MGID;
> +	rc = add_memory_driver_managed(data->mgid, range.start,
> +				       range_len(&range), sysram_name, mhp_flags);

Look like mhp_flags is only used once, I'd get rid of it and just use MHP_NID_IS_MGID instead.

> +	if (rc) {
> +		dev_warn(dev, "range %#llx-%#llx memory add failed\n",
> +			 range.start, range.end);
> +		goto err_add_memory;
> +	}
> +	dev_dbg(dev, "%s: added %llu bytes as System RAM\n", dev_name(dev),
> +		(unsigned long long)total_len);
> +
> +	dev_set_drvdata(dev, data);
> +	rc = devm_device_add_group(dev, &cxl_sysram_region_group);
> +	if (rc)
> +		goto err_add_group;
> +
> +	return devm_add_action_or_reset(dev, cxl_sysram_unregister, data);
> +
> +err_add_group:
> +	dev_set_drvdata(dev, NULL);
> +	/* if this fails, memory cannot be removed from the system until reboot */
> +	remove_memory(range.start, range_len(&range));
> +err_add_memory:
> +	remove_resource(res);
> +	kfree(res);
> +err_request_mem:
> +	memory_group_unregister(data->mgid);
> +err_reg_mgid:
> +	kfree(data->res_name);
> +err_res_name:
> +	kfree(data);
> +err_data:
> +	clear_node_memory_type(numa_node, mtype);
> +	return rc;
> +}
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 02d7d9ae0252..eeab091f043a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -639,6 +639,9 @@ static ssize_t ctrl_show(struct device *dev, struct device_attribute *attr,
>  	case CXL_MEMCTRL_DAX:
>  		desc = "dax";
>  		break;
> +	case CXL_MEMCTRL_SYSRAM:
> +		desc = "sysram";
> +		break;
>  	default:
>  		desc = "";
>  		break;
> @@ -663,6 +666,8 @@ static ssize_t ctrl_store(struct device *dev, struct device_attribute *attr,
>  
>  	if (sysfs_streq(buf, "dax"))
>  		cxlr->memctrl = CXL_MEMCTRL_DAX;
> +	else if (sysfs_streq(buf, "sysram"))
> +		cxlr->memctrl = CXL_MEMCTRL_SYSRAM;
>  	else
>  		return -EINVAL;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b8fabaa77262..bb4f877b4e8f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -506,13 +506,15 @@ enum cxl_partition_mode {
>  /*
>   * Memory Controller modes:
>   *   None - No controller selected
> - *   Auto - either BIOS-configured as SysRAM, or default to DAX
> - *   DAX  - creates a dax_region controller for the cxl_region
> + *   Auto   - either BIOS-configured as SysRAM, or default to DAX
> + *   DAX    - creates a dax_region controller for the cxl_region
> + *   SYSRAM - hotplugs the region directly as System RAM
>   */
>  enum cxl_memctrl_mode {
>  	CXL_MEMCTRL_NONE,
>  	CXL_MEMCTRL_AUTO,
>  	CXL_MEMCTRL_DAX,
> +	CXL_MEMCTRL_SYSRAM,
>  };
>  
>  /*

