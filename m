Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865F130E3A
	for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974990; cv=none; b=CygLi94AN6v0Nm3Y2dR2EtZbiOCpnJRYTsNLrwchJWC+bdokafBiVAbTgZaMXv/0ORdTtVZ1v9zZM8TtGviXpGTg+hAYeqW5ZmKM2NyLseKnkM/hYMzTXEg5ISZE69rALCcCBs4Z+F/AclOUQ1kcVEXu9NFf6G8bxGto3NewmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974990; c=relaxed/simple;
	bh=M/jJZRsBTjAYqCtxb3qWC6tNNjpBLjX1ADSc23lMlK8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGNSD8sMNPmdHKepiJwNSmuJ+4LHzjMXBHsnBXQtTYZ8RcpQXFtZJo4ApMKnT64v6rGiN4190I6Z1jNmCaVVYIYjWFK82Zu0XlUCETdixi+qRgUB7L5BjAg+IMweeuCudSrTF7uJt47epluOZf3MQKnn/Av8Q3LqIUGap/CRrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al9lKH+z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al9lKH+z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so15880965ad.3
        for <linux-cxl@vger.kernel.org>; Mon, 26 Feb 2024 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708974988; x=1709579788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqppujVJJ0rI4ZpT//c1Xe6xAYyom1X8ghHe7JufE2o=;
        b=Al9lKH+zn8/gcKwE4irngc6qQxkyBNr1GgVOabbxr62J29rnp12l/W0MgsyHSNUf8X
         IxkaDt4/+UosRr5uMolKdyhiG+od5y+C7W5QihWv0aE1kTZgI3bZJ+Pxs6yf434tMvmj
         D3wLmKL4lTqrAmzQllXQED08INR2HGeexmCqapT1TEBkKDAOP17k4uI0uqurAXJFhvEz
         uP7jOl/XX5wpMBdemKNuLHuEX8/FZ3FS+Uk2NWHksFNtjPP2QW3LmuOMECSyyIUaPRb/
         zoLp6QSV6QqzGbZ6mlCXzWLpU0jC6+lpsEKHRizEwzAl+kL1pXhOilm5M+S6CywcSnVO
         +W2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974988; x=1709579788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqppujVJJ0rI4ZpT//c1Xe6xAYyom1X8ghHe7JufE2o=;
        b=Enk2qhfeV6jjw/FHdjJZQfQPiZY+TA/cW4nCTYm34GUXcTwYd+x3XbzRhsfgWjGnda
         WOmx3Us5h5QPY0e1SlHvQaMPiDIEbGHiQ5+yb3TT6MH7w9e/n7Sl2b9W5oITYK72fuKx
         KE/X9ZSJyV8NWNt+HK97ZfasXUPAewHfEhyDtnMvJMj2jBXCHuUcuKAI1QSk+/c+3TaI
         KBTvuNqY3kL5EyG8xC6P5Cmq6O8fGTZj68bgmV7Ocep0udWWkNrzaxzti8Jd+fKctf3M
         /usY87SH9S4XIlxRuobkVdvZcDRaBoq2sj5l5y4jn5+JymzI1RJYEcH1h3I+B2mHC7cz
         DrIg==
X-Forwarded-Encrypted: i=1; AJvYcCVunca2Tcqk2pKgQRzYgA44klPmOTIFdNDNSvqXgeivhOsyb7zGKyUV4y7YFTBl9xvp3RVFgKfZfgxRvigCCe1oFDHkfxXRt+N5
X-Gm-Message-State: AOJu0Yx+bzuOQ1XTZM2r/7XKRWmM7K923LGyW6KcO9tps1N99dEKN5er
	RAByiRxnWCMaNm52T9ii43BneyY5jhRYu3LInGnNPPmzyhFWTQ0F
X-Google-Smtp-Source: AGHT+IG3nXfZhAaKrbrY8fNOROq+h62rUs3DUBj9PRQx77+/PjT7OTn1l9w9lO7aQKjOuK0yzKm4NQ==
X-Received: by 2002:a17:90a:a383:b0:299:17a7:c441 with SMTP id x3-20020a17090aa38300b0029917a7c441mr5566446pjp.42.1708974987998;
        Mon, 26 Feb 2024 11:16:27 -0800 (PST)
Received: from debian ([2601:641:300:14de:6185:5882:dd39:9005])
        by smtp.gmail.com with ESMTPSA id sh14-20020a17090b524e00b00298ca3a93f1sm7128555pjb.4.2024.02.26.11.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:16:27 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 26 Feb 2024 11:16:09 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <Zdzjef3y1SjRCc5L@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-3-nifan.cxl@gmail.com>
 <20240226173317.0000299d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226173317.0000299d@Huawei.com>

On Mon, Feb 26, 2024 at 05:33:17PM +0000, Jonathan Cameron wrote:
> On Wed, 21 Feb 2024 10:15:55 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per cxl spec r3.1, add dynamic capacity region representative based on
> > Table 8-165 and extend the cxl type3 device definition to include dc region
> > information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> > Configuration' mailbox support.
> > 
> > Note: decode_len of a dc region is aligned to 256*MiB, divided by
> > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > mailbox command.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Hi Fan,
> 
> A few comments inline.
> 
> Jonathan
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  16 ++++++
> >  2 files changed, 126 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index ba1d9901df..88e3b733e3 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -22,6 +22,7 @@
> >  
> >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >  #define CXL_DC_EVENT_LOG_SIZE 8
> > +#define CXL_SPEC_AFTER_R30
> As below. Drop this.  Kernel code needs to be able to cope with newer specs
> than it understands anyway so should be fine with the larger records (otherwise
> it's buggy and needs fixing!) 

Will remove it.
> 
> >  
> >  /*
> >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > @@ -80,6 +81,8 @@ enum {
> >          #define GET_POISON_LIST        0x0
> >          #define INJECT_POISON          0x1
> >          #define CLEAR_POISON           0x2
> > +    DCD_CONFIG  = 0x48,
> > +        #define GET_DC_CONFIG          0x0
> >      PHYSICAL_SWITCH = 0x51,
> >          #define IDENTIFY_SWITCH_DEVICE      0x0
> >          #define GET_PHYSICAL_PORT_STATE     0x1
> > @@ -1238,6 +1241,103 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
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
> Type not needed - see below. 
> > +        uint8_t region_cnt;
> > +        uint8_t start_region_id;
> > +    } QEMU_PACKED;
>    } QEMU_PACKED *in;

Get your point, it seems I followed the wrong example like
cmd_media_clear_poison and cmd_inject_poison :-<

Fan

> 
> > +
> > +    struct get_dyn_cap_config_out_pl {
> Don't think giving this a type is necessary - see below.
> > +        uint8_t num_regions;
> > +        uint8_t regions_returned;
> > +        uint8_t rsvd1[6];
> > +        struct {
> > +            uint64_t base;
> > +            uint64_t decode_len;
> > +            uint64_t region_len;
> > +            uint64_t block_size;
> > +            uint32_t dsmadhandle;
> > +            uint8_t flags;
> > +            uint8_t rsvd2[3];
> > +        } QEMU_PACKED records[];
> > +        /*
> > +         * if cxl spec version >= 3.1, extra output payload as defined
> > +         * in struct get_dyn_cap_config_out_pl_extra comes here.
> > +         */
> > +    } QEMU_PACKED;
>     } QEMU_PACKED *out;
> > +
> > +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> > +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
> 
> We've (mostly) use the (void *) casting where we haven't given the structures
> a type.  I think I'd prefer we kept to that style for consistency.
> 
> There is an argument we should have given all these types
> for readability reasons and to avoid casting via void * but
> we have gone this way now - with the exception of
> the poison list - oops.   
> 
> > +    uint16_t record_count = 0;
> > +    uint16_t i;
> > +    uint16_t out_pl_len;
> > +    uint8_t start_region_id = in->start_region_id;
> > +#ifdef CXL_SPEC_AFTER_R30
> 
> Handy for testing, but I'd drop the ifdef for the final
> version.  We don't need to support old specs.
> 
> > +    struct get_dyn_cap_config_out_pl_extra {
> > +        uint32_t num_extents_supported;
> > +        uint32_t num_extents_available;
> > +        uint32_t num_tags_supported;
> > +        uint32_t num_tags_available;
> > +    } QEMU_PACKED;
> > +    struct get_dyn_cap_config_out_pl_extra *extra_out;
> As above, anonymous structure should work ok.
> > +#endif
> > +
> > +    if (start_region_id >= ct3d->dc.num_regions) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> > +            in->region_cnt);
> > +
> > +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> > +#ifdef CXL_SPEC_AFTER_R30
> > +    extra_out = (struct get_dyn_cap_config_out_pl_extra *)(payload_out +
> > +            out_pl_len);
> > +    out_pl_len += sizeof(struct get_dyn_cap_config_out_pl_extra);
> > +#endif
> > +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> > +
> > +    out->num_regions = ct3d->dc.num_regions;
> > +#ifdef CXL_SPEC_AFTER_R30
> > +    out->regions_returned = record_count;
> > +#endif
> > +    for (i = 0; i < record_count; i++) {
> > +        stq_le_p(&out->records[i].base,
> > +                ct3d->dc.regions[start_region_id + i].base);
> Qemu allows a couple of style choices, but don't think this matches any of them.
> https://elixir.bootlin.com/qemu/latest/source/docs/devel/style.rst#L79
> 
> My preference is immediately after opening bracket.
> 
> 
> > +        stq_le_p(&out->records[i].decode_len,
> > +                ct3d->dc.regions[start_region_id + i].decode_len /
> > +                CXL_CAPACITY_MULTIPLIER);
> > +        stq_le_p(&out->records[i].region_len,
> > +                ct3d->dc.regions[start_region_id + i].len);
> > +        stq_le_p(&out->records[i].block_size,
> > +                ct3d->dc.regions[start_region_id + i].block_size);
> > +        stl_le_p(&out->records[i].dsmadhandle,
> > +                ct3d->dc.regions[start_region_id + i].dsmadhandle);
> > +        out->records[i].flags = ct3d->dc.regions[start_region_id + i].flags;
> > +    }
> > +#ifdef CXL_SPEC_AFTER_R30
> > +    /*FIXME: need to set valid values in the future*/
> 
> We need to do that before upstreaming..
> For tags, 0 is fine for now.
> 
> For extents allow say 512 and count how many are in lists
> I guess then subtract that.
> 
> > +    stq_le_p(&extra_out->num_extents_supported, 0);
> > +    stq_le_p(&extra_out->num_extents_available, 0);
> > +    stq_le_p(&extra_out->num_tags_supported, 0);
> > +    stq_le_p(&extra_out->num_tags_available, 0);
> > +#endif
> > +
> > +    *len_out = out_pl_len;
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> >  #define IMMEDIATE_DATA_CHANGE (1 << 2)
> >  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > @@ -1282,6 +1382,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >          cmd_media_clear_poison, 72, 0 },
> >  };
> >  
> > +static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
> > +    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
> > +        cmd_dcd_get_dyn_cap_config, 2, 0 },
> > +};
> > +
> >  static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> >      [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
> >      [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
> > @@ -1487,7 +1592,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
> >  
> >  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
> >  {
> > +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> > +
> >      cxl_copy_cci_commands(cci, cxl_cmd_set);
> > +    if (ct3d->dc.num_regions) {
> > +        cxl_copy_cci_commands(cci, cxl_cmd_set_dcd);
> > +    }
> >      cci->d = d;
> >  
> >      /* No separation for PCI MB as protocol handled in PCI device */
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 3cf3077afa..6df7fecdf1 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -422,6 +422,17 @@ typedef struct CXLPoison {
> >  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> >  #define CXL_POISON_LIST_LIMIT 256
> >  
> > +#define DCD_MAX_REGION_NUM 8
> Really trivial but call this 
> 
> DCD_MAX_NUM_REGION because it's the maximum number of
> regions. The maximum region number is 7 (as zero indexed).
> 
> > +
> > +typedef struct CXLDCDRegion {
> > +    uint64_t base;
> Probably makes sense to call out that bas also aligned to 256 MiB
> as not immediately clear the comment applies to both.
> Easiest will be to duplicate it.
> > +    uint64_t decode_len; /* aligned to 256*MiB */
> > +    uint64_t len;
> > +    uint64_t block_size;
> > +    uint32_t dsmadhandle;
> > +    uint8_t flags;
> > +} CXLDCDRegion;
> > +
> >  struct CXLType3Dev {
> >      /* Private */
> >      PCIDevice parent_obj;
> > @@ -454,6 +465,11 @@ struct CXLType3Dev {
> >      unsigned int poison_list_cnt;
> >      bool poison_list_overflowed;
> >      uint64_t poison_list_overflow_ts;
> > +
> > +    struct dynamic_capacity {
> > +        uint8_t num_regions; /* 0-8 regions */
> > +        CXLDCDRegion regions[DCD_MAX_REGION_NUM];
> > +    } dc;
> >  };
> >  
> >  #define TYPE_CXL_TYPE3 "cxl-type3"
> 
