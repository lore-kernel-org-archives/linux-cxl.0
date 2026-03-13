Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497F38C427;
	Fri, 13 Mar 2026 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405831; cv=none; b=WuXSbwROZn+2SCNVKG/cSRUI+1Q9x40elmXY8uhEHPUVAVcv1WaLuLeva36n674MGU/6pQ4+K57dWjoc3dZKsZKP1KzpUxFNahmpjiXpgUXTCL0gH0h60KZgpxMBjnQQ6xOY/3unngoGJEXW8GbmPDX8bEamJoqOgAFllUCJfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405831; c=relaxed/simple;
	bh=UvBrY6OeJl6/5WlQJjKbdDKg2BpDG+tDBNfVeZMKj0w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaiZeulI7HNsMrnoNLJtXh7w3m4sw74iGF7RW1kMSdrhlXeL6bMjj8FhBhwhvRabJSz9QakzwKDqrq4G7sxHt7tzGYP4/nOQIjXu5try1Zwl0N4bdkobA9IA8yQTRTTGU6jSowomjifcrJUQRFYy0O/XjJSclUe50DNdYUvtuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fXPKx4BCPzHnH5S;
	Fri, 13 Mar 2026 20:43:33 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 35B5040585;
	Fri, 13 Mar 2026 20:43:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 12:43:43 +0000
Date: Fri, 13 Mar 2026 12:43:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <mhonap@nvidia.com>, <aniketa@nvidia.com>, <ankita@nvidia.com>,
	<alwilliamson@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
	<mochs@nvidia.com>, <skolothumtho@nvidia.com>,
	<alejandro.lucero-palau@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <jgg@ziepe.ca>,
	<yishaih@nvidia.com>, <kevin.tian@intel.com>, <cjia@nvidia.com>,
	<targupta@nvidia.com>, <zhiw@nvidia.com>, <kjaju@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<kvm@vger.kernel.org>
Subject: Re: [PATCH 09/20] vfio/cxl: Implement CXL device detection and HDM
 register probing
Message-ID: <20260313124342.00001add@huawei.com>
In-Reply-To: <26be5ee3-d7ba-4bea-9824-c514341cf324@intel.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-10-mhonap@nvidia.com>
	<26be5ee3-d7ba-4bea-9824-c514341cf324@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 12 Mar 2026 15:31:03 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> > From: Manish Honap <mhonap@nvidia.com>
> > 
> > Implement the core CXL Type-2 device detection and component register
> > probing logic in vfio_pci_cxl_detect_and_init().
> > 
> > Three private helpers are introduced:
> > 
> >   vfio_cxl_create_device_state() allocates the per-device
> >   vfio_pci_cxl_state structure using devm_cxl_dev_state_create() so
> >   that lifetime is tied to the PCI device binding.
> > 
> >   vfio_cxl_find_bar() locates the PCI BAR that contains a given HPA
> >   range, returning the BAR index and offset within it.
> > 
> >   vfio_cxl_setup_regs() uses the CXL core helpers cxl_find_regblock()
> >   and cxl_probe_component_regs() to enumerate the HDM decoder register
> >   block, then records its BAR index, offset and size in the CXL state.
> > 
> > vfio_pci_cxl_detect_and_init() orchestrates detection:
> >   1. Check for CXL DVSEC via pcie_is_cxl() + pci_find_dvsec_capability().
> >   2. Allocate CXL device state.
> >   3. Temporarily call pci_enable_device_mem() for ioremap, then disable.
> >   4. Probe component registers to find the HDM decoder block.
> > 
> > On any failure vdev->cxl is devm_kfree'd so that device falls back to
> > plain PCI mode transparently.
> > 
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
Given Dave didn't crop anything I'll just reply on top and avoid duplication.

Mostly lifetime handling comments.  I get nervous when devm occurs in the middle
of non devm code. It needs to be done very carefully. I don't think you
have a bug here, but I'm not keen on the resulting difference in order of setup
and tear down.  I'd like cleanup to tidy it up even though it would be safe
to do later.


> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 151 +++++++++++++++++++++++++++
> >  drivers/vfio/pci/cxl/vfio_cxl_priv.h |   8 ++
> >  2 files changed, 159 insertions(+)
> > 
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 7698d94e16be..2da6da1c0605 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -18,6 +18,114 @@
> >  
> >  MODULE_IMPORT_NS("CXL");
> >  
> > +static int vfio_cxl_create_device_state(struct vfio_pci_core_device *vdev,
> > +					u16 dvsec)
> > +{
> > +	struct pci_dev *pdev = vdev->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct vfio_pci_cxl_state *cxl;
> > +	bool cxl_mem_capable, is_cxl_type3;
> > +	u16 cap_word;
> > +
> > +	/*
> > +	 * The devm allocation for the CXL state remains for the entire time
> > +	 * the PCI device is bound to vfio-pci. From successful CXL init
> > +	 * in probe until the device is released on unbind.
> > +	 * No extra explicit free is needed; devm handles it when
> > +	 * pdev->dev is released.
> > +	 */
> > +	vdev->cxl = devm_cxl_dev_state_create(dev,

Rather than assigning this in here, I'd use a local variable for 
the return of this, operate on that and return it from the function.
That both creates a clean separation and possibly make error
handling simpler later...

Also similar to some of the feedback Alejandro had on his type 2
series, be very careful with mixing devm calls and non devm,
generally that's a path to hard to read and reason about code.
I know you've stated this is fine because it's tied to the
PCI device lifetime and you are probably right on that, but
I'm not keen.

This might be a case where manual unwinding of devres is needed
(maybe using devres groups if we end up with a bunch of stuff
 to undo).



> > +					      CXL_DEVTYPE_DEVMEM,
> > +					      pdev->dev.id, dvsec,
> > +					      struct vfio_pci_cxl_state,
> > +					      cxlds, false);
> > +	if (!vdev->cxl)
> > +		return -ENOMEM;
> > +
> > +	cxl = vdev->cxl;
> > +	cxl->dvsec = dvsec;

That's a bit odd given we pass dvsec into devm_cxl_dev_state_create()
why doesn't it assign it?

> > +
> > +	pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
> > +			     &cap_word);
> > +
> > +	cxl_mem_capable = !!(cap_word & CXL_DVSEC_MEM_CAPABLE);
> > +	is_cxl_type3 = ((pdev->class >> 8) == PCI_CLASS_MEMORY_CXL);  
> 
> Both of these can use FIELD_GET().
> 
> > +
> > +	/*
> > +	 * Type 2 = CXL memory capable but NOT Type 3 (e.g. accelerator/GPU)
> > +	 * Unsupported for non cxl type-2 class of devices.

As in other places, type 3 doesn't mean that. What you mean is class
code compliant type 3. 

> > +	 */
> > +	if (!(cxl_mem_capable && !is_cxl_type3)) {
> > +		devm_kfree(&pdev->dev, vdev->cxl);

As below. That needs a name that makes it clear it is the right devm call.

> > +		vdev->cxl = NULL;
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
> > +{
> > +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> > +	struct cxl_register_map *map = &cxl->cxlds.reg_map;
> > +	resource_size_t offset, bar_offset, size;
> > +	struct pci_dev *pdev = vdev->pdev;
> > +	void __iomem *base;
> > +	u32 count;
> > +	int ret;
> > +	u8 bar;
> > +
> > +	if (WARN_ON_ONCE(!pci_is_enabled(pdev)))
> > +		return -EINVAL;
> > +
> > +	/* Find component register block via Register Locator DVSEC */
> > +	ret = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, map);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Temporarily map the register block */
> > +	base = ioremap(map->resource, map->max_size);  
> 
> Request the mem region before mapping it?
> 
> DJ
> 
> > +	if (!base)
> > +		return -ENOMEM;
> > +
> > +	/* Probe component register capabilities */
> > +	cxl_probe_component_regs(&pdev->dev, base, &map->component_map);
> > +
> > +	/* Unmap immediately */
> > +	iounmap(base);
> > +
> > +	/* Check if HDM decoder was found */
> > +	if (!map->component_map.hdm_decoder.valid)
> > +		return -ENODEV;
> > +
> > +	pci_dbg(pdev,
> > +		"vfio_cxl: HDM decoder at offset=0x%lx, size=0x%lx\n",
> > +		map->component_map.hdm_decoder.offset,
> > +		map->component_map.hdm_decoder.size);
> > +
> > +	/* Get HDM register info */
> > +	ret = cxl_get_hdm_reg_info(&cxl->cxlds, &count, &offset, &size);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!count || !size)
> > +		return -ENODEV;
> > +
> > +	cxl->hdm_count = count;
> > +	cxl->hdm_reg_offset = offset;
> > +	cxl->hdm_reg_size = size;
> > +
> > +	ret = cxl_regblock_get_bar_info(map, &bar, &bar_offset);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cxl->comp_reg_bar = bar;
> > +	cxl->comp_reg_offset = bar_offset;
> > +	cxl->comp_reg_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2 device
> >   * @vdev: VFIO PCI device
> > @@ -28,8 +136,51 @@ MODULE_IMPORT_NS("CXL");
> >   */
> >  void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
> >  {
> > +	struct pci_dev *pdev = vdev->pdev;
> > +	struct vfio_pci_cxl_state *cxl;
> > +	u16 dvsec;
> > +	int ret;
> > +
> > +	if (!pcie_is_cxl(pdev))
> > +		return;
> > +
> > +	dvsec = pci_find_dvsec_capability(pdev,
> > +					  PCI_VENDOR_ID_CXL,
> > +					  PCI_DVSEC_CXL_DEVICE);
> > +	if (!dvsec)
> > +		return;
> > +
> > +	ret = vfio_cxl_create_device_state(vdev, dvsec);
Suggestion above would lead to.
	cxl = vfio_cxl_create_device_state(vdev, dvsec);
	if (IS_ERR(cxl))
		return PTR_ERR(cxl); //assuming failing at this point is fatal.

then only set vdev->cxl once you are sure this function succeeded.
Thus removing the need to set it to NULL on failure.
You need to pass it into a few more calls though.


> > +	if (ret)
> > +		return;
> > +
> > +	cxl = vdev->cxl;
> > +
> > +	/*
> > +	 * Required for ioremap of the component register block and
> > +	 * calls to cxl_probe_component_regs().
> > +	 */
> > +	ret = pci_enable_device_mem(pdev);
> > +	if (ret)
> > +		goto failed;
> > +
> > +	ret = vfio_cxl_setup_regs(vdev);
> > +	if (ret) {
> > +		pci_disable_device(pdev);
> > +		goto failed;
> > +	}
> > +
> > +	pci_disable_device(pdev);
> > +
AS above, I think this would be cleaner if only here do we have

	vdev->cxl = cxl;

> > +	return;
> > +
> > +failed:
> > +	devm_kfree(&pdev->dev, vdev->cxl);

If you get here you found a CXL device but couldn't handle it. Is it useful
to continue?  I'd suggest probably not.   If returning an error then devm
cleanup happens.  Also, we should have a wrapper around devm_kfree to
make it clear that it is valid to use it for undoing the 
 devm_cxl_dev_state_create() (I haven't even checked it is valid)

> > +	vdev->cxl = NULL;
> >  }
if /* __LINUX_VFIO_CXL_PRIV_H */  
> 
> 

