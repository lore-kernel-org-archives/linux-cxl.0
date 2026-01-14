Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD91275AF0
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414342; cv=none; b=kKANL/Yl48vnd04Mz/qtk6X4PoX40eebiEoW4c7hndo8FMC5J7cJgxXgLuGdO3VlE6dgtPhlgo2MzxBoWaFJ8IMqVdMHkysaZd8SjahGJBTVXzC7SBxH3C2PXhSq6ChJB3IGJYCdhIVxhfYMmSYhB7sBn3zHTyncDdKsrwcAhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414342; c=relaxed/simple;
	bh=Ludne4UyCmokfcKLruO0U5b344CQHhAN/3PEM1PYEik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0nOz1mNUNbIOEzRflz3vlEg9K+dnWQt3UakaMrRtAlpIVo3Fb9OKGSNDLMgfhCLK/YkeDA/VgCE1g/nRo4TelSSm4kpkrdKecGeBdb8X/vB0aH3CDAcMLkpc5hWP/J0EbPVoZO2OeEo305CLSxbafG5AHt/qk0DaTKMd85c3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CBNnwR6j; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CBNnwR6j"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a3b9ddd40so232066d6.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768414340; x=1769019140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfgGnc8yYPLi9t7dHOsu001XcSCAHL7N89lmWN6W/2k=;
        b=CBNnwR6js8SazjJ/vZFLbHl8y7YPo6mvqSKTLlrRKsqLiqkvCMwOtRSpSDNVyKE7CZ
         Vs0kM3ISvFxoW84GPqdwIMklXyexztqb8twqDFzsu9DSj4TGsi9INVjSy3n+dMrOiG8M
         WJSKWv1kPgCpBGzS8LIIeA3gSH2KIcsNnVmOTNyHl2WtcHNM1hwch7sfE9NTBEChi5yx
         ES7iMC7PfOR4gy2zoVgYqgu8zjP0BJTfzopY17cVrvdg1kGy9HTeUVoKXZWX0eBXgNzH
         GqRczvygU+Ss5+/mru96EzJmMLzZRl93xIKq31ffezM5Ns+9Mx5GgGip6qHQjJ965PiQ
         6zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414340; x=1769019140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfgGnc8yYPLi9t7dHOsu001XcSCAHL7N89lmWN6W/2k=;
        b=G9yx7Za0md0KgXTIKRqfby6/y+OxTHn6IRVtN96aC7New4728XFPzGit7iS8k+hKZv
         HneNqW5YQ9cGVe00pTeAQMvJsygW2grpx+BVWPvRTdBNqg6/qG4vS25G/1FgOtewvgqH
         37+fbKCSST6rgZ/m+lsd8u5OlGv00ayvzo8N2zWAKNs/Vb5j59mBU2EBSVQBhrGMQDkz
         /XmtO3sfDXKoBKzBazvLgLO7koSe/tZd/T5KQ0shEyATzcWap2RNW8EYHDObGIaZozb7
         PWatpWTBix4D9e/rUIA969eYJMNV3sNcUOJsV3/HbY3Hf2LCt4vv3gzxwM6+Me00RgQ1
         4PyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXzejWfiWSJepXjLMiqk7b4o8zwauEkzLdBw308WPYwDXtt3CvdNT4yP/jbjkawClKFYacUPq+S50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYf11c2v7p7gETO4yMRuDsD2ramHwMDteBpWshwodkPOSFOA8H
	R8dHUbjgxH7bcu8GwncStIlodo09kLG0aOQD2iozTPkXY/oF7jTqkaP7FH8FxsswbCA=
X-Gm-Gg: AY/fxX48aVZZZyWVnYqqI5D/wvWcwgDTEocJRoI2h6q2SZLxADUUwPZegTx7VhZ8yTQ
	b1atn9bjzu6jc1nrERL0MEe9O86t8XAsEjfHbJmyuyh5+c/aJS2rhSY8zBBBFBZQOiPSQYgOpW+
	7L+JMM9gj/+nDjLzyRSrEPFcaW4irXb9lKMj1+J49nXt3+aOv09OVF4QAtUCxf4lkE8xdWjCyqb
	USZ1UXR3PgreioAA3DIw2v2XLWXg2TmKpGwLpAmSlFim32GF+LDUUs/AZCQ7WQ8lfl8fxP8q5VO
	DLYgrEhhzu78oewjMPaFBiF0BC7F+3z8/3iPpkvCg/sZK2Kyl7/7SLjGbv3/zIe/KV3BdCp0Rvl
	5xyYTWO0cdrYhurJkA/o62EwYdQavs1k6MOI+ziCD5zeVWktXoCgXyFM61Sk/az18s2XqBob8XV
	BWqBQGkvUQ6+d6LmzVXBFj+FxJLp7TY6zltU3WHt2QIRQMJ6vnAgezt4C+wFe+fgvYWbASQA==
X-Received: by 2002:a05:6214:10c2:b0:785:aa57:b5bb with SMTP id 6a1803df08f44-892743cfe92mr35226416d6.43.1768414339907;
        Wed, 14 Jan 2026 10:12:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770d17a3sm181634186d6.9.2026.01.14.10.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:12:19 -0800 (PST)
Date: Wed, 14 Jan 2026 13:11:46 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kernel-team@meta.com, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, osalvador@suse.de, akpm@linux-foundation.org
Subject: Re: [PATCH 7/8] dax/kmem: add sysfs interface for runtime hotplug
 state control
Message-ID: <aWfcYjZVrROHfGyh@gourry-fedora-PF4VCD3F>
References: <20260114085201.3222597-1-gourry@gourry.net>
 <20260114085201.3222597-8-gourry@gourry.net>
 <3555385d-23de-492c-8192-a991f91d4343@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3555385d-23de-492c-8192-a991f91d4343@kernel.org>

On Wed, Jan 14, 2026 at 11:55:21AM +0100, David Hildenbrand (Red Hat) wrote:
> On 1/14/26 09:51, Gregory Price wrote:
> > The dax kmem driver currently onlines memory automatically during
> > probe using the system's default online policy but provides no way
> > to control or query the memory state at runtime. Users cannot change
> > the online type after probe, and there's no atomic way to offline and
> > remove memory blocks together.
> > 
> > Add a new 'hotplug' sysfs attribute that allows userspace to control
> > and query the memory state. The interface supports the following states:
> > 
> >    - "offline": memory is added but not online
> >    - "online": memory is online as normal system RAM
> >    - "online_movable": memory is online in ZONE_MOVABLE
> >    - "unplug": memory is offlined and removed
> > 
> > The initial state after probe uses MMOP_SYSTEM_DEFAULT to preserve
> > backwards compatibility - existing systems with auto-online policies
> > will continue to work as before.
> > 
> > The state machine enforces valid transitions:
> >    - From offline: can transition to online, online_movable, or unplug
> >    - From online/online_movable: can transition to offline or unplug
> >    - Cannot switch directly between online and online_movable
> 
> Do we have to support these transitions right from the start?
> 
> What are the use cases for adding memory as offline and then onlining it,
> and why do we have to support that through this interface?
> 

After a re-read of the feedback - are you suggested to basically kill the
entire offline state of blocks entirely? (e.g. if a driver calls to
offline a block, instead fully unplug it)

I took a look at the acpi and ppc code you suggested, and I think they
also have "expect offline then online" as a default expectation.  I
can't speak to those users requirements.

This would definitely break things like daxctl/ndctl, but maybe that's
preferable?  I pointed out that patch 8 does this anyway - and I'd like
input from ndctl folks as to whether that should end in a NACK.

~Gregory
