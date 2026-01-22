Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AD26E6F8
	for <linux-cxl@vger.kernel.org>; Thu, 22 Jan 2026 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041986; cv=pass; b=Tb0yT2nO4kLYwXJNrCJPCUEraD2W4dyzhU6u8jadaxUOgt/dRb7b2kYOTUkcAqeva1Qw8aJh0q7uaV9LmTSxAetoJW1V7Hl70af1dKjsXtRUcGOASv3pRcJTv3UbP/uFasjUuuCM6XA8oJgoF1CoV9zFdTUpgbJqFB5pZfho76w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041986; c=relaxed/simple;
	bh=iTMcoKF6Me937Pd2rtdqS2yy5B8sIYdJqUvW988w77o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lADXT+ItsNKgquOT8EcwStbr6+A0jVhAuPpuPnKk98AsV8AWXdT9hVsNiFUsA2oWM+Bi13nlCAm+RwntCnjpHIL3Ffi7PpBxUNbR6oFPSAeQFQ+IMTpGbuhnvMMdmYQMBYGSqKpzZkNEdl6BcEbcOgl3kuY+US8g8pj55V087To=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGUmBAv0; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGUmBAv0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-894703956b8so5709996d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 16:33:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769041982; cv=none;
        d=google.com; s=arc-20240605;
        b=ewtgPlhVaS7hGyhblzYkYrDCNaoLk54FUUMNGIIyI+sjTtU0fqbk7C8OWKOCRTqDoa
         GZyznePOOsIeE96qm7K9TGojrD2jmrN7rejkSGD6zpD7ZWKSARTvHTLZj/56ShIc08BA
         jvyjWVcxUzcocMRDZBVscl+T8ko+/5p5TdOOnoXO6ajvUEmK2KTGSZQWJexi2I20qbnB
         HYPxZBeb3nMGe1WFk4AggtU3Uc89FL1rH99RcBO6w0htWGkiK9j0/WmE/emtNgW8bb9W
         c/Z5ofMkBNrT7xLAnFoSaU8J/HZ46wfuKXUpj/rQ5ESaJDUDwJxHdJpLQSh7rR3aQmm9
         6ZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iTMcoKF6Me937Pd2rtdqS2yy5B8sIYdJqUvW988w77o=;
        fh=076VXm9jnN6nSRttFxjRDxE+q+vkowuvEtRFFf1IdKI=;
        b=NZCtvcLrjEjBa1hmw5xudvXIcnPaZIDu88UZ8PoqdWzbgKJQa84wnWCUBSJKuxIp9w
         kbYUO8hXNGgDMWe+FoaNJGp/xycEhi44RJQlAFTcRrPUIvsFiBt8BhSlS3yJTXL/A24S
         4N0Aaodhq2Um4uHZj9LcqJ8+ix7fPqPDWAchtLk2x0na0rhPMsWlgHTbbpzJKlqa8Vh+
         M/p6yHrVt84Qxk3S3Gc5IHFGLyf2MsbLSFXAwV+kz0uowW4bFU7Mz2KaXjW1LwcdqJQJ
         FEUJQ3eAWyh2ElF40a2CJKGmwVEnkUWsGQhTmXVmUJ6LrXX7fmY2MtpDubVJx7Vd0hCV
         UMYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769041982; x=1769646782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTMcoKF6Me937Pd2rtdqS2yy5B8sIYdJqUvW988w77o=;
        b=ZGUmBAv0j6aXGXZ1KXOKMKOYd62DqDg3hXe/JcIiIIhiT/AtgkNlEAoMcVpZGLe+ol
         QAF3XExfIZYg6nuceHXTB+4wSIyXwQZbE+aLMdj+bYEnAMAik8n4THjhmOEEn4ilt+ev
         jI3am9d/Ed5VLtxuTmrG7TGpWWvHQAgDQDomylKHgUDAbko3bCBgrmpq/RYeKIzceu1i
         IcQUZbEI5Yx9qxk5sDlb18lmkwcAxzDPotBmN6BGd/+cxijOHvD9lDlfQuNfmqX1rCvw
         TQnk/p/aatp2ffgjgYhWJM5vORGy11kWkgBJKB+7KBUuYJI7+dOcmASwoR4g4Har7oYY
         0CAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769041982; x=1769646782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iTMcoKF6Me937Pd2rtdqS2yy5B8sIYdJqUvW988w77o=;
        b=u09dyuVCQ2Lh/xRbLPGPNFvTUxK8nCtEPvOgu+x4DbRAJ9JoYt8N9SKHOszTHgK+ra
         nFeRdz2FrEiPHCaLO3xaR8xOHqx9KzhwE+/P62xFoOiH8nc0nRRKkeuhFTKpTmGgOzjN
         YfJfHcQusBCigD++DV18Crfr3lXGvT52Ho6p4IBAI/Qp/ghgX9V3c8OXb8A8mQK5E7YI
         rF1KHBF9C5f54M9zIUmKejzZuH6b8XqgdY5dZsi0EGvrJJVyjHOkskXJfDAi7P0fLcnw
         XH7UgEXHfvzCvyPjl3SimDkmFfUQWLUEC7xNQQKg2RGJtI6opC4pA3vGf6mpTCcIM89U
         xtxA==
X-Forwarded-Encrypted: i=1; AJvYcCWf3xtLOlAEPao08jg5yYvJ7GurP+0H8/OMwpzF0SeS9xY76vELf961JN/FzZm7C9KMRt5y2ff+YTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEssLebNKFYVo2kEUFJ1eaKkC3WbEgIVuNsAvsQQd3AtAeDwK
	8gmcTYu0thIwsMg1dCGJLbUoTIgGdDdulIl6HI8a/zf/uioEFBaDYa0Gq+kUDxS7cbv3YyXssB5
	vmUW2HJowETD53YAHeJPTaguRKhJTNGc=
X-Gm-Gg: AZuq6aL2rLXStM7p3fpFyyp2azUA4KAzIn5nSDhV2PL0Q4q07WDGdniG9C5ILIXDNoa
	FPyrzi83/YuKa6maVNt5clHktM1r/gJQmAw9nLZwZESxGStr0qnHlJfUVEFuCXpVGTZv1O9noHH
	lNxuduoYUQFypQUzal7WeZjPjr6LlsBoq93n3EyJ6F3beDY0a1GqMa9BknoiBY8IxJVx8NFSTxf
	b/Zz4ZrtB1r/MLcQhxXoyWkczsjNJP7EtSKD+cRf5XO7BCK6PL3sR20WifB+Bp1F2qD36Q19Ewb
	02Ooq2U9036B3YbeWqwaAl1JmH+/MN42
X-Received: by 2002:a05:6214:1bc6:b0:894:7405:d36d with SMTP id
 6a1803df08f44-8947405d41dmr51481776d6.51.1769041982341; Wed, 21 Jan 2026
 16:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113081453.8293-1-akinobu.mita@gmail.com> <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka> <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
 <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F> <CAC5umyg+wubKoQSfpDQvNh3K5Y7+iOEYn6_BuKFd53kHDVE7aw@mail.gmail.com>
In-Reply-To: <CAC5umyg+wubKoQSfpDQvNh3K5Y7+iOEYn6_BuKFd53kHDVE7aw@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 22 Jan 2026 09:32:51 +0900
X-Gm-Features: AZwV_QiQiLo2nQtmjoCr7j0d4b1PHgJ9t-S3FgKnJWteMkQEp7_ATEdImoSoiDE
Message-ID: <CAC5umyjOgZE0Qpa3W3qZ=sSkwkuf_md47jctXgi5UKWuG49o1Q@mail.gmail.com>
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

2026=E5=B9=B41=E6=9C=8815=E6=97=A5(=E6=9C=A8) 9:40 Akinobu Mita <akinobu.mi=
ta@gmail.com>:
>
> 2026=E5=B9=B41=E6=9C=8815=E6=97=A5(=E6=9C=A8) 2:49 Gregory Price <gourry@=
gourry.net>:
> >
> > On Wed, Jan 14, 2026 at 09:51:28PM +0900, Akinobu Mita wrote:
> > > can_demote() is called from four places.
> > > I tried modifying the patch to change the behavior only when can_demo=
te()
> > > is called from shrink_folio_list(), but the problem was not fixed
> > > (oom did not occur).
> > >
> > > Similarly, changing the behavior of can_demote() when called from
> > > can_reclaim_anon_pages(), shrink_folio_list(), and can_age_anon_pages=
(),
> > > but not when called from get_swappiness(), did not fix the problem ei=
ther
> > > (oom did not occur).
> > >
> > > Conversely, changing the behavior only when called from get_swappines=
s(),
> > > but not changing the behavior of can_reclaim_anon_pages(),
> > > shrink_folio_list(), and can_age_anon_pages(), fixed the problem
> > > (oom did occur).
> > >
> > > Therefore, it appears that the behavior of get_swappiness() is import=
ant
> > > in this issue.
> >
> > "It appears that..." and the process of twiddling bits and observing
> > behavior does not strike confidence in this solution.
> >
> > Can you take another go at trying to define the bad interaction more
> > explicitly? I worry that we're modifying vmscan.c behavior to induce an
> > OOM for a corner case - but it will also cause another regression.
>
> I agree.
> It surprised me that the behavior of get_swappiness() had an impact on th=
e
> issue, so I'll clarify its relationship to this issue.

To investigate what was happening while the system was inoperable due
to this issue, I applied a patch that automatically resets
demotion_enabled to false after a certain period of time has passed
since demotion_enabled was set to true.

This allowed me to investigate what was happening during this time,
and it showed that the system was not in a permanently inoperable
state such as a deadlock, but was just wasting time while
demotion_enabled was true.

I measured the elapsed time for __alloc_pages_slowpath() that called
out_of_memory() and the number of folios scanned during its execution,
i.e., the total increase in scan_control.nr_to_scan per execution of
shrink_zones(), several times.

When demotion_enabled was initially false, the longest
__alloc_pages_slowpath() execution time was 185 ms, with 18 calls
to try_to_free_pages() and 3095 folio scans.

On the other hand, when demotion_enabled was true,
__alloc_pages_slowpath() took 144692 ms, try_to_free_pages() was
called once, and 5811414 folio scans were performed.

However, as mentioned above, in this case, demotion_enabled
automatically returns to false during execution, limiting the number
of folios that can be scanned and speeding up completion; otherwise,
it would have taken longer and required more folio scans.

Almost all of the execution time is consumed by folio_alloc_swap(),
and analysis using Flame Graph reveals that spinlock contention is
occurring in the call path __mem_cgroup_try_charge_swap ->
__memcg_memory_event -> cgroup_file_notify.

In this reproduction procedure, no swap is configured, and calls to
folio_alloc_swap() always fail. To avoid spinlock contention, I tried
modifying the source code to return -ENOMEM without calling
folio_alloc_swap(), but this caused other lock contention
(lruvec->lru_lock in evict_folios()) in several other places, so it
did not work around the problem.

When demotion_enabled is true, if there is no free memory on the target
node during memory allocation, even if there is no swap device, demotion
may be able to move anonymous pages to a lower node and free up memory,
so more anonymous pages become candidates for eviction.
However, if free memory on the target node for demotion runs out,
various processes will perform similar operations in search of free
memory, wasting time on lock contention.

Reducing lock contention or changing the eviction process is also an
interesting solution, but at present I have not come up with any workaround
other than disabling demotion when free memory on lower-level nodes is
exhausted.
