Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A765C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 16:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiLSQw6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 11:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiLSQw5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 11:52:57 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ABCDBC
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 08:52:56 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbQfY1sBsz6J6F2;
        Tue, 20 Dec 2022 00:49:41 +0800 (CST)
Received: from localhost (10.81.210.222) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 16:52:53 +0000
Date:   Mon, 19 Dec 2022 16:52:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rrichter@amd.com>,
        <terry.bowman@amd.com>
Subject: Re: [RFC PATCH 5/8] cxl: create emulated cxl_hdm for devices that
 do not have HDM decoders
Message-ID: <20221219165251.000008ab@Huawei.com>
In-Reply-To: <166984996390.2805382.1358232383903012041.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
        <166984996390.2805382.1358232383903012041.stgit@djiang5-desk3.ch.intel.com>
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

On Wed, 30 Nov 2022 16:12:43 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL rev3 spec 8.1.3
> RCDs may not have HDM register blocks. Create a fake HDM with information
> from the CXL PCIe DVSEC registers. The decoder count will be set to the
> HDM count retrieved from the DVSEC cap register.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
One comment inline that probably doesn't matter about setting
the target_count = 1.
If you need it to be 0 (which isn't normally a valid option) then
perhaps a comment on why.

> ---
>  drivers/cxl/core/hdm.c |   27 ++++++++++++++++++++++++++-
>  drivers/cxl/core/pci.c |    9 ++++++---
>  drivers/cxl/cxl.h      |    3 ++-
>  drivers/cxl/cxlmem.h   |    1 +
>  drivers/cxl/port.c     |    2 +-
>  5 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9773a5efaefd..3a9e9b854587 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -96,11 +96,31 @@ static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
>  	return crb + map.hdm_decoder.offset;
>  }
>  
> +static struct cxl_hdm *devm_cxl_setup_emulated_hdm(struct cxl_port *port,
> +						   struct cxl_endpoint_dvsec_info *info)
> +{
> +	struct device *dev = &port->dev;
> +	struct cxl_hdm *cxlhdm;
> +
> +	if (!info->mem_enabled)
> +		return ERR_PTR(-ENODEV);
> +
> +	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
> +	if (!cxlhdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlhdm->port = port;
> +	cxlhdm->decoder_count = info->ranges;

Whilst I assume target_count isn't used, perhaps better to set it here
for consistency as 0 isn't a valid value for the HDM decoder related field.


> +	dev_set_drvdata(&port->dev, cxlhdm);

blank line here preferred.

> +	return cxlhdm;
> +}
> +
