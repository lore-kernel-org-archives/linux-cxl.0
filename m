Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EA39FCE
	for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446250; cv=none; b=MBBAx/LbduBlmmsDlY6lNdUPXeMNRXwkTWZHqFBmni5IIQCugYEDFATMQTWsPuTSSSxd068j/V7tOkZKAv5sfk0UcgXr6LFYkgQ7LLvgUbQK2Yif6rjuqOgQeZpAx8fI2Y5v4BvRi5WyGb3w2Skzn4S0e3Aj2xxlZxhJDHApzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446250; c=relaxed/simple;
	bh=GAH4XF1NgNJRoMcFMyQvrp+y3baAeih2I7T2qtEfVYU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGKU+Yt3D+fnLGqGaBxXH0EoADzKVMknACQPn1fJy/9uhootesj8hBFLOPkl/pi/ZkMXmNSAO7vCgc7Qzf81q39KAXvh54vFPSKi5nGI7IE9ij/mqzyOwg8LjGRI6pWPovTqnnNEzQbE26LouRcZlkT0c0j6EHRmkFrI/wYQ0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbgbvG3y; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbgbvG3y"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so945092eec.1
        for <linux-cxl@vger.kernel.org>; Fri, 17 Apr 2026 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776446247; x=1777051047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BuTu8TP70mRfxnhCxquQpMyHJWTiwzWTYyU/WtqEMX8=;
        b=AbgbvG3yusJ74NFW+PtAgX+tHtpOoFk1ICncmdRwzEUtiSeY6R0gDUEswimG+oIHhv
         63A+cqse6/rH6LiyM27ljfA2bqik+u+LLdjNoIKOhYz+OjIQY4VyyC9SlX5FrFaZCCxw
         lVj0h3+OW0LML8LiaRYjlgVtxbTlS3cPh6eCr8aS6WqPwfjGyx+RJo8CefpJZp4IBk5x
         FDwyheQKIcZWmx0bakADgudnx2qnm+yNOM3aN9wvqs4bxvMByhFIEb43wtiNaUUt1qAf
         sw6/mtt0Ok80uFw+QzMKIvi9wyYOd2gK3vSnfz1ebioufOUKR7urUDmEak3ahrWztzCh
         QMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776446247; x=1777051047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuTu8TP70mRfxnhCxquQpMyHJWTiwzWTYyU/WtqEMX8=;
        b=Z4YYJP6XhBbmkGs5asxRqrW7tKfwlub689S04ux+30jZ/uy5AUIaz62yZxI1yxRQtu
         ZzxDfA+zDdQDvW3JwNH+1Wxxcu3KRWD6tI7GHnOQRughmq6axR+gnecS4gcoaJnUy7yF
         KfZGQXqQ5rApHE0ax/JuFfjHAeq4ZAdQxRFbpUQJ0us16hzAFpSQ8Bd0mVN5V8Dc03kw
         EdlgJGvszuEvZhheSh9inkzRuiwmCLSv1ylhhmSXR/HA0XlbhEWDL0qDYWBgkzJI8LUU
         7RLWiKVTpPLQK0PjVzvV6EZRxamVlJjKLjHGmPxDPlYKI3lEmlcqeEvGy+3c38wW0TqI
         XMig==
X-Forwarded-Encrypted: i=1; AFNElJ/jJf+hRuEK6mF04+X7EuZCTGYfT36jUsa6UCiCRIleSARWWhVeskJbNGYoNOYkfOk2nzncpzARQwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymWBOv/1vBrEUQ2A5pEM+kYqp+qoRcSy3gDr+peaT2/bfI1TXU
	YaKhYcVms+jhj3R4te532gf/AdleK9iX1wXFkmfnm4WpmzEVJu6Rki6W
X-Gm-Gg: AeBDiesQjMJvz/9Y8SI7uBMk9OVLDa7vZkFE3e0FUOpWpaxraLNESk2ybLQLqCadIpm
	YFdckVixYljWsLyIJLzzVqu1lkGMjUw9Fxwz9MSEPCobEGGMIR3Uq3FUu0vGr8bnz7UHVKhPctQ
	cdwE8qrQYGAPVlTKJUEMOlvg3ZAu2XA7gPlcSXTemjxLFqtIrSi4H5rQD/Ia/E3Tm4If7C345i2
	1/TTR5ybFy32u7suh8EB6aaqRZD3WC6q64cdgPHCOKQM5yv0BKBW6oNw79aYHTUxoqz8/La82cA
	tYJpOF+qt3TpXkmuVscGKY9A0GwFCq3CzlroqzHmtlGhQDApgwGzuZLHqWjaxRyqDKdl4sb5G08
	p4/e/YiFmRikwF83aPXnq5+zErY9CRqPKZoMKlmWZYRgnHAEhVSvq2R/z9tyx8AHJGIMXT1u47Y
	IERIbvWFR4ld/eMtkd+PWD7KBYT1wrANWSQ0I0Mrc219Uisiut+JM0VaFg0Dfzaimslpffav8IK
	VffoGhHHdTd1EcX7jOs2ns=
X-Received: by 2002:a05:7300:6c05:b0:2c7:3a7:c792 with SMTP id 5a478bee46e88-2e47a1027ecmr1967434eec.20.1776446246635;
        Fri, 17 Apr 2026 10:17:26 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm3045034eec.13.2026.04.17.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 10:17:26 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 17 Apr 2026 10:17:23 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, dave.jiang@intel.com,
	gourry@gourry.net, dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core/region_dax.c: fix missing assignment in
 cxl_dax_region_alloc()
Message-ID: <aeJrI1S5omou28MQ@4470NRD-ASU.ssi.samsung.com>
References: <20260411011137.43545-1-anisa.su@samsung.com>
 <69e17d9ee2924_52a121009@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e17d9ee2924_52a121009@iweiny-mobl.notmuch>

On Thu, Apr 16, 2026 at 07:23:58PM -0500, Ira Weiny wrote:
>> Anisa Su wrote:
> > cxlr->cxlr_dax assignment was dropped during refactor.
> > 
> > Fixes: d747cf98f091 cxl/core/region: move dax region device logic into
> > region_dax.c
> 
> I don't believe this is a valid fixes tag.
> 
> Looking only at commit d747cf98f091, this line does not appear in the
> original function...
> 
yeah it's not, sorry :((( the assignment was added in the dcd patches and I
dropped it while resolving the conflicts during the rebase cuz I was just in a
rush to finish it

I realized the error and said "pls ignore it I was wrong" in the original thread here:
https://lore.kernel.org/linux-cxl/ad0hJ1q5Lp5mckt1@4470NRD-ASU.ssi.samsung.com/T/#u

but I definitely should have mentioned it here too. anyway sorry, just pretend
I never said anything

- Anisa
> -static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> -{
> -       struct cxl_region_params *p = &cxlr->params;
> -       struct cxl_dax_region *cxlr_dax;
> -       struct device *dev;
> -
> -       guard(rwsem_read)(&cxl_rwsem.region);
> -       if (p->state != CXL_CONFIG_COMMIT)
> -               return ERR_PTR(-ENXIO);
> -
> -       cxlr_dax = kzalloc_obj(*cxlr_dax);
> -       if (!cxlr_dax)
> -               return ERR_PTR(-ENOMEM);
> -
> -       cxlr_dax->hpa_range.start = p->res->start;
> -       cxlr_dax->hpa_range.end = p->res->end;
> -
> -       dev = &cxlr_dax->dev;
> -       cxlr_dax->cxlr = cxlr;
> -       device_initialize(dev);
> -       lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> -       device_set_pm_not_required(dev);
> -       dev->parent = &cxlr->dev;
> -       dev->bus = &cxl_bus_type;
> -       dev->type = &cxl_dax_region_type;
> -
> -       return cxlr_dax;
> -}
> 
> 
> Furthermore, I don't see where this line ever appeared in
> cxl_dax_region_alloc() prior to commit d747cf98f091.
> 
> So what is the purpose of this change?
> 
> Ira
> 
> 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >  drivers/cxl/core/region_dax.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
> > index de04f78f6ad8..068690d02c8c 100644
> > --- a/drivers/cxl/core/region_dax.c
> > +++ b/drivers/cxl/core/region_dax.c
> > @@ -62,6 +62,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> >  
> >  	dev = &cxlr_dax->dev;
> >  	cxlr_dax->cxlr = cxlr;
> > +	cxlr->cxlr_dax = cxlr_dax;
> >  	device_initialize(dev);
> >  	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> >  	device_set_pm_not_required(dev);
> > -- 
> > 2.43.0
> > 
> 
> 
