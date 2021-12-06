Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28424C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Dec 2021 10:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbhLFKyu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Dec 2021 05:54:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4200 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbhLFKyu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Dec 2021 05:54:50 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J70Vj3JjFz67tGk;
        Mon,  6 Dec 2021 18:47:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 6 Dec 2021 11:51:19 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 10:51:19 +0000
Date:   Mon, 6 Dec 2021 10:51:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 01/14] cxl/core: Add, document, and tighten up
 decoder APIs
Message-ID: <20211206105118.00002dff@Huawei.com>
In-Reply-To: <20211202043750.3501494-2-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
        <20211202043750.3501494-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml746-chm.china.huawei.com (10.201.108.196) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 1 Dec 2021 20:37:37 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Since the code to add decoders for switches and endpoints is on the
> horizon it helps to have properly documented APIs. In addition, the
> decoder APIs will never need to support a negative count for downstream
> targets as the spec explicitly starts numbering them at 1, ie. even 0 is
> an "invalid" value which can be used as a sentinel.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Trivial thing inline, about whether you should call out where return
values can be error pointers.  I'm fine either way with that.

Nice cleanup.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
> Changes since v1:
> - Added decoder type specific APIs (Dan)
> ---
>  drivers/cxl/acpi.c     |  4 +--
>  drivers/cxl/core/bus.c | 82 +++++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h      |  5 ++-
>  3 files changed, 79 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index da70f1836db6..9f88dec03b33 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -102,7 +102,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
>  		target_map[i] = cfmws->interleave_targets[i];
>  
> -	cxld = cxl_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
> +	cxld = cxl_root_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
>  	if (IS_ERR(cxld))
>  		return 0;
>  
> @@ -260,7 +260,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	 * dport. Disable the range until the first CXL region is enumerated /
>  	 * activated.
>  	 */
> -	cxld = cxl_decoder_alloc(port, 1);
> +	cxld = cxl_root_decoder_alloc(port, 1);
>  	if (IS_ERR(cxld))
>  		return PTR_ERR(cxld);
>  
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index ab756a53a983..2f72087846e3 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -495,7 +495,20 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>  	return rc;
>  }
>  
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> +/**
> + * cxl_decoder_alloc - Allocate a new CXL decoder
> + * @port: owning port of this decoder
> + * @nr_targets: downstream targets accessible by this decoder. All upstream
> + *		ports and root ports must have at least 1 target.
> + *
> + * A port should contain one or more decoders. Each of those decoders enable
> + * some address space for CXL.mem utilization. A decoder is expected to be
> + * configured by the caller before registering.
> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + */
> +static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +					     unsigned int nr_targets)
>  {
>  	struct cxl_decoder *cxld, cxld_const_init = {
>  		.nr_targets = nr_targets,
> @@ -503,7 +516,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  	struct device *dev;
>  	int rc = 0;
>  
> -	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> +	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
>  		return ERR_PTR(-EINVAL);
>  
>  	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> @@ -522,19 +535,70 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  	dev->parent = &port->dev;
>  	dev->bus = &cxl_bus_type;
>  
> -	/* root ports do not have a cxl_port_type parent */
> -	if (port->dev.parent->type == &cxl_port_type)
> -		dev->type = &cxl_decoder_switch_type;
> -	else
> -		dev->type = &cxl_decoder_root_type;
> -
>  	return cxld;
>  err:
>  	kfree(cxld);
>  	return ERR_PTR(rc);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
>  
> +/**
> + * cxl_root_decoder_alloc - Allocate a root level decoder
> + * @port: owning port of this decoder
> + * @nr_targets: number of downstream targets. The number of downstream targets
> + *		is determined with a platform specific mechanism.
> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()

Call out that it can return an error pointer?

> + */
> +struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> +					   unsigned int nr_targets)
> +{
> +	struct cxl_decoder *cxld;
> +
> +	cxld = cxl_decoder_alloc(port, nr_targets);
> +	if (!IS_ERR(cxld))
> +		cxld->dev.type = &cxl_decoder_root_type;
> +
> +	return cxld;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
> +
> +/**
> + * cxl_switch_decoder_alloc - Allocate a switch level decoder
> + * @port: owning port of this decoder
> + * @nr_targets: number of downstream targets. The number of downstream targets
> + *		is determined via CXL capability registers.
> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + */
> +struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> +					     unsigned int nr_targets)
> +{
> +	struct cxl_decoder *cxld;
> +
> +	cxld = cxl_decoder_alloc(port, nr_targets);
> +	if (!IS_ERR(cxld))
> +		cxld->dev.type = &cxl_decoder_switch_type;
> +
> +	return cxld;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
> +
> +/**
> + * cxl_decoder_add - Add a decoder with targets
> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * Certain types of decoders may not have any targets. The main example of this
> + * is an endpoint device. A more awkward example is a hostbridge whose root
> + * ports get hot added (technically possible, though unlikely).
> + *
> + * Context: Process context. Takes and releases the cxld's device lock.
> + *
> + * Return: Negative error code if the decoder wasn't properly configured; else
> + *	   returns 0.
> + */
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  {
>  	struct cxl_port *port;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ad816fb5bdcc..a036594ec5b3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -288,7 +288,10 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
> +struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> +					   unsigned int nr_targets);
> +struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> +					     unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
>  

