Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF843E1689;
	Fri, 10 Jul 2026 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722215; cv=none; b=LbKnaIWna+yHWTuK/wq5/ycSsGSGgHcRovjPEmrWup1xWnCDQe5abGV2JERi5TDjsx0BzY/miSCJUJzyu+5FBJOgZy8lfWvDuCmXFNEQfYxPm2UGwoheTX2o41elc/TEcQLFXvcirG/6NWSppqKTrkKAyEC9hUQmE4WTpx7mtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722215; c=relaxed/simple;
	bh=I21kArmQobhISEaMwauu9AYY9BGr3JqrBwtJP8Be4qA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDrlplaD7n+BVogpvmw57dXTEIi+E0X/D1Ri3s0CSPNrtg5UoOKYR2ioZcahhLksammRFOZtg76BD04XCbIiG50j2w6vBMGOVfY4FVYhJ07oudOs7vQSF2bAMGnWJtP+TUwpkShPxvCmFPMsB0mp9eSuloRDNjxpec5CpYWDyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JNQK5jn7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vr6T9ZC4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JNQK5jn7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vr6T9ZC4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id ACF92EC01F0;
	Fri, 10 Jul 2026 18:23:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jul 2026 18:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783722211;
	 x=1783808611; bh=+KqIaM30rs2vhbd55aXFiWiPyHLNLUW6M2dTl31PvFU=; b=
	JNQK5jn7abNbdyfhAKC3QPRumcJMPmbOxqKzAizgg8ck0Ce54U2P5M3fD2wIyGI3
	xpsk8hguJu55kquD75fndML4ofjp9ZlbAN/vjxqc5arxCkxryP6s8zONoH6XFGzX
	sNC/OEN3ZxfM1G1yj9Rx4Ku+8VFcyQ043CjZNHSMtRKOEeI3TSjnlVKt9lnO7vfH
	ivSGwYy3GvACZ8EWFJR8vXsGgxnaTzHT97qtIvdtWz2aEMVkmXMWG1aNprVJGZmH
	EeF6PpiFT3KxHSlk6oMl2EEO/znj1tMEvYGsyunjf8BkTBmmTr6JtAhLIhUXsaW7
	n2LM7ICQdhMwWbJDjLPvhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783722211; x=
	1783808611; bh=+KqIaM30rs2vhbd55aXFiWiPyHLNLUW6M2dTl31PvFU=; b=V
	r6T9ZC4A/hRTxpFvGBMeqMgzNkDK5T6siMg/IJ7X9jCHu2yUk77MfFr/DM1NP8hS
	QLdEoh5lsjeX7NoZzV2dSf0XxGbEgO5SdM37ZcY+YOkFaDLbyAj0kb/DCQ/FrR6e
	PimzoxDE2SloOlVH5GK2ZkXmnFd8rIsK2A1S9fCG8rp/4V9N2h+rnKF5sdro+73k
	de0VfIxuuHEBMTJSMn0ecA/eId/j51kaPzw97AbyqkRQ4cg9fHYCb6SYQGyxFV1Z
	gzdAUOY1cv2d/avgtm8DmODhoPNHRSR540XzsoPaCUByd0oNDoNh/7z6pt1WFzsa
	4/K//5Uax/sWlhvQG2AhA==
X-ME-Sender: <xms:43BRasDL1TicnddlqrIbbVGGGkQRcZ-kVo5adfVNqhd2OcoKkNYwFQ>
    <xme:43BRaruXTrNmfvOQ3wM6u5kf8CaDXdyq79TNm_7oOZfLIBs3b0PhW-hsx2hVZcvPF
    wt4ddWq4jJ9C9stu6k0GsQIoEEsXGG8gPDjAMBhwLF-IbUU6cyx>
X-ME-Received: <xmr:43BRakEV5PaMB855CZBEISmVnGMRs4w6JNSn89Hv3Ba-1OIcNnxs1G_kMPQ>
X-ME-Proxy-Cause: dmFkZTGMzXDuQeY5gEq71VJWijR1DWZ9rbms+1N9AX2oGTr8hArY6bxP2G/am96xUkPFv3
    Z4ApYv3m2mSWvALuvslRIxWhZTDC+hQKcWUNwhuKD541gUvs8bDfo88o/gmIt/+eiMSKZ/
    PfsKMxh88JCcjukEpflhKnQPQMXN23KiX+qh8YjqzX+GAfpI0rmfBBb+w/+rK+bUFo73gl
    aP1foO45G+FVhtVWhkJbcsI9jzwmJY7xKCsU82pHyhFyNjMMJasjWA8bW6xCtbAh+JFQbP
    zks9zj+srb+k4G3rfqsKY8R4EvGE/Z76nI2YOYsp8f456nw6SAcrEWEs+ztpMzUV1dHFs0
    JPSG2snu841m3dLHmew39d10z5C7QgoI1AXTNEH/7U90A/L7bcMzpjdsSknHVVvOaMnVMw
    XP6lSvnqHmbwXRzIgAZhnvrF/EdAOxf/G/5MDM2cI6JZreSxBPXAvvLw7bknMpZmvRUaMU
    PqzZhgIotgO5wMEwHJQck9i+bWfEQ9GGK8kaJkd3xepGPsbI5/xZgjmsvv7IFvlh/trpL2
    T/0U753IEBjFOLRx3BS/oG/SudsXzB87qEOZWEeiIddO0IKXW0QFRjhbFmmUlJsDsGr6bJ
    TrTrVPJ3E52vTnjaXJ5swO4Gct6RngrVwspN2CK7vyqyHJXFyhPwon274RYg
X-ME-Proxy: <xmx:43BRau956hXrtRVG-NMyVkRDWBX_-dVMGkx2QyOp5A4IPRuctGQntQ>
    <xmx:43BRaiOKeA_Wd0L2ZCHj0O0mujL-LCoh-Z_04AEvxWe5JAHLOWvcfg>
    <xmx:43BRasjpw1q5c-OlNsXHXy_va8FNNHthg9XC1tBQkSv8m1Pm8A3FZw>
    <xmx:43BRapTWzmvkBYaosl0ufnXnEDnsIvtnMvLPTca46Nn5ZNbRd4m3iQ>
    <xmx:43BRanR7kK-CNDpQxdl2yrUvUgJroeELCm7I4jJSHxOr_mn4t2yjhN6C>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 18:23:29 -0400 (EDT)
Date: Fri, 10 Jul 2026 16:23:09 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <djbw@kernel.org>, <jgg@ziepe.ca>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <ankita@nvidia.com>,
 <alejandro.lucero-palau@amd.com>, <alison.schofield@intel.com>,
 <dave@stgolabs.net>, <dmatlack@google.com>, <gourry@gourry.net>,
 <ira.weiny@intel.com>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v3 08/11] vfio/pci/cxl: Add HDM + COMP_REGS regions and
 DVSEC clipping shim
Message-ID: <20260710162309.2c257883@shazbot.org>
In-Reply-To: <20260625165407.1769572-9-mhonap@nvidia.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
	<20260625165407.1769572-9-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 22:24:04 +0530
<mhonap@nvidia.com> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index a10ed733f0e3..b9f30a33515a 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1898,8 +1898,15 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>  	/*
>  	 * Chop accesses into aligned chunks containing no more than a
>  	 * single capability.  Caller increments to the next chunk.
> +	 *
> +	 * For CXL Type-2 devices also clip at the CXL Device DVSEC body
> +	 * boundary so the generic perm-bits path handles the DVSEC
> +	 * header bytes and the CXL hook handles the body bytes; without
> +	 * this clip a 32-bit access at dvsec + 0x08 would span the
> +	 * generic Header2 word and the CXL CAPABILITY word.
>  	 */
>  	count = min(count, vfio_pci_cap_remaining_dword(vdev, *ppos));
> +	count = min(count, vfio_pci_cxl_config_boundary(vdev, *ppos));
>  	if (count >= 4 && !(*ppos % 4))
>  		count = 4;
>  	else if (count >= 2 && !(*ppos % 2))
> @@ -1909,6 +1916,30 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>  
>  	ret = count;
>  
> +	/*
> +	 * Give the CXL Type-2 hook first claim on this access: if the
> +	 * range lies inside the CXL Device DVSEC body, forward it to
> +	 * cxl-core's register-virtualization helpers instead of the
> +	 * standard perm-bits path.  -ENOENT means "not for me; use the
> +	 * default path"; any other negative value is a hard error.
> +	 */
> +	if (vdev->cxl) {
> +		__le32 le_val = 0;
> +		ssize_t cxl_ret;
> +
> +		if (iswrite && copy_from_user(&le_val, buf, count))
> +			return -EFAULT;
> +		cxl_ret = vfio_pci_cxl_config_rw(vdev, *ppos, count, &le_val,
> +						 iswrite);
> +		if (cxl_ret >= 0) {
> +			if (!iswrite && copy_to_user(buf, &le_val, count))
> +				return -EFAULT;
> +			return cxl_ret;
> +		}
> +		if (cxl_ret != -ENOENT)
> +			return cxl_ret;
> +	}
> +

I think the solution here is just to set the .readfn and .writefn for
PCI_EXT_CAP_ID_DVSEC to dvsec specific handlers, rather than the raw
write and direct read handlers.  The new handlers would detect whether
the reference is to the CXL DVSEC body, possibly via ranges stored in
vdev->cxl, and either call through to CXL handlers via cxl_ops
(previously suggested), or fall through to the raw/direct handlers.

>  	cap_id = vdev->pci_config_map[*ppos];
>  
>  	if (cap_id == PCI_CAP_ID_INVALID) {
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 05ab4ae59157..2d2dae278d1e 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -501,6 +501,23 @@ static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>  		if (!pci_resource_len(pdev, i))
>  			continue;
>  
> +		/*
> +		 * cxl-core already holds request_mem_region() on the CXL
> +		 * component register sub-range of this BAR.  Skip the
> +		 * full-BAR request so we do not collide with that
> +		 * sub-region; vfio still owns the BAR via the driver
> +		 * binding and the iomap below succeeds without a region
> +		 * claim.
> +		 */
> +		if (vdev->cxl && bar == vfio_pci_cxl_get_component_reg_bar(vdev)) {
> +			vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
> +			if (!vdev->barmap[bar]) {
> +				pci_dbg(pdev, "Failed to iomap region %d\n", bar);
> +				vdev->barmap[bar] = IOMEM_ERR_PTR(-ENOMEM);
> +			}
> +			continue;
> +		}
> +
>  		if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
>  			pci_dbg(pdev, "Failed to reserve region %d\n", bar);
>  			vdev->barmap[bar] = IOMEM_ERR_PTR(-EBUSY);
> @@ -701,7 +718,10 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
>  			continue;
>  		pci_iounmap(pdev, vdev->barmap[bar]);
> -		pci_release_selected_regions(pdev, 1 << bar);
> +		/* Mirror the asymmetric setup-time skip in map_bars(). */
> +		if (!(vdev->cxl &&
> +		      i == vfio_pci_cxl_get_component_reg_bar(vdev)))
> +			pci_release_selected_regions(pdev, 1 << bar);

It would be much less ugly to create
vfio_pci_{request,release}_selected_region() wrappers that mask whether
the region is actually requested or released than to disrupt the code
flow like this.  Likewise below, think about creating wrappers that do
the right thing for cxl and are no-ops otherwise.  For example, embed
the vdev->cxl test into the function to cleanup the callers.  Thanks,

Alex

>  		vdev->barmap[bar] = NULL;
>  	}
>  
> @@ -1051,6 +1071,16 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
>  	info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
>  	info.num_irqs = VFIO_PCI_NUM_IRQS;
>  
> +	if (vdev->cxl) {
> +		ret = vfio_pci_cxl_get_info(vdev, &caps);
> +		if (ret) {
> +			pci_warn(vdev->pdev,
> +				 "Failed to add CXL info capability\n");
> +			return ret;
> +		}
> +		info.flags |= VFIO_DEVICE_FLAGS_CXL;
> +	}
> +
>  	ret = vfio_pci_info_zdev_add_caps(vdev, &caps);
>  	if (ret && ret != -ENODEV) {
>  		pci_warn(vdev->pdev,
> @@ -1093,6 +1123,12 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
>  	struct pci_dev *pdev = vdev->pdev;
>  	int i, ret;
>  
> +	if (vdev->cxl) {
> +		ret = vfio_pci_cxl_get_region_info(vdev, info, caps);
> +		if (ret != -ENOTTY)
> +			return ret;
> +	}
> +
>  	switch (info->index) {
>  	case VFIO_PCI_CONFIG_REGION_INDEX:
>  		info->offset = VFIO_PCI_INDEX_TO_OFFSET(info->index);
