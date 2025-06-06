Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F578F2F
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227231; cv=none; b=CE03cGNiogiCmGaRyhGHzEqx6kxBFL2vljMQkqtqFVglIMlFHWQJicsoTgVho8E5vPlWRmTL9UOR0dqB9WLagPbkC4sXba15rxHKgHNY6xyELlBtcpBVo4NATzCwpJuVZ/cbvNG7uNePofx1ILUjG3Gq5MRPCAGb7paZBdNBzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227231; c=relaxed/simple;
	bh=TYpaetErr2xHpEOulTMN+2jfmyPSz6DHSF1tppCYT3g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isUPxCyNtoazEkmaEb0g8vUKKjin49m+wXH9qpyFE0dJzMYpuZHsWshy9uLL8BPMOKFfji1/NRf0WIXihz6gh4VtUg2sZQA57+OK4LVz0p6QAFWNLy5uozCi6FzTesKywdG6qYKt7jphS3tvJhSkrSA6nepEEUXDOLJA/ZgjDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNmOsAiF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNmOsAiF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3134c67a173so904311a91.1
        for <linux-cxl@vger.kernel.org>; Fri, 06 Jun 2025 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749227229; x=1749832029; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LJo/2H61aEcasih2UA9s9opFRItpP5BcPNNKHiIMYyI=;
        b=FNmOsAiFdx/bx1xOokvSVD68KXOfQFbveCzeP98x0W/N9EPuWBT8LOWcFS6GMrWB6w
         gKBOzzhDDk5HHStMSCjOw7phdhFf1r7MMKO31QbyZP0sv7WKIW0uewrZN9qGr7NoPy66
         XZQ5ty7YL/CBgILX6aBH5Boohgy/3AacVZPHz5p0ZylS6diCfQkVRwLTZRCdDAsCkuWB
         zxr6YnUiXE+bQ0UhtfdP6va1E4zZDCi6yTOle52RQnVd5UKqEbzemYAp82NhPa0Jk9ao
         kPOdX87enASkPReSgOmUO+axTj8/kI2hujfJ6BeVv4nRKBB52h+cWx8bJlpAw4Y8Zqwp
         R8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749227229; x=1749832029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJo/2H61aEcasih2UA9s9opFRItpP5BcPNNKHiIMYyI=;
        b=ieQ8IgP0h08sbayaNe/Rix7uUFTKieSG/lDnPFCeqyJwMovQAekUY6n6gY44ea4256
         O/9vKy6no3WjlwLsDtLCkX+I+yFBGobRLRmK1jynv+1V8udFfMYT87lOY4lpWj8lpt9+
         0Tk1myxdWh3++cwFKTxXxRdUMNv3pPxiXqDvdZtbtWjvPBTn25/IJ+3PchQqkzFLDxMO
         cNcDkEZsGi2L9vYmifv1L5YKnnjrgx8LE903llsDT7b/+istgPOQrj2VICwWq72NQwRy
         I/nnwzBgefG7tuRkQNdGrTJI1nCrCByQnUcP40RIEztMvMUc/JtS1inwCSfmj6jZX+4D
         ytJA==
X-Forwarded-Encrypted: i=1; AJvYcCVtr058YRGrF4H7zjgEgljy3JjIpZ+5kUt3QGA76FtDh8gaHPPUOkxTvtELp0mj3zle1vTeiAMXz10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF5zX5CYxA0f4yTVcdry2SouvqfrvEz8W4yEMyjwEVMttX7KvZ
	7LhfmKlXfsZ0z7JGDlDpmgGOL4i4NrGfSnk00jp3IjTR4uw8LrZCqidG
X-Gm-Gg: ASbGncsPfN6l2fXM4iZSfiO9kkI5I5W9xb+YkG5mW3jbWZufQnljIt3K9+mb8Fs09Zp
	6Mu4lXx9IYEG6QTBK/f6FtGsFX4Np6zjXROaNSGwbgUsKmR1+SDvegqe/ki44ZBf7Uf7ZQhnBOY
	WvtfOBityjC1dwMOz2xDdwbPu2iDwl64Ra7Tu9vOn71aZpUhWeJN+QnPkOf996OY32He/jfUSGv
	EJm98XC0J9lLJS7vkrMR1l1HfD4vMUfSk5oDaPuTxG+CdmJN/AGJVdj2jHgiDteVwNMKYtbWlAE
	CcKuKbYO5UePxK9y1SzTPLCieQ5TjHb3OHlu/UG0ULzzvQ==
X-Google-Smtp-Source: AGHT+IEKi6kelnMID7Y/svXIB+jik0hfOHx3xJYctF6Pu+ddRZqnbbb0d7EMCaz4F2yl+M80M3Uyug==
X-Received: by 2002:a17:90b:1646:b0:311:f05b:869a with SMTP id 98e67ed59e1d1-313472eb280mr5905063a91.8.1749227228714;
        Fri, 06 Jun 2025 09:27:08 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349f35284sm1514066a91.17.2025.06.06.09.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 09:27:08 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Jun 2025 09:27:05 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 6/9] cxl-mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <aEMW2SDuAE10Iyuf@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-7-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250605234227.970187-7-anisa.su887@gmail.com>

On Thu, Jun 05, 2025 at 11:42:20PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---

One minor comment, otherwise LGTM.

>  hw/cxl/cxl-mailbox-utils.c   | 86 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |  6 +--
>  include/hw/cxl/cxl_device.h  |  3 ++
>  include/hw/cxl/cxl_mailbox.h |  6 +++
>  4 files changed, 98 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 1b5c7216f9..47b1509a0e 100644
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
> @@ -3387,6 +3388,84 @@ static CXLRetCode cmd_fm_get_host_dc_region_config(const struct cxl_cmd *cmd,
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
> +    /* Return success if new block size == current block size */
> +    if (in->block_sz == region->block_size) {
> +        return CXL_MBOX_SUCCESS;
> +    }

Should we move this below, after checking the bitmap?

Fan
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
> @@ -3505,6 +3584,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> -- 
> 2.47.2
> 
