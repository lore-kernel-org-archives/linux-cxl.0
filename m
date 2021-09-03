Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F3EC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3359161058
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 14:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349350AbhICO0U (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:26:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3734 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbhICO0T (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 10:26:19 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1Klk5FBmz67mXD;
        Fri,  3 Sep 2021 22:23:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 16:25:17 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 15:25:16 +0100
Date:   Fri, 3 Sep 2021 15:25:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 03/13] cxl/core: Ignore interleave when adding decoders
Message-ID: <20210903152517.00005399@Huawei.com>
In-Reply-To: <20210902195017.2516472-4-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-4-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.127]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Sep 2021 12:50:07 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Decoders will be added to the bus either already active (committed in
> spec parlance), or inactive. From the driver perspective, the set of
> devices comprising the former are those which are brought up by system
> firmware; decoders that implement: volatile regions, persistent regions,
> or platform specific (ie. CFMWS) constraints. Such devices have a given
> interleave programming already in place. Inactive decoders on the other
> hand, do not have any interleave programming in place. The set of
> devices comprising that are hostbridges, switches, and endpoint devices.
> 
> Allow adding inactive decoders by removing this check.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Makes sense. I assume there is no easy way to modify this check to
still be applied if the encoder is active?

Otherwise

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
 
> ---
>  drivers/cxl/core/bus.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 9d98dd50d424..8d5061b0794d 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -532,9 +532,6 @@ int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
>  	if (IS_ERR(cxld))
>  		return PTR_ERR(cxld);
>  
> -	if (cxld->interleave_ways < 1)
> -		return -EINVAL;
> -
>  	port = to_cxl_port(cxld->dev.parent);
>  	device_lock(&port->dev);
>  	if (list_empty(&port->dports)) {

