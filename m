Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122720;
	b=i842jAV2EmIPsCKhAq2jzwhG60iLKtmra11rjJBjvKudh1vVW6WWIAd2oV6y8yWjMCED
	 vwFN6ZnQKuH9X9OS8qXFGb1VpUjXdJQhxOo1dQWJD1aYR4DLtInu557urV38zJSltK4ZE
	 yqHa11YJEdyjtl6/h2WBQjun7bWy+wg1admWVAyJAh7hjs/W2Xzv7UhLIrinhr/2yQLNL
	 9t4ev4xMLEeElhwZTcAdosrmJE79EvwoOezDT1v+Uxgg7SCONkI0dliLrWadhfNR4u6DT
	 g7vIgRt+EQZ8Z8KM6nAsRmfDvCYNIo4Xobgtopuq+iIkTJM+pMGiDeQh4Qc3aVayBUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122720;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
	b=npUag6PNJAH7d8rEEPzPLw9xg0TFTmXPSC6ztgHERAvbKToZmz3nw8wTtewnM8NHzAGd
	 3ddekV9JK4acXMomcy2M76Cspk4SSIMEqr4jkyKmECYAq/YzkNc9LwGpF7Os8C5iIRpr/
	 BmtHvVLl+QnlTwscsrAVXDpX5UA0KGzbsjnSrnDLjV400FKvgkhDdzUNkk4dPBWrxMI60
	 SeK8d3Bfzu8Gfgy8i387njfDIZg3KNCjDjrzZriY3opUqNLYAGE9RzeGOc096Uu5AaFDI
	 gWRLcvXd3isfL5VKhMZkrKCHOLQA6AC0qpwvCnyzkRoPifYUFrLXk+s1E+eUkBstiyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TMbu8PxL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A98606A320
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 17:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79A98606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TMbu8PxL
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso1005a12.0
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 10:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122719; cv=none;
        d=google.com; s=arc-20260327;
        b=cz4UlYv5N8yw/CtBrzsOl0O+5ItKWp2T39+loGEzmKjpP0l8mDHBRnDbGa7IriFKrc
         m4AkB01akfnH3wDtoNDNCGPudV2S11HygPGkTyKTz+bF5hujuHYTRdjpOcviMtnEEKRv
         1VmcQcQUYgnOKQ2zMURP0OSNlRdee7WSafH5tP5xDbwvDvwi9fsv9jBWmJ93l2oVp2q7
         IpBr8yrjgQxEqqIuo550Yjsi7dQhM0ya7fIVjZJzo3upG+liesrgo44bs0I1OCnuBEJB
         01ELx6vyMz8T+GM4sZC03hdoHuKNrf1OZi7kzb1Hc6bjUAsBwF23r8YUSvtQQK1+fGTV
         7oCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        fh=qncHR+iQnRKU77hLxvKo/WCXjweT7KL0WnJK5zY0sJg=;
        b=O0Neu7NGiAPMquCmnfCYTWXY49l6+WoBKoeaIp+NB0z8c7G1MSaasyInKTrVcpp8lK
         k3MmrdepbXplUz3xGjV1lTFSZX3o0isXsPXnzLV2KasSJbh0F61OeJSmywy/s01XCStF
         CTUuPTyvHaa108JPlG7BsWtWxoHJTkoSQ55trB8Bj3dpWsk2+fFcK0jaTzAtalHY0Tay
         gvam22Z4D5+5gXNg+30fijk2ZkRAvl2r9K3ZuV1ksxe1BrS0bv8gr5zs/xA1aPUfpGZU
         DJknzeYvEnxKiH/gYAbmfLhPhtaVapKLVxwNhHTzHn8QkD1z563rFsow+DW9G091NEbj
         IcbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122719; x=1793727519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=TMbu8PxLhpBm5Jxc+UmD3OrKaB4W+TrO+HcdLK/qemtnz4THsUOJblzPEUuFNQdsAX
         xVppISd9HZVk1k52dXnBDZH5JY2olDDSO95++GZTKXt09LrvWQXh0bdmoGTLejAK1OLt
         bxZAkxblGRQiGMML4G9URFa8xQWaDlL49VzCVKznumP2+MyKHmYFopFrp7Vomsp36yZT
         yCc03PZELOyQAfukDHyz3vOgAGIADyvURsSBd2Fsfa6RJBwz/JWJp+HSEvxtvlpPmo9U
         hDMP72JYBeOYHs8QzW38V9/J7Ub9YckAD4l0ZmHIvx0H8IlISifANZcUpwjvV3oxhTkL
         uyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122719; x=1793727519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=PN+S1FkzMuQWePQcOqNxlaQfA0466aMxozG1VKJW3X8Ye0ri4dlboFJ2+FZsw/2Nt8
         Eqcl4V5ELczZ78ym9zmoBFcwU30G6POdBpTI8lfOz64ry4KMPDD+rDTtwtay5kXJC6KL
         aahJpzUml1g6Z+qPXZMiUjgttLBu2h8WRCoL/mnIl1Pz81Q6a3UAR1MOylDpC4V7zX2A
         PGMFY5SpdERdmLC4w22czkJkFN3Aqo6IDADMCygHObulh/lOgvg+tutsYNT9FXCsYdgo
         VHVVB19OEghmThDviR2w5kf7C4hHdUSB8vU3y1y1F5oMV34Tn6c6akLHDloA/8zAKBne
         dpHw==
X-Forwarded-Encrypted: i=1; AKwUvBysFv2CHkJxjNDvvNm7eYYZBUhemRRn6lzJsVBKpEJxtxD0AMDvL1ORqUyylpgt7KFH04cHBKCJOJg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYfL/Exmu72llKazlmCnTyhYslr9AhTxiNx4GDuY4XMVDD/FzP
	Pj5TkkWW1ABpIzYKX/3wcGsK0M0olRdtssUhvY20P7WbvUZcP2bH6UMRXaPVbvQBZGm1hXLHbD0
	M9nIGXvFpOJ7Zg/OoAMy7jjdwiMd2P9LW+DHDQeA5
X-Gm-Gg: AYBFou1927iuoJlbK2j/P1kVCg8+Gy4Yo2MIJjyfXDDIxaEKd0rtrp44vRyBBKHre/d
	SFsp9B4wnbpHRxOgzYWW/sYpahvt+IMo0qBo0S3yL5Q2rQUzqPLpviP1TcGzPU4Z+8AcZj6kLZx
	Nhq+YZP9Ro8AV5K0ATd8I087M35SJc5FU9C4Fjg+c2479XfOztDUpMCdYyVR0j/WiRZ3eYXzkk+
	op0GrXjiyommQKDTS5IdGB3uIMeNyrBQpzvixeqqfB8CbTgxRUDtkd+OX+KmU6b8fiK6zdbZlHS
	XsdwRvh9ZixCqNUyQLOdfVyv21daZst2FPqmK87DLIz/J3vLsAax/Rn5/AkHFM7wuxK7AwOcSL7
	/kXwO007MBMRzn8LA7dkhbV3Aj2RJDEyU1o1/KYNWS/Y7dWr5jXPl3vPQzoEQLFzpgQ==
X-Received: by 2002:a05:6402:a2cf:10b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b4994c5b30mr2214a12.5.1793122718174; Tue, 27 Oct 2026 10:38:38
 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org> <auBityGTDQjXURWg@gremlin>
In-Reply-To: <auBityGTDQjXURWg@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 10:38:22 -0700
X-Gm-Features: AclHuK8I8xcfhrxH9JH4rYz28CrMoohsxda9QortkIHbiI93aH5ozWron9iLPAM
Message-ID: <CAJuCfpHEHPNj9DKOGbVHYCUsmLf==-XkhzBAR94gNt_ErhdnnA@mail.gmail.com>
Subject: Re: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 1:43=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Oct 27, 2026 at 12:17:43AM +0100, David Hildenbrand (Arm) wrote:
> > userfaultfd_unregister() wakes pending missing faults before clearing t=
he
> > VMA's userfaultfd registration. With per-VMA fault locking, holding
> > mmap_lock for write does not prevent another fault from queuing after
> > the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
> > waiter can then remain asleep indefinitely.
>
> Oof.
>
> I guess userfaultfd_clear_vma() only implicitly takes the VMA write lock =
via
> vma_modify_flags_uffd().
>
> >
> > Call vma_start_write() before waking waiters. Existing fault handlers
> > queue themselves before dropping the VMA read lock, and new readers are
> > excluded until mmap_write_unlock().
>
> Clearly an oversight from the VMA locks work. I guess was always a Hercul=
ean
> task to catch every single point at which there is an implicit assumption=
 that
> mmap write lock ~ readers (esp. faults) excluded.
>
> >
> > Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
> > Cc: stable@vger.kernel.org
> > Reported-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  mm/userfaultfd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 669f71d485d02..7e30b5ff17be1 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >                       start =3D vma->vm_start;
> >               vma_end =3D min(end, vma->vm_end);
> >
> > +             /* Prevent new userfaults from being queued after the wak=
eup. */
> > +             vma_start_write(vma);
> > +
> >               if (userfaultfd_missing(vma)) {
> >                       /*
> >                        * Wake any concurrent pending userfault while
> >
> > --
> > 2.43.0
> >
>
> --
> Cheers, Lorenzo
