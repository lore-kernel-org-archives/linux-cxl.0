Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492A15ECDB
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492172; cv=none; b=d5FY18YhDplvbxR1pEzWt0bm/Njk0hDlKpeeaORTpumY2zUEW4pQ8x1r/AU1tmTtt1T/Vx1Q61QoR6leVhjauEiidVl3XwSpOV1DIHOckhOj1fIGLt/Zd28XYHP87W6R6gQz9VDg/T0Fw7i0cwc69ePOmnp3+U5Lwlz3aiK6Dwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492172; c=relaxed/simple;
	bh=KuSue5tuC9+mERblKbHaYaZdvjpu/VGJxQZzFn8VdtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xi+3sgNCsOaOu/5bj295rBu/ryMOllpixOyd4311WI+/OfoYIH4nd0T6QF3IdmQiWDJkuRJroSOrSg0FZtYzBF4Qpc1JM7hGlOA96wcXpiupvBM+eS3x0cZEpbyohzZe6mksOdtWt+Ka/Ix4xrFrJC1/KY2LAk5dNuQVLrlupds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaekHEfj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaekHEfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719492169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96xxGAOlLM6RcLKK7JVH3YWaxAXCN1qD6bLmnHwpP9w=;
	b=eaekHEfj99HjCTu/aiZsokgGBqIz9Fy1UWQculiHkKbZPYlAW+W9mXYDpd0QLEvJwQ76/8
	JH9Oyu5Ev985mS4ZYcXJrGkH8jOnwCOffOgjU+H2mmj83QwdzzUzt50k2dkdC9nOhqc41m
	QQArplAnm8hCNtoXueS6wv5Ol/Tsxto=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-Oju9R-FYMUm3xdWlTe708w-1; Thu, 27 Jun 2024 08:42:48 -0400
X-MC-Unique: Oju9R-FYMUm3xdWlTe708w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-366e087a1e8so4119211f8f.1
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 05:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492166; x=1720096966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ud/uQiAuYG/yErmjqEEC4JbOOjXx62yX+ti0vETMa4=;
        b=Abky9gcza91wCwCHsIT3du7y+rdEmYi4l6V5woXKnWdZtEpKmbZP6sxQFToqNDtNbc
         lycWwwGT/txkeoqoFlYPHxD5L1Q9SfGuVFLK6/HubWcQvrS7buX5piYbqGZu5hNgx+Xg
         mLGNPYQAhHC/Ak/qtdy+GPppZgHJYfhdvtUJ9+wOaN8aaFo8F4W+CrGfpyDPK9rSQF/l
         wYNurQvxozxXt8vfmDXQNTmGSML/CsviZzplReVu+vPgYDpVM5NbAqgOkUxXW80MEasH
         sayR1t9yhxBoxCaOLFf9GSMsQdrWk/9ML54mOW6UXZcdeA8MVaX9tovXVCTElZRYZmqw
         BMag==
X-Forwarded-Encrypted: i=1; AJvYcCV3YfhT2BQNdIAhclamgNkWiAc/kXKGDIFL2xAVQI5gD2xJi2tffPJQapPKB/KvfSNgUE49vVuaXuCkRa5VnWcYN/64kkj2aPJo
X-Gm-Message-State: AOJu0YzEmBss0bpjaTr2laahb+F2LTauU6Ue2EPOwBgG9A9GmLyuRujz
	RtcmTVkRzDtCtEHRdmoK361adIUR/RqkFdeg8eHEi+opt2HnLYOytda1Wd0Kpaj0vMJ/i8bz9vu
	RQ131xZwEmWFLiNxt6v3rAglcBWExkCqD1EtKHyHZBt0rzkAsnDp+CYgEJA==
X-Received: by 2002:a05:6000:178f:b0:366:ee01:30d6 with SMTP id ffacd0b85a97d-366ee0134b8mr13801266f8f.49.1719492166075;
        Thu, 27 Jun 2024 05:42:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi4M28RQ7G+nNIOa63jszPtkUbL0i85I1grdzJ47TU94N/Yvxp+ZjoFF6ELbprBr588NWf0w==
X-Received: by 2002:a05:6000:178f:b0:366:ee01:30d6 with SMTP id ffacd0b85a97d-366ee0134b8mr13801222f8f.49.1719492165589;
        Thu, 27 Jun 2024 05:42:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674357c12esm1752427f8f.15.2024.06.27.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:42:45 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:42:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 03/11] hw/acpi: Move AML building code for Generic
 Initiators to aml_build.c
Message-ID: <20240627144244.27473a32@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240620160324.109058-4-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-4-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Jun 2024 17:03:11 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Rather than attempting to create a generic function with mess of the two
> different device handle types, use a PCI handle specific variant.  If the
> ACPI handle form is needed then that can be introduced alongside this
> with little duplicated code.
>=20
> Drop the PCIDeviceHandle in favor of just passing the bus, devfn
> and segment directly.  devfn kept as a single byte because ARI means
> that in cases this is just an 8 bit function number.
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo=
.users.ipa.redhat.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

with typo fixed

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>=20
> ---
> v3: New patch based on Igor's comments on the endian fix.
> ---
>  include/hw/acpi/acpi_generic_initiator.h | 23 -------------
>  include/hw/acpi/aml-build.h              |  4 +++
>  hw/acpi/acpi_generic_initiator.c         | 39 ++-------------------
>  hw/acpi/aml-build.c                      | 44 ++++++++++++++++++++++++
>  4 files changed, 51 insertions(+), 59 deletions(-)
>=20
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/a=
cpi_generic_initiator.h
> index a304bad73e..7b98676713 100644
> --- a/include/hw/acpi/acpi_generic_initiator.h
> +++ b/include/hw/acpi/acpi_generic_initiator.h
> @@ -19,29 +19,6 @@ typedef struct AcpiGenericInitiator {
>      uint16_t node;
>  } AcpiGenericInitiator;
> =20
> -/*
> - * ACPI 6.3:
> - * Table 5-81 Flags =E2=80=93 Generic Initiator Affinity Structure
> - */
> -typedef enum {
> -    /*
> -     * If clear, the OSPM ignores the contents of the Generic
> -     * Initiator/Port Affinity Structure. This allows system firmware
> -     * to populate the SRAT with a static number of structures, but only
> -     * enable them as necessary.
> -     */
> -    GEN_AFFINITY_ENABLED =3D (1 << 0),
> -} GenericAffinityFlags;
> -
> -/*
> - * ACPI 6.3:
> - * Table 5-80 Device Handle - PCI
> - */
> -typedef struct PCIDeviceHandle {
> -    uint16_t segment;
> -    uint16_t bdf;
> -} PCIDeviceHandle;
> -
>  void build_srat_generic_pci_initiator(GArray *table_data);
> =20
>  #endif
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index a3784155cb..9ba3a21c13 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -486,6 +486,10 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *rang=
e_set, uint32_t io_offset,
>  void build_srat_memory(GArray *table_data, uint64_t base,
>                         uint64_t len, int node, MemoryAffinityFlags flags=
);
> =20
> +void build_srat_pci_generic_initiator(GArray * table_date, int node,

s/table_date/table_data/

> +                                      uint16_t segment, uint8_t bus,
> +                                      uint8_t devfn);
> +
>  void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms=
,
>                  const char *oem_id, const char *oem_table_id);
> =20
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_init=
iator.c
> index 4a02c19468..7665b16107 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -74,40 +74,11 @@ static void acpi_generic_initiator_class_init(ObjectC=
lass *oc, void *data)
>          acpi_generic_initiator_set_node, NULL, NULL);
>  }
> =20
> -/*
> - * ACPI 6.3:
> - * Table 5-78 Generic Initiator Affinity Structure
> - */
> -static void
> -build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
> -                                          PCIDeviceHandle *handle)
> -{
> -    uint8_t index;
> -
> -    build_append_int_noprefix(table_data, 5, 1);  /* Type */
> -    build_append_int_noprefix(table_data, 32, 1); /* Length */
> -    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
> -    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type:=
 PCI */
> -    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain=
 */
> -
> -    /* Device Handle - PCI */
> -    build_append_int_noprefix(table_data, handle->segment, 2);
> -    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
> -    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf),=
 1);
> -    for (index =3D 0; index < 12; index++) {
> -        build_append_int_noprefix(table_data, 0, 1);
> -    }
> -
> -    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* F=
lags */
> -    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
> -}
> -
>  static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
>      AcpiGenericInitiator *gi;
>      GArray *table_data =3D opaque;
> -    PCIDeviceHandle dev_handle;
>      PCIDevice *pci_dev;
>      Object *o;
> =20
> @@ -130,13 +101,9 @@ static int build_all_acpi_generic_initiators(Object =
*obj, void *opaque)
>      }
> =20
>      pci_dev =3D PCI_DEVICE(o);
> -
> -    dev_handle.segment =3D 0;
> -    dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
> -                                   pci_dev->devfn);
> -
> -    build_srat_generic_pci_initiator_affinity(table_data,
> -                                              gi->node, &dev_handle);
> +    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> +                                     pci_bus_num(pci_get_bus(pci_dev)),
> +                                     pci_dev->devfn);
> =20
>      return 0;
>  }
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe..968b654e58 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1938,6 +1938,50 @@ void build_srat_memory(GArray *table_data, uint64_=
t base,
>      build_append_int_noprefix(table_data, 0, 8); /* Reserved */
>  }
> =20
> +/*
> + * ACPI Spec Revision 6.3
> + * Table 5-80 Device Handle - PCI
> + */
> +static void build_append_srat_pci_device_handle(GArray *table_data,
> +                                                uint16_t segment,
> +                                                uint8_t bus, uint8_t dev=
fn)
> +{
> +    /* PCI segment number */
> +    build_append_int_noprefix(table_data, segment, 2);
> +    /* PCI Bus Device Function */
> +    build_append_int_noprefix(table_data, bus, 1);
> +    build_append_int_noprefix(table_data, devfn, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 12);
> +}
> +
> +/*
> + * ACPI spec, Revision 6.3
> + * 5.2.16.6 Generic Initiator Affinity Structure
> + *    With PCI Device Handle.
> + */
> +void build_srat_pci_generic_initiator(GArray *table_data, int node,
> +                                      uint16_t segment, uint8_t bus,
> +                                      uint8_t devfn)
> +{
> +    /* Type */
> +    build_append_int_noprefix(table_data, 5, 1);
> +    /* Length */
> +    build_append_int_noprefix(table_data, 32, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    /* Device Handle Type: PCI */
> +    build_append_int_noprefix(table_data, 1, 1);
> +    /* Proximity Domain */
> +    build_append_int_noprefix(table_data, node, 4);
> +    /* Device Handle */
> +    build_append_srat_pci_device_handle(table_data, segment, bus, devfn)=
;
> +    /* Flags - GI Enabled */
> +    build_append_int_noprefix(table_data, 1, 4);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +}
> +
>  /*
>   * ACPI spec 5.2.17 System Locality Distance Information Table
>   * (Revision 2.0 or later)

