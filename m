Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE46C77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 18:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDLSk0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 14:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDLSkO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 14:40:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F74C7EC7
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 11:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681324796; x=1712860796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=azQR6ifoUWN8QIJ4utcAJ+VhjvgmZi44QP4ecKlvkg8=;
  b=SU3K0kmYIJ0V/uRs+RZ3Np1c+/PqYqNtW9hWMXu5uhT5UfFzZwe8zgQS
   A1WJAcu2u9th+TvxJtpbUPny4KFrByiJO3d6rQsMTF0LCYQGmOyhhC8sB
   2oEITz+GaXPGZtCuYKdsuWwaRbsDz94QVyDXiml0aJFrzQ5QsdygI5LRG
   aEtZdNr/2OCquloOxmyAm9SZxvd9Zo2tAw297jm/WnBylgT6smTmONMTi
   A1lfvRWO31qoaTR9BmVwwI+AGnRJyK9UlGe+BYw8l/iGM0acJ17CCYaNZ
   8oRaiHN3GcccC6QRZY6QIQPQp/A/rNQv1OMBsJORtMr40qCBiXvcLRd/y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324349554"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324349554"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:39:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="1018835174"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="1018835174"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.150.154])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 11:39:31 -0700
Date:   Wed, 12 Apr 2023 11:39:29 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 4/6] cxl/region: Provide region info to the
 cxl_poison trace event
Message-ID: <ZDb64ZQpNwZemQeg@aschofie-mobl2>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <92a8eab0aadde1c65f57e03d1ae0160929b23921.1681159309.git.alison.schofield@intel.com>
 <643647e5502ab_417e29445@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <643647e5502ab_417e29445@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 11, 2023 at 10:55:49PM -0700, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > User space may need to know which region, if any, maps the poison
> > address(es) logged in a cxl_poison trace event. Since the mapping
> > of DPAs (device physical addresses) to a region can change, the
> > kernel must provide this information at the time the poison list
> > is read. The event informs user space that at event <timestamp>
> > this <region> mapped to this <DPA>, which is poisoned.
> > 
> > The cxl_poison trace event is already wired up to log the region
> > name and uuid if it receives param 'struct cxl_region'.
> > 
> > In order to provide that cxl_region, add another method for gathering
> > poison - by committed endpoint decoder mappings. This method is only
> > available with CONFIG_CXL_REGION and is only used if a region actually
> > maps the memdev where poison is being read. After the region driver
> > reads the poison list for all the mapped resources, control returns
> > to the memdev driver, where poison is read for any remaining unmapped
> > resources.
> > 
> > Mixed mode decoders are not currently supported in Linux. Add a debug
> > message to the poison request path. That will serve as an alert that
> > poison list retrieval needs to add support for mixed mode.
> > 
> > The default method remains: read the poison by memdev resource.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/core/core.h   | 11 +++++++
> >  drivers/cxl/core/memdev.c | 62 +++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/core/region.c | 63 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 135 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index e888e293943e..57bd22e01a0b 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -25,7 +25,12 @@ void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
> >  #define CXL_DAX_REGION_TYPE(x) (&cxl_dax_region_type)
> >  int cxl_region_init(void);
> >  void cxl_region_exit(void);
> > +int cxl_get_poison_by_endpoint(struct device *dev, void *data);
> >  #else
> > +static inline int cxl_get_poison_by_endpoint(struct device *dev, void *data)
> > +{
> > +	return 0;
> > +}
> 
> For a public function the lack of type safety jumps out at me... more
> below:
> 
> >  static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
> >  {
> >  }
> > @@ -68,4 +73,10 @@ enum cxl_poison_trace_type {
> >  	CXL_POISON_TRACE_LIST,
> >  };
> >  
> > +struct cxl_trigger_poison_context {
> > +	struct cxl_port *port;
> > +	enum cxl_decoder_mode mode;
> > +	u64 offset;
> > +};
> > +
> >  #endif /* __CXL_CORE_H__ */
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 297d87ebaca6..f26b5b6cda10 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -106,6 +106,47 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
> >  }
> >  static DEVICE_ATTR_RO(numa_node);
> >  
> > +static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
> > +				   struct cxl_trigger_poison_context *ctx)
> > +{
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	u64 offset, length;
> > +	int rc = 0;
> > +
> > +	/*
> > +	 * Collect poison for the remaining unmapped resources
> > +	 * after poison is collected by committed endpoints.
> > +	 *
> > +	 * Knowing that PMEM must always follow RAM, get poison
> > +	 * for unmapped resources based on the last decoder's mode:
> > +	 *	ram: scan remains of ram range, then any pmem range
> > +	 *	pmem: scan remains of pmem range
> > +	 */
> > +
> > +	if (ctx->mode == CXL_DECODER_RAM) {
> > +		offset = ctx->offset;
> > +		length = resource_size(&cxlds->ram_res) - offset;
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		if (rc == -EFAULT)
> > +			rc = 0;
> > +		if (rc)
> > +			return rc;
> > +	}
> > +	if (ctx->mode == CXL_DECODER_PMEM) {
> > +		offset = ctx->offset;
> > +		length = resource_size(&cxlds->dpa_res) - offset;
> > +		if (!length)
> > +			return 0;
> > +	} else if (resource_size(&cxlds->pmem_res)) {
> > +		offset = cxlds->pmem_res.start;
> > +		length = resource_size(&cxlds->pmem_res);
> > +	} else {
> > +		return 0;
> > +	}
> > +
> > +	return cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +}
> > +
> >  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
> >  {
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > @@ -139,14 +180,33 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
> >  				const char *buf, size_t len)
> >  {
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_trigger_poison_context ctx;
> > +	struct cxl_port *port;
> >  	bool trigger;
> >  	ssize_t rc;
> >  
> >  	if (kstrtobool(buf, &trigger) || !trigger)
> >  		return -EINVAL;
> >  
> > +	port = dev_get_drvdata(&cxlmd->dev);
> > +	if (!port || !is_cxl_endpoint(port))
> > +		return -EINVAL;
> > +
> >  	down_read(&cxl_dpa_rwsem);
> > -	rc = cxl_get_poison_by_memdev(cxlmd);
> > +	if (port->commit_end == -1) {
> > +		/* No regions mapped to this memdev */
> > +		rc = cxl_get_poison_by_memdev(cxlmd);
> > +	} else {
> > +		/* Regions mapped, collect poison by endpoint */
> > +		ctx = (struct cxl_trigger_poison_context) {
> > +			.port = port,
> > +		};
> > +		rc = device_for_each_child(&port->dev, &ctx,
> > +					   cxl_get_poison_by_endpoint);
> > +		if (rc == 1)
> > +			rc = cxl_get_poison_unmapped(cxlmd, &ctx);
> 
> Ah, cxl_get_poison_by_endpoint() is a function pointer to
> device_for_each_child(), that really feels like a detail that's private
> to the implementation.
> 
> I would reorganize this to something like:
> 
>      if (port->commit_end == -1) {
>              /* No regions mapped to this memdev */
>              rc = cxl_get_poison_by_memdev(cxlmd);
>      } else {
>              /* Regions mapped, collect poison by endpoint */
>              rc = cxl_get_poison_by_endpoint(endpoint);
>      }
> 
> ...and then internal to cxl_get_poison_by_endpoint() do:
> 	    
>              ctx = (struct cxl_trigger_poison_context) {
>                      .port = endpoint,
>              };
>              rc = device_for_each_child(&port->dev, &ctx,
>                                         poison_by_decoder);
>              if (rc == 1)
>                      rc = cxl_get_poison_unmapped(cxlmd, &ctx);
> 
> ...then the header file reads more calmly with the added type-safety.

I'll take another stab at this.

A couple of versions back, I pulled cxl_get_poison_unmapped() out of 
cxl_get_poison_by_endpoint() since it was not really work of the 
region driver. (Ira called that out in a review)

Thanks,
Alison


> 
> > +	}
> > +
> >  	up_read(&cxl_dpa_rwsem);
> >  
> >  	return rc ? rc : len;
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index f29028148806..4c4d3a6d631d 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2213,6 +2213,69 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(to_cxl_pmem_region, CXL);
> >  
> > +int cxl_get_poison_by_endpoint(struct device *dev, void *arg)
> > +{
> > +	struct cxl_trigger_poison_context *ctx = arg;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_port *port = ctx->port;
> > +	struct cxl_memdev *cxlmd;
> > +	u64 offset, length;
> > +	int rc = 0;
> > +
> > +	down_read(&cxl_region_rwsem);
> > +
> > +	if (!is_endpoint_decoder(dev))
> > +		goto out;
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> > +		goto out;
> > +
> > +	/*
> > +	 * Regions are only created with single mode decoders: pmem or ram.
> > +	 * Linux does not currently support mixed mode decoders. This means
> > +	 * that reading poison per endpoint decoder adheres to the spec
> > +	 * requirement that poison reads of pmem and ram must be separated.
> > +	 * CXL 3.0 Spec 8.2.9.8.4.1
> > +	 *
> > +	 * Watch for future support of mixed with a dev_dbg() msg.
> 
> This sentence can go, mixed will never* be supported.
> 
> * at least until the vendor that manages to ship such a thing comes and
>   explains why the kernel needs to work around that awkwardness.
> 

Got it!

> > +	 */

snip

> 
