Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C26EC54EAA
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 21:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjAZV55 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 16:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjAZV5t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 16:57:49 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0380C30D1
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 13:57:42 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230126215736usoutp01bdd4d2565bb4563f2d5de3805f90d66f~9_qzmIW6A2735927359usoutp01O;
        Thu, 26 Jan 2023 21:57:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230126215736usoutp01bdd4d2565bb4563f2d5de3805f90d66f~9_qzmIW6A2735927359usoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674770257;
        bh=u907eVJUi4xOmomJEuNRmNaUp3HQlGvcKaUxp4Z+ADg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=X0fvpAEzrrUa0omPG38nP7e/CCBlWdOfALx2vtDO14wVccC2WZQzzA4wNbGSAoqkY
         lbkO1w9Tp956xI6B/1/hzUzcgmhBWLJ2soCsEF+nMBBHGcv0DjAtZKn6yUv+dzbqeO
         F9OYu+FE3l3whUW4+xhlP9Ds3ZXnEEP44GqjwSjQ=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230126215736uscas1p2e40c066bdb27b0c82c99e196ea0c10a7~9_qzZ-pXY1092510925uscas1p2L;
        Thu, 26 Jan 2023 21:57:36 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id D3.D2.06976.057F2D36; Thu,
        26 Jan 2023 16:57:36 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230126215736uscas1p2166334bf8185239cf6ac70053dc386c5~9_qzMTPdc1091510915uscas1p2B;
        Thu, 26 Jan 2023 21:57:36 +0000 (GMT)
X-AuditID: cbfec36d-d99ff70000011b40-cc-63d2f750e31c
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id E3.D8.17110.057F2D36; Thu,
        26 Jan 2023 16:57:36 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 26 Jan 2023 13:57:35 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        26 Jan 2023 13:57:35 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] hw/pxb-cxl: Support passthrough HDM Decoders unless
 overridden
Thread-Topic: [PATCH 2/2] hw/pxb-cxl: Support passthrough HDM Decoders
        unless overridden
Thread-Index: AQHZMNGiiun86hSl3USF52ioTTSPk66xxtgA
Date:   Thu, 26 Jan 2023 21:57:35 +0000
Message-ID: <20230126215727.GA203951@bgt-140510-bm03>
In-Reply-To: <20230125152703.9928-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63990672878450469B7D887C4403DD52@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ977unptrZHrD5CuPkxpJSyxyJlxrGZFjNiOE9PV9N17Z7O
        j4xFQrfV/MrmOvpldyT6cZyjK3VIKo4oVymZUNFR2PlV6J7a7r/39/N5vz+f12f7kgLPCqEP
        GZ+YzCoTpQliQoQba79bF0Q6mpiFdT/n0h1vnxJ02plCRNe1Hibou+8+4HRRfgtBWzX1OH2v
        rBGj//7qE9IPM014uLvk6P1+oaTQ3ItJyosyCEl3iwGTfK5qJiRfy30jiWjR0hg2IX4PqwwI
        2ymK07UNC5OKI/Y5rvdjqehdkBq5k0AFQ0lGOlIjEelJXUHwTZ0t4B/pGNh+mtCYS1/RhvGN
        awjqKrtGI4MIrDXdBP/QIch6YsdGIgQ1A6rUt4gRPZEKArvttDMhoHowGGp++38JSU6gtsCT
        TJr3RMMPu9ZtzN/4o9OpcWoW1D0odWJ4UCGQp/vlnO9OhUP1kcvOOqK8wFFf7KwLKG9o687F
        eOzxUJBjFvDaC4bvvCF4PQNeO3rdeL8f5FUMErwOg97rn0b1fNDlfxTwe8fDo/PdOJ+dBDWX
        bfjILUB9IsFy4eXo0JVgeTamJ8NQhw4buREoBooGRHw5AXIv3RidEwr5f0qwk2imxgVb44Kk
        cUHSuCBpXJDykLAIeas4Ti5jucBEdq8/J5VzqkSZP6OQl6P//6th+J7chExtA/4WhJHIgoAU
        iCd63IxoYjw9YqT7U1ilYodSlcByFjSZxMXeHoHLHjGelEyazO5m2SRWOdbFSHefVOyqcTt3
        caVFb2gN1s7RK6pMC4u7ZPlfBrerGYN1HFLpM1JuB+zvCeO8yBfDV1JXK6YQsrDm5JpF0wwv
        GjuW1Ndu89Ge3pDTIo/PNqbbHler25mHrX22Wm1l16b2VRGxkemzdCfsK0LVgUHqyNnZ1xwR
        XqoD8buqmbVZ5vsfnov8lvqdlfpGfZsS7rvBejVWvNVRVprJCGcvnup29+/h1Y8HNA21pqYz
        p0TnKg/1hxen7dqUue0YPtRPaDN+7+y0O8T0mqzO93Hs5r3mdY3+x5PIaEPs54NpOX9+R1X3
        WoxEz8D6QcX0kKAbNB0SPb/UvPFWQXvADmPwcr3uVVJMSoMY5+KkgfMESk76D41xwu7OAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWS2cA0UTfg+6Vkg4VnJS3uPr7AZtE8eTGj
        xYmbjWwW+58+Z7FYtfAam8X5WadYLA5vPMNk8f/XK1aL4707WBw4PVqOvGX1WLznJZPHplWd
        bB5Prm1m8ni/7yqbx+dNcgFsUVw2Kak5mWWpRfp2CVwZy279Yy1Y41jxfd1bpgbGp0ZdjJwc
        EgImEst332ICsYUEVjNKtBzT6GLkArI/MUo8XTmJHcJZxijx/VYrG0gVm4CixL6u7WC2iICR
        xLsbkxhBipgFXjBJPJ3aBZTg4BAWiJQ412sBURMl8athNwtM/Zkf99hBbBYBVYkTRzcwgti8
        AqYSC5b9grqiVOLbj/tg9ZwCDhIHmlaA1TAKiEl8P7UGrIZZQFzi1pP5TBAfCEgs2XOeGcIW
        lXj5+B8rhK0ocf/7S3aIeh2JBbs/sUHYdhIv172BsrUlli18zQxxg6DEyZlPWCB6JSUOrrjB
        MoFRYhaSdbOQjJqFZNQsJKNmIRm1gJF1FaN4aXFxbnpFsVFearlecWJucWleul5yfu4mRmDk
        n/53OHoH4+1bH/UOMTJxMB5ilOBgVhLh3ep4KVmINyWxsiq1KD++qDQntfgQozQHi5I478uo
        ifFCAumJJanZqakFqUUwWSYOTqkGJt/ASW+XZwVsvraUOWpDr67ohuOCyqrTje7/0bit9Xle
        s9mcx8cP74jWWTx37UTnheKCJny5xzgtCjgDundt3bLF7dPKzWd5QmNkps222bRx4/TCRds4
        Nm041vDjiYKt8qfcvxHnjBYmqeUyeKtPXZCwyOj/b02Hp09XKP61r+E5rCrCzrk1Us/B3uHl
        +T8MkmFKjyZNvXO/QHruYr1P7N5BK20zQq5uXhC06t3D5os5bzl3ndBsv2g82TmFxV50hevr
        5h9snNOU5rhdT/E+eVSb/UBR5eW4rY9Z2qNEz8yPMpseckS3rvzUv4cr5eonHjxsKSq+3qku
        UOqvnM88K9sA8V1R733YQ78zTKxVXqXEUpyRaKjFXFScCAA+02iJawMAAA==
X-CMS-MailID: 20230126215736uscas1p2166334bf8185239cf6ac70053dc386c5
CMS-TYPE: 301P
X-CMS-RootMailID: 20230126215736uscas1p2166334bf8185239cf6ac70053dc386c5
References: <20230125152703.9928-1-Jonathan.Cameron@huawei.com>
        <20230125152703.9928-3-Jonathan.Cameron@huawei.com>
        <CGME20230126215736uscas1p2166334bf8185239cf6ac70053dc386c5@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jan 25, 2023 at 03:27:03PM +0000, Jonathan Cameron wrote:

> The CXL r3.0 specification allows for there to be no HDM decoders on CXL
> Host Bridges if they have only a single root port. Instead, all accesses
> directed to the host bridge (as specified in CXL Fixed Memory Windows)
> are assumed to be routed to the single root port.
>=20
> Linux currently assumes this implementation choice. So to simplify testin=
g,
> make QEMU emulation also default to no HDM decoders under these particula=
r
> circumstances, but provide a hdm_for_passthrough boolean option to have
> HDM decoders as previously.
>=20
> Technically this is breaking backwards compatibility, but given the only
> known software stack used with the QEMU emulation is the Linux kernel
> and this configuration did not work before this change, there are
> unlikely to be any complaints that it now works. The option is retained
> to allow testing of software that does allow for these HDM decoders to ex=
ist,
> once someone writes it.
>=20
> Reported-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-host.c                   | 31 ++++++++++++--------
>  hw/pci-bridge/pci_expander_bridge.c | 44 +++++++++++++++++++++++++----
>  include/hw/cxl/cxl.h                |  1 +
>  include/hw/cxl/cxl_component.h      |  1 +
>  include/hw/pci/pci_bridge.h         |  1 +
>  5 files changed, 61 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 3c1ec8732a..6e923ceeaf 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -146,21 +146,28 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWin=
dow *fw, hwaddr addr)
>          return NULL;
>      }
> =20
> -    hb_cstate =3D cxl_get_hb_cstate(hb);
> -    if (!hb_cstate) {
> -        return NULL;
> -    }
> +    if (cxl_get_hb_passthrough(hb)) {
> +        rp =3D pcie_find_port_first(hb->bus);
> +        if (!rp) {
> +            return NULL;
> +        }
> +    } else {
> +        hb_cstate =3D cxl_get_hb_cstate(hb);
> +        if (!hb_cstate) {
> +            return NULL;
> +        }
> =20
> -    cache_mem =3D hb_cstate->crb.cache_mem_registers;
> +        cache_mem =3D hb_cstate->crb.cache_mem_registers;
> =20
> -    target_found =3D cxl_hdm_find_target(cache_mem, addr, &target);
> -    if (!target_found) {
> -        return NULL;
> -    }
> +        target_found =3D cxl_hdm_find_target(cache_mem, addr, &target);
> +        if (!target_found) {
> +            return NULL;
> +        }
> =20
> -    rp =3D pcie_find_port_by_pn(hb->bus, target);
> -    if (!rp) {
> -        return NULL;
> +        rp =3D pcie_find_port_by_pn(hb->bus, target);
> +        if (!rp) {
> +            return NULL;
> +        }
>      }
> =20
>      d =3D pci_bridge_get_sec_bus(PCI_BRIDGE(rp))->devices[0];
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
> index e752a21292..ead33f0c05 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -15,6 +15,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_host.h"
> +#include "hw/pci/pcie_port.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci-bridge/pci_expander_bridge.h"
> @@ -79,6 +80,13 @@ CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb)
>      return &host->cxl_cstate;
>  }
> =20
> +bool cxl_get_hb_passthrough(PCIHostState *hb)
> +{
> +    CXLHost *host =3D PXB_CXL_HOST(hb);
> +
> +    return host->passthrough;
> +}
> +
>  static int pxb_bus_num(PCIBus *bus)
>  {
>      PXBDev *pxb =3D convert_to_pxb(bus->parent_dev);
> @@ -289,15 +297,32 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int p=
in)
>      return pin - PCI_SLOT(pxb->devfn);
>  }
> =20
> -static void pxb_dev_reset(DeviceState *dev)
> +static void pxb_cxl_dev_reset(DeviceState *dev)
>  {
>      CXLHost *cxl =3D PXB_CXL_DEV(dev)->cxl.cxl_host_bridge;
>      CXLComponentState *cxl_cstate =3D &cxl->cxl_cstate;
> +    PCIHostState *hb =3D PCI_HOST_BRIDGE(cxl);
>      uint32_t *reg_state =3D cxl_cstate->crb.cache_mem_registers;
>      uint32_t *write_msk =3D cxl_cstate->crb.cache_mem_regs_write_mask;
> +    int dsp_count =3D 0;
> =20
>      cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_P=
ORT);
> -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT=
, 8);
> +    /*
> +     * The CXL specification allows for host bridges with no HDM decoder=
s
> +     * if they only have a single root port.
> +     */
> +    if (!PXB_DEV(dev)->hdm_for_passthrough) {
> +        dsp_count =3D pcie_count_ds_ports(hb->bus);
> +    }
> +    /* Initial reset will have 0 dsp so wait until > 0 */
> +    if (dsp_count =3D=3D 1) {
> +        cxl->passthrough =3D true;
> +        /* Set Capability ID in header to NONE */
> +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_CAPABILITY_HEADER, ID, 0);
> +    } else {
> +        ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_C=
OUNT,
> +                         8);
> +    }
>  }
> =20
>  static gint pxb_compare(gconstpointer a, gconstpointer b)
> @@ -481,9 +506,18 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Erro=
r **errp)
>      }
> =20
>      pxb_dev_realize_common(dev, CXL, errp);
> -    pxb_dev_reset(DEVICE(dev));
> +    pxb_cxl_dev_reset(DEVICE(dev));
>  }
> =20
> +static Property pxb_cxl_dev_properties[] =3D {
> +    /* Note: 0 is not a legal PXB bus number. */
> +    DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> +    DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIG=
NED),
> +    DEFINE_PROP_BOOL("bypass_iommu", PXBDev, bypass_iommu, false),
> +    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBDev, hdm_for_passthrough,=
 false),
when setting hdm_for_passthrough to true at the qemu command line, we
will see the segfault issue as before. I think this is expected as it
is the logic in cxl_cfmws_find_device. Wondering if there will be
following fixes to handle the case when hdm_for_passthrough is true.
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pxb_cxl_dev_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc   =3D DEVICE_CLASS(klass);
> @@ -497,12 +531,12 @@ static void pxb_cxl_dev_class_init(ObjectClass *kla=
ss, void *data)
>       */
> =20
>      dc->desc =3D "CXL Host Bridge";
> -    device_class_set_props(dc, pxb_dev_properties);
> +    device_class_set_props(dc, pxb_cxl_dev_properties);
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> =20
>      /* Host bridges aren't hotpluggable. FIXME: spec reference */
>      dc->hotpluggable =3D false;
> -    dc->reset =3D pxb_dev_reset;
> +    dc->reset =3D pxb_cxl_dev_reset;
>  }
> =20
>  static const TypeInfo pxb_cxl_dev_info =3D {
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index b161be59b7..b2cffbb364 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -49,6 +49,7 @@ struct CXLHost {
>      PCIHostState parent_obj;
> =20
>      CXLComponentState cxl_cstate;
> +    bool passthrough;
>  };
> =20
>  #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_componen=
t.h
> index 8752171f70..b4104b78b5 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -249,6 +249,7 @@ static inline hwaddr cxl_decode_ig(int ig)
>  }
> =20
>  CXLComponentState *cxl_get_hb_cstate(PCIHostState *hb);
> +bool cxl_get_hb_passthrough(PCIHostState *hb);
> =20
>  void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp);
>  void cxl_doe_cdat_release(CXLComponentState *cxl_cstate);
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 63a7521567..81a058bb2c 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -92,6 +92,7 @@ struct PXBDev {
>      uint8_t bus_nr;
>      uint16_t numa_node;
>      bool bypass_iommu;
> +    bool hdm_for_passthrough;
>      struct cxl_dev {
>          CXLHost *cxl_host_bridge; /* Pointer to a CXLHost */
>      } cxl;
> --=20
> 2.37.2
>=20
> =
