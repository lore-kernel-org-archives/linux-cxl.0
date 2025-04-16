Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EB10E9
	for <linux-cxl@vger.kernel.org>; Wed, 16 Apr 2025 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744839191; cv=none; b=mXAPJK3jVVOinc9djAgzQOK0trq5a9Ain3xlCksAt8utM5obTV0z1qZZpAS+3JoH07Tcw2NfDqkASt5+Vdcj/dsg2BtUxBhTSGYqGbvcOJg/pyLFZNevZTEKdRZAcFRSM8YmCf3TRr41MwC0HgDnRCUFTJKWyc29f+kvmKc7fqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744839191; c=relaxed/simple;
	bh=KVXUEk4DN0V/5Z1UQA2pfsQg6a04mtN8utw78bdPKO4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSE4RpddiehM/oIc5O4L1id9PCuLFSDCMk7RpJpY8m1YuDVARjmzeLHQnzxmig8BKoYGyDu6KfNVyi0ACJZ+JhZaHSMiABoxZDAlPo/K4W7oMwWCEKtMSTEawqOvEQH4myE7nvEwQLt1tW5Redva/teSmXPv6ojl+zFvMvO+BTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7cdCahC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7cdCahC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22435603572so1536765ad.1
        for <linux-cxl@vger.kernel.org>; Wed, 16 Apr 2025 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744839188; x=1745443988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=amn4jn7lQqQ0Q0RR/m3vaumX2/sKAJWhKEabhOf6ePw=;
        b=k7cdCahCHm3TrkKgPtsxqKNqWpVGWQTikWg4CsAFQiQjhRbHSxnCDK6fRe3A7UsYJm
         LJnYEF8f/lIvf/2poeCzd1X29wWvn0maRUrvM0FPDEiPTrdUXUN/o/chwtAnlBWc5ijJ
         2B/K8ZJ7JLbWg9Ipmnm1uVvIfG7ifP0uth2YkXG4VlL06tpH4bYjcI9cZIh/o5p/7mMZ
         Ar3zYYoyao196WHfLPED2ZQLdtboVa+JhwBpnKl2STW3ZlVo6/vU1Bs+OYoqg+GclIZD
         weS4wpZQ5z925m93noMdceCA7qBy5zHVQvnD/65Z1hEU0BIK3qQS/448LgivXScJFu6x
         uZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744839188; x=1745443988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amn4jn7lQqQ0Q0RR/m3vaumX2/sKAJWhKEabhOf6ePw=;
        b=fpjmvfh4jkrhUOJq4BRDuoug7rkykizlo9XSdmsryIrWLrwan1+BGD0LM5dRGjLX0k
         CDQwhFnl9ZlqsHl1ANBuPfItKqM/qtMw1Gk6AeZODap+wyH3QQmXaQkiI9t5d3PZwyyZ
         CGctSmNataUm6Trfp4AIIKWlLlhcYvRfETxKe3JlAq27o1FYEfHbKYFYuz2OQ6iWdhLF
         Rp9lgbr4QJ8GLH1DFtmWNWPbboyRsUv1IUrg37laAbzs7PMzOdh0oQ5Wh7IhmHnzNcAS
         wpPknzDt/mx8f0JZE8cAh06SAZC9q7b3KL/BjdjS8ZLmfTlzkXyHGjoMZ+0K5cqiqCMc
         A6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVkwtfodslCJYhzXUN60EQdSrsPUN5NvUeF4l8wzbUNYntSZSfIWr99/PNnZ1H+Otf5tltqdQPkNMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzYlgkj5CkfpHnHXsQgMWqNeQKPxeunvhu8Ws9KhjZL492X/y
	//L+Zu15070SaCSqzcICNvZWaW2XCgM8mWV7Qd3Djvlmo+/tn3Q6
X-Gm-Gg: ASbGncslsF3vomCFsvUu89xl16YC5dLR/JJOqaB7DaYb2w5eHkUiXjXbcs75CCEB82I
	adjFh9cq7HXYnaKY3mmGm6oyEasYhY/flI1r9pP1+4klYUY46IJkd4ObyG5bS5nTSuErWsDD9mn
	MDDu3VIWYn7LD/LxJXeTmXynV6/tcUK2WQ0XZ1sC53SsfnRBrU71JMj9AAY3xavA96K69mm9Qp0
	iTthhEAPp4qa300B3l5dyQSTAJDeuOiKwBeYM3Be38d2iwCIe3jXjromaumMmVCeEKlU/35Ax9n
	V1eAkVEg05ZJrE5ve1bEXLMJrsQqcpnteWYCcmPh0hEdKDtPLbOIh+TIxbc4Mzd6cBuFoxqXUaY
	Jsw==
X-Google-Smtp-Source: AGHT+IF8kXu3dAb1jHJKafOCkZeR/F2Da6MtK+i/e4pCN9Y2YKhk3P8lToDQV9T2JeDXdN26NJlEbA==
X-Received: by 2002:a17:902:e808:b0:223:2aab:462c with SMTP id d9443c01a7336-22c358d70femr51623255ad.15.1744839187726;
        Wed, 16 Apr 2025 14:33:07 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1d07bsm19406045ad.94.2025.04.16.14.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:33:07 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Apr 2025 21:33:05 +0000
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region
 Config
Message-ID: <aAAiERk2XSs7xALX@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-7-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317164204.2299371-7-anisa.su887@gmail.com>

On Mon, Mar 17, 2025 at 04:31:33PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |   2 +-
>  include/hw/cxl/cxl_device.h  |   3 ++
>  include/hw/cxl/cxl_mailbox.h |   6 +++
>  4 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4bb51bf3e8..51ead2b152 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -125,6 +125,7 @@ enum {
>      FMAPI_DCD_MGMT = 0x56,
>          #define GET_DCD_INFO 0x0
>          #define GET_HOST_DC_REGION_CONFIG 0x1
> +        #define SET_DC_REGION_CONFIG 0x2
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3494,6 +3495,98 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
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
> +
> +/*
> + * CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602)
> + */
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
> +    } QEMU_PACKED *in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLEventDynamicCapacity dcEvent = {};
> +    CXLDCRegion *region;
> +
> +    if (ct3d->dc.num_regions == 0) {
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    /*
> +     * TODO: Fail with CXL_MBOX_INVALID_SECURITY_STATE if
> +     * device has been locked
> +     */
> +
> +    in = (void *)payload_in;
> +    region = &ct3d->dc.regions[in->reg_id];
> +
> +    /*
> +     * TODO: Fail if sanitize bit doesn't match current config and "the device
> +     * does not support reconfiguration of the Sanitize on Release setting."
> +     * Currently not reconfigurable, so always fail if sanitize bit
> +     * doesn't match.
> +     */
> +    if ((in->flags & 1) != (region->flags & 1)) {
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
> +    /* Free bitmap and create new one for new block size. */
> +    g_free(region->blk_bitmap);
> +    region->blk_bitmap = bitmap_new(region->len / in->block_sz);
> +
forgot to update region blk_size
region->block_size = in->block_sz;

- Anisa
> +    /* Create event record and insert into event log */
> +    cxl_mbox_dc_event_create_record_hdr(ct3d, &dcEvent.hdr);
> +    dcEvent.type = DC_EVENT_REGION_CONFIG_UPDATED;
> +    /* FIXME: for now, validity flag is cleared */
> +    dcEvent.validity_flags = 0;
> +    /* FIXME: Currently only support 1 host */
> +    dcEvent.host_id = 0;
> +    dcEvent.updated_region_id = in->reg_id;
> +
> +    if (cxl_event_insert(&ct3d->cxl_dstate,
> +                        CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                        (CXLEventRecordRaw *)&dcEvent)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3620,6 +3713,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          cmd_fm_get_dcd_info, 0, 0},
>      [FMAPI_DCD_MGMT][GET_HOST_DC_REGION_CONFIG] = { "GET_HOST_DC_REGION_CONFIG",
>          cmd_fm_get_host_dc_region_config, 4, 0},
> +    [FMAPI_DCD_MGMT][SET_DC_REGION_CONFIG] = { "SET_DC_REGION_CONFIG",
> +        cmd_fm_set_dc_region_config, 16,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ac74e62875..b742b2bb8d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1686,7 +1686,7 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
>      pcie_aer_inject_error(PCI_DEVICE(obj), &err);
>  }
>  
> -static void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> +void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                                      const QemuUUID *uuid, uint32_t flags,
>                                      uint8_t length, uint64_t timestamp)
>  {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 81b826f570..217003a29d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -806,4 +806,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
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
> -- 
> 2.47.2
> 
