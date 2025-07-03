Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7A231853
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 04:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751516490; cv=none; b=emPbNNWB+Zi2KGCwehf0tf9ZMWkPzdoyvZ3iHxb+S4f5VCxXRfzEJoDz03qDz9Ac4CJZlilOOVpT2xplEKBxZ7gu8ZhYRRnPpAiFWMmc+pQlMz3DaUGi7upcQe+LQCbVEvhJ4/AtK2PEY9OJeYlSXt1DxzWF5ZPL7WUEQ4FD8f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751516490; c=relaxed/simple;
	bh=wVHDrnt/e4O7SsdvI7CXkEktnNvKgKKRIPxzR7AMfGY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K67Igda7juDqGZCr3UZcjZ3Q0zcJWfVk2XH+96t660tqiKW20Q2/HEoD2v0MD1Gbnhtj0zZvxfeeMtufDjeNWF6aUGfHQn/XWypK77ReWAVunMbtcscSuwE1O5rVKnFsoMURq8a41jZyIRdsz5mOXv1sJhejtEvt7FCEac0AgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGgOlfy5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGgOlfy5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b52bf417cso944877b3a.0
        for <linux-cxl@vger.kernel.org>; Wed, 02 Jul 2025 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751516488; x=1752121288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fIDvlsSqSOw663I1UGN4vr15Etm6Ryjr1eAaJmR2aMo=;
        b=UGgOlfy57jDQXEnc7QvAuWfs7ki0N+76f+q9MLJatcv1WCwHlP7FaVqbdo8Pq8e4Rn
         /gmF9oLYBhGuJtpeBBtMbry9E407IBfvD3hd8SnGFGwFJ2suSKAR3rJO8ST5eHxL3NUo
         WYJO46FZEjISgE4cD2faPXT1oxtdc6LBoPk09AMoDxU0V0l324s1gVmcQfKGttoTk4Vz
         vvl/v3JYgxz8TuFW8yxwYlICYbH72oSgTgDzkQoxbqDRq2HTfPcBMEcw1YxWi0dU2Mre
         IwrSiu9gI2wnZ+t3zppomZ7frAt6L2p9ApnDaZVo735jKzn7g7U6xT1UNvwMksZgYO5R
         aXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751516488; x=1752121288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIDvlsSqSOw663I1UGN4vr15Etm6Ryjr1eAaJmR2aMo=;
        b=ZNVp52mkcWuHavdYkJpYzUBsUXkob8HAOjWv4IWqI8BSvwzRksJ22Ajdmxji4gD525
         cQB+1y2DxCHrZxzmiehJsNt23nBlNmsXeFm02nCK3VlMxsNkdHkb19d2XZY85SPdlflB
         4d/uA50mbqnTnJhXS9suY2M2Q9eq0gCqEc9XhcrJlYRg9TYmWpgDkrz38NpZKIBaSIov
         PYUi3Cjii95R9TJAkbWqp1RrSe0udmTyiooHoQBGUSGxkS5DueW8IYp4eN5mNGiUoH28
         LDy/XHZAbOuo0h9+mT8wyuu0U/LOlOERgy50o31jdBhOVB8F1PdUxtoa//4+drqatQvt
         +YVg==
X-Forwarded-Encrypted: i=1; AJvYcCUYIFufT4WdoBaiWTVCwcHVuoqN9FjcISI9SniNGN89oX1omxZtx9vM/g9Apt1FXSHWsCky0K7S0Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ccLZMcNY6Qc6kj5kHTkljw0d+3BFzMyxeT/vQXBK702q+j5t
	uLBHXtwOPzEYWQ0aY4DBei7VaqqeIFol3HwQGKlTXedInx/PlaIS6nem
X-Gm-Gg: ASbGnctE+eF/wzs80AK2+l2++RfQApWq12WCY1XREo0QqsDDuJTtbFA3GlgA1ItqIrA
	unZpve9dT5lrh3kmvhhhkmgHUAxTvhAMFJSxyqJRLZYzelDKoV+AZ+InsP5uY6SBFjJldDvoPaV
	2gMbHVUCR9OM4GoCC++oy6gU2dSgnVCXjK2xnkwg29LzA/XSBcvQhlcvSkRpK34kiB7eCb1vyfb
	5l5J5oUMljxzX9WMSzXmYFrSsGnLBZYT6KES5LshiK9EIj2G5mseNc4CHzGbeLWecFCccAGFSGR
	b33xabo+PE9Gt/p1CEoD2vF7S4QZ9Yn2rwgP/6hoPY9DrcKh8BM1z92QeNLy/lQq6w==
X-Google-Smtp-Source: AGHT+IGlupmibsI0pDmwjQl9fWAcuiv3qmPcB8r84N+pV87Txa7MPZdLwiYlKauTpNkaB3moTPSiYg==
X-Received: by 2002:a05:6a20:9d91:b0:20a:bde0:beb9 with SMTP id adf61e73a8af0-224096f882amr3187133637.1.1751516488205;
        Wed, 02 Jul 2025 21:21:28 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31da5f2sm14115461a12.58.2025.07.02.21.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 21:21:27 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 04:21:25 +0000
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 10/10] cxl-mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Message-ID: <aGYFRdm7SEGbE6pu@smc-140338-bm01>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
 <20250626222743.1766404-11-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626222743.1766404-11-anisa.su887@gmail.com>

On Thu, Jun 26, 2025 at 10:23:33PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
Minor comments inline ...

>  hw/cxl/cxl-mailbox-utils.c | 79 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 787eeaa7b9..87f9535d46 100644
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
> @@ -3638,6 +3639,77 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>      }
>  }
>  
> +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
> +#define CXL_FORCED_REMOVAL_MASK (1 << 4)
> +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */

/* CXL r3.2 Section 7.6.7.6.6: Initiate Dynamic Capacity Release (Opcode 5605h) */

Fan

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
> +            /* Fail with Invalid PA if an extent is pending and Forced Removal
> +             * flag not set
> +             */
> +            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
> +                for (i = 0; i < in->ext_count; i++) {
> +                    CXLDCExtentRaw ext = in->extents[i];
> +                    /* Check requested extents don't overlap with pending extents. */
> +                    if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                             ext.start_dpa, ext.len)) {
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
> @@ -3772,6 +3844,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
> 2.47.2
> 

-- 
Fan Ni (From gmail)
