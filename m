Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E217F8
	for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996011; cv=none; b=owfT1ZcN0cx+OF/kgQ8GXT4dVJ33jnFjLRRQ7FvucCT8HxxdJ5YLXhVwS3zqDwEwI8Z04wAlvqtPRfgYcMAtRlTqv+E/UD301172m99t8wSsRLzcRoIgTAh1ZHlecIZEj6YoH1SKU1/ae150lBiDtS/HGBgYo31iDRKtQ5kTkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996011; c=relaxed/simple;
	bh=G5XSmDj0Grny0t4D6rcJ+UO42rPWow4k7MYwmCfSkVM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdLTga5oAxz+UETGONoLkKgADiyi1HdgCFx9Qf4riLAssJ0X6hrgwJ0yMImQW0U4nN4YM1pjWUnwSKFABL2vwVtFaHeeMO5jX6ibaposDPq5n6MXmW3kE+jbLqveKHUq/Lidl8ycwshZpEo6EZA1vJKl4P+37iQDu6CkTxnkgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaOtkVxY; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaOtkVxY"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-364f791a428so12201185ab.3
        for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 17:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708996009; x=1709600809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVoAGP6yYuSlpDtZA3JBGfA3TEVDc/MSNeQz65Aoz2I=;
        b=JaOtkVxYMLu89F4ba0qP/c7qaUk4TJoFWkkmS0iLVdRbsmD6ObXyvxL64T2hKlgijX
         jN39Ay1NEMgRra7Z6SU90+xW6o6lH4j43uZTl4BblIQj/4zS4mB3gkocm6ABK9k3nmWW
         lyXFp7BMXSJzHpZCkcrLGLYHr6vnGNbtqrln12ScNuyX6AWDzclmJcyImOuqRGQYphCL
         A8JiA4RnwfELjK2UX9NjatE7os4y8znXIX4UavuOdmy3ZfIhunOk2r/x87nH5fm6eK1n
         Hxt1Qp3Vj55vZmmr8a5afgdS78JV7ew/Y02gCryo2cG6idOdUv47JhmPyDNF8jUy41th
         b/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708996009; x=1709600809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVoAGP6yYuSlpDtZA3JBGfA3TEVDc/MSNeQz65Aoz2I=;
        b=cgPLXV6i52fOMkIcfYDwJeKTXjnIkMZSUNOmPl91DCk97WVykr6HkN5kZ5Cb8H5ckB
         uiCKwsz7YN0BH+pACBAHZ9BEm731uOuXtp54aM/wrO5ZM0Gw9UeEi+5xbPPLyWpqZcoz
         /m6Sp9wtjGjTurvYWcZlOZtYQHxjwfKkm09KzxTpn4NqCRPD2pl7WYZJpBpZTXN8f518
         LHSOVj+DLBfH+lYhZLQ5lWedxad3XmcoLO50aDFjUyaCqi0uj3qBvepVON8GK1B/iL+2
         AWZ1Ey+5a1XDVE3amF2F+QWK6yvaSIWn+WLeq52AFlrqAux0VGz7rSIm0cnM/Bitnh/g
         cl4w==
X-Forwarded-Encrypted: i=1; AJvYcCUgXL/WQJQlCAhH/SRvicr/DN9ZkkSkpK3GFIQnbkU7pQNDu/6yL9VQzVHllIhtGpBCQ08V+uJwBFOsq+7zf3lWSvFmJpKWc9zE
X-Gm-Message-State: AOJu0Ywu4SRGnipJUt1gdLOldpYEpBZ44JNmdjfcGrsLTXoHm5r8D9nF
	e9Kar0YZHKyVOtuzUNEuvcPSVHFJgC073XSh9l20jR24m5q41WxhXA31//VR
X-Google-Smtp-Source: AGHT+IF/55mrQiCdVIew+CQkJsK20umuoCxmQ6xDzwu2UkEdTp+pgMbspQt5rGTI04LirRAQhBLXkQ==
X-Received: by 2002:a92:cb90:0:b0:365:32b:602b with SMTP id z16-20020a92cb90000000b00365032b602bmr8897814ilo.11.1708996009253;
        Mon, 26 Feb 2024 17:06:49 -0800 (PST)
Received: from debian ([2601:641:300:14de:cd6d:a14c:bd98:9c36])
        by smtp.gmail.com with ESMTPSA id y5-20020a633205000000b005dc120fa3b2sm4523869pgy.18.2024.02.26.17.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:06:48 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 26 Feb 2024 17:06:46 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 08/10] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <Zd01poqsQHKMu1KQ@debian>
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

If we use the bitmap (indicating each range is filled by valid extents)
in PATCH 10, it should not be that difficult to do.

Fan
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
