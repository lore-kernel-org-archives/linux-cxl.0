Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F219539F
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jan 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024611; cv=none; b=BoMUv+V/IFKJVem6xm0m3e7cVX+KQH7SjHdg6xGFvzeQY5eY9u/mIde2A05OenfFhtIYY4WRWTxbvB3J4Cd1AcNLL6BRxX0/kZMt9k52YpC7EL5BYJ/uvtPJGY88icRcHx/WR1P0c7eLggvKK0HZ6g3Lb8I360mFaryleh3uhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024611; c=relaxed/simple;
	bh=MzZwFO1KrVmDyraKNh0d8wyR47EpUMUGm+ZXv37jo9o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCrBpT3M+2WS0FM2824i8Qb36bCqs2uGsWFvH6Lunyj6mVTYcKXlu7D7DrARAqK65/gphen6OUonLrRure4r8J8TmXtao7FbsYwivcAnrMPyuorr8HYj/S8mP0sgwnXkX7EMnDZIzyDbeYqtuLrwReNPfkDNvkR5lGjgdLU8VRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YYfjJ1ghNz6M4nK;
	Thu, 16 Jan 2025 18:48:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ACCF3140B63;
	Thu, 16 Jan 2025 18:50:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 16 Jan
 2025 11:50:05 +0100
Date: Thu, 16 Jan 2025 10:50:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH] hw/cxl: Introduce CXL_T3_MSIX_VECTOR enumeration
Message-ID: <20250116105004.0000442a@huawei.com>
In-Reply-To: <3ae1403f-3a70-4826-b952-3fce27d91407@fujitsu.com>
References: <20250115075846.167552-1-lizhijian@fujitsu.com>
	<20250115135135.000066fa@huawei.com>
	<3ae1403f-3a70-4826-b952-3fce27d91407@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 16 Jan 2025 01:18:28 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 15/01/2025 21:51, Jonathan Cameron wrote:
> > On Wed, 15 Jan 2025 15:58:46 +0800
> > Li Zhijian <lizhijian@fujitsu.com> wrote:
> >  =20
> >> Introduce the `CXL_T3_MSIX_VECTOR` enumeration to specify MSIX vector
> >> assignments specific to the Type 3 (T3) CXL device.
> >>
> >> The primary goal of this change is to encapsulate the MSIX vector uses
> >> that are unique to the T3 device within an enumeration, improving code
> >> readability and maintenance by avoiding magic numbers. This organizati=
onal
> >> change allows for more explicit references to each vector=E2=80=99s ro=
le, thereby
> >> reducing the potential for misconfiguration.
> >>
> >> It also modified `mailbox_reg_init_common` to accept the `msi_n` param=
eter,
> >> reflecting the new MSIX vector setup.
> >>
> >> This pertains to the T3 device privately; other endpoints should refra=
in from
> >> using it, despite its public accessibility to all of them.
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com> =20
> > A few things inline. I'll apply this with the following tweak. =20
>=20
> Thank you!
>=20
> These changes are good to me.
>=20
> Thanks
> Zhijian
>=20
>=20
> BTW, during making this patch, i noticed that are a few abused cleanup in=
 the error path
> of xxx_realize() vs xxx_exit()
>=20
> For example:
> ct3_realize()
> {
> ...
> err1:
>    cleanup1;
>=20
> err2:
>    cleanup2;
> }
>=20
> ct3_exit()
> {
>    cleanup1;
>    cleanup2;
> }
>=20
> These cleanups will function correctly only if both cleanup1 and cleanup2=
 are reentrant.
> However, this is not the case in `ct3_realize()` and other CXL-related `x=
xx_realize()` functions.
>=20
> When examining other devices, we rarely observe any cleanups in the `xxx_=
realize()`
> error path, as the cleanup in `xxx_exit()` alone suffices.
>=20
> I intend to address these cleanups if you have not yet done so.  @Jonathan

You've lost me.  If realize() fails we should exit hard.  Why is ct3_exit()=
 called
as well.  Perhaps the issue is failure to set errp in some error paths?
So we give the impression that it is fine to carry on when we should not.

Jonathan

>=20
>=20
> Thanks
> Zhijian
>=20
>=20
> >=20
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index e765edd227..3a0ee7e8e7 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -133,14 +133,6 @@ typedef enum {
> >       CXL_MBOX_MAX =3D 0x20
> >   } CXLRetCode;
> >=20
> > -/* type3 device private */
> > -enum CXL_T3_MSIX_VECTOR {
> > -    CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS =3D 0,
> > -    CXL_T3_MSIX_EVENT_START =3D 2,
> > -    CXL_T3_MSIX_MBOX =3D CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
> > -    CXL_T3_MSIX_VECTOR_NR
> > -};
> > -
> >   typedef struct CXLCCI CXLCCI;
> >   typedef struct cxl_device_state CXLDeviceState;
> >   struct cxl_cmd;
> > diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
> > index 762d881588..833b824619 100644
> > --- a/hw/cxl/switch-mailbox-cci.c
> > +++ b/hw/cxl/switch-mailbox-cci.c
> > @@ -17,7 +17,7 @@
> >   #include "hw/qdev-properties.h"
> >   #include "hw/cxl/cxl.h"
> >=20
> > -#define CXL_SWCCI_MSIX_MBOX CXL_T3_MSIX_MBOX
> > +#define CXL_SWCCI_MSIX_MBOX 3
> >=20
> >   static void cswmbcci_reset(DeviceState *dev)
> >   {
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index ba1c79afe8..dc163f5b63 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -30,6 +30,14 @@
> >   #include "hw/cxl/cxl.h"
> >   #include "hw/pci/msix.h"
> >=20
> > +/* type3 device private */
> > +enum CXL_T3_MSIX_VECTOR {
> > +    CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS =3D 0,
> > +    CXL_T3_MSIX_EVENT_START =3D 2,
> > +    CXL_T3_MSIX_MBOX =3D CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
> > +    CXL_T3_MSIX_VECTOR_NR
> > +};
> > +
> >   #define DWORD_BYTE 4
> >   #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >=20
> >  =20
> >> ---
> >> V3: new patch to introduce a T3 specific enumeration # Jonathan
> >> ---
> >>   hw/cxl/cxl-device-utils.c   | 12 +++++-------
> >>   hw/cxl/switch-mailbox-cci.c |  4 +++-
> >>   hw/mem/cxl_type3.c          | 12 ++++++------
> >>   include/hw/cxl/cxl_device.h | 12 ++++++++++--
> >>   4 files changed, 24 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> >> index 035d034f6dd8..52ad1e4c3f7a 100644
> >> --- a/hw/cxl/cxl-device-utils.c
> >> +++ b/hw/cxl/cxl-device-utils.c
> >> @@ -352,10 +352,8 @@ static void device_reg_init_common(CXLDeviceState=
 *cxl_dstate)
> >>       }
> >>   }
> >>  =20
> >> -static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
> >> +static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate, int m=
si_n)
> >>   {
> >> -    const uint8_t msi_n =3D 9;
> >> -
> >>       /* 2048 payload size */
> >>       ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_C=
AP,
> >>                        PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
> >> @@ -382,7 +380,7 @@ static void memdev_reg_init_common(CXLDeviceState =
*cxl_dstate)
> >>       cxl_dstate->memdev_status =3D memdev_status_reg;
> >>   }
> >>  =20
> >> -void cxl_device_register_init_t3(CXLType3Dev *ct3d)
> >> +void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n)
> >>   {
> >>       CXLDeviceState *cxl_dstate =3D &ct3d->cxl_dstate;
> >>       uint64_t *cap_h =3D cxl_dstate->caps_reg_state64;
> >> @@ -398,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
> >>       device_reg_init_common(cxl_dstate);
> >>  =20
> >>       cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERS=
ION);
> >> -    mailbox_reg_init_common(cxl_dstate);
> >> +    mailbox_reg_init_common(cxl_dstate, msi_n);
> >>  =20
> >>       cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000,
> >>           CXL_MEM_DEV_STATUS_VERSION);
> >> @@ -408,7 +406,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
> >>                                 CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> >>   }
> >>  =20
> >> -void cxl_device_register_init_swcci(CSWMBCCIDev *sw)
> >> +void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n)
> >>   {
> >>       CXLDeviceState *cxl_dstate =3D &sw->cxl_dstate;
> >>       uint64_t *cap_h =3D cxl_dstate->caps_reg_state64;
> >> @@ -423,7 +421,7 @@ void cxl_device_register_init_swcci(CSWMBCCIDev *s=
w)
> >>       device_reg_init_common(cxl_dstate);
> >>  =20
> >>       cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
> >> -    mailbox_reg_init_common(cxl_dstate);
> >> +    mailbox_reg_init_common(cxl_dstate, msi_n);
> >>  =20
> >>       cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
> >>       memdev_reg_init_common(cxl_dstate);
> >> diff --git a/hw/cxl/switch-mailbox-cci.c b/hw/cxl/switch-mailbox-cci.c
> >> index 65cdac6cc139..762d8815880d 100644
> >> --- a/hw/cxl/switch-mailbox-cci.c
> >> +++ b/hw/cxl/switch-mailbox-cci.c
> >> @@ -17,10 +17,12 @@
> >>   #include "hw/qdev-properties.h"
> >>   #include "hw/cxl/cxl.h"
> >>  =20
> >> +#define CXL_SWCCI_MSIX_MBOX CXL_T3_MSIX_MBOX =20
> > Hard code this value.  There is no logical reason it has
> > to match with the type 3 one.  That is just an artifact of how
> > the code evolved.
> >  =20
> >> +
> >>   static void cswmbcci_reset(DeviceState *dev)
> >>   {
> >>       CSWMBCCIDev *cswmb =3D CXL_SWITCH_MAILBOX_CCI(dev);
> >> -    cxl_device_register_init_swcci(cswmb);
> >> +    cxl_device_register_init_swcci(cswmb, CXL_SWCCI_MSIX_MBOX);
> >>   }
> >>  =20
> >>   static void cswbcci_realize(PCIDevice *pci_dev, Error **errp)
> >> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> >> index 0ae1704a345c..f64af19ed6ae 100644
> >> --- a/hw/mem/cxl_type3.c
> >> +++ b/hw/mem/cxl_type3.c
> >> @@ -843,7 +843,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error =
**errp)
> >>       ComponentRegisters *regs =3D &cxl_cstate->crb;
> >>       MemoryRegion *mr =3D &regs->component_registers;
> >>       uint8_t *pci_conf =3D pci_dev->config;
> >> -    unsigned short msix_num =3D 10;
> >>       int i, rc;
> >>       uint16_t count;
> >>  =20
> >> @@ -884,16 +883,17 @@ static void ct3_realize(PCIDevice *pci_dev, Erro=
r **errp)
> >>                        &ct3d->cxl_dstate.device_registers);
> >>  =20
> >>       /* MSI(-X) Initialization */
> >> -    rc =3D msix_init_exclusive_bar(pci_dev, msix_num, 4, NULL);
> >> +    rc =3D msix_init_exclusive_bar(pci_dev, CXL_T3_MSIX_VECTOR_NR, 4,=
 NULL);
> >>       if (rc) {
> >>           goto err_address_space_free;
> >>       }
> >> -    for (i =3D 0; i < msix_num; i++) {
> >> +    for (i =3D 0; i < CXL_T3_MSIX_VECTOR_NR; i++) {
> >>           msix_vector_use(pci_dev, i);
> >>       }
> >>  =20
> >>       /* DOE Initialization */
> >> -    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, tru=
e, 0);
> >> +    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, tru=
e,
> >> +                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
> >>  =20
> >>       cxl_cstate->cdat.build_cdat_table =3D ct3_build_cdat_table;
> >>       cxl_cstate->cdat.free_cdat_table =3D ct3_free_cdat_table;
> >> @@ -908,7 +908,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error =
**errp)
> >>       if (rc) {
> >>           goto err_release_cdat;
> >>       }
> >> -    cxl_event_init(&ct3d->cxl_dstate, 2);
> >> +    cxl_event_init(&ct3d->cxl_dstate, CXL_T3_MSIX_EVENT_START);
> >>  =20
> >>       /* Set default value for patrol scrub attributes */
> >>       ct3d->patrol_scrub_attrs.scrub_cycle_cap =3D
> >> @@ -1202,7 +1202,7 @@ static void ct3d_reset(DeviceState *dev)
> >>  =20
> >>       pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->sp=
eed);
> >>       cxl_component_register_init_common(reg_state, write_msk, CXL2_TY=
PE3_DEVICE);
> >> -    cxl_device_register_init_t3(ct3d);
> >> +    cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
> >>  =20
> >>       /*
> >>        * Bring up an endpoint to target with MCTP over VDM.
> >> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> >> index 561b375dc86d..e765edd22772 100644
> >> --- a/include/hw/cxl/cxl_device.h
> >> +++ b/include/hw/cxl/cxl_device.h
> >> @@ -133,6 +133,14 @@ typedef enum {
> >>       CXL_MBOX_MAX =3D 0x20
> >>   } CXLRetCode;
> >>  =20
> >> +/* type3 device private */
> >> +enum CXL_T3_MSIX_VECTOR {
> >> +    CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS =3D 0,
> >> +    CXL_T3_MSIX_EVENT_START =3D 2,
> >> +    CXL_T3_MSIX_MBOX =3D CXL_T3_MSIX_EVENT_START + CXL_EVENT_TYPE_MAX,
> >> +    CXL_T3_MSIX_VECTOR_NR
> >> +};
> >> + =20
> > Push this down in to the cxl_type3.c file.
> >=20
> > It it is not a global thing but specific choices for the type 3 emulati=
on.
> >  =20
> >>   typedef struct CXLCCI CXLCCI;
> >>   typedef struct cxl_device_state CXLDeviceState;
> >>   struct cxl_cmd;
> >> @@ -264,8 +272,8 @@ void cxl_device_register_block_init(Object *obj, C=
XLDeviceState *dev,
> >>   typedef struct CXLType3Dev CXLType3Dev;
> >>   typedef struct CSWMBCCIDev CSWMBCCIDev;
> >>   /* Set up default values for the register block */
> >> -void cxl_device_register_init_t3(CXLType3Dev *ct3d);
> >> -void cxl_device_register_init_swcci(CSWMBCCIDev *sw);
> >> +void cxl_device_register_init_t3(CXLType3Dev *ct3d, int msi_n);
> >> +void cxl_device_register_init_swcci(CSWMBCCIDev *sw, int msi_n);
> >>  =20
> >>   /*
> >>    * CXL r3.1 Section 8.2.8.1: CXL Device Capabilities Array Register =
=20
> > =20

