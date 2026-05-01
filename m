Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84637475D
	for <linux-cxl@vger.kernel.org>; Fri,  1 May 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777632968; cv=none; b=f6u3dlaJnwdCwsITM8y1rdzAMxlY9i07IdGGkSEa8rqv0rwxH7UyDHwdOhuvyqhZYONQvvObY95XIuKJOiB/HD/eR+EHDBVgAi3jjAooyD9P5OmOHIYnBHxghReklVgsHe3RIxB6sFrvST6au5BlaDJGQsn9Ks8w02zGiORXxQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777632968; c=relaxed/simple;
	bh=PUoRbVZiWAdqGS8L3N3LiVBt9NwkaILir0UFrEkC99I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrZmdCDPfPPsrXpIswTjXk/VPCpLeCYX/m1nIpjndLiOEYg4WW8QNgi9/ypDtF8rNLaqwA/kTL/spKGpzItXPWhP1ZM/c5b+X3UNOY7YAwuY75xrN6Y3auSpjbgTV4dt/2laVGAbizInlbQFYkEc+FLUXVsLT3PBi+XKXRf0J/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Za7zwCp7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Za7zwCp7"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-448528f4e69so1101146f8f.3
        for <linux-cxl@vger.kernel.org>; Fri, 01 May 2026 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777632965; x=1778237765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I09lK/0D14xOdQDA35HFQAdTFTk0mYwhLtnP0J2AmpM=;
        b=Za7zwCp7YbNf2IEfIazATewLUxki6EdNoH9OATKp6fwhoQlWOuYbZ2Hd4Z5iiJkkIK
         xSIVJ5mHGwRJIf1iBLrnUE8aK04pv87mcpkyjWWvk3u2vJt3WsM5zzz4adrplwVRI8T7
         XOM2dPR2OdlhkLxm7z01C1AxLtECQRKnecJNz5hTl2AfemRlhKcNBPs9OAdD4oVJvZ/l
         buJJf3g1DNR9zc79G45MlCNI/rzmccqRftOyDTXIlwzU+Cb7zMiombS8eL8jC2FxB6wH
         P56wBwEy0W2CR94imYdXmXMGZAyGtP2IoxTsXhxKy1j43cbNMN4tqfE6346tr5XTnktR
         IVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777632965; x=1778237765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I09lK/0D14xOdQDA35HFQAdTFTk0mYwhLtnP0J2AmpM=;
        b=r3tOKwiivNpcIiKiVEnyA6NNdOZBjqF7ic8g2VLGJSuW20qtFCL+WrXh8HUG3Km/3e
         hTZ6OdOHcBu7ax0x05XxolK8RwJMwsxqVAa43LwtXjYnyoMzNPFHPeGigbXWoav00xZT
         wTOkvfTHnlLxLl5mn3FsBFo2dJhMGn6txqm/PJeu8mKlFjRr9pqxLz4e2TcIACy3YrtR
         iCD6M2EwRhxnTW1VQdita+ibwecrm0WqEdtrCd69ZYUeyTnrKahYMHXf0M5jChzxOPpB
         U8He2D33W+E7Ane3lNck8n6SeXDR6WFQ3k3ztHNYq0o7bUw7OYw0zSqSy4tNn/D+SrlI
         6d0w==
X-Forwarded-Encrypted: i=1; AFNElJ+7Zs30gT4kmPa91VVkgDUFXuXNXPWtcyIwkx/ZZ999D4uxvS2gfA/KezO0Sm4NTPc4gtm/Ai2gFt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkfrAlC75HDZFbFaw230YsZ8ywaBiVm9BrX+KGFUs/tefYspX
	KsO1/MMiFDbnQ14LAkpE99Tkf2aq6HMxqiJR1G0Ll0bOpq//RPanKLHcLrzbSWY72hg=
X-Gm-Gg: AeBDieveOXd7jtrc+iYBpdaTPKb6cN7EfvPu9v8bT2SQ/OHGRwfQBNdKV26V6DKrmB8
	771/g5eWYOy6sz72zH9cV9elghnmFVxzYqaunJhXvHOveIvtmg37S6P0CLvzeAMm77pVGzz3mpG
	yG70RVVTxNgqxyqKTzyoAsztH1MCu84pOgPQV4Q5x2IHJq7pDdbnSdPu3zmIgTcTMWpSK3mn/pD
	EQ05Ts4zpqdgnK4U2Xt/V8+CCObrZDiYi2Z8zdI2+2a10ejvjD7i31YKKpJvirO0wkmuceub87B
	3LgMwZ9BK+4iiLYArQsAjwCHN/bpRqg01qp3aH9h7E24Bumww62Qv9Evh4YMBVLGuA4Ung1wIBl
	eIvOd5UhX55A/kLYC4QF3pDfOg6fqvTt+g2xlS6ZDUGe2vRm6y6gRlbjjcwXvPHr+sOP+PR2Ikw
	51ksRK/o4o2m/WVoDJLTpsiPjeFD5C8lM=
X-Received: by 2002:a05:6000:2911:b0:441:3144:efc5 with SMTP id ffacd0b85a97d-4493f03910bmr11155381f8f.42.1777632964613;
        Fri, 01 May 2026 03:56:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::5:f8b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981dee0bsm4229556f8f.19.2026.05.01.03.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 03:56:03 -0700 (PDT)
Date: Fri, 1 May 2026 11:56:01 +0100
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>, John Groves <john@jagalactic.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, John Groves <John@groves.net>,
	Fan Ni <fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Robert Richter <rrichter@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
	"arramesh@micron.com" <arramesh@micron.com>,
	"ajayjoshi@micron.com" <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to
 an xarray
Message-ID: <afSGwTEBHgeqhyvy@gourry-fedora-PF4VCD3F>
References: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
 <20260423235158.3732476-1-john@jagalactic.com>
 <0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
 <69ebe836a8ea_bde13100d@iweiny-mobl.notmuch>
 <20260427133833.61b9cbca@jic23-huawei>
 <69ef7cc2a9b63_101875100a0@iweiny-mobl.notmuch>
 <20260429115638.685c421d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429115638.685c421d@jic23-huawei>

On Wed, Apr 29, 2026 at 11:56:38AM +0100, Jonathan Cameron wrote:
> On Mon, 27 Apr 2026 10:12:02 -0500
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > >   
> > > > Look at the diagrams in this presentation:
> > > > 
> > > > https://lpc.events/event/18/contributions/1826/attachments/1435/3335/LPC2024_CXL_DCD-v2.pdf
> > > > 
> > > > 'DAX dev 1' covers memory from Extent A and Extent B.  What yall will want
> > > > to do is ensure that the region extents which get surfaced are ordered
> > > > based on the sequence number _when_ _the_ _dax_ _device_ is created.  The
> > > > order they come into the host does not really matter.  Although yea the
> > > > spec has a bunch of rules...  so whatever, follow those.  But it is the
> > > > dax device which groups the extents into a contiguous HPA range and maps  
> > > 
> > > On this bit, HPA?  Why would extents be contiguous in HPA?  Contiguous
> > > in the DAX device mapping sure, but not HPA.  
> > 
> > I'm not saying the _extents_ are contiguous in HPA.  I said they get
> > _mapped_ into a contiguous HPA _by_ the DAX device.
> 
> That's not HPA at that point, it's a VA of some type.
> Now maybe it smells like HPA in some DAX interface but if it does
> we should think about any renames etc necessary to avoid it doing
> so!  Or introduce DAXPA (not DPA for obvious reasons ;)
>

Dynamic Capacity Extent
Byte Offset      Length      Description
00h              08h         Starting DPA

This is all we need to know what should happen in the rest of the path.

The device sends a set of DPA-extents that map into a host defined DCD
region (which has an HPA range).  

The extents it sends may be laid out as such:

Extent0: Tag(A) Seq(0) DPA(0x0000.0000)  Length(0x1000.0000)
Extent1: Tag(A) Seq(1) DPA(0xF000.0000)  Length(0x1000.0000)
(start of device, end of device)

The CXL driver creates a DCD Region, which maps a *possible region of
memory* for extents, but this region *may be sparse*.

For example:

DCDRegion -> Base(0x5.0000.0000)  Length(0x1.0000.0000)
Extent0   -> Base(0x5.0000.0000)  Length(0x1000.0000)  (start of region)
Extent1   -> Base(0x5.F000.0000)  Length(0x1000.0000)  (end of region)

This is a completely valid set of extents.

We use DAX to cobble these sparse extents into a "virtually contiguous"
region of memory - essentially base-0 + length.

DAX0.0: Base(0x0) Length(0x2000.0000)
   Region List:
        Base(0x0)         -> Extent0
	Base(0x1000.0000) -> Extent1


   So in a single diagram:


   [       device dc partition      ]
   [extent0] ... unalloc... [extent1]    Device View
       |         Sparse!        |
----------------------------------------
       |         Sparse!        |
   [extent0] ... unalloc... [extent1]
   [         host dc region         ]    CXL Driver View
       |                        |
----------------------------------------
       |                        |
   [            DAX0.0              ]
   [   Extent0     ][    Extent1    ]    DAX View
       |       NOT Sparse      |
----------------------------------------
   fd = open("/dev/dax0.0")
   buf = mmap(fd, ...)                  Software View

   buf[0];           -> DPA 0x0000.0000
   buf[0x10000000];  -> DPA 0xF000.0000

~Gregory
