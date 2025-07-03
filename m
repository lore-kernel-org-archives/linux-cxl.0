Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03F24A07C
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559700; cv=none; b=Jjdgh4np5dnRnBylv4VHAMMDP038J6YSyBS4pI0IFXM+xgiVzCrjaf4eBG2UNIdTyAvl9SNbQSz0u/t0cCieJzbD2pZxlh5pmc4wdpY2V3r1dFnJrR0vbNEzsaR2N8puGHdhiQzkVPviygdly0/tTwn4wv5+zHuwd48bjMPcXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559700; c=relaxed/simple;
	bh=UJ94gXVwjktj7p3joMWykC7+oRxB5XJvzn55BwHOGnw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7LCUQptv+esLQ7oQV5iBQqpFmdatIp2cX6nR4NOj6YABXYWPyofsm1IH1pp07sQC6OoqUgj6V5smU4DXOcMLCSJ9j2pZlMJM/g9PlJySWKg9IOn+8bzB4buiVgXw7SsETK+fvJEiETUeLD8y2uVLgGE/JRsqqgq0z2HZIzLPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDOrTIV/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDOrTIV/"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748e63d4b05so110710b3a.2
        for <linux-cxl@vger.kernel.org>; Thu, 03 Jul 2025 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751559696; x=1752164496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZFeZiaK7j01bOKFMbxZm25zvRe4iY1lXYKU44Azw2Q=;
        b=IDOrTIV/wZt0qFLEah3kmtWnvx3fvjEqe/QfMjwUvMm4b8YgnhbA3wGTXN2QZma4mD
         vGbNhDet4Q5e/d+/s7MFD1nGgugepvy2ZcEsBGDckc+KVGAVA8czUTSCssKpYKQcOSHb
         WVEC9cpgQuaWfVzE/lTI54H0o8OB9TzU0sjE2nUmx1VbrM1siW+6KldkDM60ywGvTdMd
         J8s/w4YycQIWwWB8Rr7Y70q5EGm5qflQoMUeV0T39zs3MoLpyOMpGi284noRVIVxR+DD
         uTHrBkyFUQa7RyDATMf4hQFdpJSiUq02DLsUPFW0NA/MbBYka3HniZV2BJQRiiXiJebf
         l3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751559696; x=1752164496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZFeZiaK7j01bOKFMbxZm25zvRe4iY1lXYKU44Azw2Q=;
        b=dsGDteg8Rr88j0YQJJlkJAVFVUglbM+16aEOQE+ExUDdlbPSCzMKRFTtTAdEX1Onxm
         uzKMgt5If0r9eO3HYUS8P9VVme7E0pIGdFTm6//iPDMVrej5edOMfoVlTYucDlydr38+
         w3OZFi/Y9+DwElN1HSHynEO4tdJuoqz3L5RWWbeynVem3hVPkJVrX4o/XG1ivfF+2EAU
         kxE8U03f2Nn5gaqh7h4MvYRvYtvxr2dZk6/iDvWISNEJFE4u6pY1YgEabYJEl4vCmA8C
         EE0OE8CYAufwQO5BaRcIxCtZjZUi5hH9O0gIKf4OqHctVfH2VUGhLPZs4qV/iMTF1Tks
         Xu4A==
X-Forwarded-Encrypted: i=1; AJvYcCVFbvUoLwp009IlHurJZNTMVGMxwGqVv4MpbP5MHDfrH8ob0Nmi5TEDWD833wlJXFgGoqvjrCOavjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRb3wGeJ+jquc7GuWmunS0Ze3oJ808EpxKqN4eO808NthhTrJO
	B0BAYRU9PYYRID/s3gAWhnl3hzA6oDkWA9I/OTTjJ4rPQsbn+zInSiZw
X-Gm-Gg: ASbGncu7fCjGfRrIIsiURmmC8nc3jRm4zMPvFk1KvIBjj7Bx6K5QUCO6Fd/wIRqbwSp
	VVfibVUzUSrCOpYbDZdmWnxYKuwM2lRVc0a/A9FDe+K5sd6+b88jC5wm9bqDOFQu4ucT2ytY6Hg
	ZyldlKz2QdeWj1gqtZg3jzTW/yrZnXx7S2vZyT3ZuX2URYYRQX+F+WKYbU8fJEJicJebiC5Rgf7
	9gJhlXsIt4NGayPwQwefXZwOon8twTA77UTRATzzeoxt9y5yVbBCKwux4eDb21eM94E7OywQNV0
	BWunLmxQh1PN4p0oZRnAcp/ymvUu3Mevt/LQskn+bbZD4FS45pm6//W8NPnl2PcO4A==
X-Google-Smtp-Source: AGHT+IEywsg/XtG05fb3AGPsxsQcAMkuLAt7+/85wkPC54jqt0jKBL2TnqTBgDYXK2wUSU8PzvSZlw==
X-Received: by 2002:a05:6a00:848:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-74b5103e10amr9496914b3a.6.1751559695788;
        Thu, 03 Jul 2025 09:21:35 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35d0014sm20436b3a.67.2025.07.03.09.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:21:35 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 16:21:33 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
	linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 09/11] hw/cxl: Create helper function to create DC
 Event Records from extents
Message-ID: <aGauDb295pVVBWiv@smc-140338-bm01>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-10-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702160219.989731-10-Jonathan.Cameron@huawei.com>

On Wed, Jul 02, 2025 at 05:02:15PM +0100, Jonathan Cameron wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Prepatory patch for following FMAPI Add/Release Patches. Refactors part
> of qmp_cxl_process_dynamic_capacity_prescriptive() into a helper
> function to create DC Event Records and insert in the event log.
> 
> Moves definition for CXL_NUM_EXTENTS_SUPPORTED to cxl.h so it can be
> accessed by cxl-mailbox-utils.c and cxl-events.c, where the helper
> function is defined.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl.h        |  1 +
>  include/hw/cxl/cxl_device.h |  4 ++++
>  hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  |  1 -
>  hw/mem/cxl_type3.c          | 37 +-----------------------------------
>  5 files changed, 44 insertions(+), 37 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 75e47b6864..3ae4303383 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -23,6 +23,7 @@
>  #define CXL_DEVICE_REG_BAR_IDX 2
>  
>  #define CXL_WINDOW_MAX 10
> +#define CXL_NUM_EXTENTS_SUPPORTED 512
>  
>  typedef struct PXBCXLDev PXBCXLDev;
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 76af75d2d0..ed91e5387e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -724,4 +724,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                             CXLDCEventType type,
> +                                             CXLDCExtentRaw extents[],
> +                                             uint32_t ext_count);
>  #endif
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index 12dee2e467..724055f2cf 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -260,3 +260,41 @@ void cxl_event_irq_assert(CXLType3Dev *ct3d)
>          }
>      }
>  }
> +
> +void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                             CXLDCEventType type,
> +                                             CXLDCExtentRaw extents[],
> +                                             uint32_t ext_count)
> +{
> +    CXLEventDynamicCapacity event_rec = {};
> +    int i;
> +
> +    cxl_assign_event_header(&event_rec.hdr,
> +                            &dynamic_capacity_uuid,
> +                            (1 << CXL_EVENT_TYPE_INFO),
> +                            sizeof(event_rec),
> +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> +    event_rec.type = type;
> +    event_rec.validity_flags = 1;
> +    event_rec.host_id = 0;
> +    event_rec.updated_region_id = 0;
> +    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
> +                              ct3d->dc.total_extent_count;
> +
> +    for (i = 0; i < ext_count; i++) {
> +        memcpy(&event_rec.dynamic_capacity_extent,
> +               &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +        event_rec.flags = 0;
> +        if (i < ext_count - 1) {
> +            /* Set "More" flag */
> +            event_rec.flags |= BIT(0);
> +        }
> +
> +        if (cxl_event_insert(&ct3d->cxl_dstate,
> +                             CXL_EVENT_TYPE_DYNAMIC_CAP,
> +                             (CXLEventRecordRaw *)&event_rec)) {
> +            cxl_event_irq_assert(ct3d);
> +        }
> +    }
> +}
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 24e4ba0200..d0a1d63582 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -27,7 +27,6 @@
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> -#define CXL_NUM_EXTENTS_SUPPORTED 512
>  #define CXL_NUM_TAGS_SUPPORTED 0
>  #define CXL_ALERTS_LIFE_USED_WARN_THRESH (1 << 0)
>  #define CXL_ALERTS_OVER_TEMP_WARN_THRESH (1 << 1)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ee554a77be..9c2b9d197b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1957,15 +1957,11 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>          CxlDynamicCapacityExtentList *records, Error **errp)
>  {
>      Object *obj;
> -    CXLEventDynamicCapacity dCap = {};
> -    CXLEventRecordHdr *hdr = &dCap.hdr;
>      CXLType3Dev *dcd;
> -    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
>      uint32_t num_extents = 0;
>      CxlDynamicCapacityExtentList *list;
>      CXLDCExtentGroup *group = NULL;
>      g_autofree CXLDCExtentRaw *extents = NULL;
> -    uint8_t enc_log = CXL_EVENT_TYPE_DYNAMIC_CAP;
>      uint64_t dpa, offset, len, block_size;
>      g_autofree unsigned long *blk_bitmap = NULL;
>      int i;
> @@ -2078,38 +2074,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>          dcd->dc.total_extent_count += num_extents;
>      }
>  
> -    /*
> -     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> -     *
> -     * All Dynamic Capacity event records shall set the Event Record Severity
> -     * field in the Common Event Record Format to Informational Event. All
> -     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> -     * Event Log.
> -     */
> -    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> -                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> -
> -    dCap.type = type;
> -    /* FIXME: for now, validity flag is cleared */
> -    dCap.validity_flags = 0;
> -    stw_le_p(&dCap.host_id, hid);
> -    /* only valid for DC_REGION_CONFIG_UPDATED event */
> -    dCap.updated_region_id = 0;
> -    for (i = 0; i < num_extents; i++) {
> -        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> -               sizeof(CXLDCExtentRaw));
> -
> -        dCap.flags = 0;
> -        if (i < num_extents - 1) {
> -            /* Set "More" flag */
> -            dCap.flags |= BIT(0);
> -        }
> -
> -        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> -                             (CXLEventRecordRaw *)&dCap)) {
> -            cxl_event_irq_assert(dcd);
> -        }
> -    }
> +    cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
>  }
>  
>  void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
> -- 
> 2.48.1
> 

-- 
Fan Ni (From gmail)
