Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B30C001B0
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Aug 2023 00:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHOALW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Aug 2023 20:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjHOAKw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Aug 2023 20:10:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20251715
        for <linux-cxl@vger.kernel.org>; Mon, 14 Aug 2023 17:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692058251; x=1723594251;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XMc72IhyVSkHswoPTsm0F32ueYDrhmfHP2+xd9/fZpI=;
  b=bExxdbqzOWDk/0S33KNshjjW0YEdt7skTe2Q1JvTZjGqLkHc+D9pH1gp
   ai2JBI4dRVlOUPyePPAInA2gpaU9uKHrUL8TNjG71TKIKhjv+C8Z59zsf
   lh7pqPnFjxK6NhnTjpclelsZGGoGXDNfTnTc773iiEzKEh9USVshPAYgG
   cS3IpPCVWdHsl3+c7ILDzoBZzFZ/J/k8yM+3NOWfRcy8GlxIhUJ+tZ7TV
   J1exajq1KzOGHdXfggJbCwGcgj+dNFqjG5zc6qO0HHctqyFoFrcf6RmKk
   q8piamlTWpPUU9tyaLJ3cL+BOiuziV8ilHVoC89uGEBPeIAar8GsLW4Oj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="357131779"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="357131779"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="1064258914"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="1064258914"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.148.210])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:10:50 -0700
Date:   Mon, 14 Aug 2023 17:10:48 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Try to add a region resource to a
 soft reserved parent
Message-ID: <ZNrCiNDgFEopsC7e@aschofie-mobl2>
References: <cover.1691176651.git.alison.schofield@intel.com>
 <6cd07222f169d951921486306187e87951853035.1691176651.git.alison.schofield@intel.com>
 <20230807152407.000070e6@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807152407.000070e6@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 07, 2023 at 03:24:07PM +0100, Jonathan Cameron wrote:
> On Fri,  4 Aug 2023 12:31:39 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > During region autodiscovery, the region driver always inserts the
> > region resource as a child of the root decoder, a CXL WINDOW. It
> > has the effect of making a soft reserved resource, with an exactly
> > matching address range, a child of the region resource.
> > 
> > It looks like this in /proc/iomem:
> > 
> > 2080000000-29dbfffffff : CXL Window 0
> >   2080000000-247fffffff : region0
> >     2080000000-247fffffff : Soft Reserved
> > 
> > Search for soft reserved resources that include the region resource,
> > and add the new region resource as a child of that found resource.
> > If a soft reserved resource is not found, insert to the root decoder
> > as usual.
> > 
> > With this change, it looks like this:
> > 
> > 2080000000-29dbfffffff : CXL Window 0
> >   2080000000-247fffffff : Soft Reserved
> >     2080000000-247fffffff : region0
> > 
> > This odd parenting only occurs when the resources are an exact match.
> > When the region resource only uses part of a soft reserved resource,
> > the parenting appears more logical like this:
> > 
> > 2080000000-29dbfffffff : CXL Window 0
> >   2080000000-287fffffff : Soft Reserved
> >     2080000000-247fffffff : region0
> > 
> > Aside from the more logical appearance, this change is in preparation
> > for further cleanup in region teardown. A follow-on patch intends to
> > find and free soft reserved resources upon region teardown.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Hi Alison
> 
> A comment and a question inline.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/cxl/core/region.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e115ba382e04..36c0c0dd5697 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2709,6 +2709,28 @@ static int match_region_by_range(struct device *dev, void *data)
> >  	return rc;
> >  }
> >  
> > +static int insert_resource_soft_reserved(struct resource *soft_res, void *arg)
> > +{
> > +	struct resource *parent, *new, *res = arg;
> > +	bool found = false;
> > +
> > +	parent = soft_res->parent;
> > +	if (!parent)
> > +		return 0;
> > +
> > +	/* Caller provides a copy of soft_res. Find the actual resource. */
> > +	for (new = parent->child; new; new = new->sibling) {
> > +		if (resource_contains(new, soft_res)) {
> > +			found = true;
> > +			break;
> > +		}
> > +	}
> > +	if (found)
> > +		return insert_resource(new, res) == 0;
> 

Thanks for the review Jonathan,

> Why not do this in the the if above then directly return there?
That would be better. Thanks.


> Also, should we get an error here, does it make sense to carry on?
> (I don't think we can get an error, but if that's the case we shouldn't
>  be checking for one)  If it's a corner we aren't sure about, good
> to add a comment on what the error case might be and what we are doing
> as a result.'


I see now this is hiding 2 cases in one error return
1) no soft reserved found
2) soft reserved found but failed to insert.

I think it can get an error if firmware set up soft reserved on bad
boundaries.

...scroll down...

> 
> > +
> > +	return 0;
> > +}
> > +
> >  /* Establish an empty region covering the given HPA range */
> >  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >  					   struct cxl_endpoint_decoder *cxled)
> > @@ -2719,7 +2741,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >  	struct cxl_region_params *p;
> >  	struct cxl_region *cxlr;
> >  	struct resource *res;
> > -	int rc;
> > +	int rc = 0;
> >  
> >  	do {
> >  		cxlr = __create_region(cxlrd, cxled->mode,
> > @@ -2755,7 +2777,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >  
> >  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> >  				    dev_name(&cxlr->dev));
> > -	rc = insert_resource(cxlrd->res, res);
> > +
> > +	/* Try inserting to a Soft Reserved parent, fallback to root decoder */
> > +	if (walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, 0,
> > +				res->start, res->end, res,
> > +				insert_resource_soft_reserved) != 1)
> > +		rc = insert_resource(cxlrd->res, res);
> > +

I'll rework this error handling to not try to insert to root decoder if
insert to soft reserved fails. Only try to insert to root decoder if soft
reserved does not exist.

> >  	if (rc) {
> >  		/*
> >  		 * Platform-firmware may not have split resources like "System
>

I think the insert to soft reserved can fail as describe here:
(Let me show this complete error case above)

	if (rc) {
                /*
                 * Platform-firmware may not have split resources like "System
                 * RAM" on CXL window boundaries see cxl_region_iomem_release()
                 */
                dev_warn(cxlmd->dev.parent,
                         "%s:%s: %s %s cannot insert resource\n",
                         dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
                         __func__, dev_name(&cxlr->dev));
        }




