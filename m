Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825628E17
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559864; cv=none; b=A6e6qXhQD23myrLNrWlXwoAL1InfHuvrCqfbgu3rTEc9FEPa8HMXe5iAFtEXStONgOOldaYsShXVvA4N9i3oNBRlvLoK6ZnVQxd2s9KdkHwiW+qbOMg7w8rOZxSs6bYNdIbFkRsSpzRZ8EJruz9FDkrroMhqb9QMwPsoRx++WS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559864; c=relaxed/simple;
	bh=ydQ1ni8R8SKBEecfEH//UzGI+1vs7WDotv6UzMkJ/Is=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=batM/bPzdVUFVeg6DiH14MgekpHxAQdGBxTEn0B448txegMc/Bn2cvR8bt0p/JPgg3INsySr2p5ulvNLWtqtalZWd8TgBuixe0yJ4Ap/EIAFJYxsv+V23xBx3NVMFrJruATyWCaqB8F7gaZ8bSwp73OMuhPu0H6ujERih814CVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms/nc5BW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms/nc5BW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2350b1b9129so1298085ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 03 Jul 2025 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751559862; x=1752164662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aTwGKwFQ62Eqawv1d7F6pjBSbRdUA0VSPj456ky5A3k=;
        b=Ms/nc5BWrvILwfH4VfU5ntI45C6sYKi7VxoJ9WMyAZJSUEDLPdrVjqryb4daUiRJiX
         ZB8w8Cc21ijnkFAfKdnUNHiCg5/Ifsthhox0YNSSLijRlrzaoRf4kFnkSx5S8x0S3J0W
         +1/dlFBNW5h/iiG1pfsXig+SshSjIimR8YOb+o6s3J8Meq6m5gDAfIauOUSC7YPkQlev
         Ky5JBNNRs/xny7zxOwKGAsaoI7rekEKRubZsUJdpLI0A4+NJR+t8Ks4iZv0bPUZyGYl4
         HKMEiZdJO6GCRvwKSISfnM/VSjZxPm1G4KBWjvz9ArR08PxZjJO53Z/qHxRE2X+Ngukh
         Vfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751559862; x=1752164662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTwGKwFQ62Eqawv1d7F6pjBSbRdUA0VSPj456ky5A3k=;
        b=O3jhjKyAqxfUvAu32QRFLvY9w6oDvdP3Oga3K6BF53YMoHeuTyib+nMpx47Wz/1gR3
         /Fi8ve6FnUVyCFoJtvVJBcPvmOprWRkyren1E7lipLgaVyTWMq811M0j/Yh9Qx/1442P
         dFI4SheerzQajzTDGsje6qM218/LRDqxeik7DkgfTvJ3FVw0NxytYi53/SOEoWC7HjcE
         TB2vEsddElAVzuM+kQRXIQh9j7msKLtysIlmULDQa0IlFyqKd+0J7+EdzokLpo4pFCjI
         c46rpHUXalmjbAoCI4HmVIEMBfJ7mdiT97Szl7Wswmw3IOWkPSkZsRkhLoTsMWgYWrzH
         LoDg==
X-Forwarded-Encrypted: i=1; AJvYcCUG6LBuB1NKBt4S6IIGs+j92S8i2Guhm5UUSHtco41j9A7nkHLsTCTU+fY5luFIFXl0pXTpfGYDj/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFzuRpJ9D/Ar1zpsJCv0FLKvydZ8nzItIZwaZSonzkjqoMV1M
	UrBdSLFOFwHsvSaqvcGMQa6DZTnewbtZskv4yWZ01ooePWAL/RtikU1X+QXO4A==
X-Gm-Gg: ASbGnctR9d38/A768WY/Ivolx4Z3qeNDVaI3dqQQFdBgU78atI73C8h/Vxeob273aPl
	m5+EWM2MwpVKHpbki1xAK03z9m4Ut6wkHtfR2cQgiPoDrpxsK+d4ZiksdScJ7RukAXQWedcdSHx
	SrQDmLVxXXRHGNlvwpAFg/cm/e2RAp69SjHFk/ORyZXMsSErvXe/VylVqR/vboeGhJRPcwZh31V
	lSQUHQuWDY7DYDucPPhgu4NjYdnYAkZfC3KEvd6MAND0d+iqLnHljEovzBdYlAfJsavIpdr7QN5
	qGKSXxgFastWDxtPEQFYGo7S3T1I3ZJ+OreW+0Sh7de1pO8/9d7kkliW8yLVUlcLZg==
X-Google-Smtp-Source: AGHT+IG93Mc4+t846eF2fY9hnaaPDxJ5/oVc2LiDUopjjqffI4wdH9UnPwFeO5/FleUMiQ/IVtnJ4w==
X-Received: by 2002:a17:903:3510:b0:235:225d:30a2 with SMTP id d9443c01a7336-23c797d1470mr56513715ad.48.1751559861721;
        Thu, 03 Jul 2025 09:24:21 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm165134555ad.156.2025.07.03.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:24:21 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 16:24:19 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
	linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 11/11] hw/cxl: mailbox-utils: 0x5605 - FMAPI
 Initiate DC Release
Message-ID: <aGausxNbtyEyT8GG@smc-140338-bm01>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-12-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702160219.989731-12-Jonathan.Cameron@huawei.com>

On Wed, Jul 02, 2025 at 05:02:17PM +0100, Jonathan Cameron wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 88 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 5ea0d07808..43a0d503aa 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -123,6 +123,7 @@ enum {
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
>          #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3644,6 +3645,86 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>      }
>  }
>  
> +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
> +#define CXL_FORCED_REMOVAL_MASK (1 << 4)
> +/*
> + * CXL r3.2 Section 7.6.7.6.6:
> + * Initiate Dynamic Capacity Release (Opcode 5605h)
> + */
> +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t flags;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    int i, rc;
> +
> +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> +        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
> +            CXLDCExtentList updated_list;
> +            uint32_t updated_list_size;
> +            g_autofree CXLUpdateDCExtentListInPl *list =
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +            if (rc) {
> +                return rc;
> +            }
> +
> +            /*
> +             * Fail with Invalid PA if an extent is pending and Forced Removal
> +             * flag not set.
> +             */
> +            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
> +                for (i = 0; i < in->ext_count; i++) {
> +                    CXLDCExtentRaw ext = in->extents[i];
> +                    /*
> +                     * Check requested extents don't overlap with pending
> +                     * extents.
> +                     */
> +                    if (cxl_extent_groups_overlaps_dpa_range(
> +                            &ct3d->dc.extents_pending,
> +                            ext.start_dpa,
> +                            ext.len)) {
> +                        return CXL_MBOX_INVALID_PA;
> +                    }
> +                }
> +            }
> +
> +            rc = cxl_dc_extent_release_dry_run(ct3d,
> +                                               list,
> +                                               &updated_list,
> +                                               &updated_list_size);
> +            if (rc) {
> +                return rc;
> +            }
> +            cxl_create_dc_event_records_for_extents(ct3d,
> +                                                    DC_EVENT_RELEASE_CAPACITY,
> +                                                    in->extents,
> +                                                    in->ext_count);
> +            return CXL_MBOX_SUCCESS;
> +        }
> +        default: {
> +            qemu_log_mask(LOG_UNIMP,
> +                "CXL extent removal policy not supported.\n");
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3778,6 +3859,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
>          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> +        cmd_fm_initiate_dc_release, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> -- 
> 2.48.1
> 

-- 
Fan Ni (From gmail)
