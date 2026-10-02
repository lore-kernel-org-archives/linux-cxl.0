Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B003B0ACB
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964104; cv=pass; b=QghvGKY16JKruSX4irPbDNDRjCE1lYiwXLEEM2JAZ15FV4OQR67VG9satnB5Oz/hKLARf+MugtkfzAWnrio2hi07DNx/k0Pf22Tl42MyYjNJIlauY4QkoAutFII/VmYPZc4lvkUzubanD1yHEBqi4ZVMS2NQld6N6DP+F3RLJ9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964104; c=relaxed/simple;
	bh=OZtAOnUwtWtjmlSyU9BQ6bsranFO1OJGKTec5zM9kRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDnAJCO5tmaI1MF9+N+2LG29d7W9VpvyLvUTu1NUsmty2d+6hAsZr+wk7llBdIvabr/6CPsN6JMTOjpafSJNDhrJVI/s85UBppBe4kDsyJ2o5HFOB4RG2zM2N5qtlvxBw0mTrkIpxz37lp7Do0NwZwzCQ5TU8qgpW6ocsv9vGwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msx3mXEj; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msx3mXEj"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso269790a12.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 Oct 2026 11:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790964099; cv=none;
        d=google.com; s=arc-20260327;
        b=SvnJSI3INg/F09twmUd6nkisVrCKDvilUAk6hEX9SwYhEyajKlTp4bsMoPGKRNy5Ub
         /YjhkW8VIue1FmgNQxsOW81QgiBTfFqGWKnHNOrYo4owS3jr9wAy4L4btKfRFmp8G2Px
         HfBNMgWFpwLvrJa+QuM4MY2cV3aPSmIxpdvGzlvByHTK8ANCq8F+3ojrblc5WpiJXzr/
         xTZiYPjr3873kdOzd9nbJvuAzAWvS6ikbjpuE6DDba2YBcy/nB5yZynZlmGltdoOh7X8
         wlsA1n6382+EU2rvYOGM5lpUTshwKOVyFSwcRnUGXQzxKtkHS6dJ9uoSE8kYM+FRkg51
         EjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G+4EbiFBNnqYgSb/qkcxogR3PLMkymIv1+oGaFz8J9Q=;
        fh=R0MDWZ3LP9Ey9LfusALxVLNdgEAJmTWAKi9cCKwA9MA=;
        b=bMiZo/DEsi1J0Xl1fe1T7i3znUrUxWmX9MaAKNenXneGnAFfEqeYZ7CJ035Ufb8Jid
         KBvvE+zbdrWAcSHOZTMKZODOQkRfFsJqBag3VqSph//LcQZRnDjmLtUsWo89OhgWLkob
         Mdygp638i7WXhqO5BaKRvYTHgFWN/1NRe91kC8T2PIDlvnG39Vy+oHjvzFZTIkU1achI
         yCoM65H2hUMt6KiLRi+8bNPobQJaryi00k7BYTlOWPTNJZrpPShWEi5wX4w1Ed8nhHl3
         GUs9wqXIyyhQhOwtKhEORSJAUghNXdwLIJa74MjNp1XGXUqoOUKV2yHyHEJY/Xa+LVun
         cOwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790964099; x=1791568899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G+4EbiFBNnqYgSb/qkcxogR3PLMkymIv1+oGaFz8J9Q=;
        b=Msx3mXEjnEvlfJ2Ewc3SP33H2HZbfKF1CyQoJATljKMk2za3cSfy5V2QTgahemOLWm
         QVv5OIPZvDUwQPms8VZkLpPqdTdX5qDDjJ9nFYKYYwAwjLBKb25mXIOwAb+D7/aB99DA
         u5dI2yrCI8INL0bTv96Qr3Lo0G6cQahmTXiunHsZ59VNy+wRKugoxDdjxwqwA9/+2ErR
         YHJ2+3oGZ2m2uv+gPR6InXHjdjKk5/Z6NPFT8rd4lpxBbWZfJV+yPAFJVTZCg3eFC3m7
         NIr90shs4Qrr8WKyDCZfj2pAQc1GXbY00rzAz/90uWOxYdM4TA5GoMikrtMEMxJn9OVG
         0tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790964099; x=1791568899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+4EbiFBNnqYgSb/qkcxogR3PLMkymIv1+oGaFz8J9Q=;
        b=ILrHe/XRYSgmrXL4uSDTsjwhddQTntn6x2utDQYplOoKMVqMtzuprS4Ok7kIIubq6z
         h/+VD6hm3SiHuzc6rsh5Pvh3M0WFi3i13K8XMEiXg+/hEwIwwE9UzEyv++KMW3R3bClu
         sVkL8IMq2vGLyNMu8rH1vlBxe+CoBtja3BX3pMz9M4qYncR+VDAie2T43QZ393xoDqfY
         cjTSKaDs1SJCWI74EVM2b7KTtit+AUFH7U3/pnsye037I61YHHaorqW1UX3g/VmJ0hFI
         t8OnhfEUh0JuC4wWdvON9V4Q52zcKxOWLcm0OD+6GRu9vOialm7XU1/5T5OIkht/UqAR
         chuw==
X-Forwarded-Encrypted: i=1; AKwUvBzr5G71Lk0xgAyX8m7f+IBiyNEmZi23yTGw6+6o4ii13pqdF1LNWnbr9R/9WnbBqY+IF8PpumHYrl4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOimoeLAW4zQVD7r2lVBCQH/5yzDYLTICCTdGi/EE92VrCZ1HX
	2h5K26SNHCZxUvi4wqBo938xV1qURh8CCHfoz3lp40lyIHMEAapqvu3aqgXp39/5qQi7Ev8yKh1
	zuSka044VjcXHRry27YnsF4pDfUaVZ/ZgYYsF
X-Gm-Gg: AYBFou2N8RSq/f70zj+RsXeOs/dL2qJoABir1ykkJUfFEy/2pZ8+1rkOxoE4WhHtVIx
	r5Abj5ar9zwQyRxTGhAHrB2R8uKkHykqDLrTao4ujYC43DR0Tib3a2+Go/NMQSxa2NLZtBaMJba
	fHo0oOIim0LpNsGAGmFKIMB7Y+ivIzvZXKgVYmALssGJ/IRXTemP8NrBxbpJ8xh/Il9zCo8/mj7
	WuyCc2BM6XzMQj1EGoUZ94jJya01XQjcLwlymQ8RbiG8mpWfyiZQDwLgNx1Yp2JlhsdT6wnUw1p
	CA9kvRLeGsA9cKf2potZZuvhTXVSraAa7vRkUJVtRCNyRyZep+YivO7XT1PAD6L2AJM=
X-Received: by 2002:a05:6402:4543:b0:6ac:765e:def2 with SMTP id
 4fb4d7f45d1cf-6af9e37a328mr2000619a12.41.1790964098443; Fri, 02 Oct 2026
 11:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAiJnjqz+OB+PmUQBENS8ThnWHSAFK=p3EA7KPsy5UeabQCn-A@mail.gmail.com>
 <ar_rPzLhXRSA0AfS@gourry-fedora-PF4VCD3F>
In-Reply-To: <ar_rPzLhXRSA0AfS@gourry-fedora-PF4VCD3F>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Fri, 2 Oct 2026 21:01:27 +0300
X-Gm-Features: AclHuK-vl5tAzwgoppMvS5Z9IRnATx9Ht1qOfMIeFmMbuIVN4mgOaojwbtQXzeo
Message-ID: <CAAiJnjo86U27YwFNSkQNvqxDyGMZomoqHToH3GqWuzqD2+V0Vg@mail.gmail.com>
Subject: Re: Poor memory bandwidth performance between NUMA nodes
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  - Optane has like a 3x worse write bandwidth performance than read,
>   so expect it to be significantly slower.

Single Optane DIMM (1st generation Apache Pass) has sequential write
bandwidth ~2 GB/s
But each of two namespaces is interleaved with 6 DIMMs.
So I would expect sequential write bandwidth per namespace ~10+ GB/s,
6 times faster vs observed 1.4 GB/s.

Lastly I migrated (by migratepages command) Valkey pages between DRAM
NUMA nodes 0 & 1, and got the same 1.5 GB/s with the same profiling.

Anton

=D0=BF=D1=82, 2 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 20:47, Greg=
ory Price <gourry@gourry.net>:
>
> On Fri, Oct 02, 2026 at 07:16:12PM +0300, Anton Gavriliuk wrote:
> > Hello
> >
> > There is Fedora Server 44 (up to date) on HPE DL380g10 socket server
> > with Optane PMEM DIMMs configured as system RAM for simulating CXL
> > type3 memory expanders,
> >
>
> Couple things:
>  - if possible trying onlining the PMEM in ZONE_MOVABLE.  This may
>    help avoid kernel data landing in PMEM which would be very bad.
>
>    If page pinning is required, then this will likely not work as
>    ZONE_MOVABLE pages cannot be pinned.
>
>  - Optane has like a 3x worse write bandwidth performance than read,
>    so expect it to be significantly slower.
>
>  - the stack below would suggest it's likely the folio lock.  You may
>    want to check whether the folios are being pinned and you're just
>    hitting a wall because of the temporary pins or some other contention
>    on the folio itself.
>
> >
> > 48280162400 lost: 0/0 drop:
> > Overhead  Shared Object                      Symbol
> >   49.82%  [kernel]                           [k] migrate_folio_unmap
> >
> > migrate_folio_unmap  /proc/kcore [Percent: local period]
> >   99.52 =E2=94=82       lock
>
>
