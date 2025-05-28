Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E2F2750FA
	for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748453965; cv=none; b=fkaVqxTyTCGgH6Kq7hFVdknYvZMM7tO2yvsfp2rNUKVwep0yc95+j6GhpYVdQVLLoS8qvUP6dszH3DWZZdatbEwreWVPGLjut6fOo5ZS79Rl9hz3KiG+OsRu1di4RYzSG/oU8BA7qwV1+X0GtzVKY/22pyCazq0A/D0eJMW+5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748453965; c=relaxed/simple;
	bh=1DeZgjWR+pO/U7TJ5hX543A2fpZFW90vO9ABog39QDA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLHUb+XTOh3T3CVU2/HvJdDRKzSw7pTDyef4qeZ6fESGZvIfKULfsJsAAfh+S1wF57zSd81jmw42Rd8Xl7RJs6hrGCT8LZixCqU/iqhXfWz0vEawv0qcpFe0y9r8jzgZwgcP3lYB6D4OOf5n41ugMv3zbO21G1lNVtwsEgiibmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xrb8Tczb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xrb8Tczb"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73712952e1cso3529218b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 10:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748453963; x=1749058763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3CUMqKkExl5Yqm2d32QXyDSBLqA1Cfd73PkgxPB7vY=;
        b=Xrb8Tczbap4o5LCZ9tz2foQBT6g5UBspjfDbwB+Hr+sA5zkVmBWoE8MK8vDOMYjrz6
         RKHV6HWmT5fKJpdLg9SU390LiS+HsCYHnfWBFOrvedozSZLRY2U6XPvSfkAhktoyxZ3I
         vtPAP7zDLi9/9EYb5SnvWj/BsXOYIxbrW1zHqzeGqaIY9vpCWq0dbeGrxHeJk6TVUMZS
         0ZWY4ectaufA2RfopHLNzSKyfry/7LgKNuG4NjTCsjzhkZ9nFaflmN+m5a0Kmm8aLxko
         1uIOkV+iZdL/HlJiiCjB8Ev5j/rXAGWpWXYKIIqQ65xfHh1/81lZsVQWfLg2ZTdWKJIN
         1E2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748453963; x=1749058763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3CUMqKkExl5Yqm2d32QXyDSBLqA1Cfd73PkgxPB7vY=;
        b=gZk82bEQPwv/V6VIFoPvap//GqOndHt73MIw6qnriZxzD9UUszYDxDTVXuoupaIfWD
         QC/kFUZluIiu05VD5EM7mt61jfB1a69P5PAE9/d1nhBer8DsTsapI2GZ/o8zWk+Nqq1T
         SB3yVqBQ93ao0TTgLG3vqNDojAvMXPChGpulEIA/vpJTwF0KJteH9cwq/3jtZRj2MTJc
         pkZB5JyEXqfDhFSNnc6U0/sT9kWfYamWYD3XHu4Nxd3CUQJfr9/3xGtob1UWtjS0XGV8
         0oofFseoyrM3kC2qv5Ndd89eCunP+hMgvOxgObaIMTIIzp4YloUAtTBf//hcvNLTSSVB
         FfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEuy5oWYUscHtPM/dk6wZ0mUIsxbItmSo+5dbOu/XDAAxDdCOR26vSNzQ6jO+i24ksSnNdSPISZ2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKEf+KWuo8vy0w331h7SmlKK7UHfwVH4tkNm1TFKMIKqFC0EE
	d8/AyzPvgr+XK9AdZsu8za0dOt6O2F57JuDagxL4BN740Wy8yaACjL5E
X-Gm-Gg: ASbGncvPV0zdi9vJQYf6yiaN33Wgh4RGIE6mVeAoodXlDHWX/gmZggGNey3dAnpGy5V
	VzgjdIVIxw4MC1CrBDfqrcZZLFhAsnuaPyTAvZtUz1LdrLRg/AIHlNAwSSvZAMt2fkTJo2tyL6n
	R3d20/RDR+27n4LZ66510cqKtkzOtZ1hlLrBiTIgflprG3u6EmKrs6LlVjD1p78AU0TCeraUD2H
	qRGhL1YdQOtE9EnbAiKhRLl3XqiSa6oubsCMr9xvlGh67azCrakfkI7Q6NMxnaIb7M8X3cSpm+x
	rIrCiFJWwh9Io3XtqQmGA2k9EMmtPS3Fq1sKdH+ROMy8QpDcy4evgCc=
X-Google-Smtp-Source: AGHT+IFfrHY8StlI1EtMqUvTKr+winERQk33CEfPSAoE1icRvErrxpuZfwfiSeoysqnF14o4j70zgQ==
X-Received: by 2002:a05:6a00:140f:b0:740:3830:4119 with SMTP id d2e1a72fcca58-745fe035cc9mr28850379b3a.18.1748453962793;
        Wed, 28 May 2025 10:39:22 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746e345e842sm1492123b3a.168.2025.05.28.10.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 10:39:22 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 28 May 2025 17:39:20 +0000
To: nifan.cxl@gmail.com
Cc: jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com, anisa.su887@gmail.com,
	gourry@gourry.net
Subject: Re: [PATCH] hw/cxl: fix DC extent capacity tracking
Message-ID: <aDdJj0gBtFQKt8VA@smc-140338-bm01>
References: <20250520195741.789841-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520195741.789841-1-nifan.cxl@gmail.com>

On Tue, May 20, 2025 at 12:56:43PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
> extents in different states including added, pending, etc.
> 
> Before the change, for the in-device extent number tracking purpose, we only
> have "total_extent_count" defined, which only tracks the number of
> extents accepted. However, we need to track number of extents in other
> states also, for now it is extents pending-to-add.
> 
> To fix that, we introduce a new counter for dynamic capacity
> "nr_extents_accepted" which explicitly tracks number of the extents
> accepted by the hosts, and fix "total_extent_count" to include
> both accepted and pending extents counting.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Ping ...

Hi Jonathan,

The FM DCD management mailbox patches needs to be on top of this fix.

Fan

> ---
>  hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
>  hw/mem/cxl_type3.c          |  1 +
>  include/hw/cxl/cxl_device.h |  3 ++-
>  3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 299f232f26..0b615ea37a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>      uint16_t out_pl_len, size;
>      CXLDCExtent *ent;
>  
> -    if (start_extent_id > ct3d->dc.total_extent_count) {
> +    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> @@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
>      out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
>  
>      stl_le_p(&out->count, record_count);
> -    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
>      stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
>  
>      if (record_count > 0) {
> @@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
>      QTAILQ_INSERT_TAIL(list, group, node);
>  }
>  
> -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
>  {
>      CXLDCExtent *ent, *ent_next;
>      CXLDCExtentGroup *group = QTAILQ_FIRST(list);
> +    uint32_t extents_deleted = 0;
>  
>      QTAILQ_REMOVE(list, group, node);
>      QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
>          cxl_remove_extent_from_extent_list(&group->list, ent);
> +        extents_deleted++;
>      }
>      g_free(group);
> +
> +    return extents_deleted;
>  }
>  
>  /*
> @@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> -    uint32_t i;
> +    uint32_t i, num;
>      uint64_t dpa, len;
>      CXLRetCode ret;
>  
> @@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>      }
>  
>      if (in->num_entries_updated == 0) {
> -        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +        ct3d->dc.total_extent_count -= num;
>          return CXL_MBOX_SUCCESS;
>      }
>  
> @@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
>  
>          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
>          ct3d->dc.total_extent_count += 1;
> +        ct3d->dc.nr_extents_accepted += 1;
>          ct3_set_region_block_backed(ct3d, dpa, len);
>      }
>      /* Remove the first extent group in the pending list */
> -    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> +    ct3d->dc.total_extent_count -= num;
>  
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -3160,7 +3167,7 @@ free_and_exit:
>          }
>          *updated_list_size = 0;
>      } else {
> -        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
> +        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
>      }
>  
>      return ret;
> @@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>          ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
>          cxl_remove_extent_from_extent_list(&updated_list, ent);
>      }
> -    ct3d->dc.total_extent_count = updated_list_size;
> +    ct3d->dc.total_extent_count += (updated_list_size -
> +                                    ct3d->dc.nr_extents_accepted);
> +
> +    ct3d->dc.nr_extents_accepted = updated_list_size;
>  
>      return CXL_MBOX_SUCCESS;
>  }
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 94e7274912..f283178d88 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>      }
>      if (group) {
>          cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
> +        dcd->dc.total_extent_count += num_extents;
>      }
>  
>      /*
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ed6cd50c67..a151e19da8 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -618,6 +618,7 @@ struct CXLType3Dev {
>          CXLDCExtentList extents;
>          CXLDCExtentGroupList extents_pending;
>          uint32_t total_extent_count;
> +        uint32_t nr_extents_accepted;
>          uint32_t ext_list_gen_seq;
>  
>          uint8_t num_regions; /* 0-8 regions */
> @@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
>                                                      uint16_t shared_seq);
>  void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
>                                         CXLDCExtentGroup *group);
> -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
> +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
>  void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                   uint64_t len);
>  void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> -- 
> 2.47.2
> 

-- 
Fan Ni (From gmail)
