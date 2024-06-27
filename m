Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6E146D6D
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493759; cv=none; b=qwqhrwZt2o2sjiDrlRBoXvtyGzSXWeuNVzqkT/Kh8mQEmQ61lFtjTf8N4xu74Oq9ANNBf2My8bP6fnk4z2NJxdMNIaWk/egWt+ShdF5tSgS+qZr5hTXVNNT6vDiQsjkY1D1cqVAbz65YOwb/lW3776k62Fk2YCHlyZLI9CYNDZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493759; c=relaxed/simple;
	bh=+Sw55LUc8X7nStx3j5YLGgMKaiJHAa/VxxuH6NRyqYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uxua/ewe3bg7OKs4V8Ad+KWeRULVc0QuTfujV/uvh4KOGN8/NqPtZRsdJx+spKVday0y0uszBuSx6ngDV5HAuM2OK6AQIwq22rATmq7/1sPSBKz8Hjxz7PKb1N27zrXShml4JvxX1oxA7eMShvateK0qKQ11m28YX+cjMDF0a6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C25ZIq2L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C25ZIq2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719493756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wcA7ISwGfHt02LqB5va1uV52y1R748xcCylRIffVeI=;
	b=C25ZIq2LnS7bXgFdsdL2GjEYv5fnTW2j3wHVCvveFtIpqS/x1UddETZHMJ8iUcm/4pnojF
	Ds+YfUZ3BvYyt6BHe2Fa85jmynR3wTBNWo2Z5oO2rz0aKePkgVAqHRSOV6tkYWCB0LqQ+e
	l6ew7e+JtQJwuNxyaMDoo9/uBy3f1Xc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-LcG7mdEiMm6EpT8q3oMYKA-1; Thu, 27 Jun 2024 09:09:15 -0400
X-MC-Unique: LcG7mdEiMm6EpT8q3oMYKA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3641f3d721cso3647496f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 06:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493754; x=1720098554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wcA7ISwGfHt02LqB5va1uV52y1R748xcCylRIffVeI=;
        b=K3+0SNHTCszJmWeRiqI6cIHK4CrfcrvaEB8+u1l85zMLXi4QErHzAgTgHr6x0tLnaF
         KrK8kFEsRLKyOf00jnIcXCzSUWX5M+mnhip2L+GvojlHb30ldB6tK/yl6vRp2xzbAjf/
         iIxuUOMfAoBIfUVA3yJNxNMI2s1tnemTIVBkG2SfbUJrRGquI9LByVzZHUL/6woOYJIi
         DqQeCaTAjVB7Yqjd+uDmoHsICy37FMNOpqKjyP7gi1ZAUeJwo9OZAy1iiAGMx0df5OnJ
         xUi+Img82wpSduaQS/ZUGmKqlT9QYwSCqd4I1pGqu9C6rqKMQkpJqhY9LEk8IhIb8p7A
         jUpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4T77X9yHJYqNwc9mPLw42JHUQfyZh15oB9UBN/4GCf951qC0WyRWWVCYK2ND+oZs56p0quyyDzC08Yjoimbrp9Tekc1STcNG5
X-Gm-Message-State: AOJu0YwIOpy6NlCgW/9aLB0KAO46L7c0kiSrBrr36CLkyUCwVUkaNwgk
	w8iFPxUJPW4D1ZwIBwWoMK62ownYm8MufMiNvQgqFrKuMR2UImYPYYAY4G/j5MG7O5PwKSLxLAJ
	shjP5YVn+NP2ZvZyA6yQ7b4YFyvSRhdu10oyWiaaPPgNnTLa0FR1Ngb3ozw==
X-Received: by 2002:a05:6000:154d:b0:366:e508:c7d7 with SMTP id ffacd0b85a97d-366e508c9d5mr11928435f8f.7.1719493754045;
        Thu, 27 Jun 2024 06:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRkM81XmKbLAJ5BzgiY5vOkvLGjClh12fRigKHCMVv9dqg8B/z9ZC/Gt5msG3nEsOlgKj6Rg==
X-Received: by 2002:a05:6000:154d:b0:366:e508:c7d7 with SMTP id ffacd0b85a97d-366e508c9d5mr11928416f8f.7.1719493753625;
        Thu, 27 Jun 2024 06:09:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36743699b19sm1840140f8f.73.2024.06.27.06.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:09:13 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:09:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 05/11] hw/pci: Add a bus property to pci_props and
 use for acpi/gi
Message-ID: <20240627150912.6ce774b1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-6-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-6-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
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

On Thu, 20 Jun 2024 17:03:13 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Using a property allows us to hide the internal details of the PCI device
> from the code to build a SRAT Generic Initiator Affinity Structure with
> PCI Device Handle.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> V3: New patch
> ---
>  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
>  hw/pci/pci.c                     | 14 ++++++++++++++
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> index 73bafaaaea..34284359f0 100644
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
> +    bus = object_property_get_uint(o, "bus", &error_fatal);
> +    devfn = object_property_get_uint(o, "addr", &error_fatal);
> +
> +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
>  
>      return 0;
>  }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 324c1302d2..b4b499b172 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset_hold(Object *obj, ResetType type);
>  static bool pcie_has_upstream_port(PCIDevice *dev);
>  
> +static void prop_pci_bus_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint8_t bus = pci_dev_bus_num(PCI_DEVICE(obj));
> +
> +    visit_type_uint8(v, name, &bus, errp);
> +}
> +
> +static const PropertyInfo prop_pci_bus = {
> +    .name = "bus",

/me confused,
didn't we have 'bus' property for PCI devices already?

i.e. I can add PCI device like this
  -device e1000,bus=pci.0,addr=0x6,...
  

> +    .get = prop_pci_bus_get,
> +};
> +
>  static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
>      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> @@ -85,6 +98,7 @@ static Property pci_props[] = {
>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    { .name = "bus", .info = &prop_pci_bus },
>      DEFINE_PROP_END_OF_LIST()
>  };
>  

