Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F141B7EB
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764513; cv=none; b=MAVIQnNKLfcI5SEUQeyItwpX9j1afd1AgWb5QCWGLumKhRTKy+TCZQmTXXfmgLQVUZ1TvKMrkHvF5Rllja0Gmh8A2AMu8Doi2e5zPAsQzh3TZlbCBtUxOPN6pgMs8U0lr/VAnOeFd+/fg3H5dRzQE8QHShYOceOiEtELxN3EYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764513; c=relaxed/simple;
	bh=HsmulMEPAvdAIQuNiSfPJ24+BPWGRvIYfbiGtycc1j8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0JhadiFjJt8llmVS5tAodI6WZmKUQQC99k9nOGXhBKtJ1bp5zaXpLWsK7JibmgodaKC/3rGEOSAElOtK2KPrbWgKAIG7NsunykzdC74Ns//d700ZOnRL6J7PLbzND5aDBIWTy0W9gWLZxf6xQvFAROpaPFQN50y3r+Z6r7jpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b++sfbPB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b++sfbPB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc49b00bdbso2131985ad.3
        for <linux-cxl@vger.kernel.org>; Wed, 06 Mar 2024 14:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709764510; x=1710369310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj0jhNByro2+q/l5aUmsOObEqW6klnNrWZXeSjKkvwQ=;
        b=b++sfbPBMENohfnkc8MsT0g8GDiTmqBMMmMZz5wGYvpllb6BxzrAtvqs4E+idgOot/
         w+EslWWrhb4bAaFWW2JOYPvNdOCfCGfV4zb7Qkczd0pc4xNvTwMBSgepCf4pZbA1a9M+
         p+uF7vU/5Xzgp3j7wH39+ZMvGTt0Ua3rhkEkcQezLZ7yUXeBLTjJUnsrezkbSPNWM5Xs
         2vOeyLmSj580oBbHg6OY2VUxr/TzuoLJMFKZSO8bxdT/8KKmu0nD/KqjYaZuiq/5vSJ4
         wUGkQvvFSPChuaY7uSm8nnhcSwC3NXTAdYjmJz0jUAQRDnYCVbwI2CpVg4CXRCMtEXT8
         JP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764510; x=1710369310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj0jhNByro2+q/l5aUmsOObEqW6klnNrWZXeSjKkvwQ=;
        b=iXResvcF6W+CvSgGVA8FLyXyONvwi1GoHL1BtQX9bgZccJijVPh8mJSBzwqgPDge6O
         cVCz73CzVC2yAYJUHfDqTFrDmtwJ+cCFH4eR8Q/qcssFSocZdlHBe3QP44abcBDPeV13
         iUP8pT2iePB5iFcQJKP1TJVQFlJuFRYQvOK6RuXUa7GGWjNW6Ovx8diWVNFZB/5LuoLr
         DWvYIslDdwxXX2lkjdfa3UHeJnLH6VyDTvGoGvs5KdjU5UUvh+QiEusTNfxTfj6pbolg
         IpJCoh5JFmdWGXdLQMci7O0DFrqTtJnieOJHD6KPXWiOJhRZyaYzGBIjLNb0/MTvoV68
         KY3g==
X-Forwarded-Encrypted: i=1; AJvYcCUkINN5RsQxvDUw3h15AA518lWKEoE0p/JqXz833llwev3CPgrS/hO5R6XlFFsmH9N33fhgAqdRndNExTzZNOPDh0oa3joguDDL
X-Gm-Message-State: AOJu0Yxihv6vctktsyGiuU0m3nM72skydK7KUpDoiLZQA9GvV+J5ne7q
	7nKtsYUjlI7eMaHW5RJfsqip/mZvd+ltL5BjJ4htBrGTUfumQBTmB2UikT+i
X-Google-Smtp-Source: AGHT+IFNycZBifwIHxK/A4pdXVTSq6+yaJyXfbxqRUcjj8jrdbvqXHpDgLrbfRVjlcq90rKx65db0g==
X-Received: by 2002:a17:903:41c3:b0:1dc:d515:78db with SMTP id u3-20020a17090341c300b001dcd51578dbmr7769779ple.58.1709764510118;
        Wed, 06 Mar 2024 14:35:10 -0800 (PST)
Received: from debian ([2601:641:300:14de:57cf:345:75f0:2085])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902dacc00b001dce6c481c1sm11520432plx.301.2024.03.06.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:35:09 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 6 Mar 2024 14:34:50 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 08/13] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <ZejvipUwjO-ZRT6y@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-9-nifan.cxl@gmail.com>
 <20240306172827.000052dc@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306172827.000052dc@Huawei.com>

On Wed, Mar 06, 2024 at 05:28:27PM +0000, Jonathan Cameron wrote:
> On Mon,  4 Mar 2024 11:34:03 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per CXL spec 3.1, two mailbox commands are implemented:
> > Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> > Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Hmm. So I had a thought which would work for what you
> have here. See include/qemu/range.h
> I like the region merging stuff that is also in the list operators
> but we shouldn't use that because we have other reasons not to
> fuse ranges (sequence numbering etc)
> 
> We could make an extent a wrapper around a struct Range though
> so that we can use the comparison stuff directly.
> + we can use the list manipulation in there as the basis for a future
> extent merging infrastructure that is tag and sequence number (if
> provided - so shared capacity or pmem) aware.
> 
> Jonathan
> 
> 
> > ---
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
> 
> Hmm. Interesting.  I was thinking a given add / remove command rather than
> just the extents can't overlap a region.  However I can't find text on that
> so I believe your interpretation is correct. It is only specified for the
> event records, but that is good enough I think.  We might want to propose
> tightening the spec on this to allow devices to say no to such complex
> extent lists. Maybe a nice friendly Memory vendor should query this one if
> it's a potential problem for real devices.  Might not be!
> 
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
> > +    CXLDCExtent *ent;
> > +    uint32_t i;
> > +    uint64_t dpa, len;
> > +    CXLRetCode ret;
> > +
> > +    if (in->num_entries_updated == 0) {
> > +        return CXL_MBOX_SUCCESS;
> > +    }
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
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        /*
> > +         * Check if the DPA range of the to-be-added extent overlaps with
> > +         * existing extent list maintained by the device.
> > +         */
> > +        QTAILQ_FOREACH(ent, extent_list, node) {
> 
> There are too many checks in here for an overlapping test.
> 
> Conditions are
> 
> 	|  Extent tested against |
> |  Overlap entirely                 |
> | overlap left edge |
>                     | overlap right edge |
> Think of it in the inverse condition and it is easier to reason about.
> 
>               | Extent tested against |
> | to left |---                        ---| to right |
> 
> which I think is something like.
> 
>         if (!((dpa + len <= ent->start_dpa) || (dpa >= ent->start_dpa + ent->len)) {
> 		 return CXL_MBOX_INVALID_PA;
> 	}
> 
> Hmm. For internal tracking (not the exposed values) we should probably use
> struct range from include/qemu/range.h.
> Felt like there had to be something better than doing this ourselves so I went
> looking.  Note it uses inclusive upper bound so be careful with that!
> 
> Advantage is we get this checks for free.
> https://elixir.bootlin.com/qemu/latest/source/include/qemu/range.h#L152
> range_overlaps_range()
> 
> There are functions to set them up nicely for us and by base and size
> as well which should tidy that part up.
> 
> 	    
> 
> > +            if (ent->start_dpa <= dpa &&
> > +                    dpa + len <= ent->start_dpa + ent->len) {
> > +                return CXL_MBOX_INVALID_PA;
> > +            /* Overlapping one end of the other */
> > +            } else if ((dpa < ent->start_dpa + ent->len &&
> > +                        dpa + len > ent->start_dpa + ent->len) ||
> > +                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> > +                return CXL_MBOX_INVALID_PA;
> > +            }
> > +        }
> > +
> > +        /*
> > +         * TODO: we will add a pending extent list based on event log record
> > +         * and verify the input response; also, the "More" flag is not
> > +         * considered at the moment.
> > +         */
> > +
> > +        cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > +        ct3d->dc.total_extent_count += 1;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
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
> > +    for (i = 0; i < in->num_entries_updated; i++) {
> > +        bool found = false;
> > +
> > +        dpa = in->updated_entries[i].start_dpa;
> > +        len = in->updated_entries[i].len;
> > +
> > +        QTAILQ_FOREACH(ent, extent_list, node) {
> > +            /* Found the extent overlapping with */
> > +            if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
> > +                if (dpa + len <= ent->start_dpa + ent->len) {
> > +                    /*
> > +                     * The incoming extent covers a portion of an extent
> > +                     * in the device extent list, remove only the overlapping
> > +                     * portion, meaning
> > +                     * 1. the portions that are not covered by the incoming
> > +                     *    extent at both end of the original extent will become
> > +                     *    new extents and inserted to the extent list; and
> > +                     * 2. the original extent is removed from the extent list;
> > +                     * 3. DC extent count is updated accordingly.
> > +                     */
> > +                    uint64_t ent_start_dpa = ent->start_dpa;
> > +                    uint64_t ent_len = ent->len;
> > +                    uint64_t len1 = dpa - ent_start_dpa;
> > +                    uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> > +
> > +                    /*
> > +                     * TODO: checking for possible extent overflow, will be
> > +                     * moved into a dedicated function of detecting extent
> > +                     * overflow.
> > +                     */
> > +                    if (len1 && len2 && ct3d->dc.total_extent_count ==
> > +                        CXL_NUM_EXTENTS_SUPPORTED) {
> > +                        return CXL_MBOX_RESOURCES_EXHAUSTED;
> > +                    }
> > +
> > +                    found = true;
> > +                    cxl_remove_extent_from_extent_list(extent_list, ent);
> > +                    ct3d->dc.total_extent_count -= 1;
> > +
> > +                    if (len1) {
> > +                        cxl_insert_extent_to_extent_list(extent_list,
> > +                                                         ent_start_dpa, len1,
> > +                                                         NULL, 0);
> > +                        ct3d->dc.total_extent_count += 1;
> > +                    }
> > +                    if (len2) {
> > +                        cxl_insert_extent_to_extent_list(extent_list, dpa + len,
> > +                                                         len2, NULL, 0);
> > +                        ct3d->dc.total_extent_count += 1;
> > +                    }
> > +                    break;
> Maybe this makes sense after the support below is added, but at this
> point in the series 
> 			return CXL_MBOX_SUCCESS;
> then found isn't relevant so can drop that. Looks like you drop it later in the
> series anyway.
> 
> > +                } else {
> > +                    /*
> > +                     * TODO: we reject the attempt to remove an extent that
> > +                     * overlaps with multiple extents in the device for now,
> > +                     * once the bitmap indicating whether a DPA range is
> > +                     * covered by valid extents is introduced, will allow it.
> > +                     */
> > +                    return CXL_MBOX_INVALID_PA;
> > +                }
> > +            }
> > +        }
> > +
> > +        if (!found) {
> > +            /* Try to remove a non-existing extent. */
> > +            return CXL_MBOX_INVALID_PA;
> > +        }
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> 
> >  static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 102fa8151e..dccfaaad3a 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -678,6 +678,16 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >      return true;
> >  }
> >  
> > +static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
> > +{
> > +    CXLDCExtent *ent;
> > +
> > +    while (!QTAILQ_EMPTY(&ct3d->dc.extents)) {
> > +        ent = QTAILQ_FIRST(&ct3d->dc.extents);
> > +        cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
> 
> Isn't this same a something like.
>     QTAILQ_FOREACH_SAFE(ent, &ct3d->dc.extents, node)) {
> 	cxl_remove_extent_from_extent_list(&ct3d->dc.extents, ent);
>         //This wrapper is small enough I'd be tempted to just have the
>         //code inline at the places it's called.
> 
We will have more to release after we introduce pending list as well as
bitmap. Keep it?

Fan

>     }
> > +    }
> > +}
> 
