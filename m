Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7237CD5D;
	Fri, 13 Mar 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406357; cv=none; b=kmhdMNIoNTCcfjh1VVqa/TCLKqtLekEmGUoD8ehlOqgECAP7RqaK0kWPGUDkrKOnEHQo3eMOkkHG3nrn7rn+I7iocqNRnm/pq/u+M/n5v8n+VxcE/HlzKtZ4vfEGDqloRyxGZY+cicgSIWHHSTdpDHICmXfb2gf91KsrmZ8fLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406357; c=relaxed/simple;
	bh=z1NrhoS2arEeU6bb58a3S87URBXgo7u1s/Lj3Ophcbw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQVJe1y3MYf4/yP3ZiR5Tjvyk2CCLB+/5vVJbObi4cjoWecoz5D/KZj0VDqc010dSiJFxww7uLKFShCOSIUuVfOT9hWEylwUHkUN/Gc1+8/CTcn4MJgyutiP+4gmKEJ244ih6zf6WHgMOeJ0OCJjZCoQH4EHhrB520orDrAgSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fXPX54xMCzHnGd9;
	Fri, 13 Mar 2026 20:52:21 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 545B240585;
	Fri, 13 Mar 2026 20:52:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 12:52:32 +0000
Date: Fri, 13 Mar 2026 12:52:30 +0000
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
Subject: Re: [PATCH 10/20] vfio/cxl: CXL region management
Message-ID: <20260313125230.000058dd@huawei.com>
In-Reply-To: <e2eaa470-c57b-4fa5-9810-4224ed314445@intel.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-11-mhonap@nvidia.com>
	<e2eaa470-c57b-4fa5-9810-4224ed314445@intel.com>
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

On Thu, 12 Mar 2026 15:55:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> > From: Manish Honap <mhonap@nvidia.com>
> > 
> > Add CXL region management for future guest access.
> > 
> > Region Management makes use of APIs provided by CXL_CORE as below:
> > 
> > CREATE_REGION flow:
> > 1. Validate request (size, decoder availability)
> > 2. Allocate HPA via cxl_get_hpa_freespace()
> > 3. Allocate DPA via cxl_request_dpa()
> > 4. Create region via cxl_create_region() - commits HDM decoder!
> > 5. Get HPA range via cxl_get_region_range()
> > 
> > DESTROY_REGION flow:
> > 1. Detach decoder via cxl_decoder_detach()
> > 2. Free DPA via cxl_dpa_free()
> > 3. Release root decoder via cxl_put_root_decoder()
> > 
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
A few additional comments from me.

> > ---
> >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 118 ++++++++++++++++++++++++++-
> >  drivers/vfio/pci/cxl/vfio_cxl_priv.h |   5 ++
> >  drivers/vfio/pci/vfio_pci_priv.h     |   8 ++
> >  3 files changed, 130 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > index 2da6da1c0605..9c71f592e74e 100644
> > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -126,6 +126,112 @@ static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev)
> >  	return 0;
> >  }
> >  
> > +int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev, resource_size_t size)
> > +{
> > +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> > +	resource_size_t max_size;
> > +	int ret;
> > +
> > +	if (cxl->precommitted)
> > +		return 0;
> > +
> > +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
> > +					   CXL_DECODER_F_RAM |
> > +					   CXL_DECODER_F_TYPE2,
> > +					   &max_size);  
> 
> Not sure what VFIO subsystem's policy is on scoped base resource cleanup, but a __free() here can get you out of managing put() of the root decoder.
> 
> > +	if (IS_ERR(cxl->cxlrd))
> > +		return PTR_ERR(cxl->cxlrd);
> > +
> > +	/* Insufficient HPA space */
> > +	if (max_size < size) {
> > +		cxl_put_root_decoder(cxl->cxlrd);
> > +		cxl->cxlrd = NULL;
Similar to other cases, I'd keep assigning stuff in cxl to the point
where there are no more error paths.  Use local variables until then.
(that would fit with using __free() as well which I'd also favor if
 accepted in VFIO).

> > +		return -ENOSPC;
> > +	}
> > +
> > +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM, size);  
> 
> Same comment here about __free().
> 
> > +	if (IS_ERR(cxl->cxled)) {
> > +		ret = PTR_ERR(cxl->cxled);
> > +		goto err_free_hpa;
> > +	}
> > +
> > +	cxl->region = cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
> > +	if (IS_ERR(cxl->region)) {
> > +		ret = PTR_ERR(cxl->region);

You carefully NULL this in vfio_cxl_destroy_region, but if you fail
here you end up with it containing an ERR_PTR(). I'd avoid that by
using a local variable and only assigning cxl->region after this
suceeds.

> > +		goto err_free_dpa;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free_dpa:
> > +	cxl_dpa_free(cxl->cxled);
> > +err_free_hpa:
> > +	if (cxl->cxlrd)
> > +		cxl_put_root_decoder(cxl->cxlrd);
> > +
> > +	return ret;
> > +}
> > +
> > +void vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev)
> > +{
> > +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> > +
> > +	if (!cxl->region)
> > +		return;
> > +
> > +	cxl_unregister_region(cxl->region);
> > +	cxl->region = NULL;
> > +
> > +	if (cxl->precommitted)
> > +		return;
> > +
> > +	cxl_dpa_free(cxl->cxled);
> > +	cxl_put_root_decoder(cxl->cxlrd);
> > +}
> > +
> > +static int vfio_cxl_create_region_helper(struct vfio_pci_core_device *vdev,
> > +					 resource_size_t capacity)
> > +{
> > +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> > +	struct pci_dev *pdev = vdev->pdev;
> > +	int ret;
> > +
> > +	if (cxl->precommitted) {
> > +		cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd,
> > +						       &cxl->region);
> > +		if (IS_ERR(cxl->cxled))
> > +			return PTR_ERR(cxl->cxled);
> > +	} else {
> > +		ret = vfio_cxl_create_cxl_region(vdev, capacity);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (cxl->region) {  
> 
> Maybe if you do 'if (!cxl->region)' first and just exit, then you don't need to indent the normal code path.
> 
> > +		struct range range;
> > +
> > +		ret = cxl_get_region_range(cxl->region, &range);
> > +		if (ret)
> > +			goto failed;
> > +
> > +		cxl->region_hpa = range.start;
> > +		cxl->region_size = range_len(&range);
> > +
> > +		pci_dbg(pdev, "Precommitted decoder: HPA 0x%llx size %lu MB\n",
> > +			cxl->region_hpa, cxl->region_size >> 20);
> > +	} else {
> > +		pci_err(pdev, "Failed to create CXL region\n");
> > +		ret = -ENODEV;
> > +		goto failed;
> > +	}
> > +
> > +	return 0;
> > +
> > +failed:
> > +	vfio_cxl_destroy_cxl_region(vdev);

Little bit of refactoring and this could be replaced with __free() magic.

> > +	return ret;
> > +}
> > +
> >  /**
> >   * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2 device
> >   * @vdev: VFIO PCI device
> > @@ -172,6 +278,12 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
> >  
> >  	pci_disable_device(pdev);
> >  
> > +	ret = vfio_cxl_create_region_helper(vdev, SZ_256M);  
> 
> Maybe a comment on why this size?
:)  I wondered that as well.  I'm guessing your bios isn't always providing
the decoder and this lets you test.


> 
> DJ
> 
> > +	if (ret)
> > +		goto failed;
> > +
> > +	cxl->precommitted = true;
> > +
> >  	return;
> >  
> >  failed:
> > @@ -181,6 +293,10 @@ void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
> >  
> >  void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)
> >  {
> > -	if (!vdev->cxl)
> > +	struct vfio_pci_cxl_state *cxl = vdev->cxl;

Do that in the earlier patch to reduce churn a tiny bit.

> > +
> > +	if (!cxl || !cxl->region)
> >  		return;
> > +
> > +	vfio_cxl_destroy_cxl_region(vdev);
> >  }

