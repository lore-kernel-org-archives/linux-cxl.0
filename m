Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A1F2D3A86
	for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797331; cv=none; b=X4Af8G3LL6JFBYkzkYJkkSdDKEca3I0z60UbAuQijZIAWVuXwLyQqJleHFQZSO22XfbyTf17UGr2EajiC89ftyJUFD2CLMlNT1JBHSi4VkUl4f4nGw72mNJFFpEjASxrfFXvK0DVZOsEiQjJsV2V86aX5ggzcNZkU61unXE9fJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797331; c=relaxed/simple;
	bh=oUJ/+PWhdAF5Z/G8RnyZP+LiPHV5+Zznu8bcZrSqEcc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klXTfIcNcL7+rOtdZqkbJZuUZyxpL2KLZ5RtcQuSBYHHrVIpvDYzNlhuT6MIC9p1bkmss2eTPmIB0GOY+fydgjKzZb76OnQAvWIiZBAeYrYeVAzTIqA6lGAow55I7gpKm12OZqU9yERNCD7ZsbGN6NAGQZWFqLmEEQQx/RyxdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmywVx1v; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmywVx1v"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64eaf8aa893so3753467d50.3
        for <linux-cxl@vger.kernel.org>; Tue, 21 Apr 2026 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776797329; x=1777402129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QCcNFWjR57cmopBXRWMqG/IfJiwvLd+KFhHKkTrR/Y=;
        b=QmywVx1vJwdq9rNJRozG8k3kbSPIBdD4cXFjwy2t2NhdYpMIt9QR6vW0r02L1WVKOv
         +f/1e4fGIWikj8Jy/sDVkX3a0R3YCS1vkKqq3SMHkWclNKPiKm3aBHYh+9dP0jTdxrRU
         jM9ZxchseSdluGA1pdsLiaRgvtCTyNXG2kbjWOA2mq6JAXw8kLXz0fsXYVT6nJycabiv
         OR2WU7fUrQ2yE9iDadzGTCzMHF/cfcVlYVa/gG8VZAnIsJl4IxP/rJgSkMrzdW/1A4zh
         QLUGPsaiLOC/IKDRRAyoKexuO56yM+QegqAV5CZevMZhoKL+QyITex3ZcxKjGGgSqGaF
         Ui6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776797329; x=1777402129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QCcNFWjR57cmopBXRWMqG/IfJiwvLd+KFhHKkTrR/Y=;
        b=UghS17hhnAPlWSXEmNH3+9X+Y29z11eZNpOXyTVWUjdMgl2U0bsaGjN46OSUkgs9iw
         pLAgLdomVkkwqGq03RhhhbrcPei4/jidOzRaqeNaSgBWmFWD1UjcA+7h90IbfokD37zr
         w2xEnse2Ub/3prcf1lertS+VoUHO35uGB/hTJ6AxOUQpVEioilGnggSnxwtXhoomHNbk
         drchf7imjGRY6lcaYO/3DAuB/TmWiJUgT9/5p2qhlDnbENMCZ1rI5M5TWULCR3CMbm+S
         RxIZThPCGL6b2GE4GeCGQogX87ygmzm+DXnhVP+swUmDxzOIrmCBEEX8vm5Fkwge8x13
         zRrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AKZqAMkJunJgVIeYwmGf7FPN5c3JlElVOtcwi8+4bSkMiByYx4T7nX/FwUYHe32hCbowJ9B3BL7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVonOpE+CYS/Q6IySkLyN7xHTItbCc5djxvbsJhkwnEDME5c8
	rwcvJdLv03nOOEQNNekyJlfOSv1GfEOzleVAcSol8y3FQcGJ5N3W6/zp
X-Gm-Gg: AeBDievRzdujDid7fOHApGTlqEUNLBkBBqleTLjpUviqDwqXLAIY13sKosAmh8RdVC4
	PkwDohEbgSh2rNBKcMdE3XKSvaFpr2QQP1XI3aTt8S3VQBI6AiUWgBDWTOFHujHFh1/f7bCN4rS
	k3G9j4y7qkgqR/IiSAmW43q2LcE/NVP/EXwTzJITo0aO6p/sABtupOsKLmQiTmZvN+cfS+2w999
	VNHxTUfI3BFvUHGTU/3xzbZOkE0c1Ij+wKRik0RNyTVhQIHi2h7W8tAO5WDcoj25Ln3Y1Lse6pQ
	k8nL7XObAF8TgLSWw22sqUZua1zfsPW6YDAy1ws8tP0taviIV55npEk2dol/vcIe/K3zEdVqNs6
	JvBqjhiygzWnT4xlLLxdOEAaKwKkSNyHc9nPkLqOnwPfswoMirJgjdPoFki0bqhS10IliLc7QFO
	ofXvo75F3AR+tlrqiCr2rzNYJEr2DUlc8scFEUQWKyknQHyP7mAsEX
X-Received: by 2002:a05:690e:144d:b0:654:2820:f657 with SMTP id 956f58d0204a3-6542820fb41mr9379041d50.47.1776797329434;
        Tue, 21 Apr 2026 11:48:49 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314edf839sm7067692d50.19.2026.04.21.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:48:49 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 21 Apr 2026 11:48:46 -0700
To: Gregory Price <gourry@gourry.net>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	john@groves.net, dave.jiang@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC PATCH 00/20] DCD: Remove support for sparse regions & add
 tags
Message-ID: <aefGjpCm8QhwWbHn@4470NRD-ASU.ssi.samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
 <adnWg-60uKmduTsh@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adnWg-60uKmduTsh@gourry-fedora-PF4VCD3F>

On Sat, Apr 11, 2026 at 01:05:07AM -0400, Gregory Price wrote:
> On Fri, Apr 10, 2026 at 06:22:55PM -0700, Anisa Su wrote:
> > This RFC modifies Ira's DCD patchset to enforce tags and remove sparse DAX region
> > support, which are the requirements that I've understood from the community
> > meetings, with the end goal of FAMFS as the end user for DCD. Feedback would be
> > greatly appreciated to let me know if this is on the right track? Or totally off
> > the mark...
> > 
> > Everything is the same as before except:
> > - extents must have tags (uuids)
> > - 1 tag per region
> > - regions must be contiguous (no more sparse regions)
> > 
> > To achieve this, the main thing is to change the relationship between
> > cxl_dax_region : region_extent from 1 : many to 1 : 1. Each region_extent is
> > comprised of 1+ contiguous device extents with the same tag. Contiguity
> > is enforced by sorting device extents by DPA order.
> 
> Are you saying they need to be contiguous in DPA?  I don't think that's
> what we want - in fact that's actually somewhat defeats the entire point
> of DCD being allocator-like.
> 
> We don't much care what DPA space the extents take up so long as the
> total size of the set of extents matches the size of the HPA region.
> 
> Sorting by DPA at least gets you extent-ordering for free as a
> pre-agreed upon mechanism, so that's fine.
> 
> Basically: we don't want sparse regions where the HPA space has holes
> (i.e. an extent hasn't been sent by the device to back the hole yet),
> but we don't really care what DPA actually backs those HPA regions.
> 
> Unless my take on how DCD "should" work is wildly different from the
> general understand.
> 
> ~Gregory

Super belated follow up to document some discussion from last Monday's DAX call:

Instead of enforcing contiguous DPA, what we mean by not supporting sparse
regions means that each DAX *device* needs to be fully backed by extents?

- The CXL region/DAX region itself can be made of multiple DAX devices, and
  there can be HPA gaps between the devices, so the CXL region can be "sparse"
- But each DAX device must be fully backed (non-sparse)

We potentially want to do something like "daxctl prepare-device daxX.Y" to set
up an "empty" DAX device? Then as extents come in, make sure they cover the full
range of the device?
    - Add some kind of timeout to receive extents that back the device
    - If not fully backed within timeout, release all and destroy device

That's kind of my understanding after letting it marinate in my brain... pls
correct if that's wrong

One quick question I currently have is: in this scenario, we expect the orchestrator to
coordinate the "daxctl prepare-device daxX.Y"? Is that correct?

Thanks,
Anisa
