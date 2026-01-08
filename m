Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B223C505
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887955; cv=none; b=bEm+jbomddAMq33SeVchVGzcQw4zxvPAzIZLzUY91gDkjf9LZGVDM9St9T+Omw+SteMF/Qdnh0JpVoqyrk/kXsPP9S3wsxqpBGhBLBmXVk//xIeHAm0OHgv8D92qS/ptKcMGQ5VZ2z3C6czx5YzmLhDkOhhgYlzPl62DphQ2S78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887955; c=relaxed/simple;
	bh=41MAT2/GQhUhZZZxTkEgC7wOnFJQ5cRRMtMK8ZjDIpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMUADiihHvMn+aQ4YRf4gAo4UD/GuscCEcs7QpP33aDDbJavqMveL3T5Zasw+9gLy9INHzpupRue3Z1XQQvUQdCj26nXRkq21yKEyP4DYqaQlBJFFaWlKJiD2dpu2e8h+gqe3zxD3qEZMTC5573coppB7MF30qJ2ArNLJM/YL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXW/Km/O; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXW/Km/O"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4503ee5c160so2075868b6e.1
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 07:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767887951; x=1768492751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dP32v1J28ETzWwf3EZSCOYB/oPSc0qp3HyTWJMzhC1U=;
        b=kXW/Km/OPmNOw89NSZHBQDs/yfznPv7d2BCz4acDpf+dHw23Eo9ntD0Bw0kfYsTnhJ
         SPOasllJ+CQOylxcuMreJulVSeIkjuAXrJktEIGOL33Ei+ZKf6PvJmEKmRL2eJ6tbpZx
         ZjpH20nJCQj9UU6p0L6ttv9Y5aVlFYzHKqupSQrCme3oFiPhG4+4Qw6+JnW0Nf4V3vqc
         +zAqHSyE0IrmZmtbzfy5Ta9pl8+6mfX1Nhm4ND//2TavkKlM3a452bllDuCPz1Em8uu4
         APiNsj7IZ2O303EO6cM+y8Ti5veg7fbdErl0x4iIqKdTb6FTLxXeXQ7DkQYgoc3Of95w
         +eLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767887951; x=1768492751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dP32v1J28ETzWwf3EZSCOYB/oPSc0qp3HyTWJMzhC1U=;
        b=DVTjb129VuID6tDjLJeR54sABiaINKLt27K4Ro5dCVD0f43DvuqIXKY2A2aqeCM544
         hyNfCNRaeEQvRV/kd/wMFOIuaCMU2X7UJ3SNt5laXTgmbycPE4LTyQW/uw5zBqM3KHv+
         +q64fezJ34gRQNfuMF1ol5ae5yMdANirvhJZ1R0Yhy1rfk9nO2zb4s4Z0sXdV0cFGTfO
         2O0EM4i9+lePx3JC5WCGwqI9iRie3WuEhnavmPoomcdOufJhXBAB2PE311hPQw7Iy6i3
         U0Pq2zyYKHtB4j35lOE5fA7GX/7wOWfeVQUOk93QH/L2BgjdqVSVUzURRTgbw5IZ0bpC
         +nOA==
X-Forwarded-Encrypted: i=1; AJvYcCVz9mt4eQzXMQY8SVKiwCfN296FtCgC4FjQKfZo3RFc5t8QdU23+Tt7Zobmu0o8SbJI4GMLQAH7opA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWJgZFFiv0uDHuHB0WoOFwfuy9NZB251c6w07NAAkEY45r2jm
	Qk4Y26d4djHvTOR3seqW0yxn3MnxpZdPl7sLn83hj86sgjUbALvtAoNn
X-Gm-Gg: AY/fxX7Jxna+zLNvHaQaKWpuTFluSZ4/HwFkESOOR0yQ6CAKCbAcWphjzs3ELV5Oi7B
	qxDEB+wL5Ne8Xzu9bx78by2OBfcTLxzGAJGOygY0j9aRzSnA8lQlwDouBqSPKGPaW8Cmub74TyE
	RaQAzswnP50vpU1pDaLZdcpeW4UtjjFtAWBW7a2JO7GOV3seRUY1Tcdnklj1HlCRg6EUkaVEdnz
	1pPAFPRtX5B1MIPPPVFEthwi3rZDztYCIRCR11P6+XxnX0eJZmySGIS6aifMSpBtRqWWIjkkwpM
	RlzLcQZbyBkMONlz9Q6p1owYOHtjnxMpbkmOBoBbT/7R2fOQq9cPhF7xT98j1mEbjbcMbFga1sk
	3Uig2gfjrIQ+lJomHrCoDZgY1tBDYZ7RxcLYm2tcuc7dG1dUzdsDCMs40JmJ5jOCSLTgZegyaNs
	pl3bprcBVyjuLBy4CcZQZc/EbdBW/HrQ==
X-Google-Smtp-Source: AGHT+IG8/pJiADBVJQcwYeuov1zJxNe4GKIPyzKZ3LLskqg6PZuOotYGSOumCQ8DG0Yg9NjTKaIQrg==
X-Received: by 2002:a05:6808:c2a2:b0:45a:135c:4d80 with SMTP id 5614622812f47-45a6bec82dfmr2418714b6e.61.1767887951217;
        Thu, 08 Jan 2026 07:59:11 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:902b:954a:a912:b0f5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2894e0sm3614343b6e.13.2026.01.08.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 07:59:10 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 8 Jan 2026 09:59:08 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 04/21] dax: Add dax_operations for use by fs-dax on
 fsdev dax
Message-ID: <gqwlb6ept22edcuiwwzxkboeioin6l4afemn3lenbduuwbb357@tnkceo5764vf>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-5-john@groves.net>
 <20260108115037.00003295@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108115037.00003295@huawei.com>

On 26/01/08 11:50AM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:13 -0600
> John Groves <John@Groves.net> wrote:
> 
> > From: John Groves <John@Groves.net>
> > 
> Hi John
> 
> The description should generally make sense without the title.
> Sometimes that means more or less repeating the title.
> 
> A few other things inline.

Will do

> 
> > * These methods are based on pmem_dax_ops from drivers/nvdimm/pmem.c
> > * fsdev_dax_direct_access() returns the hpa, pfn and kva. The kva was
> >   newly stored as dev_dax->virt_addr by dev_dax_probe().
> > * The hpa/pfn are used for mmap (dax_iomap_fault()), and the kva is used
> >   for read/write (dax_iomap_rw())
> > * fsdev_dax_recovery_write() and dev_dax_zero_page_range() have not been
> >   tested yet. I'm looking for suggestions as to how to test those.
> > * dax-private.h: add dev_dax->cached_size, which fsdev needs to
> >   remember. The dev_dax size cannot change while a driver is bound
> >   (dev_dax_resize returns -EBUSY if dev->driver is set). Caching the size
> >   at probe time allows fsdev's direct_access path can use it without
> >   acquiring dax_dev_rwsem (which isn't exported anyway).
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> > diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
> > index c5c660b193e5..9e2f83aa2584 100644
> > --- a/drivers/dax/fsdev.c
> > +++ b/drivers/dax/fsdev.c
> > @@ -27,6 +27,81 @@
> >   * - No mmap support - all access is through fs-dax/iomap
> >   */
> >  
> > +static void fsdev_write_dax(void *pmem_addr, struct page *page,
> > +		unsigned int off, unsigned int len)
> > +{
> > +	while (len) {
> > +		void *mem = kmap_local_page(page);
> 
> I guess it's pretty simple, but do we care about HIGHMEM for this
> new feature?  Maybe it's just easier to support it than argue about it however ;)

I think this compiles to zero overhead, and is an established pattern -
but I'm ok following a consensus elsewhere...

> 
> > +		unsigned int chunk = min_t(unsigned int, len, PAGE_SIZE - off);
> > +
> > +		memcpy_flushcache(pmem_addr, mem + off, chunk);
> > +		kunmap_local(mem);
> > +		len -= chunk;
> > +		off = 0;
> > +		page++;
> > +		pmem_addr += chunk;
> > +	}
> > +}
> > +
> > +static long __fsdev_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> > +			long nr_pages, enum dax_access_mode mode, void **kaddr,
> > +			unsigned long *pfn)
> > +{
> > +	struct dev_dax *dev_dax = dax_get_private(dax_dev);
> > +	size_t size = nr_pages << PAGE_SHIFT;
> > +	size_t offset = pgoff << PAGE_SHIFT;
> > +	void *virt_addr = dev_dax->virt_addr + offset;
> > +	phys_addr_t phys;
> > +	unsigned long local_pfn;
> > +
> > +	WARN_ON(!dev_dax->virt_addr);
> > +
> > +	phys = dax_pgoff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);
> 
> Use size given you already computed it.

Not sure I follow. nr_pages is the size of the access or fault, not the size
of the device. 

> 
> > +
> > +	if (kaddr)
> > +		*kaddr = virt_addr;
> > +
> > +	local_pfn = PHYS_PFN(phys);
> > +	if (pfn)
> > +		*pfn = local_pfn;
> > +
> > +	/*
> > +	 * Use cached_size which was computed at probe time. The size cannot
> > +	 * change while the driver is bound (resize returns -EBUSY).
> > +	 */
> > +	return PHYS_PFN(min_t(size_t, size, dev_dax->cached_size - offset));
> 
> Is the min_t() needed?  min() is pretty good at picking right types these days.

Changed to min()

> 
> > +}
> > +
> > +static int fsdev_dax_zero_page_range(struct dax_device *dax_dev,
> > +			pgoff_t pgoff, size_t nr_pages)
> > +{
> > +	void *kaddr;
> > +
> > +	WARN_ONCE(nr_pages > 1, "%s: nr_pages > 1\n", __func__);
> > +	__fsdev_dax_direct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);
> > +	fsdev_write_dax(kaddr, ZERO_PAGE(0), 0, PAGE_SIZE);
> > +	return 0;
> > +}
> > +
> > +static long fsdev_dax_direct_access(struct dax_device *dax_dev,
> > +		  pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,
> > +		  void **kaddr, unsigned long *pfn)
> > +{
> > +	return __fsdev_dax_direct_access(dax_dev, pgoff, nr_pages, mode,
> > +				       kaddr, pfn);
> 
> Alignment in this file is a bit random, but I'd at least align this one
> after the (

Done, thanks!

John

