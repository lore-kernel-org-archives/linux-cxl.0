Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D83EDAD9
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229499; cv=none; b=jnTxwfiu0Ohg8pId87LY0GngVVyzIAJJcfYr7vmztp50fH0aahBUp/XNdDP7SXBzLPfCzxhDOQmoxIFucEb6/boIbOTzeYLP+emxwx5HRETZjK4r6ANeJmkiQYpaCxBvEmd2/ApcswTbzs+36WTLUsn9Ji+N4EOBQct1SUK3FK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229499; c=relaxed/simple;
	bh=Rs0jsx+cxOkk7GGZyKL1W8MVPbJUnzoFIJuqfSwL9PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f64TLQe/IqxFW0hajtZHTGEBr/4A1fyeSqF9ioZZfvkgYCj1KfZ5blRjnS6xyiAidqvkHefoiKYsiuoTJcutNsCFsTdVDpNrl/w/UISYgYt2QiFvjjPzLT/uJN1e7b0M3vq25/icZGgKdAYNU+YzWftrIMO82eg3sFTaiKFcxkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6Sb3akt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6Sb3akt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779229498; x=1810765498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rs0jsx+cxOkk7GGZyKL1W8MVPbJUnzoFIJuqfSwL9PQ=;
  b=P6Sb3aktx/5cGPfHjaHg5cZ+MJZPGT0W/UU1/3Xr+AlVgAzPmAuESWFt
   EU3mWAk9F/7XqhUk4DPW86GRJnD9n+hkS4SFq6gcLH7N5SxgOT3sejVj0
   mDIMlZNkl/fld36MgO9teLif+X6vOJ4dIqbNokc24XGRXFp8RxPNwwxyg
   N7qsiFjZYraAQWH/TI3UR/GYSd3gFUNMGkjB9LfkuP+TJfNj7ecLMMFqT
   SnpqIHq/oabmFPDF7eooja0dJeJ1tEbQbAevWsmtANQ6zrVloJ0ITBPPG
   mu+Y0TKstZ9rV1vLpxecHe9jIWrx3JghPsa03YZUkRanoLxl8kINd15gA
   A==;
X-CSE-ConnectionGUID: jeVQ86NjQp2HHmyPjbtQvA==
X-CSE-MsgGUID: FWldy+9xRTGWmKLR5Z1paA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="83976947"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83976947"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:24:58 -0700
X-CSE-ConnectionGUID: WBU1Nr3FSH+G1g8W8EIqoQ==
X-CSE-MsgGUID: 9G48p4aIRJKDh8OxshgZvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="278032313"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.143]) ([10.125.109.143])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:24:58 -0700
Message-ID: <fd7fbb4a-3deb-4d90-9ca4-15a14368effc@intel.com>
Date: Tue, 19 May 2026 15:24:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cxl/memdev: Pin parents for entire memdev lifetime
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, jic23@kernel.org
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-4-djbw@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519210158.1499795-4-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 2:01 PM, Dan Williams wrote:
> In order to be able to manage the driver that uses a memdev attach
> mechanism the parent needs to stick around for the
> device_release_driver(cxlmd->dev.parent) event.
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Maybe a comment above get_device() to make note of why we are taking the reference.

> ---
>  drivers/cxl/core/memdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 80e65690eb77..91c99eeea92c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -25,9 +25,11 @@ static DEFINE_IDA(cxl_memdev_ida);
>  static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct device *parent = dev->parent;
>  
>  	ida_free(&cxl_memdev_ida, cxlmd->id);
>  	kfree(cxlmd);
> +	put_device(parent);
>  }
>  
>  static char *cxl_memdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
> @@ -707,7 +709,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev = &cxlmd->dev;
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_memdev_key);
> -	dev->parent = cxlds->dev;
> +	dev->parent = get_device(cxlds->dev);
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>  	dev->type = &cxl_memdev_type;

