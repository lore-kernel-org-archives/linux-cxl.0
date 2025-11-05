Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB131D372
	for <linux-cxl@vger.kernel.org>; Wed,  5 Nov 2025 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349034; cv=none; b=Oqx4bp9Nh/7ebEScJmrhRZiAVNZlSr52MeO9qsqMcsoENCISMouv6i/gBNnHkMDnN350b/eBRN9FdvJoE6bSGbR08WXYDLLozR0mFJtQpmDMcufMgqHrNe1VjbPMNUZR2xpVNhyxy7l6TcxmzdHiz9HCMxSfSqeNxdhkjiQ+wlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349034; c=relaxed/simple;
	bh=s/94gijIF0XRuyDVkC8CAXhywzL9UjqQBpellCChGTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te4pjbrTky5AeTQbOfr5caVxLxH2mDOfs9a+OcABhgeMOk/1DYSsTNbO0c7A5o6695bRGbky3uUCrUj9K6DAeu0HXJFoGf0VZRQcXHoD6COmup9wC/Jkfk/OvhCmuwkC8XBkHOwllxAo4n+dP28IEiGSxDTUutG2QNXk87hJq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVAqOpsS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVAqOpsS"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so1369181fa.0
        for <linux-cxl@vger.kernel.org>; Wed, 05 Nov 2025 05:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349031; x=1762953831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WNWzl9UPAGqC0OeojGWF3FUUOCD6lJ7lBCWbQ62ZwI=;
        b=YVAqOpsSGvKYDPLoztpTZUQpcXAqF7Sh5EkX0naLQpd3lXJyWYNDgzURhuSMqjwvY+
         /fsAXl6rl66QI5aytr9CHvZlc7yQ6lmILUm9+dvyf6ywUZhel9t9xy0Gy+TT6j1YrW2g
         dqO1v4qS/qk191CknV18ms0h7NUfMTU7SLrjv5sfUEKhozsn/yyD/X7e/XLyg46/1WRU
         BAJYXoX6KYZMoHlKisQA4vjdQZ79NnEu2IuN4RI3l6j0OpJyzkyhoALElXIM3FGn9zws
         o39wmj3WajEJVWnLU6t37ccIdY++EwH4Cce0wWMKC6g3C7NDYz4H5Grb8z2WEMWonUVT
         PHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349031; x=1762953831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WNWzl9UPAGqC0OeojGWF3FUUOCD6lJ7lBCWbQ62ZwI=;
        b=eycKA5rNa4/YrIFLiRuAcIE6mjme3SftUlQqjkOn74loKB6Jt+ew4BOcg9SOEieGxI
         dPLx59gTprb00HHbSQz1YklWAeR7vzYwX9jJ3EDlrR0hrODZnMkihEwMRSw8zd9OKqoq
         4yvD0stztVveFSS2Bt6qd1E5bs6Ay+YqMV8MhV7J2bmasDMQNiaQTrY2e7r6D6P23o2X
         dFk8rJWjt0PivHY+XAzs0uDdY6HyZYDnkKo8fnNQmFcljKGhuoXak6oCfYrU11JvGPQf
         TyphL1S5fnBjXp3zozQ5lLTRI25mABr8YDtG8JTtlZ6FA7r6BS5s9Tw8oaaFU5ANA1UI
         hBdA==
X-Forwarded-Encrypted: i=1; AJvYcCXLnwhC7TO04HmBIfcUqraXHNzF+1b6qO8gbC1TJLWcjq5l9Jd9tAxNP8SxkGDBYPeD0BqSafpQBn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4CCutZmCKC0Qk1DJ38ga9JXlrmtM/fAu2bLPqpzvZCqfUKyX
	w0sCjBRqgiMEd2snht2r/k2yZsueMhNQWsal00qixMrjN1sgrfkn9wlybDtuA0G7i7sT+pSP2ub
	cIp5mGn8s3NiCPhQWEcbPd7k8RhXWTJ0=
X-Gm-Gg: ASbGncu3OcUQnjVNXxlWHDcBz5+2Xb8Yi+UsShPCTWu09MybDE8A80VV2zBPw+nVJ30
	f3VypCX596oQd5WSwx1RIyTE0G2KXrabm4HfTPVLCsCnm9XbvUi0VGskVwL4ixg1bQdpi2gN1+x
	pg7Jb+s8/WjFu8+LpCy5J33PwD3kwoDEkLIsdMJRDVlGna1dMXVIpaq9FFf8cXAJeLzTACACvbn
	AKYKAukbY2bgiHzor1IPFA+QGIk7jRbSyYH4r77ZB7F4qVEwwoFjQ2drAhXVtkpmsP/m04atrDa
	r5rZWgo2NvhA
X-Google-Smtp-Source: AGHT+IGdn3dvXTFfnd26oUCEg5vL/XwsKbx6eN6B7iFUvvLn+iruzlQSAGzvDJ9vCiy6F+m/VX5r20KcdkbP0rV3R/0=
X-Received: by 2002:a2e:a109:0:b0:37a:3033:16f6 with SMTP id
 38308e7fff4ca-37a5142e2c8mr9741151fa.35.1762349030972; Wed, 05 Nov 2025
 05:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104003921.9707-1-akinobu.mita@gmail.com> <aQo1VjjQw1OZG8nY@kernel.org>
In-Reply-To: <aQo1VjjQw1OZG8nY@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 5 Nov 2025 22:23:39 +0900
X-Gm-Features: AWmQ_bm7dSG6fty0drtbxuWvBO6bGxhtYdnsjyRSa0aF5n43MfZsmtccLtweZyg
Message-ID: <CAC5umyigiSS+ynr2JnNSaR3irW0eEWFuUVnJvY2QvJJO4yfP-A@mail.gmail.com>
Subject: Re: [PATCH] memblock: fix memblock_estimated_nr_free_pages() for
 soft-reserved memory
To: Mike Rapoport <rppt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B411=E6=9C=885=E6=97=A5(=E6=B0=B4) 2:18 Mike Rapoport <rppt@kern=
el.org>:
>
> (added Dan Williams)
>
> Hi,
>
> On Tue, Nov 04, 2025 at 09:39:21AM +0900, Akinobu Mita wrote:
> > memblock_estimated_nr_free_pages() returns the difference between the t=
otal
> > size of the "memory" memblock type and the "reserved" memblock type.
> >
> > The "soft-reserved" memory regions are added to the "reserved" memblock
> > type, but not to the "memory" memblock type. Therefore,
>
> @Dan, do we really need to memblock_reserve() the E820_TYPE_SOFT_RESERVED
> ranges?
> Quick scan didn't show anything that requires this, but I could easily mi=
ss
> something.
>
> > memblock_estimated_nr_free_pages() may return a smaller value than
> > expected, or if it underflows, an extremely large value.
> >
> > /proc/sys/kernel/threads-max is determined by the value of
> > memblock_estimated_nr_free_pages().  This issue was discovered on machi=
nes
> > with CXL memory because kernel.threads-max was either smaller than expe=
cted
> > or extremely large for the installed DRAM size.
> >
> > This fixes the issue by improving the accuracy of
> > memblock_estimated_nr_free_pages() by subtracting only the overlapping =
size
> > of regions with "memory" and "reserved" memblock types.
> >
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> >  mm/memblock.c | 33 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index e23e16618e9b..af014fa10a44 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
>
> ...
>
> > @@ -1826,7 +1842,22 @@ phys_addr_t __init_memblock memblock_reserved_ke=
rn_size(phys_addr_t limit, int n
> >   */
> >  unsigned long __init memblock_estimated_nr_free_pages(void)
> >  {
> > -     return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size=
());
>
> We have memblock_reserved_kern_size() that tells how much memory was
> reserved from the actual RAM. Replacing memblock_reserved_size() with
> memblock_reserved_kern_size() will omit "soft-reserved" ranges.

Replacing memblock_reserved_size() with memblock_reserved_kern_size(
MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE) also fixed the problem. Thank you.
