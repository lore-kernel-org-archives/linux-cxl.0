Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E93921D8
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143269; cv=pass; b=gJZ2MXJhYMpVrwU6MNfB22mG3n4gvGqJH2dY+aFB54Kguw7dYdMW/SznDGaewHCJ4nfZ7jhVyoVDlGN45gb+wSf5KherplVOWiyHYPt3bIPYY5RzbgSpKHGtdzm+xZssJZFB4V3lQOYJ3oQeDVZ7aRHF79Q9yReHIcageUc1LAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143269; c=relaxed/simple;
	bh=HgLSZl8XxyK20T4gh3lI0f3nK0YB9PmdSCSKHAKyLFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IboCTkH/u/vtuImIxX/mo6evk+sffY4azm0/0pDRpXdowXhccCcy30M0fqdzsIj19c7A1ZtbPNVc4q9dtgLcBprBUpDlB+1Z2JnL3VzJXoBGSTxlWZjDsjQurayOewQoCn5K/MkiUl8tET9OYWAE+ia1wVXJEwEjh2rS5qJuebs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EgPUbUrx; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EgPUbUrx"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-6729ca45e37so621624d50.2
        for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 23:01:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790143266; cv=none;
        d=google.com; s=arc-20260327;
        b=R10C4rVNajAmqiEF5opDa7j9eayhC4Dcoo5CgAg32lRAUv5zahAiDQN+3oOoKHo3P7
         ITYUu64ROoxjkDDeB47em/i1Bj494+bidoHaOuVWQnK4Tv21FUpZ4xeWSpiPWuQIFMrX
         uBY28OB6nDc9fT98X/TB4OCDuH5/jV2SUk6E/mmIfhCeI2YTuO28MQr/AxDnpHPsF/Er
         3i1ZM0TFTDcVbIIZbMfqEXTM+l5gB/ZWo035Xx7We8nV8ylpRJZ1lFqBG/tv7u/yLmtk
         LpDq4gaTYwlIUQtSHpCx0NuZ24II8lrXMcKFk48EDeiGXlyBLYoLvEHSkC3EOXfVRBD0
         MUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BI7bwcNjzQv13pRkfjbMflvweeVEe6lYqf3+ijkmu54=;
        fh=XV7sKTyah1K7aipQhcnsXSXP1qrM3RCNndYxUeBi5Vg=;
        b=cdJf9CPRgANsF2kz2f4ZVpvm3g9+IazzoR6pjhrixctu0mqw2C8HbhcU022aZQAPFQ
         KLNIa1Ay8c1HnC05RX2zvDVjMWeKQJO95yjnf6lOcDAAfGbHCfFXA5aGltsARKgzSRZ1
         9Yous1IvZPKqBoNvGJ6SegNmkovy4HATpVaWgMwuHSyB/RpNycJjI92u+l5kB3H6zjuP
         sxX6dY7rV0ZHTkkqhWBDouNPQKQ4+OZxMS5tkvj9Eb8Nfp9tWW+uhlOd8Ic0f+wdiZi4
         nSTT3EXprkT1NdD1TMKyBG/oOJm0i47O/M+08rnXnGFtaxM7CRF8YQePZ9rXO15pu50b
         BpWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790143266; x=1790748066; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BI7bwcNjzQv13pRkfjbMflvweeVEe6lYqf3+ijkmu54=;
        b=EgPUbUrxZTVaE/iU2QOnC+73p/clDqDxQhp3fwzABG5j/n48P1q6ns07VHFwkjRezH
         07MMs9BgA492axyK+3OynfnTgZl9eY4Wje0qNmI/T/VncZaiuqNOI2l147sC+A/Gh4Iy
         gn2wwYJ7E4/Szse6RcHkpVbPioI8pzdFfWHbpFliodkMsdmPArJP0rjvjbJRXM44AuOr
         RfnWYBtdii2YT66YO16DIwRkHk1t3QgAw6CYC1kICmHGSG1JXofQ0ZSkO7eRGKIWNVMi
         5YhewlwgeQNEKKG9uBoeGR7CuRfgsvcawqRZB615nghP4gtljCTWdMyyAgZt7f7WE1bH
         TbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790143266; x=1790748066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BI7bwcNjzQv13pRkfjbMflvweeVEe6lYqf3+ijkmu54=;
        b=ocUHIIwlkahgd4nyNzUr6BfqGdqm4s9vptCJ1+3Pg4w422VFOLkaIA3JO5+Tqb4GlO
         Nnmz8ek5XcDu7FWu49Ong5GVzs6i+m0i++BtT+fGKJQF/E0wYtYRghoKxrcsjaJPORBp
         jrqaNenkmIsQppz6/lsapd9t3EEU2lijnAX07f4Of/tN+UMOEZ2YEDrLVh6sAajQgxT+
         7qtigkgtrtPwoD5ceth0kKf1cjLfKaDu6eFS0OkHOds4B9gbLZTz4dHjmvv47+Ucj06t
         z1Jpffj6wzwOD6Ae+2IeFfYmr1yRm/jDl6B/1OAHT5mcS+Bge53esZGkIWzueUnWoJty
         MlqA==
X-Gm-Message-State: AFuF++mrq/JfSOIzFdbz761mGFYAU8OHgVnqzSPuaPJzx6kCPXlddZaO
	z8M2sN/4/9AQ4PQ29oTwiwRvKNwW4Cfxl/Km3qD6XJxpfYboYsosZae5X+WLjOZwE6rSvUkPajj
	oLgBBIqV82K03+yGaqY436LUjivSjUcGSo/Sp53f6ug==
X-Gm-Gg: AYBFou2Yo5Li/Fo57ZcDrQFLFA1na5i2sMnP+tPlSHeFp726TNr6Hgp0RCtUsfrO7qr
	ebnHF6hvLZ3J0UoGN9wEjWkC3jpdNNKIkLVQjxBeROw6L5te4F7aDtGY2Aqa1+GTrd3bqI9JZZh
	diT2cgYQCvv8fGyiLLs2bTaP28uQTgjAPrnh7yzozWu+F6+NS6VOti87iWKKpldOu0wusEwlAjj
	a17OzwlRTqwPIPAx38MkZVvcNeQIjXPmeRuIou4fpEj5N5GonmNURkoJjri1APsrPpQJ2wlQjtU
	0dgJhRD9WNPpQv9YOBES5YoJR2VhNyKXYBxiN+I68URzyyIg3f1Nazg=
X-Received: by 2002:a53:ad50:0:b0:66f:c1bc:40a0 with SMTP id
 956f58d0204a3-672d58abf06mr470879d50.99.1790143266221; Tue, 22 Sep 2026
 23:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922082551.874901-1-songmuchun@bytedance.com>
 <20260922082551.874901-3-songmuchun@bytedance.com> <20260922083712.A89111F00893@smtp.kernel.org>
In-Reply-To: <20260922083712.A89111F00893@smtp.kernel.org>
From: Muchun Song <songmuchun@bytedance.com>
Date: Wed, 23 Sep 2026 14:00:29 +0800
X-Gm-Features: AcwNN1U14lhaEIPXhrx92Llhfbcm9mObr2diD8G4hu8c12kamR6vjUggv5v3RCQ
Message-ID: <CAMZfGtURkCQo4DCbdj+KcG0zbZHzECfY2c0aqnDeLWYt_uo9Eg@mail.gmail.com>
Subject: Re: Re: [PATCH v2 2/2] dax/bus: fix Device DAX range alignment validation
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:37=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dax: TOCTOU race in size_store causes partial shrink failure
> --
>
> commit 519db297333e73581e0bbd5524e7d6959d7610a7
> Author: Muchun Song <muchun.song@linux.dev>
>
>     dax/bus: fix Device DAX range alignment validation
>
>     dev_dax->align describes the page size used by a Device DAX mapping.
>     Both the start and size of every range must therefore be aligned to i=
t;
>     otherwise the starting PFN cannot represent a naturally aligned page =
of
>     that size.
>
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index e40c25401cf06..277c3ce23b831 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> [ ... ]
> > @@ -923,6 +964,9 @@ static int adjust_dev_dax_range(struct dev_dax *dev=
_dax, struct resource *res, r
> >       if (dev_WARN_ONCE(dev, !size, "deletion is handled by dev_dax_shr=
ink\n"))
> >               return -EINVAL;
> >
> > +     if (!range_is_aligned(dev_dax, range->start, size))
> > +             return -EINVAL;
> > +
>
> [Severity: Medium]
> Does this new strict alignment check introduce a regression where partial
> shrink fails if the device alignment changes concurrently?

Thanks for pointing this out. The underlying TOCTOU race is not
introduced by this
patch. It was introduced by commit 6d82120f4156 (=E2=80=9Cdevice-dax: add a=
n =E2=80=98align=E2=80=99
attribute=E2=80=9D), which made dev_dax->align writable while leaving the
size-alignment check
outside the locking scope.

That is also the commit this patch is intended to fix, as indicated by
its Fixes: tag.
The stricter check added by this patch merely makes the existing race
visible as a
partial-shrink failure. I will therefore fold a fix into this patch by
moving the size-
alignment validation under dax_region_rwsem and dax_dev_rwsem, before any
ranges are modified.

>
> In the sysfs interface, size_store validates the size alignment before
> acquiring dax_region_rwsem. If a root user concurrently writes to align_s=
tore
> and changes the alignment requirement under lock, the shrink path proceed=
s
> with an outdated alignment assumption.
>
> During a shrink, dev_dax_shrink irreversibly deletes fully trailing range=
s by
> calling trim_dev_dax_range. When it reaches the final range to be partial=
ly
> shrunk, it calls adjust_dev_dax_range.
>
> If the concurrently updated alignment causes this new range_is_aligned ch=
eck
> to fail, it returns an error mid-operation after trailing ranges have alr=
eady
> been deleted.
>
> Since sysfs writes require root privileges, can this time-of-check to
> time-of-use race leave the local resource state corrupted, with the devic=
e
> configuration permanently broken due to missing ranges and an inconsisten=
t
> size?
>
> >       rc =3D adjust_resource(res, range->start, size);
> >       if (rc)
> >               return rc;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922082551.87=
4901-1-songmuchun@bytedance.com?part=3D2
