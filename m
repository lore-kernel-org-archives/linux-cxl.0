Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344921A19;
	Thu, 20 Jun 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881861; cv=none; b=nQfR5MvQtJ8YSPBcjeADQ3twvg2ngXPYo3wZHvvLrhWM8ZicMZS9PPbIek0ml+Wvhij3JGi2Ed0Yr236KcQEWFsfwvij+4FxqR7NeaCTTskdGfUyAh+cq8A15sqjd/0D3uexJFYFvEMJHUApSNstB0Cf/qYIYabx40lmqPpqVZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881861; c=relaxed/simple;
	bh=oAJ1pIuzNb7mCEYBEZI8DX7Yo/eyUY8sZrVK2CeKW+A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTeyaP/PzYUDdnKlVE6nYt5H1ZNGJi1mMRenaXtE3N2A/Fru/Y2rvl2S18rMz/XN0T352JU33SBNXmw1vIDfW7yq00Lywuw1CsskP+odVodCrX3LZf4dv5sJvcprA6/sDasccByJFrKZZTHWsj4Dkqqt6Y9a3ZbeB/AX/5VsHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4d8F1wX3z6JBHw;
	Thu, 20 Jun 2024 19:10:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EFD3214058E;
	Thu, 20 Jun 2024 19:10:54 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 12:10:54 +0100
Date: Thu, 20 Jun 2024 12:10:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huang Ying <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
	Bharata B Rao <bharata@amd.com>, Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH v3 1/3] cxl/region: Fix a race condition in memory
 hotplug notifier
Message-ID: <20240620121053.00002bed@Huawei.com>
In-Reply-To: <20240618084639.1419629-2-ying.huang@intel.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
	<20240618084639.1419629-2-ying.huang@intel.com>
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

On Tue, 18 Jun 2024 16:46:37 +0800
Huang Ying <ying.huang@intel.com> wrote:

> In the memory hotplug notifier function of the CXL region,
> cxl_region_perf_attrs_callback(), the node ID is obtained by checking
> the host address range of the region. However, the address range
> information is not available when the region is registered in
> devm_cxl_add_region(). Additionally, this information may be removed
> or added under the protection of cxl_region_rwsem during runtime. If
> the memory notifier is called for nodes other than that backed by the
> region, a race condition may occur, potentially leading to a NULL
> dereference or an invalid address range.
> 
> The race condition is addressed by checking the availability of the
> address range information under the protection of cxl_region_rwsem. To
> enhance code readability and use guard(), the relevant code has been
> moved into a newly added function: cxl_region_nid().
> 
> Fixes: 067353a46d8c ("cxl/region: Add memory hotplug notifier for cxl region")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Looks good to me and matches similar cases.  Thanks for the detailed patch
description btw

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
