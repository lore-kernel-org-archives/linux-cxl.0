Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07D13A261
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011560; cv=none; b=hv/wZucHDAR9UtT0zTN1HAxkRfv6KT65EgjcbegkH8gqxeTvVplijxD75XCFR82cGPVSQH+vMNZ7lOjWIJifogKpEGt7t1Hf+i+384/JX0E04FsfSEJtdTxDAe3adXVnHO8NRBCANBEvGxQbpjojurpJA9317OR/aqbmIk4fEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011560; c=relaxed/simple;
	bh=hb0tC0Ww7jrSnLg2gSXlzDHBZT80zHACjxIlq955pHI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JlBH6KkjTQKmDTdaye/dB9C9fvbeOLFZ6oMUJ/jazqSGu/1nnwSj9gH1/EuOLTp2ypMp4cjeAx302uCuDaH+yv/Hg31SlOJf+nV/w9SigWCcR9ueKuURqY9cgFTi7B5TogCylB7oWIycT2dGscthJ9NSan5+xkPTy/VJS/B58kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwCz8038Hz6K5q9;
	Fri, 30 Aug 2024 17:49:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A1083140736;
	Fri, 30 Aug 2024 17:52:31 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 10:52:31 +0100
Date: Fri, 30 Aug 2024 10:52:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <quic_llindhol@quicinc.com>, <peter.maydell@linaro.org>,
	<marcin.juszkiewicz@linaro.org>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<chenbaozi@phytium.com.cn>, <wangyinfeng@phytium.com.cn>,
	<shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH 1/2] hw/arm/sbsa-ref: Enable CXL Host Bridge by
 pxb-cxl
Message-ID: <20240830105230.00002043@Huawei.com>
In-Reply-To: <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
	<20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 12:15:56 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> The memory layout places 1M space for 16 host bridge register regions
> in the sbsa-ref memmap. In addition, this creates a default pxb-cxl
> (bus_nr=3D0xfe) bridge with one cxl-rp on sbsa-ref.

If you are only supporting 1 host bridge you could reduce the space to just
fit that?

=46rom the command line example and code here it seems the pxb instances are =
hard
coded so you don't need to support the flexibility I needed for virt.

Otherwise, just superficial code comments inline.
Fixed setups are definitely easier to support :)

Jonathan


>=20
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  hw/arm/sbsa-ref.c | 54 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index ae37a92301..dc924d181e 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -41,7 +41,10 @@
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "hw/intc/arm_gicv3_its_common.h"
>  #include "hw/loader.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/pci-bridge/pci_expander_bridge.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/usb.h"
>  #include "hw/usb/xhci.h"
> @@ -52,6 +55,8 @@
>  #include "qom/object.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"

Headers look to be alphabetical order.

> =20
>  #define RAMLIMIT_GB 8192
>  #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> @@ -94,6 +99,7 @@ enum {
>      SBSA_SECURE_MEM,
>      SBSA_AHCI,
>      SBSA_XHCI,
> +    SBSA_CXL_HOST,
>  };
> =20
>  struct SBSAMachineState {
> @@ -105,6 +111,9 @@ struct SBSAMachineState {
>      int psci_conduit;
>      DeviceState *gic;
>      PFlashCFI01 *flash[2];
> +    CXLState cxl_devices_state;
> +    PCIBus *bus;

Lot of buses in a system, I'd call the pcibus
or similar. However, see below - I don't think
it is necessary.


> +    PCIBus *cxlbus;
>  };
> =20
>  #define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
> @@ -132,6 +141,8 @@ static const MemMapEntry sbsa_ref_memmap[] =3D {
>      /* Space here reserved for more SMMUs */
>      [SBSA_AHCI] =3D               { 0x60100000, 0x00010000 },
>      [SBSA_XHCI] =3D               { 0x60110000, 0x00010000 },
> +    /* 1M CXL Host Bridge Registers space (64KiB * 16) */
> +    [SBSA_CXL_HOST] =3D           { 0x60120000, 0x00100000 },

As below, can just leave space for however many you are creating.

>      /* Space here reserved for other devices */
>      [SBSA_PCIE_PIO] =3D           { 0x7fff0000, 0x00010000 },
>      /* 32-bit address PCIE MMIO space */
> @@ -631,6 +642,26 @@ static void create_smmu(const SBSAMachineState *sms,=
 PCIBus *bus)
>      }
>  }
> =20
> +static void create_pxb_cxl(SBSAMachineState *sms)
> +{
> +    CXLHost *host;
> +    PCIHostState *cxl;
> +
> +    sms->cxl_devices_state.is_enabled =3D true;
> +
> +    DeviceState *qdev;

I think qemu still sticks mostly to declarations at the top
of functions. So move this up.

> +    qdev =3D qdev_new(TYPE_PXB_CXL_DEV);
> +    qdev_prop_set_uint32(qdev, "bus_nr", 0xfe);

Ouch. That's not a lot of space in bus numbers.
Move it down a bit so there is room for switches etc
and not just a single root port.
Up to SBSA ref maintainers, but I'd use 0xc0 or something
like that.

> +
> +    PCIDevice *dev =3D PCI_DEVICE(qdev);

Declarations at the top I think.

> +    pci_realize_and_unref(dev, sms->bus, &error_fatal);
> +
> +    host =3D PXB_CXL_DEV(dev)->cxl_host_bridge;
> +    cxl =3D PCI_HOST_BRIDGE(host);
> +    sms->cxlbus =3D cxl->bus;
> +    pci_create_simple(sms->cxlbus, -1, "cxl-rp");

You want to enable at least some interleaving the HB so I'd
add at least 2 root ports.

> +}
> +
>  static void create_pcie(SBSAMachineState *sms)
>  {
>      hwaddr base_ecam =3D sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> @@ -682,12 +713,25 @@ static void create_pcie(SBSAMachineState *sms)
>      }
> =20
>      pci =3D PCI_HOST_BRIDGE(dev);
> +    sms->bus =3D pci->bus;

I'd carry on using pci->bus for this code to minimize changes
needed and set sms->bus at the end of the function, not the
start (see below - you can get rid of need to store pci->bus
I think).

> +
> +    pci_init_nic_devices(sms->bus, mc->default_nic);
> =20
> -    pci_init_nic_devices(pci->bus, mc->default_nic);
> +    pci_create_simple(sms->bus, -1, "bochs-display");
> =20
> -    pci_create_simple(pci->bus, -1, "bochs-display");
> +    create_smmu(sms, sms->bus);
> =20
> -    create_smmu(sms, pci->bus);
> +    create_pxb_cxl(sms);

Keep this similar to the others and pass in pci->bus even
though you are going to stash pci->bus

> +}


> =20
>  static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_si=
ze)
> @@ -823,6 +867,10 @@ static void sbsa_ref_init(MachineState *machine)
> =20
>      create_pcie(sms);
> =20
> +    create_cxl_host_reg_region(sms);
> +
> +    cxl_hook_up_pxb_registers(sms->bus, &sms->cxl_devices_state, &error_=
fatal);
> +

Fixed pxb instances certainly make this less of a dance than we need for pc=
 / virt
as the creation order is constrained in a way it isn't for those generic ma=
chines.

Given you know you only have one PXB-cxl and have it in sms->cxlbus
you could just call
pxb_cxl_hook_up_registers(&sms->cxl_devices_state, pci->cxlbus, &error_fata=
l)
I think and get same result without needed to add sms->bus to get hold of t=
he
pci bus.


>      create_secure_ec(secure_sysmem);
> =20
>      sms->bootinfo.ram_size =3D machine->ram_size;

