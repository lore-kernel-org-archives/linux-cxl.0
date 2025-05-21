Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE41482EB
	for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747850102; cv=none; b=TW1I6NxLbTlr0+iSoG1HVd4Q3VnRUfA9b0Kt9jhx28HGxJ58Vgzm8IN72BtDSLLK1FPSqcotfKeLGcCR44RdGV2/ORyc+yboOY9yiRrRT92CmEFNhBCBKE6iA/Ks3AfQOG41i6ag4Z+PrZSBzrSfITGegS/ZmMWlP3wyXg4cvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747850102; c=relaxed/simple;
	bh=00jJzzCMcYCZLDXcKWrK85CxHnuqxmutf/Be+O4M0+c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alx0sOp9tvA4Tl9zKX7NhJvnMKmBbVK8gVNz09J1CWwvhzVbR/OstlgEwbhO+V+r6d5SIfoDreESfYHx89UL86LnK3zCSG0t9V+mSEHpAp1kZClRm6sQx1QKlxGlwOF6SsQKVDk66RGwJ/r7UI0+pDAdc0T0kHj+lq7IRWR3DuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYE87+0B; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYE87+0B"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c9907967so3860517b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 21 May 2025 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747850100; x=1748454900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEl4tW2T1XbuNaUB/L5RLtwgUhNfjmnUHhkvtS446bY=;
        b=NYE87+0B/AMYuayJ0poigEeK+G5lMn60upaP77OpVdJWuaNGEXPhJpNqMIQbSGTf7x
         NiPd3wtUhZqlRaBQNvv+J5hZBFb+3V9F7em6+kAdoPDblVFpAD34+Xgg2rsUw6A0duB9
         sXyGAEBGaIhsfiBjX4Zqx7CSB062Di66JFwBGh4yLXccW2sHyv6DI47fVpPWTCwuE4B0
         ec1iNmLodBIoB0ZZHVnVNFf+yD08ckj1bZDGsn7RwS4Msd0ovY4QSBp1A1VDd/HkS49T
         g7xxhmUdFCj3jhao6rhqcpoJdRYAKhHLvqnMvDOmUoR51KrERhUhsZi1iMoJ4az9ZRNt
         qIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747850100; x=1748454900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEl4tW2T1XbuNaUB/L5RLtwgUhNfjmnUHhkvtS446bY=;
        b=EMEgeSrryFa3dEjFOfyUJc413VDAS+1UBx0AZ164V6e7a4DTNKpgmIU075KmLLU8v0
         Z4UFfzhiu8aB+bMjj5yLcYltY++e18GK7+lqlz8uT2TXgbsbcS5G2xzEP7Klns+9kets
         jaz/+L1LldShbEmvGJTYCw5q2u5H2eYloqL/TPtr3NdO8RIjvkJ69Cf6Hqwg74SSyzrQ
         KHraqxnu9C4avdfgObGjENYe6YhnOqBim5xVJSDj2PaXz766OJfyEBWuELG9ImZmvxr5
         e7Y6FityrhBvod/zRiUqfjrw/bsRee1cR9HeaboyXE45nmD7H1SqCPogwvnwZ7aT2LXv
         FOtA==
X-Forwarded-Encrypted: i=1; AJvYcCXV8L1cfKnwC3J+gbATHZzZCWacZXPQhY9fM96h9mYNcJEbjB0BnUkQWH5EjisP+yqs2gIosR5qTaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFqCfwhkKJYMItZUNb9t+4eptFXe2n1b9EWdR4vH4zbAPRu3A
	wITep2P00oTN7w4l1h46QmJGGFcE5CzCIK1TbUnClrzcrowxPRdFYSmMQaAmEw==
X-Gm-Gg: ASbGncsMuQzgJw6pkKzQye3fpqRR5EHRkx+TbLKc0i+wIUkYjyGzVMGz3GucgBluDTE
	9jyTKlQ+xEjI149hJfyVw9sSP+/VTOTAdcPD4tohKzhNSG4UH8/S72d8WNw0xS7p8D0Q6hkZg+L
	AUyvhy7H131OQeiHjBs/warp8S1MfYMXWqIo88PDftRzhlV9/e9PklVP3q2iCav1AthprxfnmrA
	4HC5e2kh0yzxGpPMO5PCJE7Rw0CHIb8gsOrXlu1Cfpz+HXxaBeETbNLx867VfHsdPECiPatXl4c
	nrKP2kihsvR5GXbH+gFMJy/SiJ/Dk5/yFgmGQnawRtHqQ4VW+REDVlo=
X-Google-Smtp-Source: AGHT+IEyT8mMAjyxGrjzH9+/GxZvVjHabnQGQ3zE/blKu4HMdOo2W4Hs2CyC3pzjhm0gsZXcDC+bZg==
X-Received: by 2002:a05:6a20:10a9:b0:216:60bc:2ca9 with SMTP id adf61e73a8af0-21660cb6eefmr25474016637.40.1747850099472;
        Wed, 21 May 2025 10:54:59 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb081aafsm9891746a12.47.2025.05.21.10.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 10:54:58 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 21 May 2025 17:54:56 +0000
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	"mst@redhat.com" <mst@redhat.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Itaru Kitayama <itaru.kitayama@linux.dev>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v13 2/5] hw/cxl: Make the CXL fixed memory windows
 devices.
Message-ID: <aC4TcAerO1P3s40D@smc-140338-bm01>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-3-Jonathan.Cameron@huawei.com>
 <1c90834e-f4ed-4707-8d46-57bc37fbf320@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c90834e-f4ed-4707-8d46-57bc37fbf320@fujitsu.com>

On Fri, May 16, 2025 at 05:44:34AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 13/05/2025 19:14, Jonathan Cameron via wrote:
> > Previously these somewhat device like structures were tracked using a list
> > in the CXLState in each machine.  This is proving restrictive in a few
> > cases where we need to iterate through these without being aware of the
> > machine type. Just make them sysbus devices.
> Make sense.
> 
> Minor comments inline
> 
> > 
> > Restrict them to not user created as they need to be visible to early
> > stages of machine init given effects on the memory map.
> > 
> > This change both simplifies state tracking and enables features needed
> > for performance optimization and hotness tracking by making it possible
> > to retrieve the fixed memory window on actions elsewhere in the topology.
> > 
> > In some cases the ordering of the Fixed Memory Windows matters.
> > For those utility functions provide a GSList sorted by the window index.
> > This ensures that we get consistency across:
> > - ordering in the command line
> > - ordering of the host PA ranges
> > - ordering of ACPI CEDT structures describing the CFMWS.
> > 
> > Other aspects don't have this constraint. For those direct iteration
> > of the underlying hash structures is fine.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > I think Peter Maydell suggested this a long time back when
> > the original CXL support series was under review but not 100% sure.
> > ---
> >   include/hw/cxl/cxl.h      |   3 +
> >   include/hw/cxl/cxl_host.h |   4 +-
> >   hw/acpi/cxl.c             |  83 +++++++++++--------
> >   hw/cxl/cxl-host-stubs.c   |   6 +-
> >   hw/cxl/cxl-host.c         | 169 +++++++++++++++++++++++++++++++-------
> >   hw/i386/pc.c              |  51 ++++++------
> >   6 files changed, 223 insertions(+), 93 deletions(-)
> > 
> > diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> > index b2bcce7ed6..a610795c87 100644
> > --- a/include/hw/cxl/cxl.h
> > +++ b/include/hw/cxl/cxl.h
> > @@ -27,6 +27,7 @@
> >   typedef struct PXBCXLDev PXBCXLDev;
> >   
> >   typedef struct CXLFixedWindow {
> > +    SysBusDevice parent_obj;
> >       int index;
> >       uint64_t size;
> >       char **targets;
> > @@ -38,6 +39,8 @@ typedef struct CXLFixedWindow {
> >       MemoryRegion mr;
> >       hwaddr base;
> >   } CXLFixedWindow;
> > +#define TYPE_CXL_FMW "cxl-fmw"
> > +OBJECT_DECLARE_SIMPLE_TYPE(CXLFixedWindow, CXL_FMW)
> >   
> >   typedef struct CXLState {
> >       bool is_enabled;
> > diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
> > index c9bc9c7c50..6dce2cde07 100644
> > --- a/include/hw/cxl/cxl_host.h
> > +++ b/include/hw/cxl/cxl_host.h
> > @@ -14,8 +14,10 @@
> >   #define CXL_HOST_H
> >   
> >   void cxl_machine_init(Object *obj, CXLState *state);
> > -void cxl_fmws_link_targets(CXLState *stat, Error **errp);
> > +void cxl_fmws_link_targets(Error **errp);
> >   void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
> > +hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr);
> > +GSList *cxl_fmws_get_all_sorted(void);
> >   
> >   extern const MemoryRegionOps cfmws_ops;
> >   
> > diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> > index 9cd7905ea2..20806e5dd4 100644
> > --- a/hw/acpi/cxl.c
> > +++ b/hw/acpi/cxl.c
> > @@ -22,6 +22,7 @@
> >   #include "hw/pci/pci_bridge.h"
> >   #include "hw/pci/pci_host.h"
> >   #include "hw/cxl/cxl.h"
> > +#include "hw/cxl/cxl_host.h"
> >   #include "hw/mem/memory-device.h"
> >   #include "hw/acpi/acpi.h"
> >   #include "hw/acpi/aml-build.h"
> > @@ -135,56 +136,62 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
> >    * Interleave ways encoding in CXL 2.0 ECN: 3, 6, 12 and 16-way memory
> >    * interleaving.
> >    */
> > -static void cedt_build_cfmws(GArray *table_data, CXLState *cxls)
> > +static int cedt_build_cfmws(Object *obj, void *opaque)
> 
> Too much unrelated indent updates in this function
I think that is because now the function only process one cfw, while it
used to process all. So the loop is no longer needed within this
function.

fan
> 
> 
> >   {
> > -    GList *it;
> > +    struct CXLFixedWindow *fw;
> > +    Aml *cedt = opaque;
> > +    GArray *table_data = cedt->buf;
> > +    int i;
> >   
> > -    for (it = cxls->fixed_windows; it; it = it->next) {
> > -        CXLFixedWindow *fw = it->data;
> > -        int i;
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> > +        return 0;
> 
> Never reach here? It seems the caller has ensured passing TYPE_CXL_FMW obj.
> 
> 
> 
> 
> > +    }
> > +    fw = CXL_FMW(obj);
> >   
> > -        /* Type */
> > -        build_append_int_noprefix(table_data, 1, 1);
> > +    /* Type */
> > +    build_append_int_noprefix(table_data, 1, 1);
> >   
> > -        /* Reserved */
> > -        build_append_int_noprefix(table_data, 0, 1);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 1);
> >   
> > -        /* Record Length */
> > -        build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
> > +    /* Record Length */
> > +    build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
> >   
> > -        /* Reserved */
> > -        build_append_int_noprefix(table_data, 0, 4);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 4);
> >   
> > -        /* Base HPA */
> > -        build_append_int_noprefix(table_data, fw->mr.addr, 8);
> > +    /* Base HPA */
> > +    build_append_int_noprefix(table_data, fw->mr.addr, 8);
> >   
> > -        /* Window Size */
> > -        build_append_int_noprefix(table_data, fw->size, 8);
> > +    /* Window Size */
> > +    build_append_int_noprefix(table_data, fw->size, 8);
> >   
> > -        /* Host Bridge Interleave Ways */
> > -        build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
> > +    /* Host Bridge Interleave Ways */
> > +    build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
> >   
> > -        /* Host Bridge Interleave Arithmetic */
> > -        build_append_int_noprefix(table_data, 0, 1);
> > +    /* Host Bridge Interleave Arithmetic */
> > +    build_append_int_noprefix(table_data, 0, 1);
> >   
> > -        /* Reserved */
> > -        build_append_int_noprefix(table_data, 0, 2);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 2);
> >   
> > -        /* Host Bridge Interleave Granularity */
> > -        build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
> > +    /* Host Bridge Interleave Granularity */
> > +    build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
> >   
> > -        /* Window Restrictions */
> > -        build_append_int_noprefix(table_data, 0x0f, 2); /* No restrictions */
> > +    /* Window Restrictions */
> > +    build_append_int_noprefix(table_data, 0x0f, 2);
> >   
> > -        /* QTG ID */
> > -        build_append_int_noprefix(table_data, 0, 2);
> > +    /* QTG ID */
> > +    build_append_int_noprefix(table_data, 0, 2);
> >   
> > -        /* Host Bridge List (list of UIDs - currently bus_nr) */
> > -        for (i = 0; i < fw->num_targets; i++) {
> > -            g_assert(fw->target_hbs[i]);
> > -            build_append_int_noprefix(table_data, PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
> > -        }
> > +    /* Host Bridge List (list of UIDs - currently bus_nr) */
> > +    for (i = 0; i < fw->num_targets; i++) {
> > +        g_assert(fw->target_hbs[i]);
> > +        build_append_int_noprefix(table_data,
> > +                                  PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
> >       }
> > +
> > +    return 0;
> >   }
> >   
> >   static int cxl_foreach_pxb_hb(Object *obj, void *opaque)
> > @@ -202,6 +209,7 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
> >                       BIOSLinker *linker, const char *oem_id,
> >                       const char *oem_table_id, CXLState *cxl_state)
> >   {
> > +    GSList *cfmws_list, *iter;
> >       Aml *cedt;
> >       AcpiTable table = { .sig = "CEDT", .rev = 1, .oem_id = oem_id,
> >                           .oem_table_id = oem_table_id };
> > @@ -213,7 +221,12 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
> >       /* reserve space for CEDT header */
> >   
> >       object_child_foreach_recursive(object_get_root(), cxl_foreach_pxb_hb, cedt);
> > -    cedt_build_cfmws(cedt->buf, cxl_state);
> > +
> > +    cfmws_list = cxl_fmws_get_all_sorted();
> > +    for (iter = cfmws_list; iter; iter = iter->next) {
> > +        cedt_build_cfmws(iter->data, cedt);
> > +    }
> > +    g_slist_free(cfmws_list);
> >   
> >       /* copy AML table into ACPI tables blob and patch header there */
> >       g_array_append_vals(table_data, cedt->buf->data, cedt->buf->len);
> > diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> > index cae4afcdde..13eb6bf6a4 100644
> > --- a/hw/cxl/cxl-host-stubs.c
> > +++ b/hw/cxl/cxl-host-stubs.c
> > @@ -8,8 +8,12 @@
> >   #include "hw/cxl/cxl.h"
> >   #include "hw/cxl/cxl_host.h"
> >   
> > -void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
> > +void cxl_fmws_link_targets(Error **errp) {};
> >   void cxl_machine_init(Object *obj, CXLState *state) {};
> >   void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
> > +hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> > +{
> > +    return base;
> > +};
> >   
> >   const MemoryRegionOps cfmws_ops;
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index b7aa429ddf..438f2920e1 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -22,12 +22,12 @@
> >   #include "hw/pci/pcie_port.h"
> >   #include "hw/pci-bridge/pci_expander_bridge.h"
> >   
> > -static void cxl_fixed_memory_window_config(CXLState *cxl_state,
> > -                                           CXLFixedMemoryWindowOptions *object,
> > +static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
> >                                              int index, Error **errp)
> >   {
> >       ERRP_GUARD();
> > -    g_autofree CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
> > +    DeviceState *dev = qdev_new(TYPE_CXL_FMW);
> > +    CXLFixedWindow *fw = CXL_FMW(dev);
> >       strList *target;
> >       int i;
> >   
> > @@ -67,35 +67,41 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
> >           fw->targets[i] = g_strdup(target->value);
> >       }
> >   
> > -    cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
> > -                                             g_steal_pointer(&fw));
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
> > +
> > +    return;
> >   }
> >   
> > -void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
> > +static int cxl_fmws_link(Object *obj, void *opaque)
> >   {
> > -    if (cxl_state && cxl_state->fixed_windows) {
> > -        GList *it;
> > -
> > -        for (it = cxl_state->fixed_windows; it; it = it->next) {
> > -            CXLFixedWindow *fw = it->data;
> > -            int i;
> > -
> > -            for (i = 0; i < fw->num_targets; i++) {
> > -                Object *o;
> > -                bool ambig;
> > -
> > -                o = object_resolve_path_type(fw->targets[i],
> > -                                             TYPE_PXB_CXL_DEV,
> > -                                             &ambig);
> > -                if (!o) {
> > -                    error_setg(errp, "Could not resolve CXLFM target %s",
> > -                               fw->targets[i]);
> > -                    return;
> > -                }
> > -                fw->target_hbs[i] = PXB_CXL_DEV(o);
> > -            }
> > +    struct CXLFixedWindow *fw;
> > +    int i;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> > +        return 0;
> > +    }
> > +    fw = CXL_FMW(obj);
> > +
> > +    for (i = 0; i < fw->num_targets; i++) {
> > +        Object *o;
> > +        bool ambig;
> > +
> > +        o = object_resolve_path_type(fw->targets[i], TYPE_PXB_CXL_DEV,
> > +                                     &ambig);
> > +        if (!o) {
> > +            error_setg(&error_fatal, "Could not resolve CXLFM target %s",
> > +                       fw->targets[i]);
> > +            return 1;
> >           }
> > +        fw->target_hbs[i] = PXB_CXL_DEV(o);
> >       }
> > +    return 0;
> > +}
> > +
> > +void cxl_fmws_link_targets(Error **errp)
> > +{
> > +    /* Order doesn't matter for this, so no need to build list */
> > +    object_child_foreach_recursive(object_get_root(), cxl_fmws_link, NULL);
> >   }
> >   
> >   static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
> > @@ -335,7 +341,7 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
> >       }
> >   
> >       for (it = cfmw_list, index = 0; it; it = it->next, index++) {
> > -        cxl_fixed_memory_window_config(state, it->value, index, errp);
> > +        cxl_fixed_memory_window_config(it->value, index, errp);
> >       }
> >       state->cfmw_list = cfmw_list;
> >   }
> > @@ -373,3 +379,110 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
> >           }
> >       }
> >   }
> > +
> > +struct cfmw_update_state {
> > +    hwaddr base;
> > +    hwaddr maxaddr;
> > +};
> > +
> > +static void cxl_fmws_update(Object *obj, void *opaque)
> > +{
> > +    struct CXLFixedWindow *fw;
> > +    struct cfmw_update_state *s = opaque;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> 
> 
> Never reach here? It seems the caller has ensured passing TYPE_CXL_FMW obj.
> 
> 
> Thanks
> Zhijian
> 
> > +        return;
> > +    }
> > +
> > +    fw = CXL_FMW(obj);
> > +    if (s->base + fw->size <= s->maxaddr) {
> > +        fw->base = s->base;
> > +        sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
> > +        s->base += fw->size;
> > +    }
> > +
> > +    return;
> > +}
> > +
> > +static int cxl_fmws_find(Object *obj, void *opaque)
> > +{
> > +    GSList **list = opaque;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> > +        return 0;
> > +    }
> > +    *list = g_slist_prepend(*list, obj);
> > +
> > +    return 0;
> > +}
> > +
> > +static GSList *cxl_fmws_get_all(void)
> > +{
> > +    GSList *list = NULL;
> > +
> > +    object_child_foreach_recursive(object_get_root(), cxl_fmws_find, &list);
> > +
> > +    return list;
> > +}
> > +
> > +static gint cfmws_cmp(gconstpointer a, gconstpointer b, gpointer d)
> > +{
> > +    const struct CXLFixedWindow *ap = a;
> > +    const struct CXLFixedWindow *bp = b;
> > +
> > +    return ap->index > bp->index;
> > +}
> > +
> > +GSList *cxl_fmws_get_all_sorted(void)
> > +{
> > +    return g_slist_sort_with_data(cxl_fmws_get_all(), cfmws_cmp, NULL);
> > +}
> > +
> > +hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> > +{
> > +    GSList *cfmws_list, *iter;
> > +
> > +    struct cfmw_update_state cfmwss = {
> > +        .base = base,
> > +        .maxaddr = max_addr,
> > +    };
> > +    cfmws_list = cxl_fmws_get_all_sorted();
> > +    for (iter = cfmws_list; iter; iter = iter->next) {
> > +        cxl_fmws_update(iter->data, &cfmwss);
> > +    }
> > +    g_slist_free(cfmws_list);
> > +
> > +    return cfmwss.base;
> > +}
> > +
> > +static void cxl_fmw_realize(DeviceState *dev, Error **errp)
> > +{
> > +    CXLFixedWindow *fw = CXL_FMW(dev);
> > +
> > +    memory_region_init_io(&fw->mr, OBJECT(dev), &cfmws_ops, fw,
> > +                          "cxl-fixed-memory-region", fw->size);
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &fw->mr);
> > +}
> > +
> > +static void cxl_fmw_class_init(ObjectClass *klass, const void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +
> > +    dc->desc = "CXL Fixed Memory Window";
> > +    dc->realize = cxl_fmw_realize;
> > +    /* Reason - created by machines as tightly coupled to machine memory map */
> > +    dc->user_creatable = false;
> > +}
> > +
> > +static const TypeInfo cxl_fmw_info = {
> > +    .name = TYPE_CXL_FMW,
> > +    .parent = TYPE_SYS_BUS_DEVICE,
> > +    .instance_size = sizeof(CXLFixedWindow),
> > +    .class_init = cxl_fmw_class_init,
> > +};
> > +
> > +static void cxl_host_register_types(void)
> > +{
> > +    type_register_static(&cxl_fmw_info);
> > +}
> > +type_init(cxl_host_register_types)
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 70656157ca..9978398876 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -630,7 +630,7 @@ void pc_machine_done(Notifier *notifier, void *data)
> >                                 &error_fatal);
> >   
> >       if (pcms->cxl_devices_state.is_enabled) {
> > -        cxl_fmws_link_targets(&pcms->cxl_devices_state, &error_fatal);
> > +        cxl_fmws_link_targets(&error_fatal);
> >       }
> >   
> >       /* set the number of CPUs */
> > @@ -739,20 +739,28 @@ static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
> >       return cxl_base;
> >   }
> >   
> > -static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
> > +static int cxl_get_fmw_end(Object *obj, void *opaque)
> >   {
> > -    uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
> > +    struct CXLFixedWindow *fw;
> > +    uint64_t *start = opaque;
> >   
> > -    if (pcms->cxl_devices_state.fixed_windows) {
> > -        GList *it;
> > -
> > -        start = ROUND_UP(start, 256 * MiB);
> > -        for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
> > -            CXLFixedWindow *fw = it->data;
> > -            start += fw->size;
> > -        }
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> > +        return 0;
> >       }
> > +    fw = CXL_FMW(obj);
> > +
> > +    *start += fw->size;
> >   
> > +    return 0;
> > +}
> > +
> > +static uint64_t pc_get_cxl_range_end(PCMachineState *pcms)
> > +{
> > +    uint64_t start = pc_get_cxl_range_start(pcms) + MiB;
> > +
> > +    /* Ordering doesn't matter so no need to build a sorted list */
> > +    object_child_foreach_recursive(object_get_root(), cxl_get_fmw_end,
> > +                                   &start);
> >       return start;
> >   }
> >   
> > @@ -954,23 +962,10 @@ void pc_memory_init(PCMachineState *pcms,
> >           cxl_base = pc_get_cxl_range_start(pcms);
> >           memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
> >           memory_region_add_subregion(system_memory, cxl_base, mr);
> > -        cxl_resv_end = cxl_base + cxl_size;
> > -        if (pcms->cxl_devices_state.fixed_windows) {
> > -            hwaddr cxl_fmw_base;
> > -            GList *it;
> > -
> > -            cxl_fmw_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
> > -            for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
> > -                CXLFixedWindow *fw = it->data;
> > -
> > -                fw->base = cxl_fmw_base;
> > -                memory_region_init_io(&fw->mr, OBJECT(machine), &cfmws_ops, fw,
> > -                                      "cxl-fixed-memory-region", fw->size);
> > -                memory_region_add_subregion(system_memory, fw->base, &fw->mr);
> > -                cxl_fmw_base += fw->size;
> > -                cxl_resv_end = cxl_fmw_base;
> > -            }
> > -        }
> > +        cxl_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
> > +
> > +        cxl_resv_end = cxl_fmws_set_memmap_and_update_mmio(cxl_base,
> > +                                                           maxphysaddr);
> >       }
> >   
> >       /* Initialize PC system firmware */

-- 
Fan Ni (From gmail)
