Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1E9331230
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333058; cv=none; b=Y6iSAdaHMJPJ0yYH4s3XFgxkMUkrVCOk2tANFDqqmf1Pzd0ETCAMukLJXWhZ5DAm/vk3k+InSz7+mnWPSmZ+ygqAFT0EUIZsuNSnYhOqx86A900jOUMWDTbCfFjEK6ASfq6pVjPfsA1OnLy3biX3mwD7RrxVxyvgLinfQ4g7Ec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333058; c=relaxed/simple;
	bh=hEJQDGKxyIJ+94KmbuaUj6NmaDaCsYqJuOznZ6cuIew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnuXJCS3ppFfa0E8KwNBcAn9UVQPwBmqnOCmjiHFJxMSK086sCr+oFwguQj4KYQHfw+J/Vew94ekd5BL218o6vh80VSHTlLryhleKoOhxRBMygMWxwkVpsgxkYD9rY8bMahoChwVKtbnFGpCM1tm4FQpVJRU94s9Ftd3VBGq2ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DWWjhZ4M; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DWWjhZ4M"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8946e0884afso1808856d6.1
        for <linux-cxl@vger.kernel.org>; Thu, 05 Feb 2026 15:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770333057; x=1770937857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNQbtNTj5xONF/FlzgjMO0/Jn5YLGFU3yCoER5lhWcI=;
        b=DWWjhZ4MMTlLuOREiTulZ7lPWaiOOSNbw19TKbDY3XeII6XAAbVwOlACQ7+pDM638q
         dIR0w/BZDjt5EdS+wKS4p9RkzB8vHr145vz2F+TfkAfSBXpL/cGghXLyaGvRc3jbKKK2
         CpygNMlHjRhB2BGmF1CwuHRQTyr4TqFJSCuf9zuKiUzM4n+lP7AqKOM9JxsRVeUECCqp
         e4FcjWEB2tEMbxpDlElWhdtIxWDCFxshSBs2SUkcatNfMGkwPI2MDX4a5XjTEVNKzZhJ
         Gtx9q1fawEzeMmjFW7SoGwPpJc5g/01lEW3swokpeAJ41+CclOGcOw4Tuc+Atg4ZEVJ3
         YpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333057; x=1770937857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNQbtNTj5xONF/FlzgjMO0/Jn5YLGFU3yCoER5lhWcI=;
        b=DH1t1PSXngPAzC/+SKCGZxF/aau/DkOh/lcMWAHTYFr5QiAw5nEG2KKiLKqjFdqNtj
         V92xDFN51nuYl3lp7Q750qqlm3rLLrYCwTtRa6SUslkbzzxObGSvHrZs2NUw4EqI6EGg
         B0Sat9DAo49u6LHa60YfxQbJAGeF+FnXbPxr8O+BE2l0f8W8Q331cCVBW6YSd6122Pzj
         /bDKTfoD7urRv6Piq7Bpdy8vP/RaVGs+sBWetT4RJlxwOKcgDaDRdozx7ivIIteUD3bH
         xAj+CNE3t0h66jUugJKCwqFmZa/plVic4zD9hhIsF+2JHM8cgcASBNJwb9K3aakZvkTN
         4o+g==
X-Forwarded-Encrypted: i=1; AJvYcCUJinsgkJT1XgOzQ9O9NBrDYo1Z0KrosWh/i4VKJGY35hgqTRmTAKjgZnNxwvXITTQcwYzBBY3PGCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAJswSQPwngf0KiqhvBCDjU7ucP6ck51wbvmTYTcgnAeFerZJR
	DI96MwuBskwWsvkypU+jRSK8Qtr5tjVGxo5ftA8BiuVPYDjHg03VnxIkbLKzUoU88kE=
X-Gm-Gg: AZuq6aLH10mNsJL8Ivxvn8rKgy+7jqzHXZ6krhNPlVYGS0oI5mM69ps0r2Ga8IQRonS
	SkduwblQfyppQMKjOinOIGb8Hum+vQbsloCH8QGMYCcQ0OEuismnS6hdfH4neapyctN6K4UsRzW
	HYc2AA8FcDLTDV+3MqTL6VZsyjxS+OJdQgWWry9gVbQakW+isWUGD7DNgTjP1lK9o56CTrL/gjf
	6p48dcZPkaM6DHU0yjeaRMfOZvWohMow70CvSIASsj+8WrJ590U6IQOgdZJTcRyQwMpuUBWuYc8
	EqLlQeDGeqrvKI0qItuaOFoLfJSQNHI4BEeBAp81cLhNJJM8VKoWYr1DxM/4AGe4kPJT5Fr7Yr7
	RumJywizjFZiQazJpeTzflumt7dy7JVauqOUwNyj1uLP50IHl3ZQyE9S8gBqAKlz4ddH5aeZ0P3
	4/kM/bh3tYCfUw2+SBrwnqRRBRCvNLC72+wAlfIi4ABfekqf4WMNsz2NqQRfDxb7ZiRT1fyw==
X-Received: by 2002:a05:620a:bc5:b0:8bb:26db:e22f with SMTP id af79cd13be357-8caef7e1ca2mr107313385a.30.1770333057461;
        Thu, 05 Feb 2026 15:10:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c075fc3sm5353626d6.51.2026.02.05.15.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 15:10:57 -0800 (PST)
Date: Thu, 5 Feb 2026 18:10:55 -0500
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Cui Chao <cuichao1753@phytium.com.cn>, dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
 <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
 <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>

On Thu, Feb 05, 2026 at 02:58:42PM -0800, Andrew Morton wrote:
> On Mon, 26 Jan 2026 17:06:52 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:
> 
> > > All that said, this does look harmless, and seems reasonable - but the
> > > changelog should reflect what the hardware is doing above.
> > This issue was discovered on the QEMU platform. I need to apologize for 
> > my earlier imprecise statement (claiming it was hardware instead of 
> > QEMU). My core point at the time was to emphasize that this is a problem 
> > in the general code path when facing this scenario, not a QEMU-specific 
> > emulation issue, and therefore it could theoretically affect real 
> > hardware as well. I apologize for any confusion this may have caused.
> 
> This patch doesn't sounds very urgent.  Perhaps we should do a v3 with
> updated changelog and handle that in the next -rc cycle?

Mostly QEMU just needs to add SRAT entries associated with the
CEDT/CFMWS it adds.

A system providing a CEDT/CFMWS entry without an SRAT entry is arguably
bad BIOS.

But yeah, this is not urgent.

~Gregory
