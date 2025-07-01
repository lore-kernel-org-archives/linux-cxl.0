Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BF2797A3;
	Tue,  1 Jul 2025 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382225; cv=none; b=lGFgZQsPRUj3G9nqNVK1gLQm56mu1Jkf5LJtb5MH568CrOeICDIRbpXd8+IZtdtk/UcvEoFmaSr1SdTO/KBTU6tvDHgeu573PXEJPrGkWM0ow+MCOFzV8+JqJpEo+jbGagywJmUXutA8HGQuIuSd33fOWaWpfhwKnA/mjKmAom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382225; c=relaxed/simple;
	bh=wvgk5dwecM5rZFQD0mJEqNcqe43fEIoyqLJ+pQIsxGo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeTXKSqf1O+6ZLHbUqGY6EQCzHomJmR1XfyrheH/hfLo/v902z01ea0M38YlCuUbrxn3/vI25YpQgGLhEe9cIuZ+xRZZfchmRm3YiC6kxQvFAXD07eIsLSGy5kLI2tasp26oKNAMgIr7jrSlUAND5C4ChKkuzT4zlhOA2Tsxd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWmVH3n9Kz6M4rX;
	Tue,  1 Jul 2025 23:02:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C04B614027A;
	Tue,  1 Jul 2025 23:03:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 17:03:41 +0200
Date: Tue, 1 Jul 2025 16:03:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Include range.h in cxl.h
Message-ID: <20250701160339.000042f5@huawei.com>
In-Reply-To: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
References: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 01 Jul 2025 07:33:31 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> After commit aefeb286b960 ("libnvdimm: Don't use "proxy" headers"),
> range.h may not be implicitly included, resulting in a build error:
> 
>   In file included from drivers/cxl/core/features.c:8:
>   drivers/cxl/cxl.h:365:22: error: field 'hpa_range' has incomplete type
>     365 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:562:22: error: field 'hpa_range' has incomplete type
>     562 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:570:22: error: field 'hpa_range' has incomplete type
>     570 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:803:22: error: array type has incomplete element type 'struct range'
>     803 |         struct range dvsec_range[2];
>         |                      ^~~~~~~~~~~
> 
> Include range.h in cxl.h explicitly to clear up the errors.
> 
> Fixes: aefeb286b960 ("libnvdimm: Don't use "proxy" headers")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
