Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB955E48
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jul 2024 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944809; cv=none; b=CW/QsJd6vOAMfxrDewfY3EKwsyJ5lRdQMmfJps6mZ/a+o71irVW+YLrZc6+w4qYr9aKjd37Zwn86Rfvk0KqgpCq6+VgxLuRnPTh7022EhsejuuRfxUJ+/9qWK+ukdluVutgYKFBxqIuuLwxf2XI00yPL98A/yydR8Awem+r4A1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944809; c=relaxed/simple;
	bh=KSjDde/wW6D5zE3NvMhyq254W+T5OiyoyXE8khJZn6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz0rA1QomcoIjex9E4VkMtq0OaSYMBWLf/PIATJZimXrCinS/BU3a6F3rs0slDe2tdq51XYfxuGwF9fns/Y0MWDY0Od/4nmfsXFpJXQ84tMWNgZmfmzxRMmQwvl2As23fOGhJNECrpCZWVqZOyXacNa8xAOThAtVZi0aNmPjtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bJnv0gPs; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bJnv0gPs"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-654cf0a069eso14249427b3.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jul 2024 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1721944807; x=1722549607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMAd4iLmUv8odVu7JAFB9ApmQQP3eAOg2M6CjRWnesE=;
        b=bJnv0gPs/bY+9s1BKhucvuZ5epkajJkx2a5xicKqaEfVcjq5BHM6EPvmaLJ0cGTb0Z
         zUwhGsc95FED1+3Rrj+YxQjwzIxzcd25/kgyfoMgAcl6nHE+ilJEQddgpVcJfLF2Zt3r
         ByYcacxTqB9gxSfUevjXjBvptE80H5wudG6UJHTKuaGXJwpj/PKdj0OH3Hgo0grISq00
         P4wjaLjNYkdNwMOOa5NRwm7sEE2+BVo+prG9tNrVH3GNLHkruoq3OwpshiZs3v5eyU4V
         LKC1mWl2N8PmjfDNhjcfwPxhCcWR2gWgFaObqHaxQ8S6HN3eyoH3utj7M2KPkhQcV7AT
         wB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721944807; x=1722549607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMAd4iLmUv8odVu7JAFB9ApmQQP3eAOg2M6CjRWnesE=;
        b=SDFdgLIX1ZTg3TfIWz5CARXvHH5Ja7n6L8KCkuXdQJWBNhzFIpk7paBzRI5CMW8Cxm
         f79/wPyAyQJN6pUmsc1raWXKI3I1Pz3ZN670bTCeF2vH6FBNyPSNBqjwZLC085b2EU4D
         YCMNQICWC4nGJT3a+xZcVkgFGR8pe8BG8pA99N1d1c1SkuVjjCqQH2iwq4b9lcdLiqII
         h2Bu5CwOPGSewsJbLoyMP1281/MhFTlVFRHCZNeqHK6l/lG+tIk9eJ7hOys7cwlh8Szi
         WYboaVy8dYuzXiRMHvmiILvfUF1ahPboIAhuBa75oEK+nGb+Ustyo70YEiUErfi8vQWW
         uWig==
X-Forwarded-Encrypted: i=1; AJvYcCXw7IpB8jG1Uo14T6j3cUwll864PRu7me29OuzLGmJYUvsGGlrKXM1s4eBfHI/EVw0albmxaf69rIwyfob39EiCNGGgCYzZuUlI
X-Gm-Message-State: AOJu0YzMFXcniDAhTXYiDXqgYtgZZhPbauNUDOCWBzDosM9kzK9nGCY7
	UapOznsg8mAiVCtGepL6O7BPJCx2Rq2WO6SqXk8ojLgqsV2cWSUibXzXZmGRO/s=
X-Google-Smtp-Source: AGHT+IHdUxAEWXGqn6foo0jARHDLvQtDiKUbJMw+adb16WFCsoSLyl/dUufXXzE7h2ov1yGNj9pzHQ==
X-Received: by 2002:a0d:ed03:0:b0:64b:630f:9f85 with SMTP id 00721157ae682-675113b347dmr45040387b3.12.1721944806711;
        Thu, 25 Jul 2024 15:00:06 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac10e3sm10707486d6.109.2024.07.25.15.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 15:00:06 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:00:00 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Address translation for HDM decoding
Message-ID: <ZqLK4CpSg4PfAdGx@PC2K9PVX.TheFacebook.com>
References: <20240701174754.967954-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701174754.967954-1-rrichter@amd.com>

On Mon, Jul 01, 2024 at 07:47:48PM +0200, Robert Richter wrote:
> Default expectation of Linux is that HPA == SPA, which means that
> hardware addresses in the decoders are the same as the kernel sees
> them. However, there are platforms where this is not the case and an
> address translation between decoder's (HPA) and the system's physical
> addresses (SPA) is needed.
> 
> This series implements address translation for HDM decoding. The
> implementation follows the rule that the representation of hardware
> address ranges in the kernel are all SPA. If decoder registers (HDM
> decoder cap or register range) are not SPA, a base offset must be
> applied. Translation happens when accessing the registers back and
> forth. After a read access an address will be converted to SPA and
> before a write access the programmed address is translated from an
> SPA. The decoder register access can be easily encapsulated by address
> translation and thus there are only a few places where translation is
> needed and the code must be changed. This is implemented in patch #2,
> patch #1 is a prerequisite.
> 
> Address translation is restricted to platforms that need it. As such a
> platform check is needed and a flag is introduced for this (patch #3).
> 
> For address translation the base offset must be determined for the
> memory domain. Depending on the platform there are various options for
> this. The address range in the CEDT's CFWMS entry of the CXL host
> bridge can be used to determine the decoder's base address (patch
> #4). This is enabled for AMD Zen4 platforms (patch #5).
> 
> Changelog:
> 
> v2:
>  * Fixed build error for other archs [kbot]
> 

Hi Robert,

I'm looking to test this patch series but saw you were looking at
reworking a portion of it.  Just wanted to inquire as to whether
you think I should wait for a v3 given this is a few weeks old now.

Thanks!
~Gregory
