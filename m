Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A2FC433EF
	for <linux-cxl@archiver.kernel.org>; Sun, 27 Mar 2022 13:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiC0NeD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 27 Mar 2022 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiC0NeC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 27 Mar 2022 09:34:02 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B436E2F
        for <linux-cxl@vger.kernel.org>; Sun, 27 Mar 2022 06:32:23 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220327133218usoutp02d68916089d58dec6d6eec88fec750e79~gQBjCH1Gg1581015810usoutp02P;
        Sun, 27 Mar 2022 13:32:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220327133218usoutp02d68916089d58dec6d6eec88fec750e79~gQBjCH1Gg1581015810usoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648387938;
        bh=S9YSfekSP5H6n7sqZvhut+vUA+iP1zA5yEOUXBoQ04I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=f4vM8Hd9jbC/hTtR8qqSKkY+pZNZSmTZKKvUE+fzK9wE4aVa7FtlyeaOpFYTBPeAE
         awSLhc37lRpPlZLN16/Y+d9sY9mvR3iXnKn8ahBm0YbslLurJCrC97wXJKLK3TOMeR
         EVoeesOHber2Fj5AOZN3s6uQjeE5DSpnS5SC7pDQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220327133217uscas1p1cf392d27468ce235cee6371c1ae46029~gQBh9wX6Z1684516845uscas1p12;
        Sun, 27 Mar 2022 13:32:17 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id BB.A8.09749.16760426; Sun,
        27 Mar 2022 09:32:17 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220327133216uscas1p13b9248b075f1736542e40654b498b5ff~gQBhY6MoR0321903219uscas1p1r;
        Sun, 27 Mar 2022 13:32:16 +0000 (GMT)
X-AuditID: cbfec370-a83ff70000002615-33-62406761ed87
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 2A.2D.09702.06760426; Sun,
        27 Mar 2022 09:32:16 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Sun, 27 Mar 2022 06:32:16 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Sun, 27 Mar 2022 06:32:16 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v8 01/46] hw/pci/cxl: Add a CXL component type
 (interface)
Thread-Topic: [PATCH v8 01/46] hw/pci/cxl: Add a CXL component type
        (interface)
Thread-Index: AQHYQd8S5mV/ldYlyE2yoR0LQYXPpw==
Date:   Sun, 27 Mar 2022 13:32:16 +0000
Message-ID: <20220327133207.GA42823@bgt-140510-bm01>
In-Reply-To: <20220318150635.24600-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <3A002E9248DE1649A27CFB0C0730FFEB@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTVxjHc95r6cC9dKw94gDXaEZYKMiWeDYHg2Vxr8YPLMQsY4laxhsg
        lsJaYIztA1YdFu1lKAL1grCsYYgZVFI7wr1WQEBwsbUgFdjqIkMY6BgXpRvlxYRvv+c8/+c8
        v5McAS4yUaGCLGUep1LKFVJKSFhvLQxFyzMS02IvlUnQqYligKqvjROo9E8Djk4PNQJUUT4M
        0MIvKzjqtXThqN9xCkf1NS4KDZluE8jeNIAhrcNAouI+Jfpv5S8SdVh9JLo4MEGg5o5/adSj
        sxFo+O5VAukeviDQDaeGRE3WcipRzHY+rqHZ4bNGkm3QTmPshbl/MPbEzRmSfeQ5TrMVl17g
        7I+tUxg75mqlWK/rOsb+3e6k2GeW8OTAVOEH6Zwiq4BTxSQcEWbqqpax3OmwwtJGA1kMrJJS
        ECCAzLvQ22cDfhYxPwNoWd1SCoRrfBKDvTebqZeh3z2rFN+4BqBD7yD4Yh7AEd0xjC86AVy9
        MUT6RygmFj7vacL9HMLEwVl3GfCHcKaThle7BtbvfY1JhpfLflhrCNZCn8JnT1L4vAyWVGlp
        PxPMTtj2x9K6X9CaRpvnPOaPBzBJsE4n9R8DRgwXbzdgfsYZCRz1VmO8dTCsvdCK8yyGvpbJ
        jde8CccXp2g+L4Pu8nMUzwnQ81sdwfPb0FwzjfNrg2FflZfgZ7fCrjr3+uMhsxIAl+1TG5d+
        DM2XvRvLtkHn/XKcD5UAOGdsJ/nCCODYzPLGxB7o07poI9hh2mRu2mRl2mRl2mRl2mR1BZD1
        QJKvVmdncOp3lNzXMrU8W52vzJB9mZNtAWvft99nz7WB0dF5WTfABKAbQAEuDQkKG/wwTRSU
        Lv+miFPlHFblKzh1N9gmIKSSIHNWo1zEZMjzuKMcl8upXnYxQUBoMXYsSR93cOv7XAyWpp48
        Qx7aGzLWeK/1k96z6HAOPX/8O2v8gDFs39Nm827948I3UGB4+7itzToRKY7abwsp2B6Rn3Jn
        cPG5OVmRNzt6QBRBuz+nNE77hNO8dyY19elbSQmFteBJ0ffRD6Z1rpHrlsqRysS7+oWLMrmm
        pePokHQ5RUHHnNzfdeLVc8xk9SF8kNttrmj/qGbMlH1EnKn4NjpGWbvls2B9en2CPVysnZca
        8h51/0qnFsWhnkjPcEXCnHbfFw/0UQX93bfutOVG3t/ZspS0YHE0xAnPjNyr1J8WfQUj3O9d
        iXyoiTfM5ryyfdee+CXNT4HnS3yhr+PW2CYpoc6U74rCVWr5/8Ds8fAtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWS2cA0UTch3SHJ4MF3A4uOBw2MFvPX3mex
        6HrWz2zRfX4Do8X0qRcYLb6u/8VscWLTQWaL00c7mC1WLbzGZnF+1ikWi8MbzzBZdB7tZ7Vo
        OJln8f/XK1aL/dv+sVrMOfOAxWLL/m/sFsd7d7BYXLi4msWi994fFovtV5tYLTZum8rmIOZx
        4MVCdo8LkyeweqzpfM3kMfvDFyaPliNvWT2e3m1m95g+9w+zx+I9L5k87lzbw+bx5NpmJo/3
        +66yeXzeJBfAE8Vlk5Kak1mWWqRvl8CV0TvzJ1PBa9mKrg39rA2M28S7GDk5JARMJB7d/cvW
        xcjFISSwmlHiY+ctNpCEkMBHRok7HwQh7AOMEl97/EBsNgEDid/HNzKD2CICRhLvbkxiBGlm
        FjjALrH64BmwZmEBP4kFf86yQxQFSqxq3wZl60m0z+wEs1kEVCX2Pv7BCGLzAl2x9+40Johl
        5RIbb6xn7WLk4OAUcJRY0asEEmYUEJP4fmoNWAmzgLjErSfzmSAeEJBYsuc8M4QtKvHy8T9W
        CFtR4v73l+wQ9XoSN6ZOYYOw7STuXlrBAmFrSyxb+JoZ4gRBiZMzn7BA9EpKHFxxg2UCo8Qs
        JOtmIRk1C8moWUhGzUIyagEj6ypG8dLi4tz0imLDvNRyveLE3OLSvHS95PzcTYzAlHX63+HI
        HYxHb33UO8TIxMF4iFGCg1lJhFf2rH2SEG9KYmVValF+fFFpTmrxIUZpDhYlcV4h14nxQgLp
        iSWp2ampBalFMFkmDk6pBqauP4u7l6gbPU14w6ZiUPHIhYdN69j+7rdrvh95Pivf93Zlwhrp
        E0FSsy7P27/jqv+fxzufT/vz+KJKef3fXsseYx+7aeUe0+3mTxbR+v+iNXrD1kXSVZw+xg6B
        l1dM2HrLe+8eXu8JCRyu5uH/eWYZ/dTstzz7Q3+ZpO+Sq4d+zHyvfO7Ujhj7UkXHAom+h7kb
        XZeE3iwQuCl72Z9xnueCx3rOs/ZP3T7HeU5K+96LtxxDJyziPW7RL+k87dwlZa7cjkYfU50g
        +cA7e/e+72sI+65tx6p7u6E18YVS7dzXP8yVdp3St9e//f2H5cy0GW7KH+9c3Xbv1Gxf7/Mz
        v25vPPoo8RPPpg060lIOwq0PlFiKMxINtZiLihMBSEvC7sgDAAA=
X-CMS-MailID: 20220327133216uscas1p13b9248b075f1736542e40654b498b5ff
CMS-TYPE: 301P
X-CMS-RootMailID: 20220327133216uscas1p13b9248b075f1736542e40654b498b5ff
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
        <20220318150635.24600-2-Jonathan.Cameron@huawei.com>
        <CGME20220327133216uscas1p13b9248b075f1736542e40654b498b5ff@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Mar 18, 2022 at 03:05:50PM +0000, Jonathan Cameron wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
>=20
> A CXL component is a hardware entity that implements CXL component
> registers from the CXL 2.0 spec (8.2.3). Currently these represent 3
> general types.
> 1. Host Bridge
> 2. Ports (root, upstream, downstream)
> 3. Devices (memory, other)
>=20
> A CXL component can be conceptually thought of as a PCIe device with
> extra functionality when enumerated and enabled. For this reason, CXL
> does here, and will continue to add on to existing PCI code paths.
>=20
> Host bridges will typically need to be handled specially and so they can
> implement this newly introduced interface or not. All other components
> should implement this interface. Implementing this interface allows the
> core PCI code to treat these devices as special where appropriate.
>=20
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  hw/pci/pci.c         | 10 ++++++++++
>  include/hw/pci/pci.h |  8 ++++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 5cb1232e27..7883778a99 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -201,6 +201,11 @@ static const TypeInfo pci_bus_info =3D {
>      .class_init =3D pci_bus_class_init,
>  };
> =20
> +static const TypeInfo cxl_interface_info =3D {
> +    .name          =3D INTERFACE_CXL_DEVICE,
> +    .parent        =3D TYPE_INTERFACE,
> +};
> +
>  static const TypeInfo pcie_interface_info =3D {
>      .name          =3D INTERFACE_PCIE_DEVICE,
>      .parent        =3D TYPE_INTERFACE,
> @@ -2182,6 +2187,10 @@ static void pci_qdev_realize(DeviceState *qdev, Er=
ror **errp)
>          pci_dev->cap_present |=3D QEMU_PCI_CAP_EXPRESS;
>      }
> =20
> +    if (object_class_dynamic_cast(klass, INTERFACE_CXL_DEVICE)) {
> +        pci_dev->cap_present |=3D QEMU_PCIE_CAP_CXL;
> +    }
> +
>      pci_dev =3D do_pci_register_device(pci_dev,
>                                       object_get_typename(OBJECT(qdev)),
>                                       pci_dev->devfn, errp);
> @@ -2938,6 +2947,7 @@ static void pci_register_types(void)
>      type_register_static(&pci_bus_info);
>      type_register_static(&pcie_bus_info);
>      type_register_static(&conventional_pci_interface_info);
> +    type_register_static(&cxl_interface_info);
>      type_register_static(&pcie_interface_info);
>      type_register_static(&pci_device_type_info);
>  }
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 3a32b8dd40..98f0d1b844 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -194,6 +194,8 @@ enum {
>      QEMU_PCIE_LNKSTA_DLLLA =3D (1 << QEMU_PCIE_LNKSTA_DLLLA_BITNR),
>  #define QEMU_PCIE_EXTCAP_INIT_BITNR 9
>      QEMU_PCIE_EXTCAP_INIT =3D (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
> +#define QEMU_PCIE_CXL_BITNR 10
> +    QEMU_PCIE_CAP_CXL =3D (1 << QEMU_PCIE_CXL_BITNR),
>  };
> =20
>  #define TYPE_PCI_DEVICE "pci-device"
> @@ -201,6 +203,12 @@ typedef struct PCIDeviceClass PCIDeviceClass;
>  DECLARE_OBJ_CHECKERS(PCIDevice, PCIDeviceClass,
>                       PCI_DEVICE, TYPE_PCI_DEVICE)
> =20
> +/*
> + * Implemented by devices that can be plugged on CXL buses. In the spec,=
 this is
> + * actually a "CXL Component, but we name it device to match the PCI nam=
ing.
> + */
> +#define INTERFACE_CXL_DEVICE "cxl-device"
> +
>  /* Implemented by devices that can be plugged on PCI Express buses */
>  #define INTERFACE_PCIE_DEVICE "pci-express-device"
> =20
> --=20
> 2.32.0
>=20
>=20

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
