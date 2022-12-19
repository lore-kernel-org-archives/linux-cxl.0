Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C35C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 16:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiLSQmo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiLSQmh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 11:42:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC4E080
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 08:42:36 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbQQd1CZhz6J67D;
        Tue, 20 Dec 2022 00:39:21 +0800 (CST)
Received: from localhost (10.81.210.222) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 16:42:33 +0000
Date:   Mon, 19 Dec 2022 16:42:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rrichter@amd.com>,
        <terry.bowman@amd.com>
Subject: Re: [RFC PATCH 4/8] cxl: emulate HDM decoder from DVSEC range
 registers
Message-ID: <20221219164231.000002c0@Huawei.com>
In-Reply-To: <166984995817.2805382.13166060288973761642.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
        <166984995817.2805382.13166060288973761642.stgit@djiang5-desk3.ch.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.222]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 30 Nov 2022 16:12:38 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In the case where HDM decoder register block exists but is not programmed
> and at the same time the DVSEC range register range is active, populate the
> CXL decoder object 'cxl_decoder' with info from DVSEC range registers.

I may be overthinking this...

So I think this results in us enabling hdm decoder registers on
a device that the BIOS already set the range registers for?

I'm not sure the spec guarantees that is a safe operation if accesses are
in flight.
You can imagine a device which goes through an unsafe intermediate state
when switching over from range registers to HDM decoders.  That wouldn't
normally be a problem as we'd not expect traffic in flight, but if the
BIOS already set up a mapping the OS might see that as normal memory which
it is using when this transition occurs.

If just feels like a transition no one will test that might bite us in
future in really hard to detect ways.

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c |   33 ++++++++++++++++++++++++++++++---
>  drivers/cxl/core/pci.c |   12 ------------
>  drivers/cxl/cxl.h      |    3 ++-
>  drivers/cxl/port.c     |    2 +-
>  4 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..9773a5efaefd 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -674,9 +674,31 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>  	return 0;
>  }
>  
> +static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
> +					    struct cxl_decoder *cxld, int which,
> +					    struct cxl_endpoint_dvsec_info *info)
> +{
> +	if (!is_cxl_endpoint(port))
> +		return -EOPNOTSUPP;
> +
> +	if (info->dvsec_range[which].start == CXL_RESOURCE_NONE)
> +		return -ENXIO;
> +
> +	cxld->target_type = CXL_DECODER_ACCELERATOR;

Why chose type 2 target type?  Definitely needs a comment.
Also would be good to have a precursor patch that moves these
over to the CXL 3.0 naming to incorportate the fun difference
between HDM-DB and HDM-H type 3 devices

CXL_DEVICE_COHERENT_ADDRESS_RANGE
CXL_HOST_ONLY_COHERENT_ADDRESS_RANGE



> +
> +	cxld->hpa_range = (struct range) {
> +		.start = info->dvsec_range[which].start,
> +		.end = info->dvsec_range[which].end,
> +	};
> +
> +	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
> +	port->commit_end = cxld->id;

blank line before all simple returns like this makes the code
slightly more readable.

> +	return 0;
> +}
> +

...

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 385dbe9bd5f2..5e44fe23fa76 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -412,18 +412,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>  		info->mem_enabled = 0;
>  	}
>  
> -	/*
> -	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
> -	 * [High,Low] when HDM operation is enabled the range register values
> -	 * are ignored by the device, but the spec also recommends matching the
> -	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
> -	 * are expected even though Linux does not require or maintain that
> -	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> -	 * Decoder Capability Enable.
> -	 */
> -	if (info->mem_enabled)
> -		return -EBUSY;
> -
Dropping this condition is the bit I'm referring to at the top.  I think
if (info->mem_enabled)
	return 0;

would avoid that transition.

>  	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
>  	if (rc)
>  		return rc;
