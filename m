Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1553BC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 10:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhLBKfu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Dec 2021 05:35:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4192 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhLBKft (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Dec 2021 05:35:49 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J4XLY0H3qz67SLW;
        Thu,  2 Dec 2021 18:31:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Thu, 2 Dec 2021 11:32:25 +0100
Received: from localhost (10.52.127.197) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 2 Dec
 2021 10:32:24 +0000
Date:   Thu, 2 Dec 2021 10:32:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        Chris Browy <cbrowy@avery-design.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        <linux-cxl@vger.kernel.org>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3 14/31] acpi/pci: Consolidate host bridge setup
Message-ID: <20211202103221.0000280b@Huawei.com>
In-Reply-To: <20210202005948.241655-15-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
        <20210202005948.241655-15-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.197]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 1 Feb 2021 16:59:31 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> This cleanup will make it easier to add support for CXL to the mix.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Hi Ben / all (particularly PCI experts!)

So... I was looking at the large impact this has on needing to update
ACPI tables for the tests and that got me wondering.
The issue is it reorders things a bit rather than making any functional changes.

Why does the pxb expander ACPI not have ADR set and all other
PNP0A03 / PNP0A08 root bridge acpi chunks do?

I've messed around with the values provided and dug around in Linux
and other than them being exposed in the sysfs for firmware blobs associated with
/sys/class/pci_bus/devices these particular _ADR entries don't actually seem to
be used by Linux.

So it becomes a question of what the specification says...

As ever clear as mud :)

PCI firmware spec doesn't say, but has an example with non _ADR entry.
4.5.3 in the PCI Firmware Specification Revisions 3.3
The ACPI spec has an example with _ADR when describing _SEG.
6.5.6 in ACPI 6.4

_ADR description is the address of the device on it's parent bus.
I'm not sure a root bridge parent bus (which is probably the SB, has
any such concept of an address (which probably explains why I've never
seen it set to anything other than 0).

Checking where the _ADR 0 entries came from, they go back to Michael importing
tables from seabios in 2013.

My current feeling is we don't want to risk breaking some user of these values
so perhaps the simple option is just to add _ADR to the PXB ACPI block as well?

That way I think we will cause less churn in the ACPI tables needed for tests
and end up at least consistent in what QEMU presents.

Note I'd ideally like to separate this as a precursor to the CXL series rather than
burying it in the middle of that!

Jonathan

> ---
>  hw/i386/acpi-build.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f56d699c7f..cf6eb54c22 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1194,6 +1194,20 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
>      aml_append(table, scope);
>  }
>  
> +enum { PCI, PCIE };
> +static void init_pci_acpi(Aml *dev, int uid, int type)
> +{
> +    if (type == PCI) {
> +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
> +    } else {
> +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> +        aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> +        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
> +        aml_append(dev, build_q35_osc_method());
> +    }
> +}
> +
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker,
>             AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -1222,9 +1236,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      if (misc->is_piix4) {
>          sb_scope = aml_scope("_SB");
>          dev = aml_device("PCI0");
> -        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> +        init_pci_acpi(dev, 0, PCI);
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>          aml_append(sb_scope, dev);
>          aml_append(dsdt, sb_scope);
>  
> @@ -1238,11 +1251,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      } else {
>          sb_scope = aml_scope("_SB");
>          dev = aml_device("PCI0");
> -        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> -        aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> +        init_pci_acpi(dev, 0, PCIE);
>          aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> -        aml_append(dev, build_q35_osc_method());
>          aml_append(sb_scope, dev);
>  
>          if (pm->smi_on_cpuhp) {
> @@ -1345,15 +1355,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>  
>              scope = aml_scope("\\_SB");
>              dev = aml_device("PC%.02X", bus_num);
> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> -            if (pci_bus_is_express(bus)) {
> -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> -                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> -                aml_append(dev, build_q35_osc_method());
> -            } else {
> -                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
> -            }
> +            init_pci_acpi(dev, bus_num, pci_bus_is_express(bus) ? PCIE : PCI);
>  
>              if (numa_node != NUMA_NODE_UNASSIGNED) {
>                  aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));

