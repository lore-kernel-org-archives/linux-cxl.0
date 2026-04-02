Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6903C373BEB
	for <linux-cxl@vger.kernel.org>; Thu,  2 Apr 2026 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154400; cv=none; b=LRuB8hHbx00jJqQnxKgU+oYYiWYGuDVIbkNx/sMqUHJ8Z04nUPh2aBxhocGYUxY5wmUjrniThR9cCHgIt89dlGAgi8xECbJOYbgKiPib7NgHGlK3WWDTT7qEV7phQoMcIr5MvnhWX7xyPoyLX/kCWlCwCHjYgBe1G8HkSMcAOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154400; c=relaxed/simple;
	bh=uQ0uAbnejGH89M/cGWkkbIsyRAlwpwWbhOGqD3/1FPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZif5ZPITc1kcbeQ2q75uAJnF9t5EBFrh/diHiHaZkVam2umtJI4fd7IXzpRSdKvH81ERzwge8LlzGrO7Gkdk8muT0Rr90PMHRL3nfVg04GysVLUf8N716/tWKfMwHvx5uYyLc2CBT1gD3VltXUeeBRaqI82wk9Z/yccvKAQ9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b93698bb57aso249652366b.0
        for <linux-cxl@vger.kernel.org>; Thu, 02 Apr 2026 11:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775154398; x=1775759198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lTYIwjaImmoM2tq6z6YuXZGmV8pazwJWOGsrNCSDtbQ=;
        b=Efo2LkWB4Uhmbv7Bhmyp3U/pRqR5huo0Yabreodzq1Wcb1+2ZYucIFdDItdPRvUhoA
         Walnfs/8Kc8S+6AGR6p6DpSybYLAzakURbwtELFgHe2B25mDslKpyfOof2V63Na7fCqx
         dSjZNX6GaY5gZwWcyIQ2GX1dXKjLumTAYwtRvmlTeF7V0FLz4jndNnj/8ZIPuZxGaice
         laUUmplSQLi+10mTZiUfgNKp8oMcyfFoZ3TweK2OvXb9pBdglFqK7fhC3VBKsbjNcSqx
         WcI7MjRjTDXW5ggBC+bSwG/X/R0ZH8Nr59K/WZyhOSuWu5mFKWN7Eu1EYRVxytSKxo1P
         s1RA==
X-Forwarded-Encrypted: i=1; AJvYcCW2kb6kzi8Wl+acG8f/Pg5SDTZyAr7ZAME8Ssy8n+OAb1NZ+IASFRxt1kcp51EkM5nyTFjfxXzjGEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVxlo0ObAUlsy2p5fJiEAKvgQfvK32wz8abute3soE/lOZncDT
	f+gHXlXDFvav4cqEKAuDlE+L/ZWrzWKoqY+2lfIdZhgN+CzQOa++uy7941RM0WuoS2Foeg==
X-Gm-Gg: ATEYQzw4tkvtwAMgcFd+QsYlWxFk4rVdey29FhHlRnjYEGmzTKsyY2RiI3bP2R+zBLt
	btC5MJXrRUfUndWqi8qSLoxrQBA948bJLFgqkfShZ4bF0BuIqH7Z7NYkOW5Ymtp+KgH1OTy3HZC
	OeG/eH63h03596XlEJwx+Bz1YCbWL1qt/ykmrOPzYWZyffSQI/L5eZhmqt4zo7p496N0+v3iLBt
	lxIQP6Gl9MExq4v5uIwV0FGc4IPLCwRiS9JogN7pwRyXyHnKO1aOzyuhElybmkcVB2unQBtcjw1
	r0Hze+RhTTtemk9zf5Zyh3yS1JOvR3DFfBePu1cVqBzJU9wEEzYu6XX0RaBLmaysUqAwEyLjN5Z
	D3wX+j5G78TDb+RIvRrQ5NZbUf2H9kMvaaTaD1jwsJIiKR6eNvg4Dj14ahQFHWPuBGs6fCTqajC
	ctNUlNlN4ctT3Tk8i+HIcjGlUrHU6U3vuUOW9ubttitBmBBDMKQKRnU6k=
X-Received: by 2002:a17:906:f5a0:b0:b97:6d1b:4be8 with SMTP id a640c23a62f3a-b9c46e2677fmr177298666b.10.1775154397460;
        Thu, 02 Apr 2026 11:26:37 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cec6f2bsm110116266b.35.2026.04.02.11.26.37
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 11:26:37 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b949bf4easo1605917f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 02 Apr 2026 11:26:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWo/DYGbXmXsy83dKmz+hBbm4h6sDQKJhCtKfxPvqoLbwHEZb6x9WbpOUQkqYurLz6nDMcPUs+8sys=@vger.kernel.org
X-Received: by 2002:a05:6000:2489:b0:43c:f67a:5b50 with SMTP id
 ffacd0b85a97d-43d28fad7f8mr359049f8f.10.1775154396797; Thu, 02 Apr 2026
 11:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330130156.2212694-3-iam@sung-woo.kim> <a9b88efb-320c-4cfd-98d9-508a237c4444@intel.com>
In-Reply-To: <a9b88efb-320c-4cfd-98d9-508a237c4444@intel.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 3 Apr 2026 03:26:21 +0900
X-Gmail-Original-Message-ID: <CAJNyHpKCHR5p9wGLi8Zrw6X78Q7nsubMwHWs4skBfGHi_9LGLA@mail.gmail.com>
X-Gm-Features: AQROBzATSOha-R_tArgODXoqGgdkOAD9ws14x8CMeSn0rLaFOZCmpLXxo7e3QCM
Message-ID: <CAJNyHpKCHR5p9wGLi8Zrw6X78Q7nsubMwHWs4skBfGHi_9LGLA@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/hdm: fix a warning in devm_remove_action()
To: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 6:35=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> w=
rote:

[snip]

> > ---
> > V1: https://lore.kernel.org/linux-cxl/20260309000810.2632065-2-iam@sung=
-woo.kim/
> > V1->V2:
> > - Let __cxl_dpa_reserve() handle devm_remove_action() to reduce
> >   duplicated patches. (Thanks to Dan for the suggestion)
> > - Make the comment concise (Reflect Dan and Alison's comments)
> > - Make a warning log in a commit message concise
> >
> >  drivers/cxl/core/hdm.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index cb5d5a047a9d..63bd0d5f31df 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -408,7 +408,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_d=
ecoder *cxled,
> >
> >       port->hdm_end++;
> >       get_device(&cxled->cxld.dev);
> > -     return 0;
> > +
> > +     /*
> > +      * Perform devres registration while holding cxl_rwsem.dpa so
> > +      * cxl_dpa_free() cannot observe dpa_res without a matching devre=
s
> > +      * action.
> > +      */
> > +     return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxle=
d);
>
> With this function added the devm_add_action_or_reset(), I think it needs=
 to be renamed to __devm_cxl_add_dpa_reserve().
>
> DJ
>

Sounds reasonable to me. I will do this in v3.
Thank you for your review.


Sungwoo.

> >  }
> >
> >  static int add_dpa_res(struct device *dev, struct resource *parent,
> > @@ -499,16 +505,8 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decod=
er *cxled,
> >                               resource_size_t base, resource_size_t len=
,
> >                               resource_size_t skipped)
> >  {
> > -     struct cxl_port *port =3D cxled_to_port(cxled);
> > -     int rc;
> > -
> > -     scoped_guard(rwsem_write, &cxl_rwsem.dpa)
> > -             rc =3D __cxl_dpa_reserve(cxled, base, len, skipped);
> > -
> > -     if (rc)
> > -             return rc;
> > -
> > -     return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxle=
d);
> > +     guard(rwsem_write)(&cxl_rwsem.dpa);
> > +     return __cxl_dpa_reserve(cxled, base, len, skipped);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
> >
> > @@ -606,7 +604,8 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_deco=
der *cxled, u64 size)
> >       struct resource *p, *last;
> >       int part;
> >
> > -     guard(rwsem_write)(&cxl_rwsem.dpa);
> > +     lockdep_assert_held_write(&cxl_rwsem.dpa);
> > +
> >       if (cxled->cxld.region) {
> >               dev_dbg(dev, "decoder attached to %s\n",
> >                       dev_name(&cxled->cxld.region->dev));
> > @@ -669,14 +668,8 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_dec=
oder *cxled, u64 size)
> >
> >  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
> >  {
> > -     struct cxl_port *port =3D cxled_to_port(cxled);
> > -     int rc;
> > -
> > -     rc =3D __cxl_dpa_alloc(cxled, size);
> > -     if (rc)
> > -             return rc;
> > -
> > -     return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxle=
d);
> > +     guard(rwsem_write)(&cxl_rwsem.dpa);
> > +     return __cxl_dpa_alloc(cxled, size);
> >  }
> >
> >  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>
>
