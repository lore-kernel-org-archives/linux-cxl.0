Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FC1C001B0
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Aug 2023 00:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHOAM0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Aug 2023 20:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjHOAMK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Aug 2023 20:12:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C9172E
        for <linux-cxl@vger.kernel.org>; Mon, 14 Aug 2023 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692058329; x=1723594329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jK7guuAgsAzRVOi2f8dDMjAxBbozDfI9pEiweo9y+Tc=;
  b=l//Il+yw7c4yfHwFvE408HdOwtdyrDrr7gMgqI1nLiyQFbBMqzLok7AS
   cmFLfh4ig/JACQtbToHMSYQ0OFSrPhD3q1iq++Xokuk1FN5nwAjfoFTHA
   V29zVSbaj8Bw2wPv+b2mFLTuhwFbqE1o5j9RtPXvml8Ay5cxBQfBfYQji
   4CLK2EpWbGxJr9BnmCRaJwyB9S33QFhZYrcxy/RoB5NTQ1XTeMtM0T2vF
   pK0iN3ES/S1g1wTu1A0FsYxmNSHR3MUwxQ6MgY7DAyQWzmL+YtLB8Kinq
   TZzQbci50EobgUtVpLwyDeyrz9j5gImtjXSrDQ5eE2kHeGURJPhvKRWEM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="362315117"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="362315117"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="683476913"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="683476913"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.148.210])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:12:08 -0700
Date:   Mon, 14 Aug 2023 17:12:07 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Try to add a region resource to a
 soft reserved parent
Message-ID: <ZNrC15kuvuJoO57H@aschofie-mobl2>
References: <cover.1691176651.git.alison.schofield@intel.com>
 <6cd07222f169d951921486306187e87951853035.1691176651.git.alison.schofield@intel.com>
 <e6431435-e9cd-8595-bb3d-f0a132eae371@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6431435-e9cd-8595-bb3d-f0a132eae371@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 09, 2023 at 04:22:03PM -0700, Dave Jiang wrote:
> 
> 
> On 8/4/23 12:31, alison.schofield@intel.com wrote:
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
> >    2080000000-247fffffff : region0
> >      2080000000-247fffffff : Soft Reserved
> > 
> > Search for soft reserved resources that include the region resource,
> > and add the new region resource as a child of that found resource.
> 
> Don't think the comma is needed here.

Got it. Thanks!


> 
> > If a soft reserved resource is not found, insert to the root decoder
> > as usual.
> > 
> > With this change, it looks like this:
> > 
> > 2080000000-29dbfffffff : CXL Window 0
> >    2080000000-247fffffff : Soft Reserved
> >      2080000000-247fffffff : region0
> > 
> > This odd parenting only occurs when the resources are an exact match.
> > When the region resource only uses part of a soft reserved resource,
> > the parenting appears more logical like this:
> > 
> > 2080000000-29dbfffffff : CXL Window 0
> >    2080000000-287fffffff : Soft Reserved
> >      2080000000-247fffffff : region0
> > 
> > Aside from the more logical appearance, this change is in preparation
> > for further cleanup in region teardown. A follow-on patch intends to
> > find and free soft reserved resources upon region teardown.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >   drivers/cxl/core/region.c | 32 ++++++++++++++++++++++++++++++--
> >   1 file changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e115ba382e04..36c0c0dd5697 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2709,6 +2709,28 @@ static int match_region_by_range(struct device *dev, void *data)
> >   	return rc;
> >   }
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
> > +
> > +	return 0;
> > +}
> > +
> >   /* Establish an empty region covering the given HPA range */
> >   static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >   					   struct cxl_endpoint_decoder *cxled)
> > @@ -2719,7 +2741,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >   	struct cxl_region_params *p;
> >   	struct cxl_region *cxlr;
> >   	struct resource *res;
> > -	int rc;
> > +	int rc = 0;
> >   	do {
> >   		cxlr = __create_region(cxlrd, cxled->mode,
> > @@ -2755,7 +2777,13 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> >   	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> >   				    dev_name(&cxlr->dev));
> > -	rc = insert_resource(cxlrd->res, res);
> > +
> > +	/* Try inserting to a Soft Reserved parent, fallback to root decoder */
> > +	if (walk_iomem_res_desc(IORES_DESC_SOFT_RESERVED, 0,
> > +				res->start, res->end, res,
> > +				insert_resource_soft_reserved) != 1)
> > +		rc = insert_resource(cxlrd->res, res);
> > +
> >   	if (rc) {
> >   		/*
> >   		 * Platform-firmware may not have split resources like "System
