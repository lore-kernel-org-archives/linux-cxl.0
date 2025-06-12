Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF52239E99
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732667; cv=none; b=VcFslRbnSiyiYDtm0r6X5O+bUEith25z6DfNdolHLGpNeoo0HzHVAWSWYKFE/kHVZu7AqQ6E5yD3VZicokiDLT3KFjJZXpA2EukfnFX9uXAXk5QlI7QrO68CBS7dCfLemxxARgwdwJV5fBo43I81Tp/hqpwISPwmNn6E3eLFfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732667; c=relaxed/simple;
	bh=Qt+kork5waADPVxeD9rHOP2nt1Fw6sPyFuw25hK4JCo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4f5K1vEasmwvI2borTPOnVZJzobt9TN9WiVMpWMGxME2HREnVtRzGq42bqij2qLf3QWZQ05GymML0NSQmLzQ/R7HyZKFNR0p33PQnL84ImcrmtXBaZqxGYJa259GwdZPuVrqqINyoL4vsh2CRv9q4O6CMcPpEnoRDV7OgUFCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ2Mz5Ym1z6L53f;
	Thu, 12 Jun 2025 20:46:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EF6F1402F3;
	Thu, 12 Jun 2025 20:51:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 14:51:00 +0200
Date: Thu, 12 Jun 2025 13:50:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
	<fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
	"mst@redhat.com" <mst@redhat.com>, "linuxarm@huawei.com"
	<linuxarm@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>, Itaru Kitayama
	<itaru.kitayama@linux.dev>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	<philmd@linaro.org>, Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 3/5] hw/cxl-host: Allow split of establishing memory
 address and mmio setup.
Message-ID: <20250612135058.000047fe@huawei.com>
In-Reply-To: <ce28ad6b-a76a-44d7-8135-9560e8e1d6f8@fujitsu.com>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
	<20250528110726.226389-4-Jonathan.Cameron@huawei.com>
	<ce28ad6b-a76a-44d7-8135-9560e8e1d6f8@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 9 Jun 2025 01:15:10 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> In patch 2/5, we introduced `cxl_fmws_set_memmap_and_update_mmio()`.
> 
> Initially, I assumed patch 3/5 would split `cxl_fmws_set_memmap_and_update_mmio()` into two steps:
> 1. Traverse CXLFixedWindow and update `fw->base`.
> 2. Call `sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base)`.
> For example (my personal preference):
> ```c
> hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> {
>      hwaddr end = cxl_fmws_set_memmap(base, max_addr);
>      cxl_fmws_update_mmio();
>      return end;
> }
> 
> 
> If we had implemented this design in patch 2/5, patch 3/5 might not be necessary.

At the time of patch 2 we had no justification for the split as for x86 that would
just look like a pointless double loop.

However you are right that this is too complex given it's not a performance path
and perhaps some commentary in the patch description will be enough that no
one minds.

I'll go a little further than you suggest and push the two calls in
your cxl_fmws_set_memmap_and_mmio() into pc.c (patch 2) as that wrapper
isn't adding much value.

I think it is a big enough change that I'll drop tags given on patch 2.

Thanks,

Jonathan


> The only potential benefit I see in the current patch 3/5 is efficiency improvements
> in cxl_fmws_set_memmap_and_update_mmio(), but since the function is typically
> called only once and the GLib list (glist) is small, the practical impact should
> be minimal.
> 
> I'm interested in others' perspectives on this.
> 
> Thanks
> Zhijian
> 
> 
> On 28/05/2025 19:07, Jonathan Cameron via wrote:
> > On arm/virt the memory map is set up before any devices are brought
> > up.  To enable this provide split functions to establish the fw->base
> > and later to actually map it.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > v14: Update wrt to changes in previous patch.
> >       Add a do_cfwms_set_memmap_and_update_mmio() utility function
> >       to reduce code duplication. (Zhijian)
> > ---
> >   include/hw/cxl/cxl_host.h |  2 ++
> >   hw/cxl/cxl-host-stubs.c   |  2 ++
> >   hw/cxl/cxl-host.c         | 43 +++++++++++++++++++++++++++++++++++----
> >   3 files changed, 43 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
> > index 6dce2cde07..aee9d573d6 100644
> > --- a/include/hw/cxl/cxl_host.h
> > +++ b/include/hw/cxl/cxl_host.h
> > @@ -16,6 +16,8 @@
> >   void cxl_machine_init(Object *obj, CXLState *state);
> >   void cxl_fmws_link_targets(Error **errp);
> >   void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
> > +hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
> > +void cxl_fmws_update_mmio(void);
> >   hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr);
> >   GSList *cxl_fmws_get_all_sorted(void);
> >   
> > diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> > index 13eb6bf6a4..d9e38618d6 100644
> > --- a/hw/cxl/cxl-host-stubs.c
> > +++ b/hw/cxl/cxl-host-stubs.c
> > @@ -11,6 +11,8 @@
> >   void cxl_fmws_link_targets(Error **errp) {};
> >   void cxl_machine_init(Object *obj, CXLState *state) {};
> >   void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
> > +hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr) { return base; };
> > +void cxl_fmws_update_mmio(void) {};
> >   hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> >   {
> >       return base;
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index 016a4fdc6a..a1b9980035 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -378,11 +378,14 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp)
> >       }
> >   }
> >   
> > -static void cxl_fmws_update(CXLFixedWindow *fw, hwaddr *base, hwaddr max_addr)
> > +static void cxl_fmws_update(CXLFixedWindow *fw, hwaddr *base, hwaddr max_addr,
> > +                            bool update_mmio)
> >   {
> >       if (*base + fw->size <= max_addr) {
> >           fw->base = *base;
> > -        sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
> > +        if (update_mmio) {
> > +            sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
> > +        }
> >           *base += fw->size;
> >       }
> >   }
> > @@ -421,19 +424,51 @@ GSList *cxl_fmws_get_all_sorted(void)
> >       return g_slist_sort_with_data(cxl_fmws_get_all(), cfmws_cmp, NULL);
> >   }
> >   
> > -hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> > +static hwaddr do_cxl_fmws_set_memmap_and_update_mmio(hwaddr base,
> > +                                                     hwaddr max_addr,
> > +                                                     bool update_mmio)
> >   {
> >       GSList *cfmws_list, *iter;
> >   
> >       cfmws_list = cxl_fmws_get_all_sorted();
> >       for (iter = cfmws_list; iter; iter = iter->next) {
> > -        cxl_fmws_update(CXL_FMW(iter->data), &base, max_addr);
> > +        cxl_fmws_update(CXL_FMW(iter->data), &base, max_addr, update_mmio);
> >       }
> >       g_slist_free(cfmws_list);
> >   
> >       return base;
> >   }
> >   
> > +hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
> > +{
> > +    return do_cxl_fmws_set_memmap_and_update_mmio(base, max_addr, false);
> > +}
> > +
> > +hwaddr cxl_fmws_set_memmap_and_update_mmio(hwaddr base, hwaddr max_addr)
> > +{
> > +    return do_cxl_fmws_set_memmap_and_update_mmio(base, max_addr, true);
> > +}
> > +
> > +static int cxl_fmws_mmio_map(Object *obj, void *opaque)
> > +{
> > +    struct CXLFixedWindow *fw;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> > +        return 0;
> > +    }
> > +    fw = CXL_FMW(obj);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(fw), 0, fw->base);
> > +
> > +    return 0;
> > +}
> > +
> > +void cxl_fmws_update_mmio(void)
> > +{
> > +    /* Ordering is not required for this */
> > +    object_child_foreach_recursive(object_get_root(), cxl_fmws_mmio_map,
> > +                                   NULL);
> > +}
> > +
> >   static void cxl_fmw_realize(DeviceState *dev, Error **errp)
> >   {
> >       CXLFixedWindow *fw = CXL_FMW(dev)  

