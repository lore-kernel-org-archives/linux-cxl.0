Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543C1D9694
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109427; cv=none; b=STtDP0+Xqgy8U2UNwVUz8rp/MuobsEkKJ0ZHyYrFbpMrqNVjNkKdtb00bIFOUEYDqzEVjzSZDHNMqn3cFOGVL5Df1C9a1I4zSILtCo6tCgq1t/pdM2ggjpx1JwN/nRy877jeSbtDeIybyZdAZzvcVFqLBEIh6qdp4Z7+DeLef64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109427; c=relaxed/simple;
	bh=i/nZZtn3ESX1B5/40/saRE43TNNM5C2OrClmdR4YHBw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBHsBac7kTS6M9gmpjGUDCYsfQ0dbDhTnICv1k5ZOtTgEwBIL4kHwVEsGFCTsHDXg38LMbXtgfNFOvbTXgbrcxe807uljSI+UdEgaFbV3qfCksdfBl4XvvEcV2904i2b5yQ8DetcTJp6M2R8iZ4ANJZTwzuZ7++e8kTMBt2U6W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZG6Q5Fm6z6HJhT;
	Fri, 17 Jan 2025 18:23:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F16101406AD;
	Fri, 17 Jan 2025 18:23:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 11:23:43 +0100
Date: Fri, 17 Jan 2025 10:23:42 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Alejandro
 Lucero <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/4] cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
Message-ID: <20250117102342.00007766@huawei.com>
In-Reply-To: <20250117102056.0000793f@huawei.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
	<173709423850.753996.572292628436250022.stgit@dwillia2-xfh.jf.intel.com>
	<20250117102056.0000793f@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 17 Jan 2025 10:20:56 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 16 Jan 2025 22:10:38 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > In preparation for consolidating all DPA partition information into an
> > array of DPA metadata, introduce helpers that hide the layout of the
> > current data. I.e. make the eventual replacement of ->ram_res,  
> > ->pmem_res, ->ram_perf, and ->pmem_perf with a new DPA metadata array a    
> > no-op for code paths that consume that information, and reduce the noise
> > of follow-on patches.
> > 
> > The end goal is to consolidate all DPA information in 'struct
> > cxl_dev_state', but for now the helpers just make it appear that all DPA
> > metadata is relative to @cxlds.
> > 
> > Note that a follow-on patch also cleans up the temporary placeholders of
> > @ram_res, and @pmem_res in the qos_class manipulation code,
> > cxl_dpa_alloc(), and cxl_mem_create_range_info().
> > 
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Alejandro Lucero <alucerop@amd.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> I'm not that keen on wrapping the size but not the base.
> Leads to some odd looking code in places.

I seems some of the code I didn't like goes away anyway later in the series.
So maybe it makes sense from a churn reduction point of view.
