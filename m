Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA02F87B;
	Wed, 24 Jun 2026 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325054; cv=none; b=WoxhvW0NfTx5bNsWcfm1ommQLeGBXWzd/16I5Hcno5ifugKMnFGUWKTib+hbEafvP6crJm2/4+gOWzScgrQVjWx0izfbNkOZEMwxxYwWjibF98fxGca7vGwmnH+/13dO+ty+YIlLuTjdxvOlzf1tPL+3Vij3Q8LcP6bSld45Km4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325054; c=relaxed/simple;
	bh=oAhMCY6P9oKdOY8vYZ1jETAkncLfLfgfyNisREtYVf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZvA6k5jT5G0mYh39rlbV5o3DjdUgEaUapaV4b8Q7Wh7co7yfUviqqg2/zVD6TeyudkUz0wrVC6p2nkIt5qT3+hVITmM0hmdXx9cnH9oJrcQA9m2oct5AoNnyH8JbbmqRA6Y5zYO3iY1Y8jm+SiiFaGF05zqzhU8id7/qghnz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9h3t2H6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9h3t2H6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782325052; x=1813861052;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oAhMCY6P9oKdOY8vYZ1jETAkncLfLfgfyNisREtYVf8=;
  b=f9h3t2H6j5EDg2L1H/0502DLkrV6czIkOKo8LZM41wTE+lbGMkOqMVY+
   dTHbJZ3JaLCBV1B6osR8O2uR/DN5DwfH26tpOjpZAjOIrIHXjskmDtvki
   pFBf0ajTwrDgWnTkcrD5CCezaf1ec51sXazeM2H52yrnm4WaJC+ovQ7b5
   5bNrh56pD4Np6UZRYBmid00rPHG7abssMSx4AxPE062uaoQtPQ2y+5MYD
   wyw4e1jCfd5w5lc/WskDPFeyN1bll3bRSbACxnanSMm7WcrlWUoZ0r9Sv
   aOse9SSAKsDx0hQI2u60eannkaaavfCg3QfuROAjoRT8+2f+4UYD7A6d1
   w==;
X-CSE-ConnectionGUID: I+kXC65MRBiHSnGVNPT58w==
X-CSE-MsgGUID: i+CIaJEhRYCqfB/zqrFyxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82978169"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="82978169"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 11:17:32 -0700
X-CSE-ConnectionGUID: WDk9beH6QZCm6D77DIpbfg==
X-CSE-MsgGUID: fnVysVRQRPKORxQ3uw2Wag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="250022773"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.227]) ([10.125.108.227])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 11:17:31 -0700
Message-ID: <fb9ecf71-518c-4aca-9438-b3394abe62b3@intel.com>
Date: Wed, 24 Jun 2026 11:17:29 -0700
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

