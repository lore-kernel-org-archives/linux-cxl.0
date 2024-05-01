Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107D12F369
	for <linux-cxl@vger.kernel.org>; Wed,  1 May 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573510; cv=none; b=bVrM3xhXP3gM/3HOtnA2YD7YAuKCLTVN4oigVMYy80mzny6KSjdlTEmXuj3Tw93h4BxF9WXgxe6efQWNujdpi/pVHuI4H6Os7pmcaZzBQuMV5u0rutbiKXyTsnd/Cyd1kAbTSymLW4ygKJB6aDUiNIo7Qt8vGYvF5+wlzP72QuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573510; c=relaxed/simple;
	bh=+UjacypduRFIk5vKU2cjXpHPV+jopZ6/m/iBjd7c+io=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idKfl9ARR8Jiom6U7qtj0XfZzvIdp+a1zxZIECVK9VrXZ6JEVSCC7VjAw01QNTkb9VIt53o+EixnvzH0QBNu5PYwZ9XrawZhVHOys6BIUEVy47H1/9suIJY/Xwm3ucFjl0AHSP9MBFaLhgVZxW+R5u5tVrLnBHL2SYbHtsiep0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTzmD3HSYz67nrk;
	Wed,  1 May 2024 22:22:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 747111408F9;
	Wed,  1 May 2024 22:25:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 1 May
 2024 15:25:04 +0100
Date: Wed, 1 May 2024 15:25:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <20240501152503.00002e60@Huawei.com>
In-Reply-To: <6628464ee73bb_d567d2943c@iweiny-mobl.notmuch>
References: <20240411181641.514075-1-dave.jiang@intel.com>
	<6628464ee73bb_d567d2943c@iweiny-mobl.notmuch>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Apr 2024 16:37:50 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> Dave Jiang wrote:
> 
> [snip]
> 
> > +/*
> > + * Calculate the bandwidth for the cxl region based on the number of targets
> > + * that share an upstream switch. The function is called while targets are
> > + * being attached for a region. If the number of targets is 1, then
> > + * the target either does not have a upstream switch or it's the first target
> > + * of the shared link. In this case, the bandwidth is the sum of the target
> > + * bandwidth and the collected region bandwidth. If the targets from cxl_rr is
> > + * greater than 1, then the bandwidth is the minimum of the switch upstream
> > + * port bandwidth or the region plus the target bandwidth.
> > + */
> > +static unsigned int calculate_region_bw(int targets, unsigned int usp_bw,
> > +					unsigned int ep_bw,
> > +					unsigned int region_bw)
> > +{
> > +	if (targets == 1)
> > +		return region_bw + ep_bw;
> > +
> > +	return min_t(unsigned int, usp_bw, region_bw + ep_bw);
> > +}
> > +
> >  void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> >  				    struct cxl_endpoint_decoder *cxled)
> >  {
> > @@ -551,7 +581,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> >  			.start = cxled->dpa_res->start,
> >  			.end = cxled->dpa_res->end,
> >  	};
> > +	struct cxl_port *port = cxlmd->endpoint;
> >  	struct cxl_dpa_perf *perf;
> > +	int usp_bw, targets;
> >  
> >  	switch (cxlr->mode) {
> >  	case CXL_DECODER_RAM:
> > @@ -569,6 +601,12 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> >  	if (!range_contains(&perf->dpa_range, &dpa))
> >  		return;
> >  
> > +	usp_bw = cxl_get_switch_uport_bandwidth(port->uport_dev);
> > +	if (usp_bw > 0)
> > +		targets = cxl_port_shared_region_targets(port, cxlr);  
> 
> I'm not quite following how this handles a x4 situation with 2 upstream
> ports and 2 devices under each of those switches.
> 
>      +------+            +------+
>      | HB 0 |            | HB 1 |
>      +------+            +------+
>         | (link 0)          | (link 1)
>      +------+            +------+
>      | SW 0 |            | SW 1 |
>      +------+            +------+
>       /    \              /     \
>  +------+ +------+   +------+ +------+
>  | EP 0 | | EP 1 |   | EP 2 | | EP 3 |
>  +------+ +------+   +------+ +------+
> 
> In this case the region BW should be:
> 
> 	min ( sum(link0, link1), sum(EP 0-3) )
> 
> How is the sum of EP 0-1 limited to the link0 BW, and EP 2-3 to link1?

Agreed. Seems this fails if there are multiple RPs involved whether attached
to a single host bridge, or multiple host bridges (and hence multiple generic
ports).  

I'm also wondering now if we are handling the difference between shared
Generic Ports and independent ones? (and for giggles PXM nodes with multiple
GPs)

                 CFMWS 0
                    |
           _________|_________
          |                   |
    GP0/HB0/ACPI0017-0  GP1/HB1/ACPI0017-1
      |          |        |           |
     RP0        RP1      RP2         RP3
      |          |        |           |
    SW 0       SW 1     SW 2        SW 3
    |   |      |   |    |   |       |   |
   EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7

BW I think is min of (being loose with terms!):
* GP0 BW + GP1 BW  (I think GP stuff is expressing bw to the Root Complex)
* RP0 Link + RP1 Link + RP2 Link + RP3 Link
* SW0 SSLBIS BW Port0 + SW0 SSLBIS BW P1 + SW1 BW P0 + SW1 P1 + SW2 P0 + SW2 P1 + SW3 P0 + SW3 P1
* EP0 Link BW + EP1 Link BW + EP2 Link BW + EP3 Link BW + EP 4 Link BW + EP5 Link BW + EP6 Link BW + EP7 Link BW
* EP0 DSLBIS BW + EP1.... EP7 DSLBIS BW.

But it's worse than that, because in each branch the bottleneck might not
be at the same level.  If we spit it into two GP0 tree and GP1 tree
and in GP0 the limit is the SW0/1 BW and in GP1 it's EP4,5,6,7
then we can't just sum things up like above.

I think we'd need to build up from the leaves with them all in place, clamping
as we go.  So something like
Min (CPU0 to GP0 BW, 
     Min(RP0 to SW 0 Link BW, 
         Min(SW0SSLBIS to P0, EP0 DSLBIS, EP0 Upstream Link) +
         Min(SW0SSLBIS to P1, EP1 DSLBIS, EP1 Upstream link)) +
     Min(RP1 to SW 1 Link BW, 
         Min(SW1SSLBIS to P0, EP2 DSLBIS, EP2 Upstream Link) +
         Min(SW1SSLBIS to P1, EP3 DSLBIS, EP3 Upstream link))) +
Min (CPU0 to GP1 BW,
     Min(RP2 to SW 2 Link BW, 
         Min(SW2SSLBIS to P0, EP4 DSLBIS, EP4 Upstream Link) +
         Min(SW2SSLBIS to P1, EP5 DSLBIS, EP5 Upstream link)) +
     Min(RP3 to SW 3 Link BW, 
         Min(SW3SSLBIS to P0, EP6 DSLBIS, EP6 Upstream Link) +
         Min(SW3SSLBIS to P1, EP7 DSLBIS, EP7 Upstream link))))


The outer most sum assumes GP0 and GP1 are in different PXM.
If they are in the same one I think it's effectively the same
as all the RP below one HB?

Maybe we should just document we only support symmetric
setups and print warning messages if anything else is seen - the
shared PXM for the GPs should be added though as that is certainly
possible and made me think I need to poke some FW folk to make sure
they aren't doing this wrong ;)

So there can be sharing both upstream of switches and between the root
ports.  We can't do anything about sharing inside the host as HMAT
doesn't give us any hints.

I'm basing that shared PXM assumption on the case of two chunks of
memory (each with own SRAT entry but same Proximity Domain) then the HMAT numbers
are to all the memory in the node, not to each chunk of the memory.

So upshot is we need test cases where we deliberate clamp the bandwidth
at each level in the above diagram to something small and make sure we
correctly identify the overall bandwidth.

Can do that in QEMU (with the GP set) though you'll need to hack the
CDAT tables or export them and inject them back in again with different
numbers.

Good luck ;) *hides*

Jonathan




> 
> > +	else
> > +		targets = 1;  
> 
> Maybe a comment to indicate that targets == 1 is a failure to read the usp
> link speed so defaulting back to the sum of the endpoints.
> 
> > +
> >  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
> >  		/* Get total bandwidth and the worst latency for the cxl region */
> >  		cxlr->coord[i].read_latency = max_t(unsigned int,
> > @@ -577,8 +615,14 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> >  		cxlr->coord[i].write_latency = max_t(unsigned int,
> >  						     cxlr->coord[i].write_latency,
> >  						     perf->coord[i].write_latency);
> > -		cxlr->coord[i].read_bandwidth += perf->coord[i].read_bandwidth;
> > -		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
> > +		cxlr->coord[i].read_bandwidth =
> > +			calculate_region_bw(targets, usp_bw,
> > +					    perf->coord[i].read_bandwidth,
> > +					    cxlr->coord[i].read_bandwidth);
> > +		cxlr->coord[i].write_bandwidth =
> > +			calculate_region_bw(targets, usp_bw,
> > +					    perf->coord[i].write_bandwidth,
> > +					    cxlr->coord[i].write_bandwidth);
> >  	}
> >  }
> >    
> 
> [snip]
> 
> > +
> > +int cxl_pci_get_switch_usp_bandwidth(struct pci_dev *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct pci_dev *iter = pdev;
> > +
> > +	do {
> > +		if (pci_pcie_type(iter) == PCI_EXP_TYPE_UPSTREAM)
> > +			break;  
> 
> Why is it not ok to do:
> 
> 	while (pci_pcie_type(iter) != PCI_EXP_TYPE_UPSTREAM) {
> 		...
Snap ;)
> 	}
> 
> Ira
> 
> [snip]

