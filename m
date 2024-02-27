Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8044C61
	for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995703; cv=none; b=NHFOpMF6LbCyEiSpzUDUv5domlPA4U5vwccuzZn3OH3B0+MTXHAflF3yxz1EULQf8vWcM1b6kpejJtibQ9sbyd8ioPfldWVnbFm8kHplMjfWQ3CUVKFSdaf5+1ub7rVDkDL+9QiXlgorTYFfkaH/tkUbD5BVH4BFEi7Kf6/ughg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995703; c=relaxed/simple;
	bh=Tn7qLnljrFHffCqaZ4hSUj4fn/J5hD7xAXBHAvtcGzg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQPAL5xxcRjDOdeUDqMQisqC8YTNRc47IoTgRRaqdxUH3P5wlr4zsVz9YozeJuZ0O06b04L36W0kFBEjivG5wCu0RhtmoT63RtpKQNqgqNPNSpuWDT5gFPp2ZBjmHrl0oGV87gfL233xqAVw0IXojhQtO5zkGqqbcg0ip25BQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOt3KAhs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOt3KAhs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e4f49c5632so1075078b3a.0
        for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 17:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995701; x=1709600501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZDdKR41hFYtGH6CFmjj4eUOG/E7SO7Xv5k4ut6JPaQ=;
        b=eOt3KAhsL91rMudM4TZ3xpJze/Iz5TGTyviDqswtAEnAKEy2ImuCZLUWlniYl9LnNC
         wR1V6OhON1KkJlk0ffjSWKX2eC4aE0+tcVnm9e237iTrO7FWW7WlXfNWCy7lFqdRN2Ya
         AWHNC2nwj0wPpn+UPzjgeKX6g1KkSd3dyZzVRLF/MwxDcbkR/RD7MDL50F/oJYWOJo2k
         H/QWhS1hd1eR21tuVm/FTSyoKoiMXSJt59zLc28TOBSqu5GO/WJ7ME+6gto4obU9I9hg
         HKh6jGuq4JLUq9sTdMymDqDiyKB0j3CHEUCPvYoKqaEWuTI9IgAUeO2J4rYIQq22cnFt
         zVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995701; x=1709600501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZDdKR41hFYtGH6CFmjj4eUOG/E7SO7Xv5k4ut6JPaQ=;
        b=sRK3h3CifeAqRlTtLuGkUDGVpTZbVhfr+/2h3zDRDdiN6RoFQ/UYJ6FT3igfKVyj9K
         EEaZy3hJRF8XXsrL/8Qbnxn9X3Sq8i3kzE6be4yNRx+Yq27yj39MzZIZADlmZOklUQos
         JqjsQurPKKFSWDi5q4GlFATkK20Ag30YpE+6BL7ITBCYAzmH4P5f6W+uCSzGKB+y7AYz
         H7GIpit9LlTQiXIbR9n3U83CohY/hlSrj3p2oXTQ8H5UC/dNvq0yxr/nTwWWtNcB2HGw
         C1OpK7eMOT+AP5H9V8kWnwRqZNF0KSYVv7/J+qmJChb2XYMB+a4TgcyOkB3k//FjpvnX
         YsEw==
X-Forwarded-Encrypted: i=1; AJvYcCXN+diihaFsXYf2o9Lto36ykSziSO09pq70grVwsOchu2zHHFh+miqZI5UADk5UMEj895MKEKkXUN9qFiXLrp8Xul1zm4APsEpF
X-Gm-Message-State: AOJu0Yw9bU4aUrlw1Oie25KZT9O+z65lOcx3J5P1hlYPIoBnxdVGVBwS
	rnmuFV1XKeh6/DN5szQRSFquOP5tBUyAbstSL1k+84L5vDuboDcq
X-Google-Smtp-Source: AGHT+IFiuLkyfTfP1K58Ed6tmWSnREBD9iKxhj60+zuRKso+K3MibCYCAPTiPG2zPH63kjaJnRJ2rA==
X-Received: by 2002:a05:6a20:4f03:b0:1a0:c427:9c4b with SMTP id gi3-20020a056a204f0300b001a0c4279c4bmr638311pzb.19.1708995701353;
        Mon, 26 Feb 2024 17:01:41 -0800 (PST)
Received: from debian ([2601:641:300:14de:cd6d:a14c:bd98:9c36])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a000d4700b006e4d545519dsm4697451pfv.62.2024.02.26.17.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:01:41 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 26 Feb 2024 17:01:22 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <Zd00YhCejwN6NuU6@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-9-nifan.cxl@gmail.com>
 <20240226180417.00004dc4@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226180417.00004dc4@Huawei.com>

On Mon, Feb 26, 2024 at 06:04:17PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Feb 2024 10:16:01 -0800
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
> Hi Fan, 
> 
> Comments on this are all about corner cases. If we can I think we need
> to cover a few more.  Linux won't hit them (I think) so it will be
> a bit of a pain to test but maybe raw commands enabled and some
> userspace code will let us exercise the corner cases?
> 
> Jonathan
> 
> 
> 
> > +
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.4: Release Dynamic Capacity (opcode 4803h)
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
> > +            if (ent->start_dpa <= dpa &&
> > +                dpa + len <= ent->start_dpa + ent->len) {
> > +                /*
> > +                 * If an incoming extent covers a portion of an extent
> > +                 * in the device extent list, remove only the overlapping
> > +                 * portion, meaning
> > +                 * 1. the portions that are not covered by the incoming
> > +                 *    extent at both end of the original extent will become
> > +                 *    new extents and inserted to the extent list; and
> > +                 * 2. the original extent is removed from the extent list;
> > +                 * 3. dc extent count is updated accordingly.
> > +                 */
> > +                uint64_t ent_start_dpa = ent->start_dpa;
> > +                uint64_t ent_len = ent->len;
> > +                uint64_t len1 = dpa - ent_start_dpa;
> > +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> > +
> > +                found = true;
> > +                cxl_remove_extent_from_extent_list(extent_list, ent);
> > +                ct3d->dc.total_extent_count -= 1;
> > +
> > +                if (len1) {
> > +                    cxl_insert_extent_to_extent_list(extent_list,
> > +                                                     ent_start_dpa, len1,
> > +                                                     NULL, 0);
> > +                    ct3d->dc.total_extent_count += 1;
> > +                }
> > +                if (len2) {
> > +                    cxl_insert_extent_to_extent_list(extent_list, dpa + len,
> > +                                                     len2, NULL, 0);
> > +                    ct3d->dc.total_extent_count += 1;
> 
> There is a non zero chance that we'll overflow however many extents we claim
> to support. So we need to check that and fail the remove if it happens.
> Could ignore this for now though as that value is (I think!) conservative
> to allow for complex extent list tracking implementations.  Succeeding
> when a naive solution would fail due to running out of extents that it can
> manage is not (I think) a bug.

Yeah. spec r3.1 mentioned about the overflow issue that adding/releasing
extent requests can raise. We should fail the operation if running out of
extents and report resource exhausted.

> 
> > +                }
> > +                break;
> > +                /*Currently we reject the attempt to remove a superset*/
> 
> Space after /* and before */
> 
> I think we need to fix this. Linux isn't going to do it any time soon, but
> I think it's allowed to allocate two extents next to each other then free them
> in one go.  Isn't this case easy to do or are there awkward corners?
> If it's sufficiently nasty (maybe because only part of extent provided exists?)
> then maybe we can leave it for now.
> 
> I worry about something like
> 
> |  EXTENT TO FREE                                        |
> | Exists    |   gap   | Exists                           |
> Where we have to check for gap before removing anything?
> Does the spec address this? Not that I can find.
> I think the implication is we have to do a validation pass, then a free
> pass after we know whole of requested extent is valid.
> Nasty to test if nothing else :(  Would look much like your check
> on malformed extent lists.
> 

I cannot find anything specific to this in the specification either.
Since we have already detected the case where the extent range across
multiple regions, the only case we need to capture here is one/multiple
portions of an extents getting released and causing extent overflow.
I think we can handle it after we introduce the bitmaps (PATCH 10) which
indicates DPA ranges mapped by valid extents in the device.

With that, The release workflow would be

1) detecting malformed extent lists; if passed
2) do cxl_detect_extent_overflow {
    delta = 0;
    make a copy of the bitmap as bitmap_copy;
    for each extent in the updated_extent_list; do
        if (extent range not fully set in the bitmap_copy)
            return error;
        else {
            if gap at the front based on the bitmap_copy:
                delta += 1;
            if gap at the end based on the bitmap_copy:
                delta += 1;
            delta -= 1;
            // NOTE: current_extent_count will not be updated in the
            // loop since delta will track the whole loop
            if (delta + current_extent_count > max_extent_count)
                return resource exhausted;
            update bitmap_copy to clear the range covered by the extent
            under consideration;
        }
    done

}; if pass
3. do real release: in the pass, we will not need to detect extent
errors;

Does the above solution sound reasonable? If so, do we want to go this
way? do we need to introduce the bitmap earlier in the series?

Thanks,
Fan



> 
> > +            } else if ((dpa < ent->start_dpa + ent->len &&
> > +                        dpa + len > ent->start_dpa + ent->len) ||
> > +                       (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +            }
> > +        }
> > +
> > +        if (!found) {
> > +            /* Try to remove a non-existing extent */
> > +            return CXL_MBOX_INVALID_PA;
> > +        }
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> 
> 
