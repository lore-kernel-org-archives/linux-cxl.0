Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA41D958E;
	Fri, 17 Jan 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149560; cv=fail; b=jQf++o6LMnFZKIebwlg5bsGtxRIm0ApMOnHqh7w5gQQZsD0tNNl0WIG3yR8MbmJaVYd+E7Zz0AIHlerSUGE1kIjo+WZHmr+GKxyzbVkE69JJgyrtuXRzViNcyHSO2M9k2ybfoaBbCeNs2t5AiXo0jFYuxWm9gc4u1qypow9Vsvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149560; c=relaxed/simple;
	bh=Cm7R2DvuIw7lZVDkDEUgblj3hFGI3cJ+Ep/qvrk39Os=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p6QRcjdoAB2U1bafx4SClI63gdDP3E9whvtTjxtiXPGvUBw0+CHMOkKtVcfeA/x6d7qowhkfCOiSfTd2g4UUCgcByo3d7Rqil2As/9yOTP5AjQsjF4AVLRrSwlINYlbW3hkzSIjrTVh6urBwU7gtrqhHVzSoieoACIeueenI8IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tnWItYur; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tnWItYur"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywf3lzJDt/QF7sdGWkkO5eREJ13emZ5viWB2DcN/z04K0gPsnxk73OCLpxMzdCbd4XR83jf7nMWTF1WW6RwwC/enz60aH3gZpmrk7VM09xT8WI7mFJ7Q8BWqZslGIw0zkrUrKtkt7FNMI+h2LCEaaSVIVmFQ5/SiJazGAR70xS3y78/x4f3O0/0PUoqmQyqDsj/uQ5dyJrw18DC59TnsRI8HAsPVeXQvOt3WmUg2cmNkOCEgBfv6HPYo+2kabYCLIi/1B9H+1iZG/8EkPaQLgKeFyQRETBIAohopG1FdiENBGFnq0lmkBF8cxAcl7WGBcOMsHQAD2lD7r2A/As40vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtxafGRZQ35RXXkOxB2eOSWsWjMt5fQRkpcYqDB1FOk=;
 b=y+YZDeK9z1Th9FEaPkV3u9shhn3ticAo5fQb6A+MSb5y/hVQufNEsIe2Zi3Xt2fePr/czLNH9MaDVzN9NmugEH3pItnPzMKiggJqdsrA4Jl72tNxjJYlCFuJOaFLIF+4N1b0yomzpBAftWXANmGwWsUBXD8K/5w5gS+REi93EiNeZkQVTtM2tfOWm3DG8XhB9UrQiFpl2FhpiqPPidMhkkHHtY8P6UsoLHFn5VwsixYqfkQ91Q3oCG6ev2YtuBH22YVYzYNm8zxdS42YfD59iRLGl5p4pSb29maMf5Vq+jxfpwxW6Lx8LRYRWuppjqfppoer30GuJQ+c3IPlP9u83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtxafGRZQ35RXXkOxB2eOSWsWjMt5fQRkpcYqDB1FOk=;
 b=tnWItYurxIroS4oJ4chlFr7pygh8Vi1oghD0UXKDG8jHlVAb0GNxLG5NDWatB+EBj8Rstn87ToBD5Y33NREgETH85r2RIaaaBw8sVZxzxLeqKcDRyPoUS7uvmoc+DZAiP105JNn+KEp7OaVkncaLDPqVBQKoSqC2PxPboXtgq5s=
Received: from BN8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:408:ac::44)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 21:32:31 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::c) by BN8PR07CA0031.outlook.office365.com
 (2603:10b6:408:ac::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.15 via Frontend Transport; Fri,
 17 Jan 2025 21:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 21:32:30 +0000
Received: from [10.236.177.252] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 15:32:28 -0600
Message-ID: <5620864b-ff79-490d-bcd4-b34b5de6f8ab@amd.com>
Date: Fri, 17 Jan 2025 15:32:25 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman
	<terry.bowman@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20250107141015.3367194-26-rrichter@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 855c2081-e81c-4269-07e3-08dd373e72c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3pkakozL1B4ZVFXdFF0UU0wNjEzSEdsNjZ6UnB4UG12V1dTL3RaR0NWNExV?=
 =?utf-8?B?eXZwRm5kL0UwbDJIT3p5WWQ4QlNKZ1NWU0ZLa2VRMm1Td0Y3ZmM4cDl4MlY2?=
 =?utf-8?B?SWEvdlZ4TkV1ZUFLaTlBcTZuMWs5TDNkR2JXOHY3bEtqdFRYQ0Q3NVFpTmVh?=
 =?utf-8?B?bUhDcXNTYVpIekkzZjNqeTVReGk5d3BMcHhrVTIwbzJ4N2FNaXRPTG02dEpI?=
 =?utf-8?B?UlFQenFzRzBQeUNWYVRiMkRLMTVuR0lOb25ZREJSQlZsM0c1alpPZ0dYV3hs?=
 =?utf-8?B?RzN2bS80YWVqN2tPWUpuOWc0eWV0OW5saEtpT1BXZGNsYmdXZ2Y5LzIweUZV?=
 =?utf-8?B?dGcvMWdaSTVxdURaQWo2Sk9DSktIdjhScEpJNWpycVVCdXZSUE44ajZXbzd6?=
 =?utf-8?B?UmJENkZiSEIwdnRRK2tZdlNFR1pFTnNpNHYzYWdBQWw2dkhtaHBGWFk5b29U?=
 =?utf-8?B?WU5SZXhtYkllZzJxSm1IVksxcURJODR6SXF6eFFRcFNTKzdCOGRBelN0QVB2?=
 =?utf-8?B?Ly9semIvVEltQ3lWQUl6Z0QwamhualB0SWw1aWNTMm1kRy9UQmdNK3dURER2?=
 =?utf-8?B?OGU4TUR5T0JYT3QyUEVaRytwajRDWHI3WkIzN2h1dUhTZC9lYmEwNXhzS296?=
 =?utf-8?B?enNYWUpSVExYVG55MUJybXhQNmVLVVlYUmFOVjg1cXRnRE1JdS9uTDZpK3Bo?=
 =?utf-8?B?TWYzbUU3RWNRRzRSUzdJRlVyREpMRkNvWk1NaVdSbUJHWWZlbGg1eVNhMlFJ?=
 =?utf-8?B?aTI5TVdPbmd6NnRKWTNuQnEyK0tKRGtnUlFrU005VEg4aHJyYTdyWkhRaUJG?=
 =?utf-8?B?OHZjSlM4b2pBM2t0NkdTLzI2a28zSTJoY09JcEpNWmV2NG1oMkI3TWN0Rmpo?=
 =?utf-8?B?UHl0aDNyV3pBNGVqYkx5cVVSd0FTRFAxQmVsMUlJY0ZDVjJubzZvNG10ejEx?=
 =?utf-8?B?VUdKNk9EOW5RUzZydGFyakY1eXRCVVFIMlhZWnhJQVJkbTVFL20raTlsYlox?=
 =?utf-8?B?QVB0SXBwWmhHLzhZb3g5Z2U3eGhFWG5US2JCTFpwUkJFZjdUOFBMZFhNcjFG?=
 =?utf-8?B?YjFUbXgra1kzdE8yd2RDZHhSVGtHV09Xc2sxTmdZQUlmc1Jjb3hLNUUrOVlu?=
 =?utf-8?B?dnlybzJ0Zm5KRjRsNDZDZnpTbW1uUzFFNWNWRVFiYmg1T0orcHNpZForcVNL?=
 =?utf-8?B?M2FWbnFHMGphVkJKQkpQT1J6RnJoeldISUl0em1uS05naWhjSFN3ZUM5ais4?=
 =?utf-8?B?ZGU1UVdpU3Foa3dVY3BaNlZmUVhYL3psc1d0cCtGVVI4YzVLUjA5QWFMWmpQ?=
 =?utf-8?B?LzVsN2V1MUtNZm44QzRBcE82b01kOEZVek90TXlJeW5oaWh4cU5qUExsTXlo?=
 =?utf-8?B?a3V5SGZxTlJzdHU5ZlljbjFBUHZWTzZMb0tmRkVVOW4xeG4xdVVDcHRhM2dX?=
 =?utf-8?B?dUdveG5lZENrSW9UdXYwSThtR2ZQUSs1Z0lrSEticUE2RElrRVVRUWNnUmR2?=
 =?utf-8?B?YWdST1BkeVc1TXdsYzZIZlNtRCtTdDYrWXZnQWlBb0JSRE4zalBPRjFzbXlr?=
 =?utf-8?B?WHQvZm1uWkpjMis5UFAxdWlTeFVHUCtjZ1pIc0RUaDZXQVFuNkdaUHpyM3kv?=
 =?utf-8?B?QXlUbGNJZ1ZtbGhHYUdSVjQrN0dEVTNrbnBVOHFNU2pkV09LLzBtS2hKeXQy?=
 =?utf-8?B?WFIzRjluOWkwc3NRa0ZoWEJ3R3ZTVjhBMWpERXVFVHdDdWxWclBWeWlBREkx?=
 =?utf-8?B?dEtHYi9wWHJsV3RwakwrblBwSlk3bXlWM2M5dE1JOVJTSlJtdG5uT1ZjTGVX?=
 =?utf-8?B?UE1taElud0IvRVdnMEcrTUliSWNnWHdzUUhtdU9SLy8yWFRJVUh2bXVOQkZK?=
 =?utf-8?B?TE5ZMmJoM3p2b2thdFJlSlovTVNqM1E3SElMYUVyR1cwUXJJVEp4aEVPbFN2?=
 =?utf-8?Q?mfg5hDJ+AcM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:32:30.7956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855c2081-e81c-4269-07e3-08dd373e72c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508

On 1/7/25 8:10 AM, Robert Richter wrote:
> Add AMD platform specific Zen5 support for address translation.
> 
> Zen5 systems may be configured to use 'Normalized addresses'. Then,
> CXL endpoints use their own physical address space and Host Physical
> Addresses (HPAs) need address translation from the endpoint to its CXL
> host bridge. The HPA of a CXL host bridge is equivalent to the System
> Physical Address (SPA).
> 
> ACPI Platform Runtime Mechanism (PRM) is used to translate the CXL
> Device Physical Address (DPA) to its System Physical Address. This is
> documented in:
> 
>  AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
>  ACPI v6.5 Porting Guide, Publication # 58088
>  https://www.amd.com/en/search/documentation/hub.html
> 
> Note that DPA and HPA of an endpoint may differ depending on the
> interleaving configuration. That is, an additional calculation between
> DPA and HPA is needed.
> 
> To implement AMD Zen5 address translation the following steps are
> needed:
> 
> Introduce the generic function cxl_port_platform_setup() that allows
> to apply platform specific changes to each port where necessary.
> 
> Add a function cxl_port_setup_amd() to implement AMD platform specific
> code. Use Kbuild and Kconfig options respectivly to enable the code
> depending on architecture and platform options. Create a new file
> core/amd.c for this.
> 
> Introduce a function cxl_zen5_init() to handle Zen5 specific
> enablement. Zen5 platforms are detected using the PCIe vendor and
> device ID of the corresponding CXL root port.
> 
> Apply cxl_zen5_to_hpa() as cxl_port->to_hpa() callback to Zen5 CXL
> host bridges to enable platform specific address translation.
> 
> Use ACPI PRM DPA to SPA translation to determine an endpoint's
> interleaving configuration and base address during the early
> initialization proces. This is used to determine an endpoint's SPA
> range.
> 
> Since the PRM translates DPA->SPA, but HPA->SPA is needed, determine
> the interleaving config and base address of the endpoint first, then
> calculate the SPA based on the given HPA using the address base.
> 
> The config can be determined calling the PRM for specific DPAs
> given. Since the interleaving configuration is still unknown, chose
> DPAs starting at 0xd20000. This address is factor for all values from
> 1 to 8 and thus valid for all possible interleaving configuration.
> The resulting SPAs are used to calculate interleaving paramters and
> the SPA base address of the endpoint. The maximum granularity (chunk
> size) is 16k, minimum is 256. Use the following calculation for a
> given DPA:
> 
>  ways    = hpa_len(SZ_16K) / SZ_16K
>  gran    = (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
>           / (ways - 1)
>  pos     = (hpa_len(SZ_16K) - ways * SZ_16K) / gran
> 
> Once the endpoint is attached to a region and its SPA range is know,
> calling the PRM is no longer needed, the SPA base can be used.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/Kconfig       |   4 +
>  drivers/cxl/core/Makefile |   1 +
>  drivers/cxl/core/amd.c    | 227 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/core.h   |   6 +
>  drivers/cxl/core/port.c   |   7 ++
>  5 files changed, 245 insertions(+)
>  create mode 100644 drivers/cxl/core/amd.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 876469e23f7a..e576028dd983 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -146,4 +146,8 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_AMD
> +       def_bool y
> +       depends on AMD_NB
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 9259bcc6773c..dc368e61d281 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -16,3 +16,4 @@ cxl_core-y += pmu.o
>  cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_AMD) += amd.o
> diff --git a/drivers/cxl/core/amd.c b/drivers/cxl/core/amd.c
> new file mode 100644
> index 000000000000..553b7d0caefd
> --- /dev/null
> +++ b/drivers/cxl/core/amd.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.

Make sure to update the year. Don't know if it's supposed to be 2024-2025 or just 2025.

> + */
> +
> +#include <linux/prmt.h>
> +#include <linux/pci.h>
> +
> +#include "cxlmem.h"
> +#include "core.h"
> +
> +#define PCI_DEVICE_ID_AMD_ZEN5_ROOT		0x153e
> +
> +static const struct pci_device_id zen5_root_port_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ZEN5_ROOT) },
> +	{},
> +};
> +
> +static int is_zen5_root_port(struct device *dev, void *unused)
> +{
> +	if (!dev_is_pci(dev))
> +		return 0;
> +
> +	return !!pci_match_id(zen5_root_port_ids, to_pci_dev(dev));
> +}
> +
> +static bool is_zen5(struct cxl_port *port)
> +{
> +	if (!IS_ENABLED(CONFIG_ACPI_PRMT))
> +		return false;
> +
> +	/* To get the CXL root port, find the CXL host bridge first. */
> +	if (is_cxl_root(port) ||
> +	    !port->host_bridge ||
> +	    !is_cxl_root(to_cxl_port(port->dev.parent)))
> +		return false;
> +
> +	return !!device_for_each_child(port->host_bridge, NULL,
> +				       is_zen5_root_port);
> +}
> +
> +/*
> + * PRM Address Translation - CXL DPA to System Physical Address
> + *
> + * Reference:
> + *
> + * AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
> + * ACPI v6.5 Porting Guide, Publication # 58088
> + */
> +
> +static const guid_t prm_cxl_dpa_spa_guid =
> +	GUID_INIT(0xee41b397, 0x25d4, 0x452c, 0xad, 0x54, 0x48, 0xc6, 0xe3,
> +		  0x48, 0x0b, 0x94);
> +
> +struct prm_cxl_dpa_spa_data {
> +	u64 dpa;
> +	u8 reserved;
> +	u8 devfn;
> +	u8 bus;
> +	u8 segment;
> +	void *out;
> +} __packed;
> +
> +static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
> +{
> +	struct prm_cxl_dpa_spa_data data;
> +	u64 spa;
> +	int rc;
> +
> +	data = (struct prm_cxl_dpa_spa_data) {
> +		.dpa     = dpa,
> +		.devfn   = pci_dev->devfn,
> +		.bus     = pci_dev->bus->number,
> +		.segment = pci_domain_nr(pci_dev->bus),
> +		.out     = &spa,
> +	};
> +
> +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc) {
> +		pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
> +		return ULLONG_MAX;
> +	}
> +
> +	pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n", dpa, spa);
> +
> +	return spa;
> +}
> +
> +static u64 cxl_zen5_to_hpa(struct cxl_decoder *cxld, u64 hpa)

After reading through your discussion with Gregory I'm not confused about the function name
anymore, but I would definitely include a comment specifying the expected usage and return value.

Thanks,
Ben

> +{
> +	struct cxl_memdev *cxlmd;
> +	struct pci_dev *pci_dev;
> +	struct cxl_port *port;
> +	u64 dpa, base, spa, spa2, len, len2, offset, granularity;
> +	int ways, pos;
> +
> +	/*
> +	 * Nothing to do if base is non-zero and Normalized Addressing
> +	 * is disabled.
> +	 */
> +	if (cxld->hpa_range.start)
> +		return hpa;
> +
> +	/* Only translate from endpoint to its parent port. */
> +	if (!is_endpoint_decoder(&cxld->dev))
> +		return hpa;
> +
> +	if (hpa > cxld->hpa_range.end) {
> +		dev_dbg(&cxld->dev, "hpa addr %#llx out of range %#llx-%#llx\n",
> +			hpa, cxld->hpa_range.start, cxld->hpa_range.end);
> +		return ULLONG_MAX;
> +	}
> +
> +	/*
> +	 * If the decoder is already attached, the region's base can
> +	 * be used.
> +	 */
> +	if (cxld->region)
> +		return cxld->region->params.res->start + hpa;
> +
> +	port = to_cxl_port(cxld->dev.parent);
> +	cxlmd = port ? to_cxl_memdev(port->uport_dev) : NULL;
> +	if (!port || !dev_is_pci(cxlmd->dev.parent)) {
> +		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
> +			dev_name(cxld->dev.parent), cxld->hpa_range.start,
> +			cxld->hpa_range.end);
> +		return ULLONG_MAX;
> +	}
> +	pci_dev = to_pci_dev(cxlmd->dev.parent);
> +
> +	/*
> +	 * The PRM translates DPA->SPA, but we need HPA->SPA.
> +	 * Determine the interleaving config first, then calculate the
> +	 * DPA. Maximum granularity (chunk size) is 16k, minimum is
> +	 * 256. Calculated with:
> +	 *
> +	 *	ways	= hpa_len(SZ_16K) / SZ_16K
> +	 * 	gran	= (hpa_len(SZ_16K) - hpa_len(SZ_16K - SZ_256) - SZ_256)
> +	 *                / (ways - 1)
> +	 *	pos	= (hpa_len(SZ_16K) - ways * SZ_16K) / gran
> +	 */
> +
> +	/*
> +	 * DPA magic:
> +	 *
> +	 * Position and granularity are unknown yet, use an always
> +	 * valid DPA:
> +	 *
> +	 * 0xd20000 = 13762560 = 16k * 2 * 3 * 2 * 5 * 7 * 2
> +	 *
> +	 * It is divisible by all positions 1 to 8. The DPA is valid
> +	 * for all positions and granularities.
> +	 */
> +#define DPA_MAGIC	0xd20000
> +	base = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC);
> +	spa  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K);
> +	spa2 = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K - SZ_256);
> +
> +	/* Includes checks to avoid div by zero */
> +	if (!base || base == ULLONG_MAX || spa == ULLONG_MAX ||
> +	    spa2 == ULLONG_MAX || spa < base + SZ_16K || spa2 <= base ||
> +	    (spa > base + SZ_16K && spa - spa2 < SZ_256 * 2)) {
> +		dev_dbg(&cxld->dev, "Error translating HPA: base %#llx, spa %#llx, spa2 %#llx\n",
> +			base, spa, spa2);
> +		return ULLONG_MAX;
> +	}
> +
> +	len = spa - base;
> +	len2 = spa2 - base;
> +
> +	/* offset = pos * granularity */
> +	if (len == SZ_16K && len2 == SZ_16K - SZ_256) {
> +		ways = 1;
> +		offset = 0;
> +		granularity = 0;
> +		pos = 0;
> +	} else {
> +		ways = len / SZ_16K;
> +		offset = spa & (SZ_16K - 1);
> +		granularity = (len - len2 - SZ_256) / (ways - 1);
> +		pos = offset / granularity;
> +	}
> +
> +	base = base - DPA_MAGIC * ways - pos * granularity;
> +	spa = base + hpa;
> +
> +	/*
> +	 * Check SPA using a PRM call for the closest DPA calculated
> +	 * for the HPA. If the HPA matches a different interleaving
> +	 * position other than the decoder's, determine its offset to
> +	 * adjust the SPA.
> +	 */
> +
> +	dpa = (hpa & ~(granularity * ways - 1)) / ways
> +		+ (hpa & (granularity - 1));
> +	offset = hpa & (granularity * ways - 1) & ~(granularity - 1);
> +	offset -= pos * granularity;
> +	spa2 = prm_cxl_dpa_spa(pci_dev, dpa) + offset;
> +
> +	dev_dbg(&cxld->dev,
> +		"address mapping found for %s (dpa -> hpa -> spa): %#llx -> %#llx -> %#llx base: %#llx ways: %d pos: %d granularity: %llu\n",
> +		pci_name(pci_dev), dpa, hpa, spa, base, ways, pos, granularity);
> +
> +	if (spa != spa2) {
> +		dev_dbg(&cxld->dev, "SPA calculation failed: %#llx:%#llx\n",
> +			spa, spa2);
> +		return ULLONG_MAX;
> +	}
> +
> +	return spa;
> +}
> +
> +static void cxl_zen5_init(struct cxl_port *port)
> +{
> +	if (!is_zen5(port))
> +		return;
> +
> +	port->to_hpa = cxl_zen5_to_hpa;
> +
> +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> +		dev_name(&port->dev));
> +}
> +
> +void cxl_port_setup_amd(struct cxl_port *port)
> +{
> +	cxl_zen5_init(port);
> +}
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 800466f96a68..efe34ae6943e 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -115,4 +115,10 @@ bool cxl_need_node_perf_attrs_update(int nid);
>  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
> +#ifdef CONFIG_CXL_AMD
> +void cxl_port_setup_amd(struct cxl_port *port);
> +#else
> +static inline void cxl_port_setup_amd(struct cxl_port *port) {};
> +#endif
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 901555bf4b73..c8176265c15c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -831,6 +831,11 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  			    &cxl_einj_inject_fops);
>  }
>  
> +static void cxl_port_platform_setup(struct cxl_port *port)
> +{
> +	cxl_port_setup_amd(port);
> +}
> +
>  static int cxl_port_add(struct cxl_port *port,
>  			resource_size_t component_reg_phys,
>  			struct cxl_dport *parent_dport)
> @@ -868,6 +873,8 @@ static int cxl_port_add(struct cxl_port *port,
>  			return rc;
>  	}
>  
> +	cxl_port_platform_setup(port);
> +
>  	rc = device_add(dev);
>  	if (rc)
>  		return rc;

