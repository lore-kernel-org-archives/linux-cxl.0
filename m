Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532311BD01F
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743570354; cv=none; b=jajBFsLnXlp84taIaae+VL0vayokr8FSpp29VU0IJt9iny/fgWkY8qJ8AnXNT64IbFsYGSMtwzTEjRJXycWKLLV3zn8hbnm4FuCBjI4FKSUct+jw8HgpQNyLdKW1KKzwHCbj1vgTsmVdv1FKDnfCrgCtvmhYoJ8xppq9sUvfNJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743570354; c=relaxed/simple;
	bh=ToBtS/Fq7DMHoT1e2iY+L0xTZeqkApz5pB3d7f0G3bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwDcGQ6jPx0f7djo6zwCz0t58aO4BwQmJdO+zIYIDUkagfRwRMtA4JWqy/Y6JCnzc/uJS9HbnWclJThIf0k5Bu3Q+rtFRRFykBe43laZCZpSA9NCVGKW3UsCOyFqNgSj++JFbH1mUT0FYGLn0zYSquG43dhRsXNs+lKN7+uGte4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Qww3K6ZN; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Qww3K6ZN"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476b89782c3so69495601cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 22:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743570351; x=1744175151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46m3GPuzo/ijq2+XYsa68t/WcXGozC1h1ijATq7sgg4=;
        b=Qww3K6ZNKTrMfzyFEZdddf7/sAC2VlxiuI612xh2s4rrwgUJcrI+ID6Tw7Z+5Aoagc
         GKOVdoClgKV+WpvsgPYeB6/+/IDL6TixBRf6MEdcNA1tgUgr4ZQueUXe/KL4JL10PyJJ
         0U0gXp0AEf+lHg1sigeS1xLofhqJZTAhIeZIAVcrmc5GJCx7JdGBntZhN8HhToNNOLvt
         /Mzs6uFTfQiK5bCwfIjB5RxjR/vpGs0MWMA+sJ4FHDikTYlK/WKXTVWu8c7pUaxHP8/N
         RaHd9rqpEBgGReZng1KVGVy0sBY++7TAMJ/FuzEiKzWMULHxd1SA1l5lkyVavufN8B/L
         gf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743570351; x=1744175151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46m3GPuzo/ijq2+XYsa68t/WcXGozC1h1ijATq7sgg4=;
        b=KssofaAZnyLb6+NmgED4q2JEEq6GEzGpujHh9Q/q897G47ysIlXlpfIurF8xiHBMwF
         ilySHvUfXU8ofi+YHHkiQ0K9j11rxBZMvusoSfUOqoMxne3PPIGTl0N2Ov59vgW5R/a1
         fnbl7w4ePW3yjnsSBBrtyObC5IuqQ5Y5K3yGkSY8dX0gtAtflDwOC1coqBX8DnMl7x9q
         GFcDlsU6MYV7SfIeC4S3vo0ufJgLE4af08BDRxf8m9ygYLB9KHQyxGo4RVPw8mXgObLs
         aZa1UHWh8U2kX+Rr6xHDz1zSKwH2cD1KULmBUiZSDJc+619q7e9ZbW3sjmlWay7j2AXf
         RQrw==
X-Forwarded-Encrypted: i=1; AJvYcCXUlRjCxbrRg8glIqVukyjiMAR9awBKALLrkcCmNLYWar3blZHxSw1ywlaunjtb7AJ9uO5P6PdNqqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDkQ7krfpjjbwJUPWBgUdfY3+pakNiyRXYPhGp/mQV8aupxx2
	VD6zt4uXTtZMmGUXLyhNYb5y3kCdB9lutrRse9SRhv+SP/cE7x6oesZzTroEwrhkwwfKIpJGvok
	m
X-Gm-Gg: ASbGncvLzM/5dbb0heUBzh4yjPKszZy5NC90AVx0P85lYSHJNAadR/3AJZ2bPMVnE1j
	zWmky1UCbMD2M/sP3T+1Og97LzW/o3KyRy4wLr50ARMvNvWrA/nurJqYFLcXbX8MxOVn/CFoQQV
	HEz17Nj3kejqIVzswhQWdQx7PZYQd7MWf7UH0/6dzS70iruUufQdH7q1pJisNjZbWwfghZHmAbq
	alyM6VTSBcx7BLLwVQcEUJEJndI4YyHuCAu1fIOGVU04qJvmYrjYSgn0cyh7g2ihSJeb0JF2akg
	ey1mC6pUbFO1sPQZqPM7rMsdR/Q9ss1+pQ6xfXmwx2vYRV+6FzRMFADx+7SUxgnLzOguJP60VVe
	6Ja0dd8tf2at8iRQpJPgpun7JOHM=
X-Google-Smtp-Source: AGHT+IHTe1SVUeuYXh0ubFlwsbzJ9Pp8B2+0OWLUKDSPQ4T5nDWaqnAyykP7ESnbJY9Hs/1MKNXpWw==
X-Received: by 2002:a05:622a:592:b0:471:cdae:ac44 with SMTP id d75a77b69052e-478f6d6b005mr69196541cf.47.1743570351163;
        Tue, 01 Apr 2025 22:05:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-477831a65a3sm74670621cf.79.2025.04.01.22.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 22:05:50 -0700 (PDT)
Date: Wed, 2 Apr 2025 01:05:48 -0400
From: Gregory Price <gourry@gourry.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4 v2] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <Z-zFrBqZHc4UWvMb@gourry-fedora-PF4VCD3F>
References: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
 <20250114203432.31861-3-fabio.m.de.francesco@linux.intel.com>
 <Z4ccKD9Fc-Egc6EL@gourry-fedora-PF4VCD3F>
 <67ec4d61c3fd6_288d2947b@dwillia2-xfh.jf.intel.com.notmuch>
 <Z-xdYvxD6yz3fMiE@gourry-fedora-PF4VCD3F>
 <67ec7814ea055_73d8294e0@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ec7814ea055_73d8294e0@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Apr 01, 2025 at 04:34:44PM -0700, Dan Williams wrote:
> The platforms with this condition want to support CXL mapped starting at
> zero *and* the typical/historical PCI MMIO space in low memory (for
> those PCI devices that do not support 64-bit addressing). If the CFMWS
> blindly followed the 256MB*NIW constraint the CXL window would overlap
> the MMIO space. So the choices are:
> 

If I'm understanding everything correctly, then I think this is intended
to work only when EFI_MEMORY_SP is *not* set for these particular CXL
devices - so it comes up as memory in early boot and we're just trying
to wire up all the bits to let the driver manage it accordingly?

If that's the case, then ignore me, i'm just bikeshedding at this point.

I can't imagine a system where the memory at 0x0-4GB is intended to come
up as EFI_MEMORY_SP, so I hope no one ever tries this :D

> > (Also, I still don't understand the oracle value of <4GB address range.
> >  It seems like if this is some quirk of SPA vs HPA alignment, then it
> >  can hold for *all* ocurrances, not just stuff below 4GB)
> 
> The goal is to get platform vendors to define the rules so that an OS
> has a reasonable expectation to know what is a valid vs invalid
> configuration. A hole above 4GB has no reason to exist, there is no
> resource conflict like PCI MMIO that explains why typical spec
> expectation can not be met.
> 
> So I want the subsystem to have an explicit set of platform quirks
> ideally backed up by updated spec language. That allows us to validate
> that the Linux implementation is correct by some objective source of
> truth, encourage platform vendors to update that source of truth when
> they create new corner cases, or even better, be more mindful to not
> create new corner cases.

I follow, seems reasonable.  

~Gregory
