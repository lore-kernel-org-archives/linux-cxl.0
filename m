Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4B1E5B67
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861361; cv=none; b=FQ6ShlRUOvy14aX81rfNXUz/7Y9gEjpaWlzVmHUlqzKIuKLE6K6M2gTvYBXmDx2SwF1RuUlW93i5Ykr7YxEtl5MRaayTHeZ5GEo/PsxM75mVyprsc+YmGTd3wYLCke5J8Ykzvd/1XcFxp9BrVD2nEbssKGWfpUYJU3NQmlCSToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861361; c=relaxed/simple;
	bh=P+R/seiW4SdaugRVKN5RxHi7jOa6KORXfMaGII56onc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbQAuZZ+bHeFNjmvJuTJswFGvYp9+Mid6VL/cqSBiQbeWDhgKEgWAF+uk0ynWomB/cOBlGOCFxmlISuDd9VCKdBizEOdPjHj875rhxIMiU/mdnQNxz91XKxO6y1Z4R6X3p+fk4TBO60DW8I3oiIA8UeXU8lP60nnqmKXh/z0/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UE/cj0dU; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UE/cj0dU"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6ed0de64aso95804485a.0
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 09:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738861359; x=1739466159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgtQMDH8wvAi61vjGth8jKP7I7lFb2s3zjflIWQJd14=;
        b=UE/cj0dUTShBzR2IM8Cd0/Qac7R+yGVdE2S7QXUaBk01jSu7F22eeXo8scVemz4pwu
         m5+GfbOQD+ySkJhGNLi/aodJcmOjbudm2I1l0CUlUlHvu2YchY5ONl8kHNHCVjnNTdB8
         FKLZDk/UfksutX2eTtvAH7NyKp9tVWhzMdk5GvXALriev+L7BqTPi9m3a/moN6xSxTsV
         l8/5OGjEvcyNPgS/TGOXg7PSrdyEYHn4qD9d2VEqH0zryTOOvJhHDXNX3p9duJ5MgGrr
         AA+SwAczjqHoXs4gIT+qRWdgjXajxm6kggamQ9n07krGMcKxI+BQ/RQGqCxTrLKLFCvy
         3bLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861359; x=1739466159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgtQMDH8wvAi61vjGth8jKP7I7lFb2s3zjflIWQJd14=;
        b=lzxYnvgrE969JztHQb2qmpNUDSnW2moLQF7wfdDQW2jtd0Cj/EVXnOW/kR1MJamvxr
         fZ0fgJjIeKJrzALbJQhUdFuhwcdTrsn5ZwmtOlrI0HQNTWjmzeWfC+F33v8sgIY+AiGn
         y24R+lDKnmoSHcpDPmJx8tuVvYKGeeGaiFQdsXhxCe+rb3Q/aLJmv/wilEHJDVZoCIzn
         WW/PTcU+Yc0gefs48fJISdwx5FAqUA0RH3hXQae42UZOgZeAU+Jny3LX8NCrjWKAhxlG
         UpguGTY6+fcZsBQURVhzY/CVuKRYhiRuBJsBmzDuzrMX035oR7+Myig7hALYXgLwn59B
         p+cQ==
X-Gm-Message-State: AOJu0YwUCNTEzn2OvBVpbNIM/kvZrkg/sHUs/EI5wQ9OHv10wenLXCID
	EB9luiCRc4aHPv5BNm3iUjsf4iw7GdxD+WnldRQ66wjvhDZnQUBHFzlwrU7Ff90=
X-Gm-Gg: ASbGncu87vXWOGxWsaBMhgLGho5OpbN2lhCSjCHH/AM9HCxs07nozUV/HbQvHItfKmL
	XbQVyOpCphX20EN/eOlcYQx5WhmVeuvoSU7BAp80XzsZvNfeKNJ7qIMPdo8R7VJUDsexqSQ/QQD
	HM9I1Rr+yQOYTjG+gnBsPwkM4cDSZooGMWW2q6Zy56+M05dZ7HH7ygevFAigCxsMk5dW3M5YF0g
	8YhO8dxixLe+7fC+7QpsbTFuRYPRUvi448JhnF1ccfYQGUJCKP90zwvjnYFYej6S26fgrJmlrOi
	IIvqAtk/58CimQkr5VruFXnCune/55wpEzIUaanfbPR8thtUq7XoUV4zLujflofJPOi3t+SPHg=
	=
X-Google-Smtp-Source: AGHT+IH4e+2/mk33Pda+5bbgWoteDOK4b0YEQKjFSfKlwtguaz1AcoSdRIebUoZTBB/swniKFKDIng==
X-Received: by 2002:a05:620a:3705:b0:7ac:b95b:7107 with SMTP id af79cd13be357-7c04024b43cmr646556485a.12.1738861358953;
        Thu, 06 Feb 2025 09:02:38 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041ded1c5sm81054085a.3.2025.02.06.09.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:02:38 -0800 (PST)
Date: Thu, 6 Feb 2025 12:02:36 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 02/16] PCI/AER: Rename AER driver's interfaces to also
 indicate CXL PCIe Port support
Message-ID: <Z6TrLKCthMY9g24W@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-3-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-3-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:38AM -0600, Terry Bowman wrote:
> The AER service driver already includes support for Restricted CXL host
> (RCH) Downstream Port Protocol Error handling. The current implementation
> is based on CXL1.1 using a Root Complex Event Collector.
> 
> Rename function interfaces and parameters where necessary to include
> virtual hierarchy (VH) mode CXL PCIe Port error handling alongside the RCH
> handling.[1] The CXL PCIe Port Protocol Error handling support will be
> added in a future patch.
> 
> Limit changes to renaming variable and function names. No functional
> changes are added.
> 
> [1] CXL 3.1 Spec, 9.12.2 CXL Virtual Hierarchy
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
