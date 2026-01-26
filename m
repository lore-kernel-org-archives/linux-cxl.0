Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B497DA66
	for <linux-cxl@vger.kernel.org>; Mon, 26 Jan 2026 02:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769392882; cv=pass; b=sDyQe/hG3sCnMuF4l4I8p21BjSYciL1sO4e2qDFmhVb4mlzqmXC2v6zUnRezm4t5jBLR58oscFYC2tPnWD6Mp27bf4Nh1gfC1AkRSJS1eO+GQXnz4eKvRigCPbpaa0ikivdH27cPVqzCC4y4Sd+klFr5oFC/R6GxA/ahkCwzhbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769392882; c=relaxed/simple;
	bh=9Y9VJiDXPVCsgHz/iEDzoY8gBmvbgLxmr0kfLRHsujQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH785F9VyGR9n3SzJw11TIX3JaXVcA5bTkkuxS8UoI+hIGork2hpwstnIYfZZHsPeORNXuYHTdg71aeInp1wXusP9z9/796YCQH810AIqwqrkjOKGkEljqAlger20ZO6DbXDPLxptayZElzXCGSO6MHvBBv/Hz0e2ffF4hwYUo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiW5sOzD; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiW5sOzD"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88a3d2f3299so45118476d6.2
        for <linux-cxl@vger.kernel.org>; Sun, 25 Jan 2026 18:01:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769392880; cv=none;
        d=google.com; s=arc-20240605;
        b=SgdBAfaC72qM1eXDl66ps5utg7heJzaVUMiIOo1V4dnos4B6pu0oJQq8qFIHQIIAMO
         VsU8AuYQqXW6swxEkq6B45B/YCE4wBh38Y5lJr9uvrNcdjSUMhtFgdzm+U2uTMIpVris
         fOwbJiWhTb1R+TARLLq5uVMmEzLa8+Y1RZ2o4qeMa6g15OHoM+zFwPYU34FkWCX4dKtb
         FHoCINCZyMjx6fdGAGvVGOs5wuHa+07VAMKEYHrTwF1miUwd+etqkZdE3GKBotf8TEZE
         lSCwrKjYfPtcy4ex/ui1lFe30DeVALz5xdkjxg0Xper4qUmFYcm5G2By+/bDvbT8IRJn
         lCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NzhBh7ZDlZbLrgRg7WaDlOzl2EY7qnwdAh0vEKPKUDE=;
        fh=6rFApyDVgYYJ4jq/4HUI3PKvcXUDnxE6Q8F9YRaUdok=;
        b=A301hrVAQBHemMBP/irC4mn1fTzPtcynp2ja6rtGFt88tESBdy87fvp7ZnC8PSOG0p
         AYOJljNY1Qxg7viXkJxLI8hS7BNaEMAzYGNNWMJxpQYgBY5Br06yW6zfVNUZlsfXgrmO
         TmuqViiw4+vAmPxqFF7jO6PyAyBNgzo5rgq87FfaoihwyEJvWBme1r7kjdNJyWF44h1X
         J/TVm3hVf6j3/GL7Kivd3XfKOgiK3g5IuheMJTUgBs1bQLNZRhUEK3VvHu2nxOu1rLLO
         L59ldHjePD9MgLmPyAmcdkrDnI0VKmsmS4dcySB8e/UNIhnuOgvGfp++BCJOEhQldpgY
         ut0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769392880; x=1769997680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzhBh7ZDlZbLrgRg7WaDlOzl2EY7qnwdAh0vEKPKUDE=;
        b=aiW5sOzDJpQF+TjBVLum/CZd9/SoErfEuVkRR2MYJH/lOY89SIdBdVmtJxcwGobVEh
         6iX2ijYP1y1MQoPVI+Gc0qKZDIpunma1EqmeUvjuGDhTD/Agc6KgW+cXI0Y6J/7ieffu
         FCZTtw6ume6ziKbhda35hp9XDxgE6zDgsJy98p58UkIZb4cYrddmdcgoRPX9m2Zx2CGC
         isTjxpv9Ydj0rZDl6WMlJMaLV1Rt+2U+rjwrMtLdp7AuADUzBmIt2nCmNlwuPAfQW4Qf
         uCT2SPcVzbn1W6SZEBIqBMyy02MwWNFystAna8b9NlaYs29EEDnxCLX6JKkJS0P42T4J
         v4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769392880; x=1769997680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NzhBh7ZDlZbLrgRg7WaDlOzl2EY7qnwdAh0vEKPKUDE=;
        b=s8a/LCl5nweGyFVacvxisf3TLvJm+3QIRCqMsW4CrXeblJNUhR6w7T1UDjq1dEFQdP
         JVLgzA9H9Zr1OD1jcjzqKFsSjiFTbFU6UzFHP20Uri71XggIAKgwOGGRQpNTVHkC/Gji
         J8KlKGGQ3bnt223Qi05bWaaam5zi2HNNVZCgdfhXmk/UF3JMP8xcsfmCXAFM+6s/SC32
         XBOVntjHvUajcSeMJ1KZz4qXB2usdXd/Y40GlefzS6jacdeClFGUVwJtIJbzuQvCDD4f
         /TGGQUVQ5r+C5BvprE4td1fvF7Ze/D58pnfdjxXzFjEV0HYqBz7Gy/srfRnbXYp/qtM3
         H8pg==
X-Forwarded-Encrypted: i=1; AJvYcCVqCMNkFrYUYUu2mcfklFXDu7S++M56BPhDYmWoTPImOZ+pB5MBpEQH+j0PQar0BYa+VZaSWluI0xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3C5Gp2P91OYaQuxj4U/P6yYaL44cYnQtVRVxTv+m7KS/b1MWT
	7uS+q7lWYrK4Jsg+29Zuee5jurOTr0QPgckv8XI9yQ5GSimhSfJDCkqUuoTQrIynPvjY35LZ/Co
	VST2XCzt3OFXDOKxjAMoLbRrUwkQL2Aw=
X-Gm-Gg: AZuq6aJtP9CkcbsboReWxRjJBewxkEQGLgONNo5C7V/1imYJC9e6MrOIOJZaTN++cEX
	jCMngLlZwSJ999+v4IGeuRAY2O63nM1rNcKYP+C2jJqXcMf1ZmQdGqWNlHWIwFO9+DXnFVGjOez
	aJlXtfjp9eVGmUbVNLL3N+zhIOXHbv6oPigHNX/AsqQTp5XUCGFNx6MN4vfcB0+fSL2yvGawXeJ
	UnVjqXpdCvEzWQ93Xn/xg9Lsh+DQ3f5Po/WTi1kP/y/8BL2vtbUrio1B3OGh9oShxChRdrJJot9
	TEuZGbjN75XTRVyt4ZkY+9s=
X-Received: by 2002:a05:6214:3014:b0:890:591c:c060 with SMTP id
 6a1803df08f44-894b07d4bbamr40946216d6.65.1769392879487; Sun, 25 Jan 2026
 18:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
 <20260122183453.2619156-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20260122183453.2619156-1-joshua.hahnjy@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 26 Jan 2026 11:01:08 +0900
X-Gm-Features: AZwV_QhE-RsBWCuK8PtjAPXjepkNFdC63aiH-aGC-nNqBILX4g3XudoFOH7HJn0
Message-ID: <CAC5umygEq6xvpDFnVnDLYLyqJV7qChEsJ_+W-KCBJ+EXj1948g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, david@kernel.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, ziy@nvidia.com, 
	matthew.brost@intel.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bingjiao@google.com, jonathan.cameron@huawei.com, 
	pratyush.brahma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8823=E6=97=A5(=E9=87=91) 3:34 Joshua Hahn <joshua.hahn=
jy@gmail.com>:
>
> Hello Akinobu,
>
> I hope you are doing well! First of all, sorry for the late review on the
> series. I have a few questions about the problem itself, and how it is be=
ing
> triggered.
>
> > > > On systems with multiple memory-tiers consisting of DRAM and CXL me=
mory,
> > > > the OOM killer is not invoked properly.
> > > >
> > > > Here's the command to reproduce:
> > > >
> > > > $ sudo swapoff -a
> > > > $ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
> > > >     --memrate-rd-mbs 1 --memrate-wr-mbs 1
> > > >
> > > > The memory usage is the number of workers specified with the --memr=
ate
> > > > option multiplied by the buffer size specified with the --memrate-b=
ytes
> > > > option, so please adjust it so that it exceeds the total size of th=
e
> > > > installed DRAM and CXL memory.
> > > >
> > > > If swap is disabled, you can usually expect the OOM killer to termi=
nate
> > > > the stress-ng process when memory usage approaches the installed me=
mory
> > > > size.
> > > >
> > > > However, if multiple memory-tiers exist (multiple
> > > > /sys/devices/virtual/memory_tiering/memory_tier<N> directories exis=
t) and
> > > > /sys/kernel/mm/numa/demotion_enabled is true, the OOM killer will n=
ot be
> > > > invoked and the system will become inoperable, regardless of whethe=
r MGLRU
> > > > is enabled or not.
> > > >
> > > > This issue can be reproduced using NUMA emulation even on systems w=
ith
> > > > only DRAM.  You can create two-fake memory-tiers by booting a singl=
e-node
> > > > system with "numa=3Dfake=3D2 numa_emulation.adistance=3D576,704" ke=
rnel
> > > > parameters.
>
> [...snip...]
>
> > can_demote() is called from four places.
> > I tried modifying the patch to change the behavior only when can_demote=
()
> > is called from shrink_folio_list(), but the problem was not fixed
> > (oom did not occur).
> >
> > Similarly, changing the behavior of can_demote() when called from
> > can_reclaim_anon_pages(), shrink_folio_list(), and can_age_anon_pages()=
,
> > but not when called from get_swappiness(), did not fix the problem eith=
er
> > (oom did not occur).
> >
> > Conversely, changing the behavior only when called from get_swappiness(=
),
> > but not changing the behavior of can_reclaim_anon_pages(),
> > shrink_folio_list(), and can_age_anon_pages(), fixed the problem
> > (oom did occur).
> >
> > Therefore, it appears that the behavior of get_swappiness() is importan=
t
> > in this issue.
>
> This is quite mysterious.
>
> Especially because get_swappiness() is an MGLRU exclusive function, I fin=
d
> it quite strange that the issue you mention above occurs regardless of wh=
ether
> MGLRU is enabled or disabled. With MGLRU disabled, did you see the same h=
angs
> as before? Were these hangs similarly fixed by modifying the callsite in
> get_swappiness?

Good point.
When MGLRU is disabled, changing only the behavior of can_demote()
called by get_swappiness() did not solve the problem.

Instead, the problem was avoided by changing only the behavior of
can_demote() called by can_reclaim_anon_page(), without changing the
behavior of can_demote() called from other places.

> On a separate note, I feel a bit uncomfortable for making this the defaul=
t
> setting, regardless of whether there is swap space or not. Just as it is
> easy to create a degenerate scenario where all memory is unreclaimable
> and the system starts going into (wasteful) reclaim on the lower tiers,
> it is equally easy to create a scenario where all memory is very easily
> reclaimable (say, clean pagecache) and we OOM without making any attempt =
to
> free up memory on the lower tiers.
>
> Reality is likely somewhere in between. And from my perspective, as long =
as
> we have some amount of easily reclaimable memory, I don't think immediate=
ly
> OOMing will be helpful for the system (and even if none of the memory is
> easily reclaimable, we should still try doing something before killing).
>
> > > > The reason for this issue is that memory allocations do not directl=
y
> > > > trigger the oom-killer, assuming that if the target node has an und=
erlying
> > > > memory tier, it can always be reclaimed by demotion.
>
> This patch enforces that the opposite of this assumption is true; that ev=
en
> if a target node has an underlying memory tier, it can never be reclaimed=
 by
> demotion.
>
> Certainly for systems with swap and some compression methods (z{ram, swap=
}),
> this new enforcement could be harmful to the system. What do you think?

Thank you for the detailed explanation.

I understand the concern regarding the current patch, which only
checks the free memory of the demotion target node.
I will explore a solution.
