Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F631B7EF
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274056; cv=none; b=Uw/Pfd5Nfb+Wsjr8TG6u5hFFpogp27YvKL1pIwwd70MkhjH+cFygNDg7i6LPa4iVLkxH6fMm2RBFzT1OK3+2ZieaxhvRLzb87gcrWf3qcOau0TCqfyhwDgZaM9zOohklyrFrlggbsNTom1skVtRXGP2byRA6BphaM1A6fsmfsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274056; c=relaxed/simple;
	bh=l6W3PhJYp5h1qpYeVUOkH6H4K5WFZ+navz9lWBZ0Cx8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsYyO1+gl7XfEvSsB05yt/FqL2Fu0k/lDOERBinNCb1SS6isJxNvt3AMlOZi4e9CvGi12nDjeDQ8/jF63GjX9tc7vhppVzodMZdKKsVkxRemW9d7kz4K1Primjrb74qcfITjVstZLo84qAGao9CTpFdayXfBM1TYxgtM5uWz9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TLyR24xWvz6K9L1;
	Fri, 26 Jan 2024 20:57:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D275140AB8;
	Fri, 26 Jan 2024 21:00:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 13:00:49 +0000
Date: Fri, 26 Jan 2024 13:00:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v3 4/9] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <20240126130048.000042f4@Huawei.com>
In-Reply-To: <20240124152316.0000281c@Huawei.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-5-nifan.cxl@gmail.com>
	<20240124152316.0000281c@Huawei.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Jan 2024 15:23:16 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue,  7 Nov 2023 10:07:08 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > With the change, when setting up memory for type3 memory device, we can
> > create DC regions.
> > A property 'num-dc-regions' is added to ct3_props to allow users to pass the
> > number of DC regions to create. To make it easier, other region parameters
> > like region base, length, and block size are hard coded. If needed,
> > these parameters can be added easily.
> > 
> > With the change, we can create DC regions with proper kernel side
> > support as below:
> > 
> > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > 
> > echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
> > echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> > 
> > echo 0x40000000 > /sys/bus/cxl/devices/$region/size
> > echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> > echo 1 > /sys/bus/cxl/devices/$region/commit
> > echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> Hi Fan, a few comments inline.
> 
> Jonathan
> 
> > ---
> >  hw/mem/cxl_type3.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 754c885cd1..2d67d2015c 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -721,6 +721,36 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >      }
> >  }
> >  
> > +static int cxl_create_dc_regions(CXLType3Dev *ct3d)
> > +{
> > +    int i;
> > +    uint64_t region_base = 0;
> > +    uint64_t region_len =  2 * GiB;
> > +    uint64_t decode_len = 8; /* 8*256MB */  
> 
> If decode len is going to be div 256MiB then we need
> a name for that field that makes it clear that it is.
> 
> decode_len_256mbytes or something like that and maybe
> region_len_bytes to keep things consistent.
> 
> Why the spec didn't make our life easier and define decode length
> in bytes with some bits that must be zero is beyond me... 
> 
> 
> I think we need to make this at least optionally configurable or based
> in some fashion on the provided memory backend (divide that up
> by number of regions with appropriate rounding perhaps?)

This seems to be a mid patch set confusion..  It's fixed in patch 7.
Whilst applying I've made this 2GiB here.

Jonathan

