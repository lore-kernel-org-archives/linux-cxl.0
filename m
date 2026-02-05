Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652312E8E16
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 04:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770265358; cv=none; b=d5t+r2qzmDu+fPxOXq+aHFNYnuTPwWvjgmMcIOk9+DXiN+d3bAhuTkBSbnvoPAuDooP9+euqsPqYWfWqERKJP8Rnruek7BmW+PjvCgD0zJ2/6K80uJiZ4zz1GIIjBiShoyWnl9bZbu3IhvDJukHPJUI8M7J17iWwZ322zDrudFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770265358; c=relaxed/simple;
	bh=7X6iSq+okoJqC18iKBvSKc+ah+w6FLqVhxtEp1ERUCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0u2CNnWkXLPxOF13F9BbCFrdJEvyKAJbmq5+cWATTrA5UKHbKOKEsLERu7rqspgf9mbugdPmZJUQ3z0OI1CpKyMQIwnl2hMrc8uHIZvmRyCThq/wtxMQwUeuBAADwUCBVaeFEGVZMMQiaN0t0ZIW9ZIKG0ySzGbbibWDtTwpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TVObVj03; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TVObVj03"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-5036d7d14easo6352251cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 20:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770265357; x=1770870157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rz9Ec2apNbNYW2q/PDMmmhy+ztswSTKTIfNaoVdcFSM=;
        b=TVObVj03kNglCmCQQzQLVKtfziRu0F99on7FGMyq33XqkoHlIbjGMA+N11zDqafKBg
         81fTiS0e5Kc2y2M41gkKEFOC4zIauUOSFUk1P3o+6lKo81QREl32F1ctwRwqlCQOvsk/
         +jJeqYJkJL2XnWMWrU0HksJQEgJXFClrpFtzYba0kilCVrhNRpE4uDUVyCJnntEdJtZM
         aLIP9K0BguptIrRKZNd9njTRPdTro6GaiO5lgu1PK4jVwFp9dNwwk5kOJm1oP0Av/gTm
         yfIkBOab+jANeDIWFLUSVjrykLd6Mhobuu2XiavePLpmZRprQvmH4p1M0wlxZmtQYY/u
         j40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770265357; x=1770870157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rz9Ec2apNbNYW2q/PDMmmhy+ztswSTKTIfNaoVdcFSM=;
        b=rhWsg0Dn+7BVG+x1OSJpl9IuKrZQYHcLmqhLKohNl6tFSJF7CC6O+C8xp2mga7jzgQ
         PBqE3QF7rHY+EbA9FIntjVMfcU/t2aurlF2bhghbtscC67t4+M004h1+yc/2u2b/fRbW
         hqhRzGjnA2r1hMcYIlDsh7/dnJtsL+Nbco221Dy3Aww7a2HoXYzv5CmPNgngYgu61+56
         JeMqbrBULpHtNe33JqmdRDg6Vy5xEl59TpfUNOEm3xYA/NGMuX7bse/8HnkSN64aAM4P
         H53VQS0qGjCg3JbbX06Prt2J5TClqPrQYfqJSPKY+D7B/KiH5ZveT9GwNI5YxWSl9qEI
         S+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUufIipRgKUEFMHVXywJrF9i41epDYK9ek5f+7rZed4FU1dkpUqzlWgz3Kyl0oY2FqWcSdmQ8S/A7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp2/XjsqGKLrKng2mOh7CeBBIaKmXoOknG3PHRTgwy3lPwugFZ
	ZaEEEF4nQwd0zM4rGh7wAcaddg+Nq8GkumebsKSLS4UZ/LvFvG+So72fGCnIrTEwO1Y=
X-Gm-Gg: AZuq6aI0tpms/VM/SIaRSaDrc0PUZZhRGE61IWeMRMcq/ARXudC+vAK5B6sd9ZocGcg
	7A3QPlriW09x24Visncj04L/3JvAB768AgSApPEGvWShChDfxE17IzxDpCijGUhUEGcEXSm7rDs
	DCB73INmgOGORvfJe6G3egqgqAraITWuToO1Nsk8dOXcXbhBXivX5DAHyR/dK16yvgnEDBCSpYl
	KzJcyKyj2iEhcvNiZ8advVTzxLfNVQkk/OSKKgvNVswf7/o+ruB7oqmg1vBcDuseYCNnsRSklVJ
	ZT9i6STwfJhAtbob392YyL0XW+hvHSuBb2CztSC6gdHyikw6yoOEJOfPghc9vSz0Gp5pHbHAXCW
	d+urLMI7DJqaSJ3IZuSczlSqSjSUrg/f8g9PR6oQRpQT2ulwKBDLpJFT3qGf4xDVTXRwOtzmF6m
	Tc1ZDLGytL+xyVASUD5ULwXcRk26Oe/0DaDsNtWcdMXrT7x1tsUKmMwUWnsmFK1x+n1fohMQ==
X-Received: by 2002:ac8:7f15:0:b0:502:9be1:7227 with SMTP id d75a77b69052e-5061c0d1c84mr76634971cf.5.1770265357017;
        Wed, 04 Feb 2026 20:22:37 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c1f975bsm29957261cf.26.2026.02.04.20.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 20:22:36 -0800 (PST)
Date: Wed, 4 Feb 2026 23:22:34 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dan.j.williams@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/2] cxl/region: Unregister auto-created region when
 assembly fails
Message-ID: <aYQbCsOiFzyZHI6R@gourry-fedora-PF4VCD3F>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
 <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
 <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>
 <aX4kd-S3PQTTWfol@gourry-fedora-PF4VCD3F>
 <aYPlJ2PRv-FaFKFT@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYPlJ2PRv-FaFKFT@aschofie-mobl2.lan>

On Wed, Feb 04, 2026 at 04:32:39PM -0800, Alison Schofield wrote:
> On Sat, Jan 31, 2026 at 10:49:11AM -0500, Gregory Price wrote:
> > i.e. auto-decoders should be intended for trivial SysRAM regions only
> 
> It has not been my impression that we have that much control over what
> BIOS may present. ie. If it is CXL Spec legal they may build it. I
> recall you wrote a doc of Linux Expectations of BIOS. Did you actually
> try to limit what BIOS does?
> 
> 

I should rephrase - barring any new specification updates that actually
allow the BIOS to say what a region may be used for, the only two
reasonable endpoints are sysram and dax - and realistically only sysram
unless you build kmem out of the dax driver (kmem is the auto
destination).

But for non-trivial setups, recovery might not actually get you
anything.  If a device fails to actually come up after having been
programmed by bios, it may not even be feasible to tear-down and recreate
what the BIOS tried to do because of platform specifics (Zen5).

So while you can time out and clean up, I'm not sure you can actually do
anything after that reliably in the general case - and i'm not sure how
much effort we should put into fighting those fires.

I suppose you could leave the driver in a state that allows a user to
see it's broken.

~Gregory
