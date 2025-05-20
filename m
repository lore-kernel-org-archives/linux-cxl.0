Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A327A927
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760828; cv=none; b=k0tuXooFScMSpkrsD+KjyUW3W83B/Tm4aE4niJbOTUEcXnkQJMBQQwlWe8cmK/0V0F1GZstRXbZUe+iHD6ss1OX4G99DKq66FqOLKA05wP/i6fxXO7xSD65wTVpffmNuWttjFYpIHelezFc8njxAx7KlsdfpuxHnok9VQPDDjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760828; c=relaxed/simple;
	bh=KeKDukF00+SyqsHS7fwAi/g0MZgfzvDg3bZAx+xpQ9c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzXYk6xvJqALf+FpnPWB2IrDEMm2+Q0RmC0Kq63XZ6SNu31ZDem29/QH/Uh2WNdB/X9Ohl3hhmFvKYcFbcJ087fMTW66JDthi5WnLAaKhFPkK1ZAGVHm6NYa2ZaRKVy7CqgHZmnGgS9j8UlNrxJWna+EccjSN2trzfy3HuLyh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvB/AZGi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvB/AZGi"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742af84818cso3449846b3a.1
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747760825; x=1748365625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8q+EYA2c9WPJk2TN75JC+fehQQGo9FQiZD7bYilPvpw=;
        b=cvB/AZGiTVKGB9hhnAU3UEuFBDFnHQZwvqp1C24R/rGIBDVVqpcVAGWEgWdBR1SvIR
         w6iqUhQ19YTkgjm0rfvGM+96tQ0mTET9OIhNVtFyW3sg0g2uPdgAb21m4TbFq24clMOO
         vQE1qW8WxE6uLwb541LQhypNd5g3oKJ3mh8vSQCImzSBvZcbFybQ1qycqIFH/P1CESyx
         Rf6/6yGrKHuASpi/yxuhhp4bc4dv+NWXFdwk6pZsQscneZyn8IPyuMcpA40NKW6Q2IHS
         HMXxNm9Pu+Gmw3HYvi8BiN7a6RPr0EXSfeDWZH5rXndjHGM9O7IFb6/fefWyRYfC60Yt
         vHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747760825; x=1748365625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8q+EYA2c9WPJk2TN75JC+fehQQGo9FQiZD7bYilPvpw=;
        b=cgMv8ZAQqRBm3VsxJfaYGFOWZzE7auU8A53BvMZyZRwL5FRUbpr68zhV5SANtDLnUR
         rqbDKM1GDzui5NEw6lDha5nj/M6bL4x9yxxPL4uhjqBbngg0TjaBtOk4Klb4e5OZEm6x
         wRG6fWXG3WZ3sqfRd6RhNWYoGdncx3k1mTQOGjhjZ6kP6cRhIIBH60WdevqcTAeY7wy/
         mzAevEzsVU3oXMr3Gd3/YdESyXCxyUq8KcY6Yl9vHb4tk7g3hq1gAcsqV8NH42MzwyxS
         jKaRoLIdX3kS0I05PNACQLEo/1l9MPS1nTxu4+Zk9BT1nnvKGwcTQboDZ6unIYJNl6Dg
         1wQw==
X-Forwarded-Encrypted: i=1; AJvYcCVOcVq/+A5FfrfvEb7lxZQxEoNd7HnYFPP2wpIU0jGeMkp6v2tXB5G8u88Erf+HEyrGxMZXC1/XusA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtcsvamIw1Lxo5qiS+hKHH+bgVlcCTlRJ3A8RWGolpD4SIwxK
	yh52sHAuKUrOAdHZVM/7cLMVCRO8UKZxFnIRw8urgcsH/0VAMDscR2GF
X-Gm-Gg: ASbGnct1GRl67705NpPkaoaVcgrNYO9S7ffYpJR0yHfMIIsvPCB18cq5fp6963XA87x
	xuoRDywiaHqj7YTV+p1Zp/epUOWZuR4Ff7endGZ9WcBucL2zbzsdyluaN+Niry4QII1/FlM7iTg
	DxOrPfjf2lW/N1zl0HEaKQjfF9EinAXDC1+GdkDGyU3PQ3Tr49fTgoO5E4qTMdL/g7kGM0aQ2v8
	dTQDaxMamIL4lKH1dqa/1/x7zMS4YHuHwscp3ZQqjufA8Er7JJcJO5NSQCURve2vJy8vkdErh6L
	Jz6xed1JToXnmIweYa8BfUTlMpZx51KULM1Zd9D5rtLf70yCLJ0v
X-Google-Smtp-Source: AGHT+IFmtzOivtQLt/MERhxfivImekdEeQkNMQgXIoMpA3EnIyZnt3/tYApwH0vBzkOXESYF+llakw==
X-Received: by 2002:a05:6a20:d705:b0:215:e43a:29b9 with SMTP id adf61e73a8af0-216219bd612mr24255820637.33.1747760825446;
        Tue, 20 May 2025 10:07:05 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8e13csm8230164a12.45.2025.05.20.10.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:07:04 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 10:07:02 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 07/10] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region
 Config
Message-ID: <aCy2thqeJ7DnD-7K@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-8-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508001754.122180-8-anisa.su887@gmail.com>

On Thu, May 08, 2025 at 12:01:03AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 97 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |  2 +-
>  include/hw/cxl/cxl_device.h  |  3 ++
>  include/hw/cxl/cxl_mailbox.h |  6 +++
>  include/hw/cxl/cxl_opcodes.h |  1 +
>  5 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6afc45833d..fe38a13f71 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3426,6 +3426,96 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static void cxl_mbox_dc_event_create_record_hdr(CXLType3Dev *ct3d,
> +                                                CXLEventRecordHdr *hdr)
> +{
> +    /*
> +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Severity
> +     * field in the Common Event Record Format to Informational Event. All
> +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> +     * Event Log.
> +     */
> +    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
> +
> +    st24_le_p(&hdr->flags, flags);
> +    hdr->length = sizeof(struct CXLEventDynamicCapacity);
> +    memcpy(&hdr->id, &dynamic_capacity_uuid, sizeof(hdr->id));
> +    stq_le_p(&hdr->timestamp, cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +}

This function does the same thing as cxl_assign_event_header(), maybe we
can move the cxl_assign_event_header() to header file so it can be used by
both cxl_type3.c and cxl-mailbox-utils.c and then this function is not
needed or simplified by calling cxl_assign_event_header().

Fan
> +
> +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
> +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t reg_id;
> +        uint8_t rsvd[3];
> +        uint64_t block_sz;
> +        uint8_t flags;
> +        uint8_t rsvd2[3];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLEventDynamicCapacity dcEvent = {};
> +    CXLDCRegion *region;
> +
> +    region = &ct3d->dc.regions[in->reg_id];
> +
> +    /*
> +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> +     * This command shall fail with Unsupported when the Sanitize on Release
> +     * field does not match the region’s configuration... and the device
> +     * does not support reconfiguration of the Sanitize on Release setting.
> +     *
> +     * Currently not reconfigurable, so always fail if sanitize bit
> +     * doesn't match.
> +     */
> +    if ((in->flags & 0x1) != (region->flags & 0x1)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that no extents are in the region being reconfigured */
> +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /* Check that new block size is supported */
> +    if (!test_bit(BIT((int) log2(in->block_sz)),
> +                  &region->supported_blk_size_bitmask)) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    /* Free bitmap and create new one for new block size. */
> +    qemu_mutex_lock(&region->bitmap_lock);
> +    g_free(region->blk_bitmap);
> +    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
> +    qemu_mutex_unlock(&region->bitmap_lock);
> +    region->block_size = in->block_sz;

If the new block size equals to region->block_size, we can avoid the free
and allocation of the bitmap?

Fan

> +
> +    /* Create event record and insert into event log */
> +    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
> +    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
> +    dcEvent.validity_flags = 1;
> +    dcEvent.host_id = 0;
> +    dcEvent.updated_region_id = in->reg_id;
> +
> +    if (cxl_event_insert(&ct3d->cxl_dstate,
> +                         CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                         (CXLEventRecordRaw *)&dcEvent)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3552,6 +3642,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          cmd_fm_get_dcd_info, 0, 0 },
>      [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
>          cmd_fm_get_host_dc_region_config, 4, 0 },
> +    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
> +        cmd_fm_set_dc_region_config, 16,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b5b3df5edf..edc29f1ccb 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1695,7 +1695,7 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
>  }
>  
> -static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                                      const QemuUUID *uuid, uint32_t flags,
>                                      uint8_t length, uint64_t timestamp)
>  {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 9cfd9c5a9f..22823e2054 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -821,4 +821,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                     uint64_t len);
>  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                             const QemuUUID *uuid, uint32_t flags,
> +                             uint8_t length, uint64_t timestamp);
>  #endif
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 8e1c7c5f15..820c411cbb 100644
> --- a/include/hw/cxl/cxl_mailbox.h
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -8,6 +8,7 @@
>  #ifndef CXL_MAILBOX_H
>  #define CXL_MAILBOX_H
>  
> +#define CXL_MBOX_CONFIG_CHANGE_COLD_RESET (1)
>  #define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -15,6 +16,11 @@
>  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> +#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
> +#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
> +#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
> +#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
> +#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
>  
>  #define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
>  #define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> index 68ad68291c..ed4be23b75 100644
> --- a/include/hw/cxl/cxl_opcodes.h
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -64,5 +64,6 @@ enum {
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
>          #define GET_HOST_DC_REGION_CONFIG 0x1
> +        #define SET_DC_REGION_CONFIG 0x2
>      GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
>  };
> -- 
> 2.47.2
> 

-- 
Fan Ni
