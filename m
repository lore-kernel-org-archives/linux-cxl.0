Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED676C65
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jan 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549583; cv=none; b=NpPahzd0lJeTqd5rLtYLF/ajjMz4G0+TY4ThS805/FHmYK2zGxq/hWCYDz83WUOg5DWP7vhahRYJueE4sx4hw0tBX9T0ShcJfUauG0DBFVCF3FBOlpKNLqEnXGGQ4Yq/DFdsx+kKWfl7ZOn1q9fLYTYu103Npdefh9LhimeLzm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549583; c=relaxed/simple;
	bh=ejze1c6bKj5SY8gD5Dxcl3k61v4lY6LGocSmnrCjDq0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNEtY+lhgbWigwUqdqpBrBZ5Cic4SvyyDbcGd8MUSSjh7hJK9eA14pGyipkK7n3qZqKuiW5rC4hx+mPi+XVEZ9X+qNUjRv/Q/vLWcISciJmPoJmRXCwmFr6Afh+T1DIn6aGwzDT6KVkz6E7zxO4oI9h7/JXcU+Rb8PlfyGHEvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bihXNI9z; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bihXNI9z"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-600273605a9so30666987b3.1
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jan 2024 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706549580; x=1707154380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGNCyyidgcDrIuYHop/nlKKZHYmDs65dIr3jRdyCLXU=;
        b=bihXNI9zgfbROMy0CFCGDbnup5FaUa7VVOzuUzpJshLeeKp0kkAs9Q7jvq+BTxKJWU
         kWLKPEpUwD7LI4SxRUoY39fTPomrmB0wc/sp3zRDoswRac0bgissYe0u0SYrzgONqfet
         KophJVqtmZrGlKnq/UgKqroIAG4AlW6HYYJ61Ssr698jXNuu5ATujZznYOl2Sr0EiOz/
         4nhxm8acF6lyQpzJsv6Z2xplXPSkZAojlPXW57w+k1KWC85sabFvUpP446pLg65IPzVi
         +wTOo11rdwR+GLFZ54ZJPmDIOIaOPEqF1W+qNvAdXW1VzDtEvbUG47Zw/r6qpw7nngv3
         HIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549580; x=1707154380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGNCyyidgcDrIuYHop/nlKKZHYmDs65dIr3jRdyCLXU=;
        b=E7rm/UOvVJZdtgyrFhXdAeDTHOFBZ/3G2SS7yNogsOHlXx0TpQwhT4Ha42c6Ooq77H
         fij38ayNMk6CU1uN6T5iTMXh6Rpa7yCFmFFjXPjEPgd2vigfvTVB0G1cjf+sGBn+wSUE
         9wyHzRDSSSM2nkOJP13KfQ2PlTvJAqDQZKtsjlbpkA1SnUxiGprPx+6kJho8iii+JWdB
         VCZ5ziA8+QLd3lgHnc93SGfLlDy1UmKPLIG+6mbNLZ6V79+m0eXQ8L52onlraeEHBRNg
         +zCmyt2COnUHMR98Ml2R+AaeNnkcuFKqRJWI19ospAGT6CVKRyLsYIy7oiewcBspkJML
         n2kQ==
X-Gm-Message-State: AOJu0Yx6rx6MGjzj81yhMPoVp1IgqLcgtUsqNwmqpTf6NIxwQOT/LYl4
	SeO2F92scbrgBW/B8d0ZEmRDOJhOBuSbIpQVHvdrlbO/XyY8gswN
X-Google-Smtp-Source: AGHT+IGiDzIER4X4xUPDaZamPcqHc0Qf48ktmy/6mVn5WwSeFie+xe5V0VtfRTJPIPAYvl9cnxb2Aw==
X-Received: by 2002:a0d:d686:0:b0:5ff:73d8:216f with SMTP id y128-20020a0dd686000000b005ff73d8216fmr5090130ywd.17.1706549580553;
        Mon, 29 Jan 2024 09:33:00 -0800 (PST)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id bf15-20020a05690c028f00b00602f3e50c62sm2002479ywb.113.2024.01.29.09.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 09:33:00 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 29 Jan 2024 09:32:39 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, nifan@outlook.com,
	jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v3 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <ZbfhN5kVT7W3jvoU@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-3-nifan.cxl@gmail.com>
 <20240124145118.00002f7d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124145118.00002f7d@Huawei.com>

On Wed, Jan 24, 2024 at 02:51:18PM +0000, Jonathan Cameron wrote:
> On Tue,  7 Nov 2023 10:07:06 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per cxl spec 3.0, add dynamic capacity region representative based on
> > Table 8-126 and extend the cxl type3 device definition to include dc region
> > information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
> > Configuration' mailbox support.
> > 
> > Note: decode_len of a dc region is aligned to 256*MiB, need to be divided by
> > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > mailbox command.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Hi Fan,
> 
> I'm looking at how to move these much earlier in my tree on basis that
> they should be our main focus for merging in this QEMU cycle.
> 
> Whilst I do that rebase, I'm taking a closer look at the code.
> I'm targetting rebasing on upstream qemu + the two patch sets I just
> sent out:
> [PATCH 00/12 qemu] CXL emulation fixes and minor cleanup. 
> [PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1
> 
> It would be good to document why these commands should be optional (which I think
> comes down to the annoying fact that Get Dynamic Capacity Configuration isn't
> allowed to return 0 regions, but instead should not be available as a command
> if DCD isn't supported.
> 
> Note this requires us to carry Gregory's patches to make the CCI command list
> constructed at runtime rather than baked in ahead of this set.
> 
> So another question is should we jump directly to the r3.1 version of DCD?
> I think we probably should as it includes some additions that are necessary
> for a bunch of the potential use cases.
> 

Hi Jonathan,

Thanks for taking time to review the patches. 
I will redo the patches and make them align with cxl spec v3.1. Before
that, I need some clarifications.
As you mentioned above, for the next version, I will use upstream qemu + the
two patchsets you mentioned above as base, that is clear to me.
However, you mentioned Gregory's patches above constructing CCI command list
at runtime, I think you meant we should also include that patchset
before DCD so if DCD is not supported, the Get Dynamic capacity
configuration command will not be available at the first place, am I
right? If so, could you point me to the latest patches of the mentioned
CCI work I should use? I see the CCI rework patches, but not sure if we
should have them all or they are the latest.

Thanks,
Fan

> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 80 +++++++++++++++++++++++++++++++++++++
> >  hw/mem/cxl_type3.c          |  6 +++
> >  include/hw/cxl/cxl_device.h | 17 ++++++++
> >  3 files changed, 103 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 8eceedfa87..f80dd6474f 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -80,6 +80,8 @@ enum {
> >          #define GET_POISON_LIST        0x0
> >          #define INJECT_POISON          0x1
> >          #define CLEAR_POISON           0x2
> > +    DCD_CONFIG  = 0x48,
> > +        #define GET_DC_CONFIG          0x0
> >      PHYSICAL_SWITCH = 0x51,
> >          #define IDENTIFY_SWITCH_DEVICE      0x0
> >          #define GET_PHYSICAL_PORT_STATE     0x1
> > @@ -1210,6 +1212,74 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * CXL r3.0 section 8.2.9.8.9.1: Get Dynamic Capacity Configuration
> 
> As per the patch set I just sent out, I want to standardize on references
> to r3.1 because it's all that is easy to get.  However if we decide to r3.0
> DCD first the upgrade it later, then clearly these need to stick to r3.0 for
> now.
> 
> > + * (Opcode: 4800h)
> > + */
> > +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    struct get_dyn_cap_config_in_pl {
> > +        uint8_t region_cnt;
> > +        uint8_t start_region_id;
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_config_out_pl {
> > +        uint8_t num_regions;
> > +        uint8_t rsvd1[7];
> 
> This changed in r3.1 (errata? - I haven't checked)
> Should be 'regions returned' in first byte.
> 
> > +        struct {
> > +            uint64_t base;
> > +            uint64_t decode_len;
> > +            uint64_t region_len;
> > +            uint64_t block_size;
> > +            uint32_t dsmadhandle;
> 
> > +            uint8_t flags;
> > +            uint8_t rsvd2[3];
> > +        } QEMU_PACKED records[];
> 
> There are two fields after this as well.
> Total number of supported extents and number of available extents.
> 
> That annoyingly means we can't use the structure to tell us where
> to find all the fields...
> 
> 
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> > +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
> > +    uint16_t record_count = 0, i;
> 
> Better to split that on to 2 lines. Never hide setting a value
> in the middle of a set of declarations.
> 
> > +    uint16_t out_pl_len;
> > +    uint8_t start_region_id = in->start_region_id;
> > +
> > +    if (start_region_id >= ct3d->dc.num_regions) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> > +            in->region_cnt);
> > +
> > +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> 
> For r3.1 + 8 for the two trailing fields.
> 
> > +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> > +
> > +    memset(out, 0, out_pl_len);
> 
> As part of the cci rework we started zeroing the whole mailbox payload space
> after copying out the input payload.
> https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204
> 
> So shouldn't need this (unless we have a bug)
> 
> Jonathan
