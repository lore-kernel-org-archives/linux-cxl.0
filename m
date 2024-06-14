Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C9DDAA
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718376058; cv=none; b=qw0OEYJK5cDxFTD/A1uMynFW4bOKJlFly3z+sfDcONbp5T/wEY+iAkJX6KLrLHxi8zCcqtN3/suwPTS/dz4ioDMZEmvN9o18t13fEEXycSCbIV6wavwx5BJn5/VoWDDf6AjMtMHLtNdgTL6KhgOm3qPsCOabz4ygIlG67fA7Ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718376058; c=relaxed/simple;
	bh=acLLDU5J/j9NED2zRaeZzYw7B5HzPe/JXtIrBlGH10I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7AWQRgobhZk5395VYYBxLlNnk7D+8ZfyKZfn04gCpmX8J3xk6aU6TMs0+1aV+/E1DEoedmQuBoimX+C0cBk30EwjZ3DMGrqy7PoJ4UUep3jyccbpjaNP7C2+sq5AMEmKwWvgEeAJh8beoEm1ffS7/ya/wgNBVcEOUSAAnCiSDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W11zr5q2Sz6HJtF;
	Fri, 14 Jun 2024 22:36:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5816414065C;
	Fri, 14 Jun 2024 22:40:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 15:40:52 +0100
Date: Fri, 14 Jun 2024 15:40:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "mj@ucw.cz" <mj@ucw.cz>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [PATCH v12 1/2] cxl/core/regs: Add rcd_pcie_cap initialization
Message-ID: <20240614154051.00001c47@Huawei.com>
In-Reply-To: <OSAPR01MB7182B37FB0600712947C6C2CBAC22@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240614045611.58658-1-kobayashi.da-06@fujitsu.com>
	<20240614045611.58658-2-kobayashi.da-06@fujitsu.com>
	<20240614093027.0000251f@Huawei.com>
	<OSAPR01MB7182B37FB0600712947C6C2CBAC22@OSAPR01MB7182.jpnprd01.prod.outlook.com>
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

On Fri, 14 Jun 2024 09:51:55 +0000
"Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 14 Jun 2024 13:56:10 +0900
> > "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
> >   
> > > Add rcd_pcie_cap and its initialization to cache the offset of cxl1.1
> > > device link status information. By caching it, avoid the walking
> > > memory map area to find the offset when output the register value.
> > >
> > > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>  
> > Hi.
> > 
> > A couple more change inline.  Problem with evolving code is that as a reviewer
> > I sometime forget to check my expectations.  This now stores a variable in a
> > core structure just to use it once a few lines later. No point in keeping it.
> > Looking at that made me notice the error returns were wrong and unhandled.
> >   
> Thank you for your kind review. I can't post the next version this week, 
> but let me check if my understanding is correct.

> 
> > > ---
> > >  drivers/cxl/core/core.h |  6 ++++
> > >  drivers/cxl/core/regs.c | 62  
> > +++++++++++++++++++++++++++++++++++++++++  
> > >  drivers/cxl/cxl.h       | 10 +++++++
> > >  drivers/cxl/pci.c       |  7 +++--
> > >  4 files changed, 83 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h index
> > > 3b64fb1b9ed0..69006bde7ad5 100644
> > > --- a/drivers/cxl/core/core.h
> > > +++ b/drivers/cxl/core/core.h
> > > @@ -74,6 +74,12 @@ resource_size_t __rcrb_to_component(struct device  
> > *dev,  
> > >  				    struct cxl_rcrb_info *ri,
> > >  				    enum cxl_rcrb which);
> > >  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
> > > +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct
> > > +cxl_dport *dport);
> > > +
> > > +#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
> > > +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> > > +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
> > > +#define PCI_CAP_EXP_SIZEOF		0x3c  
> > 
> > I'd like a follow up patch making these defines apply for all usage of these fields
> > in the PCI core code.  Right now there are pointless hard coded values.
> >   
> Does this mean that you want me to post another patch later that 
> defines PCI_CAP_EXP_SIZEOF to replace the hardcoded value in the PCI core code?
> If so, I'll create a follow-up patch in the future.

Yes but also include the masks for the fields of a PCI capability.
So definitely the last 3 defines. For the first one is the PCIExpress
Capabilities pointer mask, but it is carefully constructed
to line up with the pointers in the PCI capabilities themselves
so you can probably share a define for the first 2.



> 
> > >
> > >  extern struct rw_semaphore cxl_dpa_rwsem;  extern struct rw_semaphore
> > > cxl_region_rwsem; diff --git a/drivers/cxl/core/regs.c
> > > b/drivers/cxl/core/regs.c index 372786f80955..96c2a289cfb7 100644
> > > --- a/drivers/cxl/core/regs.c
> > > +++ b/drivers/cxl/core/regs.c
> > > @@ -505,6 +505,68 @@ u16 cxl_rcrb_to_aer(struct device *dev,  
> > resource_size_t rcrb)  
> > >  	return offset;
> > >  }
> > >
> > > +resource_size_t cxl_rcrb_to_linkcap(struct device *dev, struct
> > > +cxl_dport *dport) {
> > > +	resource_size_t rcrb = dport->rcrb.base;
> > > +	void __iomem *addr;
> > > +	u32 cap_hdr;
> > > +	u16 offset;
> > > +
> > > +	if (!request_mem_region(rcrb, SZ_4K, "CXL RCRB"))
> > > +		return CXL_RESOURCE_NONE;
> > > +
> > > +	addr = ioremap(rcrb, SZ_4K);
> > > +	if (!addr) {
> > > +		dev_err(dev, "Failed to map region %pr\n", addr);
> > > +		release_mem_region(rcrb, SZ_4K);
> > > +		return CXL_RESOURCE_NONE;  
> > 
> > If you hit this then the value returned will be all fs.
> > We are treating and offset of 0 as the error return below.
> >   
> I will change the return type to int and return 0 on error. Does this match your intent?

I was suggesting returning CXL_RESOURCE_NONE on error rather than 0
0 is normally success in Linux, you could have used an int and returned < 0
for the error paths -EINVAL or similar.  I don't really mind which
you chose between that and returning CXL_RESOURCE_NONE in all the failure
paths.


Jonathan


