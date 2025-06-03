Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43551132111
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958686; cv=none; b=QY47Za/MJfuPubkSt2KIyExzrDbGEQ27zGsOQj/nOHFBMJgzrWpz5Io2x5HaslDrJBDp3/t0twTTzBvBTz+28wVqMU1fsMYYRQs6cDM674cO+01uE9i9It8Kz52paIkpHne5176jBvK7rzLwR0ZvGp6PrhM6IDeFPDfSvpCPu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958686; c=relaxed/simple;
	bh=DZgdvaQsVzy3FEkZ9qjIOfWCU7WN4gcYp04RM+bGGPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxCRl7XGaPO0EYD+n+agBKQXMC81xPdPksw6WdphecKTSGax/3yZPZBFc1+IzFKGMZf1QtUjAVUPO/Rdo+ghCdRdBk7D3XGDsaiKVvm/zqILBzxqD8CBHzFRPstR8fmcFukeLkukIUtvSpHzi9Ct/OX1wwqI2BL/Ry8kfE5Cn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CkjRQVCo; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CkjRQVCo"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f0c30a1cf8so72685216d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958684; x=1749563484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VzY+cZCL0448RY0GID08t4arF/zf+2+XaBNqbHYkIpY=;
        b=CkjRQVCo62+UdQJlcNKk9VStpJfKAfSkj7uDLJAc/YWTM1zvSrsN5EZZaR4PTlIj5z
         yo2SjyR1wqiQfBTHNexaRxrqGj3hLlTTX3csuOdyzbR8z1Xe995WpXPDV0+5ffx2AkIZ
         U5vq184X+k5p/VQiIFOS+7iFFZCB+/x7Oh5gnV2tPjioeiCstxG9btlv9mF0FmeUWGJE
         +kxNaRtj6mRr8ngAu7fHyMgIsMERoOUKtwP9q99Mp+FMyL4HTJRO+IG/45bLTpqSQczx
         qH3wmD8OM+yPUcR/C9x11+TsSt5pFdjkiB7JE3VbLkGCg9PigUvrAcH9871NtnAYMqmz
         73tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958684; x=1749563484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzY+cZCL0448RY0GID08t4arF/zf+2+XaBNqbHYkIpY=;
        b=hWK3MD+lo4h0sVRLM/5SROe3gl/KQzZ0RFfUk5ZpGAJUyeyT5b2WfG4RQax6NHhwqE
         iLfjHj2BB2sX8VwhJ59s8X32DT70uniuQ77BOMlop4AJp3AfekgAG6Hhjr91IgW45H/S
         KIvpcJ4/LdfuF4ZrL7Z/v0nsTNj0Y4cQLd8E1VGpwtyDSJlC3yBsJCNiUtsWDDi2uY6p
         IOTNDa0zqTSUKbxoPtUEVSqbvhTRh9Li6RF4PcyZlwQFrPKMaWCAU5BkX/fTKPaeVUIV
         pUp0YxTk5P6ahRT+/iz9KFkROqxa5ngt3exunzVQCdsYrbnJ1vihsA5PsjkKgRAP+nxz
         pnrA==
X-Forwarded-Encrypted: i=1; AJvYcCVCthfb7We8DYZ7bK2BH3yKJ7Amkzot7/sRsn9r2f5UpmGWdrdbJewPmLkSLPyUCtclRvV43rZBjMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEOwwmGvhxW/QkkKxm3q1t7oS1lNHyJdGZeQPBzKUq93YvfrZ
	U0BrMhhZg6K+E98z4zz7VyYFVFugzJ11YMNIN5fCtlAfGxfNM4OaXPXyic2pp0epvj/XGwlTeMu
	FeFNl
X-Gm-Gg: ASbGnctTXDuExgVXLeVm1xseLxbK25mQDNKF1wr0JgwGnJnV5VxAA8mv1RSjagomAe4
	JlO0hpPPYkqedgKOCOIPGFPaxE+JS1tqSax+Lu4p28QTVYysD+mosyZlEqVpZPkaG2iqa1wEFhu
	cOxhPI4NlqZ75/nmX3TnwSi6YTKsqE4w0GFDseFe94gqHID6EZWq+uiQz2atfeGB/I2wlfge04n
	iZjc4tuxFmtJs7wrraRsNXm/29eReLebMjejbJZAinxaFSPSHr8KLsrg9jP+hu5jHEPSgPamt6H
	axfXrstYr8IezhauxtFxqcSbIBxnz+7gzDBS571Wa1CMIf2qtbfUBtwzhYClekNHQbEyzq0jVmF
	xgfXTT3DCMDIXyir5RGUAAmNtfYQ=
X-Google-Smtp-Source: AGHT+IFvqH9ubcC6dbv0UqQGW5DGDtp+BZ9QNaQHwHo+bs9Vg0oCfSh3AzQ5xeJI5fTattmwccxXPg==
X-Received: by 2002:a05:6214:2aa3:b0:6fa:caa2:19bc with SMTP id 6a1803df08f44-6fad916605amr159392986d6.44.1748958672893;
        Tue, 03 Jun 2025 06:51:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fad0495cf2sm68040826d6.39.2025.06.03.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:51:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS2p-00000001hDX-3xh9;
	Tue, 03 Jun 2025 10:51:11 -0300
Date: Tue, 3 Jun 2025 10:51:11 -0300
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
Subject: Re: [PATCH 12/12] mm/memremap: Remove unused devmap_managed_key
Message-ID: <20250603135111.GM386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <112f77932e2dc6927ee77017533bf8e0194c96da.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <112f77932e2dc6927ee77017533bf8e0194c96da.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:13PM +1000, Alistair Popple wrote:
> It's no longer used so remove it.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/memremap.c | 27 ---------------------------
>  1 file changed, 27 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
