Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CDD2E3718
	for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485548; cv=none; b=sPAgB8iLuc8h6cNxtwSWmiZ5hp2XKh/jDt3/hEcgk38EH6riV0a+ksXkBxp58CQqqbcj1kyMQVuYclFREdaovilFDXWYhHtNVsw8J1inUSA4+b8Pnwh58QFWOmjPfdgZxziQ4U9nU9HUG4XnvQ7XgMSSzJ/dbYYCn7IjANZYol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485548; c=relaxed/simple;
	bh=ORIp0DsTIkl1pIRoWhFV8ehRLtrIqAJsWSgoImxEfak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n1Akx2FZH6XoYUc8moTD7RTgFRAxDp2aAvCtjDrLfYlGizCi70C13V/008CWhnxVO6+MQqRMreUYWZTM4V7PyuEm2SM54qDlSJ/L8hwJz3WgE1B+M88/i2anZAXlkWfLwZ8J0teBTWGB1GYr5W2zWTylgLZTRYpeKPt+td96k/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PVXmix8z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVXmix8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752485545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BkT8p2YW/M9VYSgCvpbzN2lnaj46fH5yJZ5UAMNKGU=;
	b=PVXmix8zd9N0PXr20BCHEKH63rfVpF4CNyxpXc13p1gE87xmA4oVgArCczW3K1Bf6jj2Q4
	Jm2R+4NQ3c5ySQTOSDsajlRiNdwjXX4XhbaWKpzeM31W/FS0djq3K8vK7cfzthdQ4UbObi
	J0lgxlXs9mkA/QxFowuEgUXBR4ljgyc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-WTLXSUSwPEiDgO8yvkGveQ-1; Mon, 14 Jul 2025 05:32:24 -0400
X-MC-Unique: WTLXSUSwPEiDgO8yvkGveQ-1
X-Mimecast-MFC-AGG-ID: WTLXSUSwPEiDgO8yvkGveQ_1752485543
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-456106b7c4aso4483985e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 14 Jul 2025 02:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752485543; x=1753090343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BkT8p2YW/M9VYSgCvpbzN2lnaj46fH5yJZ5UAMNKGU=;
        b=mF0f+3m6pcCud8zmc3SZNwG7jgNkv3VpCHBqCP2ie5Fkm7q5d0OeHyxWjoQzXboosT
         pkDosua8JWJuNna7M096AOwGrs3T3ZjmAATLctgiuZpG6d1E1ofEqfdhnjRleaCcBrx0
         md4Ym/PRn+B3p8uC9YFLpZZVn0EGR3ochVBcy+9tesjzNSfk5ol89UmL9l3vncP6lY+V
         +IeFxkzds6DW3Ct/eYUGQQhLqaiHgKbttg1knpFt7xH2tztitFZC61or22ni5ZRYpFj4
         7ZJCj725qY5YKER5iLxNk8A2xrzLdyn9a0Uzy0L34xb2huoaOvBRjWRKHE3ur5VwgmwR
         23pA==
X-Forwarded-Encrypted: i=1; AJvYcCXvfB9xfo0TJBCt0wJXS7GlljNsEqO50v0hFa1wv86gLP4UaugoNRs99pWHMB7f4RsXhCjav1RXh7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk0SW3Sreg09LG43OVLPqoOVA0RiEG1i7xxbGpOtwOkgOwxNSS
	Bn11RTP6J4wUkQPoFVGQcAVwlRu1dzN1Ymig9TGsmUfvsIuHKEIoZXGm8bWb2vUbA+dY5XDHtIY
	35wWtKjMHEI26fI+DB48PdRFEa/35u3nV/ULARHJI4+75/8eK+b5yaJY+B0C+3g==
X-Gm-Gg: ASbGncthpOxdB1/UVah7bks3LpeR2n5LeH7w+t/DohDBj5SwFAX5QaNA11As+nsJY9L
	8Xwg1WFNz7QQPJIQvSsVlP4yMYa40rX6HzkZkdfv6brJCa0CuvztN1nUV1LljF5YCJHk308V8dm
	jev4p9ZQqI6XdxrXdcW8mLztBhsOQOUFK0VVv8nEOkQJ6LXxp8UTBmc/niNmF7H3sAOmxifcyxx
	bcwHIXTEI3ydD9ARAGZt7hEplu+I1fQUuEOMBJIasOK6uBqNc2euciKMK1gaO6wpL5QBzClfosD
	Ii1cI9G4tFPxobmV2SKZ5SgMf4R/ITq+
X-Received: by 2002:a05:600c:c097:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-454db8b7aa9mr123777615e9.10.1752485543035;
        Mon, 14 Jul 2025 02:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmqmT+EBkAgDQgxCs3fzbMYZTOiU6Wq2jej9Z8+hmfEvxkO4md31GcLOvInI3c9HtrT1f5RA==
X-Received: by 2002:a05:600c:c097:b0:43c:ed33:a500 with SMTP id 5b1f17b1804b1-454db8b7aa9mr123777295e9.10.1752485542441;
        Mon, 14 Jul 2025 02:32:22 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b600722780sm4251288f8f.23.2025.07.14.02.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 02:32:21 -0700 (PDT)
Date: Mon, 14 Jul 2025 05:32:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <20250714052757-mutt-send-email-mst@kernel.org>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M5GUpFuCq467YKNop4oTvNQwVfxYPvsQ0e5AF0YuSLA_1752485543
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 02, 2025 at 05:02:13PM +0100, Jonathan Cameron wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl_device.h  |  3 ++
>  include/hw/cxl/cxl_mailbox.h |  6 +++
>  hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |  6 +--
>  4 files changed, 98 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 96ef9be444..76af75d2d0 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -721,4 +721,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                     uint64_t len);
>  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                             const QemuUUID *uuid, uint32_t flags,
> +                             uint8_t length, uint64_t timestamp);
>  #endif
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> index 9008402d1c..a05d7cb5b7 100644
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
> @@ -15,5 +16,10 @@
>  #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
>  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
>  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> +#define CXL_MBOX_SECONDARY_MBOX_SUPPORTED (1 << 8)
> +#define CXL_MBOX_REQUEST_ABORT_BACKGROUND_OP_SUPPORTED (1 << 9)
> +#define CXL_MBOX_CEL_10_TO_11_VALID (1 << 10)
> +#define CXL_MBOX_CONFIG_CHANGE_CONV_RESET (1 << 11)
> +#define CXL_MBOX_CONFIG_CHANGE_CXL_RESET (1 << 12)
>  
>  #endif
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index bf1710b251..1fc453f70d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -121,6 +121,7 @@ enum {
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO    0x0
>          #define GET_HOST_DC_REGION_CONFIG   0x1
> +        #define SET_DC_REGION_CONFIG        0x2
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3390,6 +3391,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
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
> +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
> +
> +    /*
> +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> +     * This command shall fail with Unsupported when the Sanitize on Release
> +     * field does not match the region’s configuration... and the device
> +     * does not support reconfiguration of the Sanitize on Release setting.
> +     *
> +     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
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

This does not work: test_bit works on unsigned long, while
supported_blk_size_bitmask is uint64_t.

Why so funky? what is wrong with:

if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask))

And BTW why cast to int here?


> +
> +    /* Return success if new block size == current block size */
> +    if (in->block_sz == region->block_size) {
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    /* Free bitmap and create new one for new block size. */
> +    qemu_mutex_lock(&region->bitmap_lock);
> +    g_free(region->blk_bitmap);
> +    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
> +    qemu_mutex_unlock(&region->bitmap_lock);
> +    region->block_size = in->block_sz;
> +
> +    /* Create event record and insert into event log */
> +    cxl_assign_event_header(&dcEvent.hdr,
> +                            &dynamic_capacity_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(dcEvent),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
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
> @@ -3508,6 +3587,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> index b872a26173..ee554a77be 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1590,9 +1590,9 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
>  }
>  
> -static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> -                                    const QemuUUID *uuid, uint32_t flags,
> -                                    uint8_t length, uint64_t timestamp)
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +                             const QemuUUID *uuid, uint32_t flags,
> +                             uint8_t length, uint64_t timestamp)
>  {
>      st24_le_p(&hdr->flags, flags);
>      hdr->length = length;
> -- 
> 2.48.1

