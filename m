Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010039.outbound.protection.outlook.com [52.101.193.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD2451984
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085665; cv=fail; b=jfRwOGLJkT389wMnZVLw3J8VYZiIF8HFhLuzBjPS9EXmR81lHG79FHr+LIICW0gLDDjiwcHKjHSD/wn3Je7JJNlB9vcvSpWBh7ogY4JHI96Y/kUCVXGlexf7U3KppQ7nVpf0W70wcaqFSW3Cp+gE+P0e+QaS9MKrAt3KqsJUWdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085665; c=relaxed/simple;
	bh=Bmv/s0FCK34vt3n8h5FKUEba2LoFQePJNk+y5951k9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GWB3JUHeZsPi/kGyzBOHHu2sBylQSEbdYPMqlbgimDqIqbGfGSPi3t/EW0/VIIScCkBgaKZcPyCuhlFITjIP/blMjw3o5aHPMVYbld2/XegRs+LF6+2E9Os4ldnmu/8mEMQmQTz1y6tCqticRcrLcCEzl2E9SzFNX7uHIrAIhn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pohGR0bS; arc=fail smtp.client-ip=52.101.193.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pohGR0bS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o43s+jZU3tDfkWDrc/VycNewuROMLeqKHB2fT9cSwK2rE8pubnjqcfpWzFulzEd1DgQ85FEFMAtYAHr4DAVM7GZGkJcN+ESCg0fAq5ArrzTa8lBc6N2bPR9LIQps5WjhRXgMEjNFcm7ua1nK6kL1RqbC4CGXcolsOUXZfbsKUTl0pR9VZrlVroJYcLB+FablJ8uW5MLNoBn9WtMS0rM4uo8f8CWL1MG6/igv0RbhPRXbfPjaBL8klKi1imdZLrZCqBqDNt+GSVdG8aZLXFUOQ0jgC0tqNxUw0Bmd+cD/On4M3xVi/U6d9z12q+xB9HD/xwfgZ0vacnecaSSt0N5ANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5asIGKcUjIiYX3dpAK1o+tcdIO4KRaog3na+iC1p8M0=;
 b=T5RC57Z0HF6iaKzaPmeNACMnf8N9UTPjQJinBMQrtY2WRvEfzvpOJYixILzM8D8P+vXXcbxuaxjNs+ojfnQRdEYycbFCkBG8qVZ3dhgsvlquJQgtJysg10VMLLPYY4ox8wzkefxeuhehtlQsi/LYSFGCOF2EzVLLO9HAKYsZ+Jb6s+QhEsCrDFMbFLf+4GuqHLBrUIiKmLAq4pmwvChyuhhqUU3RnZeqhhWD/BliLdwQ0p50b2J6mfbsikf8qV3+vtVJJfPE6ONg7aEFdx0go5Q3MEy0hSxWhuyAwIhirSf1yclhyeYWxAI+fh8g2/AOB5//7miVQlinONkib4qxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5asIGKcUjIiYX3dpAK1o+tcdIO4KRaog3na+iC1p8M0=;
 b=pohGR0bSKkSXdwXiAfKsu7QpJDeF7/M5G/bMcCPwZog3onqhOO0qEMzAm8r6BRKa+fzUQgKA9Xg5B87Gpt7j30ocoDa+pf4mIOw3stbirU416fWZENr04FPLnsK7XepzFErVlR21Thn+p5knPFolW8DvVcBmjTYDuq+MsGMUJOziocsjftFZCi7eX+TNCheS5vrkCzDrai4SzqMcrIM5Yv38hR+E7xNjZtLcGUm1SWCWHns259CXK6Swsk+VydkY60wef+HledBR3eTQzrphyk7uIV4K9ZwT338w+fE4NuruOniPykxAP500eKkW0jvXzLarx9Gw8n7T3QzYoWkqgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW4PR12MB7120.namprd12.prod.outlook.com (2603:10b6:303:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Fri, 7 Aug
 2026 06:54:16 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 06:54:16 +0000
Date: Fri, 7 Aug 2026 14:54:07 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com, 
	benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 2/8] cxl/pci: Add BI topology enable/disable
Message-ID: <anV9OphxsNzGO6mR@MWDK4CY14F>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-3-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728144136.709882-3-dave@stgolabs.net>
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW4PR12MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: b02a8c5d-4b7b-41e7-bf8c-08def450b1aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|5023799004|4143699003|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	nid1GaeMTFMQv6mx1zPqTpIbfLNzBV42l7VINsxLovAnJUqwwCfmrNLSLIBvW3/xcMDQ2Spel14/CGTD9i1QN1fpH5XjFXUr5xazajOcVauG/d0wDvepqHufyuYmLEpI6npde2gErTTR1JWmNnZXJD8nTh9bkDc3Lb+Jx/mY+QXO7WURoCRCaDmjDd5xMNwptPFhc3QxlauFpJaYO7Ow84b9Xze/yK47i8l5L45POrlx5Q+1tbrESKUbOMecWt+mzIcbSSsZYzPBMtyREfd42I6twOc27TWy8FJT0dfooo6jstCSGQM3q9KOGx8XBq64vfqC3GsckuVegKcwsezyGSkGXdUo74OM2Ef5zZp4H6exwtVkY7ikggEuFVVOgXoApL/H1IVh6MBuvwCnUHYeE5q1lnNB1nASEJFS4UFO6hPcXyM/8U20+yddRRvj1udkwWPBGe2LMguQcZGRqkX4i/GUYUN7x8QaK8h5vUAoScoFUUjGj+N8bddNGHVu3CskGsr6JOBAvE6uiMGwWf2YPy9fax7JNH0lOjKj6vTVXLY35NMSHnAus/Q+lgZBrHExlohzix14ls1FKrlw6WmW6SBg2i1qmv8Vm5+lM9yv2fLy0zcGaS1SUNBYBg38JeCZA7LqQYDa2/YYOLXcszhyfeABshOu3vZJNzrfqANrj+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?waxHQHJeTgXXWNNZ5B1LneUoiF1JLFL9PYhQ53ZNeseRf+VrBg/inbnuvYro?=
 =?us-ascii?Q?hnl/OKCN6ecDIaD86AW3LCwk9R2aWI5OY521+9xBc5lqYcvcRWOMe5OjK5HS?=
 =?us-ascii?Q?Bw3oq9K6ge7tivU8byYPsDwPa70kEfGL8/oNDCoWbrY+cpv+4Lw52s2FzX0A?=
 =?us-ascii?Q?TbwNikPLoTUlplSCK7qv3SBZhPhlbrgxGfQAAMZ7JtM1e/iERcRLXbJm/lvT?=
 =?us-ascii?Q?ggkk3J1Vt4l/NJjjAMuzwdS1Suy9e+/A9chkNru0tvaxNcG0yUOuxqQOCHiX?=
 =?us-ascii?Q?EGpfqroM3YwuLY5Yv4z38xQmYVtLlf9j8xFsOmXYxT3a03qfSh+tyHQ/u4Bv?=
 =?us-ascii?Q?mU5DWoL8grB6QadUHEgnSpdZJTWCbPyW7rJ/BYpG0GS8d49bNzhK+LQHo2c+?=
 =?us-ascii?Q?nem9dFJbLrEqxPACkbWd7KYfzxvj0r97PFcmyY2+mCApXqv73hzirroQOa7C?=
 =?us-ascii?Q?Gd4clfJkmb1P8gyp6/hHGlt3AIiSIq+6D+IuUzW4qUBoTRfGUb9jK79foRD7?=
 =?us-ascii?Q?TU54U9FM3E4nVTTBVqzpOF7/Kf3vMr1iCMTvpdSSragbeVk3X9jRXq6tJsbV?=
 =?us-ascii?Q?poxUxKhG1oogSEh2Cn6pTI5nhE80oh4KQ1yvPdQpFbfXtBO6wCZ/0yEEmmLN?=
 =?us-ascii?Q?NiHdechF0TKE3lRkmCZ7jnc7km9bHz+97Zj+F2dyHTkLaCHe9oRK8j1zoYQ6?=
 =?us-ascii?Q?rkAjB2j5UiIjNLwa94Jgb7vTDUi28acibGV5Z2S5gxj5sxmAKf4uxX8qUrPc?=
 =?us-ascii?Q?TbauhLu1dzWpESQ9jKoaH8NWikgfTDzDLOGe2CIli09U53AOKzfT3Ur5w9kq?=
 =?us-ascii?Q?vKV0vRl6sawcR/OV3HRfENdBMAvGZCvOnaXahrGN3EmjaeZ8JLXAT9Bux0AY?=
 =?us-ascii?Q?i/yhAqBfAH1ZmsJL+Dpl8RTuL7lGHDqfMiJGnn3VN41eKBX11o1XXmol7vpH?=
 =?us-ascii?Q?ZiUKGLzeEgH3iQXH3i1v5tUQKLDF5FPO8VUaQ9UJAXuLzy/vYOXfcZSHKk7f?=
 =?us-ascii?Q?vPGpWG6dCm99aG1roiwdIvbD1HWhs9YbhUo2YoV6KPDM20wci6/XRawLD9k2?=
 =?us-ascii?Q?6/Rvfy+INvKMe7sJ4bjOnnFQbVkc4HErvZxSyCxbzta3rI/PBYjImQZd49h6?=
 =?us-ascii?Q?L5aB1cmqp2udAmqRi5dACZoJMR4av0po93a8zardECvdj3JDWaghO7Td+bX2?=
 =?us-ascii?Q?zKW924Ur5W/sn0nOmYiRwH+1oeLuEtaId48pXwD3HZ+XZcNaQM/xpMjQ1K+4?=
 =?us-ascii?Q?NKr1xh+4seHXf2ipg2FC/TvBT3ShS7l15foJ9ux2jlU9/1zs+G220lDIV56W?=
 =?us-ascii?Q?rNNwgXz6sG+wTfntGiwX3XOx41rUyc3N8vKcPznmkrlL/YHhc+f+7tKTzhbk?=
 =?us-ascii?Q?iDbqemBAPVKDDxjs38XjDMtcB3O6JMxYEox1mTZ27jK2fcN4B/oWfoi/54Zz?=
 =?us-ascii?Q?d353bkQIvZX6UezDR3H9VOV1mlQSKduRqqkOlzRjrhXT5lNSTOCEuEZWllE6?=
 =?us-ascii?Q?1ipMLOxJKakiNNoBQ8lCX74SZ0i4u7VEayf+LXGXQ//qUoefj09ToVK9VFi7?=
 =?us-ascii?Q?ojcYh6ubgQdcyTsjVdsV4hSQq7KovITKFXJ4DxT4kAOyCQl2ENUdmU12E3Hv?=
 =?us-ascii?Q?twPEnwX32Wr0EW1s0KjJhyUD5MqMa5jpnPturzo3sIm9vtXNTP3kvHm53yhh?=
 =?us-ascii?Q?Q4akO+0lAFgBumdINmiu2ywH7DqLPioKP4hJzdP6HF3qnh+cTJNouxIzKGoD?=
 =?us-ascii?Q?WJYRf0Vs2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02a8c5d-4b7b-41e7-bf8c-08def450b1aa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 06:54:16.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/RV/ig+NmJv4PKBIT89BXCAekNx5go6lYlimF22hwJZcs1fRD653V8Dntzt9UTKE6mMnCSIMlIDuPtXUJYKNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7120

On Tue, Jul 28, 2026 at 07:41:30AM +0800, Davidlohr Bueso wrote:
> Implement cxl_bi_setup() to enable BI flows on the device and every
> component in the path, and its teardown counterpart cxl_bi_dealloc().
> Both run from cxl_endpoint_port_probe(): the BI-ID and path
> enablement belong to the endpoint port's lifetime.
> 
> Setup is safe in endpoint port probe context: the port probes
> synchronously from cxl_mem_probe(), pinning the memdev state the
> walk consumes, and the whole ancestor path already exists with BI
> registers mapped (dports at dport-add time, the switch USP RT at
> first-dport setup) because devm_cxl_enumerate_ports() completes
> before the endpoint is created.
> 
> Dealloc is safe in endpoint devres context: both setup and dealloc
> walk the endpoint's parent_dport topology rather than getting the
> port by bus lookup - an ancestor teardown delists the parent port
> before the endpoint's devres runs.
> 
> The topology walk is stable as parent_dport pointers are fixed at
> port creation; ancestors cannot be reaped while holding this
> memdev's cxl_ep; and their own teardown frees dports only after
> the endpoint is gone.
> 
> The device state holds up as well: cxlmd->cxlds is nulled only
> after cxl_memdev_unregister() has torn the endpoint down, and
> delete_endpoint() clears cxlmd->endpoint only after the endpoint
> devres has run.
> 
> With dealloc in the endpoint's devres, delete_endpoint() already
> holds the parent port's device lock, so to avoid deadlocking, add a
> per-port bi_lock, serializing only dports that share state (ie:
> sibling nr_bi on a root port, the switch USP's BI RT).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c  | 379 ++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |   1 +
>  drivers/cxl/cxl.h       |  30 ++++
>  drivers/cxl/port.c      |   4 +
>  include/cxl/cxl.h       |   2 +
>  5 files changed, 416 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f82559d8a8c5..a87c2ad9ac53 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -2,11 +2,13 @@
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/units.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/iopoll.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <linux/string_choices.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -964,3 +966,380 @@ void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
>  		break;
>  	}
>  }
> +/*
> + * BI requires 256B Flit operation on the link. RP/DSP/endpoint must
> + * also have the BI Decoder cap mapped (@bi); for USPs the BI RT cap
> + * is optional per CXL 4.0 8.2.4.26, so absent @bi is allowed.
> + */
> +static bool cxl_is_bi_capable(struct pci_dev *pdev, void __iomem *bi)
> +{
> +	if (!cxl_pci_flit_256(pdev))
> +		return false;
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM && !bi) {
> +		dev_dbg(&pdev->dev, "No BI Decoder registers.\n");
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/* limit any insane timeouts from hw */
> +#define CXL_BI_COMMIT_MAXTMO_US (5 * USEC_PER_SEC)
> +
> +static unsigned long __cxl_bi_get_timeout_us(struct device *dev,
> +					     unsigned int scale,
> +					     unsigned int base)
> +{
> +	static const unsigned long scale_tbl[] = {
> +		1, 10, 100, 1000, 10000, 100000, 1000000, 10000000,
> +	};
> +
> +	if (scale >= ARRAY_SIZE(scale_tbl) || !base) {
> +		dev_dbg(dev, "Invalid BI commit timeout: scale=%u base=%u\n",
> +			scale, base);
> +		return CXL_BI_COMMIT_MAXTMO_US;
> +	}
> +
> +	return scale_tbl[scale] * base;
> +}
> +
> +static int __cxl_bi_wait_commit(struct device *dev, void __iomem *status_reg,
> +				u32 committed_bit, u32 err_bit,
> +				unsigned int scale, unsigned int base)
> +{
> +	unsigned long tmo_us, poll_us;
> +	ktime_t start;
> +	u32 status;
> +	int rc;
> +
> +	tmo_us = min_t(unsigned long, CXL_BI_COMMIT_MAXTMO_US,
> +		       __cxl_bi_get_timeout_us(dev, scale, base));
> +	poll_us = max_t(unsigned long, tmo_us / 10, 1); /* ~10% */
> +	start = ktime_get();
> +
> +	rc = readx_poll_timeout(readl, status_reg, status,
> +				status & (committed_bit | err_bit),
> +				poll_us, tmo_us);
> +	if (rc) {
> +		dev_err(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
> +		return rc; /* -ETIMEDOUT */
> +	}
> +
> +	if (status & err_bit) {
> +		dev_err(dev, "BI-ID commit rejected by hardware\n");
> +		return -EIO;
> +	}
> +
> +	dev_dbg(dev, "BI-ID commit wait took %lluus\n",
> +		ktime_to_us(ktime_sub(ktime_get(), start)));
> +	return 0;
> +}
> +
> +/* BI RT only exists on switch upstream ports. */
> +static int __cxl_bi_commit_rt(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_RT_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_RT_CTRL_BI_COMMIT, bi + CXL_BI_RT_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_RT_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_RT_STATUS_OFFSET,
> +				    CXL_BI_RT_STATUS_BI_COMMITTED,
> +				    CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}
> +
> +static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
> +{
> +	u32 status, ctrl;
> +	unsigned int scale, base;
> +
> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +		       readl(bi + CXL_BI_DECODER_CAPS_OFFSET)))
> +		return 0;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl & ~CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	writel(ctrl | CXL_BI_DECODER_CTRL_BI_COMMIT,
> +	       bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	status = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
> +	scale = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE, status);
> +	base = FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE, status);
> +
> +	return __cxl_bi_wait_commit(dev, bi + CXL_BI_DECODER_STATUS_OFFSET,
> +				    CXL_BI_DECODER_STATUS_BI_COMMITTED,
> +				    CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED,
> +				    scale, base);
> +}
> +
> +/* Enable or dealloc BI-ID changes in the given level of the topology. */
> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
> +	void __iomem *bi = dport->regs.bi_decoder;
> +	struct cxl_port *port = dport->port;
> +	u32 ctrl, value;
> +	int rc;
> +
> +	guard(mutex)(&port->bi_lock);
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		if (enable) {
> +			/*
> +			 * There is no point of failure from here on,
> +			 * BI will be enabled on the endpoint device.
> +			 */
> +			dport->nr_bi++;
> +
> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +
> +			value = ctrl | CXL_BI_DECODER_CTRL_BI_FW;
> +			value &= ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (WARN_ON_ONCE(dport->nr_bi == 0))
> +				return -EINVAL;
> +			if (--dport->nr_bi > 0)
> +				return 0;
> +
> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +		return 0;
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (enable) {
> +			value = ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
> +			value |= CXL_BI_DECODER_CTRL_BI_ENABLE;
> +		} else {
> +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
> +				return 0;
> +			value = ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
> +		}
> +
> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +		rc = __cxl_bi_commit_decoder(dport->dport_dev, bi);
> +		if (rc)
> +			return rc;
> +
> +		if (port->regs.bi_rt)
> +			return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport)
> +{
> +	return __cxl_bi_ctrl_dport(dport, true);
> +}
> +
> +static int cxl_bi_ctrl_dport_disable(struct cxl_dport *dport)
> +{
> +	return __cxl_bi_ctrl_dport(dport, false);
> +}
> +
> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	void __iomem *bi = endpoint->regs.bi_decoder;
> +	u32 ctrl, val;
> +
> +	if (!bi)
> +		return -EINVAL;
> +
> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
> +
> +	if (enable) {
> +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already enabled in hardware\n");
> +			return -EBUSY;
> +		}
> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	} else {
> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
> +			if (!cxlds->bi)
> +				return 0;
> +			dev_err(cxlds->dev,
> +				"BI already disabled in hardware\n");
> +			return -EBUSY;
> +		}
> +		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
> +	}
> +
> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
> +	cxlds->bi = enable;
> +
> +	dev_dbg(cxlds->dev, "BI requests %s\n",
> +		str_enabled_disabled(enable));
> +
> +	return 0;
> +}

After a PCI reset or CXL reset, shouldn't "cxlds->bi" be invalidated and restored ?

As far as I know SBR can reset endpoint BI decoder's BI Enable bit to 0, but here we leave
its software value stale.

Should we covery this value in the reset path or rerun BI path setup ?

Best regards,
Richard Cheng.

> +
> +static int cxl_bi_ctrl_endpoint_enable(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_bi_ctrl_endpoint(cxlds, true);
> +}
> +
> +static int cxl_bi_ctrl_endpoint_disable(struct cxl_dev_state *cxlds)
> +{
> +	return __cxl_bi_ctrl_endpoint(cxlds, false);
> +}
> +
> +/*
> + * devm teardown on endpoint port destruction. Endpoint decoders may
> + * still be committed here (cxl_workqueue tears them down
> + * asynchronously), but memory access has been quiesced.
> + */
> +static void cxl_bi_dealloc(void *data)

Hi Davidlohr,

Few questions in my mind.

This function disables BI, but does it detach the active region or its HDM decoder ?
I think no ?

devres register the cleanup functions after the decoder autoremove actions, devres will
run  cxl_bi_dealloc() first and then cxld_unreigster().

To me it seems that this leave an active HDM-DB region with BI disabled, though temporarily.
I think the users of the region should be stopped first before cxl_bi_dealloc() runs ?
Should BI cleanup run after the decoder and region have been detached ?

> +{
> +	struct cxl_port *endpoint = data;
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +
> +	if (!cxlds->bi)
> +		return;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		cxl_bi_ctrl_endpoint_disable(cxlds);
> +
> +	/*
> +	 * Walk the same parent_dport chain that enabled the path. A bus
> +	 * lookup cannot stand in for it: an ancestor-driven teardown
> +	 * delists the parent port before this devres action runs.
> +	 */
> +	dport_iter = endpoint->parent_dport;
> +	port_iter = dport_iter->port;
> +	while (!is_cxl_root(port_iter)) {
> +		int rc = cxl_bi_ctrl_dport_disable(dport_iter);
> +
> +		/* best effort */
> +		if (rc)
> +			dev_dbg(&port_iter->dev,
> +				"BI dport disable failed: %d\n", rc);
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +}
> +
> +/*
> + * Enable BI on every dport in the path, then on the device itself.
> + * On failure, unwind only the dports that fully enabled.
> + */
> +static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
> +			      struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	struct cxl_dport *dport_iter, *failed;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	port_iter = port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter);
> +		if (rc)
> +			goto err_rollback;
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	/* finally, enable BI on the device */
> +	rc = cxl_bi_ctrl_endpoint_enable(cxlds);
> +	if (rc)
> +		goto err_rollback;
> +
> +	return 0;
> +
> +err_rollback:
> +	failed = dport_iter;
> +	dport_iter = dport;
> +	port_iter = port;
> +	while (!is_cxl_root(port_iter) && dport_iter != failed) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +	return rc;
> +}
> +
> +int cxl_bi_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_dport *dport = endpoint->parent_dport;
> +	struct cxl_dport *dport_iter;
> +	struct cxl_port *port_iter;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return 0;
> +
> +	/* BI is VH-only */
> +	if (cxlds->rcd)
> +		return 0;
> +
> +	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
> +			       endpoint->regs.bi_decoder))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port_iter = dport->port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
> +				       dport_iter->regs.bi_decoder)) {
> +			dev_dbg(cxlds->dev, "BI not supported by topology\n");
> +			return 0;
> +		}
> +
> +		/* check usp */
> +		if (dev_is_pci(port_iter->uport_dev) &&
> +		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
> +			    PCI_EXP_TYPE_UPSTREAM &&
> +		    !cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
> +				       port_iter->regs.bi_rt)) {
> +			dev_dbg(cxlds->dev, "BI not supported by USP\n");
> +			return 0;
> +		}
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +
> +	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(&endpoint->dev, cxl_bi_dealloc,
> +					endpoint);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b2f8fb9547d3..7817109026b1 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -741,6 +741,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  	xa_init(&port->dports);
>  	xa_init(&port->endpoints);
>  	xa_init(&port->regions);
> +	mutex_init(&port->bi_lock);
>  	port->component_reg_phys = CXL_RESOURCE_NONE;
>  
>  	device_initialize(dev);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f9fcb6387fc8..d00b8b7b778a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -180,6 +180,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_TRACE_SIZE SZ_512
>  #define CXL_HEADERLOG_TRACE_SIZE_U32 (CXL_HEADERLOG_TRACE_SIZE / sizeof(u32))
>  
> +/* CXL 4.0 8.2.4.26 CXL BI Route Table Capability Structure */
> +#define CXL_BI_RT_CAPS_OFFSET 0x0
> +#define   CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ BIT(0)
> +#define CXL_BI_RT_CTRL_OFFSET 0x4
> +#define   CXL_BI_RT_CTRL_BI_COMMIT BIT(0)
> +#define CXL_BI_RT_STATUS_OFFSET 0x8
> +#define   CXL_BI_RT_STATUS_BI_COMMITTED BIT(0)
> +#define   CXL_BI_RT_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
> +#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
> +#define   CXL_BI_RT_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
> +
> +/* CXL 4.0 8.2.4.27 CXL BI Decoder Capability Structure */
> +#define CXL_BI_DECODER_CAPS_OFFSET 0x0
> +#define   CXL_BI_DECODER_CAPS_HDMD_CAP BIT(0)
> +#define   CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ BIT(1)
> +#define CXL_BI_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_BI_DECODER_CTRL_BI_FW BIT(0)
> +#define   CXL_BI_DECODER_CTRL_BI_ENABLE BIT(1)
> +#define   CXL_BI_DECODER_CTRL_BI_COMMIT BIT(2)
> +#define CXL_BI_DECODER_STATUS_OFFSET 0x8
> +#define   CXL_BI_DECODER_STATUS_BI_COMMITTED BIT(0)
> +#define   CXL_BI_DECODER_STATUS_BI_ERR_NOT_COMMITTED BIT(1)
> +#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_SCALE GENMASK(11, 8)
> +#define   CXL_BI_DECODER_STATUS_BI_COMMIT_TM_BASE GENMASK(15, 12)
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -562,6 +587,7 @@ struct cxl_dax_region {
>   * @decoder_ida: allocator for decoder ids
>   * @reg_map: component and ras register mapping parameters
>   * @regs: mapped component registers
> + * @bi_lock: serializes BI Decoder/RT state of this port's dports
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>   * @commit_end: cursor to track highest committed decoder for commit ordering
> @@ -584,6 +610,7 @@ struct cxl_port {
>  	struct ida decoder_ida;
>  	struct cxl_register_map reg_map;
>  	struct cxl_component_regs regs;
> +	struct mutex bi_lock;
>  	int nr_dports;
>  	int hdm_end;
>  	int commit_end;
> @@ -647,6 +674,7 @@ struct cxl_rcrb_info {
>   * @coord: access coordinates (bandwidth and latency performance attributes)
>   * @link_latency: calculated PCIe downstream latency
>   * @gpf_dvsec: Cached GPF port DVSEC
> + * @nr_bi: number of BI-enabled endpoints below this dport
>   */
>  struct cxl_dport {
>  	struct device *dport_dev;
> @@ -659,6 +687,7 @@ struct cxl_dport {
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	long link_latency;
>  	int gpf_dvsec;
> +	int nr_bi;
>  };
>  
>  /**
> @@ -923,6 +952,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_port *endpoint);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a527dd13fb68..22bd4254ba8d 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -180,6 +180,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_bi_setup(port);
> +	if (rc)
> +		dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
> +
>  	/*
>  	 * With VH (CXL Virtual Host) topology the cxl_port::add_dport() method
>  	 * handles RAS setup for downstream ports. With RCH (CXL Restricted CXL
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2816954680b3..e507cb0f777f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -168,6 +168,7 @@ struct cxl_dpa_partition {
>   * @regs: Parsed register blocks
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @bi: device is BI (Back-Invalidate) enabled
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
>   * @part: DPA partition array
> @@ -187,6 +188,7 @@ struct cxl_dev_state {
>  	struct cxl_device_regs regs;
>  	int cxl_dvsec;
>  	bool rcd;
> +	bool bi;
>  	bool media_ready;
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> -- 
> 2.39.5
> 
