Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C52C83F3E
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 19:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjIETcA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 15:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbjIETcA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 15:32:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCF170A
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693942294; x=1725478294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qxkJDs3lKv8AFiDFGUVcv0dNSBKMPYH6HwveqGUPBew=;
  b=EjMhKL8clsc97Q+Fqan0wwvFvhBniEDBOEe4YPVFdLVZTxSRdtpD9c8N
   LuqXIKtqIBcTd232FEDZpYD27aj98wKEGvQku/o2Da1owRIv0g8GsnYAF
   cF7jhgHBoT5I2+BATsuddaOLVOnoSX8JDX/ZTPiCW1lIH+LQ0F5KYyfHs
   C11niqtts8jvuevTR6nbqb8S4P8KLd5ixk2pfYeVPEwjqVHVmSO+9yIJw
   P/x3TdLfGsVOfqHhBimrckJ455IwMqZCqZCAyvAP4cwzq1qEGeuSO+yIW
   HOM9zDyXQkHCOKgSnhZSrsNOzpRL60hlgRtVw5LSAbeNtcl/3SVgpyxJI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="440831920"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="440831920"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:42:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884384461"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="884384461"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.50.9])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 10:42:07 -0700
Date:   Tue, 5 Sep 2023 10:42:14 -0700
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
Message-ID: <ZPdoduf5IckVWQVD@aschofie-mobl2>
References: <cover.1692638817.git.alison.schofield@intel.com>
 <29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com>
 <20230825125415.00000bfc@Huawei.com>
 <ZO1E8i4i0QU2MANZ@aschofie-mobl2>
 <20230829141702.00000d7d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829141702.00000d7d@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 29, 2023 at 02:17:02PM +0100, Jonathan Cameron wrote:
> 
> Hi Alison,
> 
> > > > +	/*
> > > > +	 * No alignment. Attempt a 3-way split that removes the part of
> > > > +	 * the resource the region occupied, and then creates new soft
> > > > +	 * reserved resources for the leading and trailing addr space.
> > > > +	 * adjust_resource() will stop the attempt if there are any
> > > > +	 * child resources.
> > > > +	 */
> > > > +
> > > > +	/* Save the original soft reserved resource params before adjusting */
> > > > +	new_start = soft->start;
> > > > +	new_end = soft->end;
> > > > +	parent = soft->parent;
> > > > +	flags = soft->flags;
> > > > +
> > > > +	rc = adjust_resource(soft, start, end - start);
> > > > +	if (rc) {
> > > > +		dev_dbg(&cxlr->dev,
> > > > +			"cannot adjust soft reserved resource %pr\n", soft);
> > > > +		return;
> > > > +	}
> > > > +	rc = remove_resource(soft);
> > > > +	if (rc)
> > > > +		dev_warn(&cxlr->dev,
> > > > +			 "cannot remove soft reserved resource %pr\n", soft);  
> > > 
> > > I'd like a comment on this first bit.  Why adjust a resource only to throw it
> > > away?  
> > 
> > I intended to give the big picture in the block comment above. Scroll up
> > and see /* No alignment... 
> > 
> > Did you overlook that or do you want more explanation or something else?
> 
> Overlooked it as you guessed.  Makes sense though it's ugly that we need
> that comment.  Maybe worth explicitly checking that there are no children
> rather than using a side effect of adjust_resource()?
> Might need a new generic resource_has_children() check or similar.
> 
> Jonathan

Hi Jonathan,
Thanks - agree on the explicit child check.

However, I'm reworking this Soft Reserved handling based on a chat with
Dan. New approach is to not have the CXL intersecting soft reserved
resources in iomem_resource tree. Only move them there if CXL region
assembly fails and we want to make them availabe to DAX directly.
Just wrapping my head around it.

So, both these patches go away.

Alison


> > 
> > Thanks,
> > Alison
> > 
> > > 
> > >   
> > > > +
> > > > +	rc = add_soft_reserved(parent, new_start, start - new_start, flags);
> > > > +	if (rc)
> > > > +		dev_warn(&cxlr->dev,
> > > > +			 "cannot add new soft reserved resource at %pa\n",
> > > > +			 &new_start);
> > > > +
> > > > +	rc = add_soft_reserved(parent, end + 1, new_end - end, flags);
> > > > +	if (rc)
> > > > +		dev_warn(&cxlr->dev,
> > > > +			 "cannot add new soft reserved resource at %pa + 1\n",
> > > > +			 &end);
> > > > +}
> > > > +
> > > >  static void cxl_region_iomem_release(struct cxl_region *cxlr)
> > > >  {
> > > >  	struct cxl_region_params *p = &cxlr->params;
> > > > +	struct resource *parent, *res = p->res;
> > > > +	resource_size_t start, end;
> > > >  
> > > >  	if (device_is_registered(&cxlr->dev))
> > > >  		lockdep_assert_held_write(&cxl_region_rwsem);
> > > > -	if (p->res) {
> > > > -		/*
> > > > -		 * Autodiscovered regions may not have been able to insert their
> > > > -		 * resource.
> > > > -		 */
> > > > -		if (p->res->parent)
> > > > -			remove_resource(p->res);
> > > > -		kfree(p->res);
> > > > -		p->res = NULL;
> > > > +	if (!res)
> > > > +		return;
> > > > +	/*
> > > > +	 * Autodiscovered regions may not have been able to insert their
> > > > +	 * resource. If a Soft Reserved parent resource exists, try to
> > > > +	 * remove that also.
> > > > +	 */
> > > > +	if (p->res->parent) {
> > > > +		parent = p->res->parent;
> > > > +		start = p->res->start;
> > > > +		end = p->res->end;
> > > > +		remove_resource(p->res);
> > > > +		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
> > > > +		    parent->desc == IORES_DESC_SOFT_RESERVED)
> > > > +			remove_soft_reserved(cxlr, parent, start, end);
> > > >  	}
> > > > +
> > > > +	kfree(p->res);
> > > > +	p->res = NULL;
> > > >  }
> > > >  
> > > >  static int free_hpa(struct cxl_region *cxlr)  
> > >   
> 
