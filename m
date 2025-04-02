Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674A42A9E
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625461; cv=none; b=lF0ZPMC2kao5t0XXDBXl3Y8SDJQhe4gjuMSvI2txLn+cKOJHtqjKtRjbsZEC8JOC+HQB/Ca3sAnnZEVC+Ln88rJMvEz1Cq0lzAJeF2ieqlh4PHjTMq1r1DTzhYWCrdotAAzn5HZEi8hMxX1vlkKLSSaqheNCr6aIrExKJ/V+Woc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625461; c=relaxed/simple;
	bh=tXpnEX3tyw/SdWapN8z0fagduXq6C8vTGKb5RiIDUkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH/KY8U6fXSq9SbRI4bt4CmQUYP4/DpJXbkblMEEg0wjhgGJlrk2enfgdYt/BfJJ7af8fYHYFigGMF9An239lwpfV61IHwGZ0oplr+pdYJAr9pGaIRFErMCl7GxUFg0YTPRwGYQz/dPRMlG0c8duU8K0ToZXsnVOPWajTcwMX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KUisUPle; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KUisUPle"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47664364628so2230911cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 02 Apr 2025 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1743625458; x=1744230258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jlKsIdBA3751Uewe6o63Rt1BOvdcDnO+aqIrz5DM7Dk=;
        b=KUisUPle8a30RYJfwZpJkKBXfNSqbzLE0XrxErBP3JuHH/NhjFLQDFcpRNTnuiy5Nq
         YrFuQpaXpCkQmSjiJHTDY/hLzFkMMjhVxbo4o1nXxMoY+N1SdQbOzzpFEYMHxNh92/O7
         d+EqBQxyVeoVvjoOfu32Hg0Gdvncru7/qmg72ZyS741rF2cMWxwLOiZ8NpJsjCFWraeL
         zb5LeO8fq+DRrjCgTd0OcYbRYwnCB+1wAEFxwHasTqPmjkwG1qWFNk7GjXdBc+8mh/hK
         y0dXqBgvM1zbrBoKQo5tVXdoK/ton7g/6OiD0xfXfd3mc733E1MlV4QTcN+YEqCpXWl8
         JvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743625458; x=1744230258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlKsIdBA3751Uewe6o63Rt1BOvdcDnO+aqIrz5DM7Dk=;
        b=ZvculaC8ebezhMKMxHtnC8XdtfHoxJMf3lNsV1SCjMRn0F9PahBdAxUcYDa/Lh5/hx
         DI9oF1ondVyqpcIVK0L+9CYPSKp/0Lt3qzHBo8U8Yd4g9HbbARmi/qw7m81saYYjTK9B
         ag+ym693DVoqnjv3oT5DTRjvL+qFYHlkHJe+QGEXfOu4TLpU3KeOLPzlWYDqx+Iqi85F
         EoZgCrdy9TQPhuWa4pW7LmEp6K4OLTxLiOK85dI4i488efg3VcHmPNE0wDspq11HsfvQ
         185DV5wp1GlBrqTGc4xG18J4K6Nx79lmdiAhFUuZfwgnm/h7Qk7IIwzwsA88skXwCltf
         +31g==
X-Forwarded-Encrypted: i=1; AJvYcCXyjKuPLjwx92B+sLxCT4SAajPoo4m8Bu/acdCfsFmJZMynnTyUcfHTIM8qct8vBcxQpqeh2r/Dqpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJAqu+J6GEBFbAVh0CBI4as31/uVqT45ILhcR35fDPqKE+1fw
	ovcfeFRGnLFXIpbQrMdjpWSwK6fa8KpmUtNfrUzDnE2xXna/7tfWxysySlbOJDg=
X-Gm-Gg: ASbGncskrwMbQrvwOF9BY8z3pBT9b/PK5DGe1mZUQPe5NIarqDPuTIre78wZI4OjmMw
	Eik09x/LxZYkyzVGcPaD519rAHh1gKQI4ZrfmSVaoXy7wAN98lp2a8AVocstJ2baXywHqnI4opX
	s0O6BCuamFly4Fr8b2TvmB6XtSIFmUGKXT0DNATMbmt3L90XYMiEMpKENWClcYjpeLoyFPPcwWI
	wv5ULAFmpf6o6y6jcHQEj26hjnbtCFjNpQHXi9z5jMGRzSZRsjCwIUosoTfCbV4kDiaobL9CQ1K
	IqeLRAruH3AKPACVgRHxz5XU/GJ2v/AOL3VkUthdt3k=
X-Google-Smtp-Source: AGHT+IGLRRkKyiKbQIIEjOC/9qkPzHlmQ2oHBsFZcm/Bojdzg8BtC0+7P2RKcRzroUtH8XCrfAKOdQ==
X-Received: by 2002:a05:622a:19a6:b0:467:6563:8b1d with SMTP id d75a77b69052e-4791615e3c9mr13324771cf.6.1743625458002;
        Wed, 02 Apr 2025 13:24:18 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-477831a6579sm83209061cf.73.2025.04.02.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 13:24:17 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:24:16 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev, sj@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, gourry@gourry.net,
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	minchan@kernel.org, senozhatsky@chromium.org
Subject: Re: [PATCH] zswap/zsmalloc: prefer the the original page's node for
 compressed data
Message-ID: <20250402202416.GE198651@cmpxchg.org>
References: <20250402191145.2841864-1-nphamcs@gmail.com>
 <20250402195741.GD198651@cmpxchg.org>
 <CAKEwX=Pjk=7Ec3rE2c1SOUL9zeYGcyEOCVQqSffC6Qw077dBHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=Pjk=7Ec3rE2c1SOUL9zeYGcyEOCVQqSffC6Qw077dBHQ@mail.gmail.com>

On Wed, Apr 02, 2025 at 01:09:29PM -0700, Nhat Pham wrote:
> On Wed, Apr 2, 2025 at 12:57 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Apr 02, 2025 at 12:11:45PM -0700, Nhat Pham wrote:
> > > Currently, zsmalloc, zswap's backend memory allocator, does not enforce
> > > any policy for the allocation of memory for the compressed data,
> > > instead just adopting the memory policy of the task entering reclaim,
> > > or the default policy (prefer local node) if no such policy is
> > > specified. This can lead to several pathological behaviors in
> > > multi-node NUMA systems:
> > >
> > > 1. Systems with CXL-based memory tiering can encounter the following
> > >    inversion with zswap: the coldest pages demoted to the CXL tier
> > >    can return to the high tier when they are zswapped out, creating
> > >    memory pressure on the high tier.
> > >
> > > 2. Consider a direct reclaimer scanning nodes in order of allocation
> > >    preference. If it ventures into remote nodes, the memory it
> > >    compresses there should stay there. Trying to shift those contents
> > >    over to the reclaiming thread's preferred node further *increases*
> > >    its local pressure, and provoking more spills. The remote node is
> > >    also the most likely to refault this data again. This undesirable
> > >    behavior was pointed out by Johannes Weiner in [1].
> > >
> > > 3. For zswap writeback, the zswap entries are organized in
> > >    node-specific LRUs, based on the node placement of the original
> > >    pages, allowing for targeted zswap writeback for specific nodes.
> > >
> > >    However, the compressed data of a zswap entry can be placed on a
> > >    different node from the LRU it is placed on. This means that reclaim
> > >    targeted at one node might not free up memory used for zswap entries
> > >    in that node, but instead reclaiming memory in a different node.
> > >
> > > All of these issues will be resolved if the compressed data go to the
> > > same node as the original page. This patch encourages this behavior by
> > > having zswap pass the node of the original page to zsmalloc, and have
> > > zsmalloc prefer the specified node if we need to allocate new (zs)pages
> > > for the compressed data.
> > >
> > > Note that we are not strictly binding the allocation to the preferred
> > > node. We still allow the allocation to fall back to other nodes when
> > > the preferred node is full, or if we have zspages with slots available
> > > on a different node. This is OK, and still a strict improvement over
> > > the status quo:
> > >
> > > 1. On a system with demotion enabled, we will generally prefer
> > >    demotions over zswapping, and only zswap when pages have
> > >    already gone to the lowest tier. This patch should achieve the
> > >    desired effect for the most part.
> > >
> > > 2. If the preferred node is out of memory, letting the compressed data
> > >    going to other nodes can be better than the alternative (OOMs,
> > >    keeping cold memory unreclaimed, disk swapping, etc.).
> > >
> > > 3. If the allocation go to a separate node because we have a zspage
> > >    with slots available, at least we're not creating extra immediate
> > >    memory pressure (since the space is already allocated).
> > >
> > > 3. While there can be mixings, we generally reclaim pages in
> > >    same-node batches, which encourage zspage grouping that is more
> > >    likely to go to the right node.
> > >
> > > 4. A strict binding would require partitioning zsmalloc by node, which
> > >    is more complicated, and more prone to regression, since it reduces
> > >    the storage density of zsmalloc. We need to evaluate the tradeoff
> > >    and benchmark carefully before adopting such an involved solution.
> > >
> > > This patch does not fix zram, leaving its memory allocation behavior
> > > unchanged. We leave this effort to future work.
> >
> > zram's zs_malloc() calls all have page context. It seems a lot easier
> > to just fix the bug for them as well than to have two allocation APIs
> > and verbose commentary?
> 
> I think the recompress path doesn't quite have the context at the callsite:
> 
> static int recompress_slot(struct zram *zram, u32 index, struct page *page,
>    u64 *num_recomp_pages, u32 threshold, u32 prio,
>    u32 prio_max)
> 
> Note that the "page" argument here is allocated by zram internally,
> and not the original page. We can get the original page's node by
> asking zsmalloc to return it when it returns the compressed data, but
> that's quite involved, and potentially requires further zsmalloc API
> change.

Yeah, that path currently allocates the target page on the node of
whoever is writing to the "recompress" file.

I think it's fine to use page_to_nid() on that one. It's no worse than
the current behavior. Add an /* XXX */ to recompress_store() and
should somebody care to make that path generally NUMA-aware they can
do so without having to garbage-collect dependencies in zsmalloc code.
