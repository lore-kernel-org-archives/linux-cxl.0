Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FA288A2
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647355; cv=none; b=qPYEG5EpIpAJSZ3NKu0JMw3prCqeCneVgn+fe1QkQVgYDfFBwTdgeJJ3LaCzbT/uBKCvX/7DSLHnBrm+Rq+2E53Ii8JO0Qts0nU4gVniSkUmvs6ETLTEVlUE3RcoCqgdSvqBUWm0gsqwIJADP3cUyrJHhpVeu0s0wzhf4a78MOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647355; c=relaxed/simple;
	bh=oaioe1KW8RpsxiMF66YDI20v2xdTL0Jzk3AYWhTJS5g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaRmwazBBHflc0agMIHU4l6UnewqZrcwMtBMCqsfYQ/L/1jZUeurrLuP6SRdztjrLQ+hOY3AMmWj3kKVbFkRf0Z5pZl0f+PGHCNGYqmum2t2AhUAH3ZDYY97cuvbMHcsOdIdTwRouURAjg5hHhzt4Wg+/6ATUYuONLy9t44ijQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf50q5b96z6L50g;
	Thu, 23 Jan 2025 23:47:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0636C140A70;
	Thu, 23 Jan 2025 23:49:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 16:49:03 +0100
Date: Thu, 23 Jan 2025 15:49:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH v2 1/5] cxl: Remove the CXL_DECODER_MIXED mistake
Message-ID: <20250123154902.00000c4b@huawei.com>
In-Reply-To: <173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
	<173753635601.3849855.5582594127330525596.stgit@dwillia2-xfh.jf.intel.com>
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

On Wed, 22 Jan 2025 00:59:16 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL_DECODER_MIXED is a safety mechanism introduced for the case where
> platform firmware has programmed an endpoint decoder that straddles a
> DPA partition boundary. While the kernel is careful to only allocate DPA
> capacity within a single partition there is no guarantee that platform
> firmware, or anything that touched the device before the current kernel,
> gets that right.
> 
> However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
> designation because of the way it tracks partition boundaries. A
> request_resource() that spans ->ram_res and ->pmem_res fails with the
> following signature:
> 
>     __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation
> 
> CXL_DECODER_MIXED is dead defensive programming after the driver has
> already given up on the device. It has never offered any protection in
> practice, just delete it.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
