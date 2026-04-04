Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461163081D7
	for <linux-cxl@vger.kernel.org>; Sat,  4 Apr 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775328815; cv=none; b=He5pDew8iPMDvryx0u9yhq/Ge9FI6Q2GgOpybbEhZVfgFAWricRrZI830Q8CEItuz2IzlP1wxuYiL5ekbge0Uh2SqvvAo5zCS7o4Y8lSJ3K7qYo5jq04ON2ZJ8tQF6Itx8l8MMQ4Jb4YhpNFtMvORG4CxSqd8MjG9ApTB1o2t9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775328815; c=relaxed/simple;
	bh=dtScXWXhuDldnt6Kvgogigjrvo1FHXnb9GiXekrXjiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKNvhgXtLVR61diOxfigkx3FimOddrv3l8cRTwaNqL6AKWzg7QjT+J6vGzzkcMr/oXCh9yEoIJ4LH1GH9rckh9qTSBp2nmNPrlu6boTbNOF5vcwmrqEOyEki17xRuJF2YVMWad8AY1GyHMPjb/zQUTzjNBYq4B+vn9zgukTzTQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ByDIMUKw; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ByDIMUKw"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d4f78fc9f6so154135485a.3
        for <linux-cxl@vger.kernel.org>; Sat, 04 Apr 2026 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775328813; x=1775933613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nck4cGiGZiXSzZzHQhsuUAn9cXTimQB//kh9QdWI6lU=;
        b=ByDIMUKwmTdGCOxitwoHje2n/+PTeyBAv707lgF33j61xnMUcwkFFHQqg/RkbGFaHh
         Zz6yMrfvfJnvp1flwz60AtMoXBTvUV4tbTb4YcH9CxdfZSk5kxULJ8Ifmacf+MQfqZqs
         VWWcDBe9rURqQ9M7dosyV3nNTgCDXz222O6V/tHlKCwsbnzrIcB569Ghy8B6/p9i9nsW
         5tJiNINRpJWSZe0MKlDI+X4ZcTXtdZZtosUT9ATanZKqQvVfbL7H1aJUiHQjy48Qa8OJ
         4uG5XtFt90iMXBenMCAVNAUjfUy0eEjr2qLh2l431Rryhh7wXaNGNfAU/uH1jB8IQ79y
         azmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775328813; x=1775933613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nck4cGiGZiXSzZzHQhsuUAn9cXTimQB//kh9QdWI6lU=;
        b=Vz/cKsXS2omCWqozWtXff7/qwR+Fn0Q03W65mM7g9jR4ZFaCWX5vixeWAtMGIQaqwm
         eFzhaI+xDjwgkWGc35pZbylL1cW7IUdm7qVE5FTaVSPdQRXf7ZkkCrn3x557T+C3JU5l
         3k1+luWMCHqwbOJe16J4z9ohFHlSH4AeyKkoD+4zFthQQti2irNZM1p5NmAcCrjHp44I
         L+RpK6ijCL305Dz0xkyQaJQnW5YNKhcsbmQUxMC3pFR66V2sT510rHPbHoJfF0ndPO50
         ZGBne/Wut0J/X7TRogBO0VDPtYYSLXcRjBg2hDJrD9hKW37IMmvyx49OxvCEkk/+qKJT
         4K1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHwia2eQZopsLKN7cGHzma014aMFlOVN9AAQF6FkmTnlui43XzeRB1R8eIXD6VVfN1IcvPLqzyZQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAE5JdmXjVseD5HrOC7asGkwWVJbmTY39zcHppU4CcxsjGiMc
	ifsWhwddDvS59wG8/TyuoCoa8aJ+kNPn2Bzsn/i0MYVfAJ1TooSYyKqKqSpw61cPNyE=
X-Gm-Gg: AeBDieulsDJsST2oc/a8mbjEEAIcCwbwsrXup/v8wlnFuevGemRJYh1OrfEQRGvh54Y
	r6HoqWENkPhZRpXFzqGXgSS+CQr071Ogv3QvD0q2H38fsY5vuDZLreEChkGKbSbB7zYQZ6vmEoM
	9mK/zgHcdsoQSzXyXn4z5tfuUyUBLoKYO1BXbpnuHAsUX9b6Fstd0wIj4IJMQJ/LN6fAy6THCYK
	FunPE8hFdKKh7chkrUCd7JgLd7Ckka36JwR0t2igjKMsfn0seduMR2Rxt96I4w9cSYWgHVbf0iq
	KN9D6xKX4O8HFsmjxwfRj8bSzdtnoISRE/F9ua2uzYtCFrDqGx0iKLUtE/tBJheFbdEP6KXP3TJ
	zHhXknCzYTYYrGudPGWxnPQrr9vM8GY9n7pHSAgkg0kdKbW9lxRa2ocQjHqp/K+44KR1Xvonzoc
	Fz1K4OFO0UYBpqCxOR/f6YIB2z7M0WrjNTGDggHQyFZICfmoGGhEJPgMJ4xI6mwN8PZBcezw==
X-Received: by 2002:a05:620a:4003:b0:8d6:bd01:a67a with SMTP id af79cd13be357-8d6bd01b3f5mr99323085a.26.1775328812984;
        Sat, 04 Apr 2026 11:53:32 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a864b516sm733755685a.37.2026.04.04.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 11:53:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w967e-0000000CyRZ-3Zuw;
	Sat, 04 Apr 2026 15:53:30 -0300
Date: Sat, 4 Apr 2026 15:53:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Williams <dan.j.williams@intel.com>
Cc: mhonap@nvidia.com, alwilliamson@nvidia.com, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, dmatlack@google.com,
	shuah@kernel.org, yishaih@nvidia.com, skolothumtho@nvidia.com,
	kevin.tian@intel.com, ankita@nvidia.com, vsethi@nvidia.com,
	cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com,
	kjaju@nvidia.com, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Message-ID: <20260404185330.GD2551565@ziepe.ca>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
 <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>

On Fri, Apr 03, 2026 at 12:35:45PM -0700, Dan Williams wrote:
> > +	/*
> > +	 * CXL device memory is RAM, not MMIO.  Use memremap() rather than
> 
> Right, CXL.mem is RAM, not MMIO, so I question why is this not being
> mapped via a RAM mechanism? Can you explain a bit more about why reusing
> vfio MMIO mapping mechanisms is suitable here and what happens when we
> get to questions like guest_memfd integration, page conversions, and
> large page mapping support? 

None of that is applicable to VFIO. VFIO owns the entire address space
and does not share it with the mm or anything else.

> Maybe this is the start of the conversation for something simple, but I
> would actually prefer uncached ioremap() if only to avoid all the
> coherence management and suitability of MMIO mechanisms questions.

The entire thing needs to be mmapable in a cache coherent way since
that is what the HW semantic is. If you try to do something else you
will break KVM support since it follows the VMA.

Jason
