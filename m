Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A57238177
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958549; cv=none; b=T+nltNzUQ1dx9gIWCpY3uSuZkmUZqUcy6PfFV6P7O8Eh0VfR4QsFePjcyaJgdPFViuQeLNd8bHLr/yMXtQeLJ5gYGFvDCzQt7ezs3Ti4oznJBDKrn8fMFgau6rFwPo2QGRldJFUL8h7WWZCr8kxo6SxEyOeFJC5ZH8iRdo8amOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958549; c=relaxed/simple;
	bh=z6KLOqm9i0ROrUFmuMKuPSFgLeSRnBoRY1z3awpPe7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZKBQeF6hWLTLvSMGn78SQ0GUSdqkG5MChHFEkzF2ejTfV89bqvsfDiCLCU6Cuf8K3wn/SxhKdYa7b1/3TRU0FL1WuIuqLLcxta3appLSN1/ZtlcSx+m0+DBOz9Wi19QiPr94/S+7PA5G3jQOjRNgpOxiZs5PsLPBcjlh+QDlvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jJVQcqeC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jJVQcqeC"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a43e277198so40295391cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958546; x=1749563346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ooaH+MVJLI6au3+Z1ecUWfQ+S7G2Wg3KD+ti8ca06oA=;
        b=jJVQcqeCAc0iTCARHARG2NmR+PX11EDVnFDiahfPqaQTUdXWScZbdTlKmMfZhzmJn1
         rDC7kWLDXsIbilCjju0o/WGrcB+N8UcZ4IKxdQlNREzXmxbaXT1X5l8HfKJdYk9pSkfi
         dxbsGMqa62vDKd3pRQANnxKTtc+tv74/hLJqCamxg8F6SrZez31ZVtLH52rBR+blcXJo
         gRwepcr+jYILzItfj77n3cmsg/NqDOZp2EFfpLVFSOX+NgEBtytbNnrPnt/CMYpcao13
         gxCLzNK/ENITed7fzdzsMwHnkVTZ8FOaVKOyFvstoi+OKo6wD9a7wQ/IW+Cj5LmnWpel
         HNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958546; x=1749563346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooaH+MVJLI6au3+Z1ecUWfQ+S7G2Wg3KD+ti8ca06oA=;
        b=eSgKzRcIY0Dq99qhDL/gmcBluqa1n0j9gK51D71LINRM2GrVXcYRKeP8IsukyTBRxn
         6p61sqs2ZnJjnF4Vn3epxBCxaDyMLlTDcxwzN2hs8QVqeYNaMGR6N5qaove7Eo1weicX
         aUPU9SJiqDCEZCa0M4RVs9YIjrEonUFDI1OiBGN4vDrykBKnYuuq7jq6ylp7bXrEOQy+
         GsyFs/IdazN1bPX7aZUBAyPZzUQwybBBcZwuX0rqnmNUUl2IXOib/8ArUYOw945qClXm
         tcmA5jRc+kK5oAEmwCEyIS60GKgQFJKm3/cyNmf1pwKj71FR9MXJqxvtlII5EA7pNE1t
         /kQw==
X-Forwarded-Encrypted: i=1; AJvYcCV1mGFeR4T2rVFrGi+q04KJAkLp+kjMSTlIVOc+a5qBiwc7OgvbDj/LwsR1olOb9+BlSGog09vTvwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71QZV330SS1pAN9HsWbvQVdZiuoGgXBFJuLqTCLNQh1Nyf9Qf
	YTwQHdsp1Bpg7FZa0oh5FxWzaJ63zmp8xGYRqexfOpnx8YyJAcBzLfQJHHgsS7o0t9Y=
X-Gm-Gg: ASbGncva3ocdiUP10/ByxT1KtESb6DrCzP4E/BZHsoWhIHDDRX7LnKzriFfyLYNeJz5
	x1nkf0J8GJn3Ot3BMU8Y9tkrYr8dHmBblJfQzBIdDP8q7QjfN7+LlYZ4aBR/OUjg/VW0bgJQ/N/
	Oc2TSLGfsOjY2Gd1b5L/wgc9v34gMjICZ/DupJ1MGV2HN4H9dNJ/Z8QqtlCGjiAnQ/ldLanxpb4
	SJv29vWB4bS1949sPJGazEia15Lgtq87U1KOB0dBpqnv8+MdXWvaVqPuFqWgWOWWkAzs7Q34Xeb
	qtfi3k6Ya/dhldCYvWFX+DGgQaZO0MjYuxoSGJWIq5+sqCvyoYoYTAaCjstlY79ft1UjRly92Qj
	r7cvxNe5Fg0smpM6+o600D+k0Sew=
X-Google-Smtp-Source: AGHT+IGIU1g+493Q79vIGhbP57BxcXzG4cORozjsE0WNUaw+m77zFEPhKIIEfe6WhON7WEL1UbHK4w==
X-Received: by 2002:a05:622a:5a98:b0:494:b914:d140 with SMTP id d75a77b69052e-4a4aed8a697mr209908281cf.43.1748958546430;
        Tue, 03 Jun 2025 06:49:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a435772a19sm74189111cf.1.2025.06.03.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:49:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS0n-00000001hCF-1wNL;
	Tue, 03 Jun 2025 10:49:05 -0300
Date: Tue, 3 Jun 2025 10:49:05 -0300
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
Subject: Re: [PATCH 09/12] powerpc: Remove checks for devmap pages and
 PMDs/PUDs
Message-ID: <20250603134905.GJ386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <b837a9191e296e0b9f4e431979bab1f6616beab6.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b837a9191e296e0b9f4e431979bab1f6616beab6.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:10PM +1000, Alistair Popple wrote:
> PFN_DEV no longer exists. This means no devmap PMDs or PUDs will be
> created, so checking for them is redundant. Instead mappings of pages that
> would have previously returned true for pXd_devmap() will return true for
> pXd_trans_huge()
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  arch/powerpc/mm/book3s64/hash_hugepage.c |  2 +-
>  arch/powerpc/mm/book3s64/hash_pgtable.c  |  3 +--
>  arch/powerpc/mm/book3s64/hugetlbpage.c   |  2 +-
>  arch/powerpc/mm/book3s64/pgtable.c       | 10 ++++------
>  arch/powerpc/mm/book3s64/radix_pgtable.c |  5 ++---
>  arch/powerpc/mm/pgtable.c                |  2 +-
>  6 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
