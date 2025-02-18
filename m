Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3126FD8B;
	Tue, 18 Feb 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898532; cv=none; b=JzgnKExoSXg2doLTwi6+8apQzRHRt4yfNwzjyR3SErsoIRiVd6APByIvO4wCf3R4NHyITSHetEOa/Yb8MvX7NuGBqwAdMxfy3LPWEEtbMnRSfjGEmFxzvzhIJHkFNkjsGm4+lqOm6FUhHGZjLb5Fk94sb8hqZayWT/TmGI4Vv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898532; c=relaxed/simple;
	bh=a6gzkT/1WOil1FjkegQ5U9ewcuxrQ23z0OALJmt+Dr8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paslAxXiMdNIkxQu9c/6o3VIIvYedXFogCw6roH3apaDzhx/GzLgI2xOeb+0ETIS+JUbK2vEYevocFTKDjQN1JQSBiuSizGIUYNiyA4j9Jrtqfd4W/weT31ongwH+Q8khIRYuc0Za5BwuFUhzLq8f8WgnuL0ZdsmIZme6Q4OXAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yy5WB313lz67g19;
	Wed, 19 Feb 2025 01:05:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 492CD1400DD;
	Wed, 19 Feb 2025 01:08:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Feb
 2025 18:08:45 +0100
Date: Tue, 18 Feb 2025 17:08:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: Fan Ni <nifan.cxl@gmail.com>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenbaozi@phytium.com.cn>
Subject: Re: [PATCH v3 1/1] cxl/pmem: debug invalid serial number data
Message-ID: <20250218170844.00000e2a@huawei.com>
In-Reply-To: <Z7P4A+3hfRdNnMM3@phytium.com.cn>
References: <20250218014746.166565-1-wangyuquan1236@phytium.com.cn>
	<20250218014746.166565-2-wangyuquan1236@phytium.com.cn>
	<67b3ee67.a70a0220.21e7fd.0285@mx.google.com>
	<Z7P4A+3hfRdNnMM3@phytium.com.cn>
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

On Tue, 18 Feb 2025 11:01:23 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> On Mon, Feb 17, 2025 at 06:20:18PM -0800, Fan Ni wrote:
> > On Tue, Feb 18, 2025 at 09:47:46AM +0800, Yuquan Wang wrote:  
> > > In a nvdimm interleave-set each device with an invalid or zero
> > > serial number may cause pmem region initialization to fail, but in
> > > cxl case such device could still set cookies of nd_interleave_set
> > > and create a nvdimm pmem region.
> > > 
> > > This adds the validation of serial number in cxl pmem region creation.
> > > The event of no serial number would cause to fail to set the cookie
> > > and pmem region.
> > > 
> > > For cxl-test to work properly, always +1 on mock device's serial
> > > number.
> > > 
> > > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > > ---
> > >  drivers/cxl/pmem.c           | 8 ++++++++
> > >  tools/testing/cxl/test/mem.c | 2 +-
> > >  2 files changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> > > index f9c95996e937..73787afe1b9d 100644
> > > --- a/drivers/cxl/pmem.c
> > > +++ b/drivers/cxl/pmem.c
> > > @@ -383,6 +383,14 @@ static int cxl_pmem_region_probe(struct device *dev)
> > >  			.position = i,
> > >  		};
> > >  		info[i].offset = m->start;
> > > +
> > > +		if (cxlds->serial == 0) {
> > > +			/* include missing alongside invalid in this error message. */
> > > +			dev_err(dev, "%s: invalid or missing serial number\n",
> > > +				dev_name(&cxlmd->dev));
> > > +			rc = -ENXIO;
> > > +			goto out_nvd;
> > > +		}  
> > 
> > Should we do the check earlier in the code? 
> > For example, right below if (!nvdimm) {}
> > 
> > Fan  
> 
> I agree. This would removes unnecessary struct value assignments
> and make the code easier to read. Jonathan, what's your opinion?
> 

Seems a bit odd to move it well clear of where it is used.  You could
pull these two info[i] lines up as well then it would seem more reasonable.

I don't mind that much though.

Jonathan

> Yuquan
> 
> >   
> > >  		info[i].serial = cxlds->serial;
> > >  	}
> > >  	ndr_desc.num_mappings = cxlr_pmem->nr_mappings;
> > > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > > index 8d731bd63988..9e098cf06603 100644
> > > --- a/tools/testing/cxl/test/mem.c
> > > +++ b/tools/testing/cxl/test/mem.c
> > > @@ -1533,7 +1533,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> > >  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
> > >  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
> > >  
> > > -	cxlds->serial = pdev->id;
> > > +	cxlds->serial = pdev->id + 1;
> > >  	if (is_rcd(pdev))
> > >  		cxlds->rcd = true;
> > >  
> > > -- 
> > > 2.34.1
> > >   
> 
> 

