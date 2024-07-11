Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0214532D
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720700606; cv=none; b=nWHIkkt9tVbWS52wZDwupvtyXxJUxmA/RKEg5ff74XdxnC8qLix66OKzDOaFiXgv7WG7VHK+P+eaWi4QOH1R1mG6T9+l+tD7q35mxKZVupFzm9r4u/2VZu9WBz+4lTubEUQSZpZ9WPxSTUNzUjWz59mOh6oXCQRbsjfJgD9o+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720700606; c=relaxed/simple;
	bh=fyoPgLnUM9T5v3h3ffKc+89dQidCQzdcG395Q84n+qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWjb1QjTR5sN2390JCkA1wLqVqLbw12Ftkfi+GU6q2tsLYX1VYerT+WWwCO8kduSVHz8oQSYgWf24oFSCIj9jDH2FWynYeSg+d5PKZLDmX9wPHAwigD6HGTPndk1xpq/7RNTa+u12GPCloPClmBKwK8JS6wiNSk/L9f52vabKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXZ41JRS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXZ41JRS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720700602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OnyCG9jLNSkK29ol0NSD8qGt7MpNaFgicQ9xROE6ndQ=;
	b=MXZ41JRSuc7A2pLEHJMu7nOY7tP6C+IKulUAsfTjGVh3xr+wiK/HZxOeV/sJ6CLFsmJfFW
	E74nhauY93d1GUInCH7Sdv/no5WEPb5qhylO7itscafVnlHoassfWFRA/bcAqNxERsIItg
	diBSq83y8Uk3HYijMEWLQKScm8InN+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-uxSx5-iZPRiBR3IlfprfpQ-1; Thu, 11 Jul 2024 08:23:21 -0400
X-MC-Unique: uxSx5-iZPRiBR3IlfprfpQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3679ab94cdbso489306f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 05:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720700600; x=1721305400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnyCG9jLNSkK29ol0NSD8qGt7MpNaFgicQ9xROE6ndQ=;
        b=YEOpZDSaSVlwW5AOERuPuD9vL++az+uo/fwZqOF6FXU0Ui7zH+9za5CSt2EjKqmVVs
         SRM3b4xQ5MN0Cd8mxEMvU/5nwtLwF6wLtSLkM4CfOX6/YGaiZ5er6iX0R/mMv0owioun
         doLKKpb3zWpbla7RqPPWTEf8jjV5A1R+5aJ6SXxPhQ10v4gC91A0+mXpXWwTVaARpzLE
         0efOOb1hGIodzCTawozhcP141pM2WE/2TTS6EmrjjU4lsdKUHIMz9Z2x1kA+aBvNg/rs
         cNIfaDmXXkkTswBlJ+746wrcnCrgc3cVxNGFAtz9dWt3/vxMsviL1eIi5J28kM1uszoX
         om1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5xEuuIHeAlyCmEgbTOnu0jrJC2A+V/xEqrEPQ0K/uFiwgPLh+TtDLuXa5NwEmjs/EKQXCLx3djiVZpNpZ89IidHpnlKz2jZOF
X-Gm-Message-State: AOJu0Yy8d8WADXXGrAjbDqU2a7owbpnQdDNeQj0DawqbcfiN6a/6k+h2
	l4gv/QqRybf7fSkopdYPI9V77vTmjrflTODlAFfimY75EmMScUmzH+UVfz08yBCPD6uzyMsggKA
	a/za+7aG0BuVo1H3eb1dUwpkGy9egzI5csQFBZpb5ATo8xkA8pixMkpoOow==
X-Received: by 2002:adf:e98d:0:b0:367:89d3:6581 with SMTP id ffacd0b85a97d-367cea67d70mr5897753f8f.17.1720700600366;
        Thu, 11 Jul 2024 05:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVTReJvehVyFPqpX0/1+vB6rD4l1DZVJ3/3qhaXBXbIdOMd17ey8C0rWVb+SgIhIueZOW73Q==
X-Received: by 2002:adf:e98d:0:b0:367:89d3:6581 with SMTP id ffacd0b85a97d-367cea67d70mr5897736f8f.17.1720700599994;
        Thu, 11 Jul 2024 05:23:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfb2281sm7592520f8f.115.2024.07.11.05.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:23:19 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:23:16 +0200
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
Message-ID: <20240711142316.1150870e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240711135331.6f0e4639@imammedo.users.ipa.redhat.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
	<20240702131428.664859-6-Jonathan.Cameron@huawei.com>
	<20240711135331.6f0e4639@imammedo.users.ipa.redhat.com>
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

On Thu, 11 Jul 2024 13:53:31 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 2 Jul 2024 14:14:10 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Using a property allows us to hide the internal details of the PCI device
> > from the code to build a SRAT Generic Initiator Affinity Structure with
> > PCI Device Handle.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > V4: Avoid confusion with device creation parameter bus but renaming to
> >     busnr
> > ---
> >  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
> >  hw/pci/pci.c                     | 14 ++++++++++++++
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > index 73bafaaaea..f2711c91ef 100644
> > --- a/hw/acpi/acpi_generic_initiator.c
> > +++ b/hw/acpi/acpi_generic_initiator.c
> > @@ -9,6 +9,7 @@
> >  #include "hw/boards.h"
> >  #include "hw/pci/pci_device.h"
> >  #include "qemu/error-report.h"
> > +#include "qapi/error.h"
> >  
> >  typedef struct AcpiGenericInitiatorClass {
> >      ObjectClass parent_class;
> > @@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >      MachineState *ms = MACHINE(qdev_get_machine());
> >      AcpiGenericInitiator *gi;
> >      GArray *table_data = opaque;
> > -    PCIDevice *pci_dev;
> > +    uint8_t bus, devfn;
> >      Object *o;
> >  
> >      if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> > @@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >          exit(1);
> >      }
> >  
> > -    pci_dev = PCI_DEVICE(o);
> > -    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> > -                                     pci_bus_num(pci_get_bus(pci_dev)),
> > -                                     pci_dev->devfn);
> > +    bus = object_property_get_uint(o, "busnr", &error_fatal);
> > +    devfn = object_property_get_uint(o, "addr", &error_fatal);  
> 
> devfn in PCI code is 32bit, while here it's declared as unit8_t,
> which seems wrong.
> It likely would work in case of PCIe root ports/switches where slot is 0,
> but should quickly break elsewhere as soon as slot is more than 0.
> 
> If it's intentional, there should be fat comment here about why it this way
> and an assert to catch silent cropping of the value. 

Ignore that, obviously the rest of the QEMU does not care about this downcast.

Maybe add assert anyways to catch too big devfn returned,
which unlikely to happen ever.

anyways:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > +
> > +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> >  
> >      return 0;
> >  }
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 50b86d5790..29d4852c21 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >  static void pcibus_reset_hold(Object *obj, ResetType type);
> >  static bool pcie_has_upstream_port(PCIDevice *dev);
> >  
> > +static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
> > +                             void *opaque, Error **errp)
> > +{
> > +    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
> > +
> > +    visit_type_uint8(v, name, &busnr, errp);
> > +}
> > +
> > +static const PropertyInfo prop_pci_busnr = {
> > +    .name = "busnr",
> > +    .get = prop_pci_busnr_get,
> > +};
> > +
> >  static Property pci_props[] = {
> >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> > @@ -85,6 +98,7 @@ static Property pci_props[] = {
> >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > +    { .name = "busnr", .info = &prop_pci_busnr },
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >    
> 

