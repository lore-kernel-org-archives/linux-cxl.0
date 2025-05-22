Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8430235058
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 09:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905515; cv=none; b=csrhLsBrnV8ReZqTJ3h73b1mA7ixmxs767uUo4Am7pfhIVxg482pmoC3+B9ZCl5aYZR3og9ncMq1C3gxgnbkSsflxwNFBA+75nO27LPIZPPq1unVMqUhjTwUBuLVeWl2AEtb9Byq+KBzAHokjWQIdmULd7/JEXjkLiJ2JMoQ9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905515; c=relaxed/simple;
	bh=8vkLJCvWVD+CZ8cqkZA41BasMOuBE8H/saLfYtEA46U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ug/IwQfmHLSPCL2xg3YvijGm8RTFXdKoKJGfrvSAuYEmw8eKUm1N8dG4cog7Es/10+IFYkwu5t8F+dsU3u8L/y4G0sVdrHCGi6qIBgJ8Sj+ar4MfIQ4wRVK8+WCpLo/Il4pfZ6JDvgrphq9T+CEc1neFE61otzrySPb7/2hJe84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b32gm1MJhz6DL1Y;
	Thu, 22 May 2025 17:15:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C6E314020A;
	Thu, 22 May 2025 17:18:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 11:18:29 +0200
Date: Thu, 22 May 2025 10:18:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonsathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/9] cxl: Add helper to detect top of CXL device
 topology
Message-ID: <20250522101827.000012c8@huawei.com>
In-Reply-To: <58d89978-122f-4c79-ba04-98a1ec6e4418@intel.com>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
	<20250521183443.3828320-3-dave.jiang@intel.com>
	<58d89978-122f-4c79-ba04-98a1ec6e4418@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 11:39:29 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 5/21/25 11:34 AM, Dave Jiang wrote:
> > Add a helper to replace the open code detection of CXL device hierarchy
> > root. The helper will be used for delayed hostbridge port creation later
> > on.
> > 
> > Reviewed-by: Jonathan Cameron <Jonsathan.Cameron@huawei.com>  
> 
> I'll fix the email address. :)

One day I'll grow up and learn to spell my own name ;)
Thanks!

J
(playing is safe :)

> DJ
> 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  drivers/cxl/core/port.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 726bd4a7de27..cafb1b13cba1 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -39,6 +39,15 @@ DECLARE_RWSEM(cxl_region_rwsem);
> >  static DEFINE_IDA(cxl_port_ida);
> >  static DEFINE_XARRAY(cxl_root_buses);
> >  
> > +/*
> > + * The terminal device in PCI is NULL and @platform_bus
> > + * for platform devices (for cxl_test)
> > + */
> > +static bool is_cxl_hierarchy_head(struct device *dev)
> > +{
> > +	return (!dev || dev == &platform_bus);
> > +}
> > +
> >  int cxl_num_decoders_committed(struct cxl_port *port)
> >  {
> >  	lockdep_assert_held(&cxl_region_rwsem);
> > @@ -1642,11 +1651,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> >  		struct device *uport_dev;
> >  		struct cxl_dport *dport;
> >  
> > -		/*
> > -		 * The terminal "grandparent" in PCI is NULL and @platform_bus
> > -		 * for platform devices
> > -		 */
> > -		if (!dport_dev || dport_dev == &platform_bus)
> > +		if (is_cxl_hierarchy_head(dport_dev))
> >  			return 0;
> >  
> >  		uport_dev = dport_dev->parent;  
> 
> 
> 

