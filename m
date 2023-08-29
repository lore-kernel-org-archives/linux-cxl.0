Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8829C71153
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Aug 2023 13:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjH2NR2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Aug 2023 09:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbjH2NRL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Aug 2023 09:17:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AD3BA
        for <linux-cxl@vger.kernel.org>; Tue, 29 Aug 2023 06:17:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZnxJ1dtjz6HJjL;
        Tue, 29 Aug 2023 21:16:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 14:17:03 +0100
Date:   Tue, 29 Aug 2023 14:17:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alison Schofield <alison.schofield@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>,
        "Derick Marks" <derick.w.marks@intel.com>
Subject: Re: [PATCH v3 2/2] cxl/region: Remove a soft reserved resource at
 region teardown
Message-ID: <20230829141702.00000d7d@Huawei.com>
In-Reply-To: <ZO1E8i4i0QU2MANZ@aschofie-mobl2>
References: <cover.1692638817.git.alison.schofield@intel.com>
        <29312c0765224ae76862d59a17748c8188fb95f1.1692638817.git.alison.schofield@intel.com>
        <20230825125415.00000bfc@Huawei.com>
        <ZO1E8i4i0QU2MANZ@aschofie-mobl2>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Hi Alison,

> > > +	/*
> > > +	 * No alignment. Attempt a 3-way split that removes the part of
> > > +	 * the resource the region occupied, and then creates new soft
> > > +	 * reserved resources for the leading and trailing addr space.
> > > +	 * adjust_resource() will stop the attempt if there are any
> > > +	 * child resources.
> > > +	 */
> > > +
> > > +	/* Save the original soft reserved resource params before adjusting */
> > > +	new_start = soft->start;
> > > +	new_end = soft->end;
> > > +	parent = soft->parent;
> > > +	flags = soft->flags;
> > > +
> > > +	rc = adjust_resource(soft, start, end - start);
> > > +	if (rc) {
> > > +		dev_dbg(&cxlr->dev,
> > > +			"cannot adjust soft reserved resource %pr\n", soft);
> > > +		return;
> > > +	}
> > > +	rc = remove_resource(soft);
> > > +	if (rc)
> > > +		dev_warn(&cxlr->dev,
> > > +			 "cannot remove soft reserved resource %pr\n", soft);  
> > 
> > I'd like a comment on this first bit.  Why adjust a resource only to throw it
> > away?  
> 
> I intended to give the big picture in the block comment above. Scroll up
> and see /* No alignment... 
> 
> Did you overlook that or do you want more explanation or something else?

Overlooked it as you guessed.  Makes sense though it's ugly that we need
that comment.  Maybe worth explicitly checking that there are no children
rather than using a side effect of adjust_resource()?
Might need a new generic resource_has_children() check or similar.

Jonathan
> 
> Thanks,
> Alison
> 
> > 
> >   
> > > +
> > > +	rc = add_soft_reserved(parent, new_start, start - new_start, flags);
> > > +	if (rc)
> > > +		dev_warn(&cxlr->dev,
> > > +			 "cannot add new soft reserved resource at %pa\n",
> > > +			 &new_start);
> > > +
> > > +	rc = add_soft_reserved(parent, end + 1, new_end - end, flags);
> > > +	if (rc)
> > > +		dev_warn(&cxlr->dev,
> > > +			 "cannot add new soft reserved resource at %pa + 1\n",
> > > +			 &end);
> > > +}
> > > +
> > >  static void cxl_region_iomem_release(struct cxl_region *cxlr)
> > >  {
> > >  	struct cxl_region_params *p = &cxlr->params;
> > > +	struct resource *parent, *res = p->res;
> > > +	resource_size_t start, end;
> > >  
> > >  	if (device_is_registered(&cxlr->dev))
> > >  		lockdep_assert_held_write(&cxl_region_rwsem);
> > > -	if (p->res) {
> > > -		/*
> > > -		 * Autodiscovered regions may not have been able to insert their
> > > -		 * resource.
> > > -		 */
> > > -		if (p->res->parent)
> > > -			remove_resource(p->res);
> > > -		kfree(p->res);
> > > -		p->res = NULL;
> > > +	if (!res)
> > > +		return;
> > > +	/*
> > > +	 * Autodiscovered regions may not have been able to insert their
> > > +	 * resource. If a Soft Reserved parent resource exists, try to
> > > +	 * remove that also.
> > > +	 */
> > > +	if (p->res->parent) {
> > > +		parent = p->res->parent;
> > > +		start = p->res->start;
> > > +		end = p->res->end;
> > > +		remove_resource(p->res);
> > > +		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags) &&
> > > +		    parent->desc == IORES_DESC_SOFT_RESERVED)
> > > +			remove_soft_reserved(cxlr, parent, start, end);
> > >  	}
> > > +
> > > +	kfree(p->res);
> > > +	p->res = NULL;
> > >  }
> > >  
> > >  static int free_hpa(struct cxl_region *cxlr)  
> >   

