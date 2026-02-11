Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1E1A5B9E
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822288; cv=none; b=Bqhy37NEg38sYvLws8qxpB3ZEC1v1aePqSbwiVUa5dsIfgnhC93z1o9BiEncWu95HsU3MIsiLtyE3npYdMrfbqVcf+Vs63ib+585BqxW3vObmD9Hqrvv43RVrJeNBgkDIAsp0Lbrt4+bU3KYDM7ylLdWYW0RxiUx/xpbxDTD9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822288; c=relaxed/simple;
	bh=9ynvU7rPH2rQeYJAmZiupmPoo+/r92CyhmXEOK8Dw4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFiwLRBWFhKIApOdxPXYfrC/86m/Yy2EdFaxlOQslKADfAXDjAkmIPWJortIuYS02Uvb3GXC4IHElsmTvZsKBmf/IabhlN6FuY6iN5vfX2hVnkiJ/9Ef7MyNFXHmhHUE8IvWN2l2wcI4h7Zob7+58QZNoVxnYSwmGjzcJNvkasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FfQvdvjD; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FfQvdvjD"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c70b5594f4so112074085a.1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770822286; x=1771427086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ieMJcsroJBLEY8F2stYQNl2yn5l58s+hOlrdnQy3zyw=;
        b=FfQvdvjDtK1RGomSUzD5n/KBkm71nk3TTToQJBvGwv+9zITPWeRYuzdmV0NtO4mce7
         Wi1LEEeMWxetz7gd1d76vBwNpO/yIDKdmy6jGpAK7yi9wG8kjDRF5MHr09YNSstt7Rkv
         r2O4QCBxlgAzGBfpDk9kKysFyI+cLgOIz+/yEpxgB/KDWvL580QiBv/LwfEd6O5/Zqnk
         apEsxLVbkBOs6xXHT40MPoNMJvl9FpyROjkDjafMKRfwu4ShpoxJtLTblkjfx4BEc4tt
         CitnjrvQfJ6QxYTnQTuQDJut3F72zBG1Q2zcvtY6EYorElPo3Uc3m0tyVdC2YnZSC/3L
         sCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770822286; x=1771427086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ieMJcsroJBLEY8F2stYQNl2yn5l58s+hOlrdnQy3zyw=;
        b=PT+4PfuKk0vRawu21m/5xbx0LMyveP3qcwjKWxOdCLrCzfOgjMOw5EYFutGcFo7kCt
         mmtMgGGzILNRqWPYTJtUPlhU/G/LeYMIvKNR/gT8mLPoQWhfRIuLZozLYH+Z2cNx4AwY
         bs17ZpHFLSY1FASpPbvVZnf6tANC5wAG+2ROPUuZmyiS60MpwxaTkX3+Lg3bdfTOuxbS
         EkzfF1vKKfflC1ZPtGl/jtrJ0X1xE+ljBfVg4AUEweNXKHC6uQJKYM0rQN2ESaawSqMu
         jbqLVujtwe6hp8X8rzxza3KH2WGR7HNtobshT+5nMYYqkNbgLMXCcuBviZdh6NQXN4Nw
         wQPw==
X-Forwarded-Encrypted: i=1; AJvYcCWSw1Pg4wV6Ff3kbqt/3CHPZcNJJ/5s++IkCMt9wIazGPTsUC5oYVZRk3gIFq9xLGkYqXY6xTSay2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYqRz/uqCB563nYlYYTODeROn/7Zn5ldXYAledMowqAmOdo4ak
	DHAXNI35x0420kLjjoxQZG9Ni8zdI/b+e2H+YkERvY8aqHvgkKDVR+xYMJQI2x70L18=
X-Gm-Gg: AZuq6aIA4z/PWAw3WUtPNNvZZDf8TCsKOuLKyTPnmVZzJATmugSWab5eDV1nSk9OfQ4
	B2pAUuLXYy4/AbqIp61J11LE7jnUUhyAVkEAVGVhZiOhtkuI78UfS052Jrl6MiUjmEWH5mI+B5f
	FaNoyI1TNXOlP8M9gVV6Ypy6X/LytbeMm+VmoqcmxgXy5nXbDHdoEc8Ofhe8YrULbVKIm5ShPtA
	JcPJsHTnQifhe5kEHbHaq7Bbm7ZCQXn7H3WkryC/cLAOiycbfWxcT8fw3gqS3/7QiliBymcGelP
	Qr9rsXf92QQXvmIPw1UDMpRS84qlRkiefWtEn4BVycJLZaYQlRlc6rn0AgDI3Jx/nizVe760Oqh
	r6zsn/xc64JqYTSwwuYWTuLNpUTWQUT8ERRaWFrBChIWgjXikP4XAsQ6mSqgS8cQjmDPd7l0NMl
	S4W9h60SEebLrPY6lzGupd+GQMXYx+Uv5iUEXvzfhemwJ3rjK49M0GYK9u9X9iIavdTdvzGLfSh
	NLJ/uL4ew==
X-Received: by 2002:a05:620a:470a:b0:8c7:1316:b0eb with SMTP id af79cd13be357-8cb1eeeb94bmr743050485a.8.1770822285705;
        Wed, 11 Feb 2026 07:04:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b2346dasm125436385a.48.2026.02.11.07.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 07:04:44 -0800 (PST)
Date: Wed, 11 Feb 2026 10:04:41 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
Message-ID: <aYyaicFMzfsd8eSq@gourry-fedora-PF4VCD3F>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
 <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
 <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
 <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>
 <aPeSqjqU6BH9gvcw@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPeSqjqU6BH9gvcw@gourry-fedora-PF4VCD3F>

On Tue, Oct 21, 2025 at 10:03:22AM -0400, Gregory Price wrote:
> 
> Re commit order - Vishal said they do post-lock order
> https://lore.kernel.org/linux-cxl/aOP3Kr3jHLWOydRp@gourry-fedora-PF4VCD3F/
> 
> Post-lock order
> [programmable] [zero-lock] [zero-lock] ... [zero-lock]
> 
> Pre-lock order:
> [zero-lock] [zero-lock] ... [zero-lock] [programmable]
> 
> My reading of the spec suggests that Post-lock ordering is *not legal*,
> and would suggest the software has deviated from the spec - which does
> not allow for size-zero decoders to ignore commit order.
> 

Revisiting this - it might be reasonable to allow post-lock ordering if
*all* decoders in beyond the programmable one are zero-locked.

Seems ok? Thoughts?

~Gregory
