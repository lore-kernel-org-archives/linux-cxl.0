Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21CCC77B73
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 11:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjFFL12 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 07:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbjFFL11 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 07:27:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92094B1
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 04:27:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb7VN0G09z6J7FH;
        Tue,  6 Jun 2023 19:27:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 12:27:24 +0100
Date:   Tue, 6 Jun 2023 12:27:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 06/19] cxl/hdm: Default CXL_DEVTYPE_DEVMEM decoders to
 CXL_DECODER_DEVMEM
Message-ID: <20230606122723.0000093d@Huawei.com>
In-Reply-To: <168592153054.1948938.12344684637653088842.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592153054.1948938.12344684637653088842.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:32:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for device-memory region creation, arrange for decoders
> of CXL_DEVTYPE_DEVMEM memdevs to default to CXL_DECODER_DEVMEM for their
> target type.

Why?  CXL_DEVTYPE_DEVMEM might just be a non CLASS code compliant HDM-H
only device.  I'd want those drivers to always set this explicitly.


> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index de8a3fb28331..ca3b99c6eacf 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -856,12 +856,22 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		}
>  		port->commit_end = cxld->id;
>  	} else {
> -		/* unless / until type-2 drivers arrive, assume type-3 */
>  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
>  			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
>  			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));

This is setting it to be HOSTMEM if it was previously DEVMEM and that
makes it inconsistent with the state cached below.

Not sure why it was conditional in the first place - writing to existing value
should have been safe and would be less code...

>  		}
> -		cxld->target_type = CXL_DECODER_HOSTMEM;
> +		if (cxled) {
> +			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +			struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> +				cxld->target_type = CXL_DECODER_HOSTMEM;
> +			else
> +				cxld->target_type = CXL_DECODER_DEVMEM;
> +		} else {
> +			/* To be overridden by region type at commit time */
> +			cxld->target_type = CXL_DECODER_HOSTMEM;
> +		}
>  	}
>  	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
>  			  &cxld->interleave_ways);
> 

