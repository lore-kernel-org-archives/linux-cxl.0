Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0027C433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 24 May 2022 18:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiEXSNS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 May 2022 14:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiEXSNQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 May 2022 14:13:16 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F42346A03B
        for <linux-cxl@vger.kernel.org>; Tue, 24 May 2022 11:13:14 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c1so15629468qkf.13
        for <linux-cxl@vger.kernel.org>; Tue, 24 May 2022 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tt+yoXSfaSEDtJwWBq0ccW/zcqSPyDxpK46AB1kjft4=;
        b=mBdseHK+I3PpHzSoeFpZFjuq/Ij6DVUUp/4glqzJ70W6kQl/Kx2o5bnl5v4VSRUP16
         psYjwyON6AgZKd1O3Q1MCPqh9nxQ0YYPhfBxvQSzJHSziKfNbuUJgNEccvRORnSBTC0e
         eDakbmIsFJ95NVSOaNy2xdE8jkDY+QQD2ZyhlI2utzxi9fiDDk5SJVkeNTpyCMCle5l2
         FuenAlmPTNDhsWDbSU/6Unm/3FRnNSeVFkx4mQNLD7fxEllVy5zQ0dfVpnnkjgQ/Zwqz
         XTsAChUNh/hXs0s0ClUQwF90oJxZvmxXCSlxd23+KoohCex8H2nfbWIPX1im7VUbhPJw
         NCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Tt+yoXSfaSEDtJwWBq0ccW/zcqSPyDxpK46AB1kjft4=;
        b=cNfj3dfukp042ZzkKJc4xWiVL7GCfx8W/5DHPFj+0JbATiW6BveVxZfVHX6hMZxBhG
         FejQ80yYnBNNx9zv3W33wAI6ZAKgIQnTqJ/ywKRtnFHA2JiLFnpf4Ub9qAbiq1fHGCzC
         NZFzwABuGf1J5XrlRiGS3+V9TC9Hw5kyc42TTv73cikRPVf5FMLnnMBQ2vA1jObzApw4
         ct0C030cDM4YGiaZN/eAqtLRCAkaznXdZYSawLKyki+Kq8QMpTXOWub8RUQZNE1sv9ht
         DXO5neVvA5GnWEVx+hfQM2ufoSXERtKLrJJ+Zz9GY/9dPMbZIe9QUBfAYqMnpjD1pKvI
         LNsA==
X-Gm-Message-State: AOAM531jSpfAtwRgZZt+a3C3bevh3TYH7n5US5qCtCGBZol1QThNaNbO
        AP0Ce+E4m8licrj6OoGFigEq9qw3ag==
X-Google-Smtp-Source: ABdhPJw/nHHHEb3vRdcCQ1R2PCPjpbu2YzDQqfnCby7n/oT0dXv4x0wQf6lXXOqMeVgVU7lz0OL7/g==
X-Received: by 2002:a05:620a:248f:b0:6a3:ac24:931c with SMTP id i15-20020a05620a248f00b006a3ac24931cmr5200122qkn.122.1653415993841;
        Tue, 24 May 2022 11:13:13 -0700 (PDT)
Received: from serve.minyard.net ([47.184.144.75])
        by smtp.gmail.com with ESMTPSA id a13-20020a37660d000000b0069fc13ce1e8sm6561400qkc.25.2022.05.24.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:13:13 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:15a9:1d6a:8b02:cb8d])
        by serve.minyard.net (Postfix) with ESMTPSA id D20D91800BB;
        Tue, 24 May 2022 18:13:11 +0000 (UTC)
Date:   Tue, 24 May 2022 13:13:10 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, qemu-devel@nongnu.org,
        Klaus Jensen <its@irrelevant.dk>, linux-cxl@vger.kernel.org,
        Damien Hedde <damien.hedde@greensocs.com>,
        Peter Delevoryas <pdel@fb.com>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH 2/2] arm/virt: Add aspeed-i2c controller and MCTP EP
 to enable MCTP testing
Message-ID: <20220524181310.GI3767252@minyard.net>
Reply-To: minyard@acm.org
References: <20220520170128.4436-1-Jonathan.Cameron@huawei.com>
 <20220520170128.4436-3-Jonathan.Cameron@huawei.com>
 <20220524163633.gycxq6v5i5ucz4ja@bwidawsk-mobl5>
 <20220524175043.00002ae8@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524175043.00002ae8@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, May 24, 2022 at 05:50:43PM +0100, Jonathan Cameron wrote:
> On Tue, 24 May 2022 09:36:44 -0700
> Ben Widawsky <bwidawsk@kernel.org> wrote:
> 
> > On 22-05-20 18:01:28, Jonathan Cameron wrote:
> > > As the only I2C emulation in QEMU that supports being both
> > > a master and a slave, suitable for MCTP over i2c is aspeed-i2c
> > > add this controller to the arm virt model and hook up our new
> > > i2c_mctp_cxl_fmapi device.
> > > 
> > > The current Linux driver for aspeed-i2c has a hard requirement on
> > > a reset controller.  Throw down the simplest reset controller
> > > I could find so as to avoid need to make any chance to the kernel
> > > code.  
> > 
> > s/chance/change
> oops :)
> > 
> > > 
> > > Patch also builds appropriate device tree.  Unfortunately for CXL
> > > we need to use ACPI (no DT bindings yet defined). Enabling this will
> > > either require appropriate support for MCTP on an i2c master that
> > > has ACPI bindings, or modifications of the kernel driver to support
> > > ACPI with aspeed-i2c (which might be a little controversial ;)  
> > 
> > I'm naive to what DT defines, but I assume what's there already is insufficient
> > to make the bindings for CXL. I say this because I believe it wouldn't be too
> > bad at all to make a cxl_dt.ko, and it's certainly less artificial than
> > providing ACPI support for things which don't naturally have ACPI support.
> 
> It wouldn't be that hard to work out a CXL dt binding, but it's not
> of sufficient interest to me that I'd want to do it (I'll review if someone
> else sends patches). Platforms I'm interested in CXL with are all strictly
> ACPI only.
> 
> The trick here I think, is going to be adding ACPI support for a suitable I2C controller
> which supports the requirement for supporting master and and I2C EP needed
> for MCTP. Either I find one that already has ACPI bindings and add enough
> emulation for this functionality, or work around the lack of ACPI bindings for the
> aspeed-i2c controller.
> 
> Based on a really quick check of I2C masters for which I have docs and that
> definitely have ACPI bindings, it's not a particularly common feature set.

Ben already got my comments.

It's not common, but it's something you are using, so it obviously
exists.  What hardware do you have?  The most natural thing might be to
add your controller.

-corey

> 
> Jonathan
> 
> 
> 
> > 
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  hw/arm/Kconfig        |  1 +
> > >  hw/arm/virt.c         | 77 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/hw/arm/virt.h |  2 ++
> > >  3 files changed, 80 insertions(+)
> > > 
> > > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > > index 219262a8da..4a733298cd 100644
> > > --- a/hw/arm/Kconfig
> > > +++ b/hw/arm/Kconfig
> > > @@ -30,6 +30,7 @@ config ARM_VIRT
> > >      select ACPI_VIOT
> > >      select VIRTIO_MEM_SUPPORTED
> > >      select ACPI_CXL
> > > +    select I2C_MCTP_CXL_FMAPI
> > >  
> > >  config CHEETAH
> > >      bool
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index d818131b57..ea04279515 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -80,6 +80,9 @@
> > >  #include "hw/char/pl011.h"
> > >  #include "hw/cxl/cxl.h"
> > >  #include "qemu/guest-random.h"
> > > +#include "hw/i2c/i2c.h"
> > > +#include "hw/i2c/aspeed_i2c.h"
> > > +#include "hw/misc/i2c_mctp_cxl_fmapi.h"
> > >  
> > >  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> > >      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> > > @@ -156,6 +159,8 @@ static const MemMapEntry base_memmap[] = {
> > >      [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
> > >      [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
> > >      [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
> > > +    [VIRT_I2C] =                { 0x0b000000, 0x00004000 },
> > > +    [VIRT_RESET_FAKE] =         { 0x0b004000, 0x00000010 },
> > >      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
> > >      [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
> > >      [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
> > > @@ -192,6 +197,7 @@ static const int a15irqmap[] = {
> > >      [VIRT_GPIO] = 7,
> > >      [VIRT_SECURE_UART] = 8,
> > >      [VIRT_ACPI_GED] = 9,
> > > +    [VIRT_I2C] = 10,
> > >      [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
> > >      [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
> > >      [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> > > @@ -1996,6 +2002,75 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
> > >      }
> > >  }
> > >  
> > > +static void create_mctp_test(MachineState *ms)
> > > +{
> > > +    VirtMachineState *vms = VIRT_MACHINE(ms);
> > > +    MemoryRegion *sysmem = get_system_memory();
> > > +    AspeedI2CState *aspeedi2c;
> > > +    struct DeviceState  *dev;
> > > +    char *nodename_i2c_master;
> > > +    char *nodename_i2c_sub;
> > > +    char *nodename_reset;
> > > +    uint32_t clk_phandle, reset_phandle;
> > > +    MemoryRegion *sysmem2;
> > > +   
> > > +    dev = qdev_new("aspeed.i2c-ast2600");
> > > +    aspeedi2c = ASPEED_I2C(dev);
> > > +    object_property_set_link(OBJECT(dev), "dram", OBJECT(ms->ram), &error_fatal);
> > > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_I2C].base);
> > > +    sysbus_connect_irq(SYS_BUS_DEVICE(&aspeedi2c->busses[0]), 0, qdev_get_gpio_in(vms->gic, vms->irqmap[VIRT_I2C]));
> > > +
> > > +    /* I2C bus DT */
> > > +    reset_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> > > +    nodename_reset = g_strdup_printf("/reset@%" PRIx64, vms->memmap[VIRT_RESET_FAKE].base);
> > > +    qemu_fdt_add_subnode(ms->fdt, nodename_reset);
> > > +    qemu_fdt_setprop_string(ms->fdt, nodename_reset, "compatible", "snps,dw-low-reset");
> > > +    qemu_fdt_setprop_sized_cells(ms->fdt, nodename_reset, "reg",
> > > +                                 2, vms->memmap[VIRT_RESET_FAKE].base,
> > > +                                 2, vms->memmap[VIRT_RESET_FAKE].size);
> > > +    qemu_fdt_setprop_cell(ms->fdt, nodename_reset, "#reset-cells", 0x1);
> > > +    qemu_fdt_setprop_cell(ms->fdt, nodename_reset, "phandle", reset_phandle);
> > > +    sysmem2 =  g_new(MemoryRegion, 1);
> > > +    memory_region_init_ram(sysmem2, NULL, "reset", vms->memmap[VIRT_RESET_FAKE].size, NULL);
> > > +    memory_region_add_subregion(sysmem, vms->memmap[VIRT_RESET_FAKE].base, sysmem2);
> > > +    
> > > +    clk_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> > > +    
> > > +    qemu_fdt_add_subnode(ms->fdt, "/mclk");
> > > +    qemu_fdt_setprop_string(ms->fdt, "/mclk", "compatible", "fixed-clock");
> > > +    qemu_fdt_setprop_cell(ms->fdt, "/mclk", "#clock-cells", 0x0);
> > > +    qemu_fdt_setprop_cell(ms->fdt, "/mclk", "clock-frequency", 24000);
> > > +    qemu_fdt_setprop_string(ms->fdt, "/mclk", "clock-output-names", "bobsclk");
> > > +    qemu_fdt_setprop_cell(ms->fdt, "/mclk", "phandle", clk_phandle);
> > > +
> > > +    nodename_i2c_master = g_strdup_printf("/i2c@%" PRIx64, vms->memmap[VIRT_I2C].base);
> > > +    qemu_fdt_add_subnode(ms->fdt, nodename_i2c_master);
> > > +    qemu_fdt_setprop_string(ms->fdt, nodename_i2c_master, "compatible",  "aspeed,ast2600-i2c-bus");
> > > +    qemu_fdt_setprop_cells(ms->fdt, nodename_i2c_master, "multi-master");
> > > +    qemu_fdt_setprop_cell(ms->fdt, nodename_i2c_master, "#size-cells", 0);
> > > +    qemu_fdt_setprop_cell(ms->fdt, nodename_i2c_master, "#address-cells", 1);
> > > +    qemu_fdt_setprop_cell(ms->fdt, nodename_i2c_master, "clocks", clk_phandle);
> > > +    qemu_fdt_setprop_string(ms->fdt, nodename_i2c_master, "clock-names", "bobsclk");
> > > +    qemu_fdt_setprop(ms->fdt, nodename_i2c_master, "mctp-controller", NULL, 0);
> > > +    qemu_fdt_setprop_cells(ms->fdt, nodename_i2c_master, "interrupts", GIC_FDT_IRQ_TYPE_SPI,
> > > +                           vms->irqmap[VIRT_I2C], GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> > > +    /* Offset to the first bus is 0x80, next one at 0x100 etc */
> > > +    qemu_fdt_setprop_sized_cells(ms->fdt, nodename_i2c_master, "reg",
> > > +                                 2, vms->memmap[VIRT_I2C].base + 0x80,
> > > +                                 2, 0x80);
> > > +    qemu_fdt_setprop_cells(ms->fdt, nodename_i2c_master, "resets", reset_phandle,  0);
> > > +
> > > +    nodename_i2c_sub = g_strdup_printf("/i2c@%" PRIx64 "/mctp@%" PRIx64, vms->memmap[VIRT_I2C].base, 0x50l);
> > > +    qemu_fdt_add_subnode(ms->fdt, nodename_i2c_sub);
> > > +    qemu_fdt_setprop_string(ms->fdt, nodename_i2c_sub, "compatible",  "mctp-i2c-controller");
> > > +    qemu_fdt_setprop_sized_cells(ms->fdt, nodename_i2c_sub, "reg", 1, 0x50 | 0x40000000);
> > > +
> > > +        
> > > +    /* Slave device - linux doesn't use the presence of dt node for this so don't create one*/
> > > +    i2c_slave_create_simple(aspeed_i2c_get_bus(aspeedi2c, 0), "i2c_mctp_cxl_switch", 0x4d);
> > > +}
> > > +
> > >  static void machvirt_init(MachineState *machine)
> > >  {
> > >      VirtMachineState *vms = VIRT_MACHINE(machine);
> > > @@ -2289,6 +2364,8 @@ static void machvirt_init(MachineState *machine)
> > >          create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
> > >      }
> > >  
> > > +    create_mctp_test(machine);
> > > +
> > >       /* connect powerdown request */
> > >       vms->powerdown_notifier.notify = virt_powerdown_req;
> > >       qemu_register_powerdown_notifier(&vms->powerdown_notifier);
> > > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > > index 67c08a62af..abbfac7c48 100644
> > > --- a/include/hw/arm/virt.h
> > > +++ b/include/hw/arm/virt.h
> > > @@ -71,6 +71,8 @@ enum {
> > >      VIRT_SMMU,
> > >      VIRT_UART,
> > >      VIRT_MMIO,
> > > +    VIRT_I2C,
> > > +    VIRT_RESET_FAKE,
> > >      VIRT_RTC,
> > >      VIRT_FW_CFG,
> > >      VIRT_PCIE,
> > > -- 
> > > 2.32.0
> > >   
> 
