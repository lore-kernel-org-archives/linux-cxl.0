Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392381F3BAE
	for <linux-cxl@vger.kernel.org>; Wed, 23 Apr 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446355; cv=none; b=bpbJee9VnCtpM1hfYotHg2ggr3sW3gbg7V87NmCgDvGMaxsbYhGtXdkgRuvwbn5/jPqJpy78OGFxsQ8vIhds/hzzAH6fJEJGLQuCRvQoN4fd/lVuXTYTRWX8Ffcmr5P6YRCQo6YEJKjSr0lIW40JZ9zL45MnP9Y6C1n4251wH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446355; c=relaxed/simple;
	bh=pxCRpPeP5/ZuKvy/5RkvJwDJBdNzzC8Jwte8C1sV994=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEm92lkBQKwTfiMdj6/cyVofq3udv1GWGAtiL3xwC93cVGBrxO+3ZF7XxMj7x7vpcGFRsw0VYRsUhszfqQeFqyUvjVWhT+pYj1uo581sSVHTJzWHCWqOeJ7BMdxPXkAWVIFVxGkeFDgOe9p2QB5bDa+S2nZ40SD0hsBTgCS5ZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sliEkyfU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sliEkyfU"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4774ce422easo4039871cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 23 Apr 2025 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745446353; x=1746051153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGSu2/ndlUdb1fs1CGKQUBgSMxzZ0kzGZd1szVYFmbc=;
        b=sliEkyfURIL6k21GLQLmGysmvfrfKcErG9dxM3G7B2oN0/VNqOgj0MKM0/DTtmCIkj
         cg6tphrPjaQyS/g9914g57Jqy3coG2LWQzmytidCse9DYT6udGo9ld4Mf3hEVnSpbC2L
         1rAl9ItsZEjE6+1D+5c3U+Ly+a6idncMk1GuSPBGLFluzcgCB88kDmE7pr3Oam47xAWS
         ZdC33heqDDXF7h9OZFsJM++k0siOTeAZkCEeZWqVzb6RxGoCnXz60QpkUVSVL58L75C1
         R7PTyr2+VyHlVOLUF6xXAtKl/2zY59pdE7/I0vUpN+pHCYG5tbqIlp5tnvW++CBbLs4C
         qYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745446353; x=1746051153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGSu2/ndlUdb1fs1CGKQUBgSMxzZ0kzGZd1szVYFmbc=;
        b=SOzcmazsSUwFM+7DaD0ABRFrJuGLNjGArhkt2zOGjQIa1bH1Sj07PHKZOWV57ISBFC
         0GG6u9YJv6UXVohyDGL8jmllBKjf7Hu5yzeRM3AaZRyK4Q3FC/69f8AawGSrJ0zs5cGw
         5V7nDZNNRlr3/UOlcL1AinNmsTTOIY7xNEU8tk3iA+LqY1//3UOfoucYSWtGH6IWneTp
         gvgb+QYjdeUlj4/OYQGaUffH0T7jv3HTu+4utfQv+108jov8i+vQ4m2QVV72uib43T7q
         AEZyg+EQAYtj3Z9VAZdRdX74dLRaMo2V6YyY8AJoB9t+xvqebeh8RvZ580agoRZBKzPU
         xBjA==
X-Gm-Message-State: AOJu0Yx0KUSA3Gv+A2uAd2+33XfrdZgenEwAMv6VLy4m2ZzHlSNd3egs
	nBZpM7Apmrznn8kvVh/SvbA+Alqpo7x3I/m8+VQ/FsCv8P8/fKDW0kmer117v5s=
X-Gm-Gg: ASbGncuvXP0q+Xy3FjMwgsmAtsXEO/6qGy2BktYy5sC9J4uqiKdfsXmm6mJI4ZtecX2
	+8tACpZu1nWdlsd6py5XYBtkeZ9vv4O4itkGq+21CY5BFR9I6OudjOE1R9We4uCUTriiMx8fZXA
	ZCeLK1+sWvsD0VUGSu6qe4HqhAfw8jwKZfhIwvdkNkUzhikqtrl6Syw0KYjtw8lyXXyIX513eR1
	rn0a4+uNg0CDHNAiPsUj+w5Ix54Alf/OrEYVKsESgleZlzmx1/BpJ0Kgd+l4Fdg8HYNh4HYoQBS
	h4uaVzuwJkwO3qw5kUiqeLAfHsEpgeKg/D0BexwgCqzkGmxlj7wTH6LmEGDoY+sG2bFkHQY41ej
	SJYKtyczXWGjh+xx/0ifhMnM=
X-Google-Smtp-Source: AGHT+IEJWvDnsGY3vjry1HMHq7KBzCnRVUDLDsSKkcGTXxw03nK1OpLwZUuU/+EBwGnc/8OlsEG6Og==
X-Received: by 2002:ac8:5f90:0:b0:479:1a11:2f95 with SMTP id d75a77b69052e-47eb248cc30mr3193401cf.4.1745446352954;
        Wed, 23 Apr 2025 15:12:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9ebea2absm1710081cf.2.2025.04.23.15.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 15:12:32 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:12:30 -0400
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
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
Message-ID: <aAllzsbEOotodnMJ@gourry-fedora-PF4VCD3F>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-4-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-4-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:04PM -0500, Terry Bowman wrote:
> index 485a831695c7..ecb60a5962de 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
... snip ...
> +
> +struct work_struct cxl_prot_err_work;

This changes in patch 5, but this commit fails to build when the drivers
are built-in.  This should be static.

~Gregory
