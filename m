Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09C381AC
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352414; cv=none; b=bS2KzNfTCXNH95a6JwItM8pMUMXRpPY3PiMuYsT2ZamupBvG1vgo897QTBdoJwCORfLSxdW5qfA5IneJDMUsUCZSdLnFJFi039NXDXurwHGQ/IWHsVS/TlYyOdfm/DcbhMenpu3VvLxlpFGBe0C4yFJPL+iNCNTjyI8MO2I0sfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352414; c=relaxed/simple;
	bh=TbVBl3gMH5TQ5M4F8dtekEDQaoGEPnHNSQBUq6wV74g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rj2lzZiP3UD5RgG34BoX3PSerscdGsJKPnahbBhlWqCIA6nsmwbV8ZtVw+oCn8ZVXfoS1Iv7vw25Wmn11EXc/1d05a2wNGr9cGwlDJdb7V0/l+/3rKPY9aPv+un9rYiJ2GAguG5QUZ9nnEgFGdMWy8/rJVeXlCMoS54/TLcDE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdl2p34TZz6K9Gp;
	Mon, 19 Feb 2024 22:16:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1974C140D26;
	Mon, 19 Feb 2024 22:20:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 14:20:07 +0000
Date: Mon, 19 Feb 2024 14:20:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH] cxl: Add post reset warning if the reset is detected as
 Secondary Bus Reset (SBR)
Message-ID: <20240219142006.000056a4@Huawei.com>
In-Reply-To: <20240215232307.2793530-1-dave.jiang@intel.com>
References: <20240215232307.2793530-1-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 15 Feb 2024 16:23:07 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> SBR is equivalent to a device been hot removed and inserted again. Doing a
> SBR on a CXL type 3 device is problematic if the exported device memory is
> part of system memory that cannot be offlined. The event is equivalent to
> violently ripping out that range of memory from the kernel. While the
> hardware requires the "Unmask SBR" bit set in the Port Control Extensions
> register and the kernel currently does not unmask it, user can unmask
> this bit via setpci or similar tool.
> 
> The driver does not have a way to detect whether a reset coming from the
> PCI subsystem is a Function Level Reset (FLR) or SBR. The only way to
> detect is to note if there are active decoders before the reset and check
> if the range register memory active bit remains set after reset.
> 
> A helper function to check is added to detect if the range register memory
> active bit is set. A locked helper for cxl_num_decoders_committed() is also
> added to allow pci code to call the cxl_num_decoders_committed() while
> holding the cxl_region_rwsem.
> 
> Add a err_handler->reset_prepare() to detect whether there are active
> decoders.  Add a err_handler->reset_done() to check if there was active
> memory before the reset and it is no longer active after the reset. A
> warning is emitted in the case of active memory has been offlined.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

This feels like we are papering over a hole in the PCI core.
Is there no way of detecting Secondary Bus Reset (SBR) and
communicate that down to the device?
+CC Bjorn. 
Most of the logic would be needed in driver anyway though as
we don't want to bother warning on SBR if there was no memory mapped.

Bjorn, would you prefer this FLR vs SBR being detected by state
change in driver, or a modification to the PCI core so that it
provides this info to the drivers?  I assume this pretty unique
to CXL as normally there isn't a magic control to ignore triggering
a reset.

One trivial comment inline.

Jonathan

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e59d9d37aa65..81d9f57d2e84 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -45,6 +45,17 @@ int cxl_num_decoders_committed(struct cxl_port *port)
>  	return port->commit_end + 1;
>  }
>  
> +int cxl_num_decoders_committed_locked(struct cxl_port *port)
> +{
> +	int decoders;
> +
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	decoders = cxl_num_decoders_committed(port);

return cxl_num_decoder_commited(port);

> +
> +	return decoders;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_num_decoders_committed_locked, CXL);
> +
>  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b6017c0c57b4..530c7e693096 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -720,6 +720,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  }
>  
>  int cxl_num_decoders_committed(struct cxl_port *port);
> +int cxl_num_decoders_committed_locked(struct cxl_port *port);
>  bool is_cxl_port(const struct device *dev);
>  struct cxl_port *to_cxl_port(const struct device *dev);
>  struct pci_bus;
> @@ -800,6 +801,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>  int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
>  			struct cxl_endpoint_dvsec_info *info);
> +bool cxl_dvsec_rr_active(struct device *dev, int d);
>  
>  bool is_cxl_region(struct device *dev);
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5303d6942b88..9f1814005322 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -440,6 +440,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	bool active_rr_prereset;
>  };
>  
>  /**
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 233e7c42c161..5a5fda7134f6 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -957,11 +957,42 @@ static void cxl_error_resume(struct pci_dev *pdev)
>  		 dev->driver ? "successful" : "failed");
>  }
>  
> +static void cxl_reset_prepare(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +
> +	if (cxl_num_decoders_committed_locked(cxlmd->endpoint))
> +		cxlds->active_rr_prereset = true;
> +}
> +
> +static void cxl_reset_done(struct pci_dev *pdev)
> +{
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> +	struct device *dev = &cxlmd->dev;
> +
> +	/*
> +	 * FLR does not expect to touch the HDM decoders and related registers.
> +	 * SBR however will wipe all device configurations.
> +	 * Issue warning if there was active configuration before reset that no
> +	 * longer exists.
> +	 */
> +	if (cxlds->active_rr_prereset &&
> +	    !cxl_dvsec_rr_active(&pdev->dev, cxlds->cxl_dvsec)) {
> +		dev_warn(dev, "SBR happened without memory regions removal.\n");
> +		dev_warn(dev, "System may be unstable if regions hosted system memory.\n");
> +	}
> +	cxlds->active_rr_prereset = false;
> +}
> +
>  static const struct pci_error_handlers cxl_error_handlers = {
>  	.error_detected	= cxl_error_detected,
>  	.slot_reset	= cxl_slot_reset,
>  	.resume		= cxl_error_resume,
>  	.cor_error_detected	= cxl_cor_error_detected,
> +	.reset_prepare	= cxl_reset_prepare,
> +	.reset_done	= cxl_reset_done,
>  };
>  
>  static struct pci_driver cxl_pci_driver = {

