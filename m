Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89DFC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 17:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587608AbiAYRUL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587549AbiAYRSP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jan 2022 12:18:15 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32245C061755
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 09:18:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m11so64517165edi.13
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jan 2022 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Y9VMEWa9H0pf+42UoNVqVS4zeqbjbQp1/KTw6BBvYjQ=;
        b=k+hacKB1JNkWUt06j0MFO3fHma249npXlaXYW33blM5BtiOVGD+KpZHaEJ8XCRbiE5
         MxlKqLIIUXtINNaXHJwSq2eHkkM88DNAXGQ5gxagiU+Bs9bJm0XCiymLLvf4/r4OPlpz
         0QQlsKnmZfABA6vheAZiStClJs5eOJWHESTU/iHYoHLCKHwgaHRQUSu6021FaKUqSy8j
         egQJ62fs8ow76EkUVG0Wv2G5ubd738mIUAyTKFQ4VAfbLKAGrny5LjHfqJOQBHYo4nFu
         6iGWSe41rREa4HWdFF3x+3hgd77+VteAb3pGnCxbJDnwYkbc8+WVwmz4ZqJYfxkhvMFT
         15Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Y9VMEWa9H0pf+42UoNVqVS4zeqbjbQp1/KTw6BBvYjQ=;
        b=mvOzRDJPI8lTwov6nulFGZZ0pk39+lOSlPDf++dB+rz3B1X+y/zvZfrrjcjNb1sT0F
         k+M0/CRzc8uv8OxrTAcM8q3rJfJ3SaJA/EUxG+23J/TCjvk6wsZXLwajxQZCB0wxXyET
         aXB1CBWhcCo2zmQ8ruYwmsFkO7bxRsE7KRUCoY9fYT1f7jfa2sEQk4Cy/UE4m4qnku2C
         3KYbUhRv3zBJtQMmDjIsO+BZgC1p9BgsEAl1ZmWQWExfUNzdGI2dXyMzC5ywtOtFAmV0
         uIaaR0gmhDH/62fH8ZO9tww+OK5isAX64mgg14DvzKgHRCRcbHFam8X67UWxHSFFIUNh
         Ruug==
X-Gm-Message-State: AOAM531RoQsaiL8zznICagmFJUwncn7D+GzPxX55LuQtromQMNgTqcCo
        qZ/46LWkT72RyZhrJfqydj/bfA==
X-Google-Smtp-Source: ABdhPJygticXyEYjy7Zz41weq3cMbKrMWFppmNbnooHAMX4Omv8RIoM/nBCf8c+MdNq8EwA7CXNTMw==
X-Received: by 2002:a05:6402:450:: with SMTP id p16mr20973872edw.113.1643131090650;
        Tue, 25 Jan 2022 09:18:10 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id o11sm8533693edh.75.2022.01.25.09.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:18:09 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id D95091FFB7;
        Tue, 25 Jan 2022 17:18:08 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-32-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.6; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 31/42] hw/pci-host/gpex-acpi: Add support for dsdt
 construction for pxb-cxl
Date:   Tue, 25 Jan 2022 17:15:58 +0000
In-reply-to: <20220124171705.10432-32-Jonathan.Cameron@huawei.com>
Message-ID: <87o83zd99r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> This adds code to instantiate the slightly extended ACPI root port
> description in DSDT as per the CXL 2.0 specification.
>
> Basically a cut and paste job from the i386/pc code.

This fails to build on all machines:

  FAILED: qemu-system-mips64el=20
  c++ -m64 -mcx16  -o qemu-system-mips64el qemu-system-mips64el.p/softmmu_m=
ain.c.o <snip> subprojects/libvhost-user/libvhost-user.a libmigration.fa li=
bhwcore.fa libqom.fa libio.fa libcrypto.fa libauthz.fa libblockdev.fa libbl=
ock.fa libchardev.fa libqmp.fa @block.syms @qemu.syms /usr/lib/x86_64-linux=
-gnu/libpixman-1.so -lepoxy /usr/lib/x86_64-linux-gnu/libcapstone.so /usr/l=
ib/x86_64-linux-gnu/libspice-server.so -Xlinker --dynamic-list=3D/home/alex=
/lsrc/qemu.git/plugins/qemu-plugins.symbols /usr/lib/x86_64-linux-gnu/libz.=
so /usr/lib/x86_64-linux-gnu/libpng16.so /usr/lib/x86_64-linux-gnu/libjpeg.=
so /usr/lib/x86_64-linux-gnu/libgnutls.so -lsasl2 /usr/lib/x86_64-linux-gnu=
/libpmem.so /usr/lib/x86_64-linux-gnu/libseccomp.so -lnuma -lgio-2.0 -lgobj=
ect-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lrdmacm -libverbs -l=
ibumad /usr/lib/gcc/x86_64-linux-gnu/10/../../../x86_64-linux-gnu/libzstd.s=
o /usr/lib/x86_64-linux-gnu/libslirp.so /usr/lib/x86_64-linux-gnu/libglib-2=
.0.so -lvdeplug /usr/lib/x86_64-linux-gnu/libudev.so /usr/lib/x86_64-linux-=
gnu/libbpf.so /usr/lib/x86_64-linux-gnu/libasound.so /usr/lib/x86_64-linux-=
gnu/libpulse.so -lbrlapi /usr/lib/x86_64-linux-gnu/libvirglrenderer.so /usr=
/lib/x86_64-linux-gnu/libusb-1.0.so /usr/lib/x86_64-linux-gnu/libusbredirpa=
rser.so /usr/lib/x86_64-linux-gnu/libcacard.so -lncursesw -ltinfo -pthread =
-lgmodule-2.0 -lglib-2.0 /usr/lib/x86_64-linux-gnu/libgbm.so /usr/lib/x86_6=
4-linux-gnu/libgtk-3.so /usr/lib/x86_64-linux-gnu/libgdk-3.so /usr/lib/x86_=
64-linux-gnu/libpangocairo-1.0.so /usr/lib/x86_64-linux-gnu/libpango-1.0.so=
 /usr/lib/x86_64-linux-gnu/libharfbuzz.so /usr/lib/x86_64-linux-gnu/libatk-=
1.0.so /usr/lib/x86_64-linux-gnu/libcairo-gobject.so /usr/lib/x86_64-linux-=
gnu/libcairo.so /usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so /usr/lib/x86=
_64-linux-gnu/libgio-2.0.so /usr/lib/x86_64-linux-gnu/libgobject-2.0.so /us=
r/lib/x86_64-linux-gnu/libvte-2.91.so /usr/lib/x86_64-linux-gnu/libX11.so @=
block.syms -lutil -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.=
0 -lglib-2.0 -lgmodule-2.0 -lglib-2.0 -lm -lgmodule-2.0 -lglib-2.0 /usr/lib=
/x86_64-linux-gnu/libiscsi.so -laio /usr/lib/x86_64-linux-gnu/libcurl.so -l=
gmodule-2.0 -lglib-2.0 -lbz2 /usr/lib/x86_64-linux-gnu/libacl.so /usr/lib/x=
86_64-linux-gnu/libgfapi.so /usr/lib/x86_64-linux-gnu/libglusterfs.so /usr/=
lib/x86_64-linux-gnu/libgfrpc.so /usr/lib/x86_64-linux-gnu/libgfxdr.so /usr=
/lib/x86_64-linux-gnu/libuuid.so /usr/lib/x86_64-linux-gnu/libnfs.so -lrbd =
-lrados /usr/lib/x86_64-linux-gnu/libssh.so -lstdc++ -Wl,--end-group
  /usr/bin/ld: /lib/x86_64-linux-gnu/libtirpc.so.3: warning: common of `rpc=
_createerr@@GLIBC_2.2.5' overridden by definition from /lib/x86_64-linux-gn=
u/libc.so.6
  /usr/bin/ld: libcommon.fa.p/hw_pci-host_gpex-acpi.c.o: in function `acpi_=
dsdt_add_gpex':
  /home/alex/lsrc/qemu.git/builds/all/../../hw/pci-host/gpex-acpi.c:191: un=
defined reference to `build_cxl_osc_method'
  collect2: error: ld returned 1 exit status
  [1600/2203] Linking target qemu-system-or1k


>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  hw/arm/Kconfig          |  1 +
>  hw/pci-host/gpex-acpi.c | 22 +++++++++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 2e0049196d..3df419fa6d 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -29,6 +29,7 @@ config ARM_VIRT
>      select ACPI_APEI
>      select ACPI_VIOT
>      select VIRTIO_MEM_SUPPORTED
> +    select ACPI_CXL
>=20=20
>  config CHEETAH
>      bool
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index e7e162a00a..fb60aa517f 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -5,6 +5,7 @@
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pcie_host.h"
> +#include "hw/acpi/cxl.h"
>=20=20
>  static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
>  {
> @@ -139,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig=
 *cfg)
>          QLIST_FOREACH(bus, &bus->child, sibling) {
>              uint8_t bus_num =3D pci_bus_num(bus);
>              uint8_t numa_node =3D pci_bus_numa_node(bus);
> +            bool is_cxl;
>=20=20
>              if (!pci_bus_is_root(bus)) {
>                  continue;
> @@ -153,9 +155,19 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfi=
g *cfg)
>                  nr_pcie_buses =3D bus_num;
>              }
>=20=20
> +            is_cxl =3D pci_bus_is_cxl(bus);
> +
>              dev =3D aml_device("PC%.02X", bus_num);
> -            aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08"))=
);
> -            aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03"))=
);
> +            if (is_cxl) {
> +                struct Aml *pkg =3D aml_package(2);
> +                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI00=
16")));
> +                aml_append(pkg, aml_eisaid("PNP0A08"));
> +                aml_append(pkg, aml_eisaid("PNP0A03"));
> +                aml_append(dev, aml_name_decl("_CID", pkg));
> +            } else {
> +                aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A0=
8")));
> +                aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A0=
3")));
> +            }
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>              aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>              aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Devic=
e")));
> @@ -175,7 +187,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfi=
g *cfg)
>                              cfg->pio.base, 0, 0, 0);
>              aml_append(dev, aml_name_decl("_CRS", crs));
>=20=20
> -            acpi_dsdt_add_pci_osc(dev);
> +            if (is_cxl) {
> +                build_cxl_osc_method(dev);

Either we need an #ifdef gate on CONFIG_ACPI_CXL or possibly a stub
implementation (with a g_assert_not_reached()).

> +            } else {
> +                acpi_dsdt_add_pci_osc(dev);
> +            }
>=20=20
>              aml_append(scope, dev);
>          }


--=20
Alex Benn=C3=A9e
