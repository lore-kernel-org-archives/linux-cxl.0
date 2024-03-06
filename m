Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA0D137C29
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748593; cv=none; b=Tn5p8Ya3gjS6lGLzgGqIC3zkhFpff1OGBQO+nI4J+wqShFaCA9hXj0oWVHhD2BQYDUp0kZ9AgxG2//tkP1fYqpr93GbYxChYa7OOZhUqkf5X04BwPxbkUyYUzmHofPnF9RqmgoGVhfJoCkUDKASBfEC/pkbFzeeAi1uulMUqRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748593; c=relaxed/simple;
	bh=jOEx6fi2aELFIATPmRVs5Fzfs7ssQDh+pSpvmYwvC4M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3o3RaQrz9XLoLk76vN6fwCnx7/5Xf9g7HIX8ZJ5wV9lIKwqiPP5wBxGg4EUtV25Qm4R6Zfb9fA+mAhfk5CyU35gsNUC1KFwS1TAgJiwr/LTK3FQG9pNDAjjP0re1UV9IQ8NZqWb7lkOM6UJOS6IEDAu1bLXmbVp6I9mkRSvbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqgSV6Vv1z6J9h6;
	Thu,  7 Mar 2024 02:09:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AE37F14111D;
	Thu,  7 Mar 2024 02:09:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 18:09:47 +0000
Date: Wed, 6 Mar 2024 18:09:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 11/13] hw/cxl/cxl-mailbox-utils: Add partial and
 superset extent release mailbox support
Message-ID: <20240306180946.00005161@Huawei.com>
In-Reply-To: <20240304194331.1586191-12-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-12-nifan.cxl@gmail.com>
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

On Mon,  4 Mar 2024 11:34:06 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, we extend the extent release mailbox command processing
> to allow more flexible release. As long as the DPA range of the extent to
> release is covered by valid extent(s) in the device, the release can be
> performed.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Ouch this is more complex than I was thinking, but seems correct to me.

A few minor comments inline

Jonathan

> +/*
> + * Detect potential extent overflow caused by extent split during processing
> + * extent release requests, also allow releasing superset of extents where the
> + * extent to release covers the range of multiple extents in the device.
> + * Note:
> + * 1.we will reject releasing an extent if some portion of its rang is

range

> + * not covered by valid extents.
> + * 2.This function is called after cxl_detect_malformed_extent_list so checks
> + * already performed there will be skipped.
> + */
> +static CXLRetCode cxl_detect_extent_overflow(const CXLType3Dev *ct3d,
> +        const CXLUpdateDCExtentListInPl *in)

This code is basically dry running the actual removal.  Can we just
make the core code the same for both cases?  The bit where you update bitmaps
and extent lists at least.

> +{
> +    uint64_t nbits, offset;
> +    const CXLDCRegion *region;
> +    unsigned long **bitmaps_copied;
> +    uint64_t dpa, len;
> +    int i, rid;
> +    CXLRetCode ret = CXL_MBOX_SUCCESS;
> +    long extent_cnt_delta = 0;
> +    CXLDCExtentList tmp_list;
> +    CXLDCExtent *ent;
> +
> +    QTAILQ_INIT(&tmp_list);
> +    copy_extent_list(&tmp_list, &ct3d->dc.extents);
> +
> +    bitmaps_copied = g_new0(unsigned long *, ct3d->dc.num_regions);
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        nbits = region->len / region->block_size;
> +        bitmaps_copied[i] = bitmap_new(nbits);
> +        bitmap_copy(bitmaps_copied[i], region->blk_bitmap, nbits);
> +    }
> +
> +    for (i = 0; i < in->num_entries_updated; i++) {
> +        dpa = in->updated_entries[i].start_dpa;
> +        len = in->updated_entries[i].len;
> +
> +        rid = cxl_find_dc_region_id(ct3d, dpa, len);
> +        region = &ct3d->dc.regions[rid];
> +        offset = (dpa - region->base) / region->block_size;
> +        nbits = len / region->block_size;
> +
> +        /* Check whether range [dpa, dpa + len) is covered by valid range */
> +        if (find_next_zero_bit(bitmaps_copied[rid], offset + nbits, offset) <
> +                               offset + nbits) {
> +            ret = CXL_MBOX_INVALID_PA;
> +            goto free_and_exit;
> +        }
> +
> +        QTAILQ_FOREACH(ent, &tmp_list, node) {
> +            /* Only split within an extent can cause extent count increase */
> +            if (ent->start_dpa <= dpa &&
> +                dpa + len <= ent->start_dpa + ent->len) {
> +                uint64_t ent_start_dpa = ent->start_dpa;
> +                uint64_t ent_len = ent->len;
> +                uint64_t len1 = dpa - ent_start_dpa;
> +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> +
> +                extent_cnt_delta += len1 && len2 ? 2 : (len1 || len2 ? 1 : 0);
I think this is the same as

		if (len1)
			extent_cnt_delta++;
		if (len2)
			extent_cnt_delta++;
		extent_cnt_delta--;



> +                extent_cnt_delta -= 1;
> +                if (ct3d->dc.total_extent_count + extent_cnt_delta >
> +                    CXL_NUM_EXTENTS_SUPPORTED) {

This early overflow detect seems valid to me because a device might run
out or resource mid processing the list even if it would fit at the end.
Good.
> +                    ret = CXL_MBOX_RESOURCES_EXHAUSTED;
> +                    goto free_and_exit;
> +                }
> +
> +                offset = (ent->start_dpa - region->base) / region->block_size;
> +                nbits = ent->len / region->block_size;
> +                bitmap_clear(bitmaps_copied[rid], offset, nbits);
> +                cxl_remove_extent_from_extent_list(&tmp_list, ent);
> +
> +                 if (len1) {
> +                    offset = (dpa - region->base) / region->block_size;
> +                    nbits = len1 / region->block_size;
> +                    bitmap_set(bitmaps_copied[rid], offset, nbits);
> +                    cxl_insert_extent_to_extent_list(&tmp_list,
> +                                                     ent_start_dpa, len1,
> +                                                     NULL, 0);
> +                 }
> +
> +                 if (len2) {
> +                    offset = (dpa + len - region->base) / region->block_size;
> +                    nbits = len2 / region->block_size;
> +                    bitmap_set(bitmaps_copied[rid], offset, nbits);
> +                    cxl_insert_extent_to_extent_list(&tmp_list, dpa + len,
> +                                                     len2, NULL, 0);
> +                 }
> +                 break;
> +             }
> +         }
> +    }
> +
> +free_and_exit:
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        g_free(bitmaps_copied[i]);
> +    }
> +    g_free(bitmaps_copied);
> +
> +    while (!QTAILQ_EMPTY(&tmp_list)) {
> +        ent = QTAILQ_FIRST(&tmp_list);
> +        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> +    }
> +
> +    return ret;
> +}
> +
>  /*
>   * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (Opcode 4803h)
>   */
> @@ -1644,15 +1793,28 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>          return ret;
>      }
>  
> -    for (i = 0; i < in->num_entries_updated; i++) {
> -        bool found = false;
> +    ret = cxl_detect_extent_overflow(ct3d, in);
> +    if (ret != CXL_MBOX_SUCCESS) {
> +        return ret;
> +    }
>  
> +    /*
> +     * After this point, it is guaranteed that the extents in the
> +     * updated extent list to release is valid, that means:
> +     * 1. All extents in the list have no overlaps;
> +     * 2. Each extent belongs to a valid DC region;
> +     * 3. The DPA range of each extent is covered by valid extent
> +     * in the device.
> +     */
> +    for (i = 0; i < in->num_entries_updated; i++) {
>          dpa = in->updated_entries[i].start_dpa;
>          len = in->updated_entries[i].len;
>  
> +process_leftover:
>          QTAILQ_FOREACH(ent, extent_list, node) {
>              /* Found the extent overlapping with */
>              if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
> +                /* Case 1: The to-release extent is subset of ent */
>                  if (dpa + len <= ent->start_dpa + ent->len) {
>                      /*
>                       * The incoming extent covers a portion of an extent
> @@ -1669,17 +1831,6 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>                      uint64_t len1 = dpa - ent_start_dpa;
>                      uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
>  
> -                    /*
> -                     * TODO: checking for possible extent overflow, will be
> -                     * moved into a dedicated function of detecting extent
> -                     * overflow.
> -                     */
> -                    if (len1 && len2 && ct3d->dc.total_extent_count ==
> -                        CXL_NUM_EXTENTS_SUPPORTED) {
> -                        return CXL_MBOX_RESOURCES_EXHAUSTED;
> -                    }
> -
> -                    found = true;
>                      cxl_remove_extent_from_extent_list(extent_list, ent);
>                      ct3d->dc.total_extent_count -= 1;
>                      ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
> @@ -1700,20 +1851,34 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>                      break;
>                  } else {
>                      /*
> -                     * TODO: we reject the attempt to remove an extent that
> -                     * overlaps with multiple extents in the device for now,
> -                     * once the bitmap indicating whether a DPA range is
> -                     * covered by valid extents is introduced, will allow it.
> +                     * Case 2: the to-release extent overlaps with multiple
> +                     * extents, including the superset case
>                       */
> -                    return CXL_MBOX_INVALID_PA;
> +                    uint64_t ent_start_dpa = ent->start_dpa;
> +                    uint64_t ent_len = ent->len;
> +                    uint64_t len1 = dpa - ent_start_dpa;
> +
> +                    cxl_remove_extent_from_extent_list(extent_list, ent);
> +                    ct3d->dc.total_extent_count -= 1;
> +                    ct3_clear_region_block_backed(ct3d, ent_start_dpa, ent_len);
> +
> +                    if (len1) {
> +                        cxl_insert_extent_to_extent_list(extent_list,
> +                                                         ent_start_dpa, len1,
> +                                                         NULL, 0);
> +                        ct3d->dc.total_extent_count += 1;
> +                        ct3_set_region_block_backed(ct3d, ent_start_dpa, len1);
> +                    }
> +                    /*
> +                     * processing the portion of the range following current
> +                     * extent

> +                     */
> +                    len = dpa + len - ent_start_dpa - ent_len;
> +                    dpa = ent_start_dpa + ent_len;
> +                    goto process_leftover;

I'd slightly prefer a while loop I think based on len > 0
It does add indent, but easier to follow for me than a retry type goto.


>                  }
>              }
>          }
> -
> -        if (!found) {
> -            /* Try to remove a non-existing extent. */
> -            return CXL_MBOX_INVALID_PA;
> -        }
>      }
>  
>      return CXL_MBOX_SUCCESS;

