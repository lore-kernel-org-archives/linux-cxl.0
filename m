Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B1336D4FA
	for <linux-cxl@vger.kernel.org>; Tue,  3 Feb 2026 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154563; cv=none; b=dUWlnHWArHtXYeO6XpzeUAEo/Woi9OtKdgxXY+CYzUMUPTVtvGvRwmmUe+ceZYLFoSxQYU6ceNJjIdlLcGHW/+rykSUTGCjRknrHP+cYVvjI8GDaiZJBtK3MLI4M0HupPjuiAZ6IumTXpV67cxnQ2lH0AK5bxQ8+sIe9hepn4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154563; c=relaxed/simple;
	bh=opDMmHtRxS0/lSRNoK3mscHUWdCmnio2rsHWsmdhLIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0YoPh9Iv4QsT8g3B06lH6fTDv5+i84N/n280z1FmYhw+k2Pe+2mgEh45YcZue1rNeNVDoxMnokGTW47NwRwSgcb5NFmaMJx4kKrZtARDUtAjl1t7RZZF66541d+nIiYVBWTBZH+ewpuLrDIMau+/8wlo/dhVtE+Kmu3ck5VaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Xzskahpi; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Xzskahpi"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5036d7d14easo62408281cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 03 Feb 2026 13:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770154560; x=1770759360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXWdzwNSwn1jJ8B9yEiSs048+F8gzjkvoB9M2/M3KG4=;
        b=Xzskahpi4g9ljwf2+LCljKE3tiCcRjF9Z6Tk17dDn/l9m/PeF1hZb0FVXFwYrlDUPh
         ZvXYC8bVcwQ9w1CfEomD9j+hzLxRAid2xqbe4AnxkhFeyab2goUXRuv2KOi7kMrfAK8i
         yYC1Hvjbn8ehGkam8NAAPbtIMw8D5wq+gvQkvqYwsFTnxG5BuPG6Xsh5NSw+v1JB+D++
         zXw2w/Z5wmAck7655sJFMqXx5Sez6Tm3PWsKwEw+LQmPEuU7xc6+Tgeucvj9xU5IKtZq
         oFsLHBpRGJxWWNPj2w8H0oZ/FM9p39oCUsI662vszXRwPWx/GNNlzoZkwqS+ASiD2ByR
         397A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770154560; x=1770759360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXWdzwNSwn1jJ8B9yEiSs048+F8gzjkvoB9M2/M3KG4=;
        b=s48jVJodCVi3btLj5mWUSmx9xDg11S5owepA9oiRpECOd2rHVskZ//9LxS9Zq2EJr2
         LRKVOUxRIzbe4Aun7QqWby4dwpmkXafEmQBlP1yVrgdZZDS//eeuPx2Q0ccXu8T+haBC
         WAi3cGRl25PbnuWYdukWTXXuDx+Wx6yjUbm+TXU5DbZhMIoBSZD063v1/sX25m4YPgcO
         K8fNicBMGx4IdReH5641V7JwD6+8L+4Idv5oAnjOIGTecZ+3A/fEbgSJsat2ekRBi/Rd
         oIoDrs/IYG6NrkxUe6ZO7eOerd95Otp3hqKCYTyXaSb1V/l3xeOuPtxoX+7/WBpIglAX
         sD3A==
X-Forwarded-Encrypted: i=1; AJvYcCV1Oz45V0xo+Ijb/C/kwaudb1BCWczScII5xX5exnpN8AUda8Y9PQh0R/7twZaW5bPI+RfNWqGhyPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJcRywp/4TBE6p9A4eyB0B7VBJFa9mCpqrD5JvZmGrRCeZR/o
	Nf+sFq4/XQHFL8QDfPd4x58BSQ9vrLmyNuTsmcXD02eo09/26BwtJSBJI0tHeHh1EfQ=
X-Gm-Gg: AZuq6aL6L4X9ErN0NGLj4dqLhRVPl3kPbDJh/NjYkzwk1VlNbcO+ueTKpvbYtCgwumM
	TeAhp5KKHJvoF6x/fMbiy4xnhsoYe/YtwkwC3BqBTJGj2ucRJAU5drrgu34akIr+5Ohr71QV68a
	JeoflWgRkXaJQFUF+FewsKM/e/1AzITjg7ilFqk3dPj9tijOIX7Mddx9diuZ7YcTRK/wcs3eGu9
	nUrSoCgMiWedcZOcwvKqi9hR7yU2NJiSBz9dDyeNH7ZzB9eT1iiZFiTsqcNL4XFZbGwD6XfFX1L
	xmwK2OmNH/+813Cugt0rHe8AR1kXMbvp80mdHtfP/62XvEfeHn+ECkXr56zMabJEyagUQaxrF3D
	RsrA77TnRYytYVGECUk2UDslXx6omSPqQoRP5qk/bb3YWc597Jy38/33KlleYj7fkOvvUi5qwzT
	JZjPS0cj8MqHBf0N1G47uD/RH41xnNDJScU/VDe4D9PrXN2Fa6Rxxzv1FrRK9QrC8BhfWvhw==
X-Received: by 2002:ac8:5986:0:b0:4f0:2d9d:a3ba with SMTP id d75a77b69052e-5061c1c792dmr10836851cf.77.1770154560519;
        Tue, 03 Feb 2026 13:36:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd53e58sm48573285a.48.2026.02.03.13.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 13:36:00 -0800 (PST)
Date: Tue, 3 Feb 2026 16:35:58 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 00/13] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aYJqPlWju4VLnQlz@gourry-fedora-PF4VCD3F>
References: <20260110114705.681676-1-rrichter@amd.com>
 <125a0a77-b966-410c-b9e4-a7d81e462576@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125a0a77-b966-410c-b9e4-a7d81e462576@intel.com>

On Tue, Feb 03, 2026 at 11:52:02AM -0700, Dave Jiang wrote:
> > 
> > Finally, Zen5 address translation is enabled using ACPI PRMT.
> > 
> > This series bases on v6.19-rc1.
> 
> Applied to cxl/next. Including the conventions doc.
> 00bc604c96bb762f0f050460e25de2729edb1699
> 

Congrats Robert! And thank you!

~Gregory
