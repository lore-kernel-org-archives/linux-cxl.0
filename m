Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803B171064
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874131; cv=none; b=KruPYZP38OuJebJb6Eb2e8P1iZoU/RFRCp5D1IhOvqyQPAQsuAndoaTdJkz1JmuY5zyCh0LZkZtD0KQs9E8j+Y2r5hEycGlrUbSvpHotUHVi7yWuE5pPvQoAP6rshkD9s55PH9eBTvmXMgTKLuRcy7pxSdmPKctc1TNGI/ZdAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874131; c=relaxed/simple;
	bh=4qxXjTnB7CUpxJJs4HVQTE1GHqr13zcVZymxbeN0Jdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMmVXDmtW0fRkLsyaNfZUjFeTFrmMLHNQ39DwLCbwSPnPbjpTx7NBj2NQ3fMdog2Ep7EADgOqxCnDEd9dMHxZrRQniWf0vlHijPFIoKLoofZWHxdeVXzHo4cDonaJhD8LfI6rNizR75Wdq7/I9k8glMoEapEQH3b5JRQAKaNDhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuYBLRw/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuYBLRw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719874129; x=1751410129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4qxXjTnB7CUpxJJs4HVQTE1GHqr13zcVZymxbeN0Jdo=;
  b=WuYBLRw/bYbufjib/Ju+s/4y+oz0I1zdb+b1T7pvb+KmiHx7e4W/8PgG
   h762Ujln/1arteZweFsaHQ7pHhpffFJHCq67G/8TeVGrAiqXM0eBFD1iy
   nGqZf4xhEZ/OYxNbDZnymIdz6oq2Ip8FqWfZPi82iyHbiKSf6ZbCWfQC3
   eOZrDxeQU9NLvf1bRFlFdAN0EMgSt7VlnT2yhc6sPXUi7gjWwefS1MQO6
   P0o8VwIVaZLgvlfCsZdBswwhgVSUEM8Y8VO6KGjuUUZI7Bl3ZiRJSSmzf
   M54uaCsE5+gN1GRPJg0y0XJe99frtmDaMMtGQjmAgIoP+su/Qx8bRqvE+
   g==;
X-CSE-ConnectionGUID: wsvs2rksTwSPLzM4VGAHtQ==
X-CSE-MsgGUID: rvR/Kd4LR3mQfLkayRG9qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27645943"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="27645943"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 15:48:48 -0700
X-CSE-ConnectionGUID: FGjB5j/TS7Gaat/K6o3vpw==
X-CSE-MsgGUID: /TIDiDUMSBCeYhbnCfgBQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="50883596"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.105.13])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 15:48:46 -0700
Date: Mon, 1 Jul 2024 15:48:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Diego Garcia Rodriguez <diego.garcia.rodriguez@intel.com>
Subject: Re: [PATCH v3 2/4] cxl: Restore XOR'd position bits during address
 translation
Message-ID: <ZoMyTdZ1L4mWUwF5@aschofie-mobl2>
References: <cover.1719275633.git.alison.schofield@intel.com>
 <e36eabffe2c2e1a7611cf8ba9ba8bee435bceb1c.1719275633.git.alison.schofield@intel.com>
 <3568032.dWV9SEqChM@fdefranc-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3568032.dWV9SEqChM@fdefranc-mobl3>

On Mon, Jul 01, 2024 at 11:28:24AM +0200, Fabio M. De Francesco wrote:
> On Tuesday, June 25, 2024 2:55:53 AM GMT+2 alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> 
> Hi Alison,
> 
> Below I have two questions... 
> 
Thanks for reviewing -

snip

> > 
> > A cxl-test unit test of address translations is in upstream review.
> 
> Would it be helpful to provide a link to the test?

Sure. Will add lore link in next rev.

snip
> 
> > +

How about this comment:

	/* Predictable chunk guarantee only applies to modulo decodes */

> > +	if (!cxlrd->translate && (!cxl_is_hpa_in_chunk(hpa, cxlr, pos)))
> >  		return ULLONG_MAX;
> 
> I needed some time to understand this. It was not immediately clear why, for 
> XOR translations, this chunk check is skipped.
> 
> Wouldn't it be helpful to add a comment to explain why that check is skipped

Beyond that comment, I'd like readers to use git blame and look at
at the commit log:
	A second check confirms that the HPA is within an expected chunk
    based on the endpoints position in the region and the region
    granularity. An XOR decode disrupts the Modulo pattern making the
    chunk check useless.

I'm intentionally avoiding making the CXL driver and it's documentation
the source of XOR interleave education.

> 
> Thanks,
> 
> Fabio
> 
> > 
> >  	return hpa;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 603c0120cff8..3678235fc9ce 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -434,12 +434,14 @@ struct cxl_switch_decoder {
> >  struct cxl_root_decoder;
> >  typedef struct cxl_dport *(*cxl_calc_hb_fn)(struct cxl_root_decoder *cxlrd,
> >  					    int pos);
> > +typedef u64 (*cxl_translate_fn)(struct cxl_root_decoder *cxlrd, u64 hpa);
> >  
> >  /**
> >   * struct cxl_root_decoder - Static platform CXL address decoder
> >   * @res: host / parent resource for region allocations
> >   * @region_id: region id for next region provisioning event
> >   * @calc_hb: which host bridge covers the n'th position by granularity
> > + * @translate: decoder specific address translation function
> >   * @platform_data: platform specific configuration data
> >   * @range_lock: sync region autodiscovery by address range
> >   * @qos_class: QoS performance class cookie
> > @@ -449,6 +451,7 @@ struct cxl_root_decoder {
> >  	struct resource *res;
> >  	atomic_t region_id;
> >  	cxl_calc_hb_fn calc_hb;
> > +	cxl_translate_fn translate;
> >  	void *platform_data;
> >  	struct mutex range_lock;
> >  	int qos_class;
> > @@ -773,7 +776,8 @@ bool is_switch_decoder(struct device *dev);
> >  bool is_endpoint_decoder(struct device *dev);
> >  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> >  						unsigned 
> int nr_targets,
> > -						
> cxl_calc_hb_fn calc_hb);
> > +						
> cxl_calc_hb_fn calc_hb,
> > +						
> cxl_translate_fn translate);
> >  struct cxl_dport *cxl_hb_modulo(struct cxl_root_decoder *cxlrd, int pos);
> >  struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> >  						    
> unsigned int nr_targets);
> > 
> 
> 
> 
> 
