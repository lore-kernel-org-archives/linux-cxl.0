Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B117578
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124386; cv=none; b=pb+ySlKz5jRxiF6vorgYm5C+F3jNvHtHyaasp/bHXq6O25aRJ04a5Xrc6OLmcB/QAJSmwz/3ojJjjAfb1JALxd3J+5dGUfJNoHfLURw3X1yRXwOQLA/XqDWnlETonCYDX1E3urbkFO8BQF7kQ6wbrvZa6IvQBtQAbhypD+R+a7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124386; c=relaxed/simple;
	bh=jJtwlEYsIdOSVQdsrOyvEkRHE5ECFNhrbWqB4wlCyaI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQB01acDnxk3yjDT72cXCeBKFYHoRRkst7Ktgp20U92DoPVzbwi9KAuAbg7Dsz4PewDez9mimIQc+LGqrTT9RpQlswA78ui2nlQ1BuGVDzro85oZPvIy45jluS1GRuDTbdCl5naEjlRkLpx85ew/dbeOJfKpCrQOx77wHETxMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzDvm75Qzz67nqN;
	Wed, 12 Jun 2024 00:41:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E9DAA1401DC;
	Wed, 12 Jun 2024 00:46:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 17:46:19 +0100
Date: Tue, 11 Jun 2024 17:46:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Yao Xingtao <yaoxt.fnst@fujitsu.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jim.harris@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6] cxl/region: check interleave capability
Message-ID: <20240611174618.000040ff@Huawei.com>
In-Reply-To: <d7416f60-28fa-4848-a0cc-61431528db8a@intel.com>
References: <20240611021511.35315-1-yaoxt.fnst@fujitsu.com>
	<d7416f60-28fa-4848-a0cc-61431528db8a@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >  drivers/cxl/core/hdm.c    | 10 +++++
> >  drivers/cxl/core/region.c | 89 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h         |  2 +
> >  drivers/cxl/cxlmem.h      |  1 +
> >  4 files changed, 102 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 7d97790b893d..5b7dff19bbfa 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -52,6 +52,11 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
> >  	struct cxl_dport *dport = NULL;
> >  	int single_port_map[1];
> >  	unsigned long index;
> > +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> > +
> > +	/* allow all the interleave capabilities for passthrough decoder */
> > +	cxlhdm->interleave_mask = GENMASK(14, 8);
> > +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
> >  
> >  	cxlsd = cxl_switch_decoder_alloc(port, 1);
> >  	if (IS_ERR(cxlsd))
> > @@ -79,6 +84,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >  		cxlhdm->interleave_mask |= GENMASK(11, 8);
> >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> >  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> > +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);  
> 
> Should define a mask for this. Probably should have defined masks for all of the open coded BIT() sets.

I don't agreed.  These bits are logically independent specifying each
supported value of interleave ways.
Put them under a define and I think you end up with less readable code.

> 
> > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> > +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
> > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> > +		cxlhdm->iw_cap_mask |= BIT(16);
> >  }



