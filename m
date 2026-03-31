Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282D194C98
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968823; cv=none; b=f49a4YIddo/6maFOHDnlE/rhfR7ulfdSkBXQxh7ao6qpIBgGVTJeHqpL7oFmdBWzNSNv01iPAU2HWPVGccwrqgn4BMFx6dN99YaPsij5yNlBy2hiQHM8jA4sm3KRrfy654a4kHQVwDO9sUr2ki8jRe5y6KY/b+YdYHycqyMb+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968823; c=relaxed/simple;
	bh=D3GTkhP/lTSH51nc8quGY5NDjj/QgqMccivoGCMSPDk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2+iztX7Ug6S81adQ2ZLz/TEj2qZtkLuMuyLq0+tAWZojmlU/9vigkGts85pQbRffojcyBg9bYKoKNasenOP4l729e82OArjOSbrkZ57I27h3Y3YiSwaQOG0HNVaohiQPUbIw5bEvjrwvGLqtdXt5FYCycplgYQJd8bW+wG81ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4flWLp383CzHnGgW;
	Tue, 31 Mar 2026 22:52:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CB4FA40575;
	Tue, 31 Mar 2026 22:53:37 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 15:53:36 +0100
Date: Tue, 31 Mar 2026 15:53:31 +0100
From: Alireza Sanaee <alireza.sanaee@huawei.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <armbru@redhat.com>, <berrange@redhat.com>,
	<eblake@redhat.com>, <jonathan.cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
	<mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
	<nifan.cxl@gmail.com>, <me@linux.beauty>, <sarsanaee@gmail.com>
Subject: Re: [PATCH 8/9] hw/cxl: Add tag-based dynamic-capacity release
 support
Message-ID: <20260331155331.0000436d.alireza.sanaee@huawei.com>
In-Reply-To: <acq63qeubIux3W0p@4470NRD-ASU.ssi.samsung.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-9-alireza.sanaee@huawei.com>
	<acq63qeubIux3W0p@4470NRD-ASU.ssi.samsung.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 30 Mar 2026 11:03:10 -0700
Anisa Su <anisa.su887@gmail.com> wrote:

Hi Anisa,

Thanks for testing. I will make this change and send a new version then.

> On Wed, Mar 25, 2026 at 06:42:56PM +0000, Alireza Sanaee wrote:
> > Add support for the tag-based dynamic-capacity release policy via the QMP
> > interface. The new path scans committed extents, selects those whose stored
> > tag matches the requested UUID, and emits a Release Dynamic Capacity event
> > for each matching range.
> > 
> > This is intentionally scoped to tag-driven selection. Prescriptive release
> > handling and the underlying extent teardown stay in the existing paths.
> > 
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > ---
> >  hw/mem/cxl_type3.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 6b73d58358..d5fa8a530a 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -2492,6 +2492,63 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
> >      cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
> >  }
> >  
> > +static void qmp_cxl_process_dynamic_capacity_tag_based(const char *path,
> > +        uint16_t hid, CXLDCEventType type, uint8_t rid, const char *tag,
> > +        CxlDynamicCapacityExtentList *records, Error **errp)
> > +{
> > +    Object *obj;
> > +    CXLType3Dev *dcd;
> > +    CXLDCExtentList *list = NULL;
> > +    CXLDCExtent *ent;
> > +    g_autofree CXLDCExtentRaw *extents = NULL;
> > +
> > +    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
> > +    if (!obj) {
> > +        error_setg(errp, "Unable to resolve CXL type 3 device");
> > +        return;
> > +    }
> > +
> > +    dcd = CXL_TYPE3(obj);
> > +    if (!dcd->dc.num_regions) {
> > +        error_setg(errp, "No dynamic capacity support from the device");
> > +        return;
> > +    }
> > +
> > +    if (rid >= dcd->dc.num_regions) {
> > +        error_setg(errp, "region id is too large");
> > +        return;
> > +    }
> > +
> > +    QemuUUID uuid_req;
> > +    qemu_uuid_parse(tag, &uuid_req);
> > +
> > +    list = &dcd->dc.extents;
> > +    size_t cap = 8, n = 0;
> > +    extents = g_new0(CXLDCExtentRaw, cap);
> > +    QTAILQ_FOREACH(ent, list, node) {
> > +        QemuUUID uuid_ext;
> > +        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
> > +        if (!qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
> > +            continue;
> > +        }
> > +
> > +        if (n == cap) {
> > +            cap *= 2;
> > +            extents = g_renew(CXLDCExtentRaw, extents, cap);
> > +        }
> > +
> > +        extents[n++] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
> > +                                         .len = ent->len,
> > +                                         .shared_seq = 0 };  
> 	extents[n] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
>                                        .len = ent->len,
>                                        .shared_seq = 0 };
>         memcpy(extents[n].tag, uuid_ext.data, 0x10);
>         n++;
> 
> That should fix the issue I was talking about earlier in the other thread haha
> (I tested it this time)
> > +    }
> > +
> > +    if (n == 0) {
> > +        return;
> > +    }
> > +    extents = g_renew(CXLDCExtentRaw, extents, n);
> > +    cxl_create_dc_event_records_for_extents(dcd, type, extents, n);
> > +}
> > +
> >  void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
> >                                    CxlExtentSelectionPolicy sel_policy,
> >                                    uint8_t region, const char *tag,
> > @@ -2537,6 +2594,10 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
> >                                                        region, tag,
> >                                                        extents, errp);
> >          return;
> > +    case CXL_EXTENT_REMOVAL_POLICY_TAG_BASED:
> > +        qmp_cxl_process_dynamic_capacity_tag_based(path, host_id, type, region,
> > +                                                   tag, extents, errp);
> > +        return;
> >      default:
> >          error_setg(errp, "Removal policy not supported");
> >          return;
> > -- 
> > 2.50.1 (Apple Git-155)
> >   
> 

