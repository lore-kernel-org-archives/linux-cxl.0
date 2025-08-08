Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E579CD
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669187; cv=none; b=FXHnqFP+nkHBTkt3wdReEwPv8mIxd7zcP1BSvcPql2IaUyq3EZBlDSkTuGiE0QdLWxcdfyWo/a6rUMQ94l0dqU/ULsaKNnh9pITPAtElvqWKVnpn5uAMke+s0skGS4JCzYGlMuTGT9UEVWD2E6JMwtuBskRf4fY67D5wOc+cXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669187; c=relaxed/simple;
	bh=r8WbQ2KEeYe1/lTcMARKKkFGhIp0j9EZkY2fioGrUYc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3eqkXwj9vv4Ckps29QwreRwyyCXT7EyZBk7snIvZ0MKyRSseZXPvT/0dYSQZyi5FuDgpIItrKOE3bbW4nMdQRIHm+C6dBdSBHO+EltcFzvCSOmF/35DKbMH6yDiJCXTydxjJdi6TpaZkcixbSsk59XxhYFyIVAKjdEFbDC6vK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz80k1Cl8z6L50q;
	Sat,  9 Aug 2025 00:01:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F6DD14027A;
	Sat,  9 Aug 2025 00:06:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 18:06:20 +0200
Date: Fri, 8 Aug 2025 17:06:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/acpi: Limit XOR map application based on host
 bridge ways
Message-ID: <20250808170619.00003c63@huawei.com>
In-Reply-To: <ea832391-3ec1-46db-ae2a-7870074c7179@intel.com>
References: <20250804082357.2590809-1-alison.schofield@intel.com>
	<ea832391-3ec1-46db-ae2a-7870074c7179@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 6 Aug 2025 14:46:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 8/4/25 1:23 AM, alison.schofield@intel.com wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The CXL specification defines one set of XOR maps per Host Bridge
> > Interleave Granularity (HBIG), but the number of maps to apply
> > depends on the Host Bridge Interleave Ways (HBIW) for each region.
> > 
> > Currently, cxl_xor_hpa_to_spa() incorrectly applies all available
> > XOR maps regardless of the region's host bridge interleave ways.
> > This causes incorrect address translations when multiple CXL regions
> > with the same HBIG but different HBIW's coexist.
> > 
> > Example scenario with 3 XOR maps defined for 256-byte granularity:
> > - 4-way interleave region:  should apply 2 maps (was applying 3)
> > - 8-way interleave region:  should apply 3 maps (correct)
> > - 12-way interleave region: should apply 2 maps (was applying 3)
> > 
> > Per CXL 3.2 Section 9.18.1.4 and Table 9-22, fix this by using
> > a lookup table to determine the correct number of XOR maps based
> > on host bridge interleave ways.
> > 
> > Fixes: 3b2fedcd75e3 ("cxl: Restore XOR'd position bits during address translation")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
