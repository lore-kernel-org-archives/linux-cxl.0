Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5414C76196
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Apr 2023 17:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjDKRnN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDKRnM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 13:43:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C77C272B
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681234984; x=1712770984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yutK6XjL/wX2a6BRpwT2G14FRE4HdjQ/mmhhnMVlROs=;
  b=GMYy9591zCyAVAs8rgO5MYafpgIDpFScsBjli94ucm26Jc0jBMMnf8T5
   ABrb+0Qlf0vgv/DfKlExNrsbZty8G4ysDUQKbPh6oRL/XBpoX0BSjy8za
   JQF5dnJH5QBie8uaw861/2F/lctoE1Huxmk0BOPMez2s4O2N7LD7A0v8N
   tZ0WD7k30c1f4DEqgln+hW3BWs0qKaj21Gn6XuFI4wWd2K+MmiIDGYsvc
   cxVmWH2T6bN/Yya/CkAdf7CvpVYq0QE8S2yjrrkowuEtlsznIs8JUWs4q
   QwJE+YjUgKS9l0QcHhLAupKMguF/mU9Coubld1pbWLT7+cgkgwLyH/YVC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="429979173"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="429979173"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="800006916"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="800006916"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.39.92])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:43:03 -0700
Date:   Tue, 11 Apr 2023 10:43:01 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 03/12] cxl/memdev: Warn of poison inject or clear to a
 mapped region
Message-ID: <ZDWcJcs9fu7+clzi@aschofie-mobl2>
References: <cover.1679892337.git.alison.schofield@intel.com>
 <fc7db7de4778803a3221d7fd5a203bf971fdac61.1679892337.git.alison.schofield@intel.com>
 <20230330195546.00004774@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330195546.00004774@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 30, 2023 at 07:55:46PM +0100, Jonathan Cameron wrote:
> On Sun, 26 Mar 2023 22:03:09 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Inject and clear poison capabilities and intended for debug usage only.
> > In order to be useful in debug environments, the driver needs to allow
> > inject and clear operations on DPAs mapped in regions.
> > 
> > dev_warn_once() when either operation occurs.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/memdev.c | 59 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 0e39c3c3fb09..a83619c31f61 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c

snip

> > +static int __cxl_dpa_to_region(struct device *dev, void *arg)
> > +{
> > +	struct cxl_dpa_to_region_context *ctx = arg;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	u64 dpa = ctx->dpa;
> > +
> > +	if (!is_endpoint_decoder(dev))
> > +		return 0;
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> > +		return 0;
> > +
> > +	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> > +		return 0;
> > +
> > +	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> > +		dev_name(&cxled->cxld.region->dev));
> > +
> > +	ctx->cxlr = cxled->cxld.region;
> > +
> If we have a match, little point in letting walk continue.
> 
> return 1;

Yes, thanks!  Returning 1 now to stop the walk.

> 
> Also, I "think" we just know that the association has been built.
> Injecting poison is probably still fine if the region / decoder hasn't yet
> been committed.

I think you are right. If we want to allow inject in the space between
mapping and commit, then this work needs to move to the region driver,
similar to how cxl_get_poison_by_endpoint() in the get poison list
series works.

I'm not seeing how injecting poison in that gap, would be an important
debug scenario. Is it?

Alison

> 
> Jonathan
> 
> 
> > +	return 0;
> > +}
> > +
> > +static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
> > +{
> > +	struct cxl_dpa_to_region_context ctx;
> > +	struct cxl_port *port;
> > +
> > +	ctx = (struct cxl_dpa_to_region_context) {
> > +		.dpa = dpa,
> > +	};
> > +	port = dev_get_drvdata(&cxlmd->dev);
> > +	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
> > +		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
> > +
> > +	return ctx.cxlr;
> > +}
> > +
> >  static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
> >  {
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > @@ -242,6 +286,7 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_mbox_inject_poison inject;
> >  	struct cxl_mbox_cmd mbox_cmd;
> > +	struct cxl_region *cxlr;
> >  	int rc;
> >  
> >  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> > @@ -261,6 +306,13 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
> >  		.payload_in = &inject,
> >  	};
> >  	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> > +	if (rc)
> > +		goto out;
> > +
> > +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> > +	if (cxlr)
> > +		dev_warn_once(dev, "poison inject dpa:0x%llx region: %s\n",
> > +			      dpa, dev_name(&cxlr->dev));
> >  out:
> >  	up_read(&cxl_dpa_rwsem);
> >  
> > @@ -273,6 +325,7 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_mbox_clear_poison clear;
> >  	struct cxl_mbox_cmd mbox_cmd;
> > +	struct cxl_region *cxlr;
> >  	int rc;
> >  
> >  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> > @@ -303,7 +356,13 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
> >  	};
> >  
> >  	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> > +	if (rc)
> > +		goto out;
> >  
> > +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> > +	if (cxlr)
> > +		dev_warn_once(dev, "poison clear dpa:0x%llx region: %s\n",
> > +			      dpa, dev_name(&cxlr->dev));
> >  out:
> >  	up_read(&cxl_dpa_rwsem);
> >  
> 
