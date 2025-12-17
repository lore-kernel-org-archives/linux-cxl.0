Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FE393DE7
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981840; cv=none; b=clEWboANsjH8FhVpNhDsUj5Jt+UgnqLwjHLVD1+hXu9k15RMAXTu1qjJ/gAINwCtp6rd+myHb/IFAmfYBeKXHxRwOnYhk2Nf6pVMqygta6WioI4qsny+Wpz7CJTMVnLWIqH2aA8dKBvIhRTHAN9sWcbP14Q7Aesu7h6o8ivUnRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981840; c=relaxed/simple;
	bh=Fh6DABJrbPJT1PTCHfTOdEoXaqOKIP3VETOEhx/5FRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pny6LPtnr+ZfrCm5Zizh0GBYeVq+YTNQAL/6RmP5kgYrQuNvPRER33wRK4zOUSeJ9q6GWHD00M6c2vFx54xUL100uPNIGVfKP9kIaC0p7fPvukundnc94/3FI1hlsd093EJhW7ICq6Pj+hy+t0oAFqoYLfalYD5vGBFFmEFjWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXvl9aFk; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXvl9aFk"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88888d80590so35405586d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981838; x=1766586638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bObqtAYbtqPyRtytU8ZPzJkSMQTXmYD1zvhyUZB6ziM=;
        b=UXvl9aFkorwau3Gj9I6RVLPbTu9JAbLfbzcS3BvfyI5Xgk2LyrADbXIBkqdKijDMa0
         9ZiTf93HvJQwpobOHzxnxHsFuEwZyguMH38RrhH5GfzLeNtPSywHiochaMf9//dCkEQt
         l04LiyOcJ7fX9+6w44Zkmr3jhxfHC5YibA2rzRixbCp3lC6pTQyVwTzQw5yg0KPhXIYK
         PvGuGDNJPRPlyeTB5XiPTCxVoKAaCev+XSsmVtyldzkP8o5WvO/WbBMKgIOv8rbPeuZm
         7bkIMiJKnuMBoGsqQQjxaHKelpNEetZnl7ZTGaRlToo3g/HM3ihGgdcGyg6XdCRikC3v
         BJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981838; x=1766586638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bObqtAYbtqPyRtytU8ZPzJkSMQTXmYD1zvhyUZB6ziM=;
        b=Ev3SDJPwjGqtkQk/cYMDAbF9aOLyplVsIUUcxE0PEm1rZxOYIh4XqM+laMXMWONxMx
         EgD8s29cy1feL/ago02EfViNrVyeo2SfVYiYOhzM2Pwh2benNbxVAQA+sozO4FkIxf12
         FBAUpZCgyu+q3TAAypXIqEiU3b2FGUI6KGC1X7/Wbu8bMswXB8gtY+h28FvA8QkfPug3
         v6JINvfz7G+EvFZv/eE6y/78yzLEHAZc9P5Jt36WmYuaj7dlywZvzaObL1rYdar7tIV2
         N9PImMuaXcRu+D3vzneyoFpnqQYqliC6T6dQIoIWjTyV4dQAmTWxoev0+0Wx7ycK0ij4
         msqw==
X-Gm-Message-State: AOJu0Ywd7bFSIqEfpetBhAW2/ui2SkeipEsZunAwKXRChaOwUieRUWSq
	G5YRiLzINnEwJC3WhdCaJXq/VmcdRBR0G+1TQ6fjG+8iu/A5XYs5eW0Vs/JmtUSWA4e1IkWknP5
	3RuCO/QZoXOoaqqQI4GxZ4H1+9aGyDuE=
X-Gm-Gg: AY/fxX4B5k0t8ZwTjfSdNNrxTZ9t7TLHvHbsxKJmGFs+/IOHTYB70rAgtdEftuOWguB
	qU99S/Sqq0833P6rS+N3dyjoz+6AnS+mN90/NgJtgMEdbmXKMXtuMX5gSU8tsrjvyibEU2+Q6+R
	GORdei95lq5bA6iBQfrjP4cHQgPmCuWmg5zccyN1v8DpO+A5rxuCFW1b0MWAVvNXlZEsUQ8ib9v
	m2gqQO8+62AecL+if2Ieo2gGmoblOJwmzVA/yfkN+zoE1F87KoDXQ0S8NPBMWuaJKTffdld9ZkY
	DdJDiDZM9C6goWIeLZmgnOI=
X-Google-Smtp-Source: AGHT+IG9CjUX9xvTFuZx6a2NPrFwtCK7bxkx/r5NoPA7mfHv28qSmnSSIjA0N0/sFHA8ebvWgtfC8wdZ4CSHTHQWhq0=
X-Received: by 2002:a05:6214:1301:b0:87f:fecf:17b2 with SMTP id
 6a1803df08f44-8887e1681dfmr277315766d6.64.1765981837872; Wed, 17 Dec 2025
 06:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208094028.214949-1-akinobu.mita@gmail.com>
 <20251208094028.214949-3-akinobu.mita@gmail.com> <01d780a3-16ef-4f87-b57d-00d50afa4bed@suse.cz>
In-Reply-To: <01d780a3-16ef-4f87-b57d-00d50afa4bed@suse.cz>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 17 Dec 2025 23:30:26 +0900
X-Gm-Features: AQt7F2r857gCtTYlq9_ZRMrLStQLliPCzDrXV1Jhny-QQKzbfSA_Im20lse9vVk
Message-ID: <CAC5umygxuqYrV1w3kMc+uaZuBgqcx3sX4MsZ1C3tLpHHTFZW2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/vmscan: don't demote if there is not enough free
 memory in the lower memory tier
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B412=E6=9C=8817=E6=97=A5(=E6=B0=B4) 21:55 Vlastimil Babka <vbabk=
a@suse.cz>:
>
> On 12/8/25 10:40, Akinobu Mita wrote:
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
> > /sys/devices/virtual/memory_tiering/memory_tier<N> directories exist),
> > and /sys/kernel/mm/numa/demotion_enabled is true and
> > /sys/kernel/mm/lru_gen/min_ttl_ms is 0, the OOM killer will not be invo=
ked
>
> Does this mean only mglru has the problem, or !mglru too?

!mglru has the problem, too.

> Also is min_ttl_ms =3D 0 a sensible setting? What happens without it?

Setting min_tto_ms =3D 1 or a longer value will cause kswapd
to trigger the oom-killer.

However, when the stress-ng devshm test was run in addition to
the above test to increase the load, the system remained inoperable
with only the oom-killer by kswapd.

> If !mglru doesn't have this problem, how does the fix affect it?

With this patch, the oom-killer will be triggered directly from
memory allocations, regardless of mglru or not.
