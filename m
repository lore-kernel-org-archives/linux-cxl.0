Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39A1DDC23
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749235719; cv=none; b=WV9yeTTF6JBL2lsQ42aG0tJ4yX3V0fBX2vHbAjPBhUfCOgrbhYLHlmkr2c264dn/j+PaWMGl6uvrATvTHwwssaqr4lXMAqkY8t/X3KmB8xPG8fwgIUIkzZnaGl4LMO6QKHTDSKTNqBGohr+FvLhk5USSNSLet6Vrk5WGUR7cSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749235719; c=relaxed/simple;
	bh=lcZD3xiBD/52+R9Tma1DPI2/irhR53gmiAR4SLJ2zUg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIM8TBfeT8OaUqgYlaK6Qi/309iO/Ccb5eL2D6GMUXk3IIOJRVcdgHDBtKOHkWCdWVJNMVsFqc2FoxzUxT7QgPlspkkRlpv3Sb2XDREXKoBh/ifkrgwtSU9BKbPLYtZgLwlPiuykEksgn3EVU2Nu3JLbwsQ6W0dldvhQHexLsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXVRkEi+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXVRkEi+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2093867b3a.0
        for <linux-cxl@vger.kernel.org>; Fri, 06 Jun 2025 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749235716; x=1749840516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XzwZXcFFnUPpq5lmaEWt4YpLE6Y/sVwaVTV0zUmG5U=;
        b=iXVRkEi+ZIOcQFJZGMSITO1vbQvHcCK7ZiLQEtzFWQ3w2c1/Yz50oPrSh3B+Uhw1GF
         OyRTfZdIcEIV00KuU7QFrQquDUBMxgbFjopDvBqn0ZCv4jwyH+lcWNu3+jw3R15ChK4I
         3CnTdtUncDIRGai8fLrFslPLrIMQsKlET8ifyuzycsNwBkXu/8s2A5dOIG8YYw2wWnKS
         +pSHzBrqVshpDKrAPCHrxOLdqDk+LMKuYFQbaCIOFppWTriIxc4zRG2XVb7k+vCrhalA
         iBDZkDKL4gaSF7Xud/tiJz/7ofcZT9jWRZ3V6yRa2ZKp0A54/Kee/blwnuR99I+6b5kF
         E5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749235716; x=1749840516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XzwZXcFFnUPpq5lmaEWt4YpLE6Y/sVwaVTV0zUmG5U=;
        b=E66oJDjconkl7PgvFZ6uxyNR5SHbocJD+/OV4wk79F7A6H2tKD1qvPzMKEKwm1WdfZ
         vpRvDk8q87EgPezXu/cf2enDzd79n4z9cQmAu3GPcQ8n22rNTjaVniB7YpWAtPNhcDeG
         UcPI9EYAOts92iq6sIasj008GDrgyZXZ1no/Lptk+CWXEEtLTXOlC261mU5cOpXC8oKf
         n14SG6/GliHC3ZfIY70KMMUsBK8wPXecGvXXQdmrPTiXM3skiWvNKpX3oGT/6y1/TrnW
         NWQXXoQQFojjL4wgjGyhPNe9C1e0zp9JpaTowD0z+yFmTvwznX/hdqkE54Qz6e8DX35W
         U0uA==
X-Forwarded-Encrypted: i=1; AJvYcCVK/oKIKMUMLHB9CZJROXaFnekla0ovlgctd8TkfJbT5yDdcnhEBI8+jViHO0F2CKgDlKUvAiwhYGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycW+4ti2ZMkpBEaNUFaj39vRyxFAlko0TY9XbE/eEuYAthO0nL
	6hcyRa7Ix/gbC7EgsgCnMarrVOQNpI3OK5IQo71QTGwOkPx6kikhIjVQ
X-Gm-Gg: ASbGncvns9cjQLbmlX9TCfBgQUjWLBFQb7P2NoLeoUkMMqTiGuhracamfeGhC6wLtHH
	SJdrDo/P74D6pevXg6EU6n/kLwMiHXodW6NJ7gOTyBoYKNf9KvZYLHduQPtJCvUuqxfyWo5JNvs
	3WsHJNaR/RHMgpGAfA+USUDgXvxSPNxxutC528UCj2aPIoSrF6bTHRYq5mqzE9O0qVOymCwRrRQ
	NgG5IDMUNra835Akw6z/fmYjjz7+rqBhdNZqpTiMjnizAULVxCfVlzc69iJY6bPWrdBGKBUA6W9
	9Wqk3VvxP5XgV8yK//SKnT/vS5p47CQjUaozAGUM9izcGg==
X-Google-Smtp-Source: AGHT+IG7V6H7umOyHTIJ1kyAYCca9dapZ1XD5673yteXoMhB/jDmMw8PnzXl7Ms6He6T8s7GJJdUog==
X-Received: by 2002:a05:6a20:9191:b0:21c:faa4:9ab9 with SMTP id adf61e73a8af0-21ee25489a7mr6168623637.22.1749235716004;
        Fri, 06 Jun 2025 11:48:36 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0e9efasm1643162b3a.147.2025.06.06.11.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 11:48:35 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Jun 2025 11:48:33 -0700
To: Fan Ni <nifan.cxl@gmail.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Message-ID: <aEM4AXOJLMq7nqZp@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-10-anisa.su887@gmail.com>
 <aEM25yCeErixfi0l@debian>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEM25yCeErixfi0l@debian>

On Fri, Jun 06, 2025 at 11:43:51AM -0700, Fan Ni wrote:
> On Thu, Jun 05, 2025 at 11:42:23PM +0000, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> 
> See below ..
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 7ee5be00bc..6c57e0deac 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -124,6 +124,7 @@ enum {
> >          #define SET_DC_REGION_CONFIG        0x2
> >          #define GET_DC_REGION_EXTENT_LIST   0x3
> >          #define INITIATE_DC_ADD             0x4
> > +        #define INITIATE_DC_RELEASE         0x5
> >  };
> >  
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
> > +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
> > +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint16_t host_id;
> > +        uint8_t flags;
> > +        uint8_t reg_num;
> > +        uint64_t length;
> > +        uint8_t tag[0x10];
> > +        uint32_t ext_count;
> > +        CXLDCExtentRaw extents[];
> > +    } QEMU_PACKED *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLUpdateDCExtentListInPl *list;
> > +    CXLDCExtentList updated_list;
> > +    uint32_t updated_list_size;
> > +    int rc;
> > +
> > +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> > +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> > +        list = calloc(1, (sizeof(*list) +
> > +                          in->ext_count * sizeof(*list->updated_entries)));
> 
> Use g_malloc() and free with g_free();
> 
> > +        convert_raw_extents(in->extents, list, in->ext_count);
> > +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> > +        if (rc) {
> > +            return rc;
> > +        }
> > +        rc = cxl_dc_extent_release_dry_run(ct3d,
> > +                                           list,
> > +                                           &updated_list,
> > +                                           &updated_list_size);
> 
> This seems not right.
> this is only fm issue dc release request, not host release dc extents to device.
> So we should follow what we did in the qmp_cxl_process_dynamic_capacity_prescriptive()
> for release case.
> 
> One thing that I can see that making the workflow is different is that, we check
> the extent list with the pending list to make sure fm is not trying to remove
> non-accepted extents, but the host release extent workflow does not need to do
> that as it is filtered out in the first place when fm sends the request if it is
> from FM.
> I have to admit, existing qmp interface can be improved to remove some condition
> checks as they are kind of duplicate.
> For example, if an extent is still pending, it will not be set in the bitmap, so
> we can still tigger the error if it happens by removing the pending list check.
> One justification is that the error message is different for a non-existing
> extent and a pending extent, which is useful for a dmp interface.
> 
> 
> Also, the case to detect exhausted resouces is not different, FM can request to

s/is not different/is different/
I am not sure what I was thinking..

Fan
> release a lot of extents, but what the host actually does can be a subset or
> none.
> 
> Fan
> 
> > +        if (rc) {
> > +            return rc;
> > +        }
> > +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> > +                                                     DC_EVENT_RELEASE_CAPACITY,
> > +                                                     in->extents,
> > +                                                     in->ext_count);
> > +        return CXL_MBOX_SUCCESS;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP,
> > +            "CXL extent selection policy not supported.\n");
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> >          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> >          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> > +        cmd_fm_initiate_dc_release, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >  };
> >  
> >  /*
> > -- 
> > 2.47.2
> > 
