Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812AA146A97
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108099; cv=none; b=kGGGFDCFWhsc3pLQrVwMmrujFfuIfXDiUP8OwUc1DeKFEEKp4jsZa9juWlv8X487LfefuPiWR0BjHtvaHW6t0go/B3pwp1YYYllGeJbIVaevw+iI8olfwncJTKiXCLkBj9PzT3HpLD6mE/Yms8K+2ueopgp9EFdYhifUkWz8YwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108099; c=relaxed/simple;
	bh=UJFKhed4fJMneVV6rujND5H35slJcFG29ivNGkd897Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ly6V8+snPASn/f47xN1Y0qdO7uLY4xuZ2FR8zWmIUM0xmNSV6ggT/+l2+NB6Ukc//78qfA76De3Xbyg32AbFuY4esMWAQ6FkOpfweSCFZXQ54SMSLUFy4MoiMev4yie32SgK7yr6KU5qp7DR76x/E1QF6oSFJOfneVEgX64ODwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wfh3M1FYnz6K61c;
	Thu,  8 Aug 2024 17:05:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 987BE1400C9;
	Thu,  8 Aug 2024 17:08:12 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 Aug
 2024 10:08:11 +0100
Date: Thu, 8 Aug 2024 10:08:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yanfei Xu <yanfei.xu@intel.com>
CC: Alison Schofield <alison.schofield@intel.com>,
	<linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <ming4.li@intel.com>
Subject: Re: [PATCH] cxl/pci: Fix DVSEC ranges validation to cover all
 ranges
Message-ID: <20240808100810.00005f5d@Huawei.com>
In-Reply-To: <116108a3-f974-455e-b530-1e55e4f98758@intel.com>
References: <20240807131908.303600-1-yanfei.xu@intel.com>
	<ZrPEoBbeV0BBdn8n@aschofie-mobl2>
	<116108a3-f974-455e-b530-1e55e4f98758@intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 8 Aug 2024 15:59:49 +0800
Yanfei Xu <yanfei.xu@intel.com> wrote:

> On 8/8/2024 3:01 AM, Alison Schofield wrote:
> > On Wed, Aug 07, 2024 at 09:19:08PM +0800, Yanfei Xu wrote:  
> >> cxl_endpoint_dvsec_info.ranges means the number of non-zero DVSEC
> >> range, and it will be less than the value of HDM_count when occuring
> >> zero DVSEC range. Hence using it for looping validation of DVSEC
> >> ranges in cxl_hdm_decode_init() and looping DVSEC decoder initialization
> >> in devm_cxl_enumerate_decoders could miss non-zero DVSEC ranges. And
> >> we should only create decoder for the allowed ranges.
> >>
> >> Initializing content of all dvsec_range[] to invalid range and moving
> >> the check of dvsec_range_allowed() in advance to cxl_dvsec_rr_decode()
> >> could address that.  
> > 
> > Hi Yanfei,
> > 
> > This is interesting but a bit much to review in one patch.
> > 
> > Please separate the fixes patch, that you comment above, from the refactoring
> > and the drop of wait_for_valid() changes. That'll make review easier.  
> 
> Thanks Alison's suggestion and review! That make sense and I will split
> the patch to make it easy to review :)
> 
> > 
> > For the fix. I understand that you found by inspection. Is the impact
> > that the driver will create decoders for NOT allowed ranges?  And
> > forgive me for not looking further into the code yet, but I'd like you
> > to lead me on that and explain the impact in the commit log.  
> 
> Yes, it will create decoders for NOT allowed ranges.
> 
> > 
> > I'm confused when the above says ranges 'means the number of non-zero
> > DVSEC range' and then says we should not use ranges while looping
> > because it 'could miss non-zero DVSEC ranges.' Is the
> > dvsec_range_allowed() callout in cxl_hdm_decoder_init() not doing
> > as expected? And why is it a 'could' miss and not an always miss?  
> 
> My issue of wording.
> 
> For example: 2 ranges, the first one is a zero range, the second one is
> an available range. In this case, info->ranges = 1.

Initially I thought this wasn't allowed as you have to implement
range 1 if you are going to implement range 2, but there is
a statement in 8.1.3.8 that
A CXL.mem-capable device is permitted to report zero memory size.

That makes me wonder. There is no text in the memory size
to rule out setting them to zero and if you can set it for
all of them I assume you can set it to zero for the 1st one only.

So in conclusion.  I think a good catch - though theoretical
for now.

> 
> 1. In cxl_hdm_decode_init(), it uses variable "i" which is less than
> info->ranges, is used as index of info->dvsec_range[] to validate the
> ranges.
> 
> for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
>      ... dvsec_range_allowed
> }
> 
> Since info->ranges is 1, so i will only be 0, validating only the first
> zero range and not the second avaliable range. As a result, allowed==0.
> 
> 2. A same issue occurs in devm_cxl_enumerate_decoders(), where
> cxlhdm->decoder_count is assigned the value of info->ranges to loop each
> decoder while invoking the
> init_hdm_decoder()->cxl_setup_hdm_decoder_from_dvsec(). Due to "allowed
> == 0" in 1., it returns directly and won't run into 2.
> 
> But if ranges could exceed 2 (though the spec defines the maximum as 2
> for now), it would encounter the same problem in 2 like 1. What I mean
> the appropriate approach would be to store the only non-zero and allowed
> ranges in info->dvsec_range[].

Would a less invasive change be to use a bitmap instead of
a simple count for info->ranges?

That way we can use the bitmap iterators (even though it'll be very short).
Alternatively carry a info->range_offset through all this code
and iterate from that not 0.  That only works because there are only 2
range registers though so is non intuitive. I'd prefer the bitmap.


> 
> > 
> > Please v2 with this as a set. I'd prefer seeing the Fix first, unless
> > you think the refactor and wait_for_valid() change are required before
> > adding the fix.  
> 
> It's not required, will send v2.

Great. And thanks for the detailed explanation.  The code changes
were not easy to follow - so minimizing the fix will also help.

Thanks,

Jonathan

> 
> Thanks,
> Yanfei
> 
> > 
> > --Alison
> >   
> >>
> >> Other non-functional changes, refectoring cxl_dvsec_rr_decode to
> >> improve its readability and droping wait_for_valid() to use
> >> cxl_dvsec_mem_range_valid().
> >>
> >> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> >> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> >> ---
> >> Background: Found this issue when reading the CXL code. I didn't encounter
> >> the discribed issue in real environment.
> >>
> >>   drivers/cxl/core/hdm.c        |   2 +-
> >>   drivers/cxl/core/pci.c        | 121 +++++++++++++---------------------
> >>   drivers/cxl/cxl.h             |   5 +-
> >>   drivers/cxl/port.c            |   2 +-
> >>   tools/testing/cxl/test/mock.c |   4 +-
> >>   5 files changed, 53 insertions(+), 81 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> >> index 3df10517a327..65f5fd2e4189 100644
> >> --- a/drivers/cxl/core/hdm.c
> >> +++ b/drivers/cxl/core/hdm.c
> >> @@ -768,7 +768,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
> >>   
> >>   	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> >>   	len = range_len(&info->dvsec_range[which]);
> >> -	if (!len)
> >> +	if (WARN_ON(len == 0 || len == CXL_RESOURCE_NONE))
> >>   		return -ENOENT;
> >>   
> >>   	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> >> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> >> index 8567dd11eaac..c8420a7995f1 100644
> >> --- a/drivers/cxl/core/pci.c
> >> +++ b/drivers/cxl/core/pci.c
> >> @@ -211,37 +211,6 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
> >>   
> >> -static int wait_for_valid(struct pci_dev *pdev, int d)
> >> -{
> >> -	u32 val;
> >> -	int rc;
> >> -
> >> -	/*
> >> -	 * Memory_Info_Valid: When set, indicates that the CXL Range 1 Size high
> >> -	 * and Size Low registers are valid. Must be set within 1 second of
> >> -	 * deassertion of reset to CXL device. Likely it is already set by the
> >> -	 * time this runs, but otherwise give a 1.5 second timeout in case of
> >> -	 * clock skew.
> >> -	 */
> >> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
> >> -	if (rc)
> >> -		return rc;
> >> -
> >> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
> >> -		return 0;
> >> -
> >> -	msleep(1500);
> >> -
> >> -	rc = pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &val);
> >> -	if (rc)
> >> -		return rc;
> >> -
> >> -	if (val & CXL_DVSEC_MEM_INFO_VALID)
> >> -		return 0;
> >> -
> >> -	return -ETIMEDOUT;
> >> -}
> >> -
> >>   static int cxl_set_mem_enable(struct cxl_dev_state *cxlds, u16 val)
> >>   {
> >>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> >> @@ -322,11 +291,14 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
> >>   	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
> >>   }
> >>   
> >> -int cxl_dvsec_rr_decode(struct device *dev, int d,
> >> +int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> >>   			struct cxl_endpoint_dvsec_info *info)
> >>   {
> >>   	struct pci_dev *pdev = to_pci_dev(dev);
> >> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> >>   	int hdm_count, rc, i, ranges = 0;
> >> +	int d = cxlds->cxl_dvsec;
> >> +	struct cxl_port *root;
> >>   	u16 cap, ctrl;
> >>   
> >>   	if (!d) {
> >> @@ -357,10 +329,19 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> >>   	if (!hdm_count || hdm_count > 2)
> >>   		return -EINVAL;
> >>   
> >> -	rc = wait_for_valid(pdev, d);
> >> -	if (rc) {
> >> -		dev_dbg(dev, "Failure awaiting MEM_INFO_VALID (%d)\n", rc);
> >> -		return rc;
> >> +	root = to_cxl_port(port->dev.parent);
> >> +	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> >> +		root = to_cxl_port(root->dev.parent);
> >> +	if (!is_cxl_root(root)) {
> >> +		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	for (i = 0; i < CXL_DVSEC_RANGE_MAX; i++) {
> >> +		info->dvsec_range[i] = (struct range) {
> >> +			.start = 0,
> >> +			.end = CXL_RESOURCE_NONE,
> >> +		};
> >>   	}
> >>   
> >>   	/*
> >> @@ -373,9 +354,15 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> >>   		return 0;
> >>   
> >>   	for (i = 0; i < hdm_count; i++) {
> >> +		struct device *cxld_dev;
> >> +		struct range dvsec_range;
> >>   		u64 base, size;
> >>   		u32 temp;
> >>   
> >> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
> >> +		if (rc)
> >> +			return rc;
> >> +
> >>   		rc = pci_read_config_dword(
> >>   			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
> >>   		if (rc)
> >> @@ -389,13 +376,8 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> >>   			return rc;
> >>   
> >>   		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
> >> -		if (!size) {
> >> -			info->dvsec_range[i] = (struct range) {
> >> -				.start = 0,
> >> -				.end = CXL_RESOURCE_NONE,
> >> -			};
> >> +		if (!size)
> >>   			continue;
> >> -		}
> >>   
> >>   		rc = pci_read_config_dword(
> >>   			pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
> >> @@ -411,11 +393,22 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> >>   
> >>   		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> >>   
> >> -		info->dvsec_range[i] = (struct range) {
> >> +		dvsec_range = (struct range) {
> >>   			.start = base,
> >> -			.end = base + size - 1
> >> +			.end = base + size - 1,
> >>   		};
> >>   
> >> +		cxld_dev = device_find_child(&root->dev, &dvsec_range,
> >> +					     dvsec_range_allowed);
> >> +		if (!cxld_dev) {
> >> +			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
> >> +			continue;
> >> +		}
> >> +		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
> >> +		put_device(cxld_dev);
> >> +
> >> +		info->dvsec_range[ranges] = dvsec_range;
> >> +
> >>   		ranges++;
> >>   	}
> >>   
> >> @@ -439,9 +432,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> >>   	struct cxl_port *port = cxlhdm->port;
> >>   	struct device *dev = cxlds->dev;
> >> -	struct cxl_port *root;
> >> -	int i, rc, allowed;
> >>   	u32 global_ctrl = 0;
> >> +	int rc;
> >>   
> >>   	if (hdm)
> >>   		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> >> @@ -455,30 +447,16 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >>   	else if (!hdm)
> >>   		return -ENODEV;
> >>   
> >> -	root = to_cxl_port(port->dev.parent);
> >> -	while (!is_cxl_root(root) && is_cxl_port(root->dev.parent))
> >> -		root = to_cxl_port(root->dev.parent);
> >> -	if (!is_cxl_root(root)) {
> >> -		dev_err(dev, "Failed to acquire root port for HDM enable\n");
> >> -		return -ENODEV;
> >> -	}
> >> -
> >> -	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> >> -		struct device *cxld_dev;
> >> +	if (!info->mem_enabled) {
> >> +		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> >> +		if (rc)
> >> +			return rc;
> >>   
> >> -		cxld_dev = device_find_child(&root->dev, &info->dvsec_range[i],
> >> -					     dvsec_range_allowed);
> >> -		if (!cxld_dev) {
> >> -			dev_dbg(dev, "DVSEC Range%d denied by platform\n", i);
> >> -			continue;
> >> -		}
> >> -		dev_dbg(dev, "DVSEC Range%d allowed by platform\n", i);
> >> -		put_device(cxld_dev);
> >> -		allowed++;
> >> +		return devm_cxl_enable_mem(&port->dev, cxlds);
> >>   	}
> >>   
> >> -	if (!allowed && info->mem_enabled) {
> >> -		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> >> +	if (!info->ranges && info->mem_enabled) {
> >> +		dev_err(dev, "No available DVSEC register ranges.\n");
> >>   		return -ENXIO;
> >>   	}
> >>   
> >> @@ -491,14 +469,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >>   	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
> >>   	 * Decoder Capability Enable.
> >>   	 */
> >> -	if (info->mem_enabled)
> >> -		return 0;
> >> -
> >> -	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
> >> -	if (rc)
> >> -		return rc;
> >> -
> >> -	return devm_cxl_enable_mem(&port->dev, cxlds);
> >> +	return 0;
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> >>   
> >> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> >> index a6613a6f8923..6d9126d5ee56 100644
> >> --- a/drivers/cxl/cxl.h
> >> +++ b/drivers/cxl/cxl.h
> >> @@ -790,6 +790,7 @@ static inline int cxl_root_decoder_autoremove(struct device *host,
> >>   }
> >>   int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
> >>   
> >> +#define CXL_DVSEC_RANGE_MAX		2
> >>   /**
> >>    * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> >>    * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
> >> @@ -801,7 +802,7 @@ struct cxl_endpoint_dvsec_info {
> >>   	bool mem_enabled;
> >>   	int ranges;
> >>   	struct cxl_port *port;
> >> -	struct range dvsec_range[2];
> >> +	struct range dvsec_range[CXL_DVSEC_RANGE_MAX];
> >>   };
> >>   
> >>   struct cxl_hdm;
> >> @@ -810,7 +811,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> >>   int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >>   				struct cxl_endpoint_dvsec_info *info);
> >>   int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> >> -int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
> >> +int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> >>   			struct cxl_endpoint_dvsec_info *info);
> >>   
> >>   bool is_cxl_region(struct device *dev);
> >> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> >> index 97c21566677a..a8c241cb4ce2 100644
> >> --- a/drivers/cxl/port.c
> >> +++ b/drivers/cxl/port.c
> >> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> >>   	struct cxl_port *root;
> >>   	int rc;
> >>   
> >> -	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
> >> +	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
> >>   	if (rc < 0)
> >>   		return rc;
> >>   
> >> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> >> index 6f737941dc0e..79fdfaad49e8 100644
> >> --- a/tools/testing/cxl/test/mock.c
> >> +++ b/tools/testing/cxl/test/mock.c
> >> @@ -228,7 +228,7 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> >>   }
> >>   EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
> >>   
> >> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
> >> +int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
> >>   			       struct cxl_endpoint_dvsec_info *info)
> >>   {
> >>   	int rc = 0, index;
> >> @@ -237,7 +237,7 @@ int __wrap_cxl_dvsec_rr_decode(struct device *dev, int dvsec,
> >>   	if (ops && ops->is_mock_dev(dev))
> >>   		rc = 0;
> >>   	else
> >> -		rc = cxl_dvsec_rr_decode(dev, dvsec, info);
> >> +		rc = cxl_dvsec_rr_decode(dev, port, info);
> >>   	put_cxl_mock_ops(index);
> >>   
> >>   	return rc;
> >> -- 
> >> 2.39.2
> >>
> >>  
> >   
> 

