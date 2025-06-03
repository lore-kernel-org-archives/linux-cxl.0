Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15025221F06
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958664; cv=none; b=fvB6FHDQj7NjrbjoOWnuJmolR3s93Ulf0jnyXLmCD0TVfbDX0iCeIs4IUGmrQNpCpDxeuICGrgQf0vrckwlBpqVo2XaOHztOYrlbK+oYydB+Tqdtis2q2zMqi+xIIlTM4LsjIn6IUhw965XU6Q6LJv+h6Z3ktTB8r1R+OGZGYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958664; c=relaxed/simple;
	bh=TpMwl2oz7EgmR302mml/BLJBQvaM57yfpZzI6Z7p75c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcrfRbl6NVrpSbC57fU38iHpgueqAAIXv481za/jI5xmGz3RvS4S52F6KrW4/ggDHnHmzzEB+xns3yPPmf8pPKlUhOiZZqCUp7CeTGvu/SYJogQI3/wZsA+5EHswUOWS8Gheipc+dJVzuEHKCUr2nWWSywDEfuyXUOfvjh27/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QHfIQXw5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QHfIQXw5"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d0a2220fb0so519777185a.3
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748958662; x=1749563462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjoJn2Zm/22QHFjhWW1StoVgQrArf1QtKVAZNo0G9LI=;
        b=QHfIQXw5But1vmUFqdBH6BH/hFhbWI4i6QCDYKQrH6nXF1gNEWyy3Linkm2QzQB3eS
         hQ+jSXBuKlpUDWA8HxTrScBMYslIuisCvkwxxZoOp0hOqSgCk8kTO1XCvTZryXT1AV3s
         vLVgX/f5cdSflDOz7fT635cTw7WA3xxlF6PYdR2WoOmpzZUxVTW/M9y1cfI4RdC/3fB/
         epQDqplIPk4dJ6LYXVowzT3PlepXl2womploBf3dqZ0F2j5JdNj9tjRAAy3NxziyZrNy
         0mqe4M1l0RGyrNmg4SBuwcBh4a0FdBz9gzPQeqsUhQEAgJ+aDTuNihxlJbkzwdDRgTJt
         mRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958662; x=1749563462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjoJn2Zm/22QHFjhWW1StoVgQrArf1QtKVAZNo0G9LI=;
        b=hUr9L397YqEFjTVZz+voCg6rJIomMZpcCNewlGXG+ClH+0Utfk0IfR1AZZ7GaAHWUd
         DJVh8TSjS7sSdtdEHSGHlItAtoi+UlhHrX8niebCX1J3rPI6/rsOxjTpxXH4p/naCQpj
         j8LPZY8hvl3jnwssR9Yu6v0uqCLLNQOV1WwWZVu4xiHkZ9ZVCUpU354t7t5+2Jlz18hw
         ocv6cH6+JpJEctjrmJI+XaQP7lFDMWc9rOycEcbakY2hsVnWGhQCHGhnE07dwYfKri52
         qd3VqMwSMkbtXTpBbej6vckgCR6vKrjSYQHzhkDv+jx6sX2+BXGgIEkLmMmgECna/+A5
         1hnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUADN8kgRNTjEQxVnv8YIv7Rs7IWc8X92bjqIbb5dWmjL8S0EegDMs85wQZ0UcI0yw50cU160Bcf80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/7whBjDYWSQ+VHOE6a5iLgeTp65t8A2c8w5b4WMVYI/bEEBCR
	uiMD9IXxt7ILZ+FT4Iuv2Ee8RH9o10PaE3kycBxD5dcpZqaZM5sY3GijdUiOxWDcoJ0/ZvrWKkj
	byBb8
X-Gm-Gg: ASbGnctDbapeaeXBXiK3kQloV2YJrt8Ew01O6b9GOCTxK4+psqpzamVulOp992C0F5i
	da5Hl7rgcXF9Xh9/cELzpTKQYQ4Ot+Y1IaPZsBgD8qvguE11l7UHXCPGn1vWf1aRrGCsHOXUCoV
	ZSQH76NYBAtnaJlaa7d4h5cZ36QZcE2Ld5KtUqMBsobm9ddKeyAcLmhwjjNKGj5hZPutPA8KekF
	lTHWRPJGqTfSk3OO6OWD9xVjAlrVNr0xvagBn3ulTMjSzUawGXISk2JpNSsQvQrccaFIs3WZaIJ
	flxRQUrVec7EASenfwTYIVo3nADHi3Sj4CZC+4IRg2vpwmjk/32xpksSmoJYJrASaewKyHzrq8U
	BFws7G5GWYj4di4mgW2YLhiqBwDk=
X-Google-Smtp-Source: AGHT+IEFP32FP1kWWCcJZHDROTyLVsjrCtV3bR6kiIwGVnTYe5RPt72l9Jyf9JX2LfFifGppycDP9g==
X-Received: by 2002:a05:620a:4629:b0:7c5:3c0a:ab78 with SMTP id af79cd13be357-7d0eac62c8fmr1708400485a.14.1748958650816;
        Tue, 03 Jun 2025 06:50:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f9925sm841658185a.41.2025.06.03.06.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:50:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uMS2T-00000001hDC-3YG8;
	Tue, 03 Jun 2025 10:50:49 -0300
Date: Tue, 3 Jun 2025 10:50:49 -0300
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
Subject: Re: [PATCH 11/12] mm: Remove callers of pfn_t functionality
Message-ID: <20250603135049.GL386142@ziepe.ca>
References: <cover.541c2702181b7461b84f1a6967a3f0e823023fcc.1748500293.git-series.apopple@nvidia.com>
 <4b644a3562d1b4679f5c4a042d8b7d565e24c470.1748500293.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b644a3562d1b4679f5c4a042d8b7d565e24c470.1748500293.git-series.apopple@nvidia.com>

On Thu, May 29, 2025 at 04:32:12PM +1000, Alistair Popple wrote:
> All PFN_* pfn_t flags have been removed. Therefore there is no longer
> a need for the pfn_t type and all uses can be replaced with normal
> pfns.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Yay!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
