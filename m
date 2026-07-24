Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D925CC57
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784898402; cv=none; b=AP1I4CEPxn7ufJb7iRs1lPjAq+mAwJ8YewlzGcITaREtiCUfEqKWNJIfaCWxPsVj5AACRnuLkLAndlNj26qYCIu1jBCWZAnhdBVdUIQnfi+46E9nhUjm5eiEnCA/n+Uz4BD//wAUTEew1TR0HyhaASzECzWB4ZZu1qMG0/H8k1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784898402; c=relaxed/simple;
	bh=BO1Qo1nw+0PvCR2G2yHuB96lktg3Fj/o/8I/fLPhaLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A820+S7Exik4Afsq2zZn/9D6tbVV3VDXk61WbePkzi52tfa6136b+qpBB/dG0Va6n5+07QRlIxn8x7vKFWLR6njXcSvo8IuqTFYTdPr1ByEmrqtySQUL5Tjnv1jZgdjA8Bp8Br+R7cWbIqfqMA1bMj1dbLTbqsOIoMKeND1EMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=owOCOzrs; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="owOCOzrs"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8efcef23d21so3899926d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784898400; x=1785503200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uClgs/33iOo+YM1fFExYaaz7O5yD2KHvC68r49braVw=;
        b=owOCOzrs8uY6A5RtywfAysDKXLFeRjf1meYDZH6XqhX9eUwK/JMdzMWsKzkVsaEIvd
         AfIcTjLmyUYnQe35AqxCdEGauL4CPCNNPdV9nPgERmJef4WbvH0DhYvbXCPInJnPLrYX
         dMp9FFfFTYlW99hUnozn+PZfuhK0t2ESilG/g1r5LLADVc2VIshJhYhi/0Jwt9Z9BIJA
         v0YhggNlAo/xHIwkZMAEbfthbBcY91+gHM+TIw5AyoaFPsk3yDOifG5LkSjD1nHmrYV8
         YiGj2e+HNnMT/kxn9EmuAMpcYhxQIoRMrQAb12D8tI7Zu3sdmcQl79wzqcQ8jst1E/FD
         WXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784898400; x=1785503200;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uClgs/33iOo+YM1fFExYaaz7O5yD2KHvC68r49braVw=;
        b=o/GbnPPCVmZ7zONulfIbIwXqEOECz9NdNFLLnDBZE3fzXGu2DU0MYz1EVEMnd8iMU0
         Uw8t62p5JYsgq1g/euJ/oKMELh05S+qx0DucPftOKW2ceV81/cqZolIaj4htkMOMg0r9
         EJez6XXtMAxsNDRb0i0l1+VU1b06OqzM64UBgYcXQVIbi+vebyd4dtn/bKVtB9bbCN7g
         r+2UnFKxouq18P+vNTe7UnWKb8ce8wKWEGY3vbXEAfaScB1bUtzUGhR1t71BS+Ao0GEu
         9Mf5m9shC8qGmV/Fp91glNy4xXho3EobbfYhn24AOyP4MxUNoZllH8jdXcZGdSsiVPyc
         4Ycw==
X-Gm-Message-State: AOJu0Yzw69wUQMaI5svasp/weSAiEvepMivgwPwXcyjBoeoerucgyBWP
	yeCoHvzvMX7Jve3dZrjs1lA3Q0jJYI7GLJ+LSmC4Gujh5NbY3k+kvKasiRrcGaP7c+A=
X-Gm-Gg: AR+sD122KZZFfG1xhEn8a5lDm5cKdsiaoY/CVEJkS3wRYLIyyY8C5ad2KKslSvarU/r
	TaFKNKBJNgYq+dV4WGoEbBakoFiNkSJTdVwiSeIfGAWXtne9ljWDqedFFnuMPE44uhUgYsD5hA6
	0syILnt/FF30aEq8zZN3iFyT0Es2RG5E+GH9ClcxwpKSJxtni05FaMUA+1KWUkdW80iKkQRXYAI
	x6vHxbi4ReVedMDDN5yxB68kiyqcUoXNLCG2WeRHSHCSgOksYE4TPUw/EDAUgcE44jJtwNTYOsF
	m2fJTqCP1woEDZqvP1Yc9yM9HGJeFhByNs3Tihlf5m47j5awvEUiRtdLjeS120dsSf0sRczBx7P
	UwfokIpNbWzF5YK3Hg+snsQwHa5AMcYZEkTDsanUtdEm7lbplm7KBm333K2C/FR1MjA6IBfvs1g
	jU+opT986+0Stvb5z3R2nPeJgPL2bMj0ew7u2SMKS0EtYJl7dcAqTrcEk+Yrj7IOcos5aH
X-Received: by 2002:a05:6214:ccb:b0:8dd:4979:4b19 with SMTP id 6a1803df08f44-907ca570d4dmr77408266d6.13.1784898399844;
        Fri, 24 Jul 2026 06:06:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8b5f85sm68863316d6.2.2026.07.24.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 06:06:39 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:06:34 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, djbw@kernel.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com
Subject: Re: [RFC PATCH 0/8] dax/kmem: support for private NUMA nodes
Message-ID: <amNegmEeK1dUP1Dz@gourry-fedora-PF4VCD3F>
References: <20260722183519.935213-1-gourry@gourry.net>
 <amMUZ-QnxV0SKevW@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amMUZ-QnxV0SKevW@MWDK4CY14F>

On Fri, Jul 24, 2026 at 03:45:23PM +0800, Richard Cheng wrote:
> On Wed, Jul 22, 2026 at 02:35:11PM +0800, Gregory Price wrote:
> 
> Hi Gregory,
> 
> I have some thoughts especially for ownership and configs.
> 
> I think it would be good to expose dax control of private node, just with
> the following guarantees.
> 
> Let's make it clear that userspace should never become the owner
> of private node, they should be driver-owned and 1-to-1 mapping relationship.
> 

The intent here is 100% 1-to-1 driver:node mappings.

Technically there's nothing unreasonable about single-owner multi-node, but
really we just don't want multiple devices on one node.

> A userspace tool can request to reconfigure some capability of the DAX device, and
> maybe how the driver expose it.
> 
> A dax range may have several deployment rules, e.g. devdax, system-ram or private, with
> the patch series' tool, it looks like a userspace tool can convert a DAX device between
> dax and system-ram mode, I think that's unsafe especially when the region is online as
> system-ram.
> 
> And it will cause coherence issue to be resolved, if no special or strong use cases, I would
> prevent having such ability to convert the rules in runtime, especially for fixed-purpose device.
> 

Right now we can't really prevent a user from doing:

echo dax0.0 > dax/drivers/devdax/unbind
echo dax0.0 > dax/drivers/kmem/bind

And in fact we depend on kmem being the default target for CXL to
auto-probe through to hotplug.  For CXL accelerators, the current
intended auto-probe behavior is to terminate at an offline kmem dax
binding, and then expect the user to either rebind the dax device, or
rebind the entire cxl device:

echo $DEVICE > ../drivers/cxl_pci/unbind
echo $DEVICE > ../pci/my_cxl_device_driver/bind

I have some old patches that augment how drivers select the dax mode,
I can see about reviving that and maybe letting the source driver
also dictate which dax modes are valid according to the source.

I'll look into that.

> For capability bitmap part, I think it's reasonable to expose it, but with 2 concepts
> - supported_caps : immutable, supplied by the provider/vendor
> - enabled-caps : selected policy, subset of supported_caps
> 
> The invariant should always hold
> """
> enabled_caps & ~supported_caps == 0
> """
> 
> This way we can prevent userspace from touching things that they shouldn't.
> 

This I like, and i think you've convinced me that this should be a
separate dax device driver so we're not overloading kmem.

That said, for a dax device that was not created by a driver, but
instead created via something like "memmap=" boot parameter, i'm we
can't really dictate supported caps - but for a driver that *does* want
to limit support, I think we can manage that.

> Maybe a demo with a driver would be nice ?
> 

Sure! I think i'm going to include my anon-memory only compressed ram
service back into v6 w/ the dax driver extensions you've suggested.

~Gregory

