Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8328C018
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547038; cv=none; b=NlckUhfsRcZ9fcTLH4Ni552XdFWq+VaJH8x24qzcifH4kDFTohqPKprcPLd4peQEPCxaAvAOfkxnO4Eva2NKrturFe6ZHe8QVWz2gz1Gsh3QHZsuOxcRrv6nd/TLVgR9xy4il2/6PFHkiA7x6DJHD/qEJMxGL2TDCqhe7h0keVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547038; c=relaxed/simple;
	bh=qonDtQhJAxGe1i/kjL1q3KI7OJrw5txvzO79CYcZn/0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VC5gUxiDiQfxZwJp/UAJwGSq8BcDZcaNOLHu5v5oGQ1mxDD0aZBwUr2I8GeVxj5iON8N7LYHPUz1bLidpZQiXQB40M7OUxWeoENmaZ4KrKdgSjBfYpEuGaBLnYjNBkoYPTJKSCwSEO4/8E6nq050B3i2KvIhzRm3oiJS18oBSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGjpp0PSzz6L7GZ;
	Tue, 10 Jun 2025 17:16:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A243A140525;
	Tue, 10 Jun 2025 17:17:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 11:17:12 +0200
Date: Tue, 10 Jun 2025 10:17:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, Itaru Kitayama <itaru.kitayama@linux.dev>,
	Dan Williams <dan.j.williams@intel.com>, Marc Herbert
	<marc.herbert@linux.intel.com>, Alison Schofield
	<alison.schofield@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl_test: Limit location for fake CFMWS to mappable
 range
Message-ID: <20250610101710.000008b7@huawei.com>
In-Reply-To: <8b53e8e1-8b9f-4db5-952f-0a961942dfeb@intel.com>
References: <20250527153451.82858-1-Jonathan.Cameron@huawei.com>
	<8b53e8e1-8b9f-4db5-952f-0a961942dfeb@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 9 Jun 2025 10:25:41 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 5/27/25 8:34 AM, Jonathan Cameron wrote:
> > Some architectures (e.g. arm64) only support memory hotplug operations on
> > a restricted set of physical addresses. This applies even when we are
> > faking some CXL fixed memory windows for the purposes of cxl_test.
> > That range can be queried with mhp_get_pluggable_range(true). Use the
> > minimum of that the top of that range and iomem_resource.end to establish
> > the 64GiB region used by cxl_test.
> > 
> > From thread #2 which was related to the issue in #1.
> > 
> > Link: https://lore.kernel.org/linux-cxl/20250522145622.00002633@huawei.com/ #2
> > Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
> > Closes: https://github.com/pmem/ndctl/issues/278 #1
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com <mailto:itaru.kitayama@fujitsu.com>
> > Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Applied to cxl/next
> 
> Added the config check from Alison
Thanks. Was about to send v2 but this is quicker ;)


> 
> > 
> > ---
> > I haven't given this a fixes tag because it never worked on arm64.
> > So it isn't a regression fix, and I'm not sure we want to back port this
> > which a fixes tag might well trigger.  If people want one shout and I'll
> > try and figure out what is appropriate.
> > ---
> >  tools/testing/cxl/test/cxl.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 8a5815ca870d..6a25cca5636f 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -2,6 +2,7 @@
> >  // Copyright(c) 2021 Intel Corporation. All rights reserved.
> >  
> >  #include <linux/platform_device.h>
> > +#include <linux/memory_hotplug.h>
> >  #include <linux/genalloc.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > @@ -1328,6 +1329,7 @@ static int cxl_mem_init(void)
> >  static __init int cxl_test_init(void)
> >  {
> >  	int rc, i;
> > +	struct range mappable;
> >  
> >  	cxl_acpi_test();
> >  	cxl_core_test();
> > @@ -1342,8 +1344,11 @@ static __init int cxl_test_init(void)
> >  		rc = -ENOMEM;
> >  		goto err_gen_pool_create;
> >  	}
> > +	mappable = mhp_get_pluggable_range(true);
> >  
> > -	rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
> > +	rc = gen_pool_add(cxl_mock_pool,
> > +			  min(iomem_resource.end + 1 - SZ_64G,
> > +			      mappable.end + 1 - SZ_64G),
> >  			  SZ_64G, NUMA_NO_NODE);
> >  	if (rc)
> >  		goto err_gen_pool_add;  
> 
> 

