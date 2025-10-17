Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF6339710
	for <linux-cxl@vger.kernel.org>; Fri, 17 Oct 2025 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711131; cv=none; b=LJR2OsZn0dQ0i8VpzjalQuJaX8XhqTLXAbc+NucA2l6+9syj52ORIigxRvtOz4mcP/I8IFetRgxWLS784wYA6CHw9tkmwENMyDCkGQE2iXTA01QT8wV7VUGmWkJCs21vWhD+rBXoImb7gqeu2qwEls4Mc5FVTtUg/z+qgK4PBKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711131; c=relaxed/simple;
	bh=gyPAg03gcaeUi5cqHBA+8ZkI1AJBxoiIcKJ80dolOCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DskTR2oPqNeN3pjrMBruWadjXhk+tyyUAqUwRurrasLR5+CnJB+z3KTtq1Ii2syTFmjjIcMXSE45zqLKYYhbfU+lvh9CAvpIcG7mlxyFngqU48r99z8u0+aownhnrwB0zXNhwO1O+NWFUKDkidLAglujo0s3S3lNYuzQ2DmWxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AQpVYqeR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AQpVYqeR"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-87c1f607e72so24950226d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 17 Oct 2025 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760711129; x=1761315929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dR94qc3L4qOoUf4aThyhcpSx2pMieomZsghayB7VXWY=;
        b=AQpVYqeRAyLafMBfJ+wsz9L9j0slkWnDVhsl8QMMj4KfZ0gChzwraZMkiHobGNVJ0U
         yfuy+Y7vWgVZ6kfIm6NJ4mfUWdZBab1RuXZQbalM1n7Q2u+1m+6hYYOnab6sQaxh9r8t
         VPnkiIIDRrLk9JUOHNjpQVYtdlJ4/H5fdVPW8bddI06h4JpQN8BSfjPgGFxVvHo7A2xY
         nh3YtTYozYNWRKE0kEhKA5KoStfBg8nSks5sBY8O9DgZIBrwJ420Ci7p24Cy6RAAt+/U
         8hCzhTA3QKRXaCTApgMHUaX97SklvWD56hfvHsPfSZnkJOdvNTOhtOhEUwZuKHIPGwME
         B7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760711129; x=1761315929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR94qc3L4qOoUf4aThyhcpSx2pMieomZsghayB7VXWY=;
        b=USlaKTcT7Ps4Nv0QU9KxJO8AF6+m3k14X3vf2eyHfTmlTqm53s+wbv91EWyIV4OJJW
         XoMpRJ1iRz3zBTHtpxVKYEG4xk3E29yKomA2Yh3uoPhfAqhGguMNDDasPCAW/MqcgXrP
         MMR5kYhGgWRflXZpwF0LvgVou6bQigiwaZwFVBXc5c3777O9+nFNzt3sdV51BTiYmM+t
         Gf2emx4IgE3nUXD9afHGYTXnmPLbgI92A2hyX0J3CJRTubwkOqjtDTlkj31WwyQTszcq
         6WZIZAYYQHfkBf4++D0rChbnt3DrA6vFrIyKjxxLEokL9bxj1XqDixLqkBgjAJPHEMu4
         rWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsNrIQvEdB64NbrP8Ivteu9fFYbJSFgXsHCHgFRfGEkkAbGJz92Aa2J10FfmjlKNAfY08ENkWFP2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAcxGJ3qsci2G0E9ucjc17OQ8hBETFKHMuPWP8JSFtJewkAyK
	nE4xw/1OuQ7cBAzNuWgPfG1EmIrkSKJXPm0vK3IAEOtZq3mNTua1nfd0TTxJsTG8pbA=
X-Gm-Gg: ASbGnct7QUtAqR8roT5X2jV6xiWHQDQZO2I9zSMXmdCqM4cPs6/yESIyyC+TseD9VVY
	FZbPfn/WaOb3EmbLkpC+Arzmp2abB4aFM88H7Vq6Eg2R/RTM8PrtUPthqMlBm/0WSkRYHBhWPnu
	5g5V3c30ibcAUHuBJl1dyzF7bgWbaTAnxNQADA7c4wJx6HekaaxYGPMHhIt/at53PdOaMpceAvp
	3J0ODxZ9m5fcZnO0L8V/JYeiNNo7sTcpXt80odlEyrf1DGLshlnIeMiCJ9k6nvT/SG+mCl/JLs3
	lDMHt//2MhR41qQlzFtzqotSiCH2Y2xORyXMsa/lc7NEe2bJXYUZ/Ob/a6kgJWYFNXrpLvn34or
	ZWjpLM+BqP1rA/Knf9240aeqwdnN3vdLoY7zKjh75CdkNjRKqn2t5+6EQDt5u0cSuZYH6tkA+Q+
	q0azOSkVJ8pxNcMdnaI5/D6TlozCiSOkiQsEz+vbBUquYBfEwwIOsekEZk2Uc=
X-Google-Smtp-Source: AGHT+IFFyE3ciIaSNxdrB+aZ3wVp2jfY1dPKpBgbYNNVRd2U2lMmLYqZ/t0/NY7HoLt6yGiYTxLOSQ==
X-Received: by 2002:a05:6214:1c4e:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-87c202ca12cmr57209516d6.24.1760711128666;
        Fri, 17 Oct 2025 07:25:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012a796fsm62503866d6.55.2025.10.17.07.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:25:28 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:25:26 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com, hch@infradead.org,
	a.manzanares@samsung.com, fan.ni@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: Deep flush support for CXL pmem?
Message-ID: <aPJR1ihx1j3UqUjx@gourry-fedora-PF4VCD3F>
References: <87zf9qf46z.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zf9qf46z.fsf@DESKTOP-5N7EMDA>

On Fri, Oct 17, 2025 at 02:11:16PM +0800, Huang, Ying wrote:
> Hi, All,
> 
> When reading the documentation of PMDK (https://github.com/pmem/pmdk), I
> found that deep flush is used for data loss recovery in addition to GPF.
> With that, we can identify that a file isn't affected by the GPF failure
> because it wasn't opened during the GPF failure.
> 
> However, IIUC, the Linux kernel doesn't support deep flush (via
> nvdimm_flush()) for CXL pmem at least for now.  For NVDIMM, we have WPQ,
> but it appears that we don't have that for CXL.  Is deep flush for CXL
> defined in some spec?
>

Should note that this is relevant not just for pmem, but also for shared
memory use cases.  Last I looked there's nothing defined / implemented.

When I reviewed the cxl.mem protocol about a year or so ago, I came away
thinking a deep flush was going to be problematic for shared devices
(multiple separate coherency domains / non-coherent memory).

~Gregory
