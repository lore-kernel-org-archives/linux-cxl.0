Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EC2BE7C3
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063777; cv=none; b=B9q29aR5mkAuBxBkMq0UpC2Onf63pF93H1JNlTO/2EBa+D75UUvW5cAcs1BN3ZgmN2wsG2ag2Z0+268b450+UPiL9f/q51sqLVaL2SbO9pHKU7Ei4D8KXFlzS5eDeI8Z8dybdmcvDyeon3dRphaw0rLkim7X/dYjB+o2eWsbB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063777; c=relaxed/simple;
	bh=JQfcfUUd8XuDiRHFdF+25+0jAwh/fTTxY7PfkjJ42ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkUtOFqbgk9vkSLpwzl2Eh39uPDTsjFX8Br9AEdaWxSdogm/TasreEtcNguLEE84YFdpPpv6Vh2F5ME179W87k2Bw71zvR412a1Ex/HmEGP+amANccVkA1WDlZ2RNYH05JhNDqBKjalFnQueGu1CQWdivDCGIXICzs7JZVlCnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ty27rvxr; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ty27rvxr"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5033a2c4b81so58117201cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770063773; x=1770668573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5DQQ/80oIeISv/l0flaFn2oFu98ezlgiuT9SahjHUQ=;
        b=ty27rvxryVFRGBJA/Yy0yu81oPFF8k7qCodFW2YdzKrJ8/y1Lp5ZvQX670mPn3qQO5
         4ZHjGqP0nqTIyzla1VOssS6JFPj2lGjrykRj0RHD3w2MZuQBvbbDkx5Sv3FnHks6vkfb
         rLUjKE10ArykJ9WEiyxPiprRx7p7YNNxklbbxp3bmwSW1P2Sja1o7sborq1YwVkwg53L
         /iojLnYQEeYtp/o9uFo9j8qtA7W39n0HT/fAEwt33CyDBIZZalcho1y+Z+8N3k6c3xSd
         um72gi+qYcfeaTokXnfe+F8v37JAf2DpFGfwkBYgtgft7CnGkzyuGmAqH7OL0v5j5COC
         EzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770063773; x=1770668573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5DQQ/80oIeISv/l0flaFn2oFu98ezlgiuT9SahjHUQ=;
        b=RcTjdBKgNFfWagJhq3POjKXZJ6tTWTdp1w329QOmMpr3O5m3yKD/yuOkgmNf4vgN+H
         Fq2nIXsi9UWw6XiOQDwoQWjPT+KxIUgc1WoULw/mMkyZDcJmKAVpgV3CWZtGKt4Y4clv
         r2V9TrpFjvHK5czybdWJSuOs5vrqePjIESumsXSH3qmDyu7YLZSbKfQ+WmaMPU1LpWL/
         0ZvR+4tpWb0KLUldWws4DoRRGPudyd/lNyw3RfqTK6oeW9sSAXy/GVlycUuVCLpIInO9
         1EDwTZG3TMVfqprhuklF0cjLOYlQm5ANxISDlDDdt5Jb1RlmNLeL3jA4L1nAcBHsXHIK
         HyZA==
X-Forwarded-Encrypted: i=1; AJvYcCWZohuXFxAWjv1xtevdZW3m/Ya3fPHeVlLKng0NYadZ7IN4V0pk5tIkpwzY4a+nGdhsrDN6nnQncHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynjHyFPhC+FWurAgciSLbhsOzzWFpnXA/Ki8t2vKTpbJqsamTx
	inoZXnMGFpx6dqaMDtYhWIWCAy3lErSfZU0Xk/i8WjkSkXLRawmYoFd8X3FUAs18Utk=
X-Gm-Gg: AZuq6aJBprMOIt1BxYYPIEmzVK9RL8vgxDbVesa4FXTq0iMsjg6Vu6/q59GZAjT4aJw
	hMZCf8lsBG5kqf2F68rOrDg7OzbovVtENXKbUGvvik5LCt5DL32IGutY4UIyJkqVCQ1WcRRUm4K
	v0TSIuA2Yc9rogUzlWR2RihOJ8DTSQja5UGQqZmhnpSidLk1Olm+pnLFMdSKhNxDhkazBGsr+nP
	Ioad5owW2Bl/zabtew189n8MiFzY7ZE8M2RCp5y42pe+o8A5/Qhqg7rPqyuokTK85uBGwr4wMzr
	vSYbc+t4tcH+N2SnrK4Z5j1mp2c33mZ26hLUHsxyszx5dP7uAnxUVsnu+DYSLjFvZRNnsYKHeWD
	OXzEpRyuKe63SzTCB39Clof8l9r38mYX3UfUTcQbCIWMaImPqWotDAbTu9pd7sBkW1rMgIZaCeo
	sv0tIo+r7VAZvGIj5GwEkBQyGjS4rmz4aRsnWlXdR1k5Km0jEZ75E0Z3zk/ABCq9H8qRJwkw==
X-Received: by 2002:ac8:7d86:0:b0:4ee:c1a:f11f with SMTP id d75a77b69052e-505d22fa7ccmr153965971cf.84.1770063772904;
        Mon, 02 Feb 2026 12:22:52 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337ba3981sm112708281cf.16.2026.02.02.12.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:22:52 -0800 (PST)
Date: Mon, 2 Feb 2026 15:22:50 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v9 00/19] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <aYEHmjmv-Z_WyrqV@gourry-fedora-PF4VCD3F>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>

On Sun, Apr 13, 2025 at 05:52:08PM -0500, Ira Weiny wrote:
> A git tree of this series can be found here:
> 
> 	https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-04-13
> 
> This is now based on 6.15-rc2.
> 

Extreme necro-bump for this set, but i wonder what folks opinion is on
DCD support if we expose a new region control pattern ala:

https://lore.kernel.org/linux-cxl/20260129210442.3951412-1-gourry@gourry.net/

The major difference would be elimination of sparse-DAX, which i know
has been a concern, in favor of a per-region-driver policy on how to
manage hot-add/remove events.

Things I've discussed with folks in different private contexts

sysram usecase:
----
  echo regionN > decoder0.0/create_dc_region
  /* configure decoders */
  echo regionN > cxl/drivers/sysram/bind

tagged extents arrive and leave as a group, no sparseness
    extents cannot share a tag unless they arrive together
    e.g. set(A) & set(B) must have different tags
    add and expose daxN.M/uuid as the tag for collective management

Can decide whether linux wants to support untagged extents
    cxl_sysram could choose to track and hotplug untagged extents
    directly without going through DAX. Partial release would be
    possible on a per-extent granularity in this case.
----


virtio usecase:  (making some stuff up here)
----
  echo regionN > decoder0.0/create_dc_region
  /* configure decoders */
  echo regionN > cxl/drivers/virtio/bind

tags are required and may imply specific VM routing
    may or may not use DAX under the hood

extents may be tracked individually and add/removed individually
    if using DAX, this implies 1 device per extent.
    This probably requires a minimum extent size to be reasonable.

Does not expose the memory as SysRAM, instead builds new interface
    to handle memory management message routing to/from the VMM
    (N_MEMORY_PRIVATE?)
----


devdax usecase (FAMFS?)
---- 
  echo regionN > decoder0.0/create_dc_region
  /* configure decoders */
  echo regionN > cxl/drivers/devdax/bind

All sets of extents appear as new DAX devices
Tags are exposed via daxN.M/uuid
Tags are required
   otherwise you can't make sense of what that devdax represents
---

Begs the question:
   Do we require tags as a baseline feature for all modes?
   No tag - no service.
   Heavily implied:  Tags are globally unique (uuid)

But I think this resolves a lot of the disparate disagreements on "what
to do with tags" and how to manage sparseness - just split the policy
into each individual use-case's respective driver.

If a sufficiently unique use-case comes along that doesn't fit the
existing categories - a new region-driver may be warranted.

~Gregory
