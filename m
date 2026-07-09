Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24E30E84A
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635780; cv=none; b=OEt3eAv5DsLFgKFgJwae1QjeoiKd/aw7fGx72mMwVnBBGGGso0lKrIW9W54K+gg/V7Lr1sqxJumLUCDEVUdN6iHnpm005F8jLUJ6FdHiXkH/KgHlx3OFSp27usuyuAznR/yaTGrCqrRIBNo17Cmzu5VVZIsATpXApagaB0P/v7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635780; c=relaxed/simple;
	bh=F9KJPRgK4L705MdJhF7jSetuwwe9QE17mcbAei3OvSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKnqvU62JD3GgRHUCAQiraz5hiAKi7wBzJrDfpY2D7ugyT5g40/yYSvv/ZbUKUz+7ML9qNfG/tQQq4Txju0l19tVhikbPVWV52mnOIj1oWOxQtC0wZEONejDGgL+F71vVUSMtpGnm5dMMZC7iFdrIqWXGJThlwa4Cr7C11n6MqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ym/nNC7x; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ym/nNC7x"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c1d487f2cso2592041cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783635777; x=1784240577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b50SGMSOIyssQj3plHocLLhkQW1pcBLVRqoMkWAD4k0=;
        b=Ym/nNC7xnOytLC7XYyyXeQU1Qcymqj/RUWB/43ngPmgvjZw4FNhcDHqLezVw2aGa8v
         4WL7EprYsWTvV4V7rm6PvWfLm0G/exjsygMismS/4OLDUXNktcx6xrWV3OukhQHD/VLB
         ezMJfkNYJgNMSliSyaxaOvOSb6MkSFhA7oRMBWos1WvWBbhV4nwI1twXqGW7LJsSvout
         2S64GC9e29rsLWS6Mp5O3FKkE8RcOLUokVAIBF05pUn1/UJI+faAHjA0P3WHf7C3XIZI
         4tsidaWo3GfzwRFJIqod085JOQy9OoqxyL5+iiKNvzJzuMyIvGINZd6+5+1ToDlABa4P
         0mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783635777; x=1784240577;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b50SGMSOIyssQj3plHocLLhkQW1pcBLVRqoMkWAD4k0=;
        b=GzeOSLiSLIue0lvymecWmwTuXiMavVKJUqm3KdqSFgB6nhJDj08WoBsDg6SHJbL7tU
         GkPQrX8ZJOEPa0CA3ql9T6KBHHlwNg9DGBhOFgz7Lz3VR2mIS8ZtoJee9l9wPUNlq7iQ
         aZ/0IN1UsdBSLX4sDaYD3/pux7Z0ImkIW/nOihTYU2NQPL5mu2SR1MbMPahGyCOlHKD6
         5WTTS+ROblikehWp02NFBIQMaCm0Ia7f7xAbEQWI2I3VJg1Gx3dyBHWGiftmby+iLjg4
         a2fIcZF+Lj1jnEVUtyjbDVX4fBtucK8claoV9EKZ532mDu6b8v2tdqvTDY77QTvP1HAw
         zjwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqM2rBfy25i55j9QtUGnfZLgiywx1of449fRgVkWNQvadbe6TnndWX/cdTvXws6StGJaknmDh+8Q8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnLpWPzu3x5SsU5sCZAdf05e3S5FpuCYsxscmfMD/S+wMODJv
	vAtFMnEZiVAGSZa1fr+g5mmZRg4NXsrymcmO4KEWtTdLllvtDxNpZi5mO4JlKKVsvio=
X-Gm-Gg: AfdE7cnwccv/lZSOYenEM6HafkofWrRUaH7s+2BJ9X8QRzgmwYH5xezHvvDNTA+eZMs
	aT6DIY0fj3l+BfIGccBtEt+nwmFmvhCG8koUR9IzKGyrHtOmINscalvj/rdV1ZbOKwMuFpn6B8I
	NzyJ/J8ryg291e6z9y26uERGsbW/msTBI0CQZOEf6h4aMiPR9UTLD8ib3BbImbOyGZzujWZhNer
	Vt08VegIRuN1t/c0OQxXFKRIjOhLwDFM3wWe5LgwEGmDtYPG3CcQO9fDAtA1eMUJDYrnL0Az5Eu
	Dba7gVd2KH/I/aOP6arR1RAwWaB7wmJiKgCNgEAYjokWbXu6TNL2yNtIK19VIGPX780y8RoH84O
	ECBzdom3gQ04PndDxlZx+zXvgsIbmVPpYG+uZmajLL859GkTQSbhLQDEwPqf/e/X1xalIZo9uav
	NhOU3K5bcVnp5Bx6a2TpprGb3386zvQIZmrDr//Tzw8sWKgzF1Bsfh0E49glbnXtZcx6Qh
X-Received: by 2002:ac8:5a02:0:b0:51a:8c97:fb91 with SMTP id d75a77b69052e-51c8b4bac92mr100050501cf.58.1783635777304;
        Thu, 09 Jul 2026 15:22:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caace31a4sm4283401cf.12.2026.07.09.15.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:22:56 -0700 (PDT)
Date: Thu, 9 Jul 2026 18:22:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	djbw@kernel.org, vishal.l.verma@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 09/10] dax/kmem: add sysfs interface for atomic
 whole-device hotplug
Message-ID: <alAfOxnnYQxPW8DO@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-10-gourry@gourry.net>
 <6fd50351-93e0-4d65-960f-53dee655a786@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fd50351-93e0-4d65-960f-53dee655a786@intel.com>

On Thu, Jul 09, 2026 at 03:14:26PM -0700, Dave Jiang wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-bus-dax b/Documentation/ABI/testing/sysfs-bus-dax
> > index b34266bfae49..2dcad1e9dad0 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-dax
> > +++ b/Documentation/ABI/testing/sysfs-bus-dax
> > @@ -151,3 +151,29 @@ Description:
> >  		memmap_on_memory parameter for memory_hotplug. This is
> >  		typically set on the kernel command line -
> >  		memory_hotplug.memmap_on_memory set to 'true' or 'force'."
> > +
> > +What:		/sys/bus/dax/devices/daxX.Y/state
> > +Date:		June, 2026
> > +KernelVersion:	v6.21
> 
> Kernel version a bit old :)
> 
> DJ
> 

It has been a hot second since i started this n_n;;;;

~Gregory
