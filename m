Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F311F4C8E
	for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670616; cv=none; b=YbIeTUewQz7MrP16sErW/mBt9et2E7iDNBUq5bg3uwf+aXM4N1nQjXm67EnWCiUjmUETZWnbPjVc7eczebyhL1bXCv+D+eqcV/ndmdampiSDIB/z8YhO13gU26VOq8yIGUJrD/WDnfa4NXUCHoplrdFEbcmAt0n+2MU2EooCdWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670616; c=relaxed/simple;
	bh=q6ztn/TtYVCY4MF4Cf5G8G5KkrSwOvin8xGPi39pMA4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0ZqzI4LoPfFExmWLbqm3ZqW4WNwicSR+tkabppfJMYdaRbqCOiLyJp4e6eeT2vVPuEh/aruDE89v1LVbv5N++PhlUM+hdjEMbIs6Ygb2IHEIZHyDKJ1GkPguTP4L7RgdUdlJgAfqdBXvo2bUOGIufXyV1Qizt+LLmiQR/nP7Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6Y7z+/7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Y7z+/7"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6ce696c18bso5726419a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 09:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670614; x=1762275414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/brO/u0paEEgtwhQ2JCt2rt+Ab6UtFNYPmhMQx742E=;
        b=J6Y7z+/7swdYj4KSDX8Fatb3FICofSwkXxGaSU1oIQaffmr8cIIMG5d9uRk91YTh4b
         A+7MBUs+YjbkcFot8h8PT7KuFUns9QMjSSZdzGDD2sklXJuj6H7v+Gkx/TjzIwvM60Pu
         pvoCgKnemkEzJ0kQfWCENklNCS+Mksb3Gp7SbVOTOmUKcyiP9cMxwPEvCZKCRyDHGRs1
         CniN0OoHaoNzJtyqS0OnV95+d9iAK0TOx9sYqvOkBC9c/TcdAB0j/msmDjT4cPWTcSgO
         y8S+7gBjtct+f+5SxNFFcWJ2sj1XNeyCpI2InvDQzHA3xw3Id+KMcxn+Y4PkhVFmtCXi
         pZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670614; x=1762275414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/brO/u0paEEgtwhQ2JCt2rt+Ab6UtFNYPmhMQx742E=;
        b=Ufix0RFT7cIVAYEeSeGPPMN2l62AyoGaQgFtwoXfFofldxj5Er6DyCtfu3xL8M7egM
         dU3Wv6CDZzBg8SwecBuGUXozXeOn9nH9y2NMg9T5eQ542A+Qb6ajhmhKjGQjRxAs3XsD
         QLXl3+SlOqffttGO3z0vcPCDMDBguYGv9TWluBshkKyFhQfI9PqLlFVqtPfwVsW5bR2J
         xaGpkKmuLq3EbE2/3XzmfE9t1vs1iO2/SWxqOLG0DQKiZVCJ7FaPYgPhH/L/PZ9N5tqE
         NvzfLhZTtn0f6bzXvromeDNPuCqC36HXt75inVK1Cmx7cv+WllRQe79PzSuNoVwLc5m8
         oAbw==
X-Forwarded-Encrypted: i=1; AJvYcCVkL19SP0lxp2HQpCvMYk491bwr0zFnDMwMld16d9jxLOTKuK7dBkr9ooF2r8VgIv0ENpICCFN4A1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcTgyCxyrNTBi61yQANnVMhZMXJJiN6HwGtCB9Xwydg8+CM99
	QJvFZs8550VuUeOOZbpowBIHjQE1P6QF/WVPULJJQ8cuQ6Add+kWum6T
X-Gm-Gg: ASbGnctKZ9jdbQrWq4D/Fjs6KsVXxVepRQVddmGYR4OkQ/QakGJ2+k5YvH2UW64mep2
	Lkt57M+/qhyW8pGW6gw2V4XsTf1+n/6WB94ZFZbvmWJ26fGCGKkNxSiegi17acNf3YkIFE9hEvi
	p99L2++eS6NO9Jp366Cw+ydo2aBMkROfoGucnwXHZ1yzBPPBMcJRksp8ONsr2BfW8Dsd06K/YnK
	pEv7gi8nnrhDZI/HFdoq7q/uTklmilQRQyrBSTzBHXMteZ8D1Mo35zcFsqaNA7uWuvkgP6W/L/d
	l2AWwOERuVyBFo0mIU+cet2fPXLkKfLBwURpNR0VLFwxMC4Iwwqm7p691tDQE6a037l5Ex+bWa9
	yA0YxOYR33l23CLuL21FdMtfEvMf0hL9XTig0vhJ0SO/OJDiaDItwQOIMqCTtJoDbxMhvooTl2I
	ddXee31irwGpvUpFg21x1lBaaNUcE=
X-Google-Smtp-Source: AGHT+IH1316jgmDw/P6TmIjlAoCZxaS24hOy4JenP51pdc4qOgp5Ssym99QR7z2RJBGuEPDuPXxvZg==
X-Received: by 2002:a17:903:38c8:b0:25c:982e:2b1d with SMTP id d9443c01a7336-294cb54018emr68148255ad.59.1761670613785;
        Tue, 28 Oct 2025 09:56:53 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d27541sm121925925ad.61.2025.10.28.09.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:56:53 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 28 Oct 2025 16:56:51 +0000
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: Re: [QEMU PATCH 1/1] hw/cxl/cxl-mailbox-utils: Enable FMAPI Initiate
 Add for MHSLD
Message-ID: <aQD10zBfV2RUXD4n@deb-101020-bm01.eng.stellus.in>
References: <20250927002125.860668-1-anisa.su887@gmail.com>
 <20250927002125.860668-2-anisa.su887@gmail.com>
 <20251028162100.00006fa8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028162100.00006fa8@huawei.com>

> Tue, Oct 28, 2025 at 04:21:00PM +0000, Jonathan Cameron wrote:
> On Sat, 27 Sep 2025 00:18:07 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > Call mhd_reserve_extents in FMAPI Init Add (5604h)to enable sending
> > FMAPI Add command to MHSLD.
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Hi Anisa,
> 
> I've not been quick on this one partly because it sits on top of the MHSLD
> work that I think needs a proper revisit to establish what is an up streamable
> path, but I haven't had time to do that :(
> 
> Anyhow in meantime I'll take a look.  I suppose nothing stops me carrying
> this on top.
> 
> Just one minor comment inline.
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index c5177dfd92..9ac60db4e1 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -24,6 +24,7 @@
> >  #include "system/hostmem.h"
> >  #include "qemu/range.h"
> >  #include "qapi/qapi-types-cxl.h"
> > +#include "hw/cxl/mhsld/mhsld.h"
> >  
> >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >  #define CXL_DC_EVENT_LOG_SIZE 8
> > @@ -4163,6 +4164,8 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >          CXLDCExtentRaw extents[];
> >      } QEMU_PACKED *in = (void *)payload_in;
> >      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> > +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_num];
> >      int i, rc;
> >  
> >      switch (in->selection_policy) {
> > @@ -4201,6 +4204,28 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >                  return rc;
> >              }
> >  
> > +            /* If this is an MHD, attempt to reserve the extents */
> > +            if (cvc->mhd_reserve_extents) {
> > +                g_autofree CxlDynamicCapacityExtentList *records =
> > +                    g_malloc0(in->ext_count * sizeof(*records));
> 
> I think it makes sense to use g_malloc0_n for these
> 
> I changed this whilst applying it locally so it'll be there next time
> I push out a tree.
> 
> Thanks,
> 
> Jonathan
> 
Gotcha, thanks Jonathan :D

- Anisa
> 
> > +                g_autofree CxlDynamicCapacityExtent *dc_exts =
> > +                    g_malloc0(in->ext_count * sizeof(*dc_exts));
> > +
> > +                for (i = 0; i < in->ext_count; i++) {
> > +                    CxlDynamicCapacityExtent *value = &dc_exts[i];
> > +                    value->offset =
> > +                        in->extents[i].start_dpa - region->base;
> > +                    value->len = in->extents[i].len;
> > +
> > +                    records[i].value = value;
> > +                    records[i].next = &records[i + 1];
> > +                }
> > +                records[in->ext_count - 1].next = NULL;
> > +                if (!cvc->mhd_reserve_extents(&ct3d->parent_obj, records, in->reg_num)) {
> > +                    return CXL_MBOX_INVALID_INPUT;
> > +                }
> > +            }
> > +
> >              CXLDCExtentGroup *group = NULL;
> >              for (i = 0; i < in->ext_count; i++) {
> >                  CXLDCExtentRaw *ext = &in->extents[i];
> 
