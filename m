Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E086FB9
	for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707386; cv=none; b=NikSDLlihpj6W16lkGwoixyGl12AEtLARIGehEbK1yu0HUnLTHtNVQhOwdRTA54/nKcKJB64HAvZtgNGcFS8ecyxIoPOmw5RhG/f6Qg0xRcDW5HcjNwf50SGAJqwapO41oGJWtRPOnBcrZgBKx+I8nNJNXNDx/9/8HKIRew9N+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707386; c=relaxed/simple;
	bh=W0cje3ZRNK+tgmauHC0CD1C0W7teFFBb9AQTVDYxExM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aic42WOdconDD2aLw2IlbGWvRPCfAwmQSCLirZ5JHmv3T/JQYDkM63VBTtnkqwpfTLYzG097EvaO1AbFG1mzB5ezGBZ8EOMY7SUgz3kE73F2n/l9YBwHqU3I9swM9Po/sweVSKoQJsz/dufXUvcnhVj9ecYptXnpZmE8vgD6ECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgC3jvhk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgC3jvhk"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so490636a12.1
        for <linux-cxl@vger.kernel.org>; Fri, 23 Feb 2024 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707384; x=1709312184; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqxkXBb6PhFa+1UMisoz0rLwEEh0zgLzrj88ji9tSBE=;
        b=ZgC3jvhk5QKIIlRG2HPygeZ/9s2cqk7JMuEPSLMelx9VcCrxdA1R7h0HXR+iod1gs+
         GwEMqRcL6DamrA3LGONHb2KvN9hT0A87HCzOBkZXIZfoecLjCV+xY2TUKLYzwsljSAjI
         zoGPf3OydsFu5OdPhsVYyy6wLjXAX4VlAhcocS4MJsIx+NXhjbNrDL9cyWsjoZLcDm8+
         s6ASdAHNpQUegmr7GijClkcJhHAnWN84Pi85fCyk/f/XpEBREYfBDhKfD09k+e7D43NO
         VxNK22Sp6iPV9hpjT2g6ZOz3N65/ecsc8Bh2+Y8ZWC06DFGmeOPmIZa8Cz5swUyIzMA5
         Er4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707384; x=1709312184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqxkXBb6PhFa+1UMisoz0rLwEEh0zgLzrj88ji9tSBE=;
        b=gOVTshhufuxn2RJ8lELCf8cJr9gKFIvfiEE8iRAHqc6xErEuOL2NIDmlenEByrglQv
         1+H4S5zl/ILawhvGV8jtJHHJzcAssvpx3zW/VJtCje+p8fPlPB9nchkSKonEq5SHaG1p
         PGHGPNGflItC7XSkKdxaIhYy2D9rhEjyEfO63JWVDioyxqZv/BqgVpQ10oj0ymZotnnX
         wKHxBokOfq89GkpP/5sQWEf1U0argJgNytMiOwltCfsJcjQQMYcMPcKd1m4ciz/03+/2
         CNdQFyychV2nw+t0aUG41Of2QWIZ+zb8Ubg8PgrkydeCwvkIPVThdCivOYfWG3FHCuTZ
         d/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUJQEFH2Zwl1AmsK+p2jNBpgPIYm0/Cd8X6Scy7ZwVhsW52nPCZ458k1aTmnE9u+3cBO7kRhTZq6kwROaX0XW81eU534MKCN3SG
X-Gm-Message-State: AOJu0YxpbXg0iYCt3LdWfBl7DReHPq8xUvuTRu3y5ZdcTuQXKpiUaFZI
	xXnFQDilsZugJ5QmyHM5tY47hQKLIAfJq2MmGIuzc8+0s0pwasJp
X-Google-Smtp-Source: AGHT+IHglsYhoWeG3jZSwWCRSwZ9e5fr4Q2O6UQV67X9L0DgRTBvHxYp69k21a8PrRmiUC0+SMfWww==
X-Received: by 2002:a05:6a21:3987:b0:1a0:dfc8:9ddd with SMTP id ad7-20020a056a21398700b001a0dfc89dddmr465920pzc.6.1708707384208;
        Fri, 23 Feb 2024 08:56:24 -0800 (PST)
Received: from debian ([2601:641:300:14de:2595:938c:d7c1:5827])
        by smtp.gmail.com with ESMTPSA id e26-20020aa78c5a000000b006e3809da4fdsm12126930pfd.83.2024.02.23.08.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 08:56:23 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 23 Feb 2024 08:56:09 -0800
To: Wonjae Lee <wj28.lee@gmail.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, gregory.price@memverge.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 07/10] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Message-ID: <ZdjOKWTm5aCJc8o9@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-8-nifan.cxl@gmail.com>
 <6fad2a96-aba6-46a1-a1ef-85be4faba59b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fad2a96-aba6-46a1-a1ef-85be4faba59b@gmail.com>

On Fri, Feb 23, 2024 at 04:16:53PM +0900, Wonjae Lee wrote:
> On 2024-02-22 오전 3:16, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Add dynamic capacity extent list representative to the definition of
> > CXLType3Dev and add get DC extent list mailbox command per
> > CXL.spec.3.1:.8.2.9.9.9.2.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++++
> >   hw/mem/cxl_type3.c          |  1 +
> >   include/hw/cxl/cxl_device.h | 23 ++++++++++++
> >   3 files changed, 95 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index f95e417683..dae7fe00ed 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -83,6 +83,7 @@ enum {
> >           #define CLEAR_POISON           0x2
> >       DCD_CONFIG  = 0x48,
> >           #define GET_DC_CONFIG          0x0
> > +        #define GET_DYN_CAP_EXT_LIST   0x1
> >       PHYSICAL_SWITCH = 0x51,
> >           #define IDENTIFY_SWITCH_DEVICE      0x0
> >           #define GET_PHYSICAL_PORT_STATE     0x1
> > @@ -1344,6 +1345,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.2:
> > + * Get Dynamic Capacity Extent List (Opcode 4801h)
> > + */
> > +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> > +                                               uint8_t *payload_in,
> > +                                               size_t len_in,
> > +                                               uint8_t *payload_out,
> > +                                               size_t *len_out,
> > +                                               CXLCCI *cci)
> > +{
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    struct get_dyn_cap_ext_list_in_pl {
> > +        uint32_t extent_cnt;
> > +        uint32_t start_extent_id;
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_ext_list_out_pl {
> > +        uint32_t count;
> > +        uint32_t total_extents;
> > +        uint32_t generation_num;
> > +        uint8_t rsvd[4];
> > +        CXLDCExtentRaw records[];
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_ext_list_in_pl *in = (void *)payload_in;
> > +    struct get_dyn_cap_ext_list_out_pl *out = (void *)payload_out;
> > +    uint16_t record_count = 0, i = 0, record_done = 0;
> > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    CXLDCExtent *ent;
> > +    uint16_t out_pl_len;
> > +    uint32_t start_extent_id = in->start_extent_id;
> > +
> > +    if (start_extent_id > ct3d->dc.total_extent_count) {
> 
> Hello,
> 
> Shouldn't it be >= rather than >?
> 
> (I accidentally replied to v3 with the same comment above, so please ignore
> that.)

The spec says "Greater than", so I will keep it as it is until there is
more clarification about this. When start_extent_id ==
total_extent_count, return 0 extents.

Fan
> 
> Thanks,
> Wonjae
> 
