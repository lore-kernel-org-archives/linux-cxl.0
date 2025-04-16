Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8271ACEBE
	for <linux-cxl@vger.kernel.org>; Wed, 16 Apr 2025 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744838741; cv=none; b=cBtGYHHo3XjSSQykXRoElknrs8WIZbqNLMsXxGCDUgjVVTuH/V0Gf18mqMMnOF/mI/EP6HXqduUHU2p9SCzMoPx9es0kLVUJuWMH+h6MSnC5mdFRrzL59lFz12UOP2pUo7NJHq6T/bORTo8pgvLPtiBScP1Wv/3c1SJT4EVO9sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744838741; c=relaxed/simple;
	bh=SOj+/HWLUmY/uGW83Yk7kNRhqVlcC2e/KAEXIHszpLQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl9+4JT5Wt/AAaskc9Pc2PPPD78WO0J8azxUjRPwrbKNMnW90sGJe+zhq0UYFqgu01rRTrAuHHZELrbgn7mv6JHDlj8X0IBQ3GA+xUXfaxrGso2zOiAWoTblNdngq2OywCf2qMwg67TWGts/F0WEt4W6rnpTumDcCUpWk7sKn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhHGG5tw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhHGG5tw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c33e5013aso1702365ad.0
        for <linux-cxl@vger.kernel.org>; Wed, 16 Apr 2025 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744838738; x=1745443538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAEUDZKbLPgza5DZtsu0FJyh6PwlcfTu2jJWNYque1Y=;
        b=PhHGG5twEg01z/NPgh+Yed7BlRdL9fT5YjI149iKhJANZqfQO0cBgorE/k6+bKUtJo
         dcBWL52cddx4ijhLHl19ncekhwXl6Hh0UqeIYHQrx0mOaEgjU6MXY9wrwokua6eC870P
         gSRAAbhNY3sj/xpjiyFwb2d0K5PXFdqtK61h7922BGWHzRs0h7ZH5sL2gA2H0I8YVaWx
         9T64Iuuy1qX/seLQaA9XeSJ/a44YNFMFr69uo3oSVKHMegQovG1MWKOLlWsNFN++OKEF
         x+jamZHwfsBNtlUMc4RYAFMvxt/ElDCrh4+O6H1vvPdC5YXKacVjS2M85DbwBQMU9SDz
         xdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744838738; x=1745443538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAEUDZKbLPgza5DZtsu0FJyh6PwlcfTu2jJWNYque1Y=;
        b=FV5voZp9q2c5b80Z8KG6SJIshij9TLJ/jGE58pR+UrOh1d32R5a7lY4MRlNj7PhsgL
         6O03p46SB0iykqV0NGAcONrRBT7NG9qmeFv+oOsXc65zMbEDyTpryzXCpVbiwqDEi+W7
         MpVfH7+yEwQ5BGI1q0VNwwLH2nwA1Of4TLQTgdVhGpHwP1+3i14M4l3ZLn+0htJYr/8I
         9bfn/R5tQzkOBTJgIvfLmVHqcVpu0flfe7edUZz2Pv0tk8hP8FztRQieF1m50v5bFrQ+
         PkjsU3Vn8vQRf4ngu3wNWceJrZPyu9fy55hVdTVbaFUEp/+SpumACGmTdANyoHbsdw6r
         cqqg==
X-Forwarded-Encrypted: i=1; AJvYcCUqHvHIt8dzxx22qxArxH3nt5qKkVdeC+g6JIZ/DumG9rpWkj/OIFpUXYcEXIZ0BBFv0Y1vW9qshTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTVETuRziuv6wNByFrpGyh8791d2gDfQifj0opzWqRvnmyaiFE
	0j9xw/wi5kSMRx9OJqVP1IgG38ZRnHzz6kf6wSKlhYde1P0KT/Yp
X-Gm-Gg: ASbGnctXT6Q5BEU1DxsPM1Om9Cfv5JZBlHlqjOxyYuWu2AgYxUiWkR8m1NPPi8OKfxD
	qq7L9mnM6cwYKuWwpWEyQfW2vNe0dvVH0aSeGFVOwVgVzf2xC6ZIEZQiD0OhnIM4aJZvRDjJTsK
	VVnIbXyUJNHuA7tQxivFVwvMEGyT2S8jbv+WejoOxplVkLIB2yuhEkiWM+i8Ff8JXHN/Khi5mBV
	928GWYhMBtDJGIX+8/etX2ICDLyN+Kg1IKjgMTdrtMd/jJUBAbgHMvPEUZHzAhxHGPtQpMWMPHk
	iBhWuqlK4VWybN56eRCekT1lBR99wdkI8pYnTR40aJcwGvMV/07MiNbtz1YOciy/mtXtoaMtncP
	pFA==
X-Google-Smtp-Source: AGHT+IGP3CPy6p8wued0F90EC+c8Pvvq25w8rVHX8qBnidg5TnYXPH4w3uHp5M00MdN4ml26InZEhg==
X-Received: by 2002:a17:902:eb8a:b0:224:2200:5940 with SMTP id d9443c01a7336-22c3596b995mr66522655ad.38.1744838737875;
        Wed, 16 Apr 2025 14:25:37 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308537cdb13sm2663562a91.0.2025.04.16.14.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:25:37 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Apr 2025 21:25:34 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <aAAgTjeapPWpXhjt@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-3-anisa.su887@gmail.com>
 <20250318155624.00006410@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318155624.00006410@huawei.com>

On Tue, Mar 18, 2025 at 03:56:24PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:29 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 67 ++++++++++++++++++++++++++++++++++++++
> >  hw/cxl/i2c_mctp_cxl.c      |  6 +++-
> >  2 files changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 1b62d36101..e9991fd1a7 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -122,6 +122,8 @@ enum {
> >          #define MANAGEMENT_COMMAND     0x0
> >      MHD = 0x55,
> >          #define GET_MHD_INFO 0x0
> > +    FMAPI_DCD_MGMT = 0x56,
> > +        #define GET_DCD_INFO 0x0
> >  };
> >  
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3341,6 +3343,62 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h)
> > + */
> 
> Single line comment should be fine here.
> 
> > +static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
> > +                                      uint8_t *payload_in,
> > +                                      size_t len_in,
> > +                                      uint8_t *payload_out,
> > +                                      size_t *len_out,
> > +                                      CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint8_t num_hosts;
> > +        uint8_t num_regions_supported;
> > +        uint8_t rsvd1[2];
> > +        uint16_t add_select_policy_bitmask;
> > +        uint8_t rsvd2[2];
> > +        uint16_t release_select_policy_bitmask;
> > +        uint8_t sanitize_on_release_bitmask;
> > +        uint8_t rsvd3;
> > +        uint64_t total_dynamic_capacity;
> > +        uint64_t region_blk_size_bitmasks[8];
> > +    } QEMU_PACKED *out;
>     } QEMU_PACKED *out = (void *)payload_out;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDCRegion region;
> > +    int i;
> > +
> > +    if (ct3d->dc.num_regions == 0) {
> > +        return CXL_MBOX_UNSUPPORTED;
> > +    }
> > +
> > +    out = (void *)payload_out;
> Why not just do this at declaration above?
> It is harmless to set it then even if we exit earlier
> I think.
> 
> > +
> > +    /* TODO: num hosts set to 1 for now */
> 
> Unless this changes later in the set, no need for a todo here.
> This simply denotes what we are emulating. Maybe we will make
> it more flexible in future, maybe not.
> 
> > +    out->num_hosts = 1;
> > +    out->num_regions_supported = ct3d->dc.num_regions;
> > +    /* TODO: only prescriptive supported for now */
> 
> Likewise, not a todo that needs comment. Just a current setting.
> As long as we never make it nor support this we are fine for
> compatibility etc.  The CXL stuff doesn't support migration anyway
> so not problems there.
> 
> > +    stw_le_p(&out->add_select_policy_bitmask,
> > +             CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE);
should be
BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE)
> > +    stw_le_p(&out->release_select_policy_bitmask,
> > +             CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE);
should be
BIT(CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE)

-Anisa
> > +    /* TODO: sanitize on release bitmask cleared for now */
> 
> As with above, not really a todo, more of a choice made for now.
> 
> > +    out->sanitize_on_release_bitmask = 0;
> > +
> > +    stq_le_p(&out->total_dynamic_capacity,
> > +             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
> > +
> > +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +        region = ct3d->dc.regions[i];
> > +        memcpy(&out->region_blk_size_bitmasks[i],
> > +                &region.supported_blk_size_bitmask, 8);
> 
> sizeof(out->region_blk_size_bitmasks[i]) 
> 
> > +    }
> > +
> > +    *len_out = sizeof(*out);
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3462,6 +3520,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> >                                       cmd_tunnel_management_cmd, ~0, 0 },
> >  };
> >  
> > +static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> > +    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
> > +        cmd_fm_get_dcd_info, 0, 0},
> > +};
> > +
> >  /*
> >   * While the command is executing in the background, the device should
> >   * update the percentage complete in the Background Command Status Register
> > @@ -3764,7 +3827,11 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
> >                                             DeviceState *intf,
> >                                             size_t payload_max)
> >  {
> > +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> >      cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
> > +    if (ct3d->dc.num_regions) {
> > +        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
> > +    }
> >      cci->d = d;
> >      cci->intf = intf;
> >      cxl_init_cci(cci, payload_max);
> > diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> > index 7d2cbc3b75..df95182925 100644
> > --- a/hw/cxl/i2c_mctp_cxl.c
> > +++ b/hw/cxl/i2c_mctp_cxl.c
> > @@ -46,6 +46,9 @@
> >  /* Implementation choice - may make this configurable */
> >  #define MCTP_CXL_MAILBOX_BYTES 512
> >  
> > +/* Supported FMAPI Cmds */
> > +#define FMAPI_CMD_MAX_OPCODE 0x57
> > +
> >  typedef struct CXLMCTPMessage {
> >      /*
> >       * DSP0236 (MCTP Base) Integrity Check + Message Type
> > @@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> >          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> >                msg->command_set < 0x51) &&
> >              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> > -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> > +              msg->command_set >= 0x51 &&
> > +              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {
> 
> Hmm. There is a visibility problem here we should address but probably not
> by introducing a new define.  Maybe we should move the enum from
> cxl-mailbox-utils.c in a precursor patch.
> 
> Jonathan
> 
> 
> >              buf->rc = CXL_MBOX_UNSUPPORTED;
> >              st24_le_p(buf->pl_length, len_out);
> >              s->len = s->pos;
> 
