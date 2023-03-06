Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281CCC64EC4
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Mar 2023 18:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCFSEm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCFSEk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Mar 2023 13:04:40 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F7764854
        for <linux-cxl@vger.kernel.org>; Mon,  6 Mar 2023 10:04:09 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230306175134usoutp0299993b2fd75a25a3b7810a1a89d33537~J5eHUTGZ_2431824318usoutp02E;
        Mon,  6 Mar 2023 17:51:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230306175134usoutp0299993b2fd75a25a3b7810a1a89d33537~J5eHUTGZ_2431824318usoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678125094;
        bh=DiP3VyMp3FLM9F+nkLGfr3ZQ3EIpqPCACWw8PVaWwqo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hc5oGj+k3BGsJg4WwuaCCNiGhNoaRilPnqtA1bKzWwksR+MawmQADbWjcz6CC+zbD
         +AO6aIncs5DUkPqOvwxrQXu7HdDFeXKtpZmRe+cKlVfsoz+ClftFEHtdre4VrRTCbj
         pmkTK+QUQq08M2/LyyYdetUW7K5dtM+o1/noq5a8=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230306175133uscas1p24f80d53a61a2b39bfaef915fc9d88d8e~J5eG6wm1a3080030800uscas1p2P;
        Mon,  6 Mar 2023 17:51:33 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 4E.34.12196.52826046; Mon, 
        6 Mar 2023 12:51:33 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230306175133uscas1p163baf7c881e373c5a5db0805fa83fdd1~J5eGi2vyV2059520595uscas1p1e;
        Mon,  6 Mar 2023 17:51:33 +0000 (GMT)
X-AuditID: cbfec370-83dfe70000012fa4-5a-64062825c52b
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 40.A7.11346.52826046; Mon, 
        6 Mar 2023 12:51:33 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 6 Mar 2023 09:51:32 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        6 Mar 2023 09:51:32 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 4/8] hw/pci-bridge/cxl_root_port: Wire up MSI
Thread-Topic: [RESEND PATCH v6 4/8] hw/pci-bridge/cxl_root_port: Wire up MSI
Thread-Index: AQHZTQxw0vEaWIMUIkuF/VYoXnZD4q7ulJUA
Date:   Mon, 6 Mar 2023 17:51:32 +0000
Message-ID: <20230306175132.GD1489326@bgt-140510-bm03>
In-Reply-To: <20230302133709.30373-5-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E5973700F21BC3428932588D959CA985@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djXc7qqGmwpBtsu6FncfXyBzWL+2vss
        Fm/erGGyOHGzkc1i4tv1rBb7nz5nsVi18BqbxflZp1gsDm88w2SxoK2d1WLN/UOsFr/XPmay
        +P/rFZC7QtjieO8OFouVx2wcBDxaL/1l89g56y67R8uRt6wei/e8ZPK4c20Pm8eTa5uZPN7v
        u8rm8XmTXABHFJdNSmpOZllqkb5dAldGz+sDjAUzFSpm7N7F1MD4UKKLkZNDQsBE4vOBP2xd
        jFwcQgIrGSUePvrNCuG0MklM+HyPDabq3euZTBCJtYwSTQ27oKo+MkpM2NQL1b+UUWLGpB/s
        IC1sAooS+7q2g7WLCBhJvLsxiRGkiFlgD6vExxnzwYqEBbwl7i16wQpR5CNx5toRdpiGf5vf
        gTWzCKhIHLz4HczmFTCT6LtyE8zmFHCUuL19NxOIzSggJvH91Bowm1lAXOLWk/lMEHcLSiya
        vYcZwhaT+LfrIdQ/ihL3v79kh6jXk7gxdQobhG0ncehKPyuErS2xbOFrZoi9ghInZz5hgeiV
        lDi44gYLyDMSAqs5JWb9u8IKkXCRuDipD6pIWmL6mstANgeQnSyx6iMXRDhHYv6SLVAl1hIL
        /6xnmsCoMgvJ2bOQnDQLyUmzkJw0C8lJCxhZVzGKlxYX56anFhvnpZbrFSfmFpfmpesl5+du
        YgSmxdP/DhfsYLx166PeIUYmDsZDjBIczEoivFW/WVOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        8xrankwWEkhPLEnNTk0tSC2CyTJxcEo1MGlHX1n1e4rh3UiDQB1v+z4r82V6J+5NO1rHNC3P
        WXbL9Yk7nhQ0zfPhz7honP2z6GaXU8WEWbG7+z/YW3H9PPMv3Jf5J0uH8qEDVzUU9f4Yltcf
        f3mnrMzj8V/evXKcK1XfLM88KxBxtl94TumLUzZdViELLt57kPHj5qs5DlPP6OfWCQmt2eBe
        uc2/YK2qW8Kr2b3qt+42eq4KqppfdOmR8kKjypUL91aEdy39IBm2MOhSWU5ncyhfb1E584Yd
        70rWXhXpkmV8oP5QJC/wQafzurW/N//J5t2zikH0QYzgIquZH1Viv3r8aH2ju+dUz9SGwO73
        K18Yf1W+eFNNgD2/p+sSa+xe9g2rrD4o/lNiKc5INNRiLipOBABms+S++gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LJbGCapKuqwZZi8PuHkMXdxxfYLOavvc9i
        8ebNGiaLEzcb2Swmvl3ParH/6XMWi1ULr7FZnJ91isXi8MYzTBYL2tpZLdbcP8Rq8XvtYyaL
        /79eAbkrhC2O9+5gsVh5zMZBwKP10l82j52z7rJ7tBx5y+qxeM9LJo871/aweTy5tpnJ4/2+
        q2wenzfJBXBEcdmkpOZklqUW6dslcGX0vD7AWDBToWLG7l1MDYwPJboYOTkkBEwk3r2eydTF
        yMUhJLCaUeLgko2MEM5HRomNLSugMksZJZbMesUO0sImoCixr2s7G4gtImAk8e7GJLAOZoFd
        rBKPlz4HKxIW8Ja4t+gFK0SRj8SZa0fYYRr+bX4H1swioCJx8OJ3MJtXwEyi78pNMFtIoFzi
        zv2bjCA2p4CjxO3tu5lAbEYBMYnvp9aA2cwC4hK3nsxngvhBQGLJnvPMELaoxMvH/1ghbEWJ
        +99fskPU60ncmDqFDcK2kzh0pZ8VwtaWWLbwNTPEDYISJ2c+YYHolZQ4uOIGywRGiVlI1s1C
        MmoWklGzkIyahWTUAkbWVYzipcXFuekVxcZ5qeV6xYm5xaV56XrJ+bmbGIEp5fS/wzE7GO/d
        +qh3iJGJg/EQowQHs5IIb9Vv1hQh3pTEyqrUovz4otKc1OJDjNIcLErivB6xE+OFBNITS1Kz
        U1MLUotgskwcnFINTLsUuVZacGz615psuM0ty6t21YXD9y2P/Lwd8Lv4ZT/7h58xPG9tFv87
        9oZv9oYj+VzP5/jmlojtZPnveIRni3trxZo9W/bKe52Sqm5UWcPn7zT/zp1TbFPfp1iePrtA
        QHXDzA/7k1x2b2rPCkn3rRV7LvD4L4ePyrE4bqZpdRsLFxzTOvPgZb3Uku/OfEJ/nx2LM57w
        YdsEC1venLLDgv/vJNS6iLtPOSoVwyf8dmtos+nGxTr5x4SuPF7fc2+C99OFeb1P76etWDdJ
        bX+1i4yVupDnpM0zjEwMkiKfTRR+rniCaX1P14t6QYWC+WoL+QNMMg65pFud/H019T5/nt2t
        P0u7fuZHV5ds5s2zmq3EUpyRaKjFXFScCADGuK++mAMAAA==
X-CMS-MailID: 20230306175133uscas1p163baf7c881e373c5a5db0805fa83fdd1
CMS-TYPE: 301P
X-CMS-RootMailID: 20230306175133uscas1p163baf7c881e373c5a5db0805fa83fdd1
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
        <20230302133709.30373-5-Jonathan.Cameron@huawei.com>
        <CGME20230306175133uscas1p163baf7c881e373c5a5db0805fa83fdd1@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 02, 2023 at 01:37:05PM +0000, Jonathan Cameron wrote:
> Done to avoid fixing ACPI route description of traditional PCI interrupts=
 on q35
> and because we should probably move with the times anyway.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/pci-bridge/cxl_root_port.c | 61 +++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.=
c
> index 00195257f7..7dfd20aa67 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -22,6 +22,7 @@
>  #include "qemu/range.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pcie_port.h"
> +#include "hw/pci/msi.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/sysbus.h"
>  #include "qapi/error.h"
> @@ -29,6 +30,10 @@
> =20
>  #define CXL_ROOT_PORT_DID 0x7075
> =20
> +#define CXL_RP_MSI_OFFSET               0x60
> +#define CXL_RP_MSI_SUPPORTED_FLAGS      PCI_MSI_FLAGS_MASKBIT
> +#define CXL_RP_MSI_NR_VECTOR            2
> +
>  /* Copied from the gen root port which we derive */
>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET 0x100
>  #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
> @@ -47,6 +52,49 @@ typedef struct CXLRootPort {
>  #define TYPE_CXL_ROOT_PORT "cxl-rp"
>  DECLARE_INSTANCE_CHECKER(CXLRootPort, CXL_ROOT_PORT, TYPE_CXL_ROOT_PORT)
> =20
> +/*
> + * If two MSI vector are allocated, Advanced Error Interrupt Message Num=
ber
> + * is 1. otherwise 0.
> + * 17.12.5.10 RPERRSTS,  32:27 bit Advanced Error Interrupt Message Numb=
er.
> + */
> +static uint8_t cxl_rp_aer_vector(const PCIDevice *d)
> +{
> +    switch (msi_nr_vectors_allocated(d)) {
> +    case 1:
> +        return 0;
> +    case 2:
> +        return 1;
> +    case 4:
> +    case 8:
> +    case 16:
> +    case 32:
> +    default:
> +        break;
> +    }
> +    abort();
> +    return 0;
> +}
> +
> +static int cxl_rp_interrupts_init(PCIDevice *d, Error **errp)
> +{
> +    int rc;
> +
> +    rc =3D msi_init(d, CXL_RP_MSI_OFFSET, CXL_RP_MSI_NR_VECTOR,
> +                  CXL_RP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
> +                  CXL_RP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
> +                  errp);
> +    if (rc < 0) {
> +        assert(rc =3D=3D -ENOTSUP);
> +    }
> +
> +    return rc;
> +}
> +
> +static void cxl_rp_interrupts_uninit(PCIDevice *d)
> +{
> +    msi_uninit(d);
> +}
> +
>  static void latch_registers(CXLRootPort *crp)
>  {
>      uint32_t *reg_state =3D crp->cxl_cstate.crb.cache_mem_registers;
> @@ -183,6 +231,15 @@ static void cxl_rp_dvsec_write_config(PCIDevice *dev=
, uint32_t addr,
>      }
>  }
> =20
> +static void cxl_rp_aer_vector_update(PCIDevice *d)
> +{
> +    PCIERootPortClass *rpc =3D PCIE_ROOT_PORT_GET_CLASS(d);
> +
> +    if (rpc->aer_vector) {
> +        pcie_aer_root_set_vector(d, rpc->aer_vector(d));
> +    }
> +}
> +
>  static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t=
 val,
>                                  int len)
>  {
> @@ -192,6 +249,7 @@ static void cxl_rp_write_config(PCIDevice *d, uint32_=
t address, uint32_t val,
> =20
>      pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
>      pci_bridge_write_config(d, address, val, len);
> +    cxl_rp_aer_vector_update(d);
>      pcie_cap_flr_write_config(d, address, val, len);
>      pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
>      pcie_aer_write_config(d, address, val, len);
> @@ -220,6 +278,9 @@ static void cxl_root_port_class_init(ObjectClass *oc,=
 void *data)
> =20
>      rpc->aer_offset =3D GEN_PCIE_ROOT_PORT_AER_OFFSET;
>      rpc->acs_offset =3D GEN_PCIE_ROOT_PORT_ACS_OFFSET;
> +    rpc->aer_vector =3D cxl_rp_aer_vector;
> +    rpc->interrupts_init =3D cxl_rp_interrupts_init;
> +    rpc->interrupts_uninit =3D cxl_rp_interrupts_uninit;
> =20
>      dc->hotpluggable =3D false;
>  }
> --=20
> 2.37.2
>=20
> =
