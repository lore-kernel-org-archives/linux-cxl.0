Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E0C001B0
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Aug 2023 00:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjHOANb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Aug 2023 20:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjHOANK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Aug 2023 20:13:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7481715
        for <linux-cxl@vger.kernel.org>; Mon, 14 Aug 2023 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692058389; x=1723594389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M8izhfAWfLsbjmbfkp9NTlJYQ4yXDoM/CY7F7JQ2JlA=;
  b=MP3fgmOrH+Qi9V/ICUBycPjyL5d336wBVRoPASPOYkM1YiMqFB/nTicr
   NlqMM6eYXzRuJFJ9YRP0us1FLzYduWhaOESARd6mCQJr9YVOy+WotMbzD
   P0ZH+U6YMHj7rxu7bVNVwGy2LYG0uPrClhhxlXw2Kq7H6UFNSuzj/44WP
   WzUETrEEGW3XEfu7ECQykf3G/LVgiSublgstGyXCPxTaevx8rHVzd/Dfr
   EG+2S3NgzkJ7Q96LwP4/X8DehOL8dphfSYYVLuely1PfuGysPR+XlXEeG
   X/c8AT3D0jYqwyEBgFHtI+zmm5nSPZVHMHxNg7yfu7pJvzJ5z8EhSN1AZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="369639305"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="369639305"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:13:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736708752"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736708752"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.148.210])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:13:07 -0700
Date:   Mon, 14 Aug 2023 17:13:05 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cxl/region: Remove a soft reserved resource at
 region teardown
Message-ID: <ZNrDEY4G5oAwChy9@aschofie-mobl2>
References: <cover.1691176651.git.alison.schofield@intel.com>
 <2aa10593dbe6a4a8da35077aa492c8aacd363901.1691176651.git.alison.schofield@intel.com>
 <f0d84d36-44a5-840c-9ff3-0dcdfdeb69ee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0d84d36-44a5-840c-9ff3-0dcdfdeb69ee@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 09, 2023 at 04:34:43PM -0700, Dave Jiang wrote:
> 
> 
> On 8/4/23 12:31, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > When CXL regions are created through autodiscovery their resource
> > may be a child of a soft reserved resource. Today, when such a
> > region is destroyed, its soft reserved resource remains in place.
> > That means that the HPA range that the region could release, is
> > actually unavailable for reuse.
> 
> I think it reads better without the comma here.

Agree. Thanks!
Alison

> 
> > 
> > Free the soft reserved resource on region teardown by examining
> > the alignment of the resources, and handling accordingly. The
> > two resources, will be exactly aligned, partially aligned, or not
> > aligned at all.
> > 
> > |----------- "Soft Reserved" -----------|
> > |-------------- "Region #" -------------|
> > Exactly aligned. Any dangling children move up to a parent on removal.
> > The removal of this soft reserved seems guaranteed, however, the
> > availability of the address range for use depends on complete cleanup
> > of the region child resources also.
> > 
> > |----------- "Soft Reserved" -----------|
> > |-------- "Region #" -------|
> > or
> > |----------- "Soft Reserved" -----------|
> >              |-------- "Region #" -------|
> > Either start or end aligns. Unlike removing a resource, which simply
> > moves child resources up the resource tree, adjustments fail if any
> > child resources map the range being truncated. So, this one will fail
> > for dangling child resources of the region.
> > 
> > |---------- "Soft Reserved" ----------|
> >          |---- "Region #" ----|
> > No alignment. Freeing the resource of a region in the middle is possible
> > if no child resources map the leading or trailing address space.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   drivers/cxl/core/region.c | 132 +++++++++++++++++++++++++++++++++++---
> >   1 file changed, 123 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 36c0c0dd5697..b8a02afa3514 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -569,22 +569,136 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
> >   	return 0;
> >   }
> > +static int add_soft_reserved(struct resource *parent, resource_size_t start,
> > +			     resource_size_t len, unsigned long flags)
> > +{
> > +	struct resource *res;
> > +	int rc;
> > +
> > +	res = kmalloc(sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return -ENOMEM;
> > +
> > +	*res = DEFINE_RES_MEM_NAMED(start, len, "Soft Reserved");
> > +
> > +	res->desc = IORES_DESC_SOFT_RESERVED;
> > +	res->flags = res->flags | flags;
> > +	rc = insert_resource(parent, res);
> > +	if (rc)
> > +		kfree(res);
> > +
> > +	return rc;
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
> > +	mutex_lock(&cxlrd->range_lock);
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
> > +
> > +		goto out;
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
> > +		goto out;
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
> > +		goto out;
> > +	}
> > +	rc = remove_resource(soft);
> > +	if (rc)
> > +		dev_warn(&cxlr->dev,
> > +			 "cannot remove soft reserved resource %pr\n", soft);
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
> > +out:
> > +	mutex_unlock(&cxlrd->range_lock);
> > +}
> > +
> >   static void cxl_region_iomem_release(struct cxl_region *cxlr)
> >   {
> >   	struct cxl_region_params *p = &cxlr->params;
> > +	struct resource *parent, *res = p->res;
> > +	resource_size_t start, end;
> >   	if (device_is_registered(&cxlr->dev))
> >   		lockdep_assert_held_write(&cxl_region_rwsem);
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
> >   	}
> > +
> > +	kfree(p->res);
> > +	p->res = NULL;
> >   }
> >   static int free_hpa(struct cxl_region *cxlr)
