Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275C13DBA2
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jul 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510557; cv=none; b=dd3r6nwNa/S7ukbuEpwo+vLFcxhbkNm+0V1hQh+vkUWZ3lfV4hbvI9qVp6xibJAQ48a7IgKFHXzU8DTACsAXu4P0BK2/a/1pcICwpNBI/t86En3WQjeAJ2Pywq5rydAxQ6ejsyMMOR8+skCzFohESw9hJC4x9rxOh+DeJFIwyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510557; c=relaxed/simple;
	bh=HeyJ9lMz1NSGY+tG5/lo4GiCzuIF5FSVCvTEm2YeLdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqTOnY7jDTI4rN96GVvZ5sknzXFNw81l3FDKtU4ATCCp4/U5USCnIaU145rKzY2DoFa30raGJwNpS+dRPr2MEVsu+s9QzDt8sBk9SW3CQdTciMEZE7AiKVFHDaP23m8TA5JoGT9A6VF7j8UxMdlCDcnyOz5TFZmcrf+jqE4GPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xHVX/rur; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xHVX/rur"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gbMJt7ebPejehgKgh9FlmEO1SVbhJB/ogMBBrAQcifk=; b=xHVX/rur1eoKdfYrI4y6Z9fVRX
	DkNTM9YhfDTDhcoL+n+awFBX+0D0/UQSnx9hb01aogrqPU46b6aAtKcaPk5d1bbbm1MiVprQS0QO/
	xRCZBqNTCPvlgloOVC8uokEMWDWz22FQah/wuHE+7H2WyfZy2pDYRFLt7ICwgd0HZnGgS+Cq/3kU5
	xHqMsSmVXI5qi5IJ+GNDQRvrLXcEDskPaaUVtvdKhgP+jYqK+SgCcffIAUisLgzJo1hdTlkwDKwwW
	zTqjli6QFmSaomEk1DvtnTd/zA74BM6sjYkdIrsRM+CTdQ7YF1sKcRCrGcaxLnF9OFIGwVPAKQVAq
	p8tlhfaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR5OF-00000006Fey-3a2X;
	Tue, 09 Jul 2024 07:35:55 +0000
Date: Tue, 9 Jul 2024 00:35:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yee Li <seven.yi.lee@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: Is there any plan to support CXL GPF in Linux
Message-ID: <ZozoWwm2v246szTu@infradead.org>
References: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
 <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch>
 <ZozTTpbMjff82vO0@infradead.org>
 <CALX8JfQwCFsF4AvCwiui_7J08j41jJiSTLMVCQTx++EseguEdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALX8JfQwCFsF4AvCwiui_7J08j41jJiSTLMVCQTx++EseguEdg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 09, 2024 at 03:22:53PM +0800, Yee Li wrote:
> As I know, for cxl pmem, the DRAM cache is very large (even equal to
> NAND flash). The data is stored in the DRAM cache. Data sync during
> power loss or some sync operations. Data is stored in the DRAM cache
> for most of the time.

If the device can't provide enough power on it's own to take care of
the DRAM flushing then it's simply broken.  All these details are
something the manufacturer needs to take care off.

