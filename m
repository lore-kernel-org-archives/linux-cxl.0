Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B53B0AF5
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780626208; cv=fail; b=ZM0bFjWm5OrMsOpMVbgU5/9ZAoi08vyvKO5mB0OzDXiLbDXO5E8Cdc4iJQcuzMsDYgydMWv8/7L8FrW+UK+QWawFjhVYpzG3btIGOujivgMtknqIx3rCUSZ7LolipFZr/Tp/VwfLv9BLCXe4qXEsKiy6eMZwAbkzD5JegZDeetY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780626208; c=relaxed/simple;
	bh=ZujSKR/QHLbM3Gm063StoTmv/v+NOnjsLoXhwErtRSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rYRrFRRlk5aUwp6ZrpyA6N5N7DctU1fHbWGq2biADm3Sjxe3rsYEXDWdLbOAdmdhmzUZOUdu4ElXc/6EzmVOmUyD8QrjDgDf7skMF29sDdEQ0PrNpyfEGgnbLr+KCHqtSbcr23H4lgmEDs6I4PgzZlQ8Qt0MIzj8G2S1X3IiPgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KsGmafAG; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KsGmafAG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbanySe3rlb+4trMowUaEc2w4Cso/GB5EYsvgINJsMX3CcJ7uifpvqvujOkk1ct7fjjAy3WOPCLw/FZjuXzFSyJGANxOCNmWZEL3c5ToupM/+zYid5G+Yt+7HHA1zfoPN6SIQgD9otRNgw06zwxgJ8cTeN/3E+FrDkIq5tkbuSUZgZpou0J0Ykdn9vcpd8aoo1GwDNwROZBELdqBsXxTQRxynt4w+tuddzs+lRmaeNmju1rlJ4XvuQ+rx54oJR1xYEv0FV8EDN286hoOSa3UybbgMOdmG7dvs9Bt2tIfBuVlznFDVkbODWUJQEMjMPewj4q2Xz1YVId3F424lRkd+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4/n2F5pOEAkRdgo96dW80jxaP0+aZoW9Y6E7Qird4E=;
 b=SXxQ4OQF9uXdCQ+UR95iXg6DgeX+GTL1YGHjODoZvrmeH3Tvy4DMv59fz/vK8c9pGtAYb25IwjeO2p+lFqxmP7KHVmwWYy15pr30YcxtZeLjmCtZzR29dKVzBtKivJqpPGqs5vwtyXAAI+l/6ZuBDlp2wWyHw8UChoOWJ/UScjpysmc9IPExpe3d/WbUT8g+bKG493AjNHh0vEGUuwiv6eVb3dP8ebUfVQ25cKI2xO3TJSGyjTjlB7SXVW8H9ZQZLfQSFV3DYlKtRx+5E3jrVRqQWXamZ/WeBLU5BL/rC9QL3e1fIl9XeXq0jD6wvRsy8wcSFCxpUg0OoQ1RRjMOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4/n2F5pOEAkRdgo96dW80jxaP0+aZoW9Y6E7Qird4E=;
 b=KsGmafAGQnNEmO8aNFmnyWDMHTfMzbDwyiWeBHA6we7S41Oax/fuS9+NXkbi39dK/i7Zr4ld8j3QIJUf54NXlLylMWZFweIggrL0PJQqV6D/dK/Xk04oQLvdOeDieG1UXFO+E039K1dtPZuqJBQQ9MHUW+nFLVtPc7ZlE7Clue2S8qrpw7VRtnuwjqCAQB/gvT7hLZ+LM/IrrVMZx+Gad7t0/xOm/hm82p480IyIdQfHy0KqhWoo6ZuIR1Ta8mYHtDoj1BW0mPAhdAymwmEg0YLED8sSb4SaJniRNdLQlZYwez/dPPcEcyc/BxuNRzps70IjSGiYQQ8F3HezcLUU/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 02:23:10 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:23:10 +0000
Date: Fri, 5 Jun 2026 10:23:03 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org, 
	benjamin.cheatham@amd.com, alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net, 
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/pci: Add BI topology enable/disable
Message-ID: <aiIycaatJLZ9_Lz6@MWDK4CY14F>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-3-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605003329.2584012-3-dave@stgolabs.net>
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: efc8ca48-58d8-4afa-f0de-08dec2a96303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|6133799003|22082099003|18002099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	O19Ix3xnUC5V+m6btX9/pPucqqDLHSbTALgvCiAimQ6ueggQV9PK/Zfb59h2QLb9XCSSafVaDKbHIbDX77LinVPJr5wtSqei4UKjX3pngCul7tAEKMxz+ZnvFT+fE86mwxavmKOPbKbUlw/BaZlOhyVM9vMyG9Q5UwrwyPo1gEEFNaFDA40P5Pt8oJjoWAR3oExt67DlGQIPianxo3/wxCuRhFRx2YFQhzYbuqF69jvGNvMiKh0gEx1aAt4xnYBOYxq8J2BFf1mqaTyg1mwMZvBAQ9qwbwAyWvrK4NvZsGvw4gf0rXTkW1lbIkE3/lKXnGQvnN75Akw6+Vm/RWp5w28m254m/blGSgLOBolXAFga7/ybiCtmMsNKzdd5Z6aOq2YOuDzPNSjjGXhwAr/gtmhL/ybSEBaLroEcSMvPdqNqVSgRjW+Xww1xAsFkjDiBWS3o7+2+g7ZBSlbjPY2YEH4RZ/SccLRa8nAGonwvCENF7rzS5F5S8iYyHUXXSbaGRWxV3DVkbi78j66PJ8hik00+O7C64e8IqRGMs4aqe3aSRIKcYRgCg7Wm36dRTN8/UUhZ59JMEsTTdm5g6Jsu1NFCF6dHHRkdGDol2hT9WepRJlGvXAGdm1000DE9iMCKxUtWRlfn68kPIN/nh02FTpsdTU9HOW4aiOvlS3RM3axHgaC8YrT0OORcbNopwm0S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ce3h3AH1pI+qVg+rTzFBNaUIGaVMquNnRn8jQPc378Roe1ce4CizHZ+Cn48s?=
 =?us-ascii?Q?IPQc9D2BVShAvQyt4JnZjdDBmI27KTF3TB1dUExFtqcvdd8rcYw4gRnyWUUJ?=
 =?us-ascii?Q?vWxIYnMcXgMoWyApqOUAMH6si8XiWDMLNK8jUBi/59tIbBzI+m/RA8c+zfn2?=
 =?us-ascii?Q?te7+xtkwwBCpCEitQ/kF+7aivlVySwP4Lr49ROcG36rrHpEBy6dgskcl2z29?=
 =?us-ascii?Q?I2wMVDEBEK9A/00tmOtgSDGR93Bss1kHA6WFqqby2UIcXNNqw//4oKJ4fVqS?=
 =?us-ascii?Q?GJ1o1svkUW9cxCbSd5b1oKB4DbGUVt2Jtf6rl9SPfbX0mvYP9VoISUgivd2U?=
 =?us-ascii?Q?mMq0cwG/1bpsHVsyLSiu70xPCHXrmhDyQcJ0+5m5dTTQWFW9PzjvFEgY37jc?=
 =?us-ascii?Q?/Bf/Zg9GJsyLIOyxh8l8XcGaQOZEnrAVgS747LynCTqR50g7ZNFYZaqqui3e?=
 =?us-ascii?Q?9wzzRhN+U0rqi86JWm939KBHhqnDHu9FEg5adxSLu252NPd8XSBKg4tFn7ww?=
 =?us-ascii?Q?wuCx01K7lc6dPVq2p9fSRa3hKkaujTE6BixR7PInwyoZDMTx+NqVKj9QzeYS?=
 =?us-ascii?Q?ZRUim2g68kO2sQhVdqv+0WQceRhwMdZ0O1igk5/tsQjisf++0Byoq5/1pNfc?=
 =?us-ascii?Q?SkeYDe6hI3Vl3QbhhFCbvd2oc7MSaSgLrDIbj9P3C2Oy+e7/3BX8padVMlsC?=
 =?us-ascii?Q?/GjRR8ZSSL/zAC7Ms7tQiFFVsE7VbCxlXXy9q1ZuzqjAj4NyDTzfhDN0CNGg?=
 =?us-ascii?Q?UQYorLR2AzsbhFXxpm4pYX+KjISu/03CJSEKyNwNgXnFVQZeYhjpcqFfUlHJ?=
 =?us-ascii?Q?AzXwbY8Wy9PbUwNjOrUUlyvxp7Lt0f7SkVmI7JKGjTV4obB/OwZzH1LGd/sW?=
 =?us-ascii?Q?RBzi8FdcrhbO4E2gk604ZGN1OdHmT8s/bcf3xIbX5wIcU00ArpMPqz4Byk27?=
 =?us-ascii?Q?00V8m24pwZ0BifoOTun94RNCs24FdMRx2Eo/ta51nIwoNZGNACwNpAHZ5eHT?=
 =?us-ascii?Q?IE9PkH1gGlVAOA/ag6In1H49lfBCYTSEu9m5+g+i9AWldzV90mL+BJqdVnAv?=
 =?us-ascii?Q?wX7fQdAuNETE6Q7xVhgytS/iqLusBJAy74gb1NiJdOeerVPAgZHo+EunVUFd?=
 =?us-ascii?Q?AL6jNWPnr6okZam+c2DS7ReikuelR/YclLjld2wup7S7Exj/140dO3giB2bb?=
 =?us-ascii?Q?jNXpI74WFMtaveuGo5ViqzV5HkvWmcu95adwrzFBBTeekhT5r5/3G98Xwez6?=
 =?us-ascii?Q?GEfoP+TXCkAZXgmX4L0ue2TM+ZenJaIz3+m1+EaiMd6Y6H8CgTCCyPi6fjbr?=
 =?us-ascii?Q?As5+466dGBRpdhmqym+UxEEb4jlVJxCuJRgsGmHuTT12r3Jshw03Q8fQFPWA?=
 =?us-ascii?Q?LqAXZta20ODIn7XlC6XrjKjEaBAGse6KIOQB28pIUrYiVkiB0v+SYShPbPiP?=
 =?us-ascii?Q?Lmv822NI0KxWjsPEnV4ZnkNR98z2nzWyEJpd1U438AiXkW6BMkV/fIBMc4sV?=
 =?us-ascii?Q?4o6Q57umqJ4ZKbGWQI574y4W638GTcp14ZLJd2qGAEogLCDoAKtAAPZc4tfL?=
 =?us-ascii?Q?HPs17kTNBzUabYh5pul8bBCSW1RmEOMzrjT+OJ9EAasyy5CDp5POef19LS5T?=
 =?us-ascii?Q?yOTIvrqJzlUovPUeAUz0Ow4o4fsHDe891XhvJJYnv2KFIwiIg6sITuB0MelF?=
 =?us-ascii?Q?eO2L4Gb7WsvPEwQDj+ZDhQVQca8MxyrtlEFfz0TZshZoxUCV1JaApNi4INyD?=
 =?us-ascii?Q?YGu0Vmq2Vw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc8ca48-58d8-4afa-f0de-08dec2a96303
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:23:10.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg7vRVczhj6GGBnBI6YWw7rw1ix0VJ8BCyRtcm/f+5jMPGE8k0CtwCs3YiokYxX0/exL/zeKKMfFIe5+wz0Npw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

On Thu, Jun 04, 2026 at 05:33:26PM +0800, Davidlohr Bueso wrote:
> Implement cxl_bi_setup(), which walks the CXL port topology to enable
> BI flows on the device and every component in the path between the
> device and the root port. The walk is two-pass: first to verify each
> component advertises BI capability, then to write BI Enable on each
> dport's BI Decoder Control register and on the device. On failure
> during the enable pass, partially-enabled dports are rolled back.
> 
> The teardown counterpart, cxl_bi_dealloc(), runs automatically on
> cxl_mem unbind.
> 
> cxl_bi_setup() does not touch HDM decoder configuration -- the BI bit
> in each decoder is programmed separately at commit time. After a
> successful setup the device is BI-capable but not yet using BI for
> decode coherence.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/pci.c | 365 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  28 ++++
>  drivers/cxl/mem.c      |   4 +
>  include/cxl/cxl.h      |   2 +
>  4 files changed, 399 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index d1f487b3d809..291d4f617e71 100644
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
> @@ -926,3 +928,366 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
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
> +	if (scale >= ARRAY_SIZE(scale_tbl)) {
> +		dev_dbg(dev, "Invalid BI commit timeout scale: %u\n", scale);
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
> +		dev_dbg(dev, "BI-ID commit timed out (%luus)\n", tmo_us);
> +		return rc; /* -ETIMEDOUT */
> +	}
> +
> +	if (status & err_bit) {
> +		dev_dbg(dev, "BI-ID commit rejected by hardware\n");
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
> +	if (!bi)
> +		return 0;
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
> +	if (!bi)
> +		return -EINVAL;
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
> +	guard(device)(&port->dev);
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
> +		return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
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
> + * devm teardown on cxl_mem unbind. Endpoint decoders may still be
> + * committed here (cxl_workqueue tears them down asynchronously), but
> + * memory access has been quiesced.
> + */
> +static void cxl_bi_dealloc(void *data)
> +{
> +	struct cxl_dev_state *cxlds = data;
> +	struct cxl_dport *dport_iter, *dport;
> +	struct cxl_port *port_iter;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return;
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(to_pci_dev(cxlds->dev), &dport);
> +	if (!port || !cxlds->bi)
> +		return;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
> +		cxl_bi_ctrl_endpoint_disable(cxlds);
> +
> +	port_iter = port;
> +	dport_iter = dport;
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
> +int cxl_bi_setup(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
> +	struct cxl_dport *dport_iter, *dport, *failed;
> +	struct cxl_port *port_iter;
> +	struct pci_dev *pdev;
> +	int rc;
> +
> +	if (!dev_is_pci(cxlds->dev))
> +		return 0;
> +
> +	pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +
> +	if (!port)
> +		return -EINVAL;
> +
> +	if (!cxl_is_bi_capable(pdev, endpoint->regs.bi_decoder))
> +		return 0;
> +
> +	/* walkup the topology twice, first to check, then to enable */
> +	port_iter = port;
> +	dport_iter = dport;
> +	while (!is_cxl_root(port_iter)) {
> +		/* check rp, dsp */
> +		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
> +				       dport_iter->regs.bi_decoder))
> +			return -EINVAL;
> +
> +		/* check usp */
> +		if (dev_is_pci(port_iter->uport_dev) &&
> +		    pci_pcie_type(to_pci_dev(port_iter->uport_dev)) ==
> +			    PCI_EXP_TYPE_UPSTREAM)
> +			if (!cxl_is_bi_capable(to_pci_dev(port_iter->uport_dev),
> +					       port_iter->regs.bi_rt))
> +				return -EINVAL;
> +
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
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
> +	return devm_add_action_or_reset(&cxlds->cxlmd->dev,
> +					cxl_bi_dealloc, cxlds);
> +
> +err_rollback:
> +	/*
> +	 * Undo all dports enabled so far, including the failed one.
> +	 */
> +	failed = dport_iter;
> +	dport_iter = dport;
> +	port_iter = port;
> +	while (!is_cxl_root(port_iter)) {
> +		cxl_bi_ctrl_dport_disable(dport_iter);
> +		if (dport_iter == failed)
> +			break;
> +		dport_iter = port_iter->parent_dport;
> +		port_iter = dport_iter->port;
> +	}
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_setup, "CXL");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 760f51b43891..89c0c6ce24a3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -167,6 +167,31 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_HEADERLOG_SIZE SZ_512
>  #define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
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
> @@ -630,6 +655,7 @@ struct cxl_rcrb_info {
>   * @coord: access coordinates (bandwidth and latency performance attributes)
>   * @link_latency: calculated PCIe downstream latency
>   * @gpf_dvsec: Cached GPF port DVSEC
> + * @nr_bi: number of BI-enabled endpoints below this dport
>   */
>  struct cxl_dport {
>  	struct device *dport_dev;
> @@ -642,6 +668,7 @@ struct cxl_dport {
>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	long link_latency;
>  	int gpf_dvsec;
> +	int nr_bi;
>  };
>  
>  /**
> @@ -906,6 +933,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +int cxl_bi_setup(struct cxl_dev_state *cxlds);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  					    struct device *dport_dev);
>  
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index fcffe24dcb42..f2d01a218895 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -150,6 +150,10 @@ static int cxl_mem_probe(struct device *dev)
>  	if (rc)
>  		dev_dbg(dev, "CXL memdev EDAC registration failed rc=%d\n", rc);
>  
> +	rc = cxl_bi_setup(cxlds);
> +	if (rc)
> +		dev_dbg(dev, "BI setup failed rc=%d\n", rc);
> +

I don't think dynamic debug here is enough, we probe the device
and the error might not surface, HDM-DB might fails later at region attach
and we lack of traces. Maybe dev_warn() would be better for this kind of
non-recoverable errors.

What do you think ?

Best regards,
Richard Cheng.

>  	/*
>  	 * The kernel may be operating out of CXL memory on this device,
>  	 * there is no spec defined way to determine whether this device
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 8ce9b4e9ca73..4938e93edb63 100644
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
> 
