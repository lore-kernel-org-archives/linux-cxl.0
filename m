Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12727187336
	for <linux-cxl@vger.kernel.org>; Fri,  7 Jun 2024 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772483; cv=none; b=Ckcdqi5dU+htCAP+PvPYXcVGYJmS7MgAvBW299X5gONznTbs0eiMdaK5v9IeZZW7yFCRAzZK1TQKHwwdmUh2oJyuA9sYXjlIwwP28sIj6K5+tUZC5WU31ZW4sb2fvXqfGiMSMVsA0YJgiCZ7pSBuWmc3CktsrzzxK/Yj3lxhVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772483; c=relaxed/simple;
	bh=V3FjAtkSbU3cPONVvzGk5q7vELlVAGKUR3phS43rYt8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/N1ujWyJ1/+mtp6OaqaAJWHto55yNftEjukNaJFxrLokL4igN45HUT31XZ+aNyYaCQDAm9eTVkjD/rMZ4cQfNjvPIE+Rgea/hsjMqNZfQIlvu6shYLGfWR8T0qnoaYKK5QTk2kbyrxZy4iNxyi/PHnxH4/eMtSmzhzUiwbjMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwkmz2VXpz6GCty;
	Fri,  7 Jun 2024 22:56:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C5D2140B33;
	Fri,  7 Jun 2024 23:01:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 16:01:15 +0100
Date: Fri, 7 Jun 2024 16:01:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] cxl/acpi: Restore XOR'd position bits during
 address translation
Message-ID: <20240607160114.00006e4d@Huawei.com>
In-Reply-To: <77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
References: <cover.1715192606.git.alison.schofield@intel.com>
	<77d251960a557f23aa6e6e0465e0e42f1d461514.1715192606.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  8 May 2024 11:47:51 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a CXL region is created in a CXL Window (CFMWS) that uses XOR
> interleave arithmetic XOR maps are applied during the HPA->DPA
> translation. The XOR function changes the interleave selector
> bit (aka position bit) in the HPA thereby varying which host bridge
> services an HPA. The purpose is to minimize hot spots thereby
> improving performance.
> 
> When a device reports a DPA in events such as poison, general_media,
> and dram, the driver translates that DPA back to an HPA. Presently,
> the CXL driver translation only considers the modulo position and
> will report the wrong HPA for XOR configured CFMWS's.
> 
> Add a helper function that restores the XOR'd bits during DPA->HPA
> address translation. Plumb a root decoder callback to the new helper
> when XOR interleave arithmetic is in use. For MODULO arithmetic, just
> let the callback be NULL - as in no extra work required.
> 
> Fixes: 28a3ae4ff66c ("cxl/trace: Add an HPA to cxl_poison trace events")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Trivial comment inline.   Agree entirely that some tests would be good.
I ran through a few trivial cases on a bit of paper and it looks to
me like it works but that hardly counts as testing :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c        | 48 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/port.c   |  5 +++-
>  drivers/cxl/core/region.c |  5 ++++
>  drivers/cxl/cxl.h         |  6 ++++-
>  4 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 571069863c62..20488e7b09ac 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -74,6 +74,43 @@ static struct cxl_dport *cxl_hb_xor(struct cxl_root_decoder *cxlrd, int pos)
>  	return cxlrd->cxlsd.target[n];
>  }
>  
> +static u64 cxl_xor_translate(struct cxl_root_decoder *cxlrd, u64 hpa)
> +{
> +	struct cxl_cxims_data *cximsd = cxlrd->platform_data;
> +	int hbiw = cxlrd->cxlsd.nr_targets;
> +	u64 val;
> +	int pos;
> +
> +	/* No xormaps for host bridge interleave ways of 1 or 3 */
> +	if (hbiw == 1 || hbiw == 3)
> +		return hpa;
> +
> +	/*
> +	 * For root decoders using xormaps (hbiw: 2,4,6,8,12,16) restore
> +	 * the position bit to its value before the xormap was applied at
> +	 * HPA->DPA translation.
> +	 *
> +	 * pos is the lowest set bit in an XORMAP
> +	 * val is the XORALLBITS(HPA & XORMAP)
> +	 *
> +	 * XORALLBITS: The CXL spec (3.1 Table 9-22) defines XORALLBITS
> +	 * as an operation that outputs a single bit by XORing all the
> +	 * bits in the input (hpa & xormap). Implement XORALLBITS using
> +	 * hweight64(). If the hamming weight is even the XOR of those
> +	 * bits results in 0, if odd the XOR result is 1.
> +	 */
> +
> +	for (int i = 0; i < cximsd->nr_maps; i++) {
> +		if (!cximsd->xormaps[i])
> +			continue;
> +		pos = __ffs(cximsd->xormaps[i]);

At the moment the comment on XORALLBITS isn't associated with this
code very well. I'd factor it out as cxl_xorallbits() mostly so
you can stick the comment next to the bit that does the work.
Or maybe a #define XORALLBITS(hpa, xormap)  is good enough if
you move it up under the comment.

> +		val = (hweight64(hpa & cximsd->xormaps[i]) & 1);
> +		hpa = (hpa & ~(1ULL << pos)) | (val << pos);
> +	}
> +
> +	return hpa;
> +}
> +


