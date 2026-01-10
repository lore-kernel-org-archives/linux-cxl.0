Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9682A1BF
	for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768053316; cv=none; b=Qlv8XN9w0FW6A5SYwPKe52ArXJoVHXZUxnIBwZOcCbQbjUa+5A5urFQVk24WEeMEQ/B/lqBQxy7NSBxXv7DjxnQHooY3S3NTMqkJuJBXbnlLNas/7UzpuycLxGFFxbugCzbcI3Re+h+McgNGeQ0+nqGCYkSOeV2KLmncdVCzxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768053316; c=relaxed/simple;
	bh=vc6aaWF9pdoJ8me4zDwRbhNSsD5hMqWpRBfAPzt/JEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oh0giKMCii/qsnut5RweRXzNcCIkCXb1xa/u5rMK/XzIcvLQE0j625qCOoWPHP/rIyISpATOUB7y4qP7yRQxhmiw1eZtYMndCJUcXnmNC/I/G3hb89HYA2GUz8IM3AmdhSUBnuYF5xZZtJackKAnp4xwkrAoZqKl2kyNf8fXAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VU4eKvBh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VU4eKvBh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8907ec50855so61284926d6.3
        for <linux-cxl@vger.kernel.org>; Sat, 10 Jan 2026 05:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768053314; x=1768658114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bF15tgDtFzb7B//rb6r4Znze3ckqkWQR0unvRLAwiw=;
        b=VU4eKvBhGa8PQtGjwFY92m8wSJkujBI1p7qFLVrH5JXvFnhFtw0eGwNzXXkgGZS8xw
         CUfWSWq66Ztet9iav0JbhvcsGoFeo/p0M9PUXyiNrliGbjhIwwRTgg5zRkSekM6ZLZY4
         JzTWM0y44seE6m37WfeAdtrie4Bk+9rlUw4gWoqmDB3vKwaGoBGZPGEn9uI4O7TvBK9H
         cvDB6uHmKW2Ae8JBEvBWg5OQGIxZjCRZq02J7NAZXsc6rjSo7GX8XOSdYxSVpL0mD0BR
         8KX1SSl4nrKHcxRoXweHFToYYaaKP8nSd7E3aOenZmn4Nl5mT7qGiydKzmLOMUswOnCP
         xCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768053314; x=1768658114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6bF15tgDtFzb7B//rb6r4Znze3ckqkWQR0unvRLAwiw=;
        b=YqkEnCGUvMHqvNF2K5K1QpmcHbVMnfyMWMTWWZ4O6NIGUTypit3KaEUJ+k5IBwuNSd
         GOQSNN2oLy/Kxy9cBzeGa0Iz3n/E55DTS3NHAq0roBymRI957iMyXSdr4uIOv/ENFuvy
         LLolwylo9kk3BgoqqNFGQjZ47Ox/q8/gVvH/M1q0RLmdFmvfwXitGRU77q6/ivqj7J4q
         e6F18eOjLEH4QlbQ0g98PifV91Z7rvJfviojB/nX6Fy5X7dDn/7dxl+ziw8oBZIkXlEj
         /T1vMUxRn28/bR9WwFiOK+P8rJ8s0LlH/T67Ul+/1DRdB0Ii10xc5sCyGqdvr57OH55K
         ViJQ==
X-Gm-Message-State: AOJu0Yx1OXahbP7Owm8lQTMnJ2l9jYZ/fMO1WBlZTFyBKAt4wQBEc9n+
	bkbCQOzBVSPxexNd5PjOXIq2hc8HyNU2zF+M4AKdjzuXBuBTl/hLsD0EnxzOS1BlrK7+nuSpzI8
	McQwLiwwg7iA+1o132V3F4194Kg+GzI4=
X-Gm-Gg: AY/fxX4eeaJryVjbJIYYyaE4LXKYASJaNmMIIvYR9lH8UboAIb3wgKU+EolmGQ8ul5q
	9R6aeWb3oGrrNBZFN9CZByXREfCmG9aLz4EUZNkbUBfE07z/HXX3pYl78vNwdiAr/H0c3xm2kgM
	19bjynMYsP97lJI2UUlwII/TKGPe0HQbtfkJGIo6cQ+lrvViQBJBF/jnAIocIfC4ZrvVR6Y1yzP
	7TW3UcT/OXhMqkKoUVSslqMmmeVC0NqGZZmLWQz0ITFbLky9qT0i0BeQlD9k0FDWGU51K2e+7Rg
	fvL8zRtW3xOTbGl7vBVHMcMaLJXGXUqDlQ==
X-Google-Smtp-Source: AGHT+IEDYC3cY6soBRLQg0jrKD+eKmTD2ovAt2yrZmq93YN5K8GrT0NaJGJRys7cFEZm4N+ttZhDuYFIVnybaRJXjUM=
X-Received: by 2002:a05:6214:27c2:b0:87c:1d24:7b7f with SMTP id
 6a1803df08f44-890841aa05fmr191022996d6.23.1768053313735; Sat, 10 Jan 2026
 05:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com> <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
In-Reply-To: <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sat, 10 Jan 2026 22:55:02 +0900
X-Gm-Features: AZwV_QiB1arM2112x9CFryUSneEVqs_KakkkX2Yd9ULOgdOZCKyZki0KapMs8FI
Message-ID: <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: gourry@gourry.net
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, bingjiao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8810=E6=97=A5(=E5=9C=9F) 1:08 Gregory Price <gourry@go=
urry.net>:
>
> > +     for_each_node_mask(nid, allowed_mask) {
> > +             int z;
> > +             struct zone *zone;
> > +             struct pglist_data *pgdat =3D NODE_DATA(nid);
> > +
> > +             for_each_managed_zone_pgdat(zone, pgdat, z, MAX_NR_ZONES =
- 1) {
> > +                     if (zone_watermark_ok(zone, 0, min_wmark_pages(zo=
ne),
> > +                                             ZONE_MOVABLE, 0))
>
> Why does this only check zone movable?

Here, zone_watermark_ok() checks the free memory for all zones from 0 to
MAX_NR_ZONES - 1.
There is no strong reason to pass ZONE_MOVABLE as the highest_zoneidx
argument every time zone_watermark_ok() is called; I can change it if an
appropriate value is found.
In v1, highest_zoneidx was "sc ? sc->reclaim_idx : MAX_NR_ZONES - 1"

> Also, would this also limit pressure-signal to invoke reclaim when
> there is still swap space available?  Should demotion not be a pressure
> source for triggering harder reclaim?

Since can_reclaim_anon_pages() checks whether there is free space on the sw=
ap
device before checking with can_demote(), I think the negative impact of th=
is
change will be small. However, since I have not been able to confirm the
behavior when a swap device is available, I would like to correctly underst=
and
the impact.
