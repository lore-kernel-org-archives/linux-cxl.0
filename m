Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509C8C636D6
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 13:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBVNW2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 08:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBVNW1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 08:22:27 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750713A84B
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 05:22:25 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PMGsr5hlkz6J7Xn;
        Wed, 22 Feb 2023 21:17:36 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 22 Feb
 2023 13:22:22 +0000
Date:   Wed, 22 Feb 2023 13:22:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 2/2] cxl/hdm: Skip emulation when driver manages
 mem_enable
Message-ID: <20230222132221.00002b42@huawei.com>
In-Reply-To: <167703068474.185722.664126485486344246.stgit@dwillia2-xfh.jf.intel.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
        <167703068474.185722.664126485486344246.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 21 Feb 2023 17:51:24 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> If the driver is allowed to enable memory operation itself then it can
> also turn on HDM decoder support at will.
> 
> With this the second call to cxl_setup_hdm_decoder_from_dvsec(), when
> an HDM decoder is not committed, is not needed.
> 
> Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> Link: http://lore.kernel.org/r/20230220113657.000042e1@huawei.com
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

For both
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I could have sworn that mem_enabled was set when I was debugging this before
(hence the odd dance in my proposal)

Meh, doesn't seem to be now so I clearly did something wrong!

Trivial comment below.

I still need to add more tests cases, but this solves the one that
caused the original report.

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d853a0238ad7..dd4b7a729419 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -695,13 +695,15 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>  
>  /**
>   * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> - * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
> + * @mem_enabled: cached value of mem_enabled in the DVSEC at init time

I guess could rename this to make the meaning more obvious, but would make for
a messier fix.

>   * @ranges: Number of active HDM ranges this device uses.
> + * @port: endpoint port associated with this info instance
>   * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
>   */
>  struct cxl_endpoint_dvsec_info {
>  	bool mem_enabled;
>  	int ranges;
> +	struct cxl_port *port;
>  	struct range dvsec_range[2];
>  };
>  
