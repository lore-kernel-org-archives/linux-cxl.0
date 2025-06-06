Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4DBA38
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749238649; cv=none; b=EGFV8ZXMo/E4ZLht3+ztDi7UoPbtoS75TMJ3AAvSqq8Ey6Pionpq1GZnNTlY+xFakgViwq5R5nSzv8wBfyhjjPUMa0pLHulaKDFM1zLtit2+GBcQ6AweEv1f0cI7T07hEtmW1Dp6CYctBx34npZMUZsYa81vaP9kSPAF48jKXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749238649; c=relaxed/simple;
	bh=EJY3Y9qmsaXTZqCgy59Qfc82qsi/v/fSKs/ltY6k2Ag=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMBNfP1UMR0Xkg/fK7/EDMmgU2sP2dQ6JNJ5MdRCOBO7O4qHajkSKcCzGMiXEH5+fC02TXzg1j6cRtGQPxIrvVilnALJa4gyfSi9QHcVv0P/u/36Idb+xHj9dekZ0QTlnLAJ4QMTQT8a3hMCWEnisLv6Kfg/jS4WIeN5dtx4gx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH8r7aRY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH8r7aRY"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2071101b3a.3
        for <linux-cxl@vger.kernel.org>; Fri, 06 Jun 2025 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749238647; x=1749843447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jp+ZmHZi5JCiUXvLUvDXRKSUfFO3Yl8SYrgOARBxt0=;
        b=lH8r7aRYvQm4s39AMObxC97LK/JRreol7yDBANWaAhLHvmEVZ6cJc5LodOwnWl6ps9
         0l3nExMJAQjrI1S5ojwXu6qQQ4PSSyzu5XZ1J8vs+3otiE6HdmlDaJjJJpTYDGxPDqbO
         V/o8h6D4INGrOa7H8bydjz7ft6kzIuUWbiFHlUCpDdzmeVPWQImBW2nnwac1yXlM/CDN
         J4OfO//3zH9CgMbRRaENPxqqc2uBJ/sTBzG2Dj4w95h07fwvQZGG0bZ1IRAIP+8952JY
         5LBPE4ZILo3595jBKRA9ivI2nvdL9J7uugmdm7tw1ziQ5cKRmx1ilRDI1Gb2s19767cJ
         Jh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749238647; x=1749843447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Jp+ZmHZi5JCiUXvLUvDXRKSUfFO3Yl8SYrgOARBxt0=;
        b=eF1Qxx3Ha09PFF5nXqvyLBSspTzZQ3fiv6+jpJ2crtiBytmRFCK3MPTkKV5dORGlcw
         MYuEfUjBHfrYHFwc5D4F8J13FA875prQIbkwB7whIzJjN4kS5ssFXaOauozzJtsV0Js2
         vMF0L6JHoU8sRFhb0R1QjQHU3EPY42Ahh99JDEUPWUmixUBzDceSJjOf3TqPHX0WVUAQ
         LkWhSVvtii8X03vUF3Cl2u5xtR67w1bDp0WrCikageSkChqvoqtudddQr3n0GgsGzNCa
         32sra9Sjx0UcF/X2UwJX9FIV/77WNQ/zPjqdVOU3z+bAPGj4/oKOxelWaRExh1BCTMOr
         4sZw==
X-Forwarded-Encrypted: i=1; AJvYcCWyus5XhR7IzZ4F5exDmvnefoVGTrbcShTYw3qGxmeyCMX5JTazsq+aAA8v66AiwAEogBycgVRXGL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjHFUK6hEJa85YFtDjR5RQDODzkvuiJqOhQD1MgGUo74rjEiT
	X6Shi6tHgWeqQZVhAUdiP1mKyEc5y+BXRvQ5oSLbUOoAF2erhASEvoUF
X-Gm-Gg: ASbGnctrLUqhwnKuIEuj9z/l0T57W20NjSXnE6POv/YARUCySWKWjW4SR+zUKz1roUE
	f56x+0WHBS0ec38itPlwgPQ9ZoeNj92+bdaRz9BAISDUbM0vikA0CcmFPr48THbNkhJLakQDGB2
	suII/uVWCLtnoCOWouRO9IUVsLdPJ0y6wzcePlaqa/xqYzpayBW+tjKEGd0r2AoNOEkmJxYFi96
	uqcS57KpfZpxQwcmAYAz+pknoabj1ZrLXLgqVRBpdRoDZaHNJbsCLNRs7jI4ydCx3Ncua83nG0t
	gCCQyDRDuy8ZhT5rxrqB46JACQOjSjJNId6ro+bxR3q0uTT7ZycQ3lU83M2ft95+R3WhlwtMI07
	prPVTrPLg9omz
X-Google-Smtp-Source: AGHT+IGGrpMX4eZ8myDehK2P4WTu+9wq9+Cnj/ct+GvCo4Qd6LZ+zhGTokm9xiJA51HFXf0P4wZt+A==
X-Received: by 2002:a05:6a00:488b:b0:748:2eb7:8cc7 with SMTP id d2e1a72fcca58-7482eb793b6mr3073279b3a.21.1749238639431;
        Fri, 06 Jun 2025 12:37:19 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083abcsm1695664b3a.92.2025.06.06.12.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 12:37:19 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 6 Jun 2025 19:37:17 +0000
To: Fan Ni <nifan.cxl@gmail.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: Re: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Message-ID: <aENDbaFuj4df46eA@deb-101020-bm01.eng.stellus.in>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-10-anisa.su887@gmail.com>
 <aEM25yCeErixfi0l@debian>
 <aEM4AXOJLMq7nqZp@debian>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEM4AXOJLMq7nqZp@debian>

On Fri, Jun 06, 2025 at 11:48:33AM -0700, Fan Ni wrote:
> On Fri, Jun 06, 2025 at 11:43:51AM -0700, Fan Ni wrote:
> > On Thu, Jun 05, 2025 at 11:42:23PM +0000, anisa.su887@gmail.com wrote:
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> > > 
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > 
> > See below ..
> > 
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index 7ee5be00bc..6c57e0deac 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -124,6 +124,7 @@ enum {
> > >          #define SET_DC_REGION_CONFIG        0x2
> > >          #define GET_DC_REGION_EXTENT_LIST   0x3
> > >          #define INITIATE_DC_ADD             0x4
> > > +        #define INITIATE_DC_RELEASE         0x5
> > >  };
> > >  
> > >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > > @@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> > >      return CXL_MBOX_SUCCESS;
> > >  }
> > >  
> > > +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
> > > +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
> > > +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> > > +                                             uint8_t *payload_in,
> > > +                                             size_t len_in,
> > > +                                             uint8_t *payload_out,
> > > +                                             size_t *len_out,
> > > +                                             CXLCCI *cci)
> > > +{
> > > +    struct {
> > > +        uint16_t host_id;
> > > +        uint8_t flags;
> > > +        uint8_t reg_num;
> > > +        uint64_t length;
> > > +        uint8_t tag[0x10];
> > > +        uint32_t ext_count;
> > > +        CXLDCExtentRaw extents[];
> > > +    } QEMU_PACKED *in = (void *)payload_in;
> > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > +    CXLUpdateDCExtentListInPl *list;
> > > +    CXLDCExtentList updated_list;
> > > +    uint32_t updated_list_size;
> > > +    int rc;
> > > +
> > > +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> > > +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> > > +        list = calloc(1, (sizeof(*list) +
> > > +                          in->ext_count * sizeof(*list->updated_entries)));
> > 
> > Use g_malloc() and free with g_free();
> > 
> > > +        convert_raw_extents(in->extents, list, in->ext_count);
> > > +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> > > +        if (rc) {
> > > +            return rc;
> > > +        }
> > > +        rc = cxl_dc_extent_release_dry_run(ct3d,
> > > +                                           list,
> > > +                                           &updated_list,
> > > +                                           &updated_list_size);
> > 
> > This seems not right.
> > this is only fm issue dc release request, not host release dc extents to device.
> > So we should follow what we did in the qmp_cxl_process_dynamic_capacity_prescriptive()
> > for release case.
> > 
> > One thing that I can see that making the workflow is different is that, we check
> > the extent list with the pending list to make sure fm is not trying to remove
> > non-accepted extents, but the host release extent workflow does not need to do
> > that as it is filtered out in the first place when fm sends the request if it is
> > from FM.
> > I have to admit, existing qmp interface can be improved to remove some condition
> > checks as they are kind of duplicate.
> > For example, if an extent is still pending, it will not be set in the bitmap, so
> > we can still tigger the error if it happens by removing the pending list check.
> > One justification is that the error message is different for a non-existing
> > extent and a pending extent, which is useful for a dmp interface.
> > 
> > 
> > Also, the case to detect exhausted resouces is not different, FM can request to
> 
> s/is not different/is different/
> I am not sure what I was thinking..
> 
> Fan
I'm confused though because in the 3.2 spec it says "The command shall fail with
Resources Exhausted if the Extent List would cause the device to exceed its
extent or tag tracking ability" (Section 7.6.7.6.6).

The only way that releasing an extent can cause the number of extents to
increase is if the middle section of an existing extent is released,
which is why I used cxl_dc_extent_release_dry_run(), since it already
detects that case.

Anisa
> > release a lot of extents, but what the host actually does can be a
> > subset or
> > none.
> > 
> > Fan
> > 
> > > +        if (rc) {
> > > +            return rc;
> > > +        }
> > > +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> > > +                                                     DC_EVENT_RELEASE_CAPACITY,
> > > +                                                     in->extents,
> > > +                                                     in->ext_count);
> > > +        return CXL_MBOX_SUCCESS;
> > > +    default:
> > > +        qemu_log_mask(LOG_UNIMP,
> > > +            "CXL extent selection policy not supported.\n");
> > > +        return CXL_MBOX_INVALID_INPUT;
> > > +    }
> > > +
> > > +    return CXL_MBOX_SUCCESS;
> > > +}
> > > +
> > >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> > >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> > >          cmd_infostat_bg_op_abort, 0, 0 },
> > > @@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> > >          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > >          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > >          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > > +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> > > +        cmd_fm_initiate_dc_release, ~0,
> > > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > > +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > > +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > > +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > > +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > >  };
> > >  
> > >  /*
> > > -- 
> > > 2.47.2
> > > 
