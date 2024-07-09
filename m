Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4553376EC
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jul 2024 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505170; cv=none; b=hyTT9I4bzLgxuNxfNngyWn1xRsO0v3QUrCeA6VwI3pIh/ECT8jgwQSwr67jGx5d4cQBWKqOsNFS1qqfTlfINEKQUNZan6nb0ZvkDh2h3QegkCUjxfO6Ki5kWpxnXKyUNGWWLxuMujJGedCUYitpLv0vGImeKNwJbro0CoqxafIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505170; c=relaxed/simple;
	bh=8uqzKNrEmauOSfYirU/dvF7EwDXkY5CZ2AQ+hUMtF4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdh+SxJrbGUG8LQNz/Jqk9G1dILDie/jIVm/Py3kICq0QRTo54Zpr5jVDT1+cbo53XXC+NRzaR2ikYkj8fwaveuP4ZoT+C3NYGQci5bL2g2RUpiEuiPay2R7cvZ1aS3KvjaCP+6n/3RItJFXiJCUnZ6BU8ZqXeJLqdZmAJTfmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oW1Uh8lJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oW1Uh8lJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bYAPwkpALhSjE+Lm99uuIRIa04hDCAnZYqCSZkNAuD8=; b=oW1Uh8lJoq80RFTLL/QPY2npb5
	Whw6b2Ubrl85jNE7Iu0xVEpzKajw/SOMXVPOzxEAwWbbKtIq3JHscRs0xhzU9idrgDkb7kvoanscT
	BKj207STfXUBdxpgJC1Oj9UT3/y7JzS6kRTHhMS1/CG2M+3rXVkWRbjT0DadrJWrvZL5Bv7KGaYDd
	2oDb99OJjkO1t7Gguvs504cSXIdE/DOThCQl/aGjOSRtSpOIXcvGG/ZpCFa7wTDCVRBzvP1ixWmoQ
	xTFDvS58VhqipzyEkiqYlNBLIg5qGcvZ4IRgvmBwiUX0CD2ak/ntu8KD3BjwTIOITZgPu4PU3Ey44
	AwtTCu8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sR3zK-000000060om-0zYj;
	Tue, 09 Jul 2024 06:06:06 +0000
Date: Mon, 8 Jul 2024 23:06:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Yee Li <seven.yi.lee@gmail.com>, linux-cxl@vger.kernel.org
Subject: Re: Is there any plan to support CXL GPF in Linux
Message-ID: <ZozTTpbMjff82vO0@infradead.org>
References: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
 <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 08, 2024 at 05:42:39PM -0700, Dan Williams wrote:
> One thing that guide does not cover is what should OS software do with a
> dirty shutdown failure. To my knowledge there is no specific plumbing
> for handling NVME device write-cache failures beyond: "hope filesystem
> logging and metadata checksums can recover a consistent filesystem".
> 
> I do agree that the driver has a responsibility to set switch timeout
> values, but that is more an unfortunate complexity imposed by the spec.
> Just set the max and rely on devices to minimize GPF response times to
> avoid the worst case wait times that those timeouts imply. In any event,
> enabling that is "up for grabs."

Why would anyone specifically care about a (presumably non-volatile) write
cache failure?  A non-volatile write cache is simply part of the device
and it's failure rate guarantee.  So any data lost from it will be
recovered the same way as a media failure, SOC failure, interconnect
failure, etc.

