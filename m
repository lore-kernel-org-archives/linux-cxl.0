Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EBFC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 22:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CF660F8F
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 22:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhINWnc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhINWnb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 18:43:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51BAC061764
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 15:42:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d17so360372plr.12
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nCp7KeOpiQJUhJ6ekPt6llR6Tqux2lRRygng15ep4cw=;
        b=dW4vFwhOlEGv9skSgsP8mH9Ru9siuQxXB9+jK7rWZ1rQXED24vcWa2CwDUi4kx1bJ3
         BSvry0gdLyTyYvT3mBZXiDJNqB3LZkdwnTQ/vDDA5mimCONDPUPVx44cfp26m4+Yx1HH
         7ZzZwmn/AhL1KtQ6r2p/i2DA7tKDwga41jtdD2Qfjpy6eT9loeuSQSCpqr/RjkhnAj15
         twWMxcfwAu9n/msRRPy/BpjVC8CelLaeN/uENxj+0M03WBIP2R+8/1hOhyA0AYotYimq
         s/LGCvChBVyb5NUYu+VQkPOh1knspVhDaWDX1ZmIo1dMrOO40K7n3efmVHnoFyNYTu35
         TXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nCp7KeOpiQJUhJ6ekPt6llR6Tqux2lRRygng15ep4cw=;
        b=Vl9TsfUI44tgSy+gHEcUfLmubupeT0A3Rli+OwydLJcz6W7X9mRyTZgIqLdSkn0tUL
         jSc963s6iGX6cUhIzzyTEf93W9r23nokgr+/Rrdgo4LKygPeRoWfjeavHzdcOubbEOod
         B4/lHsAePEP6juBjPsM68gCFnWITeufi/ZquQwUmGamVUkk5LaMi3pDurYBEVZiBz8vk
         dkwgLVjVxXnn4gpeMlJLwJ8Tcd6FNz+Cia5guLu+u+iOvg6ppD7Ks3gHg8gUpXGel7qC
         tS4yGnAuWgFnutfoYcUz9hShRuYQ2IqRFMIx8pcD0tqknxeAXj9V7N/GMamnp2nTZc1a
         oUrQ==
X-Gm-Message-State: AOAM531YAT7BKunRflrtotZpIH4bbKQlqg6NpOQEKP2PlgPCnPiBX403
        NSVWMqfHqtYalKuttjjt0ooUmBDYx3gtpPAqPFfhyg==
X-Google-Smtp-Source: ABdhPJxaE+XeZ7jELLUQIVSi/BVS4kChL/bam3ktgseHlX0QZflVRgDzeC4LLL5Vsp6PI6ntpMA2JyvHJSHW2FZn8/Y=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr4691767pjb.220.1631659333133;
 Tue, 14 Sep 2021 15:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-8-ben.widawsky@intel.com> <CAPcyv4gKBcdQYAU2qJKDbheaK-SFbOUmNPS+eNB5sbY+B644rQ@mail.gmail.com>
 <20210913221005.bal2nmauvyrpcp5w@intel.com>
In-Reply-To: <20210913221005.bal2nmauvyrpcp5w@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 15:42:01 -0700
Message-ID: <CAPcyv4iRmrJh_o+YwCDaOYCeZzsZtmz6EbFWQj9tkZgRiBFz3A@mail.gmail.com>
Subject: Re: [PATCH 07/13] cxl/memdev: Determine CXL.mem capability
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 13, 2021 at 3:10 PM Ben Widawsky <ben.widawsky@intel.com> wrote=
:
>
> On 21-09-10 14:59:29, Dan Williams wrote:
> > On Thu, Sep 2, 2021 at 12:50 PM Ben Widawsky <ben.widawsky@intel.com> w=
rote:
> > >
> > > If the "upstream" port of the endpoint is an enumerated downstream CX=
L
> > > port, and the device itself is CXL capable and enabled, the memdev
> > > driver can bind. This binding useful for region configuration/creatio=
n
> > > because it provides a clean way for the region code to determine if t=
he
> > > memdev is actually CXL capable.
> > >
> > > A memdev/hostbridge probe race is solved with a full CXL bus rescan a=
t
> > > the end of ACPI probing (see comment in code for details). Switch
> > > enumeration will be done as a follow-on patch. As a result, if a swit=
ch
> > > is in the topology the memdev driver will not bind to any devices.
> > >
> > > CXL.mem capability is checked lazily at the time a region is bound.
> > > This is in line with the other configuration parameters.
> > >
> > > Below is an example (mem0, and mem1) of CXL memdev devices that now
> > > exist on the bus.
> > >
> > > /sys/bus/cxl/devices/
> > > =E2=94=9C=E2=94=80=E2=94=80 decoder0.0 -> ../../../devices/platform/A=
CPI0017:00/root0/decoder0.0
> > > =E2=94=9C=E2=94=80=E2=94=80 mem0 -> ../../../devices/pci0000:34/0000:=
34:01.0/0000:36:00.0/mem0
> > > =E2=94=9C=E2=94=80=E2=94=80 mem1 -> ../../../devices/pci0000:34/0000:=
34:00.0/0000:35:00.0/mem1
> >
> > I'm confused, this isn't showing anything new that did not already
> > exist before this patch? What I think would be a useful shortcut is
> > for memX devices to have an attribute that links back to their cxl
> > root port after validation completes. Like an attribute group that
> > arrives and disappears when the driver successfully binds and unbinds
> > respectively.
> >
>
> This was a copy-paste mistake. I meant to show the memX devices under cxl=
_mem
> drivers, like this:
> # tree /sys/bus/cxl/drivers/
> /sys/bus/cxl/drivers/
> =E2=94=9C=E2=94=80=E2=94=80 cxl_mem
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 bind
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 mem0 -> ../../../../devices/pci00=
00:34/0000:34:00.0/0000:35:00.0/mem0
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 mem1 -> ../../../../devices/pci00=
00:34/0000:34:01.0/0000:36:00.0/mem1

Ok, but that's still just typical sysfs, the new ground to highlight
in my mind would be the path of the port added by the memX driver
appearing in the hierarchy of CXL ports up to the host bridge from the
device.

> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uevent
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 unbind
> =E2=94=9C=E2=94=80=E2=94=80 cxl_nvdimm
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 bind
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 uevent
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 unbind
> =E2=94=94=E2=94=80=E2=94=80 cxl_nvdimm_bridge
>     =E2=94=9C=E2=94=80=E2=94=80 bind
>     =E2=94=9C=E2=94=80=E2=94=80 uevent
>     =E2=94=94=E2=94=80=E2=94=80 unbind
>
>
> While I'm not opposed to add a link as you mention, I don't yet see the u=
tility.
> Are you thinking as primarily a convenience for userspace tooling? Is thi=
s
> useful if you have a switch in the path?

I was thinking it is useful for something like:

cxl list --memdevs --root-decoder=3Ddecoder0.0

...where it filters all the memdev by the ones that can possibly
participate in a given CFMWS range. Without a cache-copy of the root
port hanging off of the memdev, cxl-cli will need to redo the work the
kernel has already done to walk the CXL connectivity topology

This capability to list devices by their relationship to other objects
proved powerful for "ndctl list".

>
> > > =E2=94=9C=E2=94=80=E2=94=80 pmem0 -> ../../../devices/pci0000:34/0000=
:34:01.0/0000:36:00.0/mem0/pmem0
> > > =E2=94=9C=E2=94=80=E2=94=80 pmem1 -> ../../../devices/pci0000:34/0000=
:34:00.0/0000:35:00.0/mem1/pmem1
> > > =E2=94=9C=E2=94=80=E2=94=80 port1 -> ../../../devices/platform/ACPI00=
17:00/root0/port1
> > > =E2=94=94=E2=94=80=E2=94=80 root0 -> ../../../devices/platform/ACPI00=
17:00/root0
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/acpi.c        | 27 +++++++-----------
> > >  drivers/cxl/core/bus.c    | 60 +++++++++++++++++++++++++++++++++++++=
++
> > >  drivers/cxl/core/memdev.c |  6 ++++
> > >  drivers/cxl/cxl.h         |  2 ++
> > >  drivers/cxl/cxlmem.h      |  2 ++
> > >  drivers/cxl/mem.c         | 55 ++++++++++++++++++++++++++++++++++-
> > >  drivers/cxl/pci.c         | 23 ---------------
> > >  drivers/cxl/pci.h         |  7 ++++-
> > >  8 files changed, 141 insertions(+), 41 deletions(-)
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 7130beffc929..fd14094bdb3f 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -240,21 +240,6 @@ __mock int match_add_root_ports(struct pci_dev *=
pdev, void *data)
> > >         return 0;
> > >  }
> > >
> > > -static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, st=
ruct device *dev)
> > > -{
> > > -       struct cxl_dport *dport;
> > > -
> > > -       device_lock(&port->dev);
> > > -       list_for_each_entry(dport, &port->dports, list)
> > > -               if (dport->dport =3D=3D dev) {
> > > -                       device_unlock(&port->dev);
> > > -                       return dport;
> > > -               }
> > > -
> > > -       device_unlock(&port->dev);
> > > -       return NULL;
> > > -}
> > > -
> > >  __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
> > >                                               struct device *dev)
> > >  {
> > > @@ -459,9 +444,19 @@ static int cxl_acpi_probe(struct platform_device=
 *pdev)
> > >         if (rc)
> > >                 goto out;
> > >
> > > -       if (IS_ENABLED(CONFIG_CXL_PMEM))
> > > +       if (IS_ENABLED(CONFIG_CXL_PMEM)) {
> > >                 rc =3D device_for_each_child(&root_port->dev, root_po=
rt,
> > >                                            add_root_nvdimm_bridge);
> > > +               if (rc)
> > > +                       goto out;
> > > +       }
> > > +
> > > +       /*
> > > +        * While ACPI is scanning hostbridge ports, switches and memo=
ry devices
> > > +        * may have been probed. Those devices will need to know whet=
her the
> > > +        * hostbridge is CXL capable.
> > > +        */
> > > +       rc =3D bus_rescan_devices(&cxl_bus_type);
> >
> > I don't think it's a good idea to call bus_rescan_devices() from
> > probe() context. This now sets up a lockdep dependency between the
> > ACPI0017 device-lock and all the device-locks for every device on the
> > cxl-bus. This is why the nvdimm code punts the rescan outside the lock
> > to a workqueue.
> >
> > Lockdep unfortunately won't complain about device-lock entanglements.
> > One item for the backlog is to add device-lock validation to the cxl
> > subsystem ala commit 87a30e1f05d7 ("driver-core, libnvdimm: Let device
> > subsystems add local lockdep coverage")
>
> Good catch. I will fix. This is now the second time I tripped over that b=
acklog
> item :-)
>
> >
> >
> > >
> > >  out:
> > >         acpi_put_table(acpi_cedt);
> > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > index 256e55dc2a3b..56f57302d27b 100644
> > > --- a/drivers/cxl/core/bus.c
> > > +++ b/drivers/cxl/core/bus.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/idr.h>
> > >  #include <cxlmem.h>
> > >  #include <cxl.h>
> > > +#include <pci.h>
> > >  #include "core.h"
> > >
> > >  /**
> > > @@ -259,6 +260,12 @@ static const struct device_type cxl_port_type =
=3D {
> > >         .groups =3D cxl_port_attribute_groups,
> > >  };
> > >
> > > +bool is_cxl_port(struct device *dev)
> > > +{
> > > +       return dev->type =3D=3D &cxl_port_type;
> > > +}
> > > +EXPORT_SYMBOL_GPL(is_cxl_port);
> > > +
> > >  struct cxl_port *to_cxl_port(struct device *dev)
> > >  {
> > >         if (dev_WARN_ONCE(dev, dev->type !=3D &cxl_port_type,
> > > @@ -266,6 +273,7 @@ struct cxl_port *to_cxl_port(struct device *dev)
> > >                 return NULL;
> > >         return container_of(dev, struct cxl_port, dev);
> > >  }
> > > +EXPORT_SYMBOL_GPL(to_cxl_port);
> > >
> > >  static void unregister_port(void *_port)
> > >  {
> > > @@ -424,6 +432,27 @@ static int add_dport(struct cxl_port *port, stru=
ct cxl_dport *new)
> > >         return dup ? -EEXIST : 0;
> > >  }
> > >
> > > +/**
> > > + * find_dport_by_dev - gets downstream CXL port from a struct device
> > > + * @port: cxl [upstream] port that "owns" the downstream port is bei=
ng queried
> > > + * @dev: The device that is backing the downstream port
> > > + */
> > > +struct cxl_dport *find_dport_by_dev(struct cxl_port *port, const str=
uct device *dev)
> > > +{
> > > +       struct cxl_dport *dport;
> > > +
> > > +       device_lock(&port->dev);
> > > +       list_for_each_entry(dport, &port->dports, list)
> > > +               if (dport->dport =3D=3D dev) {
> > > +                       device_unlock(&port->dev);
> > > +                       return dport;
> > > +               }
> > > +
> > > +       device_unlock(&port->dev);
> > > +       return NULL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(find_dport_by_dev);
> >
> > This wants to move into the "cxl_" prefix symbol namespace if it's now
> > going to be a public function.
> >
> > > +
> > >  /**
> > >   * cxl_add_dport - append downstream port data to a cxl_port
> > >   * @port: the cxl_port that references this dport
> > > @@ -596,6 +625,37 @@ int cxl_decoder_autoremove(struct device *host, =
struct cxl_decoder *cxld)
> > >  }
> > >  EXPORT_SYMBOL_GPL(cxl_decoder_autoremove);
> > >
> > > +/**
> > > + * cxl_pci_dvsec - Gets offset for the given DVSEC id
> > > + * @pdev: PCI device to search for the DVSEC
> > > + * @dvsec: DVSEC id to look for
> > > + *
> > > + * Return: offset within the PCI header for the given DVSEC id. 0 if=
 not found
> > > + */
> > > +int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> > > +{
> > > +       int pos;
> > > +
> > > +       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > > +       if (!pos)
> > > +               return 0;
> > > +
> > > +       while (pos) {
> > > +               u16 vendor, id;
> > > +
> > > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &=
vendor);
> > > +               pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &=
id);
> > > +               if (vendor =3D=3D PCI_DVSEC_VENDOR_ID_CXL && dvsec =
=3D=3D id)
> > > +                       return pos;
> > > +
> > > +               pos =3D pci_find_next_ext_capability(pdev, pos,
> > > +                                                  PCI_EXT_CAP_ID_DVS=
EC);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cxl_mem_dvsec);
> >
> > Why not keep this enumeration in cxl_pci and have it record the
> > component register block base address at cxl_memdev creation time?
> > This would make it similar to cxl_port creation that takes a
> > component_register base address argument.
> >
>
> It does that, this is needed in addition to that to find certain DVSEC re=
gisters
> that are used to determine CXL properties.

Ok, like HDM Base registers?

Should this information be passed in to the port creation rather than
retrieved after port creation?

Side tangent... is drivers/cxl/core/bus.c becoming a dumping ground?
I.e. is it time for drivers/cxl/core/{pci,port}.c?

>
> > > +
> > >  /**
> > >   * __cxl_driver_register - register a driver for the cxl bus
> > >   * @cxl_drv: cxl driver structure to attach
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index c9dd054bd813..0068b5ff5f3e 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -337,3 +337,9 @@ void cxl_memdev_exit(void)
> > >  {
> > >         unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX=
_DEVS);
> > >  }
> > > +
> > > +bool is_cxl_mem_capable(struct cxl_memdev *cxlmd)
> > > +{
> > > +       return !!cxlmd->dev.driver;
> > > +}
> > > +EXPORT_SYMBOL_GPL(is_cxl_mem_capable);
> >
> > Perhaps:
> >
> > s/capable/{enabled,routed}/
> >
> > The device is always capable, it's the hierarchy that will let it down.
>
> I can rename to routed. From my perspective, capable and enabled aren't
> synonymous. A capable device may not be enabled.
>
> >
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index b48bdbefd949..a168520d741b 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -283,8 +283,10 @@ struct cxl_port *devm_cxl_add_port(struct device=
 *host, struct device *uport,
> > >                                    resource_size_t component_reg_phys=
,
> > >                                    struct cxl_port *parent_port);
> > >
> > > +bool is_cxl_port(struct device *dev);
> > >  int cxl_add_dport(struct cxl_port *port, struct device *dport, int p=
ort_id,
> > >                   resource_size_t component_reg_phys);
> > > +struct cxl_dport *find_dport_by_dev(struct cxl_port *port, const str=
uct device *dev);
> > >
> > >  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> > >  bool is_root_decoder(struct device *dev);
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 811b24451604..88264204c4b9 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -51,6 +51,8 @@ static inline struct cxl_memdev *to_cxl_memdev(stru=
ct device *dev)
> > >  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> > >                                        struct cxl_mem *cxlm);
> > >
> > > +bool is_cxl_mem_capable(struct cxl_memdev *cxlmd);
> > > +
> > >  /**
> > >   * struct cxl_mbox_cmd - A command to be submitted to hardware.
> > >   * @opcode: (input) The command set and command submitted to hardwar=
e.
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index 978a54b0a51a..b6dc34d18a86 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -2,8 +2,10 @@
> > >  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > >  #include <linux/device.h>
> > >  #include <linux/module.h>
> > > +#include <linux/pci.h>
> > >
> > >  #include "cxlmem.h"
> > > +#include "pci.h"
> > >
> > >  /**
> > >   * DOC: cxl mem
> > > @@ -17,9 +19,60 @@
> > >   * components.
> > >   */
> > >
> > > +static int port_match(struct device *dev, const void *data)
> > > +{
> > > +       struct cxl_port *port;
> > > +
> > > +       if (!is_cxl_port(dev))
> > > +               return 0;
> > > +
> > > +       port =3D to_cxl_port(dev);
> > > +
> > > +       if (find_dport_by_dev(port, (struct device *)data))
> > > +               return 1;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static bool is_cxl_mem_enabled(struct pci_dev *pdev)
> > > +{
> > > +       int pcie_dvsec;
> > > +       u16 dvsec_ctrl;
> > > +
> > > +       pcie_dvsec =3D cxl_pci_dvsec(pdev, PCI_DVSEC_ID_PCIE_DVSEC_CX=
L_DVSEC_ID);
> > > +       if (!pcie_dvsec) {
> > > +               dev_info(&pdev->dev, "Unable to determine CXL protoco=
l support");
> > > +               return false;
> > > +       }
> > > +
> > > +       pci_read_config_word(pdev,
> > > +                            pcie_dvsec + PCI_DVSEC_ID_CXL_PCIE_CTRL_=
OFFSET,
> > > +                            &dvsec_ctrl);
> > > +       if (!(dvsec_ctrl & CXL_PCIE_MEM_ENABLE)) {
> > > +               dev_info(&pdev->dev, "CXL.mem protocol not supported =
on device");
> > > +               return false;
> > > +       }
> > > +
> > > +       return true;
> > > +}
> > > +
> > >  static int cxl_mem_probe(struct device *dev)
> > >  {
> > > -       return -EOPNOTSUPP;
> > > +       struct cxl_memdev *cxlmd =3D to_cxl_memdev(dev);
> > > +       struct cxl_mem *cxlm =3D cxlmd->cxlm;
> > > +       struct device *pdev_parent =3D cxlm->dev->parent;
> > > +       struct pci_dev *pdev =3D to_pci_dev(cxlm->dev);
> >
> > It's not safe to assume that the parent of a cxlmd is a pci device.
> >
>
> What can it be then? Isn't the parent always going to be a downstream por=
t,
> root port, or emulated port from cxl_test?

It was a nice property of the recent reworks that
drivers/cxl/core/memdev.c was able to drop its include of
<linux/pci.h> because drivers/cxl/pci.c handled all of those details.
So I'd prefer that any extra PCI details that memdev needs be probed
by the PCI driver and passed to the creation of the memdev device,
like the component register location.

This preserves the ability of cxl_test to implement the ioctl and
sysfs ABI without needing to also emulate PCI, but also just keeps PCI
concerns in files named "pci".

>
> > > +       struct device *port_dev;
> > > +
> > > +       if (!is_cxl_mem_enabled(pdev))
> > > +               return -ENODEV;
> >
> > This isn't sufficient, this needs to walk the entire hierarchy, right?
> >
>
> It was saved to a later patch because I have no way to actually test deep=
er
> hierarchies at the moment. After I had already sent this, you and I discu=
ssed
> not doing that. I can merge it together if there's no perceived value in =
keeping
> them separate, which it sounds like there isn't.

Yeah, let's keep heading that direction...

>
> > > +
> > > +       /* TODO: if parent is a switch, this will fail. */
> >
> > Won't the parent be a switch in all cases? For example, even in QEMU
> > today the parent of the CXL device is the switch in the host bridge.
> >
> > # cat /sys/bus/cxl/devices/port1/decoder1.0/devtype
> > cxl_decoder_switch
>
> In QEMU (and I assume hardware) they aren't the same, root ports have a s=
eparate
> implementation from switches. That aside, the primary difference in the d=
river
> is that cxl_acpi enumerates root ports so the cxl_mem driver can determin=
e
> connectedness as long as cxl_acpi has run.

I know that PCI root ports are distinct from PCI switches, but the
Linux CXL topology is a Linux specific interpretation of the CXL spec
where cxl_decoder_switch applies equally to the 2nd-level+ decoders.
There is no cxl_decoder_root_port. So the comment on a minimum either
needs to be deleted or fixed up to be specific about
Linux-cxl_decoder_switch vs PCI/CXL-spec defined switch.
