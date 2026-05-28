Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C243405874
	for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992107; cv=none; b=ZVFoRA8MRgMh9m/yPHImH/Z/Zk2VRo3/lSRhAIRpNTzecMw0KtT1h88TGbIJuG1blszxQolNfR5HaFOTMz7z6RtVteAigURmxfa01l6akTc31g9HH1BS6KJQvQ7rGO0oz/IgKMHl8YsPh3Ym2uGgKco9HIYNgTCNpA2S3u1EZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992107; c=relaxed/simple;
	bh=oVw3Nd5J5iK2SatiaW52qk8wnvZOzD4L0X/96I7vm/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0zGjByxqeJ8CVOYpmYOIyLFGIz4eR+3idVzwPw+MI8nvulgUf62XqPoeJQEjSnM+C9/ePQ4hOG3mpPEOOiho3VeeLlH2RFBIPpq3BbIfBORfcySzdA//K6syX9ImVnMLge6o+9z6js3CoGDgxX5orKoPY8Wzad27eJOGKdDIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAc1JUfA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAc1JUfA"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b46da8c48eso925ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 28 May 2026 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779992105; x=1780596905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J/+HWoid0BEbW+tXsuIRks6EMfRCMcY0XqrXIbQ7CY=;
        b=FAc1JUfA0WkW40L3EwIaVOoXQ2HS53ve+XKSatxSDpx8O5dI5X/QYiVXTRjZv6+Oef
         eYshNseJBtGeF7OUl6JubrpTWCWpTQ1rYpLE5LISYRZEDQh1ootPkxKZbd33EFSYkDCI
         MMSoLjlHmjWn2uNbIO/CkGhgzMqyW3VAQLTzwzypNdCm0KtiYERVS510bWDYAluJyHMa
         Jgq/8gKOHGSAMk+PHVYy24P1bntfRTxv/2LcG/ym4Cn6bnis28Ppi9+Usm09TFx3nazW
         WvSkRb4fS0CWmUYrJCGl7tyGK6tkOeRituDZyocQwGa7Pq12YYT3+W9qjqJb3a4YVFSx
         g/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992105; x=1780596905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J/+HWoid0BEbW+tXsuIRks6EMfRCMcY0XqrXIbQ7CY=;
        b=Q3YhwSbyvPSi9tDkYIFhKZhMqY7FKoHwxJOrLP5dI7nhMKH+/1Tf2nDzuCLVpPJQrR
         kXGlbjDX+A7d280ATem5g/SHbo5lcv5QqgI8gnlrZiQP8V6AkWZN7mK3CXBiAhAKahnU
         BKUxJkns0MzUJR0TjM1i9SyrgFMakHcHJe1I8EWrQ6LmL2pNwLpNQLECz5d5WsfpNgiS
         DeaWzXZ+miOXO6jp5iYNZ90pZp2oPMckIvKjX/b7hd1MIMacjo7GhGdRTu6PezKhz9pK
         metUgRjrIhK5lQUccv6Lvwk1n88GAkhNvEWvnaf/j0hhTP+ptFNYs3tgw+Pz3GeAm88O
         jF4g==
X-Forwarded-Encrypted: i=1; AFNElJ9jzu+BhXHGcuA+i074vhLWTL5wf37PCZm7lUldP/T+LHMqM5X1/FDJZlUaTKmwrjWMvAewx7y+t7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6TWMIId/gaP43WtEdDKwAtSFzQC76+A5GQ3vTJUb7TQkMnb1y
	gXAXFUoGOYV/qIwned3Tl6uRqwruX7XxREz9gz+JCRwPAIWH6WOEyXpNn22z+I5rSw==
X-Gm-Gg: Acq92OHPG89is2ft3VQoPwsp09tFYdvot9l0BECEKIyCaa4XujU7hZT4gy3q2xHVd0L
	MvGbN+2OF+qd2mm0/fWJFF6JUnPw710ww0BJx0ldGUDVqg/1a65tp4YyAW/jSZdprwH9HZThNEO
	T1sFPGmE2lCU0/UU06hu9WfvGsV2i9hb5KgeCx2OtXiRDsUyOVk3Cu1RMVVqkXnzl06MEh91mVT
	ggTDVv9IRo0dlWSJfPSGx6q/OTh1AhbRQqhqDcVV8M7fgRPQ3XF5JrxUlEkbZrA3omB06a1/8yg
	NkEDleTQbbdwEvqV6Qhjw90lmADethucB7WL/D6jBkCvq586iVO9Jp5qTMfZM9S4yPaMPJHVIYJ
	Y/suGN9xAHji8rVNo9oR7Ym29nkaIjYw/gQ20vxMZbEfYiZ54x0C8HvAVAcobGOCp6qNCdeHGTL
	UKEjfaDPMObTEg9nVjzFmsDs4ya02zQ0w5XoaJpNrVlHry0I4CA+i0Yh5FF66YV4cFW1Y9
X-Received: by 2002:a17:902:da8d:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2bf1e2f6227mr112265ad.2.1779992104891;
        Thu, 28 May 2026 11:15:04 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908f8f80sm2156136a91.5.2026.05.28.11.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:15:04 -0700 (PDT)
Date: Thu, 28 May 2026 18:14:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ahiGIUDG2uvA6usM@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
 <ahhuFw3ZJpy48xkH@google.com>
 <20260528180018.GB3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528180018.GB3195266@nvidia.com>

On Thu, May 28, 2026 at 03:00:18PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 04:32:23PM +0000, Pranjal Shrivastava wrote:
> > On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > > +	master->ats_always_on = true;
> > > > > +
> > > > > +	return arm_smmu_alloc_cd_tables(master);
> > > > 
> > > > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > > > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > > > requires Config=Translate with S1DSS in bypass?
> > > 
> > > Yeah, basically.
> > > 
> > > Effectively the ARM rules for enabling ATS and Bypass together require
> > > a valid CD table pointer.
> > 
> > Ack. But do we expect transactions before attach_dev? What'd happen if
> > we don't allocate CDs here?
> 
> It can be done at any point before a non-abort STE is formed.
> 
> The core code pretty much does this immediately after probe so there
> isn't much point in moving it later.
> 

Right.. that's what I'm not understanding clearly, if the STE is Abort
anyway during probe, why are we breaking the alloc-at-attach convention? 
Usually, we allocate CD tables in the first attach_dev call. Why does
that not work here?

[Disclaimer: Not a pushback, just trying to understand the requirement]

Praan
