Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7C1C76196
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 15:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjCaPwQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCaPwP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 11:52:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A6E10D7
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680277933; x=1711813933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fu5iabUi8Ecf2G5i5xZ7PMzVo66ylYJh2isPezKOKzA=;
  b=X4eUv/BPESoLqiArLlEBpbHhfeXrkbYhBgdi20bEELREcJfvFlCHwpv+
   IMbULtSNpwMfwKi7ib6i/CfTSuG8YJud6dEWPeK871KKYWwlC1nLkT6DI
   mrg4sjNseiNFAfPImaEqxd6DgQe7eqIX2D8kXXa1RcP/F8OoAYD7OQu85
   lEVl4FJ8WjNDL/Nm5Gj2TxDPo2Pj7fZVnAUUD6OcKnjYGo8RM+VkLBiSp
   IiBCqlpm09ZFax4hy6kp3UjUvLsc35jFww4zOzG3M0sjTyVAWqlLQv2PQ
   csklH3WYWck4D3+APwen/qdraiJLaFs6EIa/bsjK0qUFDBEQgnxtbsQgM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="344006728"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="344006728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:52:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="809091271"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="809091271"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.63.54])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 08:52:13 -0700
Date:   Fri, 31 Mar 2023 08:52:11 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v11 4/6] cxl/region: Provide region info to the
 cxl_poison trace event
Message-ID: <ZCcBq/P45bnPjBOk@aschofie-mobl2>
References: <cover.1679888450.git.alison.schofield@intel.com>
 <f5bfd91ce391c1ee13a0d55c698be2417072d02d.1679888450.git.alison.schofield@intel.com>
 <6424a307bdd18_353be8294d7@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6424a307bdd18_353be8294d7@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 29, 2023 at 01:43:51PM -0700, Ira Weiny wrote:
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
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I like the way this scans the memdev at the end in this version better.

Good!  That was based on your suggestion and was changed in v9.

 - Move the 'remains' handling to memdev driver (Ira)
   Previously, after the region driver read poison for the last committed
   endpoint decoder, it also read poison for remaining unmapped resources.
   Add a context struct to pass the poison read state between memdev and
   region drivers, so that memdev driver can complete the poison read of
   unmapped resources.

Alison

> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
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
> > +	 */
> > +	if (cxled->mode == CXL_DECODER_MIXED) {
> > +		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
> > +		goto out;
> > +	}
> > +
> > +	cxlmd = cxled_to_memdev(cxled);
> > +	if (cxled->skip) {
> > +		offset = cxled->dpa_res->start - cxled->skip;
> > +		length = cxled->skip;
> > +		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> > +		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> > +			rc = 0;
> > +		if (rc)
> > +			goto out;
> > +	}
> > +
> > +	offset = cxled->dpa_res->start;
> > +	length = cxled->dpa_res->end - offset + 1;
> > +	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> > +	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> > +		rc = 0;
> > +	if (rc)
> > +		goto out;
> > +
> > +	/* Iterate until commit_end is reached */
> > +	if (cxled->cxld.id == port->commit_end)
> > +		rc = 1;
> > +
> > +	/* ctx informs the memdev driver of last read poison */
> > +	ctx->mode = cxled->mode;
> > +	ctx->offset = cxled->dpa_res->end + 1;
> > +out:
> > +	up_read(&cxl_region_rwsem);
> > +	return rc;
> > +}
> > +
> >  static struct lock_class_key cxl_pmem_region_key;
> >  
> >  static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> > -- 
> > 2.37.3
> > 
> 
> 
