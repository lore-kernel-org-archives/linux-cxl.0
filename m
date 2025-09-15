Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C921E087;
	Mon, 15 Sep 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931963; cv=none; b=lbWm/1LsKZbmoGTdW1Ea4MYyp+0KIT2uWOusUk0im1Hj727HhSuEE6J5kyEoyRFuh+YwyhEJo0FxD4Y16pM9DFn+iQObjFCQmHj3RNjnCNBQXS4Q8KykGRonunKZHZddrntSXQ3dxM1rNKR5MSJsNAgtu+W7ZkOdR+PNPAFTVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931963; c=relaxed/simple;
	bh=1rMCkbFca6GNo1PacHKi3ubbff6y0fu/SFkUk0sbNvY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5gQe09GIlNd4tVZXjJUTaXVQqrVSRKdu0ZjWrh18SDumFeZH9q5x0jkwEbqlXHcqopOLnmbL5WapaCiCc1mj2bDyBKbAlQ0aHKWYgd1fbZ198k4QEl1Rzc9yezwQlfLQwoi91AsAg3Och2W8VXk/Lnjmkynxm+PjDn0CtD74Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQLk630Bcz6K9JP;
	Mon, 15 Sep 2025 18:24:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B7831402FB;
	Mon, 15 Sep 2025 18:25:57 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 12:25:56 +0200
Date: Mon, 15 Sep 2025 11:25:55 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 03/11] cxl/region: Rename misleading variable name
 @hpa to @range
Message-ID: <20250915112555.00003854@huawei.com>
In-Reply-To: <aMe_6Olzsx9iYxIO@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
	<20250912144514.526441-4-rrichter@amd.com>
	<60f05a02-6a0a-4616-a2f2-d7ae5709d94e@intel.com>
	<aMe_6Olzsx9iYxIO@rric.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 15 Sep 2025 09:27:36 +0200
Robert Richter <rrichter@amd.com> wrote:

> On 12.09.25 10:33:30, Dave Jiang wrote:
> > 
> > 
> > On 9/12/25 7:45 AM, Robert Richter wrote:  
> > > @hpa is actually a @range, rename variables accordingly.  
> > 
> > it's a range of HPA right? May as well call it 'hpa_range' to distinguish from 'dpa_range' or 'spa_range'  
> 
> To me this is ok as it is locally used only in the functions. I used
> the short version to not hit the 80 char line limit in some of the
> statements for readability. Range is most of the time HPA unless for
> special cases, which use a prefix then. It also becomes clear viewed
> in context, e.g.
> 
> 	 range = &cxld->hpa_range;
> 
> Thus, I rather would like to not change that.

I'm with Dave on this one.  Better to have some slightly long lines
and avoid any potential confusion.

Jonathan
> 
> -Robert
> 
> >   
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > ---
> > >  drivers/cxl/core/region.c | 29 +++++++++++++++--------------
> > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 777d04870180..13113920aba7 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -3367,9 +3367,9 @@ static int match_decoder_by_range(struct device *dev, const void *data)
> > >  }
> > >  
> > >  static struct cxl_decoder *
> > > -cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> > > +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *range)
> > >  {
> > > -	struct device *cxld_dev = device_find_child(&port->dev, hpa,
> > > +	struct device *cxld_dev = device_find_child(&port->dev, range,
> > >  						    match_decoder_by_range);
> > >  
> > >  	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
> > > @@ -3382,14 +3382,14 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> > >  	struct cxl_port *port = cxled_to_port(cxled);
> > >  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> > >  	struct cxl_decoder *root, *cxld = &cxled->cxld;
> > > -	struct range *hpa = &cxld->hpa_range;
> > > +	struct range *range = &cxld->hpa_range;
> > >  
> > > -	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa);
> > > +	root = cxl_port_find_switch_decoder(&cxl_root->port, range);
> > >  	if (!root) {
> > >  		dev_err(cxlmd->dev.parent,
> > >  			"%s:%s no CXL window for range %#llx:%#llx\n",
> > >  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> > > -			cxld->hpa_range.start, cxld->hpa_range.end);
> > > +			range->start, range->end);
> > >  		return NULL;
> > >  	}
> > >  
> > > @@ -3458,7 +3458,7 @@ static int __construct_region(struct cxl_region *cxlr,
> > >  {
> > >  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> > >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > > -	struct range *hpa = &cxled->cxld.hpa_range;
> > > +	struct range *range = &cxled->cxld.hpa_range;
> > >  	struct cxl_region_params *p;
> > >  	struct resource *res;
> > >  	int rc;
> > > @@ -3474,13 +3474,13 @@ static int __construct_region(struct cxl_region *cxlr,
> > >  	}
> > >  
> > >  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
> > > -	cxlr->hpa_range = *hpa;
> > > +	cxlr->hpa_range = *range;
> > >  
> > >  	res = kmalloc(sizeof(*res), GFP_KERNEL);
> > >  	if (!res)
> > >  		return -ENOMEM;
> > >  
> > > -	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
> > > +	*res = DEFINE_RES_MEM_NAMED(range->start, range_len(range),
> > >  				    dev_name(&cxlr->dev));
> > >  
> > >  	rc = cxl_extended_linear_cache_resize(cxlr, res);
> > > @@ -3559,11 +3559,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> > >  }
> > >  
> > >  static struct cxl_region *
> > > -cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> > > +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *range)
> > >  {
> > >  	struct device *region_dev;
> > >  
> > > -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> > > +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, range,
> > >  				       match_region_by_range);
> > >  	if (!region_dev)
> > >  		return NULL;
> > > @@ -3573,7 +3573,7 @@ cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> > >  
> > >  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> > >  {
> > > -	struct range *hpa = &cxled->cxld.hpa_range;
> > > +	struct range *range = &cxled->cxld.hpa_range;
> > >  	struct cxl_region_params *p;
> > >  	bool attach = false;
> > >  	int rc;
> > > @@ -3584,12 +3584,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> > >  		return -ENXIO;
> > >  
> > >  	/*
> > > -	 * Ensure that if multiple threads race to construct_region() for @hpa
> > > -	 * one does the construction and the others add to that.
> > > +	 * Ensure that if multiple threads race to construct_region()
> > > +	 * for the HPA range one does the construction and the others
> > > +	 * add to that.
> > >  	 */
> > >  	mutex_lock(&cxlrd->range_lock);
> > >  	struct cxl_region *cxlr __free(put_cxl_region) =
> > > -		cxl_find_region_by_range(cxlrd, hpa);
> > > +		cxl_find_region_by_range(cxlrd, range);
> > >  	if (!cxlr)
> > >  		cxlr = construct_region(cxlrd, cxled);
> > >  	mutex_unlock(&cxlrd->range_lock);  
> >   

