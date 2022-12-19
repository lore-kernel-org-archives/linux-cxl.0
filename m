Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFEFC4167B
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 16:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLSQBK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiLSQAl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 11:00:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D78013D7F
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 07:59:23 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbPRt74W2z686w8;
        Mon, 19 Dec 2022 23:55:22 +0800 (CST)
Received: from localhost (10.81.210.222) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 15:59:20 +0000
Date:   Mon, 19 Dec 2022 15:59:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rrichter@amd.com>,
        <terry.bowman@amd.com>
Subject: Re: [RFC PATCH 1/8] cxl: break out range register decoding from
 cxl_hdm_decode_init()
Message-ID: <20221219155918.000008db@Huawei.com>
In-Reply-To: <166984994091.2805382.15976080608757662866.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
        <166984994091.2805382.15976080608757662866.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.222]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Nov 2022 16:12:20 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> There are 2 scenarios that requires additional handling. 1. A device that
> has active ranges in DVSEC range registers (RR) but no HDM decoder register
> block. 2. A device that has both RR active and HDM, but the HDM decoders are
> not programmed. The goal is to create emulated decoder software structs
> based on the RR.
> 
> Move the CXL DVSEC range register decoding code block from
> cxl_hdm_decode_init() to its own function. Refactor code in preparation for
> the HDM decoder emulation.  There is no functionality change to the code.
> Name the new function to cxl_dvsec_rr_decode().
> 
> The only change is to set range->start to CXL_RESOURCE_NONE if the range is
> not programmed correctly or active.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

I think this refactor, whilst fairly minimal reveals some places
where with a slightly more invasive set of changes we can improve the resulting
code.

Jonathan

> ---


> -int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> +
> +static int cxl_dvsec_rr_decode(struct pci_dev *pdev, int d,
> +			       struct cxl_endpoint_dvsec_info *info)
>  {
...

>  	for (i = 0; i < hdm_count; i++) {
>  		u64 base, size;
> @@ -426,22 +417,44 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>  
>  		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
>  
> -		info.dvsec_range[i] = (struct range) {
> +		info->dvsec_range[i] = (struct range) {
>  			.start = base,
>  			.end = base + size - 1
>  		};
>  
>  		if (size)
>  			ranges++;
> +		else
> +			info->dvsec_range[i].start = CXL_RESOURCE_NONE;

The following might become irrelevant after later patches in series...

Seems a little odd to do it this way for the !size case and set it
directly above for the case where size is non zero.  Also, is there any
purpose to setting end?
Perhaps just sent whole thing down here and set end to the magic flag?

		if (size) {
			info->dvsec_range[i] = (struct range) {
				.start = base,
				.end = base + size - 1,
			};
			ranges++;
		} else {
			info->dvsec_range[i] = (struct range) {
				.start = CXL_RESOURCE_NONE,
				.end = CXL_RESOURCE_NONE,
			};
		}

or for a more major refactor short cut the !size case and don't bother
reading the pci registers values that are going to be thrown away
anyway.

		if (!size) {
			info->dvsec_range[i] = (struct range) {
				.start = CXL_RESOURCE_NONE,
				.end = CXL_RESOURCE_NONE,
			};
			continue;
		}

		rc = pci_read_config_dword(
			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
		if (rc)
			return rc;

		...

		info->dvsec_range[i] = (struct range) {
			.start = base,
			.end = base + size - 1,
		};
		ranges++;
	}

>  	}
>  
> -	info.ranges = ranges;
> +	info->ranges = ranges;

Trivial but I would like a blank line here.

> +	return 0;
> +}
> +
> +/**
> + * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
> + * @cxlds: Device state
> + * @cxlhdm: Mapped HDM decoder Capability
> + *
> + * Try to enable the endpoint's HDM Decoder Capability
> + */
> +int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct cxl_endpoint_dvsec_info info = { 0 };
> +	int rc;

Trivial but probably want to reorder these to maintain the reverse xmas tree.

> +	struct device *dev = &pdev->dev;
> +	int d = cxlds->cxl_dvsec;
> +
> +	rc = cxl_dvsec_rr_decode(pdev, d, &info);
> +	if (rc < 0)
> +		return rc;
>  
>  	/*
>  	 * If DVSEC ranges are being used instead of HDM decoder registers there
>  	 * is no use in trying to manage those.
>  	 */
> -hdm_init:
>  	if (!__cxl_hdm_decode_init(cxlds, cxlhdm, &info)) {
>  		dev_err(dev,
>  			"Legacy range registers configuration prevents HDM operation.\n");
> 
> 

