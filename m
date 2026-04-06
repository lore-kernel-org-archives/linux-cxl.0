Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A32331211
	for <linux-cxl@vger.kernel.org>; Mon,  6 Apr 2026 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775513126; cv=none; b=KapqVlk54uU+M1DSAALOkcCcyvxrXbs+38sSSVaZqVdN/O6Rmzjpdx0K6b/HGMx10GW8VoBLi2ca3BLHZxFLmJ5nkrdJE5i5uQPKzI/kCD5oGqb363I6gw+5TGSsonrOuvCL3mVZgqZMWip/phbj5PFlQE6Mymutt5Ss0JfMC3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775513126; c=relaxed/simple;
	bh=oK9QofoXFukYbZ1c/cswd1bebDb7z9qu2bCtB6Eab70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMVgFJOXay7NE8mjIWClkZV5jTAOB1eBJ/WdSVzx+ymGvgta7bXEbflAjQNDJdYwo76fha2o15u3K8M68qF/SMG6dj67gJBxILR2mMUnJCxgCh2BfgeKT9j2JoZwRUhLDaAihs9ldfY34HCFD+finYbLyD1C7U3a0sA13K0mLSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RVmy1JPg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RVmy1JPg"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd71fb9f06so282964285a.2
        for <linux-cxl@vger.kernel.org>; Mon, 06 Apr 2026 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775513123; x=1776117923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGZao/IIzct9FspuaHKhJftGREYwsc0pd1AtS7x/cpc=;
        b=RVmy1JPga9OP1fAYlBdCYxO5p1+NGTZBvNC1KuBLpT466N7Isgs+iKH5WT+SI/ROzv
         yoHVWTtoIRc5V8m6KHP9CHMbAWIv8a8mW5oiPlKd84adiK6/r+zv22SOEoHy3lafQN9e
         Ppx6aw2Tizpatlz00J0wp50QbbpAMXE5wJ1/6wlJPNKKRO7AnnxaBi+Ai7IGup59P7zI
         nHVBfP2wgxCfxbg/eANCqyPufMfBzyPEbilOwLOHXKCxDD195xeJB//VTM/Is34+sddx
         /uRwDjVsWwAAm4oB4gT5XJ5Tl8T8mTwvtRrPo0NbGANms9By8Bxw2O9Si3DM6tHyHOWy
         lowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775513123; x=1776117923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGZao/IIzct9FspuaHKhJftGREYwsc0pd1AtS7x/cpc=;
        b=M6r7k9sHnak4pCO6Y/5cyNH71L90A2VWmtWNXNda+8wNQeE+z8LapxF4jjQR/NGI2n
         yWcRrjtMvBt/v4qkzHPZXaSn0fvzXFvanNOiSJj4OrFc9KUGs8CaGs6VJbBDpJg2gXY7
         C4tR9hdrhAWLorHsTdCJlajXQJ23nE5TpbXxxF53wUl4hE9ci/gvPJb9CdhJqw1GsxSE
         QUvkgkEFSpdDlX71cZXgUMjLmr1LI7/Q0HflkBryIwyOd63xVHfs43VQi5BKT/c5Au0t
         dNiKhDVcfz9N/pkwiT2rWP128nI3dxj3pZ+KBZZF86wNFFFwNY+e1pjWYigq0JDAAtYI
         ILBw==
X-Forwarded-Encrypted: i=1; AJvYcCV64K7lDZBg1LuGZM4NvdlZkzKE8Cw+P/Fq6jjJEXWo6eGSawn0d2V/GohKCYuJl6Jd6lcnkTZ3wzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUjU2wpqIlyfdaxAHceV7WlxfmPXGE7YJVI5pAibdSp9KW+gK
	Xu0uEDFSJy122c1/m/C4xJcElGnJOXROGAF3lnqcGLaFxDXxNGb9KBh0DVQE+iXDmz8=
X-Gm-Gg: AeBDievfxivAAIM5orhglwZqS94X9ezxyKCrJtuMTCweR0fDBmy4lyoHokIABgnIy9e
	POMJCIV65sW2+pjmY7y6vDuggPkhkh8/2XeF9YOfWf0TYsGTFULNx15NM7zKOnu2BNVpftSUrsq
	2T3bprMyZ4ZnnkqmUdeGBdhctDD8QjMiGpP1QemfdZhN3QACoHrqKxcfPjPy2uus5aaIPE3gHKm
	2HuQW72qrV2BY4sBjuDPV2S7fNdpLVOb0lIT+G16FAlkAre4qFm0x3jo/En7W56cx0P4CCoZcMu
	JA8QrUt50A3CYFjaZ82kHicq4y7B0y81GiFzCyy6zuaQenHcLJcL+ag6z2RdQD33k7YrBcxNiYy
	zav06XPOOVLyvT1yPN4h/3Y+KArfbAh9Pgw9ycZmXVzgwemopVnVoESnnPAWyYYXUCmGBtoQ7kk
	fMHb15YIENTUtiucKOzcGVf+qesxWlabLEzHjuEhfYOZCMNZ/U1QY2OJ1dxXBm7w5JrQc+0pvTs
	AaUHmCp
X-Received: by 2002:a05:620a:294d:b0:8cf:bfcf:eb8f with SMTP id af79cd13be357-8d41bcd15d3mr1922226485a.65.1775513123076;
        Mon, 06 Apr 2026 15:05:23 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5c5cb5csm1165614585a.15.2026.04.06.15.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:05:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9s4P-0000000E4mE-3CKd;
	Mon, 06 Apr 2026 19:05:21 -0300
Date: Mon, 6 Apr 2026 19:05:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gregory Price <gourry@gourry.net>
Cc: Dan Williams <djbw@kernel.org>, mhonap@nvidia.com,
	alwilliamson@nvidia.com, jonathan.cameron@huawei.com,
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
Message-ID: <20260406220521.GG2551565@ziepe.ca>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
 <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
 <20260404185330.GD2551565@ziepe.ca>
 <69d1685538f45_556821002f@djbw-dev.notmuch>
 <adQj_gxSzjA51Q6n@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adQj_gxSzjA51Q6n@gourry-fedora-PF4VCD3F>

On Mon, Apr 06, 2026 at 05:22:06PM -0400, Gregory Price wrote:
> On Sat, Apr 04, 2026 at 12:36:53PM -0700, Dan Williams wrote:
> > Jason Gunthorpe wrote:
> > > 
> > > The entire thing needs to be mmapable in a cache coherent way since
> > > that is what the HW semantic is. If you try to do something else you
> > > will break KVM support since it follows the VMA.
> > 
> > Then I assume it matters that memremap() sometimes silently falls back
> > to the direct map. The "VFIO owns" expectation needs to guard against
> > some helpful platform firmware mapping accelerator memory as System RAM.
> > 
> > At a minimum having VFIO fail to map in that case helps with the
> > argument I have been making that "no, EFI_CONVENTIONAL_MEMORY type +
> > EFI_SPECIFIC_PURPOSE flag" is not suitable for accelerators with private
> > CXL memory. Those want to be enforcing "EFI_RESERVED".
> 
> Agree - in fact I would argue any potential user of private nodes should
> have some kind of splat saying the memory should be marked reserved in
> the first place, otherwise it's a firmware bug.

I would expect this to happen via the request_resource mechanism, if
MM is using the CXL range it should be locked in the resource tree and
vfio should request it and then fail during the initial startup
phases.

> I need to read up a little bit on this area, but i don't see the "needs
> to be mmap'able in a cache coherent way" to be an argument for one
> particular method or another (hotplug, private node, memremap, etc).

It is speaking to what VFIO has to do. It is the exclusive owner of
the physical range, it does not have struct pages, it must be cachable
for VFIO and KVM to work - not alot of choices here. Turn the
phys_addr_t's into large cachable special PTEs inside a VMA.

Jason
