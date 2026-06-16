Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6A40E8EF
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600067; cv=none; b=B1n8BfKcQILVOTmoR9UKDP4wRQRTkqK4QRFouR/xICVGAunBE0rb4JnTjytOMT6YwsQEzvFOLbrtXfHkkp79gxAaw0tkOrOqrHu40P1Kr4nSglLCGqZqOc9gSXxOiI+nXOveGY5HcTdnkn4MeYgQEsMM3l/1RnoK2uQgvkT+e1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600067; c=relaxed/simple;
	bh=9r+RJLp6fhfyf2tAt4+Bflg63dsgtafgTE0cw+Gs7sc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDjEMdMLwHsVLvOxeazz2lMs7HEHrMC3u8U6/aho4Beg5hh2cYvUpjtURn8nFHie5qF3JBMX/ENUgxvr7M1vIwJNvgPnKyiIvDksLB7oacWd5vvalS6F2WuCsxhepvOwDAK8/vMFJv5TpryE1hVmYsSYOhzOaM6NN1Dyz/2Cz4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTcmlKWf; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTcmlKWf"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1397ad67f5eso3007690c88.0
        for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781600065; x=1782204865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pyIsPkd+pxheUlrd2cqTqR5lUJlcL53tZ2xMuuCyndo=;
        b=gTcmlKWfqWqmEgsOfQ31ztcCJ2jA9tVP5EZJDVDq9O4RjRifsbou8PkubfFVqtwnjI
         szHw87NJOpFeo7gfMCqSupdOK2XVOxZjTM+0srnIQt3Dff+QcN9Xaj9BW2nQbSzik/jv
         l74ZuDihGeJrNqKKcTT65KhDd1ZJ9oecqhkUFMTH6e6XgFycSYOSbv/iduBl9rNbBr30
         ngqqN5D8jha5hV6D6o9StCnI1Q+jy6925aJvDJdFb6+HSB368crRaECy/aBBc1BkynOd
         30hdGBQgyAMP84buRHqu+Y2HOhkQFSNF24m3M+pSPe85xCiTLt5HeoEH55XAd1+i6X1f
         zbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781600065; x=1782204865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyIsPkd+pxheUlrd2cqTqR5lUJlcL53tZ2xMuuCyndo=;
        b=KrHBj0FT5jNa6wJnPJn4+HVuitrfCCXmN4GOO+G2ediST1stAboBJvZmgWodt3D7V/
         6CzDZP9LqMTfmlqYFxTsk68P2r6kNtsGKz7wuonWF8X8GOXvkkj7qJBu6D4KZGkn2VPe
         PlsXjIm0/j9ZuOZsHV9JzgjDRjkLypxtfEhewrgNUbQRkpDEt4Vnskye1t8o+UVsdyAJ
         l4FWaljtQrMjM+yfTMEfaTygnqZGb9aYvwbsfHpiS3n3j/NckpyuAegK3O3vqaDU/Xt4
         80sUVZqAvzWLcX7VGLH3j7S9ENUu6+wLm/YKCHakfQYhG6s5ocYEVUrCB/MkeZ6ILDdo
         ZHUA==
X-Forwarded-Encrypted: i=1; AFNElJ/ViY1aIvismrNv5MUpk8C25dnE7n5sfRxZPm5ouKXAnv5STivjO0EVIQz6BcSueMPlRT+LVWFOdLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZ9KD5a5SlqmEpd+4yhXZRwmlmZty0ZYqpZUGrU/IsgFOggzu
	zye2jIAu7VFv7GqYr1cEwKEFMh+POjQBqU/bk0gUJRVqALpEQbb/pDAY
X-Gm-Gg: Acq92OGNjaj1FIJN/hLWS0/qdcSHOWRncapeTWadcBPkt7y7lYcBJJoGmc1SdxZuFNl
	jMmvuG7chssW4TntXH/YkwpRLTuBrpYEB5ZxhGAufq5OpbKDNUnsWSLScF+4BvF4rTvCbpZiJrD
	ANiCFdaatjh35o3qLr8yIB7U67DeWMeBrBetLQYsR0Svo0dbL36SyuVMI2unHDmjxJdyddZrTLS
	WOp/Cahp0kDdxflgf9bAXrgUjxcq8I8Hr24ZMNndKf+2FwS9Ql9+l7tzXyS2NaAX1bcrcfZV/JZ
	5/p9zxQzdAKg8c80Ki5HIlFFaK4xsWdOg+dL+YWv9q4fCXWzWWMx0YTY1d3CvjrdXF6Cx2hp5aM
	EMXfWyQhlD+3tUC4py7Wv/fgEsfQFt4T3CYZgK9tZEPY0YbcrxAYXsSUCxWPmgb4UIwnho4RQFN
	JRGp8Zk8SbsKZk6kwjFsgtxkCnRhT96+RslRfawEm+r0N6oYKNMSA/mzdolbXlq+09yR4tbTi3C
	83yWdA=
X-Received: by 2002:a05:7022:3d11:b0:12d:cbce:5fb7 with SMTP id a92af1059eb24-13985e95cebmr1267878c88.6.1781600064926;
        Tue, 16 Jun 2026 01:54:24 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b96d6c4sm13284720c88.9.2026.06.16.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 01:54:24 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 16 Jun 2026 01:54:23 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 25/31] dax/bus: Reject resize on DC dax devices and
 enforce 0-size creation
Message-ID: <ajEPP0E9idMEufTN@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <9c73377182f19e86e2cc939ddf0184d5d85581f9.1779528761.git.anisa.su@samsung.com>
 <8de1e66c-14a2-4933-9c34-be1d1335a36c@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8de1e66c-14a2-4933-9c34-be1d1335a36c@intel.com>

On Fri, May 29, 2026 at 10:16:10AM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > A DC dax device's size is determined by the extents that back it, not by
> > the user.  DCD extents are all-or-nothing, so partial shrink is just as
> > illegal as growing.  Enforce that on the size and creation paths:
> > 
> >   * size_store: any non-zero resize on a DC region returns -EOPNOTSUPP.
> >     The sole exception is size=0, which daxctl destroy-device writes to
> >     return every claimed extent to the region's available pool before
> >     the device's name is written to the region's 'delete' attribute.
> >   * __devm_create_dev_dax: a DC dax device must be created at size 0.
> >     Non-zero data->size on a DC region returns -EINVAL with a clear
> >     message.
> > 
> > The resize machinery (dev_dax_shrink, adjust_ok, dev_dax_resize_static,
> > dev_dax_resize) learns to walk the right parent — dax_region->res for
> > static regions, the dax_resource->res for DC regions claimed via
> > uuid_store — so shrink-to-0 correctly releases each extent's child
> > resource rather than the region's.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Just a nit below.
> 
> 
> > 
> > ---
> > Changes:
> > [anisa: split out from the original "Surface dc_extents" commit;
> >  DC-aware resize policy only.]
> > ---
> >  drivers/dax/bus.c | 46 +++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 35 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 1d6f82920be6..c030eb103ad0 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -1136,7 +1136,8 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
> >  	int i;
> >  
> >  	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
> > -		struct range *range = &dev_dax->ranges[i].range;
> > +		struct dev_dax_range *dev_range = &dev_dax->ranges[i];
> > +		struct range *range = &dev_range->range;
> >  		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
> >  		struct resource *adjust = NULL, *res;
> >  		resource_size_t shrink;
> > @@ -1152,6 +1153,10 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
> >  			continue;
> >  		}
> >  
> > +		/*
> > +		 * Partial shrink: forbidden on DC regions, so dev_range
> > +		 * here must belong to a static device.
> > +		 */
> >  		for_each_dax_region_resource(dax_region, res)
> >  			if (strcmp(res->name, dev_name(dev)) == 0
> >  					&& res->start == range->start) {
> > @@ -1195,19 +1200,21 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
> >  }
> >  
> >  /**
> > - * dev_dax_resize_static - Expand the device into the unused portion of the
> > - * region. This may involve adjusting the end of an existing resource, or
> > - * allocating a new resource.
> > + * __dev_dax_resize - Expand the device into the unused portion of the region.
> > + * This may involve adjusting the end of an existing resource, or allocating a
> > + * new resource.
> >   *
> >   * @parent: parent resource to allocate this range in
> >   * @dev_dax: DAX device to be expanded
> >   * @to_alloc: amount of space to alloc; must be <= space available in @parent
> > + * @dax_resource: if dc; the parent resource
> >   *
> >   * Return the amount of space allocated or -ERRNO on failure
> >   */
> > -static ssize_t dev_dax_resize_static(struct resource *parent,
> > -				     struct dev_dax *dev_dax,
> > -				     resource_size_t to_alloc)
> > +static ssize_t __dev_dax_resize(struct resource *parent,
> > +				struct dev_dax *dev_dax,
> > +				resource_size_t to_alloc,
> > +				struct dax_resource *dax_resource)
> >  {
> >  	struct resource *res, *first;
> >  	int rc;
> > @@ -1215,7 +1222,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
> >  	first = parent->child;
> >  	if (!first) {
> >  		rc = alloc_dev_dax_range(parent, dev_dax,
> > -					   parent->start, to_alloc, NULL);
> > +					   parent->start, to_alloc,
> > +					   dax_resource);
> >  		if (rc)
> >  			return rc;
> >  		return to_alloc;
> > @@ -1229,7 +1237,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
> >  		if (res == first && res->start > parent->start) {
> >  			alloc = min(res->start - parent->start, to_alloc);
> >  			rc = alloc_dev_dax_range(parent, dev_dax,
> > -						 parent->start, alloc, NULL);
> > +						 parent->start, alloc,
> > +						 dax_resource);
> >  			if (rc)
> >  				return rc;
> >  			return alloc;
> > @@ -1253,7 +1262,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
> >  				return rc;
> >  			return alloc;
> >  		}
> > -		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc, NULL);
> > +		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc,
> > +					 dax_resource);
> >  		if (rc)
> >  			return rc;
> >  		return alloc;
> > @@ -1264,6 +1274,13 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
> >  	return 0;
> >  }
> >  
> > +static ssize_t dev_dax_resize_static(struct dax_region *dax_region,
> > +				     struct dev_dax *dev_dax,
> > +				     resource_size_t to_alloc)
> > +{
> > +	return __dev_dax_resize(&dax_region->res, dev_dax, to_alloc, NULL);
> > +}
> > +
> >  static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >  		struct dev_dax *dev_dax, resource_size_t size)
> >  {
> > @@ -1277,6 +1294,8 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >  		return -EBUSY;
> >  	if (size == dev_size)
> >  		return 0;
> > +	if (size != 0 && is_dynamic(dax_region))
> > +		return -EOPNOTSUPP;
> >  	if (size > dev_size && size - dev_size > avail)
> >  		return -ENOSPC;
> >  	if (size < dev_size)
> > @@ -1288,7 +1307,7 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >  		return -ENXIO;
> >  
> >  retry:
> > -	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
> > +	alloc = dev_dax_resize_static(dax_region, dev_dax, to_alloc);
> >  	if (alloc <= 0)
> >  		return alloc;
> >  	to_alloc -= alloc;
> > @@ -1674,6 +1693,11 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
> >  	struct device *dev;
> >  	int rc;
> >  
> > +	if (is_dynamic(dax_region) && data->size) {
> > +		dev_err(parent, "DC DAX region devices must be created initially with 0 size");
> 
> Needs \n
> 
Fixed!

Thanks,
Anisa
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> >  	dev_dax = kzalloc_obj(*dev_dax);
> >  	if (!dev_dax)
> >  		return ERR_PTR(-ENOMEM);
> 
