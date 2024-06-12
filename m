Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A163A
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 04:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166635; cv=none; b=upIsgxB4uRE8anmaxaMfFVzmtt/KUBQF4CIZYs0szURh7eC6hLFBq9lEwLFTFj9Xnpk5dbXeCFTwtBD43QO1KrS5oF645WzdASD3kC+IUjPsSLhHeq/u6tlNPyNgKCWT7P50UxXMEMknb9bQuxJ7ZZOsIjYX8+1GEEYEn2rvtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166635; c=relaxed/simple;
	bh=dK72FwHyVMrflsfHx1wc5rgKt3Z3l8KFGOARjGjv8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSohPJoeDXPrdPwqz9SnBn7T6HyFaSDhciFlLLdjvb2A0RrgzTZ/EYYnMdoM/8/SV+OsmB7iiPdTinAtHjmALSpHnorLJkSDlToZYEdsJsOZtHZZZC8LU+sLQmQ8g8fSkuBCR2fYAePcq/gFXEpe3huxMjbyD+YrtMiZsME0pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rpqY5fqx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rpqY5fqx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lpHLTbGEf2GHRqyOnp5pYAE5eGXcckxXB3/QJ/GB9Es=; b=rpqY5fqx+nK4j7xTuJMIIYLJgs
	QrlA8awwA7XjljjyrT0NAI2Ltn69HSlUNdlXR+abRS6YhfnUo2FwJVGsbj1WAC7qhikxVoiga21F3
	6rZ6t+6UbKwb2RkpzhAazLlJ4Zo+KzF6iBu9cdtv/jhqFRvQ2mF+WNDrllRmvtCzumBjFFUgD67+d
	LxABar1JoOcVWkj5M0pHT4X7pV2mD8qdFxTxtEqW+V2v3+tD3KXzhyJC6LZmWGhUS4WgOvI/RAPt6
	/wzFia+lQH5XFG7OWnviR800dgwn+m6HRZq7+rE6SMoldFv3vKQ0xojFwJPjoNAxi19nrmP5/rPrW
	+rnlUtDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHFd2-0000000B1k1-07aF;
	Wed, 12 Jun 2024 04:30:32 +0000
Date: Tue, 11 Jun 2024 21:30:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: alucerop@amd.com, linux-cxl@vger.kernel.org,
	pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
	dinan.gunawardena@amd.com
Subject: Re: [RFC PATCH 01/13] cxl: move header files for absolute references
Message-ID: <ZmkkaOTUFuzIr2cG@infradead.org>
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-2-alucerop@amd.com>
 <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666923ba32ac7_3101294dc@dwillia2-xfh.jf.intel.com.notmuch>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 11, 2024 at 09:27:38PM -0700, Dan Williams wrote:
> alucerop@ wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > CXL Type 2 devices imply specific vendor drivers binding to those
> > devices instead of generic ones offered by CXL core like the PCI driver.

No, it absolutelt does not.  There is no such thing as a vendor driver
in Linux.

> So I don't like this approach, there are details that are private to the
> CXL generic memory-expander use case, and some that are suitable for
> CXL.mem and CXL.cache capabilities in other drivers. That distinct
> subset should move to include/linux/. I.e. I want to see the incremental
> conversion of what 3rd party drivers need compared to the generic
> expander case, and consider when and where new shared infrastructure
> needs to be refactored.

And I'd much rather keep all these drivers in drivers/cxl/ anyway so
that we can keep a tight control over them.

