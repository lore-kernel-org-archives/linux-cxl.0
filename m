Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D0D10A14
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713285435; cv=none; b=b9VLH9UqVTmG7Qv7mDCTls3MO7nLEgnGHk+/W52XQNiYUG6Asc0F+TAnLBd2ubWfkbyvY0TQBDqPtcu07jXqEzO4snQicOPXt08BdHHG1z3qPLD1fzybhE2hZCDarm1TgkWoNsISx+zp3yQFplKmtmpDI9zzJcPVG/JBUcVricg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713285435; c=relaxed/simple;
	bh=WFRv13/jZwx+kjOBcw/u1tUzZJhFkeGfYTmsGU1Wazo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn9ToT2rq8MDpDkgsAu3m9LFgsfvM9FJerStL2jRNQIGpmaHG5YH1I/rfvQp/Q+DbX3UCUvVlEYaiM8Vv6GmDInExfB32CTcYXGop9cHFsMDizql79tkd8yc606KEHqbdDtVN2KI83JM4pXY0zUXfewsKVB0GGrfkIb2SlJfhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laklfav3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laklfav3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3f17c6491so39573225ad.2
        for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713285433; x=1713890233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tNkzCRV02na/4jpDqu06Tw7UMHfd7rDdiAUaQoNz8M8=;
        b=laklfav3+WOag+bLhSwF48NhevCV+0Swwr4cOBwQsSoWYL42XYbRMQ7pIoZtWK1XII
         ye6EVGel7F17RWHylNbRgHc35MwqsWwTApBN3w0HbosNytqqvvdGvB6G8zfgEVkGBfv4
         TM6TSJnrzozqE8iML1ojeIznPqTipSXuPfVATfK7wk5pvpbvExtPEQH+TCH6JhE/1EMt
         CNeDbrphSTVOuyOafqB9V5Vc14ACLnye1/7XhaFa2xIwP/u3j2b6rz2M2X/ZcXvdYxaA
         FrLBqJX1BZaJLFUSAhFFspuoYNgB5m8oYEw7mivCCVJNewIcMm1E6ATQQQ2HsDplibzg
         UjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713285433; x=1713890233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNkzCRV02na/4jpDqu06Tw7UMHfd7rDdiAUaQoNz8M8=;
        b=DCgdHr9YLdQ+zpLX7R96zrXmF57OOddChzgMmEtwbiWVmBo9iZqNTlLtMLSJcGR0wW
         1uLrmpOVmBf+ePa3qXPq868FmEIPZu7kDJg40/LuxBYZp5pjIdS7mAjqNBt+14sdtno+
         WIexqIdeTrTSEGaoo53RWXDhyk0CWFNDRaHT0DB7tw/AX9v06vPEqSMBiabKVjoxZIKP
         Cbj0gAoNP5q88GqgxtvcDje3bBSrEmvYlOFSfrbFiP543sd9A+c19EGLyrkfg/0tjd9R
         M7Ebf5x3jX4G6hxLaGnCUxqw9kf80sZbLl6A78WdA9yBQe1hzyvDqh7P7qeN9ES9Kz/0
         1Ciw==
X-Forwarded-Encrypted: i=1; AJvYcCXg0aJK6tE9+pn7KGwJw6+fejLaeMYpIHkkXivKzc+gPczUqvlHknC+0H+KhqEZFgxkOqJj0JSbs36wCot7UlFmyjBdDgL9jCQ0
X-Gm-Message-State: AOJu0YwH8D55RAqXoOhQSSBc1TcIMsCl7SVoLbVGfgvoAtK5pM08Ra6x
	rnZp3CEiHI1qRDFeEK+oEZAmJWGCRyBY/qNz23HsM/jyGfdP/mM5
X-Google-Smtp-Source: AGHT+IE6czJgFucFxlf98LtQLm/wnevBndiZG+W6ku5aN3q6n//IjyvcR38HWN26CadSJffuQxJZPw==
X-Received: by 2002:a17:902:650a:b0:1e4:360:d926 with SMTP id b10-20020a170902650a00b001e40360d926mr10848241plk.5.1713285433106;
        Tue, 16 Apr 2024 09:37:13 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b278:701:b83f:cdc])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001e20afa1038sm10207300pln.8.2024.04.16.09.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:37:12 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 16 Apr 2024 09:37:09 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, Gregory Price <gregory.price@memverge.com>,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <Zh6pNVIZFMQadmOm@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
 <Zhm7ssKVGdGlR9Iq@memverge.com>
 <Zh1lk8FWmf0oI7RM@debian>
 <20240416160056.0000325c@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416160056.0000325c@Huawei.com>

On Tue, Apr 16, 2024 at 04:00:56PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Apr 2024 10:37:00 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Fri, Apr 12, 2024 at 06:54:42PM -0400, Gregory Price wrote:
> > > On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote:  
> > > > From: Fan Ni <fan.ni@samsung.com>
> > > > 
> > > > All dpa ranges in the DC regions are invalid to access until an extent
> > > > covering the range has been added. Add a bitmap for each region to
> > > > record whether a DC block in the region has been backed by DC extent.
> > > > For the bitmap, a bit in the bitmap represents a DC block. When a DC
> > > > extent is added, all the bits of the blocks in the extent will be set,
> > > > which will be cleared when the extent is released.
> > > > 
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > > ---
> > > >  hw/cxl/cxl-mailbox-utils.c  |  6 +++
> > > >  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
> > > >  include/hw/cxl/cxl_device.h |  7 ++++
> > > >  3 files changed, 89 insertions(+)
> > > > 
> > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > index 7094e007b9..a0d2239176 100644
> > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > > @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> > > >  
> > > >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > > >          ct3d->dc.total_extent_count += 1;
> > > > +        ct3_set_region_block_backed(ct3d, dpa, len);
> > > >  
> > > >          ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > > >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);  
> > > 
> > > while looking at the MHD code, we had decided to "reserve" the blocks in
> > > the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in order to
> > > prevent a potential double-allocation (basically we need to sanity check
> > > that two hosts aren't reserving the region PRIOR to the host being
> > > notified).
> > > 
> > > I did not see any checks in the `qmp_cxl_process_dynamic_capacity` path
> > > to prevent pending extents from being double-allocated.  Is this an
> > > explicit choice?
> > > 
> > > I can see, for example, why you may want to allow the following in the
> > > pending list: [Add X, Remove X, Add X].  I just want to know if this is
> > > intentional or not. If not, you may consider adding a pending check
> > > during the sanity check phase of `qmp_cxl_process_dynamic_capacity`
> > > 
> > > ~Gregory  
> > 
> > First, for remove request, pending list is not involved. See cxl r3.1,
> > 9.13.3.3. Pending basically means "pending to add". 
> > So for the above example, in the pending list, you can see [Add x, add x] if the
> > event is not processed in time.
> > Second, from the spec, I cannot find any text saying we cannot issue
> > another add extent X if it is still pending.
> 
> I think there is text saying that the capacity is not released for reuse
> by the device until it receives a response from the host.   Whilst
> it's not explicit on offers to the same host, I'm not sure that matters.
> So I don't think it is suppose to queue multiple extents...

Are you suggesting we add a check here to reject the second add when the
first one is still pending?

Currently, we do not allow releasing an extent when it is still pending,
which aligns with the case you mentioned above "not release for reuse", I
think.
Can the second add mean a retry instead of reuse? 

Fan

> 
> 
> > From the kernel side, if the first one is accepted, the second one will
> > get rejected, and there is no issue there.
> > If the first is reject for some reason, the second one can get
> > accepted or rejected and do not need to worry about the first one.
> > 
> > 
> > Fan
> > 
> 
