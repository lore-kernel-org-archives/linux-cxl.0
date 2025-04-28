Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7700186284
	for <linux-cxl@vger.kernel.org>; Mon, 28 Apr 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873048; cv=none; b=YVtYr2EPlEiRaG4+mIHQ9kDRv5/wRM0fTgtR0JejasoAlgEzw75OvX622sH29eP7xmtb/VvVz30aHz5MNlcMenxVCWZ1KaEuib/2HXmy+PmMvsVguMhfnylRloEN4pCCyF05lrlcdiQDNSjpoKCKtcdxJPj28hWlhfyZ8hTJq3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873048; c=relaxed/simple;
	bh=4eqXzYeiGXP8JpaWUw5neCWgOUJ2COhV9mY7iDoztjw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3SxRJFwqdYmdCPErb9ZklWIs6arOgTaa6yoc7sljBXbGjAY/Y3nsFva1uwXwUGTR0dzb62Rz9J+2uNbGXVNORSsi04aIkybRsucc9iEA7hHxzV6wPRJEHEEw6F1vdtw6GnVlSB0pyqvEVoU4i9gNiBywA6lvjSmXU+vWfdU0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l99R9VjU; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l99R9VjU"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47ae894e9b7so115316161cf.3
        for <linux-cxl@vger.kernel.org>; Mon, 28 Apr 2025 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745873045; x=1746477845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4zd0GN4l+W7tGH06TegEGwIQ2pHoD4ic50dAUxlBrg8=;
        b=l99R9VjU4uBbaxdR2/6N6j3JhKyWGLKQUcwZl+EtKxKUSbLo/UgmyKn3Gli+kLcWUc
         toqXvj1o3aJ3igolVdU7sL8W/ZiyU7chUvqBCGkLDl10n+IYlO7MfCEdtdjvoDwlaFCu
         4MX6D7W7JJqoyWdBmKYHc7S9Ig25Rzhte63/A+V2HUDotkE/uWP7YacA/9xr2V8PGQmw
         eX8snMikGfaxwYttwHSD+CcqhiTtJoGCaUt/bKYW6v2NVkpK0FvKV55x/B8020KM1y1+
         TbX6Dh5KdsrUmIxieoDvxdhszjXy5OyQ96BQztA5NHdRxYvTgGyGx9fhp08fe7tuBSfo
         Qqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745873045; x=1746477845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zd0GN4l+W7tGH06TegEGwIQ2pHoD4ic50dAUxlBrg8=;
        b=KXEsCK4vqKqw8Axf7Ca0XizcCMBIApJ5cpSC/vIwUAiYV/osU6FRakzY7bNpaIEqhK
         9z2mMOy9zxuVzVXNcnqr25dWH0LhyPMiL1CUgQiQn9Y2Bkgn14JPHRwtYMs9vyy9T9IO
         bSLYFi5qSo5P4/Kuj4lHlpXah6WG5NRD7rihOk5/7qqhu1ZQTrNpesE+zH0gDwFCDrnc
         MQNqPklj9k+liyD1Owr0dbpZLVJ9IkQUGn2FP3zrSDA8ASFt+hAYf86RN0nZxA0sglHH
         4DYccoLWQavJq3lVDyCe3QNDe+sg1eVkEPAG548ovyQ4CadrivsDllTcwlAIWdkQ2Ixy
         Jmbw==
X-Forwarded-Encrypted: i=1; AJvYcCVP5M1c/ctaiTHfr+WjtcjIktq8R9nIJQJ0xCayv1tV6maV25QFRMTRQaZdD84a3kr9lf+kMBmh00A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37xeQodihaqkfomNSqzWLe663cWC4m9zxroIYIczEzWBeQw8m
	x/1srRtzt8E+7zNoX95kNLmjCPnxCL73DMijhs++Fdz+j/il/IeH
X-Gm-Gg: ASbGncvVLLc4E6jdceahgMiX5mo+Vx0+q49ZjHGpPTpOFKhkoB0Uy5dvVE7rWJOwLjr
	Fg7Kpy8C/QYZfLWz86/0xBlu7wC07jZ7qh+njsZ41ItvYrSC2lpEVUBU9/B8QpzZ+93XebsKRpy
	PSkupn1pmWXqB8SUZL6plS8f8RE5Ohg+zAT1o/QEnUETx9uQz/MW7AuDySeZ/IK9KhWFG0lpOWm
	YpDdNtOt2qQnwiivnnJniAjZs3J0Yivhdmcz7ttuTZOHW4C2uUEn7Dpq9jUkitDm2kHqyQN4L74
	l7l9jbr60t4pvpZH8a+BUw4Y5x3QaBttRVZeZspigicbjHk=
X-Google-Smtp-Source: AGHT+IHdl3eLAzRBxdQFzr8/xHozPYez1pJyqoesPlbyf32cu4ZoDrFIaIRHBsD5NzMXUbsC5nXu2A==
X-Received: by 2002:a05:622a:1a9e:b0:476:7e72:3538 with SMTP id d75a77b69052e-48133752379mr169687231cf.50.1745873045428;
        Mon, 28 Apr 2025 13:44:05 -0700 (PDT)
Received: from debian ([2607:fb90:37e2:c851:8e4d:2d6e:a358:8db0])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ea1692d85sm72220261cf.61.2025.04.28.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 13:44:04 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 28 Apr 2025 13:44:01 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Message-ID: <aA_okWIcD3msM7y1@debian>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-10-anisa.su887@gmail.com>
 <20250424122308.00004e8e@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424122308.00004e8e@huawei.com>

On Thu, Apr 24, 2025 at 12:23:08PM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:36 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Similar comments to patch 8 around the double loop.
> 
> I'd also like Fan to take a look through these (v2 probably)
> as he's messed with DCD a lot more than me!

It is true we can avoid the double loop here. 
Since the input payload is already CXLDCExtentRaw. 
Previous in QMP implementation, we need it as the input is different, we did
not have start_dpa directly, but an offset to the start of a region.

Fan
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 94 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 5bcbd434b7..37810d892f 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -128,6 +128,7 @@ enum {
> >          #define SET_DC_REGION_CONFIG 0x2
> >          #define GET_DC_REGION_EXTENT_LIST 0x3
> >          #define INITIATE_DC_ADD           0x4
> > +        #define INITIATE_DC_RELEASE       0x5
> >  
> >  };
> >  
> > @@ -3722,6 +3723,10 @@ static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
> >                                                 ext.start_dpa, ext.len)) {
> >                  return CXL_MBOX_INVALID_EXTENT_LIST;
> >              }
> > +        } else if (type == DC_EVENT_RELEASE_CAPACITY) {
> > +            if (!ct3_test_region_block_backed(dcd, ext.start_dpa, ext.len)) {
> > +                return CXL_MBOX_INVALID_PA;
> > +            }
> >          }
> >      }
> >  
> > @@ -3835,6 +3840,88 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h)
> > + */
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
> > +    g_autofree CXLDCExtentRaw *event_rec_exts = NULL;
> > +    CXLEventDynamicCapacity event_rec = {};
> > +    CXLDCExtentRaw ext;
> > +    int i, rc = 0;
> 
> Prefer not to combine cases where you init and ones where you don't.
> Just use 2 lines instead.
> 
> > +
> > +    switch (in->flags & 0x7) {
> 
> That 7 needs a define.
> 
> > +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> > +        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
> > +                                                   in->host_id,
> > +                                                   in->ext_count,
> > +                                                   in->extents,
> > +                                                   DC_EVENT_RELEASE_CAPACITY);
> > +        if (rc) {
> > +            return rc;
> > +        }
> > +
> > +        /* Create extents for Event Record */
> > +        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
> > +        for (i = 0; i < in->ext_count; i++) {
> > +            ext = in->extents[i];
> > +            event_rec_exts[i].start_dpa = ext.start_dpa;
> > +            event_rec_exts[i].len = ext.len;
> > +            memset(event_rec_exts[i].tag, 0, 0x10);
> > +            event_rec_exts[i].shared_seq = 0;
> > +        }
> 
> Similar to before. I'm not currently following the reason for the local
> storage.
> 
> > +
> > +        /* Create event record and insert to event log */
> > +        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> > +        event_rec.type = DC_EVENT_RELEASE_CAPACITY;
> > +        /* FIXME: for now, validity flag is cleared */
> > +        event_rec.validity_flags = 0;
> > +        /* FIXME: Currently only support 1 host */
> > +        event_rec.host_id = 0;
> > +        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
> > +        event_rec.updated_region_id = 0;
> > +        for (i = 0; i < in->ext_count; i++) {
> > +            memcpy(&event_rec.dynamic_capacity_extent,
> > +                   &event_rec_exts[i],
> > +                   sizeof(CXLDCExtentRaw));
> > +
> > +            event_rec.flags = 0;
> > +            if (i < in->ext_count - 1) {
> > +                /* Set "More" flag */
> > +                event_rec.flags |= BIT(0);
> > +            }
> > +
> > +            if (cxl_event_insert(&ct3d->cxl_dstate,
> > +                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
> > +                                 (CXLEventRecordRaw *)&event_rec)) {
> > +                cxl_event_irq_assert(ct3d);
> > +            }
> > +        }
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
> > @@ -3977,6 +4064,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> >          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> >          CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> > +        cmd_fm_initiate_dc_release, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +         CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> >  };
> >  
> >  /*
> 
