Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A6288A2;
	Thu,  3 Apr 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692772; cv=none; b=UzkxiA3iRqt2cz0pgi603HcOiYTxmq4TMrA2SzyHSz26TOFkhJiRXtp4dnAC5AawkBZ8AhnE4JwRY2R4J6PxyLrxf8+82MyvQe1umMDnwLA88fSwoLSIVXwWIdLSssiUUg+hxUqte1Mi+Z7xPxNHTW7EAQVqtMNjiQqAdisSM5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692772; c=relaxed/simple;
	bh=+VMMw5rPIUEIFlei8KuJopBbaXcA5NCCzI0NEv4JagU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geYf7hallnmpOOQDIBVapQo4nQzvsmA4lLXobFEIlm/ThmPRvktmmPByyE2vNQrjj2uf4IfExbUJJEb2qN/wNbPph5gO8E4aNbDGJ08xYhFA9VX+LDdhQX0OiQ+CbjVfW7C9UJQtnLTMRoAcNmXP/tP7xPJhvg8q2nj82ZwVXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoViPt2j; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoViPt2j"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso9242356d6.0;
        Thu, 03 Apr 2025 08:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743692770; x=1744297570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK8KEJBVYPl6HLxUuQQ2klCL+ZgkeKSI3+E7obEM/WI=;
        b=aoViPt2j5d3aXeAmKRlTT/JqmjSyu3+G8Fr4hRo4HY7g7jV9e4nb1YYUij1MLj4c9q
         V4zOpKr00jwXxDllEI6sszzvWSjAfzPnWG/pyBIOsjouJ4sqXDr/pubRoE+cMGyawVRI
         lfTFWeKS+EfhJzg4aIRd6b1uX/Mc1nlpEDQo8oVYmNvyHJrk3mm1BuKM+ejnjXqW3E0c
         3DIFaOYLlAZ+HS8ORDWdrE9sfpXSvYOjT0hVJ+rYundeHCL72MMdZcEMWgbsFDBTFngS
         WvhLtkfQWL3eqyefWpagdpBHR7uDr4c0u4WOwNjxOLhe83uOGN1IjOymwjfqW/iXJVpO
         8ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743692770; x=1744297570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iK8KEJBVYPl6HLxUuQQ2klCL+ZgkeKSI3+E7obEM/WI=;
        b=jP0NlHEAkURo8/zHOwVFqJnGTz12Y/4cM6HhhDKLjNYiieHhRtEOUANOPRp4oZFT3s
         KCC7N+mD4wtqeCNMWCt4czni+HWN9rYuuzGRlizEyKZQGwkbUSesTohmupjtc/XmXoue
         MoyMtBNOik+jIoBa+4iVGge0kK0ioNDY3tbgF+ZI8fWj5XEV1MLZVD58c3P0JTCR2Do/
         EyWsckVNw02aRKycENLcWdMwYXQRNlWe2z/QXtOyxYHp6gfJQgKVDGNE9vWqCX5cLs9W
         DPntSmstw0g2ZnlrawmUdBHaZFXjtdpD+HW8+wb39eF/TnzrOboKaZZdZwr+TIOWp7tP
         +TDw==
X-Forwarded-Encrypted: i=1; AJvYcCU5yZqhJVbPudPx0ZqERfvRdtrn7WU8+a3ngO57zxTulb05M4pXgzgZNG4a5Fn6dhyyle46WCK/d0o=@vger.kernel.org, AJvYcCWMtA8hhbrA6w248vfpQwGWskbOVInyAseZ9isqtJ+wxcMLNgz3jMthkQuMMjemBvOZchJ7Q1jcKlNdqhnp@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6wA2PA2l5ZI0qsSSuyuosjslfGff3cokKSpyC9HqSfdFsQvm
	AhkWpWd35+pg2fuLfU2oWoIcRFON0rGvyDt9h+qJhvCi3W/LNySoGrp+sNUW7HlwDVBTWhm8nvY
	4dbNktJeRKGOfmFTpTB7wphgBImA=
X-Gm-Gg: ASbGncsNWbuk2yz0m8G0XlRD6uaFuJQ45xNU/3r26/edrgun+ntuyy3zJJ8CG3iiT4v
	EXmkecleNDOmd7F4XlGtcFgftZYYYwivpd5Z6ydOm2K9KLrttScXDY6wDErVbKQFkf/Xb02SNDp
	hVcx2igKqU9se9AobdKu0AToIRDo/a3hvfLFj2bKF/XytGT4C+FCHjoo9jAA==
X-Google-Smtp-Source: AGHT+IHhT/kv3ErEBGGfcWsnYD74kOhA0A8+Rch51ZBJnkmq+tPsrAIdzQtaOiWaOiHnDiOdafpEDaK/ECwlaCjb0Pg=
X-Received: by 2002:ad4:5f07:0:b0:6e8:eabf:fd55 with SMTP id
 6a1803df08f44-6eed625b85dmr310628256d6.39.1743692768242; Thu, 03 Apr 2025
 08:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402204416.3435994-1-nphamcs@gmail.com> <mnvexa7kseswglcqbhlot4zg3b3la2ypv2rimdl5mh5glbmhvz@wi6bgqn47hge>
In-Reply-To: <mnvexa7kseswglcqbhlot4zg3b3la2ypv2rimdl5mh5glbmhvz@wi6bgqn47hge>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 3 Apr 2025 08:05:57 -0700
X-Gm-Features: ATxdqUFYf4wIA9R_L2Co5iER6d9yuAcNU5JyorPqrHSFoabj94WPG9kBtVsSVkU
Message-ID: <CAKEwX=NJi63CPEe2bXD4_+Uur2KUmCV-L1kVtQr_+mgKbMb3eg@mail.gmail.com>
Subject: Re: [PATCH v2] zsmalloc: prefer the the original page's node for
 compressed data
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosry.ahmed@linux.dev, 
	chengming.zhou@linux.dev, sj@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com, 
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org, minchan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 8:55=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (25/04/02 13:44), Nhat Pham wrote:
> [..]
> > @@ -1981,10 +1981,15 @@ static int recompress_slot(struct zram *zram, u=
32 index, struct page *page,
> >        * We are holding per-CPU stream mutex and entry lock so better
> >        * avoid direct reclaim.  Allocation error is not fatal since
> >        * we still have the old object in the mem_pool.
> > +      *
> > +      * XXX: technically, the node we really want here is the node tha=
t holds
> > +      * the original compressed data. But that would require us to mod=
ify
> > +      * zsmalloc API to return this information. For now, we will make=
 do with
> > +      * the node of the page allocated for recompression.
> >        */
> >       handle_new =3D zs_malloc(zram->mem_pool, comp_len_new,
> >                              GFP_NOIO | __GFP_NOWARN |
> > -                            __GFP_HIGHMEM | __GFP_MOVABLE);
> > +                            __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid=
(page));
>
> This works for me.  I saw in other threads (and sorry, I'm on a sick
> leave now, can't reply fast) that "zram people need to fix it"/etc.
> I guess I'm one of those zram people and I don't think I run any
> multi-node NUMA systems, so that problem probably has never occurred
> to me.  We can add a simple API extension to lookup node-id by
> zsmalloc handle, if anyone really needs it, but I'm okay with the
> status quo (and XXX) for the time being.

Yeah tbh this path is not that much different from the status quo
(page is also allocated via the task's policy here), and all the other
paths are fixed, so this seems to be an overall improvement still :)

If someone uses recompress + multi node, we can fix it then. It's not
impossible, just more code :)

>
> [..]
> > -unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
> > +unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
> > +                             const int nid)
> >  {
>
> I'm not the zspool maintainer, but if I may ask, for new zsmalloc code my
> preference is to follow the kernel styles (yes, the old code doesn't foll=
ow
> any at all, whenever I touch the old code I fix it).
>
> Do you mind if we do something like below? (at least for zsmalloc)

I don't mind at all! Thanks for fixing it, Sergey.

I saw that Andrew already added this as a fixlet. Thanks, Andrew!

>
> With this
> Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org> #zram and zsmallo=
c
>
>
> ---
>
> diff --git a/include/linux/zpool.h b/include/linux/zpool.h
> index 697525cb00bd..369ef068fad8 100644
> --- a/include/linux/zpool.h
> +++ b/include/linux/zpool.h
> @@ -22,7 +22,7 @@ const char *zpool_get_type(struct zpool *pool);
>  void zpool_destroy_pool(struct zpool *pool);
>
>  int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
> -                       unsigned long *handle, const int nid);
> +                unsigned long *handle, const int nid);
>
>  void zpool_free(struct zpool *pool, unsigned long handle);
>
> @@ -64,7 +64,7 @@ struct zpool_driver {
>         void (*destroy)(void *pool);
>
>         int (*malloc)(void *pool, size_t size, gfp_t gfp,
> -                               unsigned long *handle, const int nid);
> +                     unsigned long *handle, const int nid);
>         void (*free)(void *pool, unsigned long handle);
>
>         void *(*obj_read_begin)(void *pool, unsigned long handle,
> diff --git a/mm/zpool.c b/mm/zpool.c
> index b99a7c03e735..0a71d03369f1 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -239,7 +239,7 @@ const char *zpool_get_type(struct zpool *zpool)
>   * Returns: 0 on success, negative value on error.
>   */
>  int zpool_malloc(struct zpool *zpool, size_t size, gfp_t gfp,
> -                       unsigned long *handle, const int nid)
> +                unsigned long *handle, const int nid)
>  {
>         return zpool->driver->malloc(zpool->pool, size, gfp, handle, nid)=
;
>  }
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index daa16ce4cf07..70406ac94bbd 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -452,7 +452,7 @@ static void zs_zpool_destroy(void *pool)
>  }
>
>  static int zs_zpool_malloc(void *pool, size_t size, gfp_t gfp,
> -                       unsigned long *handle, const int nid)
> +                          unsigned long *handle, const int nid)
>  {
>         *handle =3D zs_malloc(pool, size, gfp, nid);
>
> @@ -1033,8 +1033,8 @@ static void create_page_chain(struct size_class *cl=
ass, struct zspage *zspage,
>   * Allocate a zspage for the given size class
>   */
>  static struct zspage *alloc_zspage(struct zs_pool *pool,
> -                                       struct size_class *class,
> -                                       gfp_t gfp, const int nid)
> +                                  struct size_class *class,
> +                                  gfp_t gfp, const int nid)
>  {
>         int i;
>         struct zpdesc *zpdescs[ZS_MAX_PAGES_PER_ZSPAGE];
> @@ -1333,7 +1333,7 @@ static unsigned long obj_malloc(struct zs_pool *poo=
l,
>   * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
>   */
>  unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
> -                               const int nid)
> +                       const int nid)
>  {
>         unsigned long handle;
>         struct size_class *class;
