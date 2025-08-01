Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32589207DFE;
	Fri,  1 Aug 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078666; cv=fail; b=H6nF9xWrc3Fr1QbkfcAgp7v9WM5uY4FJcnIFL87E7xYTtpCNBWzZjtGtvauUwAlxWnPNQvEG3mNXcoKoYrmsCzrUG+Jsm9A8uNEUKbnpKUm+/H3NUxHPQOr8dzupLcjDCTKPB6j2+/3NusQaxj5foVL7TyggQzk8Jt3MoJkR0mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078666; c=relaxed/simple;
	bh=x5WvBLjR1gH7P3ZocJ6bcbBF73tc/Hz262p12QqfSXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OM65UDZfs7Ga73RpPJHUA0Ru7gPtcxklsEC7v+xZt62gpUgCKJ6JY1/MigvxJ2vvtfawboRZCCdaiSH6Z5NvqHQSy+u6emCssDp0XzA2++P56aDZ0U2OQeoobP3td4YvTtIZu6kBg2BC3qyYI5eGh0OPCmPHHvu+D0HnpOP49ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cVCRO/6Q; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cVCRO/6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHO2VZX1aB/VouMzGfL1kNt7A42stP1wu3t+4CNNcmKVNr6MOVM2WOFNUWv4CVlJeYoqxnJhzEQEn6K2VXXLaTIEIq5VLJGE3HjHCpdy/DkFud/qDobMN4Q7xxOmnd8Gs1CLSINIhUz8SLFJtPgtWDPYAi8BR14ziIFa8exIXuC4LGq9B+3cKjRj64rctKrHWhKL3cdC9cfg9OjmTkvqyFhZ74uRJMH3pasQr0dGU057VVNivx761xKWoXi9D0UZC3uwE962H0qum5d6bartwzXk1M23ofqcdfgKpZvj3S226I8bnKapnHDyvr3ffxeBxyxjAsEktyMNbAQHw7R3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+n8IPm4BIVdYwxLPVJ1v/XxPKj5+Jd5M8/KAT0EPP4=;
 b=PYxuStes8DoZt2cEtAt1gmSRPRBOOLLPR0H/wZvnME0M0/9GhyhtpJTD0oBkCnDRIaU8nAe2Ek72wSC2MOS2B5ntYJq/9GgW68lR3Nr67OS7hlwu1f6h6Shhfny61nK1SuafqGg7TCCN1i7WQuXEuh0OmUK68imTvuwmA7PQmVy2LAGcCT15keJJO+F5iJYOZfFTXcn+XwsN12G2+H1n9pDP50FYYMyykI46auMDVUIizx0zZbUXHX5eh03+oPLBoOLwbE+corDy/tNy2Yd66d/6xyIPjQbu+P+UGS/61qcKpswJ+CzIXfJdRnLjNo0KENGxpxKtw3SI8qnMvEmRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+n8IPm4BIVdYwxLPVJ1v/XxPKj5+Jd5M8/KAT0EPP4=;
 b=cVCRO/6QNzQa7JYd1tyTruAPKQGUo+vVQbSgYmJVav/TZ+pjAChPbzJ/RiY60ft0CYKUBWLOkhaiftxkhYHDaQig/+9yru277xfCTCxO2tIc1lB+/D+XC+WTbe2IzFzVaNWh1gxBr25nJuPpxgKp45zqDzo5b4rLZHq5Ce9UFvE=
Received: from PH0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:510:5::27)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 20:04:19 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::bf) by PH0PR07CA0022.outlook.office365.com
 (2603:10b6:510:5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 20:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 20:04:19 +0000
Received: from [10.236.183.121] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 15:04:16 -0500
Message-ID: <301195cf-dbb3-45cc-927d-ffd58988aa37@amd.com>
Date: Fri, 1 Aug 2025 15:04:16 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4 v4] cxl/core: Add helpers to detect Low Memory Holes
 on x86
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
	<ming.li@zohomail.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-3-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250724142144.776992-3-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: d08b360e-57bc-4ef9-e7e9-08ddd136998e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHdkWmoveDA2Y2ZaNXRPNlJIVkhualJiVGtpWUJLZTN4cUxWWHQ2NnVPaVJY?=
 =?utf-8?B?RkJwTnJBQVdweVc3V1ZmekdPenlYVWludWJaNmZYajIxa1lLdXI1bTlVZVF0?=
 =?utf-8?B?ZkwrZUlJbEFqVWplRklSbDZDSmJsbU5rOCtMWVZqSUJyem5wVGVKVTJlWlJM?=
 =?utf-8?B?Zkp6dnAzVDYyM1NjMFVzdFNmcThRclVUYUU2OTB3VjNuYTFLRmFCMjZSbjIz?=
 =?utf-8?B?aUNPcHRTTjZHRVQ2MnpqblY3S0JISHlsMVpFTlBmazVKRTdNOGxJNGVTekli?=
 =?utf-8?B?cVVlVDcwZWlLRXhWMUhpRDVldlErT1AxYjJqc3l4cXViVHE3QXhEelllMXhw?=
 =?utf-8?B?dnpidnlOU1lzdmE3VHVBNjhJdWIxUVFvR1QvcGpsWXZMT2ZQQWwrbzRldjZt?=
 =?utf-8?B?MUpJWUVrMkx3WlpwWVBMalpaYWNCWnI5dFg2eWRqaW9DdFE2Z0hWaEV0T3B3?=
 =?utf-8?B?VEE4Mzl6bEZaU2RTaU8wYlc4QVFCNTVYMmhOTDNidThhUWtLSWh3T21vUU1y?=
 =?utf-8?B?aFBxRTFKY2RvRlpQbFJxZ0JRRGJpdXhQZXF3QTJyUFQ2eUxrSWc1a1F5T29m?=
 =?utf-8?B?dGhiaXZwVzYrWFVZN01NODhwSzlNa2NyTC9IK3hVcFc0a3N4emlISll5WUU3?=
 =?utf-8?B?ZHU3TjI5ajlWL3phSTlOWlJiRWNha0JhbE1wcXVjN002SmFMeWN3djVubHUv?=
 =?utf-8?B?WmxjQitQS3o0KzUrbVNPbXp0NkJmTGFHVHc4TnRaVXRzNTI5OXFvcWpVeE4y?=
 =?utf-8?B?M3ozOUFraU0xaUFEQjJQa2Q5RndzWG1XaVcvSnBRQk9QV0dnWEl6WlBQaEJZ?=
 =?utf-8?B?NFFpUlNPRm04d1I3dTJsQ3JuN1EzVEFWSkxBMlg5S1BGMkVUbTFGT3RzOEZp?=
 =?utf-8?B?eUl1U0FFTHJMbmx2dDB0L3U1clhyaHRKcVFKS1ExalkxY1NwazI5RTFyUGVa?=
 =?utf-8?B?M1BQZ0JWdytTb2NQejRxKzJpaWNSd2lQU1lWU0pCNmVCaTVDdStZYTBmWHV3?=
 =?utf-8?B?MU5mdVZ3RlBDWGlpOWhBM0s1eEdnU05tVWlMb0ZzNWhuQjU2YS84QTdrVmsx?=
 =?utf-8?B?d2pLdUl6dURqaVdBcXp0WHJrTHpUWUNCb2xSN0tBczNxb1QyNytUay9Zcytl?=
 =?utf-8?B?cEpwRk0yZkxkS05ya2NsRm8vSTUxWHZLYUhIbThRMDRKOGxnTzBDS0l5V294?=
 =?utf-8?B?Z2FiSSt2dmRnL0dRWUxyc2pQM3pBcHgxb2psNWJDdUhoNEFOdHFuM1lLb0Qz?=
 =?utf-8?B?M0lYTzlMdWNEQVRBQmQ0YzRrRmdaUlpQc1BqeitDUVBiRmZ4cGFDOGJXaHJU?=
 =?utf-8?B?VnVOS1VMdWl3Y3lvZERkZ0xYWE54bTJnYkMyTzhuRTJJMXVZZFV5RHBMV3A3?=
 =?utf-8?B?UXFrbGdWQno1bWpQTjVuMWlCZXl6dlkyY0JVcVEyci9Gejl2U1pTSG5FUFNQ?=
 =?utf-8?B?NFZvdTZBN0xXRGllcDI2YklmYWdrZFB1ZC9iQ3JacjhNeTM5VDc0VCtkRUVq?=
 =?utf-8?B?YTlncHpYd3ZqOGhiWkZrUjkxaGR3M0l5UlhLYzVjM1RqY1laaFlvaG5KRCsv?=
 =?utf-8?B?VGI3bG5XRjcra0ZzVGFJSGhWdWNoM2ZKNjdSWDRBaitaUkVDN2tmNnFQNWVV?=
 =?utf-8?B?ZCthSTRvYWRtT09oZTJUN1JaSTVHY0RrYUNnQjgzMkNqell0RUlTRzR0Zm1V?=
 =?utf-8?B?OUtFOWpXVXh0NHFUVmg0cHNjOHdPNjRjS0krU1U2KzFnYXRpeW5rcCtMbSt4?=
 =?utf-8?B?aTVDT3lHUm9rM3BUcW01clFrVkd5Vk82K212eWF0bDkyeFZYaURzYzVXODQ5?=
 =?utf-8?B?MlA4NmZaM0svR09CdzNMd1Zwa01FQnNaaTcxYm1YckZpUWR2SGdYc2RwNGxY?=
 =?utf-8?B?dnpsVU5vdWVvQUZjM2VnZm1tb3RqcWU2UTErVTY2M05WR0VFaHdWU0hVdlpu?=
 =?utf-8?B?b3pyNEtQelF4QlNxNE4reGxhNlp3YkYzSEV0QllKL1BaMDdoRVlLU0tkZndQ?=
 =?utf-8?B?RnlpTzhRaUQrTldjUmZCeno5Zno0S0JuTEkvNC9hMmM3Rk1ZTmdwMWM0MFZ3?=
 =?utf-8?Q?ARJbIN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 20:04:19.0503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08b360e-57bc-4ef9-e7e9-08ddd136998e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

On 7/24/2025 9:20 AM, Fabio M. De Francesco wrote:
> In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe

s/publishes/publish

> SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
> HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> ranges are always guaranteed to align to the NIW * 256M rule.

s/to align to/to align due to/

Also a spec reference for the rule would be helpful (same with next patch).

> 
> In order to construct Regions and attach Decoders, the driver needs to
> match Root Decoders and Regions with Endpoint Decoders, but it fails and
> the entire process returns errors because it doesn't expect to deal with
> SPA range lengths smaller than corresponding HPA's.
> 
> Introduce functions that indirectly detect x86 LMH's by comparing SPA's
> with corresponding HPA's. They will be used in the process of Regions
> creation and Endpoint attachments to prevent driver failures in a few
> steps of the above-mentioned process.
> 
> The helpers return true when HPA/SPA misalignments are detected under
> specific conditions: both the SPA and HPA ranges must start at
> LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes

maybe sub "that in x86 with LMH's is 0x0" with "0x0 on x86 with LMH's" also
s/SPA range sizes/SPA range's size/.

> be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> aligned to the NIW * 256M rule.

s/be/is/ in above list.

> 
> Also introduce a function to adjust the range end of the Regions to be
> created on x86 with LMH's.
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/Kconfig         |  5 +++
>  drivers/cxl/core/Makefile   |  1 +
>  drivers/cxl/core/platform.c | 85 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/platform.h | 32 ++++++++++++++
>  4 files changed, 123 insertions(+)
>  create mode 100644 drivers/cxl/core/platform.c
>  create mode 100644 drivers/cxl/core/platform.h
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314afdb8..eca90baeac10 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -211,6 +211,11 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_PLATFORM_QUIRKS
> +	def_bool y
> +	depends on CXL_REGION
> +	depends on X86
> +

I'm confused on the intention behind this symbol. The naming suggests it's for all platform quirks,
but the code and dependencies make this x86-specific.

I'm going to suggest making this x86-specific for now. I'm not aware of any other platforms with quirks
(someone correct me if I'm wrong), so making this x86-specific is fine for now. I would rename this
symbol to CXL_X86_QUIRKS, leave dependencies as-is, and rename platform.c to something like platform_x86.c.
Then, if someone comes along with other platform quirks they can do their own symbol and file (or come
up with a generic scheme).

>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..4be729fb7d64 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -18,6 +18,7 @@ cxl_core-y += ras.o
>  cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_PLATFORM_QUIRKS) += platform.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> diff --git a/drivers/cxl/core/platform.c b/drivers/cxl/core/platform.c
> new file mode 100644
> index 000000000000..8202750742d0
> --- /dev/null
> +++ b/drivers/cxl/core/platform.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/range.h>
> +#include "platform.h"
> +#include "cxlmem.h"
> +#include "core.h"
> +
> +/* Start of CFMWS range that end before x86 Low Memory Holes */
> +#define LMH_CFMWS_RANGE_START 0x0ULL
> +
> +/*
> + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> + *
> + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> + * the given endpoint decoder HPA range size is always expected aligned and
> + * also larger than that of the matching root decoder. If there are LMH's,
> + * the root decoder range end is always less than SZ_4G.
> + */

Where does the SZ_4G restraint come from?

Also, might as well make this a kdoc comment since you've already done the majority of the work.

> +bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +				    const struct cxl_endpoint_decoder *cxled)
> +{

Assuming you take renaming suggestion above, these functions should probably be start with
"platform_x86_*" instead.

> +	const struct range *r1, *r2;
> +	int niw;
> +
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	r2 = &cxled->cxld.hpa_range;
> +	niw = cxled->cxld.interleave_ways;
> +
> +	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
> +	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
> +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Similar to platform_root_decoder_contains(), it matches regions and
> + * decoders
> + */
> +bool platform_region_contains(const struct cxl_region_params *p,
> +			      const struct cxl_decoder *cxld)
> +{
> +	const struct range *r = &cxld->hpa_range;
> +	const struct resource *res = p->res;
> +	int niw = cxld->interleave_ways;
> +
> +	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
> +	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
> +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> +		return true;
> +

This if condition could probably move into its own helper function that takes the ranges and
interleave ways. My only hang up is that these functions become 2-3 lines each after doing so.

You could also get rid of these two functions and just export the "helper" function instead.
It would probably add some bloat to patch 3/4, so it's your call here.

> +	return false;
> +}
> +
> +void platform_res_adjust(struct resource *res,
> +			 struct cxl_endpoint_decoder *cxled,
> +			 const struct cxl_root_decoder *cxlrd)
> +{
> +	if (!platform_root_decoder_contains(cxlrd, cxled))
> +		return;
> +
> +	guard(rwsem_write)(&cxl_dpa_rwsem);
> +	dev_info(cxled_to_memdev(cxled)->dev.parent,
> +		 "(LMH) Resources were (%s: %pr, %pr)\n",
> +		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);
> +	if (res) {
> +		/*
> +		 * A region must be constructed with Endpoint Decoder's
> +		 * HPA range end adjusted to Root Decoder's resource end
> +		 */

This comment (and one below) are confusing to me. I'd reword as "Trim region resource
overlap with LMH".

> +		res->end = cxlrd->res->end;
> +	}
> +	/*
> +	 * The Endpoint Decoder's dpa_res->end must be adjusted with Root
> +	 * Decoder's resource end
> +	 */

and reword this one to "Match endpoint decoder's DPA resource to root decoder's". You could
also leave out this comment altogether, the below is self-explanatory IMO.
 
> +	cxled->dpa_res->end =
> +		cxled->dpa_res->start +
> +		resource_size(cxlrd->res) / cxled->cxld.interleave_ways - 1;
> +	dev_info(cxled_to_memdev(cxled)->dev.parent,
> +		 "(LMH) Resources have been adjusted (%s: %pr, %pr)\n",
> +		 dev_name(&cxled->cxld.dev), res, cxled->dpa_res);

I think this function is a bit too noisy. I'd recommend having just this print and
have it say something like "Low memory hole overlap detected, trimmed DPA to %pr".
You could also include the amount trimmed, but that may not be very useful info.

I'd make the first print a dev_dbg() and spell out LMH at the very least. If it's a
dev_info() it should be relatively easy to tell what's going on for a layman.

> +}
> diff --git a/drivers/cxl/core/platform.h b/drivers/cxl/core/platform.h
> new file mode 100644
> index 000000000000..0baa39938729
> --- /dev/null
> +++ b/drivers/cxl/core/platform.h

This is a new file so that these functions can hook into cxl_test, right?
If not, I'd move the below into cxl/core/core.h and remove this file.

> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#include "cxl.h"
> +
> +#ifdef CONFIG_CXL_PLATFORM_QUIRKS
> +bool platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +				    const struct cxl_endpoint_decoder *cxled);
> +bool platform_region_contains(const struct cxl_region_params *p,
> +			      const struct cxl_decoder *cxld);
> +void platform_res_adjust(struct resource *res,
> +			 struct cxl_endpoint_decoder *cxled,
> +			 const struct cxl_root_decoder *cxlrd);
> +#else
> +static bool
> +platform_root_decoder_contains(const struct cxl_root_decoder *cxlrd,
> +			       const struct cxl_endpoint_decoder *cxled)
> +{
> +	return false;
> +}
> +
> +static bool platform_region_contains(const struct cxl_region_params *p,
> +				     const struct cxl_decoder *cxld)
> +{
> +	return false;
> +}
> +
> +void platform_res_adjust(struct resource *res,
> +			 struct cxl_endpoint_decoder *cxled,
> +			 const struct cxl_root_decoder *cxlrd)
> +{
> +}

Don't these need "inline" in the function signatures?

> +#endif /* CONFIG_CXL_PLATFORM_QUIRKS */

