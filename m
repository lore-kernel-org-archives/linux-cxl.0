Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664CB1AA7BA
	for <linux-cxl@vger.kernel.org>; Mon, 10 Mar 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615060; cv=none; b=ctXZOH58bK0Y0A9kaaPU8e1JASUvgMZAtQ0QBnTpsKu9rP1RJSmXuCiNic+8AEdvpwxjy4D0hvh3BNnbAQxgYwHGqQ0wR4iMMZg5WcPfNrncpOrBHpLZDmWA5tuu6MJUTGzMVP6zvU32hKjYWcd/euj0MI1t2G/j3g8Z6/unn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615060; c=relaxed/simple;
	bh=Y9fsLbwq5uH6Exv0zpyWN41cRhWpBr9Slw80G1hsSjU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPjoB8Y4jdceOJEXtdRhiRUuM0prmGuWiozfRm6HI7qt1ml8nGJVtMeMATbmkQEGUy+DixJdR3c6er4nO2kP4ed+B9ReKmMSPSofD3BVYjAUeaY36zfUWZ+ZbAAFhP/JSePCoZIQfTcNaMBph6S0mgC5NhbQVmmCU7cI4mPvUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBJKd1Yp9z6H7Xd;
	Mon, 10 Mar 2025 21:54:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 915BE140D1A;
	Mon, 10 Mar 2025 21:57:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Mar
 2025 14:57:33 +0100
Date: Mon, 10 Mar 2025 13:57:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <mtosatti@redhat.com>,
	<mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>,
	<kraxel@redhat.com>, <bsd@redhat.com>, <berrange@redhat.com>,
	<ddutile@redhat.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <20250310135731.00005b1f@huawei.com>
In-Reply-To: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Mar 2025 18:37:47 +0000
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I/O
> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
> device is platform-specific.
> 
> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
> undefined device id.
> 
> Therefore, change the vendor id to Red Hat and request a new QEMU-specific
> device id.
> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

As a heads up, I believe we have a similar problem with a few of the CXL IDs.
The root port and type 3 device both use Intel IDs that were not reserved
for this purpose.  VID=0x8086, DID=0x7075 and DID=0x0d93

Switch ports and switch-cci are using valid Hisilicon IDs that are for
emulation of these device only and are registered in our tracker
for these IDs so won't get 'reused'.

In both those cases the driver binds on class code in Linux so an ID
change to resolve this would be fine for Linux - I can't speak for
other OS.

Jonathan




> ---
>  docs/specs/pci-ids.rst | 2 ++
>  hw/i386/amd_iommu.c    | 3 ++-
>  include/hw/pci/pci.h   | 1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> index 261b0f359f..2416a70a2d 100644
> --- a/docs/specs/pci-ids.rst
> +++ b/docs/specs/pci-ids.rst
> @@ -100,6 +100,8 @@ PCI devices (other than virtio):
>    PCI UFS device (``-device ufs``)
>  1b36:0014
>    PCI RISC-V IOMMU device
> +1b36:0015
> +  PCI AMD IOMMU device (``-device amd-iommu``)
>  
>  All these devices are documented in :doc:`index`.
>  
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index dda1a5781f..4d8564249c 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1766,7 +1766,8 @@ static void amdvi_pci_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->vendor_id = PCI_VENDOR_ID_AMD;
> +    k->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    k->device_id = PCI_DEVICE_ID_REDHAT_AMD_IOMMU;
>      k->class_id = 0x0806;
>      k->realize = amdvi_pci_realize;
>  
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 4002bbeebd..da44e6673d 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -117,6 +117,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
>  #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
>  #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
> +#define PCI_DEVICE_ID_REDHAT_AMD_IOMMU   0x0015
>  #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>  
>  #define FMT_PCIBUS                      PRIx64

