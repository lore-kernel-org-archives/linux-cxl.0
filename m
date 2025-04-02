Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC051F0986;
	Wed,  2 Apr 2025 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625553; cv=none; b=LeV4OFXD4Rvq0Wxd4fplr3///xY7tqj/eC8TwYs1gniSWymcQY5uG7qQ3//3Hs8jHXrh3jfJRXKAWXWcXW8g9Z2ZJFUQbQsSEnme5NJaNiK5dBWYpzkToCkMn45dN34LwrO+lsjDBylPuzQkHjoVOmMEklSR650AEEtC9kGaUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625553; c=relaxed/simple;
	bh=ZOVmuYca6KN2mDE+PT3NJ18iyZocnKkvJlWhXnqx0Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcFGpT2lzzSc1K1gZAX/yRZUDLFbetqiGeg2ohFrwFbI7QxvxfNkTYRCDcIXBLDgYotsIzIySQv3tc7l1WRa8FRKxS/pxnGqbdywzYC+J9EdR2GL5a6s23QxvqLxbAiJQ99Xip4RFzj57JmfNLgdktfTuOW/Y+/lbSlcE7No0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgpzrxJ/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgpzrxJ/"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so1634966d6.2;
        Wed, 02 Apr 2025 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743625550; x=1744230350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3DrS55bhHGD7DHOAVlR2qBGqWbDWkcAoal4Y0Sld1E=;
        b=fgpzrxJ/rLh4U3OxHJjkrcKHsor8MFTIHf/7phFaDaTQPWgsz/XN+qBNqiBCmwrbz5
         adMZ2u0XWc6+IhUjx6EceEHi0Hwb0QXGLyKEaefLzZDkzWUB//V9I8B6FEAYk95MoPPK
         Iwz1eXjogE6/HSHSjnm71Oix7AJXSf/qkuKfAbLWNY595ttBvWnuMdBYJccq3eLfzFQP
         cIUGaU+546Fa/fzy1DA/940957taCXEPubUMAYVASxnx2mHx+vAKHhlclkjYKprvtfte
         XBZTGLgXnv4y9bR6SrRkOK/ACgSjuppsM0WUKaSDynR0aMeZBlU+4e3kyEZJL/0uDdTW
         DIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743625550; x=1744230350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3DrS55bhHGD7DHOAVlR2qBGqWbDWkcAoal4Y0Sld1E=;
        b=iNg531oSX61/JNmcjBH6f9TWLvMCBv39sJ7WJQPYbt+MPGFnk4SSWglafXqYaGJYSs
         MPxlnyA8rlgdpJzAe7wZ93wEZDIWP3kpGrjCCqjQS44zXrw4tLB0mo8GRRsRLhvUt9Tj
         njanbqjLhh2Psp5j4vP3ueU7f4EgW8Zl+vTXHGK9GGKdhhQLSfuxPakK7x8j3TQKbfTl
         N/jH+y6Ec6FHMTutehyxO4KqpQusRbN6hkVNq0Tsc9bkeGR/6EILlXsUqJHWSlH8wqgG
         EPtMqzZVrTSK3ljVra2/CLZwMdrrSrH1lG5138bEnws8PPO60sYajQXt8dVdkBvHXWcA
         juCA==
X-Forwarded-Encrypted: i=1; AJvYcCUKcSwHsb+NZDIKFps0zm0cDN1uDZH9awHkdy40OQer1DJRwHocfvFZnuhgNdqwLFHByPeDY9c0shdgyD3B@vger.kernel.org, AJvYcCVnN/4HSxkJpG2zKKbMlT54hklYSZYuIMEWp3phMov5vimStFlZfBt3IDQN4hR80ghcPWq/eC5yOMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk27pazZdDSExB8FUC1vhK/FH1Ephl+I+62KHmCnrU6lhCbg4r
	/8FoLexTszHnvxC8joHqP73ZPC3ThFitYlni2GDZNnlCsiony0VBRulXPZG+TM6P/RKEwxmBoL/
	/NiKy/q23Mo/OjX0MTVOS+0acNuA=
X-Gm-Gg: ASbGncu6gTgJPphSX65ByOeNsOx+PCqsdMDMsR6BjPk1ZKE8sAeL91Il0TB8O5QcygO
	Altb8d11mB/WkNG4XxI/FXY9PQCdXtS56a4dhoV+tZMrHsCllgaDmpy5Oo1ZcokIOUU4uaXrJ1r
	xPQe9MGHsbXLwwLSX+ESULe4ODNnaJ0z0gilX8
X-Google-Smtp-Source: AGHT+IHmQed7v+lq9IkGBVOW+jNL+WtFln9asiTYwb6z9Eqqu9hKr7TL3SccBTvnlq3OWx7o3BeVjueDxgq5l619nSo=
X-Received: by 2002:ad4:4ea7:0:b0:6e4:3c52:d67e with SMTP id
 6a1803df08f44-6ef0dc43304mr2906356d6.18.1743625550089; Wed, 02 Apr 2025
 13:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402191145.2841864-1-nphamcs@gmail.com> <20250402195741.GD198651@cmpxchg.org>
 <CAKEwX=Pjk=7Ec3rE2c1SOUL9zeYGcyEOCVQqSffC6Qw077dBHQ@mail.gmail.com> <20250402202416.GE198651@cmpxchg.org>
In-Reply-To: <20250402202416.GE198651@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 2 Apr 2025 13:25:39 -0700
X-Gm-Features: AQ5f1Jq9X9Psw0eZV6-BYQrcYQnwLYFghU4MCnLCZtU85EeJ9t8dWo3sALTD_Ys
Message-ID: <CAKEwX=PJ-LQO3xffXx5-MpRBXWaCC+QQdM1kCY0=NFX4sNEhgA@mail.gmail.com>
Subject: Re: [PATCH] zswap/zsmalloc: prefer the the original page's node for
 compressed data
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, yosry.ahmed@linux.dev, 
	chengming.zhou@linux.dev, sj@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	jonathan.cameron@huawei.com, dan.j.williams@intel.com, 
	linux-cxl@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 1:24=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Wed, Apr 02, 2025 at 01:09:29PM -0700, Nhat Pham wrote:
> > On Wed, Apr 2, 2025 at 12:57=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Wed, Apr 02, 2025 at 12:11:45PM -0700, Nhat Pham wrote:
> > > > Currently, zsmalloc, zswap's backend memory allocator, does not enf=
orce
> > > > any policy for the allocation of memory for the compressed data,
> > > > instead just adopting the memory policy of the task entering reclai=
m,
> > > > or the default policy (prefer local node) if no such policy is
> > > > specified. This can lead to several pathological behaviors in
> > > > multi-node NUMA systems:
> > > >
> > > > 1. Systems with CXL-based memory tiering can encounter the followin=
g
> > > >    inversion with zswap: the coldest pages demoted to the CXL tier
> > > >    can return to the high tier when they are zswapped out, creating
> > > >    memory pressure on the high tier.
> > > >
> > > > 2. Consider a direct reclaimer scanning nodes in order of allocatio=
n
> > > >    preference. If it ventures into remote nodes, the memory it
> > > >    compresses there should stay there. Trying to shift those conten=
ts
> > > >    over to the reclaiming thread's preferred node further *increase=
s*
> > > >    its local pressure, and provoking more spills. The remote node i=
s
> > > >    also the most likely to refault this data again. This undesirabl=
e
> > > >    behavior was pointed out by Johannes Weiner in [1].
> > > >
> > > > 3. For zswap writeback, the zswap entries are organized in
> > > >    node-specific LRUs, based on the node placement of the original
> > > >    pages, allowing for targeted zswap writeback for specific nodes.
> > > >
> > > >    However, the compressed data of a zswap entry can be placed on a
> > > >    different node from the LRU it is placed on. This means that rec=
laim
> > > >    targeted at one node might not free up memory used for zswap ent=
ries
> > > >    in that node, but instead reclaiming memory in a different node.
> > > >
> > > > All of these issues will be resolved if the compressed data go to t=
he
> > > > same node as the original page. This patch encourages this behavior=
 by
> > > > having zswap pass the node of the original page to zsmalloc, and ha=
ve
> > > > zsmalloc prefer the specified node if we need to allocate new (zs)p=
ages
> > > > for the compressed data.
> > > >
> > > > Note that we are not strictly binding the allocation to the preferr=
ed
> > > > node. We still allow the allocation to fall back to other nodes whe=
n
> > > > the preferred node is full, or if we have zspages with slots availa=
ble
> > > > on a different node. This is OK, and still a strict improvement ove=
r
> > > > the status quo:
> > > >
> > > > 1. On a system with demotion enabled, we will generally prefer
> > > >    demotions over zswapping, and only zswap when pages have
> > > >    already gone to the lowest tier. This patch should achieve the
> > > >    desired effect for the most part.
> > > >
> > > > 2. If the preferred node is out of memory, letting the compressed d=
ata
> > > >    going to other nodes can be better than the alternative (OOMs,
> > > >    keeping cold memory unreclaimed, disk swapping, etc.).
> > > >
> > > > 3. If the allocation go to a separate node because we have a zspage
> > > >    with slots available, at least we're not creating extra immediat=
e
> > > >    memory pressure (since the space is already allocated).
> > > >
> > > > 3. While there can be mixings, we generally reclaim pages in
> > > >    same-node batches, which encourage zspage grouping that is more
> > > >    likely to go to the right node.
> > > >
> > > > 4. A strict binding would require partitioning zsmalloc by node, wh=
ich
> > > >    is more complicated, and more prone to regression, since it redu=
ces
> > > >    the storage density of zsmalloc. We need to evaluate the tradeof=
f
> > > >    and benchmark carefully before adopting such an involved solutio=
n.
> > > >
> > > > This patch does not fix zram, leaving its memory allocation behavio=
r
> > > > unchanged. We leave this effort to future work.
> > >
> > > zram's zs_malloc() calls all have page context. It seems a lot easier
> > > to just fix the bug for them as well than to have two allocation APIs
> > > and verbose commentary?
> >
> > I think the recompress path doesn't quite have the context at the calls=
ite:
> >
> > static int recompress_slot(struct zram *zram, u32 index, struct page *p=
age,
> >    u64 *num_recomp_pages, u32 threshold, u32 prio,
> >    u32 prio_max)
> >
> > Note that the "page" argument here is allocated by zram internally,
> > and not the original page. We can get the original page's node by
> > asking zsmalloc to return it when it returns the compressed data, but
> > that's quite involved, and potentially requires further zsmalloc API
> > change.
>
> Yeah, that path currently allocates the target page on the node of
> whoever is writing to the "recompress" file.
>
> I think it's fine to use page_to_nid() on that one. It's no worse than
> the current behavior. Add an /* XXX */ to recompress_store() and
> should somebody care to make that path generally NUMA-aware they can
> do so without having to garbage-collect dependencies in zsmalloc code.

SGTM. I'll fix that.
