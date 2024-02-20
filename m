Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8F2DF9F
	for <linux-cxl@vger.kernel.org>; Tue, 20 Feb 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461598; cv=none; b=R2z1TbyASuTA8fUrgG93hXxevAerLKcz38GZux5RbOitwy2nN+mm8u/yfVAB9G3mD3W1UJm/C4pWc407LO8q+vwzMzqdDB67GChsROIqgCVGi2juS9t5amMt+UFvyMRPQCrlty/7Okuj56aPlGLA+ITTK0nigg33HiZxUUQHzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461598; c=relaxed/simple;
	bh=TJQdTLkDeefUdT9U/DKoQ0VebLhC4Wl0TG9aR1xcVTs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OISzD6SWpmAg6oyWHCVP6AqtgTEIe1RBHHkB5kBwjdl/I3uDczjMWyZdkIF5l4eN8ERes0qDFHaN4f+r0v3d2vUQmQYeHc0w3dmAiarGgfdLjEjapu0fYDwqb+D1mj7zzTZsAQgVvxEJ16fDA0qlNzo4d58rgrr9pe5xJF8rLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngdKTvjW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngdKTvjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D91C433F1;
	Tue, 20 Feb 2024 20:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708461598;
	bh=TJQdTLkDeefUdT9U/DKoQ0VebLhC4Wl0TG9aR1xcVTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ngdKTvjW30CKq7jCaW7q1tWt2Gh23t/BbAWlv8GPcrQwgXm2JjEHfUBxzj/6qotZH
	 G8YOq5AcPchz61IfAZNaqcwytFzfhzY4HctIXsoJPdf8k7O9kcmL7JmDhZUiJNN+Cf
	 ZrvSe4ig3pX2UuRGCLduUGE7AqZMXfBVesoaPZBZklbR7FFcSDHSvkF+5iPrrHXBa/
	 vRI/0w4NTGNRKQpG45COdTmZMbP/kEJO5NjVhv/W7D32LzWpwYnvnf6DlncBJyZmDB
	 gtgH2SWoex7Ozk+Yd+Tr0GO4ryVcuGYysou5cD+hNBKKliszPxCKC4a/ALHaa6Op/B
	 8jdx0iFmkP3fg==
Date: Tue, 20 Feb 2024 14:39:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net, Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] cxl: Add post reset warning if the reset is detected as
 Secondary Bus Reset (SBR)
Message-ID: <20240220203956.GA1502351@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219142006.000056a4@Huawei.com>

[+cc Alex, reset expert]

On Mon, Feb 19, 2024 at 02:20:06PM +0000, Jonathan Cameron wrote:
> On Thu, 15 Feb 2024 16:23:07 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > SBR is equivalent to a device been hot removed and inserted again. Doing a
> > SBR on a CXL type 3 device is problematic if the exported device memory is
> > part of system memory that cannot be offlined. The event is equivalent to
> > violently ripping out that range of memory from the kernel. While the
> > hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> > register and the kernel currently does not unmask it, user can unmask
> > this bit via setpci or similar tool.

IIUC, this refers to CXL r3.1, sec 8.1.5.2, which says the default
"Unmask SBR" value is 0, and that when it is 0, the SBR bit in Bridge
Control has no effect unless the Port is operating in PCIe or RCD
mode.

So I guess the scenario is a CXL Port leading to a CXL type 3 device,
and if the Port has the default "Unmask SBR" of 0, an attempt to reset
the type 3 device via SBR would have no effect.  But if a user or some
future kernel *sets* "Unmask SBR", the type 3 device could see a hot
reset.

It sounds kind of problematic that when "Unmask SBR" is 0, an attempt
to reset downstream devices using SBR would fail but the caller of
pci_reset_function() would think it succeeded.

> > The driver does not have a way to detect whether a reset coming from the
> > PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> > detect is to note if there are active decoders before the reset and check
> > if the range register memory active bit remains set after reset.
> > 
> > A helper function to check is added to detect if the range register memory
> > active bit is set. A locked helper for cxl_num_decoders_committed() is also
> > added to allow pci code to call the cxl_num_decoders_committed() while
> > holding the cxl_region_rwsem.
> > 
> > Add a err_handler->reset_prepare() to detect whether there are active
> > decoders.  Add a err_handler->reset_done() to check if there was active
> > memory before the reset and it is no longer active after the reset. A
> > warning is emitted in the case of active memory has been offlined.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> This feels like we are papering over a hole in the PCI core.
> Is there no way of detecting Secondary Bus Reset (SBR) and
> communicate that down to the device?
> +CC Bjorn. 
> Most of the logic would be needed in driver anyway though as
> we don't want to bother warning on SBR if there was no memory mapped.
> 
> Bjorn, would you prefer this FLR vs SBR being detected by state
> change in driver, or a modification to the PCI core so that it
> provides this info to the drivers?

I guess this is about pci_reset_function() and similar paths, which
call .reset_prepare() in pci_dev_save_and_disable() before the reset
and call .reset_done() afterwards, and the question is whether we
should pass a new parameter to .reset_done() to tell the driver what
type of reset was done?

That seems *possible*, but kind of a hassle because there are several
different reset methods (six in pci_reset_fn_methods[] plus
device-specific things in pci_dev_reset_methods[] and a few more in
various hotplug_slot_ops structs), and I guess we'd have to plumb them
all to return some indication of what kind of reset they used.

But even before we get that far, if pci_reset_function() just does
nothing on these devices because SBRs are masked by default, that
sounds like it needs to be fixed first.

> I assume this pretty unique
> to CXL as normally there isn't a magic control to ignore triggering
> a reset.
> 
> One trivial comment inline.
> 
> Jonathan
> 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index e59d9d37aa65..81d9f57d2e84 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -45,6 +45,17 @@ int cxl_num_decoders_committed(struct cxl_port *port)
> >  	return port->commit_end + 1;
> >  }
> >  
> > +int cxl_num_decoders_committed_locked(struct cxl_port *port)
> > +{
> > +	int decoders;
> > +
> > +	guard(rwsem_read)(&cxl_region_rwsem);
> > +	decoders = cxl_num_decoders_committed(port);
> 
> return cxl_num_decoder_commited(port);
> 
> > +
> > +	return decoders;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed_locked, CXL);
> > +
> >  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
> >  			    char *buf)
> >  {
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index b6017c0c57b4..530c7e693096 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -720,6 +720,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
> >  }
> >  
> >  int cxl_num_decoders_committed(struct cxl_port *port);
> > +int cxl_num_decoders_committed_locked(struct cxl_port *port);
> >  bool is_cxl_port(const struct device *dev);
> >  struct cxl_port *to_cxl_port(const struct device *dev);
> >  struct pci_bus;
> > @@ -800,6 +801,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
> >  int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
> >  			struct cxl_endpoint_dvsec_info *info);
> > +bool cxl_dvsec_rr_active(struct device *dev, int d);
> >  
> >  bool is_cxl_region(struct device *dev);
> >  
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 5303d6942b88..9f1814005322 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -440,6 +440,7 @@ struct cxl_dev_state {
> >  	struct resource ram_res;
> >  	u64 serial;
> >  	enum cxl_devtype type;
> > +	bool active_rr_prereset;
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 233e7c42c161..5a5fda7134f6 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -957,11 +957,42 @@ static void cxl_error_resume(struct pci_dev *pdev)
> >  		 dev->driver ? "successful" : "failed");
> >  }
> >  
> > +static void cxl_reset_prepare(struct pci_dev *pdev)
> > +{
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > +
> > +	if (cxl_num_decoders_committed_locked(cxlmd->endpoint))
> > +		cxlds->active_rr_prereset = true;
> > +}
> > +
> > +static void cxl_reset_done(struct pci_dev *pdev)
> > +{
> > +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > +	struct device *dev = &cxlmd->dev;
> > +
> > +	/*
> > +	 * FLR does not expect to touch the HDM decoders and related registers.
> > +	 * SBR however will wipe all device configurations.
> > +	 * Issue warning if there was active configuration before reset that no
> > +	 * longer exists.
> > +	 */
> > +	if (cxlds->active_rr_prereset &&
> > +	    !cxl_dvsec_rr_active(&pdev->dev, cxlds->cxl_dvsec)) {
> > +		dev_warn(dev, "SBR happened without memory regions removal.\n");
> > +		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");
> > +	}
> > +	cxlds->active_rr_prereset = false;
> > +}
> > +
> >  static const struct pci_error_handlers cxl_error_handlers = {
> >  	.error_detected	= cxl_error_detected,
> >  	.slot_reset	= cxl_slot_reset,
> >  	.resume		= cxl_error_resume,
> >  	.cor_error_detected	= cxl_cor_error_detected,
> > +	.reset_prepare	= cxl_reset_prepare,
> > +	.reset_done	= cxl_reset_done,
> >  };
> >  
> >  static struct pci_driver cxl_pci_driver = {
> 
