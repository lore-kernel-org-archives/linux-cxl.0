Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD30331A7E;
	Fri, 10 Jul 2026 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721347; cv=none; b=Wn9r8RTq/kY+Ak8aaSn6vLNSRqsQenPZkth9v7NADdkuEl2dkYFP04dZ6+MqyY0vqmQh6y0C5vRM7sU3wergYFCnDn2renQAISiodDqA5XTcdZOsvIYrF+5Ee4YiXgnD48mv4+5HLDx+aRJrGTBy4BJR6+l9H20h4HpCpvgX1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721347; c=relaxed/simple;
	bh=PgwSs0hDroFDVh66+GeKk0RoQRpxD7pwigmXj+9OOw0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NCTbsGaeVNruNkXV6q48m12+mHlYl8EhsJ8mIQ3rFxpGdIrUYPHvF4O7Rzhuze5U0loX0hKQ4jPMMPmpExsKWcLuQ1epHLtqzB0WhYLRYTObmzfq+qGxVggi59LBamj+JFjgM02eW/dlw/Nzu7ZwokA1vDvGp6aIbgwCLW4GnEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJQNwXbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJQNwXbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821B91F00A3A;
	Fri, 10 Jul 2026 22:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783721345;
	bh=8RIAbAfybpAIUyqGEkw+zfng9AgfFDST8G4sFtli3E8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=oJQNwXbZ+DM/vrOD/vDKUCXAr2wXO27fOqed1Jgw8aRLgR5UArw+XBndICWogAcHR
	 e+SyjfjegY6UMiSa0lqW4acY5yBNWSDUHpjMPtag+88JyPfmamwLIfr9F68Uxsf/uz
	 mpAHmOVT/OLm7KcH4qyGA2NkrOWib0SzBazeJs/XoEg07vIPcVpoxOtpooNyNfa6mA
	 hsK1F+rW0+MQ3n3vRoW0Ee+wmFgHAJp88LHozesh2/EmYi1kfTCGWl4Aeks+XYaGWj
	 eeYjgpFrfqLdPo0j7N8/8K03b1fbbKR/e9rG5wsqirpAAbW6HFOk+FjGj2YYzQGUnl
	 wXCvDeEZiMz3Q==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B6353F401F7;
	Fri, 10 Jul 2026 18:09:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 18:09:03 -0400
X-ME-Sender: <xms:f21RaqyYaBfVpZVlY49q7uKvmO_oV37Unmj4kYTx5IDNlOy865wuSg>
    <xme:f21RahCaby_xczqTdmXilgWHgskYeGyVauhqM3iGv-SF5GdGgyMHFsZRYD9S57vLQ
    HkrLwf6YrzOAiwOu9LJgm9UBCA6ntcQwocT1U8EHR2D1QcvsHkl46CA>
X-ME-Received: <xmr:f21RarPIUWoBrmI-HsdAx5fh6MqXUP1RN5UyonN0hTjjH_ekhy6xqhDZZYXLXJPhfW8TXxlnD4jjhi2NQxgpw7wO4l9FoiCXtV8>
X-ME-Proxy-Cause: dmFkZTEn+eWyFc00+AGqjnwpynLXuA5R/Ebkj45KWFU/p5tUktQVXGuGguxeW0jD5pDJTN
    dSXacLoNFEI6k/YAW21oQHHMAU+JpvzK0FoXhR/pMWlzwVpSQfYqWAx1c2Hgr5zE0wmyd7
    K0OSx4o4ggx6T+Fwgerl4iWDG+vYiUkC1B+dylIz4+v3bH/O9Eejv0/cZbt2jVjAeHi2la
    4XyR4BXh8Be/YGP/BV92LbDSi8SBTw7qS0cJMlNKsWgFZOddkeTv7K4e58Px6jeqbhRCLx
    T611jMQ60NckjBo0l7Ka0alSqZuruaHHK8zw3hghKMz5SHYnn9cPsySe/MLox4yN1SQLAL
    xmyWIiiooDU/Oum6d0QEFDCtEY8KMzCK+aHpGG3T/ZM7WUK7tjfhHoIUIlNzQlj3sUqADt
    9XoOGTuXvWasWS7cNsAQ+/rZza1mMEioYN0HbmedRd92ZaLyWyrZNGGLS8kVH9CM3ZZC0o
    lHUHlINW5kEBFJzyUn6dlX0WmY3B35cLMdn6sJjsUjjUTQYCKmddbv2zT6gAn/wyLqmmnG
    OZWWL8G4hC3Pmf21C8+LbbY0fCzNHrkx4aIGIFBqKDVdO2aGpbcAC5USGQ+gXnMN0iDmqw
    I8Fxn/eGkYRtqU6TWk8us1KqAUExNyEV17eMUfQEb2zPlSMoemkP7b2PMBUg
X-ME-Proxy: <xmx:f21RanSfb5qsuNrLceieRrskxoVioFIbZTG-aPipo4lbw6Usf7UqQw>
    <xmx:f21Rastj42_vr-ioH-qP8-VZdglOrZc2A_DNuq2X_T9Syy5ua_zKNw>
    <xmx:f21RalUfW0F1FBWocs_raKrWvLljYIwPBSngXC3mIzVce718B4D8pQ>
    <xmx:f21RagnGKryEud_KyEf1swo2YgBpLbAti6dyfaCLwSWM-imtVPQBXw>
    <xmx:f21RaoC6NrlkS9DblYnC3W36Z177POnOcTneUeCfujkzpmpd3Zjfpb-A>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 18:09:02 -0400 (EDT)
Date: Fri, 10 Jul 2026 15:09:02 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: mhonap@nvidia.com, 
 djbw@kernel.org, 
 alex@shazbot.org, 
 jgg@ziepe.ca, 
 jic23@kernel.org, 
 dave.jiang@intel.com, 
 ankita@nvidia.com, 
 alejandro.lucero-palau@amd.com, 
 alison.schofield@intel.com, 
 dave@stgolabs.net, 
 dmatlack@google.com, 
 gourry@gourry.net, 
 ira.weiny@intel.com
Cc: cjia@nvidia.com, 
 kjaju@nvidia.com, 
 vsethi@nvidia.com, 
 zhiw@nvidia.com, 
 mhonap@nvidia.com, 
 kvm@vger.kernel.org, 
 linux-cxl@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <6a516d7e2216f_3cfbb510079@djbw-dev.notmuch>
In-Reply-To: <20260625165407.1769572-9-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
 <20260625165407.1769572-9-mhonap@nvidia.com>
Subject: Re: [PATCH v3 08/11] vfio/pci/cxl: Add HDM + COMP_REGS regions and
 DVSEC clipping shim
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

mhonap@ wrote:
> From: Manish Honap <mhonap@nvidia.com>
> =

> Complete the vfio-pci-core integration of CXL Type-2 device
> passthrough by exposing two VFIO regions to userspace, wiring DVSEC
> config-space accesses through cxl-core's register-virtualization
> helpers, and reserving the CXL component register block from BAR
> mmap and BAR resource claim.
> =

> HDM region (VFIO_REGION_SUBTYPE_CXL):
>   - mmappable view of the device's firmware-committed HPA range
>   - mmap fault handler calls vmf_insert_pfn() from the physical HPA
>     so the guest gets the same backing memory the host sees
>   - pread/pwrite go through the memremap_wb() kva captured at
>     bind time by vfio_cxl_map_hdm()
> =

> COMP_REGS region (VFIO_REGION_SUBTYPE_CXL_COMP_REGS):
>   - pread/pwrite only, dword-aligned (-EINVAL on misalignment)
>   - thin transport: each dword dispatches by offset to
>     cxl_passthrough_cm_rw() (CM cap-array snapshot) or
>     cxl_passthrough_hdm_rw() (HDM Decoder block).  No shadow buffer
>     on the vfio side; all per-field semantics live in cxl-core.
> =

> DVSEC config-space access:
>   - vfio_pci_cxl_config_boundary() clips a chunk at the CXL Device
>     DVSEC body edge in vfio_pci_config_rw_single() so the generic
>     perm-bits path handles the DVSEC header bytes and the CXL hook
>     handles the body bytes.  The clipping shim is used instead of
>     re-pointing the ecap_perms[] readfn/writefn (which would mutate
>     a module-init static and race across multiple CXL devices).
>   - vfio_pci_cxl_config_rw() forwards clipped accesses to
>     cxl_passthrough_dvsec_rw(); cxl-core enforces the per-field
>     write semantics (LOCK/RWO, CONTROL/RWL, STATUS/RW1C,
>     RANGE1/HwInit, RANGE2/RsvdZ).
> =

> GET_INFO / GET_REGION_INFO:
>   - VFIO_DEVICE_INFO_CAP_CXL advertises the two region indices, the
>     component BAR layout, and HOST_FIRMWARE_COMMITTED.
>   - GET_REGION_INFO on the component BAR returns a sparse-mmap cap
>     that excludes [comp_reg_offset, comp_reg_offset+comp_reg_size).
> =

> BAR resource handling:
>   - cxl-core holds request_mem_region() on the CXL component
>     register sub-range from devm_cxl_probe_mem(), so vfio_pci-core's
>     pci_request_selected_regions() on the full BAR would collide.
>     map_bars() skips the request for the component BAR (still iomaps
>     it; vfio holds the BAR via driver binding); disable() mirrors
>     the asymmetric skip.
>   - mmap of the component BAR refuses any range overlapping the CXL
>     sub-range via vfio_pci_cxl_mmap_overlaps_comp_regs().
> =

> vfio_pci_cxl_open() now registers both VFIO regions; close()
> unregisters them.  Raw BAR rw redirect into the CXL sub-range is
> intentionally not implemented: VMMs use the COMP_REGS region
> directly.

I jumped ahead in the review to see how passthrough.c was being
used.

This patch is doing a lot which raises the risk that individual
proposals within it are going to raise questions.

> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 521 ++++++++++++++++++++++++++-=

>  drivers/vfio/pci/vfio_pci_config.c   |  31 ++
>  drivers/vfio/pci/vfio_pci_core.c     |  44 ++-
>  drivers/vfio/pci/vfio_pci_priv.h     |  72 ++++
>  drivers/vfio/pci/vfio_pci_rdwr.c     |  17 +
>  5 files changed, 679 insertions(+), 6 deletions(-)
> =

> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cx=
l/vfio_cxl_core.c
> index 42cd00bbe869..8a00b776d7c7 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -123,12 +123,24 @@ static int vfio_cxl_probe_regs(struct vfio_pci_cx=
l_state *cxl)
>  	if (rc)
>  		return rc;
>  =

> +	/*
> +	 * The CXL Component Register block is a fixed 64 KiB area (CXL r4.0
> +	 * =C2=A78.2.3).  cxl_pci_setup_regs() records the remaining BAR leng=
th
> +	 * after the regblock offset in reg_map.max_size, which is an upper
> +	 * bound, not the spec-defined size.  Bail if the BAR does not have
> +	 * room for a full component register block at the recorded offset,
> +	 * and publish the spec size so the UAPI, sparse-mmap exclusion, and
> +	 * COMP_REGS region all agree on the same window.
> +	 */
> +	if (cxlds->reg_map.max_size < CXL_COMPONENT_REG_BLOCK_SIZE)
> +		return -ENXIO;

This feels like a generic check that should not be vfio specific...

Indeed it is an existing check in cxl_decode_regblock() that already
makes this assertion.

>  	cxl->info.hdm_count               =3D hdm_count;
>  	cxl->info.hdm_reg_offset          =3D hdm_off;
>  	cxl->info.hdm_reg_size            =3D hdm_size;
>  	cxl->info.comp_reg_bir            =3D bir;
>  	cxl->info.comp_reg_offset         =3D bar_off;
> -	cxl->info.comp_reg_size           =3D cxlds->reg_map.max_size;
> +	cxl->info.comp_reg_size           =3D CXL_COMPONENT_REG_BLOCK_SIZE;
>  	cxl->info.host_firmware_committed =3D true;
>  =

>  	/*
> @@ -354,16 +366,515 @@ void vfio_pci_cxl_release(struct vfio_pci_core_d=
evice *vdev)
>  	vdev->cxl =3D NULL;
>  }
>  =

> +static int vfio_pci_cxl_register_hdm(struct vfio_pci_core_device *vdev=
);
> +static int vfio_pci_cxl_register_comp_regs(struct vfio_pci_core_device=
 *vdev);
> +
>  int vfio_pci_cxl_open(struct vfio_pci_core_device *vdev)
>  {
> +	struct vfio_pci_cxl_state *cxl =3D vdev->cxl;
> +	int rc;
> +
> +	if (!cxl)
> +		return 0;	/* plain vfio-pci device */
> +
> +	rc =3D vfio_pci_cxl_register_comp_regs(vdev);
> +	if (rc) {
> +		pci_warn(vdev->pdev,
> +			 "vfio-cxl: COMP_REGS region register failed (%d)\n",
> +			 rc);
> +		return rc;
> +	}
> +
> +	rc =3D vfio_pci_cxl_register_hdm(vdev);
> +	if (rc) {
> +		pci_warn(vdev->pdev,
> +			 "vfio-cxl: HDM region register failed (%d)\n", rc);
> +		/*
> +		 * COMP_REGS already registered above.  vfio core does not
> +		 * call close_device() when open_device() returns an error,
> +		 * so roll back the COMP_REGS dynamic region here to avoid
> +		 * a leaked half-registered open state.
> +		 */
> +		vfio_pci_cxl_close(vdev);
> +		return rc;
> +	}
> +	return 0;
> +}
> +
> +void vfio_pci_cxl_close(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl =3D vdev->cxl;
> +	unsigned int i;
> +
> +	if (!cxl)
> +		return;
> +
> +	for (i =3D vdev->num_regions; i > 0; i--) {
> +		struct vfio_pci_region *r =3D &vdev->region[i - 1];
> +
> +		if (r->data !=3D cxl)
> +			break;
> +		if (r->ops->release)
> +			r->ops->release(vdev, r);
> +		vdev->num_regions--;
> +	}
> +}
> +
> +/* ------------------------------------------------------------------ =
*/
> +/* HDM region: mmappable view of the device's HPA range               =
*/
> +/* ------------------------------------------------------------------ =
*/
> +
> +static vm_fault_t hdm_region_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	struct vfio_pci_cxl_state *cxl =3D vma->vm_private_data;
> +	unsigned long off =3D (vmf->address - vma->vm_start) +
> +			    (vma->vm_pgoff << PAGE_SHIFT);
> +	phys_addr_t pa;
> +
> +	if (!cxl || !cxl->info.hpa_size)
> +		return VM_FAULT_SIGBUS;
> +	if (off >=3D cxl->info.hpa_size)
> +		return VM_FAULT_SIGBUS;
> +
> +	pa =3D cxl->info.hpa_base + off;
> +	return vmf_insert_pfn(vma, vmf->address, PHYS_PFN(pa));

It seems unfortunate that this reimplements vfio_pci_mmap_ops without
huge mapping support. If CXL is going to be a first class citizen in
vfio then why not extend vfio_pci_core_device with the concept that
devices can have HDM ranges, or some scheme to address large mappings
from day one.

[..]
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> index 05ab4ae59157..2d2dae278d1e 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -501,6 +501,23 @@ static void vfio_pci_core_map_bars(struct vfio_pci=
_core_device *vdev)
>  		if (!pci_resource_len(pdev, i))
>  			continue;
>  =

> +		/*
> +		 * cxl-core already holds request_mem_region() on the CXL
> +		 * component register sub-range of this BAR.  Skip the
> +		 * full-BAR request so we do not collide with that
> +		 * sub-region; vfio still owns the BAR via the driver
> +		 * binding and the iomap below succeeds without a region
> +		 * claim.
> +		 */

Rather than working around a problem in the CXL core why not fix it?
This is the second time someone has run across a conflict with
devm_cxl_iomap_block() when trying to reuse CXL code.

devm_cxl_iomap_block() was a response to folks wanting /dev/mem access
to CXL BAR space. When VFIO owns the whole BAR it should be blocking
/dev/mem access to enforce going through VFIO.

I think this looks like a flag on cxl_register_map that only cxl_pci
sets to indicate the legacy special mode of doing piecemeal resource
requests of just the component registers. External CXL drivers likely
just want to own the whole BAR and not workaround an internal detail
like this.=
