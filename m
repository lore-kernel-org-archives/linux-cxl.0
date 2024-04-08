Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AEA2D05D
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570084; cv=none; b=NfJ83d0+VOBu08wz+HLki3XCfNBtrrsgLNC6pUDovkUbwK8QBuPuAwzW/oWRDm8hgQbNzWVKFsZ0AFk/xlUT3TmpsnzJ2c5pDacOMpIrUsYfeeJSdAeJ+eqtvvJ2NQ1mGkyzcuP1agvmC4B7Fy7iQjYEIQ/o+qcjiOV9QAhcjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570084; c=relaxed/simple;
	bh=20MXeqR8TcNt1Lajz7iY8Q0h2dN62ULBGXmFdCaSGFk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgvIMnS3NYi0neY19t+NY21ae73+RSou0fsMujY05m1Gmhi1XMrbp46g1YSKtIHBXGjJsta6kBZKBCiVVEmxt1ayo/hjvuHx1nMcCzJmh2LsFjABbe4V1937sfEivTBYNApds1T97jjHZvZ44B9z+n57bv1r3nf3bsPjAZRYNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VCktC0JTMz67xjd;
	Mon,  8 Apr 2024 17:53:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FDFB140B54;
	Mon,  8 Apr 2024 17:54:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 8 Apr
 2024 10:54:37 +0100
Date: Mon, 8 Apr 2024 10:54:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v7 3/5] cxl: Fix incorrect region perf data calculation
Message-ID: <20240408105436.0000175e@Huawei.com>
In-Reply-To: <66107c715e6ca_2583ad294cd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240403154844.3403859-1-dave.jiang@intel.com>
	<20240403154844.3403859-4-dave.jiang@intel.com>
	<66107c715e6ca_2583ad294cd@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Apr 2024 15:34:25 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Dave Jiang wrote:
> > Current math in cxl_region_perf_data_calculate divides the latency by 1000
> > every time the function gets called. This causes the region latency to be
> > divided by 1000 per memory device and the math is incorrect. This is user
> > visible as the latency access_coordinate exposed via sysfs will show
> > incorrect latency data.
> > 
> > Normalize values from CDAT to nanoseconds. Adjust sub-nanoseconds latency
> > to at least 1. Remove adjustment of perf numbers from the generic target
> > since hmat handling code has already normalized those numbers. Now all
> > computation and stored numbers should be in nanoseconds.
> > 
> > cxl_hb_get_perf_coordinates() is removed and HB coords are calculated
> > in the port access_coordinate calculation path since it no longer need
> > to be treated special.
> > 
> > Fixes: 3d9f4a197230 ("cxl/region: Calculate performance data for a region")
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > v7:
> > - Remove min_not_zero(). Incorrectly set everything to 1. DIV_ROUNDUP()
> >   will ensure sub-nanoseconds values not 0 unless value 0 to begin with.
> >   (Jonathan)
> > - Reflowed patch order
> > - Remove cxl_hb_get_perf_coordinates() as change made function unnessary.
> > - Add hb access_coordinate back to port caclculation.
> > ---
> >  drivers/cxl/acpi.c      | 13 +-----
> >  drivers/cxl/core/cdat.c | 89 ++++++++++++++++-------------------------
> >  drivers/cxl/core/port.c | 36 ++---------------
> >  drivers/cxl/cxl.h       |  2 -
> >  4 files changed, 40 insertions(+), 100 deletions(-)  
> 
> yum... bug fix that removes more than double the code it adds.
> 
> [..]
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index eddbbe21450c..48704976693e 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -20,6 +20,31 @@ struct dsmas_entry {
> >  	int qos_class;
> >  };
> >  
> > +static u32 cdat_normalize(u16 entry, u64 base, u8 type)
> > +{
> > +	u32 value;
> > +
> > +	/*
> > +	 * Check for invalid and overflow values
> > +	 */
> > +	if (entry == 0xffff || !entry)
> > +		return 0;
> > +	else if (base > (UINT_MAX / (entry)))
> > +		return 0;
> > +
> > +	value = entry * base;  
> 
> Might be worth a reminder comment here that CDAT fields follow the
> format of HMAT fields when a future reader wonders why these type names
> are not CDAT_ACCESS_LATENCY, etc. Bonus points for a "see Table 5
> Device Scoped Latency and Bandwidth Information Structure in Coherent
> Device Attribute Table (CDAT) Specification v1.01"

Call out a specific HMAT version if you do add such a comment.
We don't want anyone to happen to look at an early version and get
even more confused :(


> 
> Either way you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

