Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A43230BE3
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957714; cv=none; b=AdkkhrVCrbFKvzX0IlPbYTyZtCq7+sF33dQWhwHRWcAdJq4umuoux/cjfywf8GaOFQmnADDCeqKXvDn+ACom2qNOq5Hwfz1UI7g3zUF9ASx+jyfdrHj9nbf8YvedwOeDy298V9xtl3IXSeqYywNIkNdJYvGuHBerfKcDhNAFbLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957714; c=relaxed/simple;
	bh=6aXyILyNFzvdfLvnjhe+7eEg65vKZaS3Xgt9s4P7IoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi3YyJz+2WrF+UaWK66JzU4v83E0O2GShGDmnmM20uLs0kMGD3KamKnSTEYCrE5B9r7gdSFd/7DuaXdRLNdvBKyLKS8Y8cHoCZNmv1ITASZCFTSRd4p8JtcPqsVpmUi6puyTH5OSNtkfP5K4Db+L792Gm8nm3x2ad7/fVrJ45ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=L9faMCZo; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="L9faMCZo"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so36690606d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748957710; x=1749562510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csMjX6EgdDvsoUroDDkC2t6M2H8xOJU7irccfVA/OHY=;
        b=L9faMCZoU5k/eDkzQK021wVY5FNVNBtn7krLf6IoxlHpm1QF2vWzXGv0u7r8BdGjAm
         1ZfBSaDxx3E9EAaIl/9pE9ng1Ii3grLFqUSNGGaK/HmxD9aPIBsW35Zgihs/nAsL0Pj0
         DB8vqs9CFLwCTqERpAvT061kIhjcj3MYkTlunlPQb+nFkd+h4UHb1+UK5G6X5N4nFEQQ
         sJPnqYrKWS9tONkmVjTCC/GacIFCzFqn+4L4+rl4h+tk40iZk7kbUbSsFPC4JZsFF0YK
         YM+kJYa126BBD/AZ0Vw6T1+y8HPQFkyAjcpfoGYjT4hjB5l0PB43dSKVcIDuV8xRE9Cb
         gDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957710; x=1749562510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csMjX6EgdDvsoUroDDkC2t6M2H8xOJU7irccfVA/OHY=;
        b=QsaE5/vNw5GSX66rqoTb61N8zIuIo0HLBvLI6a8MN/Oh5LUZtzptIg5ooXcCVlcD9A
         YCcEbLfaRbwzyrEZYtLkqSsOeBreCX4gtGkDJVPqeJ1DkZuMwyTo8hxAhC1htJlYa7Hk
         KtefAemQKTqCxWYb/TL+CF6mE5H2L5OZwmj2flscEmRTfzbN8lLvMJImuuUy4VMHkOau
         yPdUZ9uhu8zdNiiklCyH602vBV+2mes98IuKdiGjZHY81VxeZtr8kYxwaOvGLGx418Ff
         JR+qUHwyHJ8jNqAt8IfRpXse1LtjPw6IKKmXu94SIEKf9y2sB4Hcq0zlkJaR0g/TuCqN
         rmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR6rhHWiczyPOmp60jUXh0eZ8xOTa8ZBa23gmzmehHTC7j04d3HVb2g8y3/jC/OCnikVGLZ+7Rcng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+be+bt+XyW7XCIItkSgXhdI2dMSdGTB7NmshvMjBfPEChFvZo
	RbzkfAWu9SGEkcd0VQ+n7X3eNVZyXhoTdXF772eBdXDQaIUs0nAdwD0g62yPJv6NHUc=
X-Gm-Gg: ASbGncsjfzVzVAJJUei34lK2U/0rfpQdo9w0wYbFayXay5L02TUbm9aoYM+lnTqxKIu
	AZwBEIJ3a/gUaYf2rvBFqmzlUoi7xNdi8w/me8P4IScUl8qk9Cvbk8F4NhDMdU8+Xwo7GiEryWK
	uY6hdBaNpunAXJz6UdxMoTESihJ+DhbsX8RQU9izXKL0njYfC6x5ABKqllDAbO7snH4uufGwsof
	7TYk+Kg6Ia0CVAwJXTfP5Fhjg9Xlmbd6HFOhDiewXxk3qvMBLxqE26mGHNDaNU3kKC/H0wz8/n/
	SqLgaYXUJ1wqGmpneYxCPv54S7kNsZ1JHlP7SFsBtboCr8ExItmOt0R95C5tynDjtdNjCrwDWsy
	kNJwUd1No8Yo4h23hqLCGXIODTPbHh0A2MLxETA==
X-Google-Smtp-Source: AGHT+IGTO1Uq6qWKkHjHjzXPtbeutCQLStskBTpgABiXf8IiWIF7+BRGzTPM/WsKdaJBbv1DscVTNw==
X-Received: by 2002:a05:6214:d87:b0:6eb:1e80:19fa with SMTP id 6a1803df08f44-6fad9090760mr153489766d6.1.1748957710547;
        Tue, 03 Jun 2025 06:35:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e2fc45sm80639296d6.122.2025.06.03.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:35:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMRnJ-00000001h4R-2OPU;
	Tue, 03 Jun 2025 10:35:09 -0300
Date: Tue, 3 Jun 2025 10:35:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, gerald.schaefer@linux.ibm.com,
	dan.j.williams@intel.com, willy@infradead.org, david@redhat.com,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
	zhang.lyra@gmail.com, debug@rivosinc.com, bjorn@kernel.org,
	balbirs@nvidia.com, lorenzo.stoakes@oracle.com,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-cxl@vger.kernel.org, dri-devel@lists.freedesktop.org,
	John@groves.net
Subject: Re: [PATCH 02/12] mm: Convert pXd_devmap checks to vma_is_dax
Message-ID: <20250603133509.GC386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <224f0265027a9578534586fa1f6ed80270aa24d5.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224f0265027a9578534586fa1f6ed80270aa24d5.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:03PM +1000, Alistair Popple wrote:
> Currently dax is the only user of pmd and pud mapped ZONE_DEVICE
> pages. Therefore page walkers that want to exclude DAX pages can check
> pmd_devmap or pud_devmap. However soon dax will no longer set PFN_DEV,
> meaning dax pages are mapped as normal pages.
> 
> Ensure page walkers that currently use pXd_devmap to skip DAX pages
> continue to do so by adding explicit checks of the VMA instead.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  fs/userfaultfd.c | 2 +-
>  mm/hmm.c         | 2 +-
>  mm/userfaultfd.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
