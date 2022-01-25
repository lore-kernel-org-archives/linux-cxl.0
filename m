Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABE2C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jan 2022 18:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiAYSNd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jan 2022 13:13:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4515 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244801AbiAYSNc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jan 2022 13:13:32 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjvyP5Jypz689Q8;
        Wed, 26 Jan 2022 02:09:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 19:13:15 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 25 Jan
 2022 18:13:14 +0000
Date:   Tue, 25 Jan 2022 18:13:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 31/42] hw/pci-host/gpex-acpi: Add support for dsdt
 construction for pxb-cxl
Message-ID: <20220125181313.0000209c@huawei.com>
In-Reply-To: <87o83zd99r.fsf@linaro.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
        <20220124171705.10432-32-Jonathan.Cameron@huawei.com>
        <87o83zd99r.fsf@linaro.org>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Jan 2022 17:15:58 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > This adds code to instantiate the slightly extended ACPI root port
> > description in DSDT as per the CXL 2.0 specification.
> >
> > Basically a cut and paste job from the i386/pc code.  
> 
> This fails to build on all machines:
> 
>   FAILED: qemu-system-mips64el 
>   c++ -m64 -mcx16  -o qemu-system-mips64el qemu-system-mips64el.p/softmmu_main.c.o <snip> subprojects/libvhost-user/libvhost-user.a libmigration.fa libhwcore.fa libqom.fa libio.fa libcrypto.fa libauthz.fa libblockdev.fa libblock.fa libchardev.fa libqmp.fa @block.syms @qemu.syms /usr/lib/x86_64-linux-gnu/libpixman-1.so -lepoxy /usr/lib/x86_64-linux-gnu/libcapstone.so /usr/lib/x86_64-linux-gnu/libspice-server.so -Xlinker --dynamic-list=/home/alex/lsrc/qemu.git/plugins/qemu-plugins.symbols /usr/lib/x86_64-linux-gnu/libz.so /usr/lib/x86_64-linux-gnu/libpng16.so /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib/x86_64-linux-gnu/libgnutls.so -lsasl2 /usr/lib/x86_64-linux-gnu/libpmem.so /usr/lib/x86_64-linux-gnu/libseccomp.so -lnuma -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lrdmacm -libverbs -libumad /usr/lib/gcc/x86_64-linux-gnu/10/../../../x86_64-linux-gnu/libzstd.so /usr/lib/x86_64-linux-gnu/libslirp.so /usr/lib/x86_64-linux-gnu/libglib-2.0.so -lvdeplug /usr/lib/x86_64-linux-gnu/libudev.so /usr/lib/x86_64-linux-gnu/libbpf.so /usr/lib/x86_64-linux-gnu/libasound.so /usr/lib/x86_64-linux-gnu/libpulse.so -lbrlapi /usr/lib/x86_64-linux-gnu/libvirglrenderer.so /usr/lib/x86_64-linux-gnu/libusb-1.0.so /usr/lib/x86_64-linux-gnu/libusbredirparser.so /usr/lib/x86_64-linux-gnu/libcacard.so -lncursesw -ltinfo -pthread -lgmodule-2.0 -lglib-2.0 /usr/lib/x86_64-linux-gnu/libgbm.so /usr/lib/x86_64-linux-gnu/libgtk-3.so /usr/lib/x86_64-linux-gnu/libgdk-3.so /usr/lib/x86_64-linux-gnu/libpangocairo-1.0.so /usr/lib/x86_64-linux-gnu/libpango-1.0.so /usr/lib/x86_64-linux-gnu/libharfbuzz.so /usr/lib/x86_64-linux-gnu/libatk-1.0.so /usr/lib/x86_64-linux-gnu/libcairo-gobject.so /usr/lib/x86_64-linux-gnu/libcairo.so /usr/lib/x86_64-linux-gnu/libgdk_pixbuf-2.0.so /usr/lib/x86_64-linux-gnu/libgio-2.0.so /usr/lib/x86_64-linux-gnu/libgobject-2.0.so /usr/lib/x86_64-linux-gnu/libvte-2.91.so /usr/lib/x86_64-linux-gnu/libX11.so @block.syms -lutil -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgio-2.0 -lgobject-2.0 -lglib-2.0 -lgmodule-2.0 -lglib-2.0 -lm -lgmodule-2.0 -lglib-2.0 /usr/lib/x86_64-linux-gnu/libiscsi.so -laio /usr/lib/x86_64-linux-gnu/libcurl.so -lgmodule-2.0 -lglib-2.0 -lbz2 /usr/lib/x86_64-linux-gnu/libacl.so /usr/lib/x86_64-linux-gnu/libgfapi.so /usr/lib/x86_64-linux-gnu/libglusterfs.so /usr/lib/x86_64-linux-gnu/libgfrpc.so /usr/lib/x86_64-linux-gnu/libgfxdr.so /usr/lib/x86_64-linux-gnu/libuuid.so /usr/lib/x86_64-linux-gnu/libnfs.so -lrbd -lrados /usr/lib/x86_64-linux-gnu/libssh.so -lstdc++ -Wl,--end-group
>   /usr/bin/ld: /lib/x86_64-linux-gnu/libtirpc.so.3: warning: common of `rpc_createerr@@GLIBC_2.2.5' overridden by definition from /lib/x86_64-linux-gnu/libc.so.6
>   /usr/bin/ld: libcommon.fa.p/hw_pci-host_gpex-acpi.c.o: in function `acpi_dsdt_add_gpex':
>   /home/alex/lsrc/qemu.git/builds/all/../../hw/pci-host/gpex-acpi.c:191: undefined reference to `build_cxl_osc_method'
>   collect2: error: ld returned 1 exit status
>   [1600/2203] Linking target qemu-system-or1k
> 
> 
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  hw/arm/Kconfig          |  1 +
> >  hw/pci-host/gpex-acpi.c | 22 +++++++++++++++++++---
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> > index 2e0049196d..3df419fa6d 100644
> > --- a/hw/arm/Kconfig
> > +++ b/hw/arm/Kconfig
> > @@ -29,6 +29,7 @@ config ARM_VIRT
> >      select ACPI_APEI
> >      select ACPI_VIOT
> >      select VIRTIO_MEM_SUPPORTED
> > +    select ACPI_CXL
> >  
> >  config CHEETAH
> >      bool
> > diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> > index e7e162a00a..fb60aa517f 100644
> > --- a/hw/pci-host/gpex-acpi.c
> > +++ b/hw/pci-host/gpex-acpi.c
> > @@ -5,6 +5,7 @@
> >  #include "hw/pci/pci_bus.h"
> >  #include "hw/pci/pci_bridge.h"
> >  #include "hw/pci/pcie_host.h"
> > +#include "hw/acpi/cxl.h"
> >  
> >  static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
> >  {
> > @@ -139,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >          QLIST_FOREACH(bus, &bus->child, sibling) {
> >              uint8_t bus_num = pci_bus_num(bus);
> >              uint8_t numa_node = pci_bus_numa_node(bus);
> > +            bool is_cxl;
> >  
> >              if (!pci_bus_is_root(bus)) {
> >                  continue;
> > @@ -153,9 +155,19 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >                  nr_pcie_buses = bus_num;
> >              }
> >  
> > +            is_cxl = pci_bus_is_cxl(bus);
> > +
> >              dev = aml_device("PC%.02X", bus_num);
> > -            aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
> > -            aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> > +            if (is_cxl) {
> > +                struct Aml *pkg = aml_package(2);
> > +                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
> > +                aml_append(pkg, aml_eisaid("PNP0A08"));
> > +                aml_append(pkg, aml_eisaid("PNP0A03"));
> > +                aml_append(dev, aml_name_decl("_CID", pkg));
> > +            } else {
> > +                aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
> > +                aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
> > +            }
> >              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> >              aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
> >              aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Device")));
> > @@ -175,7 +187,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >                              cfg->pio.base, 0, 0, 0);
> >              aml_append(dev, aml_name_decl("_CRS", crs));
> >  
> > -            acpi_dsdt_add_pci_osc(dev);
> > +            if (is_cxl) {
> > +                build_cxl_osc_method(dev);  
> 
> Either we need an #ifdef gate on CONFIG_ACPI_CXL

 error: attempt to use poisoned "CONFIG_ACPI_CXL"

> or possibly a stub
> implementation (with a g_assert_not_reached()).
That works.

Turns out I was too lazy thinking riscv was enough to exercise the
not CXL support case.

Lesson learned - mips64el now in my standard config :)
I'd not realized there were ACPI supporting MIPS machines...

Thanks,

Jonathan



> 
> > +            } else {
> > +                acpi_dsdt_add_pci_osc(dev);
> > +            }
> >  
> >              aml_append(scope, dev);
> >          }  
> 
> 

