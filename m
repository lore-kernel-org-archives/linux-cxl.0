Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195A1A3178
	for <linux-cxl@vger.kernel.org>; Mon, 26 Jan 2026 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769392645; cv=pass; b=ToZ8FtvnBmaV+7NhmaS2nGLyYGxrN4QHwo4BXfoq7w/KCV3nTRWmOCDgI7Y9DDI0lAceX/p13A72uGkRr+efTq4I9Ek/y2ZlMi9qqXndSTGiw7aMlwcX8WdHFRIuPo5sFQPRe6VE+t4Fva4yE5rymWwJaoVSzLnFbNa5H0U+Wec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769392645; c=relaxed/simple;
	bh=hJWMjUfYbrtZfAJ5oZoUhPpI22bRK8yfWfWkz49vATs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qI2C+a6U+V+aD9KbxDWW801VZkrkTOwg4mmEqzjpvYQ/DvO+aD/kWut+As9dpTw7IM/+GMHxjxzd4fQsrQcAI6cZZfSPn90RHXXUmYa502du1IV7OdOz8HcwKwohxVxHs2PwO/7xJZEdMB3kPybghLVPQPlOVQ6uEaTvmF+9boc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXUhGt3w; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXUhGt3w"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88fca7bce90so67835986d6.3
        for <linux-cxl@vger.kernel.org>; Sun, 25 Jan 2026 17:57:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769392642; cv=none;
        d=google.com; s=arc-20240605;
        b=jIZkcgxZVLgPeZDP49vjJX4s7ySNpr2OGWXgTE+KhPU/Z6+pXXXb6djjvuaa7SLAMY
         tAw8gbYh6UnGAtgqs+iVZP/zpJ0nsGPJZLwOotrLPkglgPwcSEka8REVh7duwA7xWBek
         ZyviNds4HJLs7zHdz08mg+yPD/3DpSY9Cxxo9aOh+YagHOFsrYaocOj2I8teLxM+iQ3o
         oCuq5paG9Z1g0RjeAYiYE1JnT9kxYKak1+Vb9+ko1SGJ8H6QbEM/M7KtSjHNSQBdFW4t
         /H5L804Ul+CivFx7OuGwSoS0vl6U70G4Cbs2JcWfD8wPxBCZoE+OCr2e1bCln6mvTpNJ
         LHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7WYlc3ruNgp5Obb3ckJRQ2VEzINlkVk7lmxzq0b9R3U=;
        fh=gDGVTNbB2fMLj87fKiGNKUBQJq9W+RUTEOFnBv+xA7g=;
        b=HrZRcPXnv6+HuVx508FylltMgWqOM9mYUO5kpeOGs6pb+Qy+rxcheTAqA8kFxDAvHe
         8ooaLpz96iOKHz+r+806a0oEtTruQ0vzKBMZWv4lJ6Z/m1VV2giW8tilcLm0SkXo5Hh4
         J105GT4UoK1sixHCZlUHYILONSEjrVa3ccklhG+CM8vuGLv1jFk+cP5PlCmaYoJvdPo1
         cMFgPVn6LsgEBBVHuiUehYmYmRX081OTaIDPwvI2hTRcABkEN6rnAxWBD4eABL1+f6Bc
         v8Scg9hPlCs9bJuk7osEbNeX/2XzZSnnL7fH1gBqf0nwNTCZnC0hNE5LQJzFHrVPw1cW
         tSZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769392642; x=1769997442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WYlc3ruNgp5Obb3ckJRQ2VEzINlkVk7lmxzq0b9R3U=;
        b=bXUhGt3wZbhPjVoxwsEQkNmfO08FcNCtE68F0zooNWU4XU3Mvf7I7qVAFSrQGQRH+7
         mpNs0YN/bGZkgI5EXGsrWcuub+/fHllUqjuic5fFDquMEQUwgZFSZ7FYvB9M80E9nVJu
         QTghW2kVKXWjmoqlUzBhEpYQ42+iC1qC9yHNqSWZIHzpqUw4evxnRLmSs9iJ5s3GCve3
         NHsytGurcw1/EjADDAT1yADeX+1f6DAmxpG3Iujr0YbloXiML2ZsaWGzpC/fFm+52OVV
         cv3WRI/tumY81+kjDA/ZPgP828bbGnZmM9hY0vnqKZSk2aZKgfYQMT0qPrvbrkE9S9Kv
         LelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769392642; x=1769997442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7WYlc3ruNgp5Obb3ckJRQ2VEzINlkVk7lmxzq0b9R3U=;
        b=KfGEjI9TDZyXcL64oC5sAreRjUREA9Lv1dcfSxUqBzEfX5MA+2V6dXu8YRIK1jl7ay
         E1Jlc4oQhIa8vPOX8Hz1Nlmv/xd4gPG78XLXijxKgsGDXMMDSbPvbSnqR3wE+415/gvt
         UykKBd7+CVuuUvJqW7hxC+QK5pDM8IEl1XRExTdO+rsZatObzmbqrckbmvEGEmIkHqUt
         WWP8usTF6D4QN7QnTEp7zXDl2HasiYf1PrXVAzqEA2oEGx19ixqt/WO1vtA5tVCHZ0NK
         MQCV5qZefGC3ou9ae7zI17v1at3UAx8oT704YMd0+gyp9FT47QLWbX4JafkarbKLXvSE
         hlfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+lljOZF6K1eQlWBZBP1g93Y24bbeLetj49WawMSbmv6wVI6LLqcJ3/UZvZeTwr0WvRHRn6LgvDV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+EpBiOJgqf6t2jBwyLehsn7HA4xrVZQwYnuHSvKfY8R9PdoH
	xgAFCjKHZsoxB46s/7MoXrXvW9oTu2tbjAhypo7pQbnCtR7UytdstAx33nBtAcyGutFoasSOl9k
	IsWQNYHRUTB+Bby9JnsYiiFXECKR+tRU=
X-Gm-Gg: AZuq6aK31e8Bj7Lgr8uSHyigrY5+BCbpOrvEOHNgQD/BSmjeM1tEWB4iVabOc+IZxmE
	GibEfUTeln2s2GIu0iyNXFM1/X0ji5zzgV72V40qBK80mgQRvL2viFCtm2xpI/gsXe94bFFy2YS
	0rBbiMl+uD7vZdQz47UlAr9XeDEb3556nBeaxKQZwdqhXx9/8p9RHaTsvZiLHujzI4mun3QojNe
	8Wg/7EmMYg8Z3OyIClG0WSgG8JX6DMzrpccxyHHr52Au2yHUDFDSoRxp6BFlBKp7VOZ5TCSvlmw
	GwAoLULT3qbopbTgtFwZnwZTyntP8lUhrw==
X-Received: by 2002:a05:6214:dae:b0:890:19d1:532c with SMTP id
 6a1803df08f44-894b075f89amr37498396d6.34.1769392642478; Sun, 25 Jan 2026
 17:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113081453.8293-1-akinobu.mita@gmail.com> <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka> <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
 <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F> <CAC5umyg+wubKoQSfpDQvNh3K5Y7+iOEYn6_BuKFd53kHDVE7aw@mail.gmail.com>
 <CAC5umyjOgZE0Qpa3W3qZ=sSkwkuf_md47jctXgi5UKWuG49o1Q@mail.gmail.com> <aXJSlv1_K1uQCN16@gourry-fedora-PF4VCD3F>
In-Reply-To: <aXJSlv1_K1uQCN16@gourry-fedora-PF4VCD3F>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 26 Jan 2026 10:57:11 +0900
X-Gm-Features: AZwV_QjosyM2EJ8-Qax2rQykQyrVBkjvCFZ66dDhYcvtgAhH-bSxND_z972-w6s
Message-ID: <CAC5umyhrcb963mA9dUaZswJKq2MF_OVaipNmy=L4J7u6rPjfqA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: Gregory Price <gourry@gourry.net>
Cc: Michal Hocko <mhocko@suse.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, david@kernel.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bingjiao@google.com, jonathan.cameron@huawei.com, 
	pratyush.brahma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8823=E6=97=A5(=E9=87=91) 1:39 Gregory Price <gourry@go=
urry.net>:
>
> On Thu, Jan 22, 2026 at 09:32:51AM +0900, Akinobu Mita wrote:
> > Almost all of the execution time is consumed by folio_alloc_swap(),
> > and analysis using Flame Graph reveals that spinlock contention is
> > occurring in the call path __mem_cgroup_try_charge_swap ->
> > __memcg_memory_event -> cgroup_file_notify.
> >
> > In this reproduction procedure, no swap is configured, and calls to
> > folio_alloc_swap() always fail. To avoid spinlock contention, I tried
> > modifying the source code to return -ENOMEM without calling
> > folio_alloc_swap(), but this caused other lock contention
> > (lruvec->lru_lock in evict_folios()) in several other places, so it
> > did not work around the problem.
>
> Doesn't this suggest what I mentioned earlier?  If you don't demote when
> the target node is full, then you're removing a memory pressure signal
> from the lower node and reclaim won't ever clean up the lower node to
> make room for future demotions.

Thank you for your analysis.
Now I finally understand the concerns (though I'll need to learn more
to find a solution...)

> I might be missing something here, though, is your system completely out
> of memory at this point?
>
> Presumably you're hitting direct reclaim and not just waking up kswapd
> because things are locking up.
>
> If there's no swap and no where to demote, then this all sounds like
> normal OOM behavior.
>
> Does this whole thing go away if you configure some swap space?

I tried it and found that the same issue occurred when I ran a
stress-ng-memrate workload that exceeded the combined memory and swap
capacity using the same repro steps.

To be more precise, for over an hour, I was unable to do anything and
of course I couldn't manually terminate the workload, so the only
option was to reset the power.

It may be a bit inconvenient that if something similar to this workload
were to happen due to a mistake or a runaway program, it would not
cause an OOM and would be inoperable for hours.

> > When demotion_enabled is true, if there is no free memory on the target
> > node during memory allocation, even if there is no swap device, demotio=
n
> > may be able to move anonymous pages to a lower node and free up memory,
> > so more anonymous pages become candidates for eviction.
> > However, if free memory on the target node for demotion runs out,
> > various processes will perform similar operations in search of free
> > memory, wasting time on lock contention.
> >
> > Reducing lock contention or changing the eviction process is also an
> > interesting solution, but at present I have not come up with any workar=
ound
> > other than disabling demotion when free memory on lower-level nodes is
> > exhausted.
>
> The lock contention seems like a symptom, not the cause.  The cause
> appears to be that you're out of memory with no swap configured.

I understand that there are issues with the current patch, but I would
like to resolve the above issues even when swap is configured with
a better solution.
