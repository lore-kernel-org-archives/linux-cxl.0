Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6728F5B
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680554; cv=none; b=kDUNXd6pQhBCq6O0zUqK1CZR8RTZcnKntJvg5NDre/YXNc/ugRT6uqhu4iTwdCB79OGv+aBPFHPVgjvFVITiKNCyIBzhKT8Bl7uEsTRdlpwSJJq/QWtnCZWlB/lmWkJ9TBXEjGKFVMo98ohuN0JVQFWoKQKjjLE9DcxV8qSDTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680554; c=relaxed/simple;
	bh=t7v9LrnikA0b/tdjpm95QIPigc7c4Z7Gm+7ryEqj1gE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a08d74tLfRqYnDxuGw/OM28TqZkmYTZtiX7XLaJojT1LNqdBn0iwDPPI4qil9IUrR2PUk5Ls6cofPTNo2dtUSGn8ybPPGIs1tnAjrBOa3b7tOhyctrrOqEw3Zui6LWye1V1UZ75xUz98WM9oKBsKvbpZCOv8ETRagSZ0rLZeDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jkh6D/Um; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkh6D/Um"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728680551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4ZF/lqPBd0UGdsnnza01sUUQe28zx1+oJm7x5DzidA=;
	b=Jkh6D/UmteYdnL3mUDeoULQraI2OMzzqdltGqsnroBLb2juSY/JMAQcstMl7ql7qZ2vq13
	hIjh+WyfARtRF9odnxjNDUFcMkPNN22wISxhJhGXjL0qtsVNT7qIlehO2DZ0VRgZbQ46HC
	N56/gf+r7GsJULHyg8lcz1DHbcBjedY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-UmZrid74PfCH2TYKZ-J3UQ-1; Fri, 11 Oct 2024 17:02:30 -0400
X-MC-Unique: UmZrid74PfCH2TYKZ-J3UQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83539231e19so34872639f.0
        for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 14:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728680550; x=1729285350;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4ZF/lqPBd0UGdsnnza01sUUQe28zx1+oJm7x5DzidA=;
        b=EIUBxScYFCSWT7G8pgBp274YZ8cDHgWfDgDpvqc7oiyuPUOdvVEwt0vn5sgLhvA+XQ
         x2Vkkb8RNQKgaoK0TP+f2GOUjRU1TsLA17DuHS8gugYAAeUMjESRQ1CLtcmDIvMYv/7U
         7+hsypfqZBb5jd2EM+/eTV/F0ncsHmFc1skHVbclj3JN+2UiQF1yFc/T4+RR3CSn7jAf
         URvVrJZjiZ/VpKHYQdJtLaA/DKniShLL9iUD5w1W0EUo4d0/2x6lLXJKfIkht2rk3Bln
         fcOY56o9auCbZ8DmSeBuPGTgskA/JbVenk1by7F/X/jXDkR2fOK+6SrpPwp3+xtm+D0j
         Wi+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzqV6xQ8DYRAKvO76QjkZLkOsSv9PnoaHrGKn40jzz8hP0y5pDt+mXuQ+31QfxzY1DZ4BgXTWcSh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3toPHB8cJuHdotQ44YPVgehHGbsVIV0QHIVJldktjP/JHONF
	V6c8lgcitUGhi4sGWBTc2Dx6nW+IGZd0GKYhkybU9jMYHSDlJ2tbgF9aYOX5/56qTwOr7NdHSB7
	TYb8o9XAZxwaQwRmq9eM0Lo7I3Gx7dG0S3ODjCCGA/95QnpoXCJZ1JZZjKQ==
X-Received: by 2002:a05:6602:3284:b0:834:f667:217a with SMTP id ca18e2360f4ac-8379202f708mr89166639f.1.1728680550021;
        Fri, 11 Oct 2024 14:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqD2f+aFQtnYWBNo5lj3VmQuysrsCAI+ZXqdxvd+ha7KP/RQaF5OE/2Ag0jxh8N+y1wX+hmg==
X-Received: by 2002:a05:6602:3284:b0:834:f667:217a with SMTP id ca18e2360f4ac-8379202f708mr89165039f.1.1728680549687;
        Fri, 11 Oct 2024 14:02:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbad9b15absm792043173.34.2024.10.11.14.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 14:02:29 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:02:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: <kvm@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
 <kevin.tian@intel.com>, <jgg@nvidia.com>, <alison.schofield@intel.com>,
 <dan.j.williams@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
 <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
 <vishal.l.verma@intel.com>, <alucerop@amd.com>, <acurrid@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <zhiwang@kernel.org>
Subject: Re: [RFC 10/13] vfio/pci: emulate CXL DVSEC registers in the
 configuration space
Message-ID: <20241011150227.1b41a479.alex.williamson@redhat.com>
In-Reply-To: <20240920223446.1908673-11-zhiw@nvidia.com>
References: <20240920223446.1908673-1-zhiw@nvidia.com>
	<20240920223446.1908673-11-zhiw@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Sep 2024 15:34:43 -0700
Zhi Wang <zhiw@nvidia.com> wrote:

> A CXL device has many DVSEC registers in the configuration space for
> device control and enumeration. E.g. enable CXL.mem/CXL.cahce.
> 
> However, the kernel CXL core owns those registers to control the device.
> Thus, the VM is forbidden to touch the physical device control registers.
> 
> Read/write the CXL DVSEC from/to the virt configuration space.
> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 98f3ac2d305c..af8c0997c796 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1902,6 +1902,15 @@ static ssize_t vfio_config_do_rw(struct vfio_pci_core_device *vdev, char __user
>  
>  			perm = &ecap_perms[cap_id];
>  			cap_start = vfio_find_cap_start(vdev, *ppos);
> +
> +			if (cap_id == PCI_EXT_CAP_ID_DVSEC) {
> +				u32 dword;

This should be an __le32 and we should use an le32_to_cpu before
comparison to PCI_VENDOR_ID_CXL.

> +
> +				memcpy(&dword, vdev->vconfig + cap_start + PCI_DVSEC_HEADER1, 4);
> +
> +				if (PCI_DVSEC_HEADER1_VID(dword) == PCI_VENDOR_ID_CXL)
> +					perm = &virt_perms;

We're making an assumption here that all CXL defined DVSEC capabilities
will have the same behavior.  Also, should we bother to expose an
emulated, dummy capability, or should we expect the VMM to handle
emulating it?  Doesn't the virt_perms allow the entire capability,
including headers to be writable?  Thanks,

Alex

> +			}
>  		} else {
>  			WARN_ON(cap_id > PCI_CAP_ID_MAX);
>  

