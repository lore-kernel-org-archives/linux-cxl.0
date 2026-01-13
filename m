Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC24D3921E9
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312560; cv=none; b=ILJpWCJt0564U+4nVgQ7a8K8en3F3sWJPvZhT9IMvJMXdOZ9FXNhjulFwePFab6zylYlpny4thbwTjrBsR6xovYQBEEjg9PDYuAVsMACsNfaKqTd8VydL6ifvsJjg88+DQplP2TQsM/N0N+Ql5hMe5djo3O21Dicf+NogWGL7mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312560; c=relaxed/simple;
	bh=xBKJZJaq58dkfEBp5UADogC3I/NHOLgLZ8uI94yH9Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehgJTMUa0vEoXWzxg1kaZkpF5SvZJBNNuN2y0p3AhbxuHvW60Qum50mDR4Jo2R6WoNNnLjLlZJDcjqQYzOJKLR27fFq7aAmZeVaC96CRlUkA1Az+etddRVEoiKbIK4V6hvsYtp4l7LTvvY0DDE+iz0E7S4At+RHH+OF8Tgn2PzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=t0ifdMef; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="t0ifdMef"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso40934691cf.3
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 05:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768312544; x=1768917344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MgVKM12PPuEhN+GtLeIhws/qU0BjDyGSzafJ6+BtXw=;
        b=t0ifdMefP9ykjBGPRfjjbhG1+5ijyYk/Mmq1w8U2njTzZjgUC2IJJZA2L30eo754Gb
         WYyQFk8YZYyAkDY/oOqpHVYrshWzIrlRSZ4eYqr+40TjdG5snOfand6+8VrKguIZ8U8m
         793vfw25VSRH7jcgWcdWepzonGFdyqPaZohn5+n2eVzrHGKynUyz67LjYnBG5ahsulvS
         ZNqlfeauugOVrrn600O9Lec4XYWPnUz0Nsu+BN/AZ+ydZJsD3DjI9G3fZTutAO9ES8/+
         GZhXvdROgb0BOCHPm3K9ZG+EFMYViuSWmOJ2vMttd6L/CSxpbEKgsSpsdafpQdHrGPti
         9PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768312544; x=1768917344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MgVKM12PPuEhN+GtLeIhws/qU0BjDyGSzafJ6+BtXw=;
        b=py2WxWKB6s1uaNzn0SwFaKoKfefsZwKhunsYF218l/vSXzXbav605rkwRFvht7LZS6
         sPsQ19F5Y4gX8/lVVyW//tNXjc26U+miO34LaapnnuJ6jan4B9ol1Ltgz0puygEr8zA1
         G5QdO49wSFRKntQZDoRf3SpdeGwle2OP9bSXzqPBx0DxU1PQ4Zr7JNBavD+syZekqfjb
         1sXALLltiAa4uSxb9SowegqQ8yXSN7WJ0UvCIpRWUzRg6XU+pn3fYXyZ8jJA5HpEtDRd
         WZMr8gfYNRI2SxxOoubuau+WiP6mNGkXDVYOYlDSz/zuMUOypgnJrVIQV+r5u4g7i8Ak
         /T9A==
X-Forwarded-Encrypted: i=1; AJvYcCUdhNQUnIQw9l1wTPlzYeVkXVYTO3J4NwEVljPHCS3b5EXzwGIDGlhIjoCXXLCemq6vPno8S9Iu8oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bh8Nfx5wsg51U5HEDqnusXjNjlCeSQWbPixhhTkvVW/Anjwe
	AfQHcSq0fNuEhRNx8Ll1YeYwY3X3R5rfjFq7vOipRfGpfOkIERw/W5duUdqDdp5C/ow=
X-Gm-Gg: AY/fxX7Ae4QryFDBRizNvrZxdf0sHwp35rPF0Pl6lWq3o/WzFeV5ENc0JqlpOeGJIRN
	I/LHwYkitW/jySGLNkI8bMRcDXFAtq5CGP3bSVFzaJHl7nJY+ugvGxo9QAezwrQed/pCPNeg4F6
	o1bsAkd6caUxHfHpG+YLTtrXBgw2YyypA76bxXAOEr47DkaknMBSK4mfEjg+uTsrHGWU3oBo2gu
	fAyc0Tsf36OIOLysRANnzzgBKT7Jk0Dh+WEzmD3iW7YYgpsenDVnzc4zTFPKQnogKdaBGsJXVFv
	N+km7rkrvh5Oe36oKUPpBPJJ1ZszK+3lybaeTrOhkhuJCf7n3VxFKZzxS69NmghD5yMuZTqSEUD
	ApIRO5xO7diIL7aqWWmWgloPgIaZv1wxyIXmD+LtLpPBWKzReUBtrm7c/ZbetwLB4WX6Yh3uuLW
	jHtxRYPFIPSj2C2lnQiCPLEYHS6z16lxCXrvZ+sbJLmpzNhQyPIF9n5wVV2VcMf3gPhXjJuOE7+
	RTkxElt
X-Google-Smtp-Source: AGHT+IE3kt3s0DLMOPwLiSdVdgOeQtw2p38PZVQ2YGk1VFWgC3l7L3gBOxrJnRu4rRu8OIwLGEfYwQ==
X-Received: by 2002:a05:622a:244a:b0:4ee:49b8:fb4b with SMTP id d75a77b69052e-4ffb4a9aad2mr295553631cf.66.1768312543593;
        Tue, 13 Jan 2026 05:55:43 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cdfb0sm158070046d6.6.2026.01.13.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 05:55:42 -0800 (PST)
Date: Tue, 13 Jan 2026 08:55:07 -0500
From: Gregory Price <gourry@gourry.net>
To: dan.j.williams@intel.com
Cc: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH 4/6] cxl: add CONFIG_CXL_REGION_CTRL_AUTO_* build config
 options
Message-ID: <aWZOu-6ML_kd7DFX@gourry-fedora-PF4VCD3F>
References: <20260112163514.2551809-1-gourry@gourry.net>
 <20260112163514.2551809-5-gourry@gourry.net>
 <05591180-c299-42e1-b8a0-ddd74c5f2174@amd.com>
 <aWV-H_YbSrmgAZYd@gourry-fedora-PF4VCD3F>
 <6965cabc68fda_875d100c0@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6965cabc68fda_875d100c0@dwillia2-mobl4.notmuch>

On Mon, Jan 12, 2026 at 08:31:56PM -0800, dan.j.williams@intel.com wrote:
> Gregory Price wrote:
> [..]
> > > If you remove the 'auto' mode earlier on, then you can just drop the first sentence here.
> > > I'd also add a note about when a DAX region can be failed to be created (i.e. BIOS already
> > > set up and onlined the memory).
> > > 
> > 
> > I think I'm just going to drop this entirely, probably this was just too
> > ambitious trying to create an easy transition from dax to sysram for
> > auto regions.
> > 
> > The reality is BIOS-configured decoders "is NOT the way" (TM). If BIOS
> > configures it - it's DAX, otherwise the user gets a choice (or they can
> > tear it down and rebuild).
> 
> Is the plan here to "whither struct memory_block"? I can see value in
> starting the deprecation process given the problems Hannes points out
> and BIOS alignment causes massive numbers of those things to show up.
>
> If yes, then even if it is DAX the distro might still want the option to
> only allows for region-scoped "hotplug" rather than memory_block-scoped
> "online".

This was not an intent, but maybe?  I'm not sure what the larger
implications of this are - except that maybe poisoned regions of memory
might take out larger chunks of hotplug memory.

Other things may depend on memory block size in unexpected ways.

I think maybe lets tuck that away until after we get region-scoped
hotplug.  Maybe it would look like this


Step 1: Region-scoped hotplug that uses all the blocks

Step 2: memory hotplug callbacks that disallow any hotplugger (except
	emergency hotplug?) from acting on individual blocks

	We already want this for online_movable, just defer a bit and
	make the guarantee stronger.

Step 3: deprecate memory_block for something else?
	make memory_block variably sized with some base alignment?

~Gregory
