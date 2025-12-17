Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03533BBA5
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979732; cv=none; b=sYskadI36Ycvhx4rGibDGCWVtKc6DM+dPAyOOHfodquj4r5lnz3H9Gk66YZN7vlFiPzVU2+BhUG03d4BvNHWlb33ovUYpGqTiJf4/ao9YTVjRHXd9yS2eqjyEeeloxBnT0KDFiz2i2OAjI7Qmm5uCjiESeVDscVCYqrHbO+z7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979732; c=relaxed/simple;
	bh=2wdS0+w+GF9xido34o83zYaNz0GRwa/DgxZDb44raek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGQJxpuyGSSLd1RNZ88MBwGri+w4pi5Z0NwqsnvKWutxouQ6M5YClQDsu1odLLgxNegZXBYTwmR0o2YTm4b9Zzzoct+pHkuHLtBhr0grSukDt+iy9ZTSyiF34Mt4i3PguRqlqrasRA6gjuBfAG6dn44t8PzmMQLGELoSZ9c7hyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJUbvgzD; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJUbvgzD"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88888c41a13so69686216d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 05:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765979728; x=1766584528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzX7ZM1o+TOjCQmRVqRs/ozyaJkAfH+0WTUZVqy7yPs=;
        b=JJUbvgzDA4qIfbqvG2By8zwt4GWicxjO48+NmkfQHsiN4yuYdv+oi5m+/ekODycfWL
         bTAMZYCRKoO2+b85wgR3bTz1rvYlThjrnSps8R+8piF/Yw4lvFhQPX5/El+Dwjs/yCis
         8DwUBNJlQj/IZB1JjI5ws7kdRw0/aE7JvScH4leNGnRKrPqW8wXGIQg/fZTXNA+XFCvx
         fiuaLiYhkhnFvAOp+c+usRiSPRLQ2pRHdSZvQeShrgwEfeGLCbcuHRrGwdr60dFEmPc+
         LrEIcJz11ggztZisEio6v3ga21OLpqlFZ3l2C2u/HAhgZTkgnSlBGiSy/VpUCEMSrZK0
         QYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979728; x=1766584528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzX7ZM1o+TOjCQmRVqRs/ozyaJkAfH+0WTUZVqy7yPs=;
        b=wpa48XSLTO4QIQcfgbk98OVVGO424aEPmfGxg1ExR+VXP1PUWIJwJ5q1Ge3N7ZHQqO
         74gxFqgxM5dkMiYk5GJ8sdLFxD2SqYW4yVz/lxHvifvJkEvU6UJK9vsgLLamrc09C6lv
         /ryjx5i01uGpU8RjpSkGUdeeB7MfViXnG5q+SAsR8Jc9QGioQdnvm9SZp21ZelZj8xdc
         RLIm/Y4v3UpkAD+Uf2lOH5kKi4q7WMpcFS+/djaAmUz1YunCdK/uk6CHai1tstdn2rbq
         QDwPDx1JYezWjybAKHWDVGpj9tokB2jS3L4VIR6HGxy08ALnO+gXjsp5ogs93Tcjhy/H
         ZmGA==
X-Gm-Message-State: AOJu0Yzw2Wd0wJZrIq8/ZXKx8hF8wrtty1HVOl4E8zSrpf0k3y+yeuht
	CGDbpOoCBDY6U/T6LgiGBofaR2sCC+q5O3/k68xtAG46MycEUp3fTqM//eCiK4xyvTyJmlTvNPe
	i92d/LkUq2WrK/OQB28uWUE5xrWRL2Yo=
X-Gm-Gg: AY/fxX6jptdZD1MNEvKggGFQQ+EyNj7xXlAXNX23Hbx8hllM5YpjfW/1YIAFv/MPj9G
	ZK/8JwPOUNLCX83JEiRpLkUVwxyA2KUKzrpa4kyGXOdP+qCT+40FiJgoCFXbKSqa0ym26JHpE1l
	aVzg/q5qv5nsE+qhiNpU/bC6pyzxnbL5Yvgwo+JvlQUcR1YhfvHGu8iOI75Grg2Xt5ORVzRCO3p
	yD8Y/VVszhEpl9rUo8n1nEtmXXY2464z3C9eEi6Q/Ldj0uw09tE3chqzt69yp0fbuvkBh3to2UQ
	CWwFmj0LwOEwijNsaraD4ShU1vFbB4Fn4w==
X-Google-Smtp-Source: AGHT+IGVQ6ivX51FgYkbTDWi4T0CCt2/UMyMmgbf3Bd7aWDbLzTqzMHzid8Kd7YuMhBhbGaUeS9qrFBkh4vq4FKbIEk=
X-Received: by 2002:a05:6214:5083:b0:88a:2444:36e1 with SMTP id
 6a1803df08f44-88a24443797mr195078936d6.62.1765979727833; Wed, 17 Dec 2025
 05:55:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208094028.214949-1-akinobu.mita@gmail.com>
 <20251208094028.214949-2-akinobu.mita@gmail.com> <20251216122441.2810043bbc51621315e3862c@linux-foundation.org>
In-Reply-To: <20251216122441.2810043bbc51621315e3862c@linux-foundation.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 17 Dec 2025 22:55:16 +0900
X-Gm-Features: AQt7F2oAJ1HD8RfcX46WepqOZrXvmZQK_-FtPhsJi5EQDV_sv1QcyY-Fdn9cU14
Message-ID: <CAC5umyjCXSm1TMiv+OOdK1vHp5nA7zGRxLegMzhbLd9U=3Dbhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: memory-tiers, numa_emu: enable to create memory
 tiers using fake numa nodes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, hannes@cmpxchg.org, david@kernel.org, mhocko@kernel.org, 
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B412=E6=9C=8817=E6=97=A5(=E6=B0=B4) 5:24 Andrew Morton <akpm@lin=
ux-foundation.org>:
>
> On Mon,  8 Dec 2025 18:40:27 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > This makes it possible to create memory tiers using fake numa nodes
> > generated by numa emulation.
> >
> > The new "numa_emulation.adistance" kernel parameter allows you to set t=
he
> > abstract distance for each NUMA node.
> >
> > For example, if the system is booted with the parameters
> > "numa=3Dfake=3D2 numa_emulation.adistance=3D576,704", it will configure=
 memory
> > tiers with node0 having the default DRAM adistance value and node1 havi=
ng
> > a lower adistance value.
>
> Confusing.  I'd have thought that this commandline would gave node0 a
> distance of 576 and node1 a distance of 704?  But the text talks about
> some third "default" distance, of unknown value.
>
> Can we please clear all this up?

The DRAM abstract distance is defined by MEMTIER_ADISTANCE_DRAM
in linux/memory-tiers.h and has a value of 576.

Each memory tier covers an abstract distance chunk size of 128,
so nodes with abstract distances between 512 and 639 are classified
into the DRAM tier.

Here, the abstract distances of node0 and node1 are set to 576 and 706,
respectively, so they are classified into different tiers.

> Also, we have little documentation for this stuff.
> fake-numa-for-cpusets.rst and kernel-parameters.txt.  Can you please
> find somewhere appropriate to document this new user-facing feature?
> Maybe a new Documentation file?

Looks good.
I'll create a new Documentation/mm/numa_emulation.rst and
document at least this new parameter.
