Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2B3ECBE5
	for <linux-cxl@vger.kernel.org>; Fri, 29 May 2026 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072757; cv=none; b=mo6Wx/fQPKx7ZpQ1tiIEqIHkZ9JeFTZnhpZ5CaVIsPhlS0U3GzPbhNlng/Js4Oovmx+tfr3aOl6u7ld0BMe5v+e4TYD4XUaeWYsUhHNQFWb5uDpo5EVZdsLGuI7kEDFnTZ9m5sUchDCJgHsWZjM94VKa1+68IUVCpEYOg0aFUMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072757; c=relaxed/simple;
	bh=rUCtVOzrXe4mJeFX5QjeoRb+rGoEXU6s0WomONT7Ln8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z5Lz/nPnhDwjVYQ1zcJKKkSiu/qIKuXj6+5NRbY5VY77O9lngPG74+8FnhPA2MGUr4z3fp101b+8J+JvuLYX4ioIV5LDhRafSimUUFkQquNGroX3dc2pzxUGY9i335ud1D1JwCg/WKy8YYulsxawbYMWRzKqo0e9oDXuvfKY1I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgFyUoE+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgFyUoE+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780072755; x=1811608755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rUCtVOzrXe4mJeFX5QjeoRb+rGoEXU6s0WomONT7Ln8=;
  b=PgFyUoE+lGWvU7p7HxDYXxVIRcDJhKUEJ6iNsCq0BcO4wKEd5btuspYb
   U/ftke0W/775mPhdgv6sfwL5vhEZmVYw9sn6JWloDYGsjcUsRNtWFrmMI
   N3OdL6exKx5brgvWHQ7nQ8HeIRxblQwSW2a8vBwWDC6l/xLy20+V3I8Nz
   3fHv/F62WyYrYjHeP/r1nNLtl0noii281WQOsq+JyalRI+QgjZNhkZpBb
   RcvMj3ERWkF9xuxPrZwF/48Ik/kf5e+Cp8zJNtULWZzcBiakYLbdv9gAM
   cN197fk1Hj8ycMWYSSasKmlyT05pJyTLB25SCM/pWwyrAi85MRsDrBIUZ
   A==;
X-CSE-ConnectionGUID: G367ksF/T6et+opm6VuQuA==
X-CSE-MsgGUID: jwRAxGW6QCWuVJhaPTLUyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80780816"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80780816"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 09:39:15 -0700
X-CSE-ConnectionGUID: 9fqlcfzzRYWk5pJEynW1lQ==
X-CSE-MsgGUID: VJWArX4HTBmXUyxRxXOMKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="244726103"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.151]) ([10.125.111.151])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 09:39:14 -0700
Message-ID: <ceeeb996-bf83-4562-9197-ac833f1b9dbf@intel.com>
Date: Fri, 29 May 2026 09:39:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add CXL reviewer
To: Alison Schofield <alison.schofield@intel.com>,
 Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org
References: <20260527001305.533170-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260527001305.533170-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/26/26 5:13 PM, Alison Schofield wrote:
> Add Li Ming as CXL subsystem reviewer.
> 
> Thanks to Li Ming for all the CXL bugs they've found and fixed,
> and looking forward to many more prevented!
> 
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next
43ad501987391948f41e72212eaee03a948f441c

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..992e1fa57b72 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6428,6 +6428,7 @@ M:	Alison Schofield <alison.schofield@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
>  M:	Dan Williams <djbw@kernel.org>
> +R:	Li Ming <ming.li@zohomail.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/driver-api/cxl

