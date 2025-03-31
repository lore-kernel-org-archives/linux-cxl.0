Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FF838FB0;
	Mon, 31 Mar 2025 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743462202; cv=none; b=uPM1pjXvvLu2drwf/LJ5R22myBUxcahKjok1AOqs9tLiNg0BjuLY11rzGiwi2PW2XznhHFYMnLLTjZJ1TMdlVVLUKdfOsGGxIQ7+Lo2i31HWbLd4i/kaUy2LvHKioH94AGk3KW/xOmXqYOcTpjdWCko9tI/JhJDQ8UMylWfUzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743462202; c=relaxed/simple;
	bh=x7+Z8Pc1cSudYWgsVu66IHizHde/+DtFe/nyvb+QJXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGwMuh8J01p8SwiqzNH37Nixqu0I4y3Qp9EF989NmCaKwONo8i4QJRIsTSUMQx3ZWCqEaXx/aqmv5IRBP98ELTmc69pkWxUDu+r/+56I/xqGRV3xn8YUvRLKB7oeYAyyGa8U92MXgOyD0dwTu2VhOMS8TGjANUI0VqbLpOx+0w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2HTH4PM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2HTH4PM"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6eeb7589db4so52290576d6.1;
        Mon, 31 Mar 2025 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743462200; x=1744067000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWwPmCk/bFrl3o6dHPfyYz2Jq8FW3LKwskkgzUQA7CQ=;
        b=g2HTH4PMQUWqfBWFMNIUvZNtO9zeHm/Yg86Yj6UYSxjYMsxOZWhr/7wn+4/dy5QsfY
         ONyb/3dUlAQYNurp0xk8WeFdOoW17pmhPLVooDNp8L4JXfAxt+hTrp6ABP/vRQAUpzK3
         n7/vlEplkFUGhx2Zm1IPZvN3ugjXZfVqrZ08Wm9aguITt62HMf9Pa8IyWgGB+E6AqPqx
         JUTxkxOs3Yp6w3ZY4eNtNWLt9kS6+w3WpzY5agBsdRLCvsMYoct9wK1stI7QGPtcR6mf
         61/AN6JpLqILm01AISfKwRyLCdtFZD+BAFNX2uxCRN3RUbFHUEg5d8p2ZjcYJh2+UVHK
         KoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743462200; x=1744067000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWwPmCk/bFrl3o6dHPfyYz2Jq8FW3LKwskkgzUQA7CQ=;
        b=T6dwQXsBDb9MP1oc9EC/UTWoe0NpG8ptiaC210QpvB83m/oRKoAQB7yB6Fm7kqQubk
         K7f7xowjjj+ZkLmXRCEGJhlg7P+CR1cDlj1T9Yl0nvTx5T4C1vWKfnhb4qjSaZI3zuYd
         lO7tfCHHzqZGegWvjas+25JMoI6NAA69Mu/8WFxC4IGHAUZWrg9PcI7bmbhQjyt9hwmN
         A17xI49FF0Pl6seXJuy4P4O6RjiByCvV1DloVd6FOfOSZNji+OaKmdPceLJAUng4zg6X
         1XKNDSVlsfGmNbSn9bIC2iffIvyvAXhOcyC+AL0uuaftsNgYM1sZdUVt4XK+LEBPAyFy
         4Bag==
X-Forwarded-Encrypted: i=1; AJvYcCVr9Jkxy3NkTq8ocvyD6E2+BXEpul9XbO7IqaeZjkGnizOc4KWFgFnNdb9thzekevB6RH6nuka5KqU=@vger.kernel.org, AJvYcCXBHx3xL4XYV87XRAKhiObA2Nd7fEB8YtYdwt412eD5V13QihUrD7lLe58yzoUcqAUjIQNOL36JxsOFX17o@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVdu7Ge7wOrMz+XtuVhpPiRnYjbXtbyQaS6R+EkhYcKi9QYzE
	JRFpgaEJYc+dYLXmC6nJO4EbhWgcStCnPGKa6q+uJqytyU4TVFyP+Yhee9KjvsckCMvrElY+IUt
	97kBlU63A+e6xnAK/p5r49Anv46o=
X-Gm-Gg: ASbGnctyp9KN5w3mtMx3ihV9FQ9z/hNzbfi+voVdkNC9bNBxQMnmbtnlqNqPL/5iJ6Z
	gwtAERRPFVBYSPoFDIAe0Pp2URw6qLAVyt/Yi/cGRKJ1NFgTnTC11tfOo5umWuHG8HUA8DyIl4q
	BTTS6HLI1ZW9Zr2TCXuu9bMZgpCSx0yXqVEkLiC7OGXvpD+LW9KRYj
X-Google-Smtp-Source: AGHT+IF1XNzfdEdI5a/KuIRD1Tv1xoYFpxj9+QumwGIhqynrvYAvG1rLCLaa6IdtCDkTmp4jEb2Q8uUGWC2C58hGufM=
X-Received: by 2002:a05:6214:2507:b0:6e6:61a5:aa4c with SMTP id
 6a1803df08f44-6eed629a9admr176232946d6.31.1743462199977; Mon, 31 Mar 2025
 16:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329110230.2459730-1-nphamcs@gmail.com> <20250329110230.2459730-2-nphamcs@gmail.com>
 <67eb148e1f818_7baf294b9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <67eb148e1f818_7baf294b9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 31 Mar 2025 16:03:09 -0700
X-Gm-Features: AQ5f1JrJa0OI2zK8nR3gBptJMvPGRmf2NcF6lSF3CCpW8PAHL9JjLfK12YT14xI
Message-ID: <CAKEwX=OEQKdoWbyAO=LKE--ssLzBH0UVhz3EYaCiodpbMtQvKw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] zsmalloc: let callers select NUMA node to store
 the compressed objects
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	yosry.ahmed@linux.dev, chengming.zhou@linux.dev, sj@kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, gourry@gourry.net, 
	willy@infradead.org, ying.huang@linux.alibaba.com, 
	jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 3:18=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> Nhat Pham wrote:
> > Curerntly, zsmalloc does not specify any memory policy when it allocate=
s
> > memory for the compressed objects.
> >
> > Let users select the NUMA node for the memory allocation, through the
> > zpool-based API. Direct callers (i.e zram) should not observe any
> > behavioral change.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/zpool.h |  4 ++--
> >  mm/zpool.c            |  8 +++++---
> >  mm/zsmalloc.c         | 28 +++++++++++++++++++++-------
> >  mm/zswap.c            |  2 +-
> >  4 files changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/zpool.h b/include/linux/zpool.h
> > index 52f30e526607..0df8722e13d7 100644
> > --- a/include/linux/zpool.h
> > +++ b/include/linux/zpool.h
> > @@ -22,7 +22,7 @@ const char *zpool_get_type(struct zpool *pool);
> >  void zpool_destroy_pool(struct zpool *pool);
> >
> >  int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
> > -                     unsigned long *handle);
> > +                     unsigned long *handle, int *nid);
>
> I agree with Johannes about the policy knob, so I'll just comment on the
> implementation.
>
> Why not just pass a "const int" for @nid, and use "NUMA_NO_NODE" for the
> "default" case. alloc_pages_node_noprof() is already prepared for a
> NUMA_NO_NODE argument.

Gregory and Johannes gave me that suggestion too! However, my
understanding was that alloc_pages_node(NUMA_NO_NODE, ...) !=3D
alloc_page(...), and I was trying to preserve the latter since it is
the "original behavior" (primarily for !same_node_mode, but also for
zram, which I tried not to change in this patch).

Please correct me if I'm mistaken, but IIUC:

1. alloc_pages_node(NUMA_NO_NODE, ...) would go to the local/closest node:

/*
 * Allocate pages, preferring the node given as nid. When nid =3D=3D NUMA_N=
O_NODE,
 * prefer the current CPU's closest node. Otherwise node must be valid and
 * online.
 */
static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
   unsigned int order)
{
    if (nid =3D=3D NUMA_NO_NODE)
        nid =3D numa_mem_id();


2. whereas, alloc_page(...) (i.e the "original" behavior) would
actually adopt the allocation policy of the task entering reclaim, by
calling:

struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned order)
{
    struct mempolicy *pol =3D &default_policy;

    /*
    * No reference counting needed for current->mempolicy
    * nor system default_policy
    */
    if (!in_interrupt() && !(gfp & __GFP_THISNODE))
        pol =3D get_task_policy(current);

Now, I think the "original" behavior is dumb/broken, and should be
changed altogether. We should probably always pass the page's node id.
On the zswap side, in the next version I'll remove same_node_mode
sysfs knob and always pass the page's node id to zsmalloc and the page
allocator. That will clean up the zpool path per your (and Johannes'
and Gregory's) suggestion.

That still leaves zram though. zram is more complicated than zswap -
it has multiple allocation paths, so I don't want to touch it quite
yet (and preferably a zram maintainer/developer should do it). :) Or
if zram maintainers are happy with NUMA_NO_NODE, then we can
completely get rid of the pointer arguments etc.
