Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B610C71153
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Aug 2023 01:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjH2BIc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 28 Aug 2023 21:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjH2BIJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 28 Aug 2023 21:08:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED30131
        for <linux-cxl@vger.kernel.org>; Mon, 28 Aug 2023 18:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693271286; x=1724807286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vl8bnalZBy3AIf5BhJhLKSMBn52oA0HvzxX2XWqXRWs=;
  b=aRHuT0LAi+oj0XRivYFO57WTzmvk2TDwKGHqpNVejqVDNCrZkM5niVgj
   qMCSOQmrE5oT9H/nIO8Z4QSn5CqtO4gq13LCBi4kTo9d4ndqabe0jJ8n6
   olEfgCj3QyQvhXiA0LBaK9Qr3RXvP/ctn4c6yUYQXirA7GSOnZLIezxCJ
   FFqNrpZNHKS8uIPY+UHCLyQn0JWlXoiujC5XfC4qV1JA6PhNzKjOn9oaj
   BGPC3rOKsAdogqxx7GY6J4RTR4Vbu93cwQvZTazSl2X+5Fq9EmttglntQ
   nTxsBHlJWq6CBuC0NanDwEgFmW+JH7NpJfAXbc9IWzqz1PVWASaeoDuAx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="375214256"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="375214256"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 18:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="741620312"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="741620312"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.62.233])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 18:08:04 -0700
Date:   Mon, 28 Aug 2023 18:08:02 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>
Subject: Re: [PATCH v3 2/2] cxl/region: Remove a soft reserved resource at
 region teardown
Message-ID: <ZO1E8i4i0QU2MANZ@aschofie-mobl2>
References: <cover.1692638817.git.alison.schofield@intel.com>
 <29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com>
 <20230825125415.00000bfc@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825125415.00000bfc@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Aug 25, 2023 at 12:54:15PM +0100, Jonathan Cameron wrote:
> On Mon, 21 Aug 2023 11:14:37 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When CXL regions are created through autodiscovery their resource
> > may be a child of a soft reserved resource. Currently, when such a
> > region is destroyed, its soft reserved resource remains in place.
> > That means that the HPA range that the region could release is
> > actually unavailable for reuse.
> > 
> > Free the soft reserved resource on region teardown by examining
> > the alignment of the resources, and handling accordingly. The
> > two resources will be exactly aligned, partially aligned, or not
> > aligned at all.
> > 
> > |----------- "Soft Reserved" -----------|
> > |-------------- "Region #" -------------|
> > Exactly aligned. Any dangling children move up to a parent on removal.
> > The removal of this soft reserved seems guaranteed, however the
> > availability of the address range for reuse depends on complete cleanup
> > of the region child resources also.
> > 
> > |----------- "Soft Reserved" -----------|
> > |-------- "Region #" -------|
> > or
> > |----------- "Soft Reserved" -----------|
> >             |-------- "Region #" -------|
> > Either start or end aligns. Unlike removing a resource, which simply
> > moves child resources up the resource tree, adjustments fail if any
> > child resources map the range being truncated. So this one will fail
> > for dangling child resources of the region.
> > 
> > |---------- "Soft Reserved" ----------|
> >         |---- "Region #" ----|
> > No alignment. Freeing the resource of a region in the middle succeeds
> > if no child resources map the leading or trailing address space.
> > 
> > Reported-by: Derick Marks <derick.w.marks@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 130 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 121 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 5c487aab15ad..dcf8d4ad2cf4 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -569,22 +569,134 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> >  	return 0;
> >  }
> >  
> > +static int add_soft_reserved(struct resource *parent, resource_size_t start,
> > +			     resource_size_t len, unsigned long flags)
> > +{
> > +	struct resource *res __free(kfree) = kmalloc(sizeof(*res), GFP_KERNEL);
> > +	int rc;
> > +
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
> > +
> > +	res->desc = IORES_DESC_SOFT_RESERVED;
> > +	res->flags = res->flags | flags;
> > +	rc = insert_resource(parent, res);
> > +	if (rc)
> > +		return rc;
> > +
> > +	no_free_ptr(res);
> 
> nitpick but I'd like a blank line here :)

Got it.

> 
> > +	return 0;
> > +}
> > +
> > +static void remove_soft_reserved(struct cxl_region *cxlr, struct resource *soft,
> > +				 resource_size_t start, resource_size_t end)
> > +{
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> > +	resource_size_t new_start, new_end;
> > +	struct resource *parent;
> > +	unsigned long flags;
> > +	int rc;
> > +
> > +	/* Prevent new usage while removing or adjusting the resource */
> > +	guard(mutex)(&cxlrd->range_lock);
> > +
> > +	/* Aligns at both resource start and end */
> > +	if (soft->start == start && soft->end == end) {
> > +		rc = remove_resource(soft);
> > +		if (rc)
> > +			dev_dbg(&cxlr->dev,
> > +				"cannot remove soft reserved resource %pr\n",
> > +				soft);
> > +		else
> > +			kfree(soft);
> Really trivial readability comment but I'd prefer...
> 		if (rc) {
> 			dev_dbg(&cxlr->...
> 			        soft);
> 			return
> 		}
> 
> 		kfree(soft)
> 
> 		return;
> 
> So that the error path is indented and the good path not.
> Maybe that's just how my brain works though so feel free to ignore this one. 

I'll do it. I appreciate the suggestion.

> 
> > +
> > +		return;
> > +	}
> > +
> > +	/* Aligns at either resource start or end */
> > +	if (soft->start == start || soft->end == end) {
> > +		if (soft->start == start) {
> > +			new_start = end + 1;
> > +			new_end = soft->end;
> > +		} else {
> > +			new_start = soft->start;
> > +			new_end = start + 1;
> > +		}
> > +		rc =  adjust_resource(soft, new_start, new_end - new_start + 1);
> > +		if (rc)
> > +			dev_dbg(&cxlr->dev,
> > +				"cannot adjust soft reserved resource %pr\n",
> > +				soft);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * No alignment. Attempt a 3-way split that removes the part of
> > +	 * the resource the region occupied, and then creates new soft
> > +	 * reserved resources for the leading and trailing addr space.
> > +	 * adjust_resource() will stop the attempt if there are any
> > +	 * child resources.
> > +	 */
> > +
> > +	/* Save the original soft reserved resource params before adjusting */
> > +	new_start = soft->start;
> > +	new_end = soft->end;
> > +	parent = soft->parent;
> > +	flags = soft->flags;
> > +
> > +	rc = adjust_resource(soft, start, end - start);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev,
> > +			"cannot adjust soft reserved resource %pr\n", soft);
> > +		return;
> > +	}
> > +	rc = remove_resource(soft);
> > +	if (rc)
> > +		dev_warn(&cxlr->dev,
> > +			 "cannot remove soft reserved resource %pr\n", soft);
> 
> I'd like a comment on this first bit.  Why adjust a resource only to throw it
> away?

I intended to give the big picture in the block comment above. Scroll up
and see /* No alignment... 

Did you overlook that or do you want more explanation or something else?

Thanks,
Alison

> 
> 
> > +
> > +	rc = add_soft_reserved(parent, new_start, start - new_start, flags);
> > +	if (rc)
> > +		dev_warn(&cxlr->dev,
> > +			 "cannot add new soft reserved resource at %pa\n",
> > +			 &new_start);
> > +
> > +	rc = add_soft_reserved(parent, end + 1, new_end - end, flags);
> > +	if (rc)
> > +		dev_warn(&cxlr->dev,
> > +			 "cannot add new soft reserved resource at %pa + 1\n",
> > +			 &end);
> > +}
> > +
> >  static void cxl_region_iomem_release(struct cxl_region *cxlr)
> >  {
> >  	struct cxl_region_params *p = &cxlr->params;
> > +	struct resource *parent, *res = p->res;
> > +	resource_size_t start, end;
> >  
> >  	if (device_is_registered(&cxlr->dev))
> >  		lockdep_assert_held_write(&cxl_region_rwsem);
> > -	if (p->res) {
> > -		/*
> > -		 * Autodiscovered regions may not have been able to insert their
> > -		 * resource.
> > -		 */
> > -		if (p->res->parent)
> > -			remove_resource(p->res);
> > -		kfree(p->res);
> > -		p->res = NULL;
> > +	if (!res)
> > +		return;
> > +	/*
> > +	 * Autodiscovered regions may not have been able to insert their
> > +	 * resource. If a Soft Reserved parent resource exists, try to
> > +	 * remove that also.
> > +	 */
> > +	if (p->res->parent) {
> > +		parent = p->res->parent;
> > +		start = p->res->start;
> > +		end = p->res->end;
> > +		remove_resource(p->res);
> > +		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
> > +		    parent->desc == IORES_DESC_SOFT_RESERVED)
> > +			remove_soft_reserved(cxlr, parent, start, end);
> >  	}
> > +
> > +	kfree(p->res);
> > +	p->res = NULL;
> >  }
> >  
> >  static int free_hpa(struct cxl_region *cxlr)
> 
