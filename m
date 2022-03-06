Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63362C433EF
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiCFVcL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 16:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiCFVcK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 16:32:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6B5B12AA8
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 13:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646602274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDyEdrxvzfoxrtEU8f4yxFIl4BzdNLxj8WE2v08QpZA=;
        b=MbF+xKbftoQ8dpH1jJv02yxxPh3WAXfblCICzIzGlpzfNL9b4aqlhm2nC75lO7f6Vh675j
        KIKU0GGegRoNT7jaSK7O1N1g54igEDzOOgAf6DiCaWcLKxR6/wrUmhm/4okRhhWDLDuIoz
        pMMsz1EtTIJo0QHoi7S1iJAJ4VSW3kY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-kH5gox6BMb-p0vuPBolJCw-1; Sun, 06 Mar 2022 16:31:12 -0500
X-MC-Unique: kH5gox6BMb-p0vuPBolJCw-1
Received: by mail-ed1-f69.google.com with SMTP id n11-20020aa7c68b000000b0041641550e11so992085edq.8
        for <linux-cxl@vger.kernel.org>; Sun, 06 Mar 2022 13:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mDyEdrxvzfoxrtEU8f4yxFIl4BzdNLxj8WE2v08QpZA=;
        b=hVJG7nHrPjFNQlMARLsE1n/MDL7ZWvvP2OqeWCAdn0bC1Zc7Ev4Hy2OS+QeOG0OTUL
         pEAWp2G3Aa3qx+3gFJ7XlH6a6CbpPw946xt4D5b1qltRcG3gfvDqQ8RKSzIIMiBuk3J6
         WnfN3WsPBidbXQ9FS3YrNm2LYNZuo1TZhhibS/einAljYlMiQGEcExHiEDlJ4+jN51JD
         Q2rMEPeqFZNb+n6ilsHCqdXDHFlukc8duDyCnHphVdi6xOxI7b9GYrxEtrsr3UJN65+d
         Af1lpbJ8U/c5kbI5sIo30pF+dDca6JbpsbuN0iTaAHeJjtjAA3aGdzm3d3BL2h04j0o/
         PIAA==
X-Gm-Message-State: AOAM531Rl2U+Aly2NSby6yzri+sXh9z5H9NGbyiZrL4S2Dpz0PxTqtMa
        Tv5ogUuqUFnro4DvjPWJ2l2OMe/kQw4ZfBfzxltdNoTnHkl2F8J29TlAzpAP+C0NjO7d02+pWmm
        3xiQrhDwr/E1Pswjngi0R
X-Received: by 2002:a17:907:7ba6:b0:6d7:1888:d553 with SMTP id ne38-20020a1709077ba600b006d71888d553mr7063511ejc.98.1646602271047;
        Sun, 06 Mar 2022 13:31:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSIFCRcNaFgE8GkXwCEss7ARF+de6KG7ddR2I4QlTBhYxjkZaxNolzZ8LfVGQ/FimCRTdhUw==
X-Received: by 2002:a17:907:7ba6:b0:6d7:1888:d553 with SMTP id ne38-20020a1709077ba600b006d71888d553mr7063490ejc.98.1646602270676;
        Sun, 06 Mar 2022 13:31:10 -0800 (PST)
Received: from redhat.com ([2.55.138.228])
        by smtp.gmail.com with ESMTPSA id cy1-20020a0564021c8100b003e359e4f54asm5216694edb.43.2022.03.06.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 13:31:10 -0800 (PST)
Date:   Sun, 6 Mar 2022 16:31:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linuxarm@huawei.com, qemu-devel@nongnu.org,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v7 24/46] acpi/cxl: Add _OSC implementation (9.14.2)
Message-ID: <20220306162444-mutt-send-email-mst@kernel.org>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
 <20220306174137.5707-25-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220306174137.5707-25-Jonathan.Cameron@huawei.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Mar 06, 2022 at 05:41:15PM +0000, Jonathan Cameron wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> CXL 2.0 specification adds 2 new dwords to the existing _OSC definition
> from PCIe. The new dwords are accessed with a new uuid. This
> implementation supports what is in the specification.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  hw/acpi/Kconfig       |   5 ++
>  hw/acpi/cxl-stub.c    |  12 +++++
>  hw/acpi/cxl.c         | 104 ++++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/meson.build   |   4 +-
>  hw/i386/acpi-build.c  |  15 ++++--
>  include/hw/acpi/cxl.h |  23 ++++++++++
>  6 files changed, 157 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
> index 19caebde6c..3703aca212 100644
> --- a/hw/acpi/Kconfig
> +++ b/hw/acpi/Kconfig
> @@ -5,6 +5,7 @@ config ACPI_X86
>      bool
>      select ACPI
>      select ACPI_NVDIMM
> +    select ACPI_CXL
>      select ACPI_CPU_HOTPLUG
>      select ACPI_MEMORY_HOTPLUG
>      select ACPI_HMAT
> @@ -66,3 +67,7 @@ config ACPI_ERST
>      bool
>      default y
>      depends on ACPI && PCI
> +
> +config ACPI_CXL
> +    bool
> +    depends on ACPI
> diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c
> new file mode 100644
> index 0000000000..15bc21076b
> --- /dev/null
> +++ b/hw/acpi/cxl-stub.c
> @@ -0,0 +1,12 @@
> +
> +/*
> + * Stubs for ACPI platforms that don't support CXl
> + */
> +#include "qemu/osdep.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/cxl.h"
> +
> +void build_cxl_osc_method(Aml *dev)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> new file mode 100644
> index 0000000000..7124d5a1a3
> --- /dev/null
> +++ b/hw/acpi/cxl.c
> @@ -0,0 +1,104 @@
> +/*
> + * CXL ACPI Implementation
> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/acpi/acpi.h"
> +#include "hw/acpi/aml-build.h"
> +#include "hw/acpi/bios-linker-loader.h"
> +#include "hw/acpi/cxl.h"
> +#include "qapi/error.h"
> +#include "qemu/uuid.h"
> +
> +static Aml *__build_cxl_osc_method(void)
> +{
> +    Aml *method, *if_uuid, *else_uuid, *if_arg1_not_1, *if_cxl, *if_caps_masked;
> +    Aml *a_ctrl = aml_local(0);
> +    Aml *a_cdw1 = aml_name("CDW1");
> +
> +    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> +    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> +
> +    /* 9.14.2.1.4 */

List spec name and version pls?

> +    if_uuid = aml_if(
> +        aml_lor(aml_equal(aml_arg(0),
> +                          aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")),
> +                aml_equal(aml_arg(0),
> +                          aml_touuid("68F2D50B-C469-4D8A-BD3D-941A103FD3FC"))));
> +    aml_append(if_uuid, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> +    aml_append(if_uuid, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> +
> +    aml_append(if_uuid, aml_store(aml_name("CDW3"), a_ctrl));
> +
> +    /* This is all the same as what's used for PCIe */

Referring to what exactly?
Better to also document the meaning.


> +    aml_append(if_uuid,
> +               aml_and(aml_name("CTRL"), aml_int(0x1F), aml_name("CTRL")));
> +
> +    if_arg1_not_1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> +    /* Unknown revision */
> +    aml_append(if_arg1_not_1, aml_or(a_cdw1, aml_int(0x08), a_cdw1));
> +    aml_append(if_uuid, if_arg1_not_1);
> +
> +    if_caps_masked = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
> +    /* Capability bits were masked */
> +    aml_append(if_caps_masked, aml_or(a_cdw1, aml_int(0x10), a_cdw1));
> +    aml_append(if_uuid, if_caps_masked);
> +
> +    aml_append(if_uuid, aml_store(aml_name("CDW2"), aml_name("SUPP")));
> +    aml_append(if_uuid, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> +
> +    if_cxl = aml_if(aml_equal(
> +        aml_arg(0), aml_touuid("68F2D50B-C469-4D8A-BD3D-941A103FD3FC")));
> +    /* CXL support field */
> +    aml_append(if_cxl, aml_create_dword_field(aml_arg(3), aml_int(12), "CDW4"));
> +    /* CXL capabilities */
> +    aml_append(if_cxl, aml_create_dword_field(aml_arg(3), aml_int(16), "CDW5"));
> +    aml_append(if_cxl, aml_store(aml_name("CDW4"), aml_name("SUPC")));
> +    aml_append(if_cxl, aml_store(aml_name("CDW5"), aml_name("CTRC")));
> +
> +    /* CXL 2.0 Port/Device Register access */
> +    aml_append(if_cxl,
> +               aml_or(aml_name("CDW5"), aml_int(0x1), aml_name("CDW5")));
> +    aml_append(if_uuid, if_cxl);
> +
> +    /* Update DWORD3 (the return value) */
> +    aml_append(if_uuid, aml_store(a_ctrl, aml_name("CDW3")));
> +
> +    aml_append(if_uuid, aml_return(aml_arg(3)));
> +    aml_append(method, if_uuid);
> +
> +    else_uuid = aml_else();
> +
> +    /* unrecognized uuid */
> +    aml_append(else_uuid,
> +               aml_or(aml_name("CDW1"), aml_int(0x4), aml_name("CDW1")));
> +    aml_append(else_uuid, aml_return(aml_arg(3)));
> +    aml_append(method, else_uuid);
> +
> +    return method;
> +}
> +
> +void build_cxl_osc_method(Aml *dev)
> +{
> +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> +    aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
> +    aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
> +    aml_append(dev, __build_cxl_osc_method());
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index 8bea2e6933..cea2f5f93a 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -13,6 +13,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false: files('acpi-mem-hotplu
>  acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('acpi-nvdimm-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
> @@ -33,4 +34,5 @@ softmmu_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
>  softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('acpi-stub.c', 'aml-build-stub.c',
>                                                    'acpi-x86-stub.c', 'ipmi-stub.c', 'ghes-stub.c',
>                                                    'acpi-mem-hotplug-stub.c', 'acpi-cpu-hotplug-stub.c',
> -                                                  'acpi-pci-hotplug-stub.c', 'acpi-nvdimm-stub.c'))
> +                                                  'acpi-pci-hotplug-stub.c', 'acpi-nvdimm-stub.c',
> +                                                  'cxl-stub.c'))
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0a28dd6d4e..b5a4b663f2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -66,6 +66,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/utils.h"
>  #include "hw/acpi/pci.h"
> +#include "hw/acpi/cxl.h"
>  
>  #include "qom/qom-qobject.h"
>  #include "hw/i386/amd_iommu.h"
> @@ -1574,11 +1575,15 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>              if (pci_bus_is_cxl(bus)) {
> -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> -                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> -
> -                /* Expander bridges do not have ACPI PCI Hot-plug enabled */
> -                aml_append(dev, build_q35_osc_method(true));
> +                struct Aml *pkg = aml_package(2);
> +
> +                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
> +                aml_append(pkg, aml_eisaid("PNP0A08"));
> +                aml_append(pkg, aml_eisaid("PNP0A03"));
> +                aml_append(dev, aml_name_decl("_CID", pkg));
> +                aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> +                aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> +                build_cxl_osc_method(dev);
>              } else if (pci_bus_is_express(bus)) {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> new file mode 100644
> index 0000000000..7b8f3b8a2e
> --- /dev/null
> +++ b/include/hw/acpi/cxl.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (C) 2020 Intel Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_ACPI_CXL_H
> +#define HW_ACPI_CXL_H
> +
> +void build_cxl_osc_method(Aml *dev);
> +
> +#endif
> -- 
> 2.32.0

