Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5691C42E00D;
	Mon, 29 Jun 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749148; cv=none; b=bPDDoRxEK6ghRnFZk2grPcUWkTYBR/Ddf89JVgYAAnX9eBpd2MFpQqbMNAZUgodNdTBgJzex0CSG+qRl6jm5a+ZmXPtHCrPJzvDgh3K5C65TeI+WhO2pG80vmcYBFJqZ7QMemhNz0LWckhzdnbEWMjKtDBvmGkbkObUU7EfNb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749148; c=relaxed/simple;
	bh=G93Fzn9yp+J9qrSM9p9ojdn77koBjNCELHZKhW3Uvt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j67r5GzGqgLKz3Gl1Vn41AlSDSV66s4Lfjbwgdb1zubhvjPixzxKLgtC3VdSsGwQnDFSuUvlzUdAQhxZTXQvsg7tqZvR3hil0m/FIkmQxdUUrAeozCen2KEJedCKevVT0ntAQYAYJf0/34rgueB1ycXC7FvW6j3hlLxvMfmfEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOrb9slQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOrb9slQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782749147; x=1814285147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G93Fzn9yp+J9qrSM9p9ojdn77koBjNCELHZKhW3Uvt8=;
  b=KOrb9slQcrTFFDCWH8YxcAW+EV8ikgF0GeeKJhZLSmUStzOkG7C3YHFJ
   64Hd4gMDTvx2e87Qs5dUghhCK+nJwWzSwuVEmElLqDa/i3A77PXxrQ5WD
   2/879SjWAP6GbIH9xcRUGgG15ZjXM2nOvEJsrF6BQRnYpzcfTHDFRWBYR
   esmD6gNJrzbRWv4iOEkwRhgf6x/QzMfjiGyrAKMVsFQzUC4CQlv21STwV
   DSvBkT5RKZ2fGEBw/ku63h2mre7uDdOusBMTyQM40xYYkKAB3WHm1Deec
   2c0oIsF3tsgLQhbQeDLb4ACwRVdqPghDT7KOmj6yeGw7J0yN+F8T5CCtc
   w==;
X-CSE-ConnectionGUID: 5E5G+EIYS0qH/vjImzzMlw==
X-CSE-MsgGUID: DS/FF82bTO6zPTXWmeJJ/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="87284890"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="87284890"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:05:45 -0700
X-CSE-ConnectionGUID: aQwnjs5/Q8SG0UTHBKyIMQ==
X-CSE-MsgGUID: d8mYyquCTCi5mRPVMY1CEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="256917278"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.194]) ([10.125.109.194])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 09:05:44 -0700
Message-ID: <a7354acc-90ef-484a-96ae-5f3d8d567366@intel.com>
Date: Mon, 29 Jun 2026 09:05:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: fix mailbox return code description typo
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260624122835.5656-1-alhouseenyousef@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260624122835.5656-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/26 5:28 AM, Yousef Alhouseen wrote:
> Fix a typo in the CXL mailbox command return code description for the
> interrupted-command case.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Applied to cxl/next
fe7883d0e99a

> ---
>  drivers/cxl/cxlmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c5..503ae2864 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -183,7 +183,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
>  	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
>  	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
> -	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
> +	C(INTERRUPTED, -ENXIO, "asynchronous event occurred"),			\
>  	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
>  	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
>  	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\

