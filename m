Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182271B50
	for <linux-cxl@vger.kernel.org>; Mon, 15 Apr 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204056; cv=none; b=olhNRHJDvXS1viYmoDIUH4ZKLOwkvSR48DgclAd+LxL8pDSlLTG4FX/3SkaV1svRZm4jnv9WNQOSClmvPesxIzqkm4ARCrofNhNMbEBqfWxLWrLnRbzjo3TpulHLIpG7ro/41w7ebBdHiyMIk+GbL6AwH2NNBejjntdXJ9xFlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204056; c=relaxed/simple;
	bh=0vGyzGIYXYPhMEH/CDHoFN4wFsIZ7ZqwXcM1ZEZHXy4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjWUGD+yUVsLIpwxrWkdfs8Fq+Smw7MJ/H5fUrC0e6josXdtLqfhuszVNRDWN7Z2ESwzIxzt3iEaZjTKvzxmZE1N3p+har9y7R74ZVYHvXbaJnmbPk+4Ux6GTOw/l8hv+3XQPrJ8RESZeNqymIad1cdRPIB7WP924UgHb10NmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnB7XQXJ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnB7XQXJ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dd161eb03afso3042908276.0
        for <linux-cxl@vger.kernel.org>; Mon, 15 Apr 2024 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713204053; x=1713808853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9SHlQYOrKadYFFqj8IdjVh6W2gHkeHd0dZRCNv995cQ=;
        b=SnB7XQXJUCJUKjiwd8uySecCr0ucPOYG2O0E3ujT4ftEPvCsNqPjVIa5xPTAi8jBuD
         EYHfvCjbNz6acGTkZdUsrf0De/XWJAGYuI1Irabh9qDAGCRUgGUPTcuAffXFEmsfhqvn
         965dX2Ti2rQicPksp0CjndWhmugjfV85T6lXcIHL6TkQ89D+DnGUqbMWMaVKX2a7HVTo
         qX1G7G8UiRC1dt7Z2oqKMx8HWbGC9JpJrt5Ym1U7QKvUN5+/8EB4HnpNVk5tObhf6viM
         E+9M2u/hxzBkECeeEzM3HeFY189ynUGiUFE88F2uL3cDiI3SxtN+2scBg/p7Qbyhz5uz
         AYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713204053; x=1713808853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SHlQYOrKadYFFqj8IdjVh6W2gHkeHd0dZRCNv995cQ=;
        b=fKWXra+fQXN7jYw6HBu38pfFouRy+r7VNWEYqUzHTMDsW8E4WCUF98SeDNbhQc/jom
         wakiQmDqvZC8x31QQJ7gO9197IHUjz5QyPULJDkDhaXBGj8x5KNLkS6JiiTMK2wXKuf/
         IgrTQ1zIek42wnS2xJZ46nwCZNXOs6e7Vq7m9hS8/x8pxLjyA2em9hduETCGzeEHX3sK
         Wf7KCDqR/Mk9SLSIKMaRaxdaKFj0QQAhFBdwkdzi+mHaGvcSZkhH0pMMEx5HFlsVUD6N
         Ribgs5gBBEjyMVcR1Ptl3jOzk7ddOMYRrQerNbn4SJR1AdBRC+goF8Zs+O6qRO9niRfz
         nlgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDQZ47aQGUFUjqtuT9QQMGWgs/jpf+ewua3h36ID1+MHrtMSgZ4/9n24FqkiSkAEvDZO9CzBetUlyyTwms1V8xd27jd8m2gnf4
X-Gm-Message-State: AOJu0YzC000jB7FuOLK50XBy9RBbPXkiS/bRvCreCDqgVoCIMdRgBrxd
	RErZ9nisOtKVo0fIthNkFtebSVQJRpl0B12PrXCs6GtVIxODWfdv
X-Google-Smtp-Source: AGHT+IGSLuU/lplM3sXjIrNtofS1EEfIB0EmnQ182i2tAJvyuM36OVG9VdsOy6XxUsBeWoJ3g21/kQ==
X-Received: by 2002:a5b:87:0:b0:de0:d2fe:d499 with SMTP id b7-20020a5b0087000000b00de0d2fed499mr9319350ybp.21.1713204052961;
        Mon, 15 Apr 2024 11:00:52 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id r8-20020a25b988000000b00dce0f2db9acsm2064701ybg.34.2024.04.15.11.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:00:52 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 15 Apr 2024 11:00:50 -0700
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 08/12] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <Zh1rUjl2zjAdh839@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-9-nifan.cxl@gmail.com>
 <9e4207aa-be50-40ca-9fda-30e4fabf6e98@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e4207aa-be50-40ca-9fda-30e4fabf6e98@wdc.com>

On Thu, Apr 04, 2024 at 01:32:23PM +0000, Jørgen Hansen wrote:
> On 3/25/24 20:02, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per CXL spec 3.1, two mailbox commands are implemented:
> > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> > Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> > 
> > For the process of the above two commands, we use two-pass approach.
> > Pass 1: Check whether the input payload is valid or not; if not, skip
> >          Pass 2 and return mailbox process error.
> > Pass 2: Do the real work--add or release extents, respectively.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 433 +++++++++++++++++++++++++++++++++++-
> >   hw/mem/cxl_type3.c          |  11 +
> >   include/hw/cxl/cxl_device.h |   4 +
> >   3 files changed, 444 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 30ef46a036..a9eca516c8 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -19,6 +19,7 @@
> >   #include "qemu/units.h"
> >   #include "qemu/uuid.h"
> >   #include "sysemu/hostmem.h"
> > +#include "qemu/range.h"
> > 
> >   #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >   #define CXL_DC_EVENT_LOG_SIZE 8
> > @@ -85,6 +86,8 @@ enum {
> >       DCD_CONFIG  = 0x48,
> >           #define GET_DC_CONFIG          0x0
> >           #define GET_DYN_CAP_EXT_LIST   0x1
> > +        #define ADD_DYN_CAP_RSP        0x2
> > +        #define RELEASE_DYN_CAP        0x3
> >       PHYSICAL_SWITCH = 0x51,
> >           #define IDENTIFY_SWITCH_DEVICE      0x0
> >           #define GET_PHYSICAL_PORT_STATE     0x1
> > @@ -1400,6 +1403,422 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> > 
> > +/*
> > + * Check whether any bit between addr[nr, nr+size) is set,
> > + * return true if any bit is set, otherwise return false
> > + */
> > +static bool test_any_bits_set(const unsigned long *addr, unsigned long nr,
> > +                              unsigned long size)
> > +{
> > +    unsigned long res = find_next_bit(addr, size + nr, nr);
> > +
> > +    return res < nr + size;
> > +}
> > +
> > +CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
> > +{
> > +    int i;
> > +    CXLDCRegion *region = &ct3d->dc.regions[0];
> > +
> > +    if (dpa < region->base ||
> > +        dpa >= region->base + ct3d->dc.total_capacity) {
> > +        return NULL;
> > +    }
> > +
> > +    /*
> > +     * CXL r3.1 section 9.13.3: Dynamic Capacity Device (DCD)
> > +     *
> > +     * Regions are used in increasing-DPA order, with Region 0 being used for
> > +     * the lowest DPA of Dynamic Capacity and Region 7 for the highest DPA.
> > +     * So check from the last region to find where the dpa belongs. Extents that
> > +     * cross multiple regions are not allowed.
> > +     */
> > +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> > +        region = &ct3d->dc.regions[i];
> > +        if (dpa >= region->base) {
> > +            if (dpa + len > region->base + region->len) {
> > +                return NULL;
> > +            }
> > +            return region;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +static void cxl_insert_extent_to_extent_list(CXLDCExtentList *list,
> > +                                             uint64_t dpa,
> > +                                             uint64_t len,
> > +                                             uint8_t *tag,
> > +                                             uint16_t shared_seq)
> > +{
> > +    CXLDCExtent *extent;
> > +
> > +    extent = g_new0(CXLDCExtent, 1);
> > +    extent->start_dpa = dpa;
> > +    extent->len = len;
> > +    if (tag) {
> > +        memcpy(extent->tag, tag, 0x10);
> > +    }
> > +    extent->shared_seq = shared_seq;
> > +
> > +    QTAILQ_INSERT_TAIL(list, extent, node);
> > +}
> > +
> > +void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> > +                                        CXLDCExtent *extent)
> > +{
> > +    QTAILQ_REMOVE(list, extent, node);
> > +    g_free(extent);
> > +}
> > +
> > +/*
> > + * CXL r3.1 Table 8-168: Add Dynamic Capacity Response Input Payload
> > + * CXL r3.1 Table 8-170: Release Dynamic Capacity Input Payload
> > + */
> > +typedef struct CXLUpdateDCExtentListInPl {
> > +    uint32_t num_entries_updated;
> > +    uint8_t flags;
> > +    uint8_t rsvd[3];
> > +    /* CXL r3.1 Table 8-169: Updated Extent */
> > +    struct {
> > +        uint64_t start_dpa;
> > +        uint64_t len;
> > +        uint8_t rsvd[8];
> > +    } QEMU_PACKED updated_entries[];
> > +} QEMU_PACKED CXLUpdateDCExtentListInPl;
> > +
> > +/*
> > + * For the extents in the extent list to operate, check whether they are valid
> > + * 1. The extent should be in the range of a valid DC region;
> > + * 2. The extent should not cross multiple regions;
> > + * 3. The start DPA and the length of the extent should align with the block
> > + * size of the region;
> > + * 4. The address range of multiple extents in the list should not overlap.
> > + */
> > +static CXLRetCode cxl_detect_malformed_extent_list(CXLType3Dev *ct3d,
> > +        const CXLUpdateDCExtentListInPl *in)
> > +{
> > +    uint64_t min_block_size = UINT64_MAX;
> > +    CXLDCRegion *region = &ct3d->dc.regions[0];
> > +    CXLDCRegion *lastregion = &ct3d->dc.regions[ct3d->dc.num_regions - 1];
> > +    g_autofree unsigned long *blk_bitmap = NULL;
> > +    uint64_t dpa, len;
> > +    uint32_t i;
> > +
> > +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +        region = &ct3d->dc.regions[i];
> > +        min_block_size = MIN(min_block_size, region->block_size);
> > +    }
> > +
> > +    blk_bitmap = bitmap_new((lastregion->base + lastregion->len -
> > +                             ct3d->dc.regions[0].base) / min_block_size);
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        region = cxl_find_dc_region(ct3d, dpa, len);
> > +        if (!region) {
> > +            return CXL_MBOX_INVALID_PA;
> > +        }
> > +
> > +        dpa -= ct3d->dc.regions[0].base;
> > +        if (dpa % region->block_size || len % region->block_size) {
> > +            return CXL_MBOX_INVALID_EXTENT_LIST;
> > +        }
> > +        /* the dpa range already covered by some other extents in the list */
> > +        if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
> > +            len / min_block_size)) {
> > +            return CXL_MBOX_INVALID_EXTENT_LIST;
> > +        }
> > +        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
> > +   }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +static CXLRetCode cxl_dcd_add_dyn_cap_rsp_dry_run(CXLType3Dev *ct3d,
> > +        const CXLUpdateDCExtentListInPl *in)
> > +{
> > +    uint32_t i;
> > +    CXLDCExtent *ent;
> > +    uint64_t dpa, len;
> > +    Range range1, range2;
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        range_init_nofail(&range1, dpa, len);
> > +
> > +        /*
> > +         * TODO: once the pending extent list is added, check against
> > +         * the list will be added here.
> > +         */
> > +
> > +        /* to-be-added range should not overlap with range already accepted */
> > +        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
> > +            range_init_nofail(&range2, ent->start_dpa, ent->len);
> > +            if (range_overlaps_range(&range1, &range2)) {
> > +                return CXL_MBOX_INVALID_PA;
> > +            }
> > +        }
> > +    }
> > +    return CXL_MBOX_SUCCESS;
> > +}
> 
> Instead of iterating over all new extents and all existing extents, 
> couldn't this be rolled into cxl_detect_malformed_extent_list - the 
> bitmap created there summarizes all ranges of the new extents, so you 
> can just check that the existing (and pending) extents don't overlap 
> with anything in the bitmap? Or allow the bitmap to be returned and used 
> for this check, since cxl_detect_malformed_extent_list is also used on 
> release, where things aren't as simple.
> 
> > +
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.3: Add Dynamic Capacity Response (Opcode 4802h)
> > + * An extent is added to the extent list and becomes usable only after the
> > + * response is processed successfully
> > + */
> > +static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> > +                                          uint8_t *payload_in,
> > +                                          size_t len_in,
> > +                                          uint8_t *payload_out,
> > +                                          size_t *len_out,
> > +                                          CXLCCI *cci)
> > +{
> > +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_SUCCESS;
> > +    }
> 
> The mailbox processing in patch 2 converts from le explicitly, whereas 
> the mailbox commands here don't. Looking at the existing mailbox 
> commands, convertion doesn't seem to be rigorously applied, so maybe 
> that is OK?
> 
> > +
> > +    /* Adding extents causes exceeding device's extent tracking ability. */
> > +    if (in->num_entries_updated + ct3d->dc.total_extent_count >
> > +        CXL_NUM_EXTENTS_SUPPORTED) {
> > +        return CXL_MBOX_RESOURCES_EXHAUSTED;
> > +    }
> > +
> > +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    ret = cxl_dcd_add_dyn_cap_rsp_dry_run(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > +        ct3d->dc.total_extent_count += 1;
> > +        /*
> > +         * TODO: we will add a pending extent list based on event log record
> > +         * and process the list according here.
> > +         */
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> > +/*
> > + * Copy extent list from src to dst
> > + * Return value: number of extents copied
> > + */
> > +static uint32_t copy_extent_list(CXLDCExtentList *dst,
> > +                                 const CXLDCExtentList *src)
> > +{
> > +    uint32_t cnt = 0;
> > +    CXLDCExtent *ent;
> > +
> > +    if (!dst || !src) {
> > +        return 0;
> > +    }
> > +
> > +    QTAILQ_FOREACH(ent, src, node) {
> > +        cxl_insert_extent_to_extent_list(dst, ent->start_dpa, ent->len,
> > +                                         ent->tag, ent->shared_seq);
> > +        cnt++;
> > +    }
> > +    return cnt;
> > +}
> > +
> > +static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
> > +        const CXLUpdateDCExtentListInPl *in)
> > +{
> > +    CXLDCExtent *ent, *ent_next;
> > +    uint64_t dpa, len;
> > +    uint32_t i;
> > +    int cnt_delta = 0;
> > +    CXLDCExtentList tmp_list;
> > +    CXLRetCode ret = CXL_MBOX_SUCCESS;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    QTAILQ_INIT(&tmp_list);
> > +    copy_extent_list(&tmp_list, &ct3d->dc.extents);
> > +
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        Range range;
> > +
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        while (len > 0) {
> > +            QTAILQ_FOREACH(ent, &tmp_list, node) {
> > +                range_init_nofail(&range, ent->start_dpa, ent->len);
> > +
> > +                if (range_contains(&range, dpa)) {
> > +                    uint64_t len1, len2, len_done = 0;
> > +                    uint64_t ent_start_dpa = ent->start_dpa;
> > +                    uint64_t ent_len = ent->len;
> > +                    /*
> > +                     * Found the exact extent or the subset of an existing
> > +                     * extent.
> > +                     */
> > +                    if (range_contains(&range, dpa + len - 1)) {
> > +                        len1 = dpa - ent->start_dpa;
> > +                        len2 = ent_start_dpa + ent_len - dpa - len;
> > +                        len_done = ent_len - len1 - len2;
> > +
> > +                        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> > +                        cnt_delta--;
> > +
> > +                        if (len1) {
> > +                            cxl_insert_extent_to_extent_list(&tmp_list,
> > +                                                             ent_start_dpa,
> > +                                                             len1, NULL, 0);
> > +                            cnt_delta++;
> > +                        }
> > +                        if (len2) {
> > +                            cxl_insert_extent_to_extent_list(&tmp_list,
> > +                                                             dpa + len,
> > +                                                             len2, NULL, 0);
> > +                            cnt_delta++;
> > +                        }
> > +
> > +                        if (cnt_delta + ct3d->dc.total_extent_count >
> > +                            CXL_NUM_EXTENTS_SUPPORTED) {
> > +                            ret = CXL_MBOX_RESOURCES_EXHAUSTED;
> > +                            goto free_and_exit;
> > +                        }
> > +                    } else {
> > +                        /*
> > +                         * TODO: we reject the attempt to remove an extent
> > +                         * that overlaps with multiple extents in the device
> > +                         * for now, we will allow it once superset release
> > +                         * support is added.
> > +                         */
> > +                        ret = CXL_MBOX_INVALID_PA;
> > +                        goto free_and_exit;
> > +                    }
> > +
> > +                    len -= len_done;
> > +                    /* len == 0 here until superset release is added */
> > +                    break;
> > +                }
> > +            }
> > +            if (len) {
> > +                ret = CXL_MBOX_INVALID_PA;
> > +                goto free_and_exit;
> > +            }
> > +        }
> > +    }
> > +free_and_exit:
> > +    QTAILQ_FOREACH_SAFE(ent, &tmp_list, node, ent_next) {
> > +        cxl_remove_extent_from_extent_list(&tmp_list, ent);
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (Opcode 4803h)
> > + */
> > +static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> > +                                          uint8_t *payload_in,
> > +                                          size_t len_in,
> > +                                          uint8_t *payload_out,
> > +                                          size_t *len_out,
> > +                                          CXLCCI *cci)
> > +{
> > +    CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    CXLDCExtent *ent;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    ret = cxl_detect_malformed_extent_list(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    ret = cxl_dc_extent_release_dry_run(ct3d, in);
> > +    if (ret != CXL_MBOX_SUCCESS) {
> > +        return ret;
> > +    }
> > +
> > +    /* From this point, all the extents to release are valid */
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        Range range;
> > +
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        while (len > 0) {
> > +            QTAILQ_FOREACH(ent, extent_list, node) {
> > +                range_init_nofail(&range, ent->start_dpa, ent->len);
> > +
> > +                /* Found the extent overlapping with */
> > +                if (range_contains(&range, dpa)) {
> > +                    uint64_t len1, len2 = 0, len_done = 0;
> > +                    uint64_t ent_start_dpa = ent->start_dpa;
> > +                    uint64_t ent_len = ent->len;
> > +
> > +                    len1 = dpa - ent_start_dpa;
> > +                    if (range_contains(&range, dpa + len - 1)) {
> > +                        len2 = ent_start_dpa + ent_len - dpa - len;
> > +                    }
> > +                    len_done = ent_len - len1 - len2;
> > +
> > +                    cxl_remove_extent_from_extent_list(extent_list, ent);
> > +                    ct3d->dc.total_extent_count -= 1;
> > +
> > +                    if (len1) {
> > +                        cxl_insert_extent_to_extent_list(extent_list,
> > +                                                         ent_start_dpa,
> > +                                                         len1, NULL, 0);
> > +                        ct3d->dc.total_extent_count += 1;
> > +                    }
> > +                    if (len2) {
> > +                        cxl_insert_extent_to_extent_list(extent_list,
> > +                                                         dpa + len,
> > +                                                         len2, NULL, 0);
> > +                        ct3d->dc.total_extent_count += 1;
> > +                    }
> > +
> > +                    len -= len_done;
> > +                    /*
> > +                     * len will always be 0 until superset release is add.
> > +                     * TODO: superset release will be added.
> > +                     */
> > +                    break;
> > +                }
> > +            }
> > +        }
> > +    }
> 
> The tmp_list generated in cxl_dc_extent_release_dry_run is identical to 
> the updated extent_list after the loops above - so you could swap the 
> existing extent_list with the tmp_list and adjust the number of extents 
> with the cnt_delta calculated, if the dry run is successful - instead of 
> duplicating the logic.
> 
> Thanks,
> Jørgen

Hi Jorgen and Jonathan,
Based on your feedback, I have simplified the code by reusing the
tmp_list.
I have redo the patch and all following and will share in this thread,
please help check if you have time.
I will send out the next full series if the change looks good to you.

Thanks,
Fan

> 
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >   #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >   #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >   #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1413,15 +1832,15 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >       [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
> >           cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
> >       [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
> > -                                      cmd_events_get_interrupt_policy, 0, 0 },
> > +        cmd_events_get_interrupt_policy, 0, 0 },
> >       [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
> > -                                      cmd_events_set_interrupt_policy,
> > -                                      ~0, IMMEDIATE_CONFIG_CHANGE },
> > +        cmd_events_set_interrupt_policy,
> > +        ~0, IMMEDIATE_CONFIG_CHANGE },
> >       [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
> >           cmd_firmware_update_get_info, 0, 0 },
> >       [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> >       [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
> > -                         8, IMMEDIATE_POLICY_CHANGE },
> > +        8, IMMEDIATE_POLICY_CHANGE },
> >       [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
> >                                 0, 0 },
> >       [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> > @@ -1450,6 +1869,12 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> >       [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
> >           "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
> >           8, 0 },
> > +    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
> > +        "DCD_ADD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> > +    [DCD_CONFIG][RELEASE_DYN_CAP] = {
> > +        "DCD_RELEASE_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> > +        ~0, IMMEDIATE_DATA_CHANGE },
> >   };
> > 
> >   static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 5be3c904ba..951bd79a82 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -678,6 +678,15 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >       return true;
> >   }
> > 
> > +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> > +{
> > +    CXLDCExtent *ent, *ent_next;
> > +
> > +    QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node, ent_next) {
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> > +    }
> > +}
> > +
> >   static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >   {
> >       DeviceState *ds = DEVICE(ct3d);
> > @@ -874,6 +883,7 @@ err_free_special_ops:
> >       g_free(regs->special_ops);
> >   err_address_space_free:
> >       if (ct3d->dc.host_dc) {
> > +        cxl_destroy_dc_regions(ct3d);
> >           address_space_destroy(&ct3d->dc.host_dc_as);
> >       }
> >       if (ct3d->hostpmem) {
> > @@ -895,6 +905,7 @@ static void ct3_exit(PCIDevice *pci_dev)
> >       cxl_doe_cdat_release(cxl_cstate);
> >       g_free(regs->special_ops);
> >       if (ct3d->dc.host_dc) {
> > +        cxl_destroy_dc_regions(ct3d);
> >           address_space_destroy(&ct3d->dc.host_dc_as);
> >       }
> >       if (ct3d->hostpmem) {
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 6aec6ac983..df3511e91b 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -551,4 +551,8 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d);
> > 
> >   void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
> > 
> > +CXLDCRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len);
> > +
> > +void cxl_remove_extent_from_extent_list(CXLDCExtentList *list,
> > +                                        CXLDCExtent *extent);
> >   #endif
> > --
> > 2.43.0
> > 
