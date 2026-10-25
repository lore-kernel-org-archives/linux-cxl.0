Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894640;
	b=Ecqqgxa3M1tGP/cGvZo5zSctXiJKMS+7JOQxOED0EyGoi0I6tSCLomLlnBy0jI08nFrR
	 dV2R3XOwkVk6O77GxYbqpz9fxT1ho3USMBUq52mwsbX+wnsFugJB7+L0zUJZKNqFQtleF
	 QxuVy3f7IdWiT19rWVZLjy9ssOpOSpN2N/z5uSXIIkVTibzts4+SSrBCZOHjAZqw60kVK
	 ANSIVJMyzlT03eLdVYWgXB+6OXTd/SXrXucrDuLbkDLEYlwll8aEL7zGMDAXGLluSs0E4
	 isTeHIXpbimD5Jxg1vGacNXXu1SRygJK0eH4KVYZp1ca4DPcwH7qkqtxUHSqkunR3Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=59O6YsOe2ZdqTEDOrhAn775YQJaCvGOavb/hzAN0T1U=;
	b=uLkVsm+kg0+nybSRuiA+5eVl+bj1471q9J+It9kO2WnxHrVK3dcvR5HTdoA0/lVD9GZ5
	 OXsZyKOUNHW0Z2zLKwK8+xnadZe0qjCPv0AfJutQ6mnoC725x50J0RHNRQI3pGo5VDHnp
	 R5u4sJhvHflCPhStzfuCgPaSTHOIm7jqOYXgoqNLr+mlFN/ORhXpMWtabb4gBq3G8xzg5
	 wTc7f63P1XelHNKGs9r3KV0zcQyptNcGV3Cq9/gy44Pt21Jee3X1iTwBecEgEvClQjqGu
	 BATqslU47Warsp6+NNUN7YLBLi6HBEKUxLsehZh9g+gLC1VVcfqBUYoznEokcwdpkAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gNV5pj8w;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3331606A321
	for <linux-cxl@vger.kernel.org>; Sun, 25 Oct 2026 02:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3331606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gNV5pj8w
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so3470453eec.0
        for <linux-cxl@vger.kernel.org>; Sat, 24 Oct 2026 19:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792894639; x=1793499439; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=59O6YsOe2ZdqTEDOrhAn775YQJaCvGOavb/hzAN0T1U=;
        b=gNV5pj8wvyqTFd7GT3mqJNxxHaMp++gpshfwksnecbSIJyjTxKBy1INB12+h1tG1vJ
         TfQo9m1tMSvHdOHNHXZWI8AUho60rXmoV1FcZWEGEJQX2VHMkKYsG8+OHtfvMdaNFZDf
         KT4Xik4kCy3zFWfrLIuy8jcbolNC71nrdK+Rv0h4JH2FWrqidWHkO4DzcPArWNJclVU7
         NOAjQf0A8qRwGhg7QHX7LrkTWsj6MOOgEcVlhuSvfI8RUvuaf2sg12bQk9tWE0DmEWo6
         JpdK6g8I1gV3+j+j1xZGvsfYzdMks+9louxLyXH6GOQJPkjPJXexM/eyivAnsDAWhG2K
         Vwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894639; x=1793499439;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59O6YsOe2ZdqTEDOrhAn775YQJaCvGOavb/hzAN0T1U=;
        b=l229eujMfFqkiWJAAYa9qprHUDTi436Xrz+Pd6fFGBgacTgiQSDvxM+Rk1m1ha/pO8
         9Cq3XTODdzsJ2/fQSzmgbhoZ2MAPmkOtuKDfKFBszQjgCD2lnQr3ZMM9LSSsufs2tWpB
         kyPc9Xc8bavuwZ1OgUblU146Y9cKxSpsjU0ZYziImoJOCdbyRbfatuDUtPpy7BwrezoX
         AkbY7hnrRA84Ne4jyxJ6AKS0TwdUn8AV/9u0X1G66RQCYyvPClRld6nWn3dlTy9ZDikh
         2X9NtmX/yJLUikKezeCSFexzqGMy3daqsMeSZu7r/k9vHnQkVT+kET1D5eiPQhn5/xVL
         0ZLw==
X-Forwarded-Encrypted: i=1; AKwUvByRuAPo1qeR3ET++uZSak8vh6XgaxBepeTBeFFtNPpYYmgjSDXoYhz/7xrrse6fYv4/TCId8YKltEs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKIk0GyWhKSyZ3Y2bivOdbRjUc1esyTaXzBaLskail9j21Qtlg
	sIZYkex5Li1YyaqGyEWHRvq2TCVx8hQwNPvEYrO6ii8bByVV5pWwkmKz
X-Gm-Gg: AYBFou36BjExaACYUuQGi8j/I4J7yQPBsVRk0M7yqm5q3BOIlixVjm8QBULD1JE907l
	2ibSzQTsQo5XL5T4Y07sjok8sgMoxab9gofqpDOwTv61SiGnmpCFQiagrvhh6WYRpLa+bB+od7G
	5kcI/ZGirjIvct1fTJuOPhFsD0ObcIRbrGU5d9HzAhos/p75hoq7l2Jw+cXhDF69JuJKK5mQjrX
	YJpWHoZLpu3R9/5k6DXcyt5fc8Mh27shlEqI3u27CkHt0mJkr9BUXhd+EF/xraNIjja+4pZTIlx
	VD+Z27ZXM28I23/CNjRWbOIl8UmPVja3DEE0gJR6/zK3voUfxJXlp2hiMx8yVQa0ADRnoT2eh3P
	rueI8AaJLAo/uxz5sY8UKLnNQptbi8nSf7M28jEEFeMlehRlH13KoVVxLhKmNw6hnDOfFcHCgiT
	Epivc5dOR8zuNce9rUhCRjd65X2zpZqJ+QZvC6N0mgiqKblBsWzqY5ALUe5sldJn1WrPUb6lc7p
	ZHOk9Ixt+psZS/HrByXnWbd0kqBsZUuv06WXLSWilvHemxKVhybvQ==
X-Received: by 2002:a05:693c:2d86:b0:35c:707b:acba with SMTP id 5a478bee46e88-369e8369d86mr7944429eec.3.1792894638749;
        Sat, 24 Oct 2026 19:17:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d812d6sm12003945eec.10.2026.10.24.19.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:17:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <songmuchun@bytedance.com>
Cc: Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Joao Martins <joao.m.martins@oracle.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v5] dax/bus: Fix Device DAX range alignment validation
In-Reply-To: <20261024183853.6803ce81788636e94d8c16a4@linux-foundation.org>
Date: Sun, 25 Oct 2026 07:40:03 +0530
Message-ID: <cxsy5y4k.ritesh.list@gmail.com>
References: <20261024112555.2476001-1-songmuchun@bytedance.com> <20261024183853.6803ce81788636e94d8c16a4@linux-foundation.org>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Andrew Morton <akpm@linux-foundation.org> writes:

> On Sat, 24 Oct 2026 19:25:55 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
>> Only range sizes are currently validated against dev_dax->align. A
>> dynamic device can therefore select a large-page alignment and allocate a
>> range whose start is not naturally aligned.
>> 
>> Sashiko found that memmap_init_zone_device() could then initialize the
>> struct pages with a large-page order for a physical range that is not
>> naturally aligned. A subsequent write to a userspace mapping then
>> triggered a kernel panic in testing.
>> 
>> The automatic resize path can also split a size-aligned request across
>> arbitrary free gaps. When devices with different alignments fragment a
>> region, this can extend a range by less than the device alignment. A later
>> allocation then fails, leaving the failed resize partially applied.
>> 
>> Initialize the device alignment before its first allocation. Validate both
>> the start and size of allocated and adjusted ranges. Use the same
>> aligned-gap iterator for free-space accounting and range allocation so the
>> pre-check and allocation path cannot diverge. Skip unusable gaps and
>> serialize size validation with alignment updates.
>> 
>> Static Device DAX already has a pre-populated pgmap whose full range was
>> validated against memremap_compat_align(). Its usable data range may begin
>> after namespace metadata, so require only dev_dax->align for static
>> devices. Dynamic Device DAX builds its pgmap from the allocated ranges and
>> must continue to satisfy both alignments.
>
> Thanks.  This is now a must-have for 7.4.
>
> I suggest that the changelog mention that the bug becomes hittable once
> your series "mm: Unify device DAX and HugeTLB vmemmap population paths"
> exposes it.  That's 
>
> 4b77739fe789 ("mm/sparse-vmemmap: drop VMEMMAP_POPULATE_DAX").
>
> I intend to send this to Linus next week.
>
> Maybe also a Fixes: 4b77739fe789.  That series didn't create the bug,
> but this data provides notification to people who are backporting this
> series (unlikely) "hey, you need to add this fix as well".
>
> Also
> Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Closes: https://lore.kernel.org/wlrkqqvg.ritesh.list@gmail.com

I think, the fix for the issue (the one that I reported) is a different
patch [1]. And I did give my tested by there.

[1]: https://lore.kernel.org/all/20261016054914.2601510-1-songmuchun@bytedance.com/

>
> I don't believe that Ritesh has tested this?  He wasn't cc'ed...

Nopes, I haven't.
But I am looking into another open issue on Power which this series
exposes. So while at it, I can test this as well.

Thanks for the cc'

-ritesh
