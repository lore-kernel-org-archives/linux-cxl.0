Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A915885E
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698821; cv=none; b=nZKcfOBnEDV4sYjlTbJm0yRodPw4FSxx60NTERcuXIGWMNmkClm2255sPPtokcUo/xIg+CBVywijY83RbGyfzagJhYJ8t317YC3+/HWzS0KZdR4dJIKrQADZkoTVekB1ZJgrahA/yH/ezeqvfbepe292p755WEjLNK270b9veEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698821; c=relaxed/simple;
	bh=L9x3XZczKEPi5Uj70eCYmCtnAStf8Jp1xVhnwRZwRjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hR51lmHzd+JUYiUeMiGlguMWxOzNbjiBY9ql9JXB09aRvujrWtzDNEAOzXPpodzizJ5SGrfpcPQtEpFtQ5OStf3QH/kG///CXQxaWwm/+B+s7Xq2ikGkvie2dklfFFwSirUoPE/3ixgQ6lsKIjg/vsgLVtNqI2bJXK6VDPyF4EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ia+SqqG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia+SqqG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720698818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OcoUcKqb44Xm9OFgCdxhrIPGvhgw6cygk4oO4wMZsgU=;
	b=Ia+SqqG+Q63G2W1s7yBEaH4STaSJhXvh1pjYbX3wVBs8QeGGC6KQlmpfQqgesM3q3Wr/cK
	LMM1IUSXK5uxSEZwkdLL7n68W76OsuL3DSlJDE004aGZz9dwwnzBd+UsfL5gP8F0UgHDUu
	XZun0/1IlcezIL0+cc6tKNUm2AbFg8o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-4CoYfjIHPNOBgELw7N7eiA-1; Thu, 11 Jul 2024 07:53:35 -0400
X-MC-Unique: 4CoYfjIHPNOBgELw7N7eiA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-367f95ed73aso370423f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 04:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720698814; x=1721303614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcoUcKqb44Xm9OFgCdxhrIPGvhgw6cygk4oO4wMZsgU=;
        b=Vd6qgK6l05gi41sAqdEkWEYyyHxThSqnzkQL2j+3iMHzVLPm80GezOU8EL2WBtJ17b
         u3/++xLSP5s/Rfc0MAjN48ytMTzfZVV+8U08jjh54snJyIUMppCpTWW4cGtFvNOyD7sl
         YdQVeyqT94eujeU//qOvBsF96Gj6RfDQvS3oQvVOUgH6Eo0cCmIXflEh+B6M0wGFoyhN
         pCIej29N5DVK3mk69QliYFwqKz+UrFAlDzcm7sZCCbvwNjc+nagoGxNlbRWP0k4Vw6w1
         GexpA+JAg5EVfEkrZ4A5Je6n6MJijMNi2fkWQFVcfQnWygkFLqZarbGqT2+eQPcE59gJ
         LlkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUlRqG89PD2uRfrwUozN+VPdTwa9jJrbH7YmH2mZ9rs13pQC26rzlAwXQSxKeBUB36zf6TeWkzo6fTN4h5/nd/AejMgfhvOeVK
X-Gm-Message-State: AOJu0YytpEPGBSRkIcjDIT76j2Yc/9EguXp5VtD6IYjonSHQu8jxJdH8
	WrJIdRDlTV8NgTVMNaQdF3bWspf7/3JsbDpHb+QmSzd8VN4ZwdAzsilScahTAPJifObSwRC+Pj9
	dqA1aH4+XghLWKXSRtDVmXdM71GFyRndvqSjzShqHFtSeJs3wzsXGPw3qzw==
X-Received: by 2002:a7b:cc97:0:b0:426:5d63:24c4 with SMTP id 5b1f17b1804b1-426708f1dcamr48196035e9.27.1720698814410;
        Thu, 11 Jul 2024 04:53:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWzLvX4c7bSDw7L1OcwNfUEEyNHzMjOERqj1EaDSdjsW5EOZALOPplWmLwxAz1Wgq8i6QD9w==
X-Received: by 2002:a7b:cc97:0:b0:426:5d63:24c4 with SMTP id 5b1f17b1804b1-426708f1dcamr48195905e9.27.1720698814044;
        Thu, 11 Jul 2024 04:53:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42797100f55sm43738255e9.1.2024.07.11.04.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:53:33 -0700 (PDT)
Date: Thu, 11 Jul 2024 13:53:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 05/13] hw/pci: Add a busnr property to pci_props and
 use for acpi/gi
Message-ID: <20240711135331.6f0e4639@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240702131428.664859-6-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
	<20240702131428.664859-6-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
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

On Tue, 2 Jul 2024 14:14:10 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Using a property allows us to hide the internal details of the PCI device
> from the code to build a SRAT Generic Initiator Affinity Structure with
> PCI Device Handle.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> V4: Avoid confusion with device creation parameter bus but renaming to
>     busnr
> ---
>  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
>  hw/pci/pci.c                     | 14 ++++++++++++++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 73bafaaaea..f2711c91ef 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -9,6 +9,7 @@
>  #include "hw/boards.h"
>  #include "hw/pci/pci_device.h"
>  #include "qemu/error-report.h"
> +#include "qapi/error.h"
>  
>  typedef struct AcpiGenericInitiatorClass {
>      ObjectClass parent_class;
> @@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
>      MachineState *ms = MACHINE(qdev_get_machine());
>      AcpiGenericInitiator *gi;
>      GArray *table_data = opaque;
> -    PCIDevice *pci_dev;
> +    uint8_t bus, devfn;
>      Object *o;
>  
>      if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> @@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
>          exit(1);
>      }
>  
> -    pci_dev = PCI_DEVICE(o);
> -    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> -                                     pci_bus_num(pci_get_bus(pci_dev)),
> -                                     pci_dev->devfn);
> +    bus = object_property_get_uint(o, "busnr", &error_fatal);
> +    devfn = object_property_get_uint(o, "addr", &error_fatal);

devfn in PCI code is 32bit, while here it's declared as unit8_t,
which seems wrong.
It likely would work in case of PCIe root ports/switches where slot is 0,
but should quickly break elsewhere as soon as slot is more than 0.

If it's intentional, there should be fat comment here about why it this way
and an assert to catch silent cropping of the value. 

> +
> +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
>  
>      return 0;
>  }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 50b86d5790..29d4852c21 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset_hold(Object *obj, ResetType type);
>  static bool pcie_has_upstream_port(PCIDevice *dev);
>  
> +static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
> +
> +    visit_type_uint8(v, name, &busnr, errp);
> +}
> +
> +static const PropertyInfo prop_pci_busnr = {
> +    .name = "busnr",
> +    .get = prop_pci_busnr_get,
> +};
> +
>  static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> @@ -85,6 +98,7 @@ static Property pci_props[] = {
>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    { .name = "busnr", .info = &prop_pci_busnr },
>      DEFINE_PROP_END_OF_LIST()
>  };
>  

