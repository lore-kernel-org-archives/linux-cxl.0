Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49021A0A
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816533; cv=none; b=t2jrNQSZgDF21/XjRvyc93PTlnc1gNM0IYf44qrJo9xMhU7NpTRvuXvlwGTR/Np4HjYRWTRfNBTFU6qKVcESSuSGRJLPDB8Wq9zlgcgXqNpiZsOETz+KFjTwit4cokhPXHELTXcauQ6vN11+J2Lwxfwp8rnBb7XfYpe84WzL630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816533; c=relaxed/simple;
	bh=+4qEPvim9JK6YdW3eyI59DBRxBU0+KQAIzGZdepKGng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anzpySwkOAzUU0n0HEayfb0iUC9BdhxmxQo54eCT9bBLquInMFy20nTyDbrkCe3AAOUSxKnVUk/+ilWokfKEBm+IVyeVQX+ak0zCmn0q/P3qo7sTrJz8hQgmaBfuw2+05U1FKEbpyaNz3P0SSRYMv/PO9EJTb0Hy6ozzuX7lE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYwsJ2dmBz6F95J;
	Tue, 13 Feb 2024 17:25:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BF391140D1D;
	Tue, 13 Feb 2024 17:28:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 09:28:45 +0000
Date: Tue, 13 Feb 2024 09:28:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 5/9] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240213092845.00000dfc@Huawei.com>
In-Reply-To: <ZcKxpFWe5v5YkJqb@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-6-nifan.cxl@gmail.com>
	<20240124154721.0000451d@Huawei.com>
	<ZcKxpFWe5v5YkJqb@debian>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> > >      *cdat_table = g_steal_pointer(&table);
> > > @@ -445,11 +492,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> > >              range2_size_hi = ct3d->hostpmem->size >> 32;
> > >              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > >                               (ct3d->hostpmem->size & 0xF0000000);
> > > +        } else if (ct3d->dc.host_dc) {
> > > +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> > > +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > > +                             (ct3d->dc.host_dc->size & 0xF0000000);  
> > 
> > I've forgotten if we came to a conclusion on whether these should include
> > DC or not...  My gut feeling is no because we don't know what to do
> > if they are both already in use.
> >   
> 
> QUESTION:
> 
> If we do not include DC, and there is no static ram/pmem capacity and
> only dynamic capacity, then the range registers will not be set, is that
> what we want?

I think that's a valid interpretation of the specification.
So for now go with that.

p.s. Sorry for slow response.  Debugging had me distracted from catching
up with the list.
