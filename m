Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4632252287
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747758213; cv=none; b=mrRVc5a8Iq0IWGJG0zF1VTiL9PXo2QjA/L3rw1l8M4t33CQwfsp23opQxB7BDR2g8jNNRmzzTX2ApBSNBMc5dqtxBFErMwnnTnP6bRphrEaZEpaNrqIwCjaTt3vsQV7lrniLta+XZ23kFYwpMkf6nWzmAjSbqecxiybq+55gO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747758213; c=relaxed/simple;
	bh=mUUYd0LDeVon+y0FU4ntINBjfx36c+ve1YIT+UPCOqM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBKcy5IP0ySaDmp+D+LCZV4XLXajhSSk6o7+RHHhIsYQPAQVfTqG+zxy/ulDAY6fEtS6m2SW7XETKQ/FGdcD8d46dktuZTK3dOLPnIUtniXUZ7eDPprSAUBaqDtKSMlxrb/mNfVvyjmJYSbAqYzgamfEae35OEJVQMfcfXPT6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcaxgfOu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcaxgfOu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-231e21d3b63so54158385ad.3
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747758211; x=1748363011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlIS5XkEiQcfpB33GU5iY3RFpQbWgrVE/LiB3jjgNCk=;
        b=dcaxgfOuGg86wsnRWhQdfwMHkIZMHgWQz5Ldiu/EfZyN4IzSwYtz0WSzCHq4+stwyb
         VFPzJAyPYaezq+8I1DMNUfxwka0v0MKB3y+hmAqUWGeZP2eU/32MC/2HbyCzpusxRAGs
         ZaWZdu207L3aFZVjq8vw2cJb1K1cP7UZjj+4g829gy+5mQJvriF5uWbIN9AUJFl4vrzh
         zXWtuIFXgafOycTZrIuuSRUofJbUPxhgup+NKXhLmLErkSyVDEowMyfbSsF7VTENf/6C
         /fsuz0O1yhSH96Qpk48pUZMtlds9dFVb+W48gcKOdLJTk1zXRdxoUodCB628SO12x1bj
         2ZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747758211; x=1748363011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlIS5XkEiQcfpB33GU5iY3RFpQbWgrVE/LiB3jjgNCk=;
        b=eM6ox39sJFR0VuDvokKUZhFeHU+V3p5rvh/DdbtPLUEwYn06FokSBBLMhylXDrqTBw
         VkygbIURHgFadgOKK+Rx643iEiAWhtaHKnkUz6e3Ivb9nKL0WEWceX1Hab85uJJP6me4
         jfJvIIsqlr3dqnjgIZEqy18Alu0AuyoZ6IyPHkhfJyaApzHFNhxU5LPjyeQZQ/j+orDT
         kxNGpr1w4ZNYOxcCtcb2AV3sr27LGPD6TIfml9uYi8EujZYBFhHGlloGw7RTSN5ybUPg
         rMNfK6afQmVvD9okYz3B3O9Lc8ypRQfx43hrad6Tm1UMa5ykycklcXVe6L0Do2pvCkq+
         1TFg==
X-Forwarded-Encrypted: i=1; AJvYcCWxNASwDbIigA6uXBDkC8V07CpuCNElJPLyRaJe8rjCnMpg5NSfggebObopRAjqsy06abhJsJ5voa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoCUsozH1W8OSQqt/BBLJEukhO/6CCi8TUfu/3pFNM7nDEynE4
	sPUJUbskpRzdir3LjyWa0ysxof+CAp9FTSwoWhSwLwd84tG37prwXsCb
X-Gm-Gg: ASbGncuQAs9sb+7dgPAqjTXva2hwlT9i2lHYJdsiRzMP5mYRLKRns7n616iYMigaGlE
	u/nTx/XO95MgIXJb36sF9aFvZ3wfihfIg5VvKquGFPEfmXJ6xN0vV9Q0pm1HvABNO8feMf9892w
	rDFo1/UCXK8Rq2VLtu6rcKtk8DZE6JJktXYU/rsuLOac09TJi1kGESuIoWnSo8Nl/o/kEzkTaYw
	uqy7DBv0ivt1hlICNf9SWp3Dwv0ng6lThSOrnrLNelcvriQicu7zWdA++sZohVwbtJsh52PjtGf
	rsixnTBucThm5pCy5pI+vddk2hFBXHQZp0HzBt/Szw==
X-Google-Smtp-Source: AGHT+IFVODoKkrtzlHVLin29APQi6H8q8atRsS0CZxOLTYpE/uHpUCwmNttZM212tup3D2nEt5OI/Q==
X-Received: by 2002:a17:902:dac5:b0:231:d16c:7f55 with SMTP id d9443c01a7336-231de21d5f5mr230631165ad.0.1747758209687;
        Tue, 20 May 2025 09:23:29 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97161sm78487625ad.153.2025.05.20.09.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:23:29 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 09:23:25 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 04/10] cxl-mailbox-utils: 0x5601 - FMAPI Get Host
 Region Config
Message-ID: <aCysfUNYZ4K-kNpA@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-5-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-5-anisa.su887@gmail.com>

On Thu, May 08, 2025 at 12:01:00AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5601 implemented per CXL r3.2 Spec Section 7.6.7.6.2
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

One minor comment inline. Otherwise,

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 102 +++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_opcodes.h |   1 +
>  2 files changed, 103 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d3c69233b8..6afc45833d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3326,6 +3326,106 @@ static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void build_dsmas_flags(uint8_t *flags, CXLDCRegion *region)
> +{
> +    *flags = 0;
> +
> +    if (region->nonvolatile) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_NONVOLATILE);
> +    }
> +    if (region->sharable) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_SHARABLE);
> +    }
> +    if (region->hw_managed_coherency) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_HW_MANAGED_COHERENCY);
> +    }
> +    if (region->ic_specific_dc_management) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_IC_SPECIFIC_DC_MANAGEMENT);
> +    }
> +    if (region->rdonly) {
> +        *flags |= BIT(CXL_DSMAS_FLAGS_RDONLY);
> +    }
> +}
> +
> +/* CXL r3.2 section 7.6.7.6.2: Get Host DC Region Configuration (Opcode 5601h) */
> +static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
> +                                                   uint8_t *payload_in,
> +                                                   size_t len_in,
> +                                                   uint8_t *payload_out,
> +                                                   size_t *len_out,
> +                                                   CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t region_cnt;
> +        uint8_t start_rid;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    struct {
> +        uint16_t host_id;
> +        uint8_t num_regions;
> +        uint8_t regions_returned;
> +        struct {
> +            uint64_t base;
> +            uint64_t decode_len;
> +            uint64_t region_len;
> +            uint64_t block_size;
> +            uint8_t dsmas_flags;
> +            uint8_t rsvd1[3];
> +            uint8_t sanitize;

We may have other flags in the future, maybe we want to generalize the
name of the field.  Maybe "flags"?

Fan
> +            uint8_t rsvd2[3];
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED *out = (void *)payload_out;
> +    struct {
> +        uint32_t num_extents_supported;
> +        uint32_t num_extents_available;
> +        uint32_t num_tags_supported;
> +        uint32_t num_tags_available;
> +    } QEMU_PACKED *extra_out;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    uint16_t record_count, out_pl_len, i;
> +
> +    if (in->start_rid >= ct3d->dc.num_regions) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    record_count = MIN(ct3d->dc.num_regions - in->start_rid, in->region_cnt);
> +
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    extra_out = (void *)out + out_pl_len;
> +    out_pl_len += sizeof(*extra_out);
> +
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    stw_le_p(&out->host_id, 0);
> +    out->num_regions = ct3d->dc.num_regions;
> +    out->regions_returned = record_count;
> +
> +    for (i = 0; i < record_count; i++) {
> +        stq_le_p(&out->records[i].base,
> +                 ct3d->dc.regions[in->start_rid + i].base);
> +        stq_le_p(&out->records[i].decode_len,
> +                 ct3d->dc.regions[in->start_rid + i].decode_len /
> +                 CXL_CAPACITY_MULTIPLIER);
> +        stq_le_p(&out->records[i].region_len,
> +                 ct3d->dc.regions[in->start_rid + i].len);
> +        stq_le_p(&out->records[i].block_size,
> +                 ct3d->dc.regions[in->start_rid + i].block_size);
> +        build_dsmas_flags(&out->records[i].dsmas_flags,
> +                          &ct3d->dc.regions[in->start_rid + i]);
> +        /* Sanitize is bit 0 of flags. */
> +        out->records[i].sanitize =
> +            ct3d->dc.regions[in->start_rid + i].flags & BIT(0);
> +    }
> +
> +    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
> +    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED -
> +             ct3d->dc.total_extent_count);
> +    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
> +    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
> +
> +    *len_out = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3450,6 +3550,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>  static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>      [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
>          cmd_fm_get_dcd_info, 0, 0 },
> +    [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
> +        cmd_fm_get_host_dc_region_config, 4, 0 },
>  };
>  
>  /*
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index c4c233665e..68ad68291c 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -63,5 +63,6 @@ enum {
>          #define GET_MHD_INFO 0x0
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
> +        #define GET_HOST_DC_REGION_CONFIG 0x1
>      GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni
