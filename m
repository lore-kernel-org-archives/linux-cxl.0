Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3771A9B3D
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749235436; cv=none; b=g6VDvOGZp2Gc/i0a8HAFgIFn6Fc5Ty1/nm/wd5UIQ2wzQ/Hxn5hCTuzpIh++74QTLoePuRfuSNlleMl0D5Sphqo7b/sRSrhBexL2IZ4CH93tBit4lFQCIvdO9d7rlHnNgurK6iF6bqjBPJqZmign4tElkHOUG7KLrGIvAgXj3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749235436; c=relaxed/simple;
	bh=iTdwQD+n8COZv/3weoVio2xEQJgs5fplpffYLrafzFM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttyWeGKFEVAuRPWNpdaXn7q0SClWapvkjBSkwf1D+rNyuSqsPNzLmzLRPt6Ul80NUU0I+fuRxNvcsIcjZicKcdVm5MAL4YyEE2DeQ7GAPRJG4lajHrt2vkWU/HRhTfzqFCgmFqmTSuasLh4NUaOHt5jWwfbdZx1+M+/kPshlqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0TFy3wv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0TFy3wv"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22d95f0dda4so31325355ad.2
        for <linux-cxl@vger.kernel.org>; Fri, 06 Jun 2025 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749235434; x=1749840234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mhv/7vS6onvDQS4kU+erZtxBqbLvtfmSsjoBZc0m6TY=;
        b=X0TFy3wvsnyL5vNVGYbOzOrxaWsn/roBBksq3OuSEXoMRBrwQtMvCgFt8jtVmHhnoj
         ElWAjfZwcWRkIs8gGfYhCOh+eQ5eZU7+iLmaQLDlSyIV2Qn2AIBpkXjkKnlEiH1wuZXA
         DGJRvB68vvN6R8aw2/UMGjS9+yuhRTuZpY3h8bdEB5T13iIMUB+vgRsTle4hu0ikdSuc
         fgGiZxjPyzr1sswodQc5u/fEnup9BB3PIUgktPGiKinZ/F6NuF0xx10e+fBX9o/5FBF1
         M2mxmDVZ1bgYPAFk1qoNi38Rjx3MhmB7oT9Y4HehAsHf7bpGXevQTp0PO5gHlNs1m9bp
         sVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749235434; x=1749840234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhv/7vS6onvDQS4kU+erZtxBqbLvtfmSsjoBZc0m6TY=;
        b=ul4OPbmiedSN3CwJvekdm1DGtPiE+9PwW5vDsg6/7h81R6ye4x8fQkVpr4f6orR3oj
         qjiOu/URL/uKjeNkqK/QYA2BIc4U+De/ce7a/QtiWiz9g+p0+uyCeae0qpV8ClpoQiEU
         zyz+4kXvTTTIgLZOxWAoGgnaCgnyRSPOK3lqC/SDyOu7ti4aVEGwDn/IqYie0ylubq5o
         0DZi94KsZVYw0V4EOHX6cPsT/2twxrRa9B8fYF1SgKKWE75E2AhwqmEhM9ZMel408CZi
         uidRo6HDKW9+TGmTMobVB13sshdYHGbBFnBvDnM8TFI80nSiWAGzb8tAK+GIs+xsLS4I
         2yFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv6fLhX6Ll9iA16eqd3TAXp6WUAbTQPoJ5dh737x11F3nmHitt8epvVB+gLuoixC5znzJ/y4VYquw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0IW2rH7kUnyUEbXZENMocr9lF35y4qdfADRYw3Y6b5MH9oodN
	L7AwEfW7EgxIJlkcQJxXOoWmN9VaMFH8WoNZaGjIoH98J6vNFDEEOUQJ
X-Gm-Gg: ASbGnctulk/tIyZ7oMIi9zIGFToTr+DpTAiAMtRWwR7Wb4nrFRFAJdWO+en736fRG8W
	0r9lne3CCybM+fWnjR/J6aSvdTflnCqoj92ytVb2rTDYckWuvthWMSiBh0hZ4SHMYq07yM1DFfw
	eeeR9CKYNkb+mfpTObJE94QtqFJOBFrZH4b/v0stGXSYqXxpSij4loiUcPdPs5N8F2YnaI8GwFa
	Pfb0Uqf6/KCH0Fs765xAF3fk+Si/Q+yONbrQobsrSznK+BaMsnsXqY6pbHkJRw9VCnRc6kVIKSx
	ws36xxgjTyGp4CQRavZaQ7cr9YUU8TIk8B2fREJHUPt15g==
X-Google-Smtp-Source: AGHT+IHIN9GBxzwrNzoZfcy0V1hXqGtfx43t6qLxVC2WhfNFmXSFsrzjCVgmUj8VZLBUHn0L75ParQ==
X-Received: by 2002:a17:902:f54f:b0:234:8ec1:4ad3 with SMTP id d9443c01a7336-23601d71b8bmr68810945ad.40.1749235434045;
        Fri, 06 Jun 2025 11:43:54 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5ef88914sm1487793a12.33.2025.06.06.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 11:43:53 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Jun 2025 11:43:51 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Message-ID: <aEM25yCeErixfi0l@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-10-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605234227.970187-10-anisa.su887@gmail.com>

On Thu, Jun 05, 2025 at 11:42:23PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

See below ..

> ---
>  hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7ee5be00bc..6c57e0deac 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -124,6 +124,7 @@ enum {
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
>          #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
> +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
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
> +    CXLUpdateDCExtentListInPl *list;
> +    CXLDCExtentList updated_list;
> +    uint32_t updated_list_size;
> +    int rc;
> +
> +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> +        list = calloc(1, (sizeof(*list) +
> +                          in->ext_count * sizeof(*list->updated_entries)));

Use g_malloc() and free with g_free();

> +        convert_raw_extents(in->extents, list, in->ext_count);
> +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> +        if (rc) {
> +            return rc;
> +        }
> +        rc = cxl_dc_extent_release_dry_run(ct3d,
> +                                           list,
> +                                           &updated_list,
> +                                           &updated_list_size);

This seems not right.
this is only fm issue dc release request, not host release dc extents to device.
So we should follow what we did in the qmp_cxl_process_dynamic_capacity_prescriptive()
for release case.

One thing that I can see that making the workflow is different is that, we check
the extent list with the pending list to make sure fm is not trying to remove
non-accepted extents, but the host release extent workflow does not need to do
that as it is filtered out in the first place when fm sends the request if it is
from FM.
I have to admit, existing qmp interface can be improved to remove some condition
checks as they are kind of duplicate.
For example, if an extent is still pending, it will not be set in the bitmap, so
we can still tigger the error if it happens by removing the pending list check.
One justification is that the error message is different for a non-existing
extent and a pending extent, which is useful for a dmp interface.


Also, the case to detect exhausted resouces is not different, FM can request to
release a lot of extents, but what the host actually does can be a subset or
none.

Fan

> +        if (rc) {
> +            return rc;
> +        }
> +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> +                                                     DC_EVENT_RELEASE_CAPACITY,
> +                                                     in->extents,
> +                                                     in->ext_count);
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +            "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
