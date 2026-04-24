Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3D17B50F
	for <linux-cxl@vger.kernel.org>; Fri, 24 Apr 2026 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777002216; cv=none; b=sMiakjKUOsHj4Q3gVbxJyJIy8FlNezkO1l1WqkkHN0N84JlGQf0P21fEff0urEHvAkZp56FLekCwRFMjmSOxI2MiZKG4RFNnmNa0Cz52F277Ewc+xdAxd5DzMWsKkoIM0lW77rAtpZTrpxRWBc3M44a8/QFpYM6Pt5CgcaEgLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777002216; c=relaxed/simple;
	bh=qnZobKXXKxR1wvldR94gOPnl1Z8QgD0VXdOMyBWMks8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddknNGuZ/54iF76JhZx9cLd3ER04ZMDYV3dOlOyQkPzdCEC0daKtWLBqqywkONkuPEf1BCU/lgM63q0RtxR3/G2fPEySeji1XdLRVWB9UnmnLOTX+0I+IspmmiLIGFsJM7dAtH+UOX12ZgXuQgk0liyH+JZgrs33Rfejr6zpfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=JTFEMx1m; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="JTFEMx1m"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ee63e91acfso293578185a.2
        for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777002214; x=1777607014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkBeqEq2+AtENzGlt9HMZzE8R+M0m7SyEcN2haGEWFI=;
        b=JTFEMx1mWk1QwVJt83/Xfn/cLZf4EiUQ/1XIdrwy/2gHQIySDuD+frjXWcvy8U4ihB
         jAf03dVL/3PgKomvNbiOGw8CfHKA9J0lEAYKaLtkzTwUul884sSBZ0RSjKThAWElQrDS
         aL/Gvs1KG4H2fWBnCB9ZoQxx7/7wQvIL1qskiOVSS5abOq25GMmkv242v3jmneNbVc6C
         BgzkuElBHDS4IdgFS5pibVRUOZ+ldF7LlLeOsiNhTOAG/C6n/XOLInscinxhV/07qNLd
         ajregv+jiclelVj38C6putyT8/Je7SUNopV9r/jVdC05T+doHk9xS9b98fSaWLX1TEp6
         fpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777002214; x=1777607014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CkBeqEq2+AtENzGlt9HMZzE8R+M0m7SyEcN2haGEWFI=;
        b=tPp/7iljgDqvvrRFy5/lUTCQvPIEgbDTCbInhMOifMS1eM/Xyx2lv10Vd6v7EsD16x
         +yn4kJQvv+p0il2X00RnlTz1Rho3ZhuQ13gKlLqZrTTEwDCmcojc7Wm7RZnnGgpkrIPB
         eG4JyM6epsFpw8nq/AQjW76iA55ZEOIQZMMlr7cTC2LdlSg50IV2+fceWbbd3eDAJuVh
         7VxCuFGXDLZh6oROSZvDuw5CdVzW+cCFY7VPKX0aq8CBE/CkJER12fiEnDx5WvjNBY14
         sK1TCZtnUGh40w/AG05uAegqLuCaKFNZOjRGyf40E8A+yOHkPbvqZGsH0mzLyMsXHx1c
         khIA==
X-Gm-Message-State: AOJu0Yzy/dwOHINwQkNzclBIh7+FI9DPb3khW1c8zaLxxE1DGzYpUkTR
	cepmS+ANbuxkZmTjPTD8rrNE7+nv8k2bFRW1CsMq4wudy/hTNm0wj7Aer08V0HwnthQ=
X-Gm-Gg: AeBDietCPAaSaYXHCMaxc3vY78lu8UbO9ZF2BWYWwPurqaQuKKApJ9eBkemhzXv2s9u
	MItld1Q3LEDuz6sSwuXfhjt/TezEPzlotTtParX/mB+nOaFnN3zGaI8QSbZJ7KcfWJz9RnDwIB2
	gN72IpVjrQlHoUZQcJuEz6EDdSid5xkV6G//GbXjU6bOYATZS3u4EIN5/gF/7zl9DlTbv0PRbOY
	qHDemU1qcctRj23y8m8iwBN7LJnf7qRxb612mqxlQp9G45ZueWDQ3rm8uIg6S7BBah7OYYfrLBT
	ZS1MTsmiBi8fXaTTaTQChY9OzTKqagB9iYfxc3m4yZPeXaC1PuY3IvwTiP4GgKukSwz7aa6tpnY
	rj34iTpGZhgqBpPWlc3mUYZb1Bzxj01pOLouqFrrB3jA0Kb41gflHN9lFmB7NfmXAJro7WicPvv
	enNuzRdf78pzCEYJhtiv1mnnJoLF0bfpV7gcuIcFIsuK8rdQJ+8dy07+273iLkFqIVzv9SVr7aN
	6j1BzHS6ri5vFt4xg==
X-Received: by 2002:a05:620a:9042:b0:8ec:c4a7:f8fc with SMTP id af79cd13be357-8ecc4a80004mr1763332385a.43.1777002213846;
        Thu, 23 Apr 2026 20:43:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-70-94.washdc.fios.verizon.net. [173.79.70.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ebce6ef86dsm1128038085a.30.2026.04.23.20.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 20:43:33 -0700 (PDT)
Date: Thu, 23 Apr 2026 23:43:31 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, djbw@kernel.org,
	iweiny@kernel.org, pasha.tatashin@soleen.com, mclapinski@google.com,
	rppt@kernel.org, joao.m.martins@oracle.com, jic23@kernel.org,
	john@groves.net, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/12] dax: Add DAX to guest memfd support for KVM
Message-ID: <aerm4yDVYpOhxXEF@gourry-fedora-PF4VCD3F>
References: <20260423170219.281618-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423170219.281618-1-dave.jiang@intel.com>

On Thu, Apr 23, 2026 at 10:02:07AM -0700, Dave Jiang wrote:
> This RFC series is created as a proof of concept to connect device DAX to guest
> memory by riding on top of guest memfd in order to prove out that device DAX
> can be used as guest memory. The series seeks to jump start a discussion on
> if there are interests in creating a DAX bridge to utilize CXL memory for guest
> memory until the N_PRIVATE implementation by Gregory [1] is available upstream
> and DAX users are ready to move to the new scheme. Once there's an established
> consensus of interest, we can move the discussion to the best way to implement
> the DAX bridge and the future of device DAX as guest.
>
> I did the bare minimal to get the PoC to pass a modified version of KVM gmem
> selftest (guest_memfd_test) in order to prove out that DAX can go in the gmem
> path. A DAX char dev is created and the fd is passed in user space with
> vm_set_user_memory_region2(). The DAX region is passed in as a whole when used
> unlike memfd where any size can be passed in to be allocated.
> 
> The folks on the cc line are people that Dan Williams has mentioned that may be
> of interest to this.

I see these as *mildly* orthogonal, but I think maybe you should propose
a discussion at LSF to talk about this.

guest_memfd in particular wants the host to never map the memory - and
guests *generally* want 1GB huge page support (TLB go brrrrr).

There's a real argument for just handing a physical memory region over
to guest_memfd and making it manage the region manually, rather than
doing a bunch of nonsense just so you can call alloc_pages_node()

So I see an extension like this as genuinely useful regardless of
whether private nodes actually end up merged.  It's a matter of
flexibility and use cases.

With this plumbing, you get less flexible use of the memory (you're tied
to dax abstractions), whereas with private nodes you can build slightly
more flexible general-system support.

IN THEORY you could add something like an NP_OP_NOMAP to private nodes
to make the buddy manage pages that don't have a direct map - BUT - in
practice that's likely to be more of a bodge rather than a good design.

So I will say - to the detriment of private nodes ;] - I like this idea.

The question is ultimately how much flexibility you need to shuffle this
capacity from one guest to another.

~Gregory
