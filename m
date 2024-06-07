Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF819B59B
	for <linux-cxl@vger.kernel.org>; Fri,  7 Jun 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782910; cv=none; b=Z6KiNDIzMhNCycfQuzEfe/HEcN9wW9TBA72zruGT50b32lVU1rfuesO8Wvxe2agSIuTry1MZONPbVdgC9U6xgxHUjbOXRqLUqrHZAeztnHLweOEkIc4ZnoPXje+qdHND3gz/nJm/8Z1Fw0sC+xaKENzrDb0E2wtO7c7DqSxs6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782910; c=relaxed/simple;
	bh=qKBHzndA0DYoyjGD/HSih19vaq6bMi96QpYfE5nUW38=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/WOAS2VD1VKFMqxkSZ+fL9FD3sp5lFYcGGkrqEGKxlaOW0qfQddD10n05nFaUWXkuf/7jOlXuVm2AulReO1Ps/8D9xDyBfjJVCUfcywpJNvEHWWe+Qhy2BbO77YhK/Q4qkjNAhCLMfxq40T1Fv3ER5t0vTbXleBCwNZ0Uv1CsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwpd94nBCz6K5s9;
	Sat,  8 Jun 2024 01:50:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BD978140A70;
	Sat,  8 Jun 2024 01:55:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 18:55:04 +0100
Date: Fri, 7 Jun 2024 18:55:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] cxl/core: Rename cxl_trace_hpa() to
 cxl_translate()
Message-ID: <20240607185503.00005f3a@Huawei.com>
In-Reply-To: <ZmNHRrzl2tJvR2SW@aschofie-mobl2>
References: <cover.1715192606.git.alison.schofield@intel.com>
	<27686c91cf4f8b09991534708f6ad2dfc2443af1.1715192606.git.alison.schofield@intel.com>
	<20240607154025.0000786d@Huawei.com>
	<ZmNHRrzl2tJvR2SW@aschofie-mobl2>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 7 Jun 2024 10:45:42 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Fri, Jun 07, 2024 at 03:40:25PM +0100, Jonathan Cameron wrote:
> > On Wed,  8 May 2024 11:47:50 -0700
> > alison.schofield@intel.com wrote:
> >   
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > Although cxl_trace_hpa() is used to populate TRACE EVENTs with HPA
> > > addresses, the work it performs is a translation (dpa->hpa), not a
> > > trace. Rename it. Since this is the only translate work in CXL,
> > > drop the _hpa suffix in the rename.
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> > 
> > Maybe makes some sense to keep the direction in the name?
> > 
> > I can see for things like PPR we may need to go HPA to DPA as
> > it'll be based on error counts that may be reported in HPA.
> > 
> > So Friday bikeshedding time. 
> > cxl_dpa_to_hpa()?  
> 
> Thanks for the review Jonathan!
> 
> Let's sync on the possible dpa->hpa->dpa use cases and then I'll
> weigh in on your bikeshedding.
> 
> Agree we need HPA->DPA support for userspace. User needs ability
> to find which device maps an HPA.
> 
> wrt PPR, do you think that is an in kernel need?
> If the PPR maintenance was done in response to a CXL event, the DPA
> is already in the event trace along with the HPA so I wouldn't expect
> that a lookup is needed, at least not within the kernel.

Might be a synchronous poison event that ends up
triggering thing. And for that we'll be lucky to get any useful
info beyond an HPA.

I've only started thinking about this in the last few days, so
not 100% sure yet.

Given PPR can I think interrupt data flow we need to be very
careful to mediate any attempt so to enable it at all will
need kernel support.  Whether the interface takes a DPA or
an HPA is an open question.  We'll see!

Jonathan

> 
> Your explicit cxl_dpa_to_hpa() name is good.
> 
> --Alison
> 
> 
> 
> > 
> >   
> > > ---
> > >  drivers/cxl/core/core.h   | 4 ++--
> > >  drivers/cxl/core/mbox.c   | 2 +-
> > >  drivers/cxl/core/region.c | 2 +-
> > >  drivers/cxl/core/trace.h  | 2 +-
> > >  4 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > > index 625394486459..8ceebd3b51d2 100644
> > > --- a/drivers/cxl/core/core.h
> > > +++ b/drivers/cxl/core/core.h
> > > @@ -28,12 +28,12 @@ int cxl_region_init(void);
> > >  void cxl_region_exit(void);
> > >  int cxl_get_poison_by_endpoint(struct cxl_port *port);
> > >  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
> > > -u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> > > +u64 cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> > >  		  u64 dpa);
> > >  
> > >  #else
> > >  static inline u64
> > > -cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
> > > +cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd, u64 dpa)
> > >  {
> > >  	return ULLONG_MAX;
> > >  }
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 2626f3fff201..edc54a1ca298 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -878,7 +878,7 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> > >  		dpa = le64_to_cpu(evt->common.phys_addr) & CXL_DPA_MASK;
> > >  		cxlr = cxl_dpa_to_region(cxlmd, dpa);
> > >  		if (cxlr)
> > > -			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> > > +			hpa = cxl_translate(cxlr, cxlmd, dpa);
> > >  
> > >  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> > >  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 00a9f0eef8dd..245edf748906 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -2797,7 +2797,7 @@ static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
> > >  	return hpa;
> > >  }
> > >  
> > > -u64 cxl_trace_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> > > +u64 cxl_translate(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
> > >  		  u64 dpa)
> > >  {
> > >  	struct cxl_region_params *p = &cxlr->params;
> > > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > > index 07a0394b1d99..6925a6a31f01 100644
> > > --- a/drivers/cxl/core/trace.h
> > > +++ b/drivers/cxl/core/trace.h
> > > @@ -704,7 +704,7 @@ TRACE_EVENT(cxl_poison,
> > >  		if (cxlr) {
> > >  			__assign_str(region, dev_name(&cxlr->dev));
> > >  			memcpy(__entry->uuid, &cxlr->params.uuid, 16);
> > > -			__entry->hpa = cxl_trace_hpa(cxlr, cxlmd,
> > > +			__entry->hpa = cxl_translate(cxlr, cxlmd,
> > >  						     __entry->dpa);
> > >  		} else {
> > >  			__assign_str(region, "");  
> >   
> 

