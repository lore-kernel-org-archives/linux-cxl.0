Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55E137C35
	for <linux-cxl@vger.kernel.org>; Tue, 23 Jul 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745104; cv=none; b=ZXMrGyLvl+V76KKdmVi9r5J1xr0ALXEYn1QeQGIN+tcjwogWzjDIXWPHaXi5cyCHy3Mvyd+d88R8szsyDQxbo+A4BqSeR3UfgaQjH1eyoImLNW+LOkenvS3Cj+XVrlE0P93qYViXkWjsz3eUy+UOxT1UshdG6COjlIgmB3TnNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745104; c=relaxed/simple;
	bh=/ugkKBFe39nmAEeWYO+6fsIlND2wdiAF6UgYctaWCq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFlWQPAH/sKbyG9NBCzhgqy/hnWkIa1JeM+a3Pq8qVB1xeAyFgJmIQ9nIQ0xY46pL8M955///knxZ5gyYwe8ZWFxHk+UxBLZG/QEjd+s4Ot8fQCRyMWahfRq5Wc1gOIuSPaEkwQlBJYrkaGVqdZ5bYe1Cr4YNYTokVC6hwiFdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SlSmGkTc; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SlSmGkTc"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66acac24443so34437967b3.1
        for <linux-cxl@vger.kernel.org>; Tue, 23 Jul 2024 07:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1721745102; x=1722349902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ve0kpCbWzl0Lf6wnCzjPSHyuv3lRuAO5/SGwyLd9uMo=;
        b=SlSmGkTcv4fyyNTdWjEMV9IDUY1BPLwe/TW/cnAZqTSyJcRb8Y91hnkYuiTkxvBRTh
         IHwlIIiKh8FNiPiEmhGEjh5TB6GLYO96qcpvP3qLrQwbWeEKH9FrNPdi+CvcQUDvn0bL
         wULwvVfNeX5TsiAdhAVzQj7imeaGTVSIkme19Fg+xd4NArmFRsBtwvkde37kr7fqLv5G
         ryymmRAxEr1sl8faNIwvTDTJ5oB9fTe6AQ1e/Ltw/HfIEtxTy9a5IksHXYFAdIjQJWFW
         7ZD4TA20GsZES5VLb+6/QtlzB6Ewhhf4r15b0Yc/JhSAXrqVqZZt8txoj4XMfi3/mXru
         SFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745102; x=1722349902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve0kpCbWzl0Lf6wnCzjPSHyuv3lRuAO5/SGwyLd9uMo=;
        b=GWKjrTWgQRHg2drAsU8qhaTQ3Cii78sdNv1yhDKSgjRiqkqoalBkHHsnVrNWZc/Fna
         xSXzxACOD6UnZNIOGzj9+onAkI20LF1iyYR15NJS1PBk8L6xY0h5ivR36iU44U5x+UV4
         bGpgAsSJ7rtRQUMvEqZ1RNKBe1a+ovQEVqcgKCle2bQ24xIPwuW2+LXsGCm/L0tivmfG
         1A1OyYb6NCUel1klMADK9MEz0sEdQknCukxR/fYIDgHmyy0RNIdH7+k+/EZ+HyPgaCfz
         au3Xk0yFcqjeVF7FvRDgpZ9PlnUFd5MUrIMy/Md3SxFXNe9dt4ivtjmVK0XV7JgcRt7v
         j8SA==
X-Forwarded-Encrypted: i=1; AJvYcCVHFdXt8O182Lc8YmkLFuc5bCcR1JnLkdpcBOUAyAv7i4snuJ1X2UEZPf2tJZimOnr79U4i95j/oEWEoK8IGxUkupLORvVHNruy
X-Gm-Message-State: AOJu0YyeID2TXSEn3bWn/syjZxwNELLfUjGR+T+OgYA92DHMCEKMt0+Q
	AGGtHJytYLudoDbaTU9+ZO3gug4zJZRiCRKPMAWNoI+o5BloUcveYSbcVgTC1zyBheE5uMIIQqt
	vQ7E=
X-Google-Smtp-Source: AGHT+IGhn7vCE9PZ+Z1E2LDcmmD5r3HDlvvoSPo8ADNhS6ilQ5yxlxNwHnpXBaOT7GYGc3ot3mZYnA==
X-Received: by 2002:a05:690c:318e:b0:64a:4161:4f91 with SMTP id 00721157ae682-66ad8cc880dmr100680537b3.14.1721745101982;
        Tue, 23 Jul 2024 07:31:41 -0700 (PDT)
Received: from devbig133.nha1.facebook.com (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66952940a71sm19818107b3.66.2024.07.23.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:31:41 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:31:39 -0700
From: Gregory Price <gourry@gourry.net>
To: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 1/3] cxl/region: Fix a race condition in memory
 hotplug notifier
Message-ID: <Zp++y0KOrWs6NKrW@devbig133.nha1.facebook.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-2-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618084639.1419629-2-ying.huang@intel.com>

On Tue, Jun 18, 2024 at 04:46:37PM +0800, Huang Ying wrote:
> In the memory hotplug notifier function of the CXL region,
> cxl_region_perf_attrs_callback(), the node ID is obtained by checking
> the host address range of the region. However, the address range
> information is not available when the region is registered in
> devm_cxl_add_region(). Additionally, this information may be removed
> or added under the protection of cxl_region_rwsem during runtime. If
> the memory notifier is called for nodes other than that backed by the
> region, a race condition may occur, potentially leading to a NULL
> dereference or an invalid address range.
> 
> The race condition is addressed by checking the availability of the
> address range information under the protection of cxl_region_rwsem. To
> enhance code readability and use guard(), the relevant code has been
> moved into a newly added function: cxl_region_nid().
> 
> Fixes: 067353a46d8c ("cxl/region: Add memory hotplug notifier for cxl region")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Good catch

Reviewed-by: Gregory Price <gourry@gourry.net>
