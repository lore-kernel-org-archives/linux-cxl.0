Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC7C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 14:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F137C61058
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 14:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbhICOSm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:18:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3733 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbhICOSl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 10:18:41 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1KZw6z27z67bBp;
        Fri,  3 Sep 2021 22:15:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 3 Sep 2021 16:17:39 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 15:17:39 +0100
Date:   Fri, 3 Sep 2021 15:17:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 02/13] cxl/core/bus: Add kernel docs for decoder ops
Message-ID: <20210903151740.00005fcd@Huawei.com>
In-Reply-To: <20210902195017.2516472-3-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-3-ben.widawsky@intel.com>
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

On Thu, 2 Sep 2021 12:50:06 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Since the code to add decoders for switches and endpoints is on the
> horizon, document the new interfaces that will be consumed by them.

Don't look "new" given they are already there...

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/core/bus.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 3991ac231c3e..9d98dd50d424 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -453,6 +453,19 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
>  }
>  EXPORT_SYMBOL_GPL(cxl_add_dport);
>  
> +/**
> + * cxl_decoder_alloc - Allocate a new CXL decoder
> + * @port: owning port of this decoder
> + * @nr_targets: downstream targets accessible by this decoder
number of downstream targets accessible by this decoder

perhaps.  Would be an odd name for a bitmap of them for example but the
help text doesn't rule that out.

> + *
> + * A port should contain one or more decoders. Each of those decoders enable
> + * some address space for CXL.mem utilization. Therefore, it is logical to
> + * allocate decoders while enumerating a port. While >= 1 is defined by the CXL
> + * specification, due to error conditions it is possible that a port may have 0
> + * decoders.
> + *
> + * Return: A new cxl decoder which wants to be added with cxl_decoder_add()

CXL decoder

Anything else possible?

> + */
>  struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  {
>  	struct cxl_decoder *cxld;
> @@ -491,6 +504,21 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  }
>  EXPORT_SYMBOL_GPL(cxl_decoder_alloc);
>  
> +/**
> + * cxl_decoder_add - Add a decoder with targets
> + * @host: The containing struct device. This is typically the PCI device that is
> + *        CXL capable

I would drop the 'struct' from that statement and just have device otherwise
it seems to imply something code related rather than physical device related.

> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()

CXL decoder

> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * Return: 0 if decoder was successfully added.

What else is possible?

> + *
> + * Certain types of decoders may not have any targets. The main example of this
> + * is an endpoint device. A more awkward example is a hostbridge whose root
> + * ports get hot added (technically possible, though unlikely).
> + */
>  int cxl_decoder_add(struct device *host, struct cxl_decoder *cxld,
>  		    int *target_map)
>  {

