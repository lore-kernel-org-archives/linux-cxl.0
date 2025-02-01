Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CF208A9
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427431; cv=none; b=u0fx32XDDGGJp3A5Gt3a2ClBag5lBJFSUQrfCjSft97hj/DtAAM5pwjrKoHjQMFVlwMmAf0KCNKzBqZnkStcQw5MSCgUIfdeh+wUiDvN+ysC942wLpHpmkLewc3W12ezpJjBuwbYTWUNaGdLCNNi2EGI32BLEpdJqFMoXqdU5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427431; c=relaxed/simple;
	bh=oftPfIqMqGfPjQd+jZRkId4Un6z8HQwsBM383DWuJSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nysQeMc4jbpy72E/2Z5kKCkKFujxik+Dy3sVb0ZXK552SOBfE1ugw79/SfMkvbR85Szg6UGmut8Lz3m5/jHSoHz+KAtyAKI7iodd1VQLoeAg7bbMqluw8r2wHGc/+2rSAbECTBouEZ5BxR7TfZV/KuBTbDn0JXm/x6Q6v2jxPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=b0Dxc204; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="b0Dxc204"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be8f28172dso143839685a.3
        for <linux-cxl@vger.kernel.org>; Sat, 01 Feb 2025 08:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738427428; x=1739032228; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uAzsil3k1tj1Q2KIFJPbu6aJ0Yupqtm9Xx7vSO2xF9Q=;
        b=b0Dxc204DyEF2JDJbI5i2vpwh1iIfJSyhIC2/daDSgb+wjnNjhkw983/v+eK7G/GUQ
         vZWnECBQ3+LnaD4S3oiqp8NwTc2LeU7lHASIYDjiUPb4llwqf7Os9JcGS64/KRoIIz4Z
         82rC9PzB4eQTIUvZTBMPccmrhyylt0a9eA1Qv3RTjpQveLQfz7vsjOcyI3EhM2E4zr4J
         MtPbcXMsc4l9tQyCH6UgXd644EHOm9TT+qvkRQOL/1m7W0jVDpmBg/hr9lQdFkJ0xZRY
         INj74tHg23XFjOLaXOdOyX0S5oQftAyU9DZqOt2Lnmoe33NCDpz9LTGC7ZSYusdQe4t4
         8jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738427428; x=1739032228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAzsil3k1tj1Q2KIFJPbu6aJ0Yupqtm9Xx7vSO2xF9Q=;
        b=xU+g9WEZ3bhYmzdm6yfI2ZZFh5XrgM3ok+mbj8W85TThuSlIoISfQn+F9nKCqHco0h
         txYvjTwUE7QP5E/OwZKdQ2dPbLvjblJotpSLT6eIwp4cN9fv7QzG5UIFRpchGyD7hWdE
         AuRWtFgMaH+suEHwn+LzPF53J+bLFkF8qQCBeMdBXoknP+D+Xz3proNC5S14uWrb8u4U
         t1VNc8Fe2shOJbZ/ZrUd6UohSPtZyuHQ8DmWMba2zr3KI5sJr+TVO3Sq95Nk53K49orp
         ymwLpX/FtzsGt33M87utk+jW18DR+SKfM+IB+86kH0Okq+XvhJ2c11arzGaVsrJ/3Rfn
         gQGg==
X-Forwarded-Encrypted: i=1; AJvYcCVVqWr9SSNf32mu5kScoB1smf5iUS8ftb2GAgVZJrG9V3I/iyFuomes3UWPFd2F62CzDX6u6EZCJV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyElF0rZYrUv2NIHtCSv6QRfop1VfDPdq0Pn3g1Hssk+Ls5NzGQ
	JZ32IsBF1x6g5oDU9I1szUmoGavkSd0fTilrI0n4Lzsui7Q31h9PMFF9B5+Ms5kJ6xOEajShaRZ
	8
X-Gm-Gg: ASbGncsxBWwkmkIfgmamTskf+giiE9LucmQu13EDMKHe+johs/S9Txdgu55O+z1/caB
	jRmMey4A6dSOMx6QYIykdYrnjBfou6Hql4nLSfLJD+6H8aZ8dBdkpNL52vU/jcYgyypJkCwL2HK
	/Xl+XJr0NDUTMdP8u563aCpG+bA1l8ygeUuuFLME+J7tT8kbl94zX8jgRIaBGfcfndah6od8oyl
	J9+SeoH48yxFcGG3HW2LutihUrIOGR/hOa9OeqIGwRHqWKM2CIHJU306Gc4jSt+Duha8w20KMTW
	Hzpo43Go9A7BnSzI+v1AMRf2BRKc63I360MhTgWbxF2MwIgdBvF4RR4xS7MiuoGQOj8SkBejcQ=
	=
X-Google-Smtp-Source: AGHT+IHypOupMAohvtLd8qmhgQw96htPpaIcdH8DHr/zDJCnHZKVa/m1oxXQ49DS4TdDJ00x9k3/3w==
X-Received: by 2002:a05:620a:244f:b0:7b6:cfab:9883 with SMTP id af79cd13be357-7bffccc97dbmr2417712785a.8.1738427427928;
        Sat, 01 Feb 2025 08:30:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d95cdsm311440285a.56.2025.02.01.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 08:30:27 -0800 (PST)
Date: Sat, 1 Feb 2025 11:30:24 -0500
From: Gregory Price <gourry@gourry.net>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	Byungchul Park <byungchul@sk.com>, Honggyu Kim <honggyu.kim@sk.com>
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <Z55MILLApIoPh0A1@gourry-fedora-PF4VCD3F>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <CAB=+i9T15XXbbZsvz2sg7JQNOVjaHzpj0LtCW9QtOQfwqq8W_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB=+i9T15XXbbZsvz2sg7JQNOVjaHzpj0LtCW9QtOQfwqq8W_g@mail.gmail.com>

On Sun, Feb 02, 2025 at 12:13:23AM +0900, Hyeonggon Yoo wrote:
> On Sat, Feb 1, 2025 at 11:04 PM Matthew Wilcox <willy@infradead.org> wrote:
> > This all seems like a grand waste of time.  Don't do that.  Don't allow
> > kernel allocations from CXL at all. Don't build systems that have
> > vast quantities of CXL memory (or if you do, expose it as really fast
> > swap, not as memory).
> >
> 
> Hi, Matthew. Thank you for sharing your opinion.
> 
> I don't want to introduce too much complexity to MM due to CXL madness either,
> but I think at least we need to guide users who buy CXL hardware to avoid
> doing stupid things.
> 
> My initial subject was "Clearly documenting the use cases of
> memhp_default_state=online{,_kernel}" because at first glance,
> it was deemed usable for allowing kernel allocations from CXL,
> which turned out to be not after some evaluation.
>

This was the motivation for implementing the build-time switch for
memhp_default_state.  Distros and builders can now have flexibility
to make this their default policy for hotplug memory blocks.

https://lore.kernel.org/linux-mm/20241226182918.648799-1-gourry@gourry.net/

I don't normally agree with Willy's hard takes on CXL, but I do agree
that it's generally not fit for kernel use - and I share general skepticism
that movement-based tiering is fundamentally better than reclaim/swap
semantics (though I have been convinced otherwise in some scenarios,
and I think some clear performance benefits in many scenarios are lost
by treating it as super-fast-swap).

Rather than ask whether we can make portions of the kernel more ammenable
to movable allocations, I think it's more beneficial to focus on whether
we can reduce the ZONE_NORMAL cost of ZONE_MOVABLE capacity. That seems
(to me) like the actual crux of this particular issue.

~Gregory
