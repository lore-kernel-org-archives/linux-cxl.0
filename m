Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B63C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Jun 2022 10:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiFXKt1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Jun 2022 06:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXKt1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Jun 2022 06:49:27 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2521A77053
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 03:49:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id o79so3862506ybc.4
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jun 2022 03:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTgxQSojsqqrecCrzUc0iEgcyiEfOCu5J3t+FfJocXE=;
        b=AxSGl1jhhnE+CUotMbw1YWPaRtN1y08fwVy5YuZs4B6B9ekEHJ4husIFzjM8Xcxba7
         wvIz79fGifofTQyiIDQILEkXjCFdFN32MkGvQYXmS2izGb75HTMwnHHTIn/aBG8rNXwi
         e+PO4eO7sADQgwtTO22aaG8DlT+tnGG3uRJ91434DgDdYLEUgg+P4ULSJJbfqTz6F/7d
         XuUXgw2yIH/EhjoPUAqgfN7oO1aAk1/4itwyQyaBoe8cogESYOUvrwN2o2FSJ02BsA+G
         Uf3mTQCw7BQdomDmDlzPhUCmBismVhKUkoL3dQyiEyOpq8acqTb+ynfJaJF19LowvKWx
         /c2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTgxQSojsqqrecCrzUc0iEgcyiEfOCu5J3t+FfJocXE=;
        b=hC2ru84zR7gyhQSXnAb6dpQtyf4qfmZNt9tjy74Kk9gOoYaisqL5u+WZ5sjibvl2S5
         zJmlcnVL5FeFLyRakl91Q3TYm4SVhYXHogzFNsOB3MjnekNEpRblwQt7O6K6927Szqv5
         4lIV5P9GofGWEe0mAM/p04EYDdj97dguUJsVQ3k7sKwCvXf/MojdiYhCze79wm0vFOBL
         EZrQW7zz87v1JHB9iBQyYnET4kvFgW5RiM1qq2nu/KFo+RkdM3Gutxnfi2X9q8JmVdxz
         gV8Ac8PWSdf2aY0E/SsMWaEtn7/vlRoEeZb388nMX6lRN1NrjTe06AR90DFDznHP+pK1
         rHTQ==
X-Gm-Message-State: AJIora/UzmEjbd0bJAI/O4nX+LKcyImi6v8y28u1ca0PpTE49UrX11mX
        EU6tYDKjQb+zO6O0oriQ2BL5P9KxOAexL46O9q5n+Q==
X-Google-Smtp-Source: AGRyM1sUYkiGBpPdotZZsIU3TJPBkL2b1bO6wO7dkIBG9Xxvx5QFf+s/z8JmKjt1EmutWdqd7ugUvWhsQ7wI2g2TOVc=
X-Received: by 2002:a25:810a:0:b0:669:9f30:7f1e with SMTP id
 o10-20020a25810a000000b006699f307f1emr11404152ybk.479.1656067765358; Fri, 24
 Jun 2022 03:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220616141950.23374-1-Jonathan.Cameron@huawei.com> <20220616141950.23374-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20220616141950.23374-2-Jonathan.Cameron@huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 24 Jun 2022 11:48:47 +0100
Message-ID: <CAFEAcA8U9oNDStfLpxOwodGm9MCTdLrt-WV+x_-rTGw9UpBGvA@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, alex.bennee@linaro.org, qemu-arm@nongnu.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 16 Jun 2022 at 15:20, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Code based on i386/pc enablement.
> The memory layout places space for 16 host bridge register regions after
> the GIC_REDIST2 in the extended memmap.
> The CFMWs are placed above the extended memmap.
>
> Only create the CEDT table if cxl=on set for the machine.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This seems to be missing code to advertise the new devices in the
device tree.

Somebody else had better review the ACPI changes :-)

>  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> @@ -178,6 +181,7 @@ static const MemMapEntry base_memmap[] = {
>  static MemMapEntry extended_memmap[] = {
>      /* Additional 64 MB redist region (can contain up to 512 redistributors) */
>      [VIRT_HIGH_GIC_REDIST2] =   { 0x0, 64 * MiB },
> +    [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */

Does this reshuffle the memory layout so that all the stuff after it
moves up ? If so, that's an incompatible change and would need
versioning somehow.

More generally, should this new addition to the machine be
versioned? What did we do for the pc machine types?

>      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
>      /* Second PCIe window */
>      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, 512 * GiB },
> @@ -1525,6 +1529,16 @@ static void create_pcie(VirtMachineState *vms)
>      }
>  }
>
> +static void create_cxl_host_reg_region(VirtMachineState *vms)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *mr = &vms->cxl_devices_state.host_mr;
> +
> +    memory_region_init(mr, OBJECT(vms), "cxl_host_reg",
> +                       vms->memmap[VIRT_CXL_HOST].size);
> +    memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].base, mr);
> +}

> @@ -1779,6 +1799,20 @@ static void virt_set_memmap(VirtMachineState *vms, int pa_bits)
>          memory_region_init(&ms->device_memory->mr, OBJECT(vms),
>                             "device-memory", device_memory_size);
>      }
> +
> +    if (vms->cxl_devices_state.fixed_windows) {
> +        GList *it;
> +
> +        base = ROUND_UP(base, 256 * MiB);
> +        for (it = vms->cxl_devices_state.fixed_windows; it; it = it->next) {
> +            CXLFixedWindow *fw = it->data;
> +
> +            fw->base = base;
> +            memory_region_init_io(&fw->mr, OBJECT(vms), &cfmws_ops, fw,
> +                                  "cxl-fixed-memory-region", fw->size);

Why is board model code having to init memory regions for this
device? Shouldn't the device be creating the memory regions itself
and then exposing them for the board code to map them ?

> +            base += fw->size;
> +        }
> +    }
>  }
>
>  /*
> @@ -2215,6 +2249,14 @@ static void machvirt_init(MachineState *machine)
>          memory_region_add_subregion(sysmem, machine->device_memory->base,
>                                      &machine->device_memory->mr);
>      }
> +    if (vms->cxl_devices_state.fixed_windows) {
> +        GList *it;
> +        for (it = vms->cxl_devices_state.fixed_windows; it; it = it->next) {
> +            CXLFixedWindow *fw = it->data;
> +
> +            memory_region_add_subregion(sysmem, fw->base, &fw->mr);
> +        }
> +    }
>
>      virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
>
> @@ -2241,6 +2283,7 @@ static void machvirt_init(MachineState *machine)
>      create_rtc(vms);
>
>      create_pcie(vms);
> +    create_cxl_host_reg_region(vms);
>
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
> @@ -3070,6 +3113,7 @@ static void virt_instance_init(Object *obj)
>
>      vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
>      vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
> +    cxl_machine_init(obj, &vms->cxl_devices_state);
>  }
>
>  static const TypeInfo virt_machine_info = {
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 15feabac63..403c9107e5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -35,6 +35,7 @@
>  #include "hw/boards.h"
>  #include "hw/arm/boot.h"
>  #include "hw/block/flash.h"
> +#include "hw/cxl/cxl.h"
>  #include "sysemu/kvm.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "qom/object.h"
> @@ -92,6 +93,7 @@ enum {
>  /* indices of IO regions located after the RAM */
>  enum {
>      VIRT_HIGH_GIC_REDIST2 =  VIRT_LOWMEMMAP_LAST,
> +    VIRT_CXL_HOST,
>      VIRT_HIGH_PCIE_ECAM,
>      VIRT_HIGH_PCIE_MMIO,
>  };
> @@ -176,6 +178,7 @@ struct VirtMachineState {
>      PCIBus *bus;
>      char *oem_id;
>      char *oem_table_id;
> +    CXLState cxl_devices_state;
>  };

I just looked at the CXLState struct. Why isn't this a device object ?

thanks
-- PMM
