Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4FD4035CA
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774365114; cv=none; b=qJkAB9EbyyieGrkb9as/huXS89PfaqKwJ7v5XKbZwS9uIieKzNxcurqIh97u+Z/pftVg6gvam+IwHwIDRZmo/fdg3S9oKXA+WTj1pQ6KrVbTKjlLIvEctgID845Uf2XYJFYb+fwZOkixfH44/Sng3k+eQyQ+r4P8k2+DIqbTssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774365114; c=relaxed/simple;
	bh=NB3LxlkO0x6eSuJGjSSSnX7CXXN3CQ99Ga2SIkCwscc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5O0P+N+/FVi+dZAfMIbXcFJelc4A6yf+CckpiQpEdmQWsfT6j7Y/59SRHGt08V6EeXAXp0mqlVDdmNPcC9Ggw1coMC+7vpqx9RMBWMy+WKLagJQHtbMG8tncfuIYJ95RAFSdWz1bzIDK3XnjUvXqSWPN2UMGcm09WLqfwKN2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=l+cgJh/a; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="l+cgJh/a"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89c7b27ca26so12027926d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774365112; x=1774969912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7NoNIPWD9aqkM46NTCuFK4LaP9mCKYqQ+pGlGyzPCA=;
        b=l+cgJh/aT/LWgkBajR16dDlIvZEUlhze5RNjSE5NdkRxRa0H0/BtQJvkkRSJyh5i2e
         QOiirr1kOZ+9p9E6WCfnNn86iYHOPPdCG2UjF1VKd9whaUF2A0KpPl4SvD6GXb5g0XW3
         5yqoRcdczrmS872OYSlYT6axsxWediY4eTggmuiaw82lFVWxr+UqjWH732RUc+Yzk4Pc
         +e5RHFRdszijefk/NeXEAi6T7I/3ArJx5FOXpPv26KXnTjfJw+rFid440PrxRRW3aoDF
         nw8+EWsHlp2YhQQU0CIRjinc6IyVfGsXQXHz3NHADCKlyW6scW3dyUujXsVYbo1U66Vr
         cExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774365112; x=1774969912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7NoNIPWD9aqkM46NTCuFK4LaP9mCKYqQ+pGlGyzPCA=;
        b=hTcPocnfEk9FF1QcHshfgozXUvD65h6kGj4tTNvsThxTuBywEKi0YdB3un22vBDuKe
         KY0MsA2xjkZ6U8jSxeW/Di2rY6bpcGAnaFGYYbLThFIT25zP3i+mNyES636rfSshwHx2
         QIkjZyiy4BsGQDEj0gocvWqlPpE2Xt04cqsMdZBt2qg3RR52fjoZKijqs8GKZ/XehSCL
         E2BcCUpeTDCShtyyUbzL70sPK+Ii1CY3HfT2xxobWz+HxhB5D+L5Z2JfpLPf6oGiczqk
         9Qa77jasb9KixcUZI16wC/p1OhK0/JbshZjTPjkMd0N5Cv/Fto41euuoQXKkZViHXuHl
         qvGQ==
X-Gm-Message-State: AOJu0YwO1DAPUNY+Qp9YCGCnDQmhSgo4mJqMy0Kz4lGlMbLS+SYRlKik
	Z1M6YnC8IJ/+qhBZYft3oJeEtp5bKKezitHSaUo7VDy9rpFkhJvebRKQc7raGJcKirw=
X-Gm-Gg: ATEYQzxnplcifCwsenOgC5uwLyv/lA7voYj3ZvtdC+coD87fQxQJ4izdz/s36A0mFm0
	YQHkrZFPwiPhLWk+dSOb2S3a6dz4Lgwq2pVIwo7m5Wq/tedXuAXlNT7u+cco4FNAysxRmm3baye
	dENc+d/c74ql6SpOvn60P30Jmov7ibOC5iSnHJjs0cdGHR7PB31vd90JuJ3DU5B7c3ovt+w5fNX
	hAk9nDzIKNlC+FHr6E/8b0ynr5KJSpH0Q9Kxvt9fwi86VmfiYSeVGaNafp635XHmot5yiPiRTg+
	oe5MrAnFlATStBibEoC3vlaTb+U8uq3NVjFRE1rjaoDHU0iVjHvEmyiHo0nE1rKNelXgMJB1uOf
	NkRJeHPW7rtFgGj5cuBlIv0O1pcl4bI7PXk+TtFvG6dMl0hLyXMRfdHmk8NvxFgtzOMGUEBqQ96
	Q3hNRsJm+mp8wlQgRjtg==
X-Received: by 2002:ad4:5f0f:0:b0:89a:b0c:7268 with SMTP id 6a1803df08f44-89c85a94778mr290733026d6.54.1774365111531;
        Tue, 24 Mar 2026 08:11:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::de62])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c852555a8sm120785056d6.18.2026.03.24.08.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:11:50 -0700 (PDT)
Date: Tue, 24 Mar 2026 10:11:48 -0500
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <acKptBsAaDOk0VaW@gourry-fedora-PF4VCD3F>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-2-gourry@gourry.net>
 <acCnaN9MIRByjUPd@aschofie-mobl2.lan>
 <acDRrRchRUSRBUbm@gourry-fedora-PF4VCD3F>
 <acIJrkkPD7dM3pBr@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acIJrkkPD7dM3pBr@aschofie-mobl2.lan>

On Mon, Mar 23, 2026 at 08:49:02PM -0700, Alison Schofield wrote:
> On Mon, Mar 23, 2026 at 01:37:49AM -0400, Gregory Price wrote:
> > 
> > The recent pmem/nvdimm Kconfig change does kind of show that we might
> > have some bloat for some deployments which might not care about pmem -
> > for example.
> 
> I guess my original thought was, what is your long term intent with
> the move?  And I was thinking you are probably heading to conditionally
> compiling.  HOWEVER, now the scaredy-cat-me is thinking, shoot, that 
> would add test config complexity and test misses. ie. Folks make a
> change in region_dax.c, don't test with CONFIG_CXL_PMEM enabled, and
> boom.
> 
> So, I lean towards keeping them all (working) together, like you have.
>

fwiw i think this is the right take.  It doesn't really cost us anything
to keep in, and probably prevents adding more Kconfig footguns.

~Gregory
