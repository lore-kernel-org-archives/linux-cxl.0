Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46328E17
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559842; cv=none; b=X5BnH9uEWdFG9YL51Tas4H5na1WVUuLRwOZ7rhy57IIiMDmnprmrXskFzYI8wMqlu2Lpy3n+j4StMEYQuFfxN9tyDFPUTEtz4q93bjYi1tqCVdDuliPwqJ6AP+RtRpuKj3J+f8Ctk/HFd4/hPwW3yj22RNmGLyEkuiLBlTvs28w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559842; c=relaxed/simple;
	bh=bS31te3uEfur1AYuPOLOtH8+z7b+nMuZQJ30T61Vgec=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfBrnz5+9PaKJCQdv65EBR3KxK3V86DCw8MjyifDtzlVkWekrFZfZaWjy4VUAwCv/mbq2v993lvNDgcEntlGD9fw62lI+YaV+JyaWKmA1/KSzH/1t7G/JMkF33CP1xnymJUKnQ5SwgfSMEMNzW+AyLjtPzo+fD9Wd1OLSNUKhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIqmgNS3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIqmgNS3"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74924255af4so160312b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 03 Jul 2025 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751559840; x=1752164640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAR9pDVF5hUoGujqZRHMIvGAE0u3AiggpsjR/ihLtZg=;
        b=HIqmgNS3ZY54drLoU6a1FPZ8Ivk5y4PP/F8toli6gL/B+bzE+FI00QA1Pmeeqvx9gO
         ruo9GHrx10XC5r0N4ISim3IYp9eMARHm9UbScU05FQtRuwijQtioxyU5umveMd/k6ekW
         ecGNrJsl/J0/fQn6OnJZTqhA5Wez324ZMlcvyaiqslnPiqCih/4vS+T1AXkwrhT4lIw8
         iw6r9KfhSAzemt77crFr0pqWYSUzs8HdqYZh70WMD1EdL+xzaoan9Vc701GIGWXj7G+6
         KegcLGglaYMAT+2RjT64n8uZBfVHJg22JLTGj2xgg5JJ8UTCp3Rwh+x4nGjV+Qw46u2l
         PR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751559840; x=1752164640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAR9pDVF5hUoGujqZRHMIvGAE0u3AiggpsjR/ihLtZg=;
        b=en5hw/R6/m9rv4L/9KTpFa8xOfDtIbEresi8VrFJu/+VBqZu5pDqWPAhOWvKpxsiAH
         RVT7OY+U7ZtDWuKPM1fTgqdZ7ZRrSVITmmgiXF7zvuUI7liO4KmIOwbfvq9My/SsWH43
         bokgpaLKG6OiY6bWUisLFIPKAzHnkARcCv3Kg1+K6D7AIkX+3MSnu03aj0Y1Nn5DxsnJ
         1LQhUWw/q18ves2enOhJTDaUOSHwtJDbGi3bz/98pzuGEhkv5HMmGPtngyJTvSQPZKrt
         YJLHsUt/7wga516+RkhCaXiTQzocNg+Ln/+VEr9cDaJyOGWQ7rH7GsFhZ9cNxyzG0/EP
         PFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/VfGk5lvbhnmdH+l5eeV26AUeSxv6GpmSQkH/CEgljnzz3dGEryiAJTFXwBbWRBf7iWSELKXPp5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqW/r15oHblhDvPZT0OAoWZIc64M1FrmMJ1g1NldeTXoPVHVu
	CthEWTnde+LrSm/fYAFKglezoSzhxeykN8oIpSrBK2l6lSDyS/GYbTNbzGaX3Q==
X-Gm-Gg: ASbGncsZj8Bpq7lnZzSst2HqJEW6U9jcBKkYwUSig0+N1fT0hCOJ3NsS5XMGF/9yYnB
	2Udd8npTrG3m7gNvZqsMxdMTx2cPJTgTABQJpLoCbnygeOd+vK8XaY9B77qwPUrPR8WGydbSagf
	h7eVTPPiezw13tuqrXk/MD5nrSZ1ywEQodk11U2vfuY8w1DyBtBxRTcAQg4KojUE9upjuju7zrn
	4aDOUPCPqutHRlfXC3qIiuOOh1Eyq49jDsy4kuVC82+Mf47cDectZaHPJY9puDm4Nut7eiJgkUp
	ZlAebImPPDf6CXs03MGvqT+3KNYwJLHR88yh0iIHmOsaOVV5lCAJpT+zJD42MjU0Lg==
X-Google-Smtp-Source: AGHT+IG958++ZBfQ2mwL/heVpUWlSKautY3lAE2wrUlCD8oQiuac13gIaQnOBlCxgeedSaTULXhmDw==
X-Received: by 2002:a05:6a00:2307:b0:748:2d1d:f7b7 with SMTP id d2e1a72fcca58-74b515128ccmr9942294b3a.21.1751559839526;
        Thu, 03 Jul 2025 09:23:59 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359df31sm29610b3a.29.2025.07.03.09.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:23:58 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 16:23:57 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
	linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 10/11] hw/cxl: mailbox-utils: 0x5604 - FMAPI
 Initiate DC Add
Message-ID: <aGaunVxcE8aOyg2V@smc-140338-bm01>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-11-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702160219.989731-11-Jonathan.Cameron@huawei.com>

On Wed, Jul 02, 2025 at 05:02:16PM +0100, Jonathan Cameron wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Only a minor comment inline ...
> ---
>  include/hw/cxl/cxl_device.h |   4 ++
>  hw/cxl/cxl-mailbox-utils.c  | 109 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |   8 +--
>  3 files changed, 117 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ed91e5387e..fdee60b977 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -728,4 +728,8 @@ void cxl_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
>                                               CXLDCEventType type,
>                                               CXLDCExtentRaw extents[],
>                                               uint32_t ext_count);
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len);
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len);
>  #endif
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d0a1d63582..5ea0d07808 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -122,6 +122,7 @@ enum {
>          #define GET_HOST_DC_REGION_CONFIG   0x1
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
> +        #define INITIATE_DC_ADD             0x4
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3542,6 +3543,107 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> + * in order to reuse cxl_detect_malformed_extent_list() function which accepts
> + * CXLUpdateDCExtentListInPl as a parameter.
> + */
> +static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
> +                                CXLUpdateDCExtentListInPl *extent_list,
> +                                int count)
> +{
> +    int i;
> +
> +    extent_list->num_entries_updated = count;
> +
> +    for (i = 0; i < count; i++) {
> +        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
> +        extent_list->updated_entries[i].len = raw_extents[i].len;
> +    }
> +}
> +
> +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */

/* CXL r3.2 Section 7.6.7.6.5: Initiate Dynamic Capacity Add (Opcode 5604h) */

Fan

> +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t selection_policy;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    int i, rc;
> +
> +    switch (in->selection_policy) {
> +        case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE: {
> +            /* Adding extents exceeds device's extent tracking ability. */
> +            if (in->ext_count + ct3d->dc.total_extent_count >
> +                CXL_NUM_EXTENTS_SUPPORTED) {
> +                return CXL_MBOX_RESOURCES_EXHAUSTED;
> +            }
> +
> +            g_autofree CXLUpdateDCExtentListInPl *list =
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +
> +            for (i = 0; i < in->ext_count; i++) {
> +                CXLDCExtentRaw *ext = &in->extents[i];
> +
> +                /* Check requested extents do not overlap with pending ones. */
> +                if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                         ext->start_dpa,
> +                                                         ext->len)) {
> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +                /* Check requested extents do not overlap with existing ones. */
> +                if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> +                                                   ext->start_dpa,
> +                                                   ext->len)) {
> +                    return CXL_MBOX_INVALID_EXTENT_LIST;
> +                }
> +            }
> +
> +            if (rc) {
> +                return rc;
> +            }
> +
> +            CXLDCExtentGroup *group = NULL;
> +            for (i = 0; i < in->ext_count; i++) {
> +                CXLDCExtentRaw *ext = &in->extents[i];
> +
> +                group = cxl_insert_extent_to_extent_group(group, ext->start_dpa,
> +                                                          ext->len, ext->tag,
> +                                                          ext->shared_seq);
> +            }
> +
> +            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> +            ct3d->dc.total_extent_count += in->ext_count;
> +            cxl_create_dc_event_records_for_extents(ct3d,
> +                                                    DC_EVENT_ADD_CAPACITY,
> +                                                    in->extents,
> +                                                    in->ext_count);
> +
> +            return CXL_MBOX_SUCCESS;
> +        }
> +        default: {
> +            qemu_log_mask(LOG_UNIMP,
> +                          "CXL extent selection policy not supported.\n");
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3669,6 +3771,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>           CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
>          cmd_fm_get_dc_region_extent_list, 12, 0 },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> +        cmd_fm_initiate_dc_add, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 9c2b9d197b..7676d785c2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1885,8 +1885,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
>   * the list.
>   * Return value: return true if has overlaps; otherwise, return false
>   */
> -static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> -                                           uint64_t dpa, uint64_t len)
> +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> +                                    uint64_t dpa, uint64_t len)
>  {
>      CXLDCExtent *ent;
>      Range range1, range2;
> @@ -1931,8 +1931,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
>      return false;
>  }
>  
> -static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> -                                                 uint64_t dpa, uint64_t len)
> +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> +                                          uint64_t dpa, uint64_t len)
>  {
>      CXLDCExtentGroup *group;
>  
> -- 
> 2.48.1
> 

-- 
Fan Ni (From gmail)
