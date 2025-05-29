Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946B219A8E
	for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748550805; cv=none; b=bDYJwADvbPoyl+aHu3JxMUcbVhJ0l8V6sg0Tx2T1cAKDczpnX3CDp2LYszFrctslDqVoJNWEqJkQeDUxKjD6832FaLAI51GCAOY2IP+JVsbaqH5u/dREB7tML+xO9gCuAyIneoCFFWsZa6mJe3wy+kTdJu6wX0YZNBQ3c2/AL/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748550805; c=relaxed/simple;
	bh=4clTFeyUOXmt4r59v77tsSrRKvGyYtWp6LVsv/7FZ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tBaFWUTyxrTHTQG/mnh8AZEzbskN1DYIDbPAUlj2JVdJb3+IPvFI9UXgpqMpLA1hotVgllDK9ZkSoxVukA/5x3yq9MVbANRk9KtqsqwbsAuOrIDT7+hxPi3FqThmzOk0eFVvbrit70FCMIs8O8VktzVqsjquoULn3Kl7bRIIa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vjsf5Kvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vjsf5Kvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748550802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRFChHGHkjphMsMC9NKxNS8XDU5AZopIMIdFGdbP0DE=;
	b=Vjsf5KvnuGbQ78dcLqhw9wcEEn1xJZ4+wEUZw82pVK3EfA7bL1p162/lv14OI8CEksDHaL
	WWBd+bn5BTinwKkU9Eumye6XUl9KxidD1uVd4zWm2BsA5kkYCXwp67edT8Z382wliTZTEH
	u5xw2PgRKGcZOxtMomLfeDM3OyLvkK4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-VXob_0d7Mo-Abnfcn_cD7A-1; Thu, 29 May 2025 16:33:20 -0400
X-MC-Unique: VXob_0d7Mo-Abnfcn_cD7A-1
X-Mimecast-MFC-AGG-ID: VXob_0d7Mo-Abnfcn_cD7A_1748550800
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so10581395e9.2
        for <linux-cxl@vger.kernel.org>; Thu, 29 May 2025 13:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748550800; x=1749155600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRFChHGHkjphMsMC9NKxNS8XDU5AZopIMIdFGdbP0DE=;
        b=vs87xYHDaqhoSWWccEOjE6ep9U+AWSaD0ZYNlHmQiUIPZjCu1Tar5r9ZkCPqI1TqsF
         wsmpyUU9VluTSU5TaS9AYKRSxbTve/Ed39KyY5xNxnU5+CTFSRIIqZtW3mSffhsYwSz7
         +tH/KIdwSUDqFe6GzCgnTW9p0DurdtHGtVHLHz52MqZufsiFWYiNJeeGZJ3/gSTPXdek
         w29tlcRA+VW5A7T2e2dazHUQz/bmHy/wqc7rjsQVY2+1Qnfu9U3dX4+lZE4HfeUTNG8C
         7w3t28ueu3gDqAWgjjEjXuy/0ATO5MqYuASaxe565to3V/yvUwkTBXMTNkpsIAmNEKaK
         AW7A==
X-Forwarded-Encrypted: i=1; AJvYcCVzyfLlgCz94t3IdrSmVxEd23v0xk4vG4AwmqxazT5INU2b3QGMfjseijqu6q3u0M0f78HcPoOs47g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRREWKvrK6IY6w3k+nf+kslsm9JGPo59F2NHDqYPDHDjTaNCZ
	ZT6CLOPxdG0CSnnw4Ji2+ygsm8E3Lx4metYnTzCzqx+EFWQymgatob4YrEEVVegpXyJTHIKEJIP
	nmQmtL5S6E9N00dp2cFVKMyjYcJrEzXZoAsvgwjHHYUaUg7kmXa3g/rA2rPHblw==
X-Gm-Gg: ASbGnctNyMFV53q4nzpNYPxUiTWroOYpVqialpHWmXgMAfkTfGtPUmk04nRVzmteomU
	DbhLlcIpPd2+YbWE5m7I7bFr1xbzbQ5D7FiW3k4A9YRfNp3dOCZKj7EK7ar7bXThOb84We6cIXQ
	Mt0yZmq9FEpxmsdG4UsgTR/68etZVptZP8xP+Bny+uhBm1y9ZhZSQL7SZfrf2aHQRbDwA+qwWbs
	NinBmcEVHiSqpPTajt5i2AR6OuFwSSdm3D2sHxKrNk2C+co1E5ivJmjGnS/pxFwqzVWDcEmFKCH
	oeTVAQyKe6LVciMT
X-Received: by 2002:a05:600c:8207:b0:450:b240:aaab with SMTP id 5b1f17b1804b1-450d64fc49dmr10017725e9.8.1748550799507;
        Thu, 29 May 2025 13:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVANfC6zXEO4Pj5gSskTNeC86LnC/iZUQBlehWnwqIx8OGGArfsSRXfL8Ug7ZKe80bt8GWrA==
X-Received: by 2002:a05:600c:8207:b0:450:b240:aaab with SMTP id 5b1f17b1804b1-450d64fc49dmr10017515e9.8.1748550798983;
        Thu, 29 May 2025 13:33:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfbf40f0sm28703375e9.3.2025.05.29.13.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 13:33:18 -0700 (PDT)
Date: Thu, 29 May 2025 16:33:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, anisa.su887@gmail.com, gourry@gourry.net,
	fan.ni@samsung.com
Subject: Re: [Qemu PATCH v2] hw/cxl: fix DC extent capacity tracking
Message-ID: <20250529163303-mutt-send-email-mst@kernel.org>
References: <20250529163925.2916725-1-nifan.cxl@gmail.com>
 <20250529180734.00001197@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250529180734.00001197@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0XypNkZyDVhknQnAY3QXE-kquRX0qbNmfnbzKEwtVS4_1748550800
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 29, 2025 at 06:07:34PM +0100, Jonathan Cameron wrote:
> On Thu, 29 May 2025 16:34:25 +0000
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
> > extents in different states including added, pending, etc.
> > 
> > Before the change, for the in-device extent number tracking purpose, we only
> > have "total_extent_count" defined, which only tracks the number of
> > extents accepted. However, we need to track number of extents in other
> > states also, for now it is extents pending-to-add.
> > 
> > To fix that, we introduce a new counter for dynamic capacity
> > "nr_extents_accepted" which explicitly tracks number of the extents
> > accepted by the hosts, and fix "total_extent_count" to include
> > both accepted and pending extents counting.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks.  Michael, would you mind picking this up directly if
> you are happy with it?

sure

>   It is an esoteric corner case but
> we should emulate resource exhaustion for tracking extents correctly.
> 
> I don't have many fixes queued up at the moment to make it worth
> me bundling them up into a little series.  There is just this one
> and the one for Register Locator capability size I posted
> earlier today (Fan can you take a look at that one?)
> 
> > ---
> > v2:
> > 1) No functional changes;
> > 2) Rebased the code to ToT of master branch;
> > 3) Picked up tag;
> > 
> > v1:
> > https://lore.kernel.org/linux-cxl/20250520195741.789841-1-nifan.cxl@gmail.com/
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
> >  hw/mem/cxl_type3.c          |  1 +
> >  include/hw/cxl/cxl_device.h |  3 ++-
> >  3 files changed, 21 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 299f232f26..0b615ea37a 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> >      uint16_t out_pl_len, size;
> >      CXLDCExtent *ent;
> >  
> > -    if (start_extent_id > ct3d->dc.total_extent_count) {
> > +    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
> >          return CXL_MBOX_INVALID_INPUT;
> >      }
> >  
> > @@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> >      out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> >  
> >      stl_le_p(&out->count, record_count);
> > -    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> > +    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
> >      stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
> >  
> >      if (record_count > 0) {
> > @@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
> >      QTAILQ_INSERT_TAIL(list, group, node);
> >  }
> >  
> > -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> > +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> >  {
> >      CXLDCExtent *ent, *ent_next;
> >      CXLDCExtentGroup *group = QTAILQ_FIRST(list);
> > +    uint32_t extents_deleted = 0;
> >  
> >      QTAILQ_REMOVE(list, group, node);
> >      QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
> >          cxl_remove_extent_from_extent_list(&group->list, ent);
> > +        extents_deleted++;
> >      }
> >      g_free(group);
> > +
> > +    return extents_deleted;
> >  }
> >  
> >  /*
> > @@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> >      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> >      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > -    uint32_t i;
> > +    uint32_t i, num;
> >      uint64_t dpa, len;
> >      CXLRetCode ret;
> >  
> > @@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      }
> >  
> >      if (in->num_entries_updated == 0) {
> > -        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> > +        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> > +        ct3d->dc.total_extent_count -= num;
> >          return CXL_MBOX_SUCCESS;
> >      }
> >  
> > @@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >  
> >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> >          ct3d->dc.total_extent_count += 1;
> > +        ct3d->dc.nr_extents_accepted += 1;
> >          ct3_set_region_block_backed(ct3d, dpa, len);
> >      }
> >      /* Remove the first extent group in the pending list */
> > -    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> > +    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> > +    ct3d->dc.total_extent_count -= num;
> >  
> >      return CXL_MBOX_SUCCESS;
> >  }
> > @@ -3160,7 +3167,7 @@ free_and_exit:
> >          }
> >          *updated_list_size = 0;
> >      } else {
> > -        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
> > +        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
> >      }
> >  
> >      return ret;
> > @@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> >          ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
> >          cxl_remove_extent_from_extent_list(&updated_list, ent);
> >      }
> > -    ct3d->dc.total_extent_count = updated_list_size;
> > +    ct3d->dc.total_extent_count += (updated_list_size -
> > +                                    ct3d->dc.nr_extents_accepted);
> > +
> > +    ct3d->dc.nr_extents_accepted = updated_list_size;
> >  
> >      return CXL_MBOX_SUCCESS;
> >  }
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 94e7274912..f283178d88 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
> >      }
> >      if (group) {
> >          cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
> > +        dcd->dc.total_extent_count += num_extents;
> >      }
> >  
> >      /*
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index ed6cd50c67..a151e19da8 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -618,6 +618,7 @@ struct CXLType3Dev {
> >          CXLDCExtentList extents;
> >          CXLDCExtentGroupList extents_pending;
> >          uint32_t total_extent_count;
> > +        uint32_t nr_extents_accepted;
> >          uint32_t ext_list_gen_seq;
> >  
> >          uint8_t num_regions; /* 0-8 regions */
> > @@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
> >                                                      uint16_t shared_seq);
> >  void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
> >                                         CXLDCExtentGroup *group);
> > -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
> > +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
> >  void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> >                                   uint64_t len);
> >  void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,

