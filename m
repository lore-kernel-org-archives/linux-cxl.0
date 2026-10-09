Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA763033E1
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566852; cv=none; b=uMpJ5Yg5A9YIevhMQhfpCSZAu2x5vdsdlMDu1fOhRfdjMH+q+E48KE4NxkmxRqTFkXbaQrGKw59/oAPeMRJjTstqKf0cehG+2IblyM3f7kOOMpLD0NoHw2s5hJsKAPoiUWTdPNv8zE9kvkwW/768Yha8iZ8EPytQE12y1DyxAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566852; c=relaxed/simple;
	bh=S0ePV8DesRV2qDCXVsOFPcxSODqUZYZKEZbb3jFK62o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7ujoeyoCWG5CN8uuhEnZVABs07y6zGZOpiJaolWmNqhDA2uSPiQpMXpXvwaZyc1OHftp5UbrIq7XIWxin8tYQlQ28Gy2GXExImKhA0SZks5qlGF/HZvdCNb/Au5N8FQSuYguI2njyHfWLkTm1NIC2FAleHKQ3aAQGoxIO2+Yl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edXqelzI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edXqelzI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791566851; x=1823102851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S0ePV8DesRV2qDCXVsOFPcxSODqUZYZKEZbb3jFK62o=;
  b=edXqelzI2jrntYEe/l0oUjjGcuioklTrXYqzMPsRn5unlbVtdPyG9ABd
   d1IQBBM2w379QkYr/y9G+WbnqstKvWuokSJxors88oRqMQngsYibtxD3+
   uQjtvXrV8UIw1P6s5MfkZ3uD+1olaiBv9CXxavHvgfJosdHwS0dREfMiw
   ZnWECKoL7CXThorbb50Qol415LmlksS/I6GBO6imh0Lx5YOcEwlhiB2gw
   Tvv8OQ9rDXKxtelbX7cj+B3xD2/xYl9SAenxZ0sfaY3kbrp42GBhyY2Vo
   pq+YCAl51gBgZIHtlUBfVYuGfGjqCbl8pq+ifdZZaQGACLHkw3weSWTHW
   A==;
X-CSE-ConnectionGUID: nXUsRX2wR/6ZJQnT26PKaQ==
X-CSE-MsgGUID: a4s+mS2zRHunxBSvAYOWjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="253392"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="253392"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 10:27:30 -0700
X-CSE-ConnectionGUID: aJ4u3I07Tw2iTSB4p6Vrrw==
X-CSE-MsgGUID: 5wHs8oqaS9uEmbHm1Dcf5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="326800"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.99]) ([10.125.109.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 10:27:29 -0700
Message-ID: <efcaa39b-2cda-460a-926d-bfe2c2543778@intel.com>
Date: Fri, 9 Oct 2026 10:27:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cxl/pci: Update only the Port GPF timeout fields
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20261008034619.28059-1-kanie@linux.alibaba.com>
 <20261008034619.28059-4-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261008034619.28059-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/7/26 8:46 PM, Guixin Liu wrote:
> update_gpf_port_dvsec() rebuilds the phase control register from just
> the timeout base and scale, so the rest of the register is cleared by
> the write. The other bits are reserved today and nothing is lost, but
> the full-register rewrite would clobber any field the spec defines
> there later.
> 
> Read-modify-write the register and change only the two timeout
> fields.
> 
> Fixes: a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1f470ab0df3b..edf0b47f39db 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -846,8 +846,8 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>  	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
>  		return 0;
>  
> -	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
> -	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
> +	FIELD_MODIFY(base, &ctrl, GPF_TIMEOUT_BASE_MAX);
> +	FIELD_MODIFY(scale, &ctrl, GPF_TIMEOUT_SCALE_MAX);
>  
>  	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
>  	if (rc) {

