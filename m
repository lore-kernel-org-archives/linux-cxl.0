Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133813290C4
	for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478082; cv=none; b=G4cbSAmrKAvpimnNZmqZU3r88JfiLqFSvVxWj1eaVv8usaZGKXk79Eic3PftVu3Ci4+5K9A97gfu5EMJgfxBxBZpl5K3S69Btl38j8YP30f/y1bJI4gkvYbiqmJO9iNIdn0lv5i1LlQkYwN2psaF0xGi28NCzGBvm/0uqVP8EW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478082; c=relaxed/simple;
	bh=SRU97DymWjnp7w+QlGnLOZoEw+1A9ptkxNjjXEbZeiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEYkWha5cekG1rNACE3SQGsgYwq739LaZ7JfyGRCOmjZJXSxxRA8gv5abFA9lwKS5pb0H793+5/JM/31pXPcnSpZDKbp/onShVBEzAw0VUSJ/KBV9jwls5gXCZMhU9m/9okUTg7Tk8/O9nURzYF7iml0TxWgd+xjx5MBENggvD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9382e59c0eso60241266b.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 15:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774478079; x=1775082879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L1AthXFJM7nHrwUAF7jDSmCmLx66+ThwcFJXkpZ4z8Y=;
        b=nfHE5d9y8f7R3qeKT807VuHvwDuP4c57BCP/em4wVh+EOk0uqLEYT3utp9Hb1VkcJK
         IMiRO5p0rubmESXn2qzAwfOlaj8gvcqBW/hUrpSwUoySPlDDk41ADfHHymWqBEzsHkYL
         39EnWokiNwspCNFz/bRCtE7HALAqZmCq+HqKR8NIuf+tkCw62qrRHEp35O87AJxCeLtH
         SmJ9T+f8a3bpts70HXWTwkj5Zk6oLqISkhR05oLncmUmS91qsSV+OAZK8m1AkPDe28LV
         trFRYsu0ah+NZchrtA8taM9L1zoK09zsarKHK2S0J2jYtjeiT02hNWgmSqJo7ASOo1iT
         EYTA==
X-Forwarded-Encrypted: i=1; AJvYcCWVhhQqcB6s4yhlC0TLA7HFrLZNTRKW5JWwYmH3T2jq6+OqlqvdtMkIovLBSMLA7oYCUqtozFnWDR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpInp7YV4LprPvheymJdNVdNdoVZHHPoU+ZnW3DEBTCTjfBiqU
	xVG9tXuBZRdtYixwzeDRRRb1mfVgBB3AixYFdjXRKWqKPMYkjB6VEjZTmTHawR3u0Dk=
X-Gm-Gg: ATEYQzwNgqAo+Cap4lb0LvWCqOM7YevtCVxR/Ho+5nZ/1HORTHrG1T6ORs2yTtTJcDp
	AJPZ977xW6eqZS8MkcCauLlDmYcJD1h3OKCWgurwo6KoPKf8J/wR/jV5WgbGmy1S0UHC/+ljKrF
	GlCbnFyvOPB3BE1JDnPcpRlFiO/oEU4nhpeYPk5OmyXxWHn32qbguyddYixOc2h4mS2G1iD/EGk
	MjtRLiC+TqygnG6di64yFaeLCrvT0NOuekZOUsvdVKXF9oGsxKQ1RqKyaGsKacKFv41b8E9T1Xz
	UQMTzCJYcn/jupDecj2CwnV67dYh8LtjN5XM4h9poOfDoDg0kYksEAfNaeitY+tvQSgax3RRVxz
	wBUkB6/u9CqNDsVzJKX87z4Po49s6tE9p/BtsPKq67ln/rHQtICnwMJAJzM7JoVKJRYgi/8xjTd
	98fJae/Mtl75YlT5ikPSEAFuXyRqXhnB1GtvV3YYvU8RMG2c/Xva+JQI4ACuoqz+zg6w==
X-Received: by 2002:a17:907:2da1:b0:b9a:7d8b:cda8 with SMTP id a640c23a62f3a-b9a7d8bd67amr391373766b.42.1774478078496;
        Wed, 25 Mar 2026 15:34:38 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b20265120sm36139066b.16.2026.03.25.15.34.37
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 15:34:38 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b871dd06eso158965f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Mar 2026 15:34:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9J86Ln0OyBGs1h9xzRutonSrRn+M1pGuV5G/St/rGnmmzmOKePY3aFHUykn4F8GWKBZXQ+ur7S88=@vger.kernel.org
X-Received: by 2002:a05:6000:2c08:b0:439:b564:7a71 with SMTP id
 ffacd0b85a97d-43b889ac037mr7528117f8f.1.1774478077438; Wed, 25 Mar 2026
 15:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309000810.2632065-2-iam@sung-woo.kim> <acMwcFT8ng9Hb45K@aschofie-mobl2.lan>
In-Reply-To: <acMwcFT8ng9Hb45K@aschofie-mobl2.lan>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Wed, 25 Mar 2026 18:34:21 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJ=3XSRT3XEk_GHPSAuCJ1FrNOcBjm=Gsd_HAUerqSm5g@mail.gmail.com>
X-Gm-Features: AQROBzCKzUysfG_-sQuXIp5Kw_RRkJOSPlHEycIJxBYARfTQ432mgjthfIUqe0g
Message-ID: <CAJNyHpJ=3XSRT3XEk_GHPSAuCJ1FrNOcBjm=Gsd_HAUerqSm5g@mail.gmail.com>
Subject: Re: [PATCH] cxl/hdm: fix a warning in devm_remove_action()
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Ben Widawsky <bwidawsk@kernel.org>, Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:46=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Sun, Mar 08, 2026 at 08:08:10PM -0400, Sungwoo Kim wrote:
> > In the following race scenario, devm_remove_action() can be called
> > before devm_add_action(), triggering a warning because there is no
> > action to remove.
> >
> > To fix this, extend a critical section to embrace both
> > __cxl_dpa_reserve() and devm_add_action().
>
> The fix LGTM. I suggest tightening up the code comment. Now it
> talks through the race in detail and also cross-ref another location.
> Limit the comment to describing the ordering requirement we need to
> preserve. The commit message already captures the full race and
> rationale.
>
> Comment update suggestion below-
>
> snip
>
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -509,13 +509,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_deco=
der *cxled,
> >       struct cxl_port *port =3D cxled_to_port(cxled);
> >       int rc;
> >
> > -     scoped_guard(rwsem_write, &cxl_rwsem.dpa)
> > -             rc =3D __cxl_dpa_reserve(cxled, base, len, skipped);
> > +     guard(rwsem_write)(&cxl_rwsem.dpa);
> > +     rc =3D __cxl_dpa_reserve(cxled, base, len, skipped);
> >
> >       if (rc)
> >               return rc;
> >
> > -     return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxle=
d);
> > +     /* See comments in cxl_dpa_alloc()*/
>
> Something like this:
> /* Keep reservation and devres registration ordered under dpa lock */
>
>
> snip
>
> > @@ -613,7 +620,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_deco=
der *cxled, u64 size)
> >       struct resource *p, *last;
> >       int part;
> >
> > -     guard(rwsem_write)(&cxl_rwsem.dpa);
> > +     lockdep_assert_held_write(&cxl_rwsem.dpa);
> >       if (cxled->cxld.region) {
> >               dev_dbg(dev, "decoder attached to %s\n",
> >                       dev_name(&cxled->cxld.region->dev));
> > @@ -679,11 +686,28 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cx=
led, u64 size)
> >       struct cxl_port *port =3D cxled_to_port(cxled);
> >       int rc;
> >
> > +     guard(rwsem_write)(&cxl_rwsem.dpa);
> >       rc =3D __cxl_dpa_alloc(cxled, size);
> >       if (rc)
> >               return rc;
> >
> > -     return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxle=
d);
> > +     /*
> > +      * Add the devres action while still holding cxl_rwsem.dpa to pre=
vent
> > +      * a race with cxl_dpa_free(). Without this, a concurrent cxl_dpa=
_free()
> > +      * can observe dpa_res set (by __cxl_dpa_reserve()) and attempt
> > +      * devm_remove_action() before devm_add_action() has been called,
> > +      * triggering a WARN_ON in devm_remove_action().
> > +      * Also, devm_add_action_or_reset() cannot be used here because
> > +      * cxl_dpa_release() tries to hold the dpa lock that is already h=
eld,
> > +      * causing a self deadlock.
> > +      */
>
> and like this:
>
> /*
>  * Hold cxl_rwsem.dpa across allocation and devres registration
>  * so cxl_dpa_free() cannot observe dpa_res without a matching
>  * devres action.
>  */
>
> snip
>

Thank you for your review with a suggestion. Will do in V2.
Resending to the mailing list, I replied privately by mistake.

Sungwoo.
