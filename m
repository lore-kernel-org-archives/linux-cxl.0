Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150208;
	b=X1MNjKAZKAIfVeVAxaQlAPszSw9jD0y/JLV5Z+FqZ4NJiHRHLu7K366fzDv1GIst7j6z
	 hhknwtpWSUsYGKooJuz777acS8LVYq3c4mePV1gdYIvTbl36gSFKfjfZ9sbm/0MUoHwbO
	 nS7iQVG591mlhSEM/kTjgUYEe16oaEbNqbZVmf0fv6VPdgToLy8c+ion+wn788RzA/X01
	 AjoBkAJPqRN0Lxw3UvkheYNC4v1zMlRnjc1qT5Y9D5RFTmE/aJFUYoc3Tk8oOUTmQCuaV
	 kMFJgsINt2FbsX3dl28Xw674yAviI/Hv+greyBYScyP+zR7ODN/8Ls6eYXSy1q+gsNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150208;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kMEo2RSytTCZSIpG+BN2tidH0RHDjiwX/b6dhBWxyI8=;
	b=MHlQebvJKiQkvBR/+vTk4tvDkezHRW0LJpJf73JQ10Ye0P1VCQ1+rqC2sZ6pd8MYMaEf
	 8tgFJyMPBpCv2i5CCO5m+qxJYKrv6sHYR15COqozUaSlRZ3ULcZgk+wGD7EWqBFAn77p1
	 mVMpysjBLtinoLJTfkvD9uXhynaI3d3NqkKihwoOLZo4g7OefTGxc50IT5V3k53QeDo4S
	 PACv7uxO/YpDBnJUn5JtFPzdulDHgfEbrfDz9l5Ub9BoTRVDGo7ojXOZ0vPzdYK/7C43o
	 GzyGgvk+ieaFCoVSn/LyAdw2PjqsmSeJ09hSMMXEXdUhOIwCl4Eo9SB1GAknEEn8/WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtP9m2Yj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD16606A31D;
	Wed, 28 Oct 2026 01:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtP9m2Yj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CF31F01828;
	Wed, 28 Oct 2026 01:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150207;
	bh=kMEo2RSytTCZSIpG+BN2tidH0RHDjiwX/b6dhBWxyI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JtP9m2Yj4WTMc8uRQ+TyhzZj9h2KEI4J91Z1BBewHXMT3TrSWLu0rr0s/N+LDcLRY
	 +BLP3lkek+K7Frmo0ToU0RtSlbDvfDDxzw0Fmh3y9vltwJu5e1CinUj60/OQZW8rRQ
	 LJiLlmPwFrP1esJAkpJbYDphnKvfUxmk55M3qi3ZK+De4uXJVF+sgDRbuqTdW6TdM0
	 eGuXawlePI7EwVwomhs7f70GXdmy69Ei9x0sdhAQy2trqd8TvLmS0UfaeV0Dl+nsjU
	 sqz9Uh9+HVy/3u6Y+dGiefii+uQEH1lCPGj5Rqj/bUb5WeorYlHbtSYz2/4CgP2F5K
	 sxcD5uVNnx+/Q==
Date: Wed, 28 Oct 2026 01:16:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Yili Zhang <zhangyili01@baidu.com>, <alison.schofield@intel.com>,
 <dave.jiang@intel.com>, <dave@stgolabs.net>, <djbw@kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <shijujose2008@gmail.com>, <vishal.l.verma@intel.com>
Subject: Re: [PATCH v3] cxl/edac: Fail ECS threshold read for reserved
 encodings
Message-ID: <20261028011640.6f2b204d@jic23-hlaptop>
In-Reply-To: <099f0eea-1ff6-4e1a-91cf-682fd7609808@amd.com>
References: <20261021152053.85322-1-zhangyili01@baidu.com>
	<099f0eea-1ff6-4e1a-91cf-682fd7609808@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Oct 2026 16:05:27 -0500
"Cheatham, Benjamin" <benjamin.cheatham@amd.com> wrote:

> On 10/21/2026 10:20 AM, Yili Zhang wrote:
> > cxl_get_ecs_threshold() extracts a 3-bit index (0-7) from the
> > device-supplied ECS config word and uses it to index  
> 
> Nit: Should probably spell out ECS here for people (like myself) who don't
> know what it means.
> > ecs_supp_threshold[], which only has 6 elements. A device reporting
> > index 6 or 7 causes an out-of-bounds read of adjacent .rodata, whose
> > value is then returned to userspace via the EDAC 'threshold' sysfs
> > attribute (small info leak and wrong reported threshold).
> > 
> > The threshold count field also has reserved encodings 0-2, which
> > currently read as 0 from the sparse lookup table. That behavior is
> > not intentional; it is just an artifact of the array's implicit
> > zero-fill. The ABI documentation only lists 256, 1024 and 4096 as
> > supported values, and the write side (cxl_set_ecs_threshold())
> > rejects everything else, so a reserved encoding can only come from
> > the device reporting it. Rather than documenting 0 as well, make the
> > read fail for all reserved encodings and only ever report the
> > documented values.
> > 
> > None of these encodings can be written through the sysfs write path,
> > and no device is known to report them, so this is hardening against
> > a device returning values not covered by the spec rather than a fix
> > for known hardware.
> > 
> > Convert the cxl_get_ecs_*() helpers to return an int and write the
> > attribute value through an output parameter (u32 * to match the
> > macro), so that errors propagate through the shared
> > CXL_ECS_GET_ATTR() macro to the sysfs read.
> > 
> > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> > ---  
> 
> I was going to make a suggestion about updating the documentation to mention
> this new behavior, but noticed the other attributes in the ABI docs don't mention
> reads of reserved values resulting in an error. The doc mentions that these attributes
> are implemented by the device's driver (duh), so updating the general docs doesn't make
> much sense.

It would be unusual to document what happens in a hardware bug situation
in an ABI doc.  Tends to be noisy and hopefully never applies.
I don't mind it being added if people really think it adds value.

> 
> So I'm going to take it a step further and ask if we should be failing the write at all?

This is only the read path I think? I guess documenting that
writes can only be of allowed values and otherwise you get an
error return would be fine but to me that would normally be
assumed for a sysfs parameter.  It is nicer for userspace than
alternative of just ignoring such a write.


> It seems like other driver implementations probably don't, so it would be weird if just the
> CXL driver did. I haven't looked for any other callers, so if CXL is the only user then
> the docs should probably be updated so other implementers can follow the same convention.
> If not, then it may be worth looking at the other call sites to update their behavior.

Far as I know, today this is the only ECS control driver.
Maybe someone surfaced another whilst I wasn't paying attention though
or someone has one in the works.

Jonathan



> 
> That may suck to do if multiple subsystems are involved, so if everyone else is fine with CXL being
> different then I guess I am too :)
> 
> Thanks,
> Ben
> 

