Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93624677B
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515120; cv=none; b=X0M79DzDwyEdjsZ6UvncjmtJtCMsIQxHTbJ1cIQhcJ5N+GEb8VIl4pi2EOwfUVLUxliDw2+bzGB+St4MKbY+MvOZoDxL1BgnQ44YkNyUkae0kg4o33VPM6y0TmLWCYmErwmqGRE5zQnAlaI2QPtKvqDYmjfxL4FxOxPaDPtgvKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515120; c=relaxed/simple;
	bh=uaeFfeaZR4ilnQZk3MKm7QbwGwZL0JdqJa/OCMSlNc8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/QEccucxtieNXvl4GClFz8AnzWPm5AMyMs5xaxaVDTM2XRxhfuTWH2VNDOt3fawMP4XSSnnR9UsL1xiU/a5CXId/SRgRhwwnupySWQLIkCyaWBPiyiVMiGCGrMAHo3KemsAQcc8x4cztCxXgvGRQYkBZ4BRIwhJPYVh0ywYjgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpCAFVnS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpCAFVnS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3134c67a173so4832407a91.1
        for <linux-cxl@vger.kernel.org>; Wed, 02 Jul 2025 20:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751515117; x=1752119917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Go8oYBd2sxtyrP6WJqHWWOw27H9fU4zxt1+fi7opBI=;
        b=KpCAFVnS5J+OgSnS8gq61UJwt1As1Twln6xAvZRI7EME4YCoaVHx+0autVkiKWI+h6
         IfkWSswi0EKFLGOS1lD2TAAtzfTbSbn2+qudC9vN48HNl/AQ5bw56JeOeadlrtAbrOlW
         RRmkUp0m3c1od7BRM3tOSgUUlsdl8d/namCdRFmaWGvCQl22hsdwRjNaGCdwDigs8tsT
         1+/ba6uCqcVWU1LzPiZA24MX9Fp9lLprtmCw8tnHVoJ9hCjMuq5JKB++/cHN8h26J/E1
         vP/3Pw4QD71JHFrXhXr/WRo02zh6teUKYs96HwyXqjsy0/Vu7mPleBm8oaTriOaZ+lQj
         Nlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751515117; x=1752119917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Go8oYBd2sxtyrP6WJqHWWOw27H9fU4zxt1+fi7opBI=;
        b=BOrqh6Nq5yGMeha6kwjpqL0tSVXlhcl+BZt8HbiO/1X+stAHk4t3paF2hvxNeIbhDb
         hK/YV0gmh9up2bj/IP50ExiIX+MTpy8bMLHs05H+NKTKg/9JvwVCiX/CHxBMdXKKqsXj
         qvh2/+7794VVj+Rm7lSE+kJS1gMiQOtMBXWsADHacw7qxKBWxUFFVB2Y9EhzzwTUYlEo
         MHuFvWvhfb0sTvUIXOw4xekg7jFOt5p7SfXy1DIjLwIKdpMC0T8b1qDvucFMIxntSCuG
         hb4H1vmT1+VMPEKPfnikaTCcexIn59Pt8zIxfVA8CvDfqTXZC6lrKJN/Jrtazm9iqhDT
         I9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQeuPNpmb3vTk58efarL+73Vst1nu8ByETiRBUyQHepV6Bq8FMC2xda2mdaokL9FbI2avjaxf5OAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYOrqK0f+xgvZzH/EscFIHknIe4Fxt8sh9R/HemcH0ZukYVQQ7
	QwGxxuGujQGz5m68//cu5BM35ZDlATmUP/2PLCe9R8Ws1sIlNqLsiP5p
X-Gm-Gg: ASbGnctrmuzIjkCPE41YZGyoVjSB0m33hSuBdk0JKK6gSCiWvNgrgE/Q745GCSF9qLN
	QVzn4XpLB9WyEFYouYkwQsui2R3u56Q3SmcGNkVKmGflYimgAwB5Xfhidn4JoitzDSsv+GIKPUG
	AHT+1pgY14+VdhCQwMVGd85+IVKx0/kgNtZZ2eNI1a15w1viPy5jGQqAouTzW+5Lf+xz+E966KZ
	CGdDfnsrArZt04kCDWErOTAGTOajJBjtqgIE/QToWDsFZOhSd01euS5cMKQXPUfUsOtSMrPLJF7
	3DFyPZX2MAb0aRb84Tb0uRmIf+hETRwA+G0rW3LAelrlU3C4txBQZDndq8nJDIphKXnQ
X-Google-Smtp-Source: AGHT+IEy2EBV5wygliAxQ1KH/cRgjS8XYzieVtx7l+itL8MEy6pNnTw5RW11X1TihQZBbbvCvL+vUw==
X-Received: by 2002:a17:90b:3b8c:b0:311:ab20:159a with SMTP id 98e67ed59e1d1-31a9d6998d2mr2235412a91.29.1751515117043;
        Wed, 02 Jul 2025 20:58:37 -0700 (PDT)
Received: from fanair.local ([67.131.46.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc67568sm1097844a91.15.2025.07.02.20.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 20:58:36 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 2 Jul 2025 20:58:34 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 08/10] hw/cxl: create helper function to create
 DC Event Records from extents
Message-ID: <aGX_6ihs4lp-RSr4@fanair.local>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
 <20250626222743.1766404-9-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626222743.1766404-9-anisa.su887@gmail.com>

On Thu, Jun 26, 2025 at 10:23:31PM +0000, anisa.su887@gmail.com wrote:
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-events.c         | 38 +++++++++++++++++++++++++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  |  1 -
>  hw/mem/cxl_type3.c          | 37 +-----------------------------------
>  include/hw/cxl/cxl.h        |  1 +
>  include/hw/cxl/cxl_device.h |  4 ++++
>  5 files changed, 44 insertions(+), 37 deletions(-)
> 
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
> index e3d54ed124..382c41c025 100644
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
> index 82e3bc1a71..91ec1ba299 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -732,4 +732,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp);
> +void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> +                                             CXLDCEventType type,
> +                                             CXLDCExtentRaw extents[],
> +                                             uint32_t ext_count);
>  #endif
> -- 
> 2.47.2
> 
