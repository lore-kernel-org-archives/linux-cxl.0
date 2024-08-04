Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03405A953;
	Sun,  4 Aug 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722789122; cv=none; b=TKShsQ3Lb3uuU2NSFG/xo1knkCTd3XY8EiD7hpIFiw5bHkL8sx+puDt5nhYSK4wiCppyQR6Uunqo6Oo0W9GxtajUMGGfyIJp3JEqUybAuQ18gTEmYMFgKiTnyQ6EBp1BaoDbV4xJ+/rkESXDOBMJwvLCF6lSub9cczjaoBTTv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722789122; c=relaxed/simple;
	bh=TOs3UWLy0Lu8sgCd+gyy/2im+23EwPxKUvvaQxP9lQw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3+HAZDAaaFIVm+bCOovdWCWpUNvOQcABXRECqMEHf/UrIlGfO8PucfLSK1Y38Lq5Z/asyYV2kobczTuh6ZqHC1Kp8DIeqvbBxQUA4jMKN28mKqO2b8NeDU3FHVt106Z68pRloZl1L9yPEQPKJsQwFAK2f/OT3KZNPGl9IoCLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcQ4r6KV9z6K91r;
	Mon,  5 Aug 2024 00:29:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 710091401DC;
	Mon,  5 Aug 2024 00:31:57 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 17:31:56 +0100
Date: Sun, 4 Aug 2024 17:31:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH 2/3] cxl: Set target type of region with that of root
 decoder
Message-ID: <20240804173141.00007931@Huawei.com>
In-Reply-To: <87o76ckb88.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240729084611.502889-1-ying.huang@intel.com>
	<20240729084611.502889-3-ying.huang@intel.com>
	<ZqrmeC8nKVR3Tksz@aschofie-mobl2>
	<87o76ckb88.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 01 Aug 2024 14:28:55 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> Alison Schofield <alison.schofield@intel.com> writes:
> 
> > On Mon, Jul 29, 2024 at 04:46:10PM +0800, Ying Huang wrote:  
> >> Now, the target type of region is hard-coded to HOSTONLYMEM, because
> >> only type3 expanders are supported.  To support type2 accelerators,
> >> set the target type of region root decoder with that of the root
> >> decoder.  
> >
> > Hi Ying,
> >
> > If the target type of a region is always the same as it's root decoder,
> > (is it?)  
> 
> IIUC, it is.  Do you know when they may be different?

Root decoder (CFMW I think) allows both and target device only one.

More likely when it's HDM-DB / HDM-H though I think than
HDM-D / HDM-H.  A host would do this because it has simple
address routing (maybe a single root complex) and doesn't
want to pay the HPA space cost of providing separate regions,
so decisions on protocol etc derived from RC HDM decoder
programming, not the fixed bit in in the host.

Note for those not so buried in CXL terms, HDM-DB includes back
invalidate memory devices (for P2P or hardware coherent sharing),
HDM-H is simpler memory devices that don't support back invalidate.

Jonathan


> 
> > why do we store it as an attribute of the region. Can we look
> > it up when needed?  
> 
> Yes.  This is possible via to_cxl_root_decoder().  It's just
> a little inconvenient.
> 
> > A bit more below -
> >  
> >> 
> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Davidlohr Bueso <dave@stgolabs.net>
> >> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> >> Cc: Dave Jiang <dave.jiang@intel.com>
> >> Cc: Alison Schofield <alison.schofield@intel.com>
> >> Cc: Vishal Verma <vishal.l.verma@intel.com>
> >> Cc: Ira Weiny <ira.weiny@intel.com>
> >> Cc: Alejandro Lucero <alucerop@amd.com>
> >> ---
> >>  drivers/cxl/core/region.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 21ad5f242875..9a483c8a32fd 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -2545,7 +2545,8 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> >>  		return ERR_PTR(-EBUSY);
> >>  	}
> >>  
> >> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
> >> +	return devm_cxl_add_region(cxlrd, id, mode,
> >> +				   cxlrd->cxlsd.cxld.target_type);
> >>  }  
> >
> > Passing the 'cxlrd' and then a piece of the cxlrd (.target_type) looks
> > redundant.  
> 
> Yes.  We can remove the parameter.  Will change this if we still need
> cxlr->type.  Thanks!
> 
> --
> Best Regards,
> Huang, Ying
> 
> >
> > -- Alison
> >  
> >>  
> >>  static ssize_t create_pmem_region_store(struct device *dev,
> >> -- 
> >> 2.39.2
> >>   
> 
> 

