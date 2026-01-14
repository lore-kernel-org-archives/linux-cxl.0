Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D218A397AB0
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768395102; cv=none; b=fFm2LFbGQHCFmbMfTi67Q1AX1dSmCxGcO6WA8mwXrUgx4Kvr5QRayeuBRi8PgrxG1UVLKx5FbfpoSSl7eYriuJC+WXP4fThUvNyOya72h8tjSzM0s0FgC/7Btz7L3b4OWQDtXuUPaSPHnnuSDzrS1VnSG+6/U3PAV5PCgcINmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768395102; c=relaxed/simple;
	bh=KIqhmb4as2YqK1+PKTrfWitwwOPicmt0b7I2oqf0//0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Df32aBm102UvUH0jzgJvZEScLz/4ofca4BrgwUsHo66ljLEmJgZiAlMWZ8HVowaJvrEeEDDNovXGDliLrC1cXViH+Wq8fhvhUohU42vTEvHI3LErhirH/xe/wqwNEvKqBRNE2mYWkqnQt4H0QSMiRKpWMs/8yneU3MDC9CoaA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnXV8yhv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnXV8yhv"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5014db8e268so5659861cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768395100; x=1768999900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=006a5mLOBo/6Z+BZ4PGfAJrahlfyrHXjY7F8sopqUqA=;
        b=hnXV8yhvUATeJIcYg1wS/arnzuaPXU4LY6HZP02HYXIJaxORJvwWbqcUjLxOwWH+9Q
         ajL9Xc7rF9ou7rWIA1YWImQHdSC2BI7wXToma+9dVi4k9/24xJu+H/8xwh4SeClF2UUx
         XMygQFWasJ6QYtcGVQZdiGKDLzPHs6SEZtvSd+5QFPWsth3s03BmfkxM7E4tl4yiqqSU
         OlpCPVz43eiDWBb0ADkXdWdkzwY0K5RvR1aAGGwE7WWY4r5xkZodUNRgaPtTObfakj7m
         ebA/vyDGtmKj5X7gMUtJ1XxjE7lePGVKhhKCRVFkGP7fFAZSNYxm6alEAHV0u/yyzSL/
         aq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768395100; x=1768999900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=006a5mLOBo/6Z+BZ4PGfAJrahlfyrHXjY7F8sopqUqA=;
        b=EE+i5lYY5h9OZWSxPKW0y1tdiGAAQIXyuZWkJUo/gpb34AvYUyMCfEg7sJwyyynzoh
         R7ThQKNtG1p0bSIvPrReTOycZzEqdQr+u/cDX81lwPsiADqkrESs+uL6xGKfGXsyZqSb
         bWRDEjTET9hgQBruaFX0eV9wi+XenFTLAc5m2vCenI3iwb7EWSlTwKS2b3av+qzc2uka
         uTCJVVCH5M+hY58PFmsijduH+KRDQR/g3iKcsUJoXZGD+IP4L/UOOffeDrIPsGszdeRt
         kw2LT3k6U53ptKIbljIEYMFG5OqTZ5SOGXgNNgdLfH0eUQJpkkx28jOR2qxEOL2F2wS0
         UTbg==
X-Gm-Message-State: AOJu0Yz8+7tCyF2JEu6EbzWj8WmqAuaSOrPB5WoyFLPStfPxlzrKHOkN
	ldl15czvliC/KoTmkBF7z6jHwbUTaCdPN904wFP2XP2Y7Q8NE2fV9ZOS0iOqhEqI5Y+c62CidYD
	RX00TtnLfakhmNJTYiUkhKrM4q0FkvwE=
X-Gm-Gg: AY/fxX5hhpQ6pIPNAIUcz3gw/mnKKpfXJ1Q7xESfJ2Y9UOENnAG+YGoBX7309kgTJjd
	RcZnmdVpuQ0s3EMRHiTCa0UVpJlqSHdT/KAME7cEbrO/hN4OwuHFsbGZjhNs9gsYNyQhPxG3nfG
	N+y7G3LCCqmxqlSBmznES0nVr+81xnlPkTDxho24wTUnaudRbVP8YWCmeQ6Qolxl1W1hyt9RweC
	ahRnSAGJ92KnmXS/3tGuQ9it6uP4vnaEAQWrFJ2izV+YRluYBKxUrqJGosAKuTaSa3+Wfz726dJ
	zo8Qp7HkPmDU9FVoXqwTbSU=
X-Received: by 2002:a05:622a:15c8:b0:4ee:26bd:13f3 with SMTP id
 d75a77b69052e-50148229b85mr30313931cf.8.1768395099537; Wed, 14 Jan 2026
 04:51:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113081453.8293-1-akinobu.mita@gmail.com> <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka>
In-Reply-To: <aWZLZzo5Hb1aFZ0j@tiehlicka>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 14 Jan 2026 21:51:28 +0900
X-Gm-Features: AZwV_QisYgkZEmBBUAVcKZ8lXCorw-BsHC0m2W7I9C7udOLibwgtul2cNNEiFaU
Message-ID: <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: Michal Hocko <mhocko@suse.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, david@kernel.org, 
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bingjiao@google.com, jonathan.cameron@huawei.com, 
	pratyush.brahma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8813=E6=97=A5(=E7=81=AB) 22:40 Michal Hocko <mhocko@su=
se.com>:
>
> On Tue 13-01-26 17:14:53, Akinobu Mita wrote:
> > On systems with multiple memory-tiers consisting of DRAM and CXL memory=
,
> > the OOM killer is not invoked properly.
> >
> > Here's the command to reproduce:
> >
> > $ sudo swapoff -a
> > $ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
> >     --memrate-rd-mbs 1 --memrate-wr-mbs 1
> >
> > The memory usage is the number of workers specified with the --memrate
> > option multiplied by the buffer size specified with the --memrate-bytes
> > option, so please adjust it so that it exceeds the total size of the
> > installed DRAM and CXL memory.
> >
> > If swap is disabled, you can usually expect the OOM killer to terminate
> > the stress-ng process when memory usage approaches the installed memory
> > size.
> >
> > However, if multiple memory-tiers exist (multiple
> > /sys/devices/virtual/memory_tiering/memory_tier<N> directories exist) a=
nd
> > /sys/kernel/mm/numa/demotion_enabled is true, the OOM killer will not b=
e
> > invoked and the system will become inoperable, regardless of whether MG=
LRU
> > is enabled or not.
> >
> > This issue can be reproduced using NUMA emulation even on systems with
> > only DRAM.  You can create two-fake memory-tiers by booting a single-no=
de
> > system with "numa=3Dfake=3D2 numa_emulation.adistance=3D576,704" kernel
> > parameters.
> >
> > The reason for this issue is that memory allocations do not directly
> > trigger the oom-killer, assuming that if the target node has an underly=
ing
> > memory tier, it can always be reclaimed by demotion.
>
> Why don't we fall back to no demotion mode in this case? I mean we have
> shrink_folio_list:
>         if (!list_empty(&demote_folios)) {
>                 /* Folios which weren't demoted go back on @folio_list */
>                 list_splice_init(&demote_folios, folio_list);
>
>                 /*
>                  * goto retry to reclaim the undemoted folios in folio_li=
st if
>                  * desired.
>                  *
>                  * Reclaiming directly from top tier nodes is not often d=
esired
>                  * due to it breaking the LRU ordering: in general memory
>                  * should be reclaimed from lower tier nodes and demoted =
from
>                  * top tier nodes.
>                  *
>                  * However, disabling reclaim from top tier nodes entirel=
y
>                  * would cause ooms in edge scenarios where lower tier me=
mory
>                  * is unreclaimable for whatever reason, eg memory being
>                  * mlocked or too hot to reclaim. We can disable reclaim
>                  * from top tier nodes in proactive reclaim though as tha=
t is
>                  * not real memory pressure.
>                  */
>                 if (!sc->proactive) {
>                         do_demote_pass =3D false;
>                         goto retry;
>                 }
>         }
>
> to handle this situation no?

can_demote() is called from four places.
I tried modifying the patch to change the behavior only when can_demote()
is called from shrink_folio_list(), but the problem was not fixed
(oom did not occur).

Similarly, changing the behavior of can_demote() when called from
can_reclaim_anon_pages(), shrink_folio_list(), and can_age_anon_pages(),
but not when called from get_swappiness(), did not fix the problem either
(oom did not occur).

Conversely, changing the behavior only when called from get_swappiness(),
but not changing the behavior of can_reclaim_anon_pages(),
shrink_folio_list(), and can_age_anon_pages(), fixed the problem
(oom did occur).

Therefore, it appears that the behavior of get_swappiness() is important
in this issue.
