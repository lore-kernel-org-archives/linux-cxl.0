Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D81B3738
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112338; cv=none; b=Lq4Ka5RnjWpVOwxcF65Le95EuaPKxCBRfd+IOVkNCSrCnMX3wcGRAoNdCRci9TnIQEn50nzLlWWyBkxyMN8W3B6WJRuYixIpq8+jBqwfkE4u6BGc/x2ld87THgRq8VkhwJNbTAzBCqAd+f0HWwkRpXEGKCSP/mHnL8NzP8fg/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112338; c=relaxed/simple;
	bh=9H5rU0DL8/eCy/eAJRNVDe82kcFpS8Z1dU3f5+NN1do=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWsf2S/L5k1q0iYHd8+tt/mhsmtjoiVYVZbWguXmV9JF89cUYrB/byE7Tyy45SsnV11JNS63awlPz0Qoc7A/8q4FyvqcI9Veb609Fd32oNFejM7M41p3nmrvmD/mhYpjVGINwnhSvJMhfEzvZKvvpPcjJsQ9Zr9YlvJGTSN66nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFN9572n8z6K9HL;
	Fri,  5 Jul 2024 00:56:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 68BE1140C98;
	Fri,  5 Jul 2024 00:58:52 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 17:58:47 +0100
Date: Thu, 4 Jul 2024 17:58:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Adam Manzanares <a.manzanares@samsung.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2] Documentation: CXL Maturity Map
Message-ID: <20240704175846.000061d0@Huawei.com>
In-Reply-To: <172005486862.2048248.6668794717827294862.stgit@dwillia2-xfh.jf.intel.com>
References: <172005486862.2048248.6668794717827294862.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 03 Jul 2024 18:01:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Provide a survey of the work-in-progress maturity (implementation
> status) of various aspects of the CXL subsystem.
> 
> Clarify that in addition to ongoing upkeep relative to specification
> updates, there are some long running themes in the driver that respond
> to the discovery of new corner cases (bugs) and new use cases (feature
> extensions).
> 
> The primary audience is distribution maintainers, but it also serves as
> a guide for kernel developers to understand what aspects of the CXL
> subsystem need more help. It is a landing page to document ongoing
> progress, and a guide to discern exposure to work-in-progress features.
> 
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Seems like a useful document, so if we can sneak it in for 6.11 that would
be great.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
