Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27232F2702;
	Wed, 16 Jul 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661937; cv=none; b=pNVlqrhtOWdTXtpqqDAuzcOzMm6lowqG0Og3oyXIyUbWjgME7l9I6cFu67TA7+UzO/cM2f9xQh7Pv9vUWjaSawB3ChCjaEHU5t6hgu2kOHV+69W9Dyy3a1/PwOanVN04WE4FKcFkDFl0/CBPMG4IBLmYF5+WnQaD3zgtejqA2Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661937; c=relaxed/simple;
	bh=Imqn83baOky6c8t+GEo3fMlMKkLIRiNV6oosALBDxag=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGv8fmEDB6GIt+J33iP793PayQtSFt/9/8ohMrLRawchmGw8Zrf8a2z0f2EjIFknYeSXX+tbE3kurjrpjwKsxhTp1JIj56bq0uH6/FSnnhAZZQT7Fis2ULvPnn+NDqo1DSB4uZhWKcpz9f83iWe2PIp1QriuYiTP2OKM53+sxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhsj20g3Vz6L4xm;
	Wed, 16 Jul 2025 18:28:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7673914044F;
	Wed, 16 Jul 2025 18:32:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 12:32:09 +0200
Date: Wed, 16 Jul 2025 11:32:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v3 7/8] cxl/region: Consolidate
 cxl_decoder_kill_region() and cxl_region_detach()
Message-ID: <20250716113208.00001c7d@huawei.com>
In-Reply-To: <6876856d329fb_2ead10062@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
	<20250711234932.671292-8-dan.j.williams@intel.com>
	<20250715165607.000036c4@huawei.com>
	<6876856d329fb_2ead10062@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 15 Jul 2025 09:44:29 -0700
dan.j.williams@intel.com wrote:

> Jonathan Cameron wrote:
> > On Fri, 11 Jul 2025 16:49:31 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > Both detach_target() and cxld_unregister() want to tear down a cxl_region
> > > when an endpoint decoder is either detached or destroyed.
> > > 
> > > When a region is to be destroyed cxl_region_detach() releases
> > > cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.
> > > 
> > > This "reverse" locking pattern is difficult to reason about, not amenable
> > > to scope-based cleanup, and the minor differences in the calling context of
> > > detach_target() and cxld_unregister() currently results in the
> > > cxl_decoder_kill_region() wrapper.
> > > 
> > > Introduce cxl_decoder_detach() to wrap a core __cxl_decoder_detach() that
> > > serves both cases. I.e. either detaching a known position in a region
> > > (interruptible), or detaching an endpoint decoder if it is found to be a
> > > member of a region (uninterruptible).
> > > 
> > > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > One query inline about what I think is a change in when a reference count is
> > held on the region device.  I'm struggling to reason about whether that change
> > would have always been safe or if there is another change here that makes
> > it fine now?
> > 
> > (or whether I'm just misreading the change).
> > 
> > Jonathan  
> [..]
> >   
> > > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > > index eb46c6764d20..087a20a9ee1c 100644
> > > --- a/drivers/cxl/core/port.c
> > > +++ b/drivers/cxl/core/port.c
> > > @@ -2001,12 +2001,9 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, "CXL");
> > >  
> > >  static void cxld_unregister(void *dev)
> > >  {
> > > -	struct cxl_endpoint_decoder *cxled;
> > > -
> > > -	if (is_endpoint_decoder(dev)) {
> > > -		cxled = to_cxl_endpoint_decoder(dev);
> > > -		cxl_decoder_kill_region(cxled);
> > > -	}
> > > +	if (is_endpoint_decoder(dev))
> > > +		cxl_decoder_detach(NULL, to_cxl_endpoint_decoder(dev), -1,
> > > +				   DETACH_INVALIDATE);
> > >  
> > >  	device_unregister(dev);
> > >  }
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 2a97fa9a394f..4314aaed8ad8 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -2135,27 +2135,43 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > >  	return 0;
> > >  }
> > >  
> > > -static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> > > +static struct cxl_region *
> > > +__cxl_decoder_detach(struct cxl_region *cxlr,
> > > +		     struct cxl_endpoint_decoder *cxled, int pos,
> > > +		     enum cxl_detach_mode mode)
> > >  {
> > > -	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
> > > -	struct cxl_region *cxlr = cxled->cxld.region;
> > >  	struct cxl_region_params *p;
> > > -	int rc = 0;
> > >  
> > >  	lockdep_assert_held_write(&cxl_region_rwsem);
> > >  
> > > -	if (!cxlr)
> > > -		return 0;
> > > +	if (!cxled) {
> > > +		p = &cxlr->params;
> > >  
> > > -	p = &cxlr->params;
> > > -	get_device(&cxlr->dev);  
> > 
> > This is a fairly nasty patch to unwind and fully understand but
> > I'm nervous that in the existing we have a get_device(&cxlr->dev)
> > before potential cxl_region_decode_reset(cxlr, ...)
> > and now we don't.  I'm not sure if that is a real problem though,
> > it just makes me nervous.  
> 
> The reference count is not for cxl_region_decode_reset(). The reference
> count is to keep the region from being freed when the lock is dropped so
> that device_release_driver() can see if it has work to do.
> 
> The lookup result from endpoint decoder to region is only stable while
> the lock is held and the region could be freed at any point after that.
> The pin holds that off until we are done with the potential follow-on
> work from detaching a decoder.
> 
> The reference is not taken in other paths like region sysfs because
> userspace activity in sysfs attributes holds off attribute
> unregistration.
Fair enough and thanks for the explanation.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 

