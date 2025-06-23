Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5C1AA1DA;
	Mon, 23 Jun 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676403; cv=none; b=nRB03B83aGbht3HXh0PZvcwJHLgB/23stWMRMKmDmZqB2m0g+dw9AcMswzvtxxezQdQZMNshxqcSkeKfA+TK4VkXH4Ob/KzwHNAhNOVi/LImULEJlZ7dAEbGCG6vrXsaNa9iT4iCgBCdD4NM0OTbXjevWABcCJXtzvrSniK//iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676403; c=relaxed/simple;
	bh=qDokKc/d+8ogqph9zuLiu0qSyFYefdaicmpI6ptI2d8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uA6mz2/4UcVe/rlSbKMfK4g38TLFN5IrAe6tRq5PrmAD2oK+yeXCNaSO6nXpAYZPIOeXrEgueVBXcaxcoDQTi5aAlkSvcXdLpeGfGU3siC6/43DUdusOvRVZd++QCRyvuMotftU8JTDsBUlthhhvRFJ086rI59ORqmJVsjnNP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bQlR03FnGz6HJtd;
	Mon, 23 Jun 2025 18:57:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C3AB140277;
	Mon, 23 Jun 2025 18:59:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Jun
 2025 12:59:58 +0200
Date: Mon, 23 Jun 2025 11:59:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH v2 5/8] cxl/region: Split commit_store() into __commit()
 and queue_reset() helpers
Message-ID: <20250623115957.000017c0@huawei.com>
In-Reply-To: <20250619050416.782871-6-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
	<20250619050416.782871-6-dan.j.williams@intel.com>
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

On Wed, 18 Jun 2025 22:04:13 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The complexity of dropping the lock is removed in favor of splitting commit
> operations to a helper, and leaving all the complexities of "decommit" for
> commit_store() to coordinate the different locking contexts.
> 
> The CPU cache-invalidation in the decommit path is solely handled now by
> cxl_region_decode_reset(). Previously the CPU caches were being needlessly
> flushed twice in the decommit path where the first flush had no guarantee
> that the memory would not be immediately re-dirtied.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Seems fine
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
