Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA6028F52E;
	Mon, 14 Apr 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640402; cv=none; b=ij06P4udHjL7ZnYNs7888ALoZ9mHZUmFwlfz2UxPKTv2t1TRMkk9KZfPN6fS8POdpxyZG8reHo4kklVH5YmqKnkkSyfAksg4c0jmyVhrjyb8PEkkF6gBKD05jICS4520OI0g/tSpTDGIJDVqYDHjuRE42Wp7ykWHiZgwo67ZGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640402; c=relaxed/simple;
	bh=CwaFplckSD7S0EpcNcWb7VUupSTqyxxJFgfu202ina4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2zKKUQBpQNNzdr6zSrVLahx5xmRweyLCP1t9l1y3RVtXrQr56HD14TSxCNvu+5OWyDHXOPRFYZ0XkMBM7Ne2vayvQFu+Y0Iqq8uB0Qm3nRitQ5dlRziP9Kvb0ClGskSEu9IA8rckT+iEo0eiVBWLCv5oP4tdXO9Yw/CmsKXrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZbqCK2SXpz6F94p;
	Mon, 14 Apr 2025 22:18:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 489C61402EA;
	Mon, 14 Apr 2025 22:19:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Apr
 2025 16:19:51 +0200
Date: Mon, 14 Apr 2025 15:19:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/19] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <20250414151950.00001823@huawei.com>
In-Reply-To: <20250413-dcd-type2-upstream-v9-1-1d4911a0b365@intel.com>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
	<20250413-dcd-type2-upstream-v9-1-1d4911a0b365@intel.com>
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

On Sun, 13 Apr 2025 17:52:09 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Per the CXL 3.1 specification software must check the Command Effects
> Log (CEL) for dynamic capacity command support.
> 
> Detect support for the DCD commands while reading the CEL, including:
> 
> 	Get DC Config
> 	Get DC Extent List
> 	Add DC Response
> 	Release DC
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>


> +
> +static bool cxl_verify_dcd_cmds(struct cxl_memdev_state *mds, unsigned long *cmds_seen)

It's not immediately obvious to me what the right behavior
from something called cxl_verify_dcd_cmds() is.  A comment might help with that.

I think all it does right now is check if any bits are set. In my head
it was going to check that all bits needed for a useful implementation were
set. I did have to go check what a 'logical and' of a bitmap was defined as
because that bit of the bitmap_and() return value wasn't obvious to me either!


> +{
> +	DECLARE_BITMAP(all_cmds, CXL_DCD_ENABLED_MAX);
> +	DECLARE_BITMAP(dst, CXL_DCD_ENABLED_MAX);
> +
> +	bitmap_fill(all_cmds, CXL_DCD_ENABLED_MAX);
> +	return bitmap_and(dst, cmds_seen, all_cmds, CXL_DCD_ENABLED_MAX);
> +}
> +


