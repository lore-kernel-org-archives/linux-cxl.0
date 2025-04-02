Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF1619CCEC;
	Wed,  2 Apr 2025 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624583; cv=none; b=fvPm7FIffMnkZa7x0Ef+nQ8zZOa65upNmmY8VmXzUMrhMVCfxE8Qfy2xe1MtImkTOc5dk4bn/aR7un3BEPMBfovLQ6KW26L1+PNIU5YIII7vjXAKPshDZ7tzjdtzZpQb2URqXkQBe1Nq2mBugr84m7iMmfdSP6sZVYOeArtyfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624583; c=relaxed/simple;
	bh=U3vz8FoeiElOthdSsXIj6w3Vi9iOBPEWWR2bNr1/f6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gnj/DW0lNAbKJ9tvok+eypaoV2LSOnv433IbKYJTSVXRCbpZSVFVJJNM3EL2h5gzijwWb+U8Bb/zVY32xiG942EodUFr2mSMwytnuZrmO0ncsi29mqkoVckyK/oal5lqv5a8XCa9AE3Tc35SZmv9u9Lajcr5QYrnqH+St47VuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb/oH9Nf; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb/oH9Nf"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso2647006d6.0;
        Wed, 02 Apr 2025 13:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743624580; x=1744229380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI+hDVvk/lnDL2A8AC7WBXR/LV2+ef/NDppre0X5ehI=;
        b=Kb/oH9NfvvQIiEQqbjeN7AB2CRFTkW1XTSjuZukjFfpJEIJ+shF9UqgSrn+hbwbtjp
         GctkARhDzwOQtBNnNUDjlxqbxymUSuQHpnLpl2atsF0aQ9ygDGZznGtbBKj0oN6AwGM+
         6M6bhxccVJ/SJFnNelswpQg5JB3z3XcX7+LPtApgtaS/fS8x/3kXmWjKJrvGhIAMw4O1
         F0YM4nvD/P2EWr3DA6yxz14Yt7MltY7nrwD5oIfGckdJ2btOb7+IXCmz+CWhBnWTnuAc
         Gt8vjfIaYm1Z/0KH7qS1R9oA6oppPK9QTGsBKJQjhH3jbJ7WJWFGtzr7YZcH7ochNuhW
         ySGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743624580; x=1744229380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QI+hDVvk/lnDL2A8AC7WBXR/LV2+ef/NDppre0X5ehI=;
        b=imxyu+MiYqnMn6ryCxAkWCmFJgrQElEYXB8lgH7BAnIQAEwApc19KwYn8WkX2d6zIK
         V9YTtVoTYShG9sL1lby6w3/boI5b/vk6HB8C75dYhKYbsIqz1YjvOMTcHIySbjo4N548
         MxAThrXErRyjEJAHfkfRv/alfgfXJO0vdc0H8ihGoT8wBa0+ANOhnVDFp+hw7fRssbei
         MB5zhS/vgsTqfU4a+1eutDf7rRjqAjjqdWKaeMyYnehrKvWQubEflhdwm6T7hu+LbDi5
         n7Gb3gTNC5llI17L3tJ2ptqkzDdl7/JAXW0hGoGXBqz9Z2HSdj7Vn5WE4wieFn9xBbS9
         aL+g==
X-Forwarded-Encrypted: i=1; AJvYcCVZFDQfsBkeVnyqo/l2gr9+A/P+xK8bxFhElJdMXvAheM4olESzUQ8faecZ+NtBfNoWoeERAwvEcHc=@vger.kernel.org, AJvYcCVmMc34rDtA5KGrjmQB/qZG1eQ2fDJIrqQ1yQlcF8xqEHstvK18JWIiDaVDeglyUVM9AP30eUS3+eWp+6pr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hhHDZZ2zvgDcpB07QI8toGjqFPJx8SdY/gqo8423Sa4znW2X
	K2LKfqXxtOmA0u1TT63iOmsXlgms5aSIb0axVNHLU1TXKpH/rYorcavnuhMuY06GuZVT0zMC5j+
	5OLGpnsH3ANUUUGjaysyYvG1C3ZBbqgpBnjs=
X-Gm-Gg: ASbGncsLyaVCuDCD44jn7afgPHnG66AAi/ZsVtMNnP/XE3eau5enWwmr+8G2NmUFg0/
	q7KG9Ij7VuKB/i4LR76JaEVdboIpWxmOlQShj2z0zlwpIlsBgbB7uywOTrURNMvBQGz5BGERSvn
	Wb2BbCkeWGh3LnNVCbdZCNGHsrOw==
X-Google-Smtp-Source: AGHT+IHKzklSU5dCAuInQGhnRSYikjtIZn6796G74lMwNSFf8x7It/71egFFr6iRafiwhbRR1xXRjkt+57dX4pFkqdw=
X-Received: by 2002:a05:6214:2624:b0:6e8:fbe2:2db0 with SMTP id
 6a1803df08f44-6ef0dc538demr1435556d6.30.1743624580182; Wed, 02 Apr 2025
 13:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402191145.2841864-1-nphamcs@gmail.com> <20250402195741.GD198651@cmpxchg.org>
In-Reply-To: <20250402195741.GD198651@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 2 Apr 2025 13:09:29 -0700
X-Gm-Features: AQ5f1JqI1gioD_bl8uUZFOfqwHMpRQhwqqha8JdVJUBjsVeCXGxQHoX60KiYz0c
Message-ID: <CAKEwX=Pjk=7Ec3rE2c1SOUL9zeYGcyEOCVQqSffC6Qw077dBHQ@mail.gmail.com>
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

On Wed, Apr 2, 2025 at 12:57=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Apr 02, 2025 at 12:11:45PM -0700, Nhat Pham wrote:
> > Currently, zsmalloc, zswap's backend memory allocator, does not enforce
> > any policy for the allocation of memory for the compressed data,
> > instead just adopting the memory policy of the task entering reclaim,
> > or the default policy (prefer local node) if no such policy is
> > specified. This can lead to several pathological behaviors in
> > multi-node NUMA systems:
> >
> > 1. Systems with CXL-based memory tiering can encounter the following
> >    inversion with zswap: the coldest pages demoted to the CXL tier
> >    can return to the high tier when they are zswapped out, creating
> >    memory pressure on the high tier.
> >
> > 2. Consider a direct reclaimer scanning nodes in order of allocation
> >    preference. If it ventures into remote nodes, the memory it
> >    compresses there should stay there. Trying to shift those contents
> >    over to the reclaiming thread's preferred node further *increases*
> >    its local pressure, and provoking more spills. The remote node is
> >    also the most likely to refault this data again. This undesirable
> >    behavior was pointed out by Johannes Weiner in [1].
> >
> > 3. For zswap writeback, the zswap entries are organized in
> >    node-specific LRUs, based on the node placement of the original
> >    pages, allowing for targeted zswap writeback for specific nodes.
> >
> >    However, the compressed data of a zswap entry can be placed on a
> >    different node from the LRU it is placed on. This means that reclaim
> >    targeted at one node might not free up memory used for zswap entries
> >    in that node, but instead reclaiming memory in a different node.
> >
> > All of these issues will be resolved if the compressed data go to the
> > same node as the original page. This patch encourages this behavior by
> > having zswap pass the node of the original page to zsmalloc, and have
> > zsmalloc prefer the specified node if we need to allocate new (zs)pages
> > for the compressed data.
> >
> > Note that we are not strictly binding the allocation to the preferred
> > node. We still allow the allocation to fall back to other nodes when
> > the preferred node is full, or if we have zspages with slots available
> > on a different node. This is OK, and still a strict improvement over
> > the status quo:
> >
> > 1. On a system with demotion enabled, we will generally prefer
> >    demotions over zswapping, and only zswap when pages have
> >    already gone to the lowest tier. This patch should achieve the
> >    desired effect for the most part.
> >
> > 2. If the preferred node is out of memory, letting the compressed data
> >    going to other nodes can be better than the alternative (OOMs,
> >    keeping cold memory unreclaimed, disk swapping, etc.).
> >
> > 3. If the allocation go to a separate node because we have a zspage
> >    with slots available, at least we're not creating extra immediate
> >    memory pressure (since the space is already allocated).
> >
> > 3. While there can be mixings, we generally reclaim pages in
> >    same-node batches, which encourage zspage grouping that is more
> >    likely to go to the right node.
> >
> > 4. A strict binding would require partitioning zsmalloc by node, which
> >    is more complicated, and more prone to regression, since it reduces
> >    the storage density of zsmalloc. We need to evaluate the tradeoff
> >    and benchmark carefully before adopting such an involved solution.
> >
> > This patch does not fix zram, leaving its memory allocation behavior
> > unchanged. We leave this effort to future work.
>
> zram's zs_malloc() calls all have page context. It seems a lot easier
> to just fix the bug for them as well than to have two allocation APIs
> and verbose commentary?

I think the recompress path doesn't quite have the context at the callsite:

static int recompress_slot(struct zram *zram, u32 index, struct page *page,
   u64 *num_recomp_pages, u32 threshold, u32 prio,
   u32 prio_max)

Note that the "page" argument here is allocated by zram internally,
and not the original page. We can get the original page's node by
asking zsmalloc to return it when it returns the compressed data, but
that's quite involved, and potentially requires further zsmalloc API
change.
