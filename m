Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068C1F4CBF;
	Fri,  1 Aug 2025 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078671; cv=fail; b=nA+VdkDc6yQzLwrBTWT0ul40lcT0dkzf8A/WnYNuM1KNMIcwVFPja9qybWL7+nq2re6FqNm3aaU3tbSpRld0t2+YOTE4r+iHi7vC6EJOCk0dmvhFYSrVe2+WFXXeELS5OfvMDR/NFCe+CcFH2hOc9YK3w9SG3XwbD7EZvqjRDlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078671; c=relaxed/simple;
	bh=FDE6yP7X/23wraibUTkvemBUSMTgE6IEIJKajKWhugc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TLeqEj9aLki6OzpG29yaeBllo3ypIsL2P9VYS/fLIORpshnhzRh1Jh9NyRrD9JkRv0X//lr9dTu980zZNcz2Xo89jqXSBvJUnTMqDBWY2Ti8VEu24RNmeEf6WHZzK53BYdnMXQoR0oDTzFt1GDHJ03+0ANnKajByfLU1smVcjgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0kSd0bFz; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0kSd0bFz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI3dKIi6RdIfdfSV32TOOKeuRkASpT5/1nHE55ZsSfZnslWkWt/uSCDbQe11/Ng5SdXysF/uafBrzIrZmIJ7t+QHyd2Vm6yXlTDyI7+W443e2hPKmz/G8T9QDVmRl6qT/82/+ShJf7r0488FGCnp7eUCDDchxnLgES4d25PdgHKVgfxOfvareqEi7HwNx6ionr0AUQv7Sd/xFIGvuYQO5i7Xl8S0TAnXIl83kQ0y/hkfRVKX0Ng/KNvNZEqXOz4B8zDh54RsPnb7pwiEpoQPSXwe5GE3X07fU1/6TNM/+ZY7iSKPntD8ospvgUnkmzp/poQngTKzi5AHtIJKW5VcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3mQcYkVi3zPHEZlG1pkb9bn6Kgmu1IEPiBTfKzC2Sw=;
 b=ilYvW+YmsY4H1W6g2LQ/yW/D6L2jm4M+X0vEq5hitEnIpNuk4xQRpvqJPwIxYAygPkS2QrKamJkuZCe8duIgl1mwpKHJUR0LZN07z20Kl9pLeS26cp8ahSES9S2PvXRD7D9PB48o6efnuO0QGRvDbQL/Oeq8BJmrAq2+7VB+e2PWjiEAL9d1rudtXaijdUgNo3zhqaefGLT3ptL8sj3GoSQ5cAkEzi+Brx/9ZjUt0j8vHo7x0YM4Ut3Zy7xrcOJRDSjJTGKZCI7hDfEnyA4dSq5vEtyZ7/oC+a2f4km6uu5Ia+wNtsAEaUq/Mubul+gpLgzaDzTQQyGjBHp7cge/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3mQcYkVi3zPHEZlG1pkb9bn6Kgmu1IEPiBTfKzC2Sw=;
 b=0kSd0bFzju33jroKkp2oPdIWsUbuqH0Kx53+1p5phExbsxFuyvegB0xKQGaFs1AIDyaSfFtInYvCHngjueh+xpLMwj42IyqGSj30hvkwLDzHdff1HR98hJMqCFd3pK4PbXAmJwL+Tz0ax8wR6RsN2dyMArCETMmcgAi0W++JWcs=
Received: from PH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:510:5::33)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 20:04:23 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::f) by PH0PR07CA0028.outlook.office365.com
 (2603:10b6:510:5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 20:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 20:04:22 +0000
Received: from [10.236.183.121] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 15:04:18 -0500
Message-ID: <7dbbc289-f6be-4a57-aacd-77838b3d27ea@amd.com>
Date: Fri, 1 Aug 2025 15:04:18 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v4] cxl/core: Enable Region creation on x86 with LMH
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Robert Richter <rrichter@amd.com>,
	<ming.li@zohomail.com>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
References: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
 <20250724142144.776992-4-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250724142144.776992-4-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab326f1-a1c4-4644-ba6c-08ddd1369bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHFrMnc4TWU3OHpXWEhud3dBWGsrQ0pUUVFCRk9veXNjRWZEOFdzZUo2UitF?=
 =?utf-8?B?bkUxOG9zVGVkYkRYQlg4NWtQK0F0ZUptY3pSUEFrNWRZcFZBR1ppdzZGVGRp?=
 =?utf-8?B?NUg2ZWEwKy9vU2RkR3FONmJ1WS9rTUIyVjZsTFlBS1JGd1Uxdk40RWFYdGh3?=
 =?utf-8?B?Z3NGTUxreXp3OXR0UHVGeHczNTRVTnJuYXpoUVJCTmFFNkdPNjI0YzJIOTd4?=
 =?utf-8?B?VWxtU3hjb0tTaFN0bk9zMjJRSkRpNjYrN3M0L3YyT0xlUVdtUEd3UUdFSkUr?=
 =?utf-8?B?a2ZUVDdoUllkbDFWYjFhODRYRW80L09Zd29SdlpMdEM2ajNQSXJBU1BKaE1L?=
 =?utf-8?B?dDhTdHZDVmJaa2hCNFM3b2NibmRLemY0MkJLY1plSVh3SUMvWHlBdUwra3RS?=
 =?utf-8?B?b2l6Ky9jMjdtMC9sbWYzZnNyVzkzK1lSMzhobjJtMkxJV2E2ZG10a3d1K2ho?=
 =?utf-8?B?blFBai8wV2ZmNmdYYkFJR0xMS3R4ZWtjZmNFUUJxTkZTMm5mcEtaRnIrb2VS?=
 =?utf-8?B?WUs0Q2tnaW9DTkNPVWNmcEpiL1l4Q0dxeTluOHVYa1g0cmZZWWlGN0N0U2dh?=
 =?utf-8?B?dUxXZ3loT0ExN3FpeHdJMnlQS1Z5SGpyTFNRNitsN1pFdnVXbTN6ZUZrTGFP?=
 =?utf-8?B?Nkt6TzVqMytPSkdMWEgyVXNhMVBSWFJ5ZTdkeFhJVWhEMDhCbmdua0dicHRv?=
 =?utf-8?B?QWdFb0pxSGJMY3ZWSlRIR3lJeXVXSnVaSTA0RDNCVk1JelNEcGE4R3A4cVNi?=
 =?utf-8?B?TVRXMzVsYlFNSzRJTk1XTTduR00vOEVPTWhRTHFUSFpkRTdaaS8vKzdJV2FI?=
 =?utf-8?B?UXBqK0xjRmJsTm5JMFMxZnczNkJQSTV0a2hOSDBTWDNXd1dmNGZtNk1iaWt5?=
 =?utf-8?B?SThUQm5TbkFZdzIva2NFSVprK1NCMElld09nRVpsVXBTNVJQZmI1ckRZOFJi?=
 =?utf-8?B?RjZwdytiUGVlR2F3elhvbnBuMXN4bTcyak9SVGRQczdYSXFHV21YbnhxaHNt?=
 =?utf-8?B?YkZSSEpsRDlvN1dWeXlGdllHN0hpWjV6TlNUYzFrcTBQcHlJb3ZoSy9udUFa?=
 =?utf-8?B?Ri9DbFdyQ0V6ME1qamtXWURLaXRaWC9JRHdFTU5EQnppR0UzQ3JGVUhVVFBP?=
 =?utf-8?B?amt3KytZYytMWnJGZllOVzNoQnVjYmFOQzhyNDk0UDNtL01CMDNhSmRlaGht?=
 =?utf-8?B?d0VZTjJFQkphVDNkclRxMUNuVlpIdVo1c0MxOWlibWc5aVVyaXR1YThXN3Qx?=
 =?utf-8?B?SVVnN3lvKzRwdFJIMTF5bHY0R1cvK0x1VFV6Y25DNC9tS0JkS2U5bGRpUGoz?=
 =?utf-8?B?djk5czRxQW5tMVJrbzhRcUk3aWFhTHhGY2hzSkRSdVFIV3JDUzl4eForTlFX?=
 =?utf-8?B?SERxR3labEhCR2paUHNGdHpLa0svNWFMZjlmTVRLc3Z1bkF0T3FoMEQwMTd4?=
 =?utf-8?B?SDlnSFh2Wnp0ZWpiclJYQm9yWm5DcVhCdytGNng0aW5xb2h2T1hrZ204U3hK?=
 =?utf-8?B?M01pVHRwU3d0R3d5Y1A4SGZwVnlIMFVCd1ZWVG00YktiWWY0elErS0JaZEdr?=
 =?utf-8?B?YlB2QU1kN3ZVUTk0OVpRc1ZHY3BKNWQrVUVSUEFYWXJxclFQUGtuTzBGb0RW?=
 =?utf-8?B?akpqWkYrQkFiWEFsL1VkS2oxMjhyZktnY0dWZDV4V3gyYStOMEFiSzNVQlBp?=
 =?utf-8?B?ZmZtUWYwRW1HSDRJSGZHME5QYTRxR2tGMFRsdkZFTUsxY0tQWXdrODRwaGxz?=
 =?utf-8?B?ZGo2bVlTa3UrVm5MVjRaQTVFdEo4dllabExUQVh6NFpwQmxpZ0FGQWs2R1Rj?=
 =?utf-8?B?dmRSZENuNjRzUmRYMHVpZ1lMWGNodXlEQnVld0JJNHhxKzlicHNTU0IxaTdQ?=
 =?utf-8?B?ZG5iOTJvdExYeVNSTDBzWW54VVZIaXlzWkhxV2o1bzlZNHhnSThSUGdEaTJa?=
 =?utf-8?B?M2UyRnBBM0ZyRU8vWU9pdUFlclJOUkJGRloxWmllZ2RWWVdvS1NRT09DcjQ4?=
 =?utf-8?B?YUpQNUtreThRVFQvbWUyYm5odytYU2hTVjFHelQ3YXNnUXdNS3RSckcwMzZB?=
 =?utf-8?Q?n5NWsI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 20:04:22.8433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab326f1-a1c4-4644-ba6c-08ddd1369bd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885

On 7/24/2025 9:20 AM, Fabio M. De Francesco wrote:
> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> Physical Address (HPA) windows that are associated with each CXL Host
> Bridge. Each window represents a contiguous HPA that may be interleaved
> with one or more targets (CXL v3.1 - 9.18.1.3).

Update to 3.2 spec? Sorry I forgot to mention it earlier, but you'll probably
want to do this for the whole series.

> 
> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> memory to which systems cannot send transactions. In some cases the size
> of that hole is not compatible with the CXL hardware decoder constraint
> that the size is always aligned to 256M * Interleave Ways.

Spec ref here.

> 
> On those systems, BIOS publishes CFMWS which communicate the active System
> Physical Address (SPA) ranges that map to a subset of the Host Physical
> Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> the endpoint is lost with no SPA to map to CXL HPA in that hole.
> 
> In the early stages of CXL Regions construction and attach on platforms
> with Low Memory Holes, cxl_add_to_region() fails and returns an error
> because it can't find any CXL Window that matches a given CXL Endpoint
> Decoder.
> 
> Detect a Low Memory Hole by comparing Root Decoders and Endpoint Decoders
> ranges with the use of arch_match_{spa,region}() helpers.
> 
> Match Root Decoders and CXL Regions with corresponding CXL Endpoint
> Decoders. Currently a Low Memory Holes would prevent the matching functions
> to return true.
> 
> Construct CXL Regions with HPA range's end adjusted to the matching SPA.
> 
> Allow the attach target process to complete by allowing Regions to not
> fit with alignment constraints (i.e., alignment to NIW * 256M rule).
> 
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/cxl/core/region.c | 53 +++++++++++++++++++++++++++++++++------
>  tools/testing/cxl/Kbuild  |  1 +
>  2 files changed, 46 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f607e7f97184..b7fdf9c4393d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -12,6 +12,7 @@
>  #include <linux/memory-tiers.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> +#include "platform.h"
>  #include "core.h"
>  
>  /**
> @@ -834,6 +835,8 @@ static int match_free_decoder(struct device *dev, const void *data)
>  static bool region_res_match_cxl_range(const struct cxl_region_params *p,
>  				       struct range *range)
>  {
> +	struct cxl_decoder *cxld;
> +
>  	if (!p->res)
>  		return false;
>  
> @@ -842,8 +845,15 @@ static bool region_res_match_cxl_range(const struct cxl_region_params *p,
>  	 * to be fronted by the DRAM range in current known implementation.
>  	 * This assumption will be made until a variant implementation exists.
>  	 */
> -	return p->res->start + p->cache_size == range->start &&
> -		p->res->end == range->end;
> +	if (p->res->start + p->cache_size == range->start &&
> +	    p->res->end == range->end)
> +		return true;
> +
> +	cxld = container_of(range, struct cxl_decoder, hpa_range);
> +	if (platform_region_contains(p, cxld))
> +		return true;
> +
> +	return false;

Can just return result of platform_region_contains() here.

>  }
>  
>  static int match_auto_decoder(struct device *dev, const void *data)
> @@ -1763,6 +1773,7 @@ static int match_switch_and_ep_decoders(struct device *dev, const void *data)
>  {
>  	const struct cxl_endpoint_decoder *cxled = data;
>  	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
>  	const struct range *r1, *r2;
>  
>  	if (!is_switch_decoder(dev))
> @@ -1772,8 +1783,13 @@ static int match_switch_and_ep_decoders(struct device *dev, const void *data)
>  	r1 = &cxlsd->cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	if (is_root_decoder(dev))
> -		return range_contains(r1, r2);
> +	if (is_root_decoder(dev)) {
> +		if (range_contains(r1, r2))
> +			return 1;
> +		cxlrd = to_cxl_root_decoder(dev);
> +		if (platform_root_decoder_contains(cxlrd, cxled))
> +			return 1;
> +	}

I don't think it's possible, but the way this is written allows falling through
to the return statement below. This if statement should probably be: 

	if (is_root_decoder(dev)) {
		cxlrd = to_cxl_root_decoder(dev);
		return range_contains(r1, r2) || platform_root_decoder_contains(cxlrd, cxled));
	}

>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> @@ -1990,7 +2006,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	}
>  
>  	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
> -	    resource_size(p->res)) {
> +	    resource_size(p->res) && !platform_root_decoder_contains(cxlrd, cxled)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s-size-%#llx * ways-%d + cache-%#llx != region-size-%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> @@ -3230,7 +3246,12 @@ static int match_root_and_ep_decoders(struct device *dev, const void *data)
>  	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  	r2 = &cxled->cxld.hpa_range;
>  
> -	return range_contains(r1, r2);
> +	if (range_contains(r1, r2))
> +		return true;
> +	if (platform_root_decoder_contains(cxlrd, cxled))
> +		return true;
> +
> +	return false;

Can just return the || of the two above if statements.

>  }
>  
>  static struct cxl_decoder *
> @@ -3277,8 +3298,12 @@ static int match_region_and_ep_decoder(struct device *dev, const void *data)
>  	p = &cxlr->params;
>  
>  	guard(rwsem_read)(&cxl_region_rwsem);
> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
> -		return 1;
> +	if (p->res) {
> +		if (p->res->start == r->start && p->res->end == r->end)
> +			return 1;
> +		if (platform_region_contains(p, &cxled->cxld))
> +			return 1;
> +	}

Same thing here.

>  
>  	return 0;
>  }
> @@ -3355,6 +3380,12 @@ static int __construct_region(struct cxl_region *cxlr,
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
>  
> +	/*
> +	 * Trim the HPA retrieved from hardware to fit the SPA mapped by the
> +	 * platform
> +	 */
> +	platform_res_adjust(res, cxled, cxlrd);
> +
>  	rc = cxl_extended_linear_cache_resize(cxlr, res);
>  	if (rc && rc != -EOPNOTSUPP) {
>  		/*
> @@ -3464,6 +3495,12 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  		cxl_find_region_by_range(cxlrd, cxled);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
> +	else
> +		/*
> +		 * Adjust the Endpoint Decoder's dpa_res to fit the Region which
> +		 * it has to be attached to
> +		 */
> +		platform_res_adjust(NULL, cxled, cxlrd);

I'm 50/50 on whether these comments are unnecessary. The routine is pretty well documented
and also has an explanatory comment above the definition in platform.c. I think you
can probably remove them, but I'll defer to your/someone else's judgement here.

Thanks,
Ben
