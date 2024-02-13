Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4071C68E
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816588; cv=none; b=hHT97VXaKhIbNteQ/NQ2kfBwXhJ9WqgJFzx/gxY6uYIl1Vl3TiVitpwHVvJdbIiPsJlDM83zkO9XK+Msl9CNTT/opQjPUtcaeNcwCyKBjLn8kKKsbp1B+100ds6keie1HSMKp1X4Q0X8UCD699FpC9EKXnL3OWdL8fleIv83pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816588; c=relaxed/simple;
	bh=RlWRUJGCKUEjHfz6nJxQVTvWJnk4rKKpqr1zzladaSk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pfz96KXNvruaZ2rcHuXi+yNb+VZ2I2GQaxJBPXznQCkIJNcPL/Hjo14HTob3eM5UryC8gs1aLfqdfxsdzFJFoi4VYLEdlFvyUFMz+MOReVnj9+vzDftr1hCAJObHcFOuJj8B6sL5XH/4k3TCyYzHFiSR+UJRm6r+hqP7vIhGHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYwt24f3xz6J9vB;
	Tue, 13 Feb 2024 17:25:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EA8F714163D;
	Tue, 13 Feb 2024 17:29:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 09:29:42 +0000
Date: Tue, 13 Feb 2024 09:29:41 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 8/9] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
Message-ID: <20240213092941.00000ad3@Huawei.com>
In-Reply-To: <ZcUotSCiFYEceShP@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-9-nifan.cxl@gmail.com>
	<20240124165004.00003228@Huawei.com>
	<ZcUotSCiFYEceShP@debian>
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


> > >  #endif
> > > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > > index d778487b7e..4f8cb3215d 100644
> > > --- a/include/hw/cxl/cxl_events.h
> > > +++ b/include/hw/cxl/cxl_events.h
> > > @@ -166,4 +166,19 @@ typedef struct CXLEventMemoryModule {
> > >      uint8_t reserved[0x3d];
> > >  } QEMU_PACKED CXLEventMemoryModule;
> > >  
> > > +/*
> > > + * CXL r3.0 section Table 8-47: Dynamic Capacity Event Record
> > > + * All fields little endian.
> > > + */
> > > +typedef struct CXLEventDynamicCapacity {
> > > +    CXLEventRecordHdr hdr;
> > > +    uint8_t type;
> > > +    uint8_t reserved1;
> > > +    uint16_t host_id;
> > > +    uint8_t updated_region_id;
> > > +    uint8_t reserved2[3];
> > > +    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */  
> > 
> > Can't we use that definition here?  
> 
> REPLY: 
> 
> I leave it as it is to avoid include cxl_device.h to cxl_extent.h.
> 
> Do you think we need to include the file and use the definition here?

I don't feel strongly either way.

Jonathan

> 
> Fan
