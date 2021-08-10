Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C68DC4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Aug 2021 22:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3A860FC4
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Aug 2021 22:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhHJWld (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Aug 2021 18:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhHJWld (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Aug 2021 18:41:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE87C061765
        for <linux-cxl@vger.kernel.org>; Tue, 10 Aug 2021 15:41:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso1494760pjb.1
        for <linux-cxl@vger.kernel.org>; Tue, 10 Aug 2021 15:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0mazYdHuDLpT8iG6dnfOyg5JoXH7YltoN6HI0aX5E0E=;
        b=ibCFb2i/L+jni8m/oFziJoOWv6PJjC3k/tUgo0eARZZAVpSqafei++DGSnZ0uzLU7v
         7pBotXVjwpfk2CKRL3P5dkxOdqZTDkxsrai+UGQzhjdqt01hKI6/wsv4PupT/egt2mES
         F0f2ekrqeFSxjZ8sAMwBDfHkgtAcidYHbS5cIAehf6B4g/TeMA0Cr13Rs0X9J5rEiR7r
         dH0pehDGKkxcprBeSuQcbCZqeTXVO7BSN/hkulxd4LalGk4sUZhexPf901wBykpksQPH
         v5OD6EyKngfN5p9O7HJaXI/1SCjzNUJGGJfgZxpJN+fVOrAN6PjoKXYnphR3OpTlS4bw
         pUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0mazYdHuDLpT8iG6dnfOyg5JoXH7YltoN6HI0aX5E0E=;
        b=jTCxYHyfIW4kUsQ8IMgZ0E8bG67TIBwzLvfbHVWwKqcxYdMxbsN2l0gMd8aZVTPsbn
         QA5YncgxFGwZtEX3h5Cx/5Kqg5wzsKhGNd5bWyDvDRNnhkfqImoMJWNZaejVhAruOmGE
         3DaLlXCXIwEBKuFhL11SHTN3Tc2EkzSpM9s2p0xwYbFmAgUaFiVF5LlG8UGM9GD62g7s
         cvDzD3kjKL6ILlpc4bJyJVtv/l0qFaNWiv/gzqyO7Wqz3kfuMtD1FmyGMhSIkP4Z+RiE
         xG+uLZyT8l5NgZPDCNfT1dOn+LVjCWEsEZuPPAyzLZGyiRlZL4Ohxbw8LiCecoLEirvy
         9ykA==
X-Gm-Message-State: AOAM531hsK8rBiz73oSCAKK3/G7VlpBrB1dHPevhohqHE4F1zWgjXVDu
        5KW69XZYm5Gjq5YjScvaePpbiK7ydL0bhRjNhHlfEg==
X-Google-Smtp-Source: ABdhPJyGEmvjuRqYTMb7cqkLziELN5hn79aE3OkklHvLgYzDw/nolA/ILf1tfuhhJqEmM6411Qwskkj6jUBITgUvzoc=
X-Received: by 2002:a63:3c7:: with SMTP id 190mr45072pgd.240.1628635269432;
 Tue, 10 Aug 2021 15:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162854817382.1980150.11827836438841211401.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210810215734.qb4ik65uangytvbm@intel.com>
In-Reply-To: <20210810215734.qb4ik65uangytvbm@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 10 Aug 2021 15:40:58 -0700
Message-ID: <CAPcyv4hc_=7s4dwrfw89B0cdAQAALZ5Yhiuo6xehB6TJQjekog@mail.gmail.com>
Subject: Re: [PATCH 20/23] tools/testing/cxl: Introduce a mocked-up CXL port hierarchy
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 10, 2021 at 2:57 PM Ben Widawsky <ben.widawsky@intel.com> wrote=
:
>
> On 21-08-09 15:29:33, Dan Williams wrote:
> > Create an environment for CXL plumbing unit tests. Especially when it
> > comes to an algorithm for HDM Decoder (Host-managed Device Memory
> > Decoder) programming, the availability of an in-kernel-tree emulation
> > environment for CXL configuration complexity and corner cases speeds
> > development and deters regressions.
> >
> > The approach taken mirrors what was done for tools/testing/nvdimm/. I.e=
.
> > an external module, cxl_test.ko built out of the tools/testing/cxl/
> > directory, provides mock implementations of kernel APIs and kernel
> > objects to simulate a real world device hierarchy.
> >
> > One feedback for the tools/testing/nvdimm/ proposal was "why not do thi=
s
> > in QEMU?". In fact, the CXL development community has developed a QEMU
> > model for CXL [1]. However, there are a few blocking issues that keep
> > QEMU from being a tight fit for topology + provisioning unit tests:
> >
> > 1/ The QEMU community has yet to show interest in merging any of this
> >    support that has had patches on the list since November 2020. So,
> >    testing CXL to date involves building custom QEMU with out-of-tree
> >    patches.
> >
> > 2/ CXL mechanisms like cross-host-bridge interleave do not have a clear
> >    path to be emulated by QEMU without major infrastructure work. This
> >    is easier to achieve with the alloc_mock_res() approach taken in thi=
s
> >    patch to shortcut-define emulated system physical address ranges wit=
h
> >    interleave behavior.
>
> I just want to say that this was discussed on the mailing list, and I thi=
nk
> there is a reasonable plan (albeit a lot of work). However, #1 is the tru=
e
> blocker IMHO.
>
> >
> > The QEMU enabling has been critical to get the driver off the ground,
> > and may still move forward, but it does not address the ongoing needs o=
f
> > a regression testing environment and test driven development.
> >
>
> The really nice thing QEMU provides over this (assuming one implemented
> interleaving properly), is it does allow a programmatic (via commandline)=
 way to
> test an infinite set of topologies, configurations, and hotplug scenarios=
. I
> therefore disagree here in that I think QEMU is a better theoretical vehi=
cle for
> regression testing and test driven development, however, my unfinished br=
anch
> with no upstream interest in sight is problematic at best for longer term=
.

The "infinite" is what I don't think QEMU will sign up to support.
There are going to be degenerate error handling scenarios that we want
to test that QEMU will have no interest in supporting because QEMU is
primarily targeted at faithfully emulating well behaved hardware. At
the same time cxl_test does not preclude QEMU support which will
remain super useful. You will notice that the ndctl unit tests have
some tests that run against nfit_test and some that run against "real"
topologies where the "real" stuff is usually the QEMU NVDIMM model. So
it's not "either, or" it's "QEMU and cxl_test".

>
> I didn't look super closely, but I have one comment/question below. Other=
wise,
> LGTM.
>
> > This patch adds an ACPI CXL Platform definition with emulated CXL
> > multi-ported host-bridges. A follow on patch adds emulated memory
> > expander devices.
> >
> > Link: https://lore.kernel.org/r/20210202005948.241655-1-ben.widawsky@in=
tel.com [1]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c            |   52 +++-
> >  drivers/cxl/cxl.h             |    8 +
> >  tools/testing/cxl/Kbuild      |   27 ++
> >  tools/testing/cxl/mock_acpi.c |  105 ++++++++
> >  tools/testing/cxl/test/Kbuild |    6
> >  tools/testing/cxl/test/cxl.c  |  508 +++++++++++++++++++++++++++++++++=
++++++++
> >  tools/testing/cxl/test/mock.c |  155 +++++++++++++
> >  tools/testing/cxl/test/mock.h |   26 ++
> >  8 files changed, 866 insertions(+), 21 deletions(-)
> >  create mode 100644 tools/testing/cxl/Kbuild
> >  create mode 100644 tools/testing/cxl/mock_acpi.c
> >  create mode 100644 tools/testing/cxl/test/Kbuild
> >  create mode 100644 tools/testing/cxl/test/cxl.c
> >  create mode 100644 tools/testing/cxl/test/mock.c
> >  create mode 100644 tools/testing/cxl/test/mock.h
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 8ae89273f58e..e0cd9df85ca5 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -182,15 +182,7 @@ static resource_size_t get_chbcr(struct acpi_cedt_=
chbs *chbs)
> >       return IS_ERR(chbs) ? CXL_RESOURCE_NONE : chbs->base;
> >  }
> >
> > -struct cxl_walk_context {
> > -     struct device *dev;
> > -     struct pci_bus *root;
> > -     struct cxl_port *port;
> > -     int error;
> > -     int count;
> > -};
> > -
> > -static int match_add_root_ports(struct pci_dev *pdev, void *data)
> > +__weak int match_add_root_ports(struct pci_dev *pdev, void *data)
> >  {
> >       struct cxl_walk_context *ctx =3D data;
> >       struct pci_bus *root_bus =3D ctx->root;
> > @@ -214,6 +206,8 @@ static int match_add_root_ports(struct pci_dev *pde=
v, void *data)
> >       port_num =3D FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> >       rc =3D cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NON=
E);
> >       if (rc) {
> > +             dev_err(dev, "failed to add dport: %s (%d)\n",
> > +                     dev_name(&pdev->dev), rc);
> >               ctx->error =3D rc;
> >               return rc;
> >       }
> > @@ -239,12 +233,15 @@ static struct cxl_dport *find_dport_by_dev(struct=
 cxl_port *port, struct device
> >       return NULL;
> >  }
> >
> > -static struct acpi_device *to_cxl_host_bridge(struct device *dev)
> > +__weak struct acpi_device *to_cxl_host_bridge(struct device *host,
> > +                                           struct device *dev)
> >  {
> >       struct acpi_device *adev =3D to_acpi_device(dev);
> >
> > -     if (strcmp(acpi_device_hid(adev), "ACPI0016") =3D=3D 0)
> > +     if (strcmp(acpi_device_hid(adev), "ACPI0016") =3D=3D 0) {
> > +             dev_dbg(host, "found host bridge %s\n", dev_name(&adev->d=
ev));
> >               return adev;
> > +     }
> >       return NULL;
> >  }
> >
> > @@ -254,14 +251,14 @@ static struct acpi_device *to_cxl_host_bridge(str=
uct device *dev)
> >   */
> >  static int add_host_bridge_uport(struct device *match, void *arg)
> >  {
> > -     struct acpi_device *bridge =3D to_cxl_host_bridge(match);
> > +     struct cxl_port *port;
> > +     struct cxl_dport *dport;
> > +     struct cxl_decoder *cxld;
> > +     struct cxl_walk_context ctx;
> > +     struct acpi_pci_root *pci_root;
> >       struct cxl_port *root_port =3D arg;
> >       struct device *host =3D root_port->dev.parent;
> > -     struct acpi_pci_root *pci_root;
> > -     struct cxl_walk_context ctx;
> > -     struct cxl_decoder *cxld;
> > -     struct cxl_dport *dport;
> > -     struct cxl_port *port;
> > +     struct acpi_device *bridge =3D to_cxl_host_bridge(host, match);
> >
> >       if (!bridge)
> >               return 0;
> > @@ -319,7 +316,7 @@ static int add_host_bridge_dport(struct device *mat=
ch, void *arg)
> >       struct acpi_cedt_chbs *chbs;
> >       struct cxl_port *root_port =3D arg;
> >       struct device *host =3D root_port->dev.parent;
> > -     struct acpi_device *bridge =3D to_cxl_host_bridge(match);
> > +     struct acpi_device *bridge =3D to_cxl_host_bridge(host, match);
> >
> >       if (!bridge)
> >               return 0;
> > @@ -371,6 +368,17 @@ static int add_root_nvdimm_bridge(struct device *m=
atch, void *data)
> >       return 1;
> >  }
> >
> > +static u32 cedt_instance(struct platform_device *pdev)
> > +{
> > +     const bool *native_acpi0017 =3D acpi_device_get_match_data(&pdev-=
>dev);
> > +
> > +     if (native_acpi0017 && *native_acpi0017)
> > +             return 0;
> > +
> > +     /* for cxl_test request a non-canonical instance */
> > +     return U32_MAX;
> > +}
> > +
> >  static int cxl_acpi_probe(struct platform_device *pdev)
> >  {
> >       int rc;
> > @@ -384,7 +392,7 @@ static int cxl_acpi_probe(struct platform_device *p=
dev)
> >               return PTR_ERR(root_port);
> >       dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> >
> > -     status =3D acpi_get_table(ACPI_SIG_CEDT, 0, &acpi_cedt);
> > +     status =3D acpi_get_table(ACPI_SIG_CEDT, cedt_instance(pdev), &ac=
pi_cedt);
> >       if (ACPI_FAILURE(status))
> >               return -ENXIO;
> >
> > @@ -415,9 +423,11 @@ static int cxl_acpi_probe(struct platform_device *=
pdev)
> >       return 0;
> >  }
> >
> > +static bool native_acpi0017 =3D true;
> > +
> >  static const struct acpi_device_id cxl_acpi_ids[] =3D {
> > -     { "ACPI0017", 0 },
> > -     { "", 0 },
> > +     { "ACPI0017", (unsigned long) &native_acpi0017 },
> > +     { },
> >  };
> >  MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 1b2e816e061e..09c81cf8b800 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -226,6 +226,14 @@ struct cxl_nvdimm {
> >       struct nvdimm *nvdimm;
> >  };
> >
> > +struct cxl_walk_context {
> > +     struct device *dev;
> > +     struct pci_bus *root;
> > +     struct cxl_port *port;
> > +     int error;
> > +     int count;
> > +};
> > +
> >  /**
> >   * struct cxl_port - logical collection of upstream port devices and
> >   *                downstream port devices to construct a CXL memory
> > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > new file mode 100644
> > index 000000000000..6ea0c7df36f0
> > --- /dev/null
> > +++ b/tools/testing/cxl/Kbuild
> > @@ -0,0 +1,27 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +ldflags-y +=3D --wrap=3Dis_acpi_device_node
> > +ldflags-y +=3D --wrap=3Dacpi_get_table
> > +ldflags-y +=3D --wrap=3Dacpi_put_table
> > +ldflags-y +=3D --wrap=3Dacpi_evaluate_integer
> > +ldflags-y +=3D --wrap=3Dacpi_pci_find_root
> > +ldflags-y +=3D --wrap=3Dpci_walk_bus
> > +
> > +DRIVERS :=3D ../../../drivers
> > +CXL_SRC :=3D $(DRIVERS)/cxl
> > +CXL_CORE_SRC :=3D $(DRIVERS)/cxl/core
> > +ccflags-y :=3D -I$(srctree)/drivers/cxl/
> > +
> > +obj-$(CONFIG_CXL_ACPI) +=3D cxl_acpi.o
> > +
> > +cxl_acpi-y :=3D $(CXL_SRC)/acpi.o
> > +cxl_acpi-y +=3D mock_acpi.o
> > +
> > +obj-$(CONFIG_CXL_BUS) +=3D cxl_core.o
> > +
> > +cxl_core-y :=3D $(CXL_CORE_SRC)/bus.o
> > +cxl_core-y +=3D $(CXL_CORE_SRC)/pmem.o
> > +cxl_core-y +=3D $(CXL_CORE_SRC)/regs.o
> > +cxl_core-y +=3D $(CXL_CORE_SRC)/memdev.o
> > +cxl_core-y +=3D $(CXL_CORE_SRC)/mbox.o
> > +
> > +obj-m +=3D test/
> > diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acp=
i.c
> > new file mode 100644
> > index 000000000000..256bdf9e1ce8
> > --- /dev/null
> > +++ b/tools/testing/cxl/mock_acpi.c
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > +
> > +#include <linux/platform_device.h>
> > +#include <linux/device.h>
> > +#include <linux/acpi.h>
> > +#include <linux/pci.h>
> > +#include <cxl.h>
> > +#include "test/mock.h"
> > +
> > +struct acpi_device *to_cxl_host_bridge(struct device *host, struct dev=
ice *dev)
> > +{
> > +     int index;
> > +     struct cxl_mock_ops *ops =3D get_cxl_mock_ops(&index);
> > +     struct acpi_device *adev =3D NULL;
> > +
> > +     if (ops && ops->is_mock_bridge(dev)) {
> > +             adev =3D ACPI_COMPANION(dev);
> > +             goto out;
> > +     }
>
> Here, and below ops->is_mock_port()... I'm a bit confused why a mock driv=
er
> would ever attempt to do anything with real hardware. ie, why not

The rationale is to be able to run cxl_test on a system that might
also have real CXL. For example I run this alongside the current QEMU
CXL model, and that results in the cxl_acpi driver attaching to 2
devices:

# tree /sys/bus/platform/drivers/cxl_acpi
/sys/bus/platform/drivers/cxl_acpi
=E2=94=9C=E2=94=80=E2=94=80 ACPI0017:00 -> ../../../../devices/platform/ACP=
I0017:00
=E2=94=9C=E2=94=80=E2=94=80 bind
=E2=94=9C=E2=94=80=E2=94=80 cxl_acpi.0 -> ../../../../devices/platform/cxl_=
acpi.0
=E2=94=9C=E2=94=80=E2=94=80 module -> ../../../../module/cxl_acpi
=E2=94=9C=E2=94=80=E2=94=80 uevent
=E2=94=94=E2=94=80=E2=94=80 unbind

When the device is ACPI0017 this code is walking the ACPI bus looking
for  ACPI0016 devices. A real ACPI0016 will fall through
is_mock_port() to the original to_cxl_host_bridge() logic that just
reads the ACPI device HID. In the mock case the cxl_acpi driver has
instead been tricked into walk the platform bus which has real
platform devices, and the fake cxl_test ones:

/sys/bus/platform/devices/
=E2=94=9C=E2=94=80=E2=94=80 ACPI0012:00 -> ../../../devices/platform/ACPI00=
12:00
=E2=94=9C=E2=94=80=E2=94=80 ACPI0017:00 -> ../../../devices/platform/ACPI00=
17:00
=E2=94=9C=E2=94=80=E2=94=80 alarmtimer.0.auto -> ../../../devices/pnp0/00:0=
4/rtc/rtc0/alarmtimer.0.auto
=E2=94=9C=E2=94=80=E2=94=80 cxl_acpi.0 -> ../../../devices/platform/cxl_acp=
i.0
=E2=94=9C=E2=94=80=E2=94=80 cxl_host_bridge.0 -> ../../../devices/platform/=
cxl_host_bridge.0
=E2=94=9C=E2=94=80=E2=94=80 cxl_host_bridge.1 -> ../../../devices/platform/=
cxl_host_bridge.1
=E2=94=9C=E2=94=80=E2=94=80 cxl_host_bridge.2 -> ../../../devices/platform/=
cxl_host_bridge.2
=E2=94=9C=E2=94=80=E2=94=80 cxl_host_bridge.3 -> ../../../devices/platform/=
cxl_host_bridge.3
=E2=94=9C=E2=94=80=E2=94=80 e820_pmem -> ../../../devices/platform/e820_pme=
m
=E2=94=9C=E2=94=80=E2=94=80 efi-framebuffer.0 -> ../../../devices/platform/=
efi-framebuffer.0
=E2=94=9C=E2=94=80=E2=94=80 efivars.0 -> ../../../devices/platform/efivars.=
0
=E2=94=9C=E2=94=80=E2=94=80 Fixed MDIO bus.0 -> ../../../devices/platform/F=
ixed MDIO bus.0
=E2=94=9C=E2=94=80=E2=94=80 i8042 -> ../../../devices/platform/i8042
=E2=94=9C=E2=94=80=E2=94=80 iTCO_wdt.1.auto -> ../../../devices/pci0000:00/=
0000:00:1f.0/iTCO_wdt.1.auto
=E2=94=9C=E2=94=80=E2=94=80 kgdboc -> ../../../devices/platform/kgdboc
=E2=94=9C=E2=94=80=E2=94=80 pcspkr -> ../../../devices/platform/pcspkr
=E2=94=9C=E2=94=80=E2=94=80 PNP0103:00 -> ../../../devices/platform/PNP0103=
:00
=E2=94=9C=E2=94=80=E2=94=80 QEMU0002:00 -> ../../../devices/pci0000:00/QEMU=
0002:00
=E2=94=9C=E2=94=80=E2=94=80 rtc-efi.0 -> ../../../devices/platform/rtc-efi.=
0
=E2=94=94=E2=94=80=E2=94=80 serial8250 -> ../../../devices/platform/serial8=
250

...where is_mock_port() filters out those real platform devices. Note
that ACPI devices are atypical in that they get registered on the ACPI
bus and some get a companion device with the same name registered on
the platform bus.
