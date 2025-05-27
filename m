Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC827AC45
	for <linux-cxl@vger.kernel.org>; Tue, 27 May 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361908; cv=none; b=Er87nq1TUZTmiNu1VpIbarfNqHTRQJvVNp/97xdoYMoVTZ2QeI32iWfhvfEPfZadJbX8eLQQReBx1eDFiHnaiuaTzGFaJDpK2Prmf9dWlEdTD7UXbBkWxCFbM0m4/UzT5ZISf9lIVgqaVsU95n2JdKY8xZyiS/vtGnK4HQfBsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361908; c=relaxed/simple;
	bh=Lh47bCHDk2ISEYn4jIur+TDr9m0TX//0vai9lck9IFo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B79OFrfXT4yhfb+bipPsghMaUcm5dYDRn6BhZ4+mAD1O567RflqHeMEgDIcAfq9f6eD9N5J6GGEefWa1+syGFSq/acFHHER7Q/GXTrmbtqZ+1A5ccsCfL5Yo7EqKZ0FgzbFeGgBSxpp5t1z2jMHFNC7uNt8d/6uGvTzDFdDaW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6HVw1Q9sz6K9D6;
	Wed, 28 May 2025 00:03:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E8BF14050D;
	Wed, 28 May 2025 00:05:02 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 May
 2025 18:05:01 +0200
Date: Tue, 27 May 2025 17:04:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
	<fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
	"mst@redhat.com" <mst@redhat.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
	"qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Itaru Kitayama <itaru.kitayama@linux.dev>,
	Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v13 2/5] hw/cxl: Make the CXL fixed memory windows
 devices.
Message-ID: <20250527170459.00002418@huawei.com>
In-Reply-To: <1c90834e-f4ed-4707-8d46-57bc37fbf320@fujitsu.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
	<20250513111455.128266-3-Jonathan.Cameron@huawei.com>
	<1c90834e-f4ed-4707-8d46-57bc37fbf320@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 16 May 2025 05:44:34 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 13/05/2025 19:14, Jonathan Cameron via wrote:
> > Previously these somewhat device like structures were tracked using a list
> > in the CXLState in each machine.  This is proving restrictive in a few
> > cases where we need to iterate through these without being aware of the
> > machine type. Just make them sysbus devices.  
> Make sense.
> 
> Minor comments inline

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

Fan addressed this.  It's due to the loop now being external to this
call.

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

Excellent point.  Further than that, now the iterator is gone
I can just pass in correctly typed pointers from the caller
which is a nice to have as well!

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

> > index cae4afcdde..13eb6bf6a4 100644
> > --- a/hw/cxl/cxl-host-stubs.c
> > +++ b/hw/cxl/cxl-host-stubs.c
> > @@ -8,8 +8,12 @@

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

Also a good point.  Here as well I can simply pass the
correct type of pointer in for this and hwaddr *base, hwaddr max_addr
removing the need for cfmw_update_state()

That is all stale infrastructure from before I changed this handling
to force the device order.

Thanks,

Jonathan

