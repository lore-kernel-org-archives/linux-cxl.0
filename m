Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7E5E08B
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748868; cv=none; b=VsCWTL4S++RhlUHi45kHuk2kLJBZpEBUXh7nY3jB4DRwzlKXsVXZhjDwbzwQXF1D6bVGgKisXjsPbIIXJjmES/ATgP/L8euW1F5550aLvKlTCa691mE1XPD1d1kqQ+aDUEqO/LPvjPZfGPLK0BoSjejCGR63Fg7IzTeLtr1EDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748868; c=relaxed/simple;
	bh=SovEYFz2HkkUmc+KIkKoC1dzLTIDsJodtHJeaJf/KzM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQPhL8EmWDIe/T4vkaEM0KzGoxNfPnc7jT4ld8SJF41huxacVBQ01v9uu1gPlKz5JNDXVqlHSTN6mVowQQZtNByvLUf/DzPQhaCulY67II8JBAuqkhffyIl5odP4wFeJ4d8ly1JDEjs4cAOGqd/Qrw6Tg+/7d2gK/Est0NebsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqgYq3yHfz6J9Tw;
	Thu,  7 Mar 2024 02:14:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 56AB61400D7;
	Thu,  7 Mar 2024 02:14:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 18:14:23 +0000
Date: Wed, 6 Mar 2024 18:14:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 12/13] hw/mem/cxl_type3: Allow to release partial
 extent and extent superset in QMP interface
Message-ID: <20240306181422.00002b75@Huawei.com>
In-Reply-To: <20240304194331.1586191-13-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-13-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  4 Mar 2024 11:34:07 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Before the change, the QMP interface used for add/release DC extents
> only allows to release extents that exist in either pending-to-add list
> or accepted list in the device, which means the DPA range of the extent must
> match exactly that of an extent in either list. Otherwise, the release
> request will be ignored.
> 
> With the change, we relax the constraints. As long as the DPA range of the
> extent to release is covered by extents in one of the two lists
> mentioned above, we allow the release.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Run out of time today,  so just took a very quick look at this.

Seemed fine but similar comments on exit conditions and retry gotos as
earlier patches.

> +/*
> + * Remove all extents whose DPA range has overlaps with  the DPA range
> + * [dpa, dpa + len) from the list, and delete the overlapped portion.
> + * Note:
> + * 1. If the removed extents is fully within the DPA range, delete the extent;
> + * 2. Otherwise, keep the portion that does not overlap, insert new extents to
> + * the list if needed for the un-coverlapped part.
> + */
> +static void cxl_delist_extent_by_dpa_range(CXLDCExtentList *list,
> +                                           uint64_t dpa, uint64_t len)
> +{
> +    CXLDCExtent *ent;
>  
> -    return NULL;
> +process_leftover:

As before can we turn this into a while loop so the exit conditions are 
more obvious?  Based on len I think.


> +    QTAILQ_FOREACH(ent, list, node) {
> +        if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
> +            uint64_t ent_start_dpa = ent->start_dpa;
> +            uint64_t ent_len = ent->len;
> +            uint64_t len1 = dpa - ent_start_dpa;
> +
> +            cxl_remove_extent_from_extent_list(list, ent);
> +            if (len1) {
> +                cxl_insert_extent_to_extent_list(list, ent_start_dpa,
> +                                                 len1, NULL, 0);
> +            }
> +
> +            if (dpa + len <= ent_start_dpa + ent_len) {
> +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> +                if (len2) {
> +                    cxl_insert_extent_to_extent_list(list, dpa + len,
> +                                                     len2, NULL, 0);
> +                }
> +            } else {
> +                len = dpa + len - ent_start_dpa - ent_len;
> +                dpa = ent_start_dpa + ent_len;
> +                goto process_leftover;
> +            }
> +        }
> +    }
>  }
>  
>  /*
> @@ -1915,8 +1966,8 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
>      list = records;
>      extents = g_new0(CXLDCExtentRaw, num_extents);
>      while (list) {
> -        CXLDCExtent *ent;
>          bool skip_extent = false;
> +        CXLDCExtentList *extent_list;
>  
>          offset = list->value->offset;
>          len = list->value->len;
> @@ -1933,15 +1984,32 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
>               * remove it from the pending extent list, so later when the add
>               * response for the extent arrives, the device can reject the
>               * extent as it is not in the pending list.
> +             * Now, we can handle the case where the extent covers the DPA

No need for Now. Anyone reading it is look at the cod here.

> +             * range of multiple extents in the pending_to_add list.
> +             * TODO: we do not allow the extent covers range of extents in
> +             * pending_to_add list and accepted list at the same time for now.
>               */
> -            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> -                        &extents[i]);
> -            if (ent) {
> -                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> -                g_free(ent);
> +            extent_list = &dcd->dc.extents_pending_to_add;
> +            if (cxl_test_dpa_range_covered_by_extents(extent_list,
> +                                                      extents[i].start_dpa,
> +                                                      extents[i].len)) {
> +                cxl_delist_extent_by_dpa_range(extent_list,
> +                                               extents[i].start_dpa,
> +                                               extents[i].len);
> +            } else if (!ct3_test_region_block_backed(dcd, extents[i].start_dpa,
> +                                                     extents[i].len)) {
> +                /*
> +                 * If the DPA range of the extent is not covered by extents
> +                 * in the accepted list, skip
> +                 */
>                  skip_extent = true;
> -            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> -                /* If the exact extent is not in the accepted list, skip */
> +            }
> +        } else if (type == DC_EVENT_ADD_CAPACITY) {
> +            extent_list = &dcd->dc.extents;
> +            /* If the extent is ready pending to add, skip */
> +            if (cxl_test_dpa_range_covered_by_extents(extent_list,
> +                                                      extents[i].start_dpa,
> +                                                      extents[i].len)) {
>                  skip_extent = true;
>              }
>          }

