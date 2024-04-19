Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210E28F1
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552219; cv=none; b=uuDQpwC2iOL8KWwlpg96dQBxkaL20wra8zXlyr2CRs+yKhKhyczW7Un8ra8E5rQ4afsTgCF3s7f8Dig5X8EM82zHELAsxjXftiVa/0vGrP21OauloidU99F7VZ4DcWRmfTHFairwrRDzpDFAC/2m6UnJsPKmFpRQn6x3NYZ/ZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552219; c=relaxed/simple;
	bh=7vdyUDLWy2YGytGCUK0WrzRQVn6u+3RNHL3BRxr+tcQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC/jdy7tBEJKPHWgo1JTKhJfoK+T4YQfEKjMdrok/CYVBV7X2ALk99xd0u3uzBD7zr2IT4I8M69f5e1u4Qgn4b9t04VpXviYgGtyz46leNTI3S5L3zbK9HvJwPrB6ENye/KD3hdHNzrlZoZI0US3N7Og3A9hSjKXCej/n4LurnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUJg5ucu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUJg5ucu"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed627829e6so2595877b3a.1
        for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 11:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713552217; x=1714157017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y3SGJdTiCbneZQ9xF1P/4L3glY2bSj97aScmfRfKL+g=;
        b=cUJg5ucuxPoTd3Gp99gWiakbl+x41ZxkDZE67t76D8raufoF+v99WOERLxXr0lgtE8
         8fg3o2Vrw4RMxK2dcCTBaMHyv3YmEteAbjLiRzEm1pdouEUfIqEPlhe72WTHNKBdLHX+
         +HYzgrpeYN97wLTK4n4ImOwWk2MFi2tueMsD8GtMqSTgZoN24GM/grJe38swMg+w25YD
         SRpFACMtoFBOCRBIGQLG0ciYMmRZ0/P4FVRVzNYCrCtcEDhkqHACtjQEdm5dVgZuR/ol
         fPVzZCSQP841H1mJR4I/g3BEbByrcvBDb+P5mHINr01/rbtkgoG+pRXdqrkEQPFbSKyn
         eHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713552217; x=1714157017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3SGJdTiCbneZQ9xF1P/4L3glY2bSj97aScmfRfKL+g=;
        b=kirBW254KHqO2JxdKt9P3vGlGMv/D/ncVTFNs4gR9Dfh5uQ07snRhB+PVuayhLkgyx
         WAfpKNhOWJ6kpBWSTQ+UeYsCArKc1Pl3a4HE8sNxFz6O1gt2A0jQMUZkYQGmNXcHfuYe
         3drW5TEDtqy4+uogxaILWpkcPexOarAzfZLHsCIW/2iDFydExS53fvR6QqxsUt9kJ73A
         39/hH1LqikMg443X1mFqXaXWf6p+BYVATIMHyHfnFSSuDqsr2hY9V3mUYfWiAYKZGvk5
         VDmLkN/bGy+MkUjzbItqPXMuQSVokYzOXMt57kD6HXw5w9bdWboV4T+n0OhWBKi1OnID
         dZ2w==
X-Forwarded-Encrypted: i=1; AJvYcCXJaDRgIItZdXtlSMyrP3ZOfq0drIypRUuyGky8ThQ7wL6PnrDNs3nWMSEJi8hKnsetcDvt+HRSAD8bMBRcsgYH9YuvNkfqIsiY
X-Gm-Message-State: AOJu0YwB2u7fmO/hKgXQZ1ZUkxXwWbA7LhMvtGiqpzDzTRDpkNyZ/WNM
	VkAKmRST0dU0uW3+F3XVVRIRiVZfIV573lpwi2NguOyJVHzslj8D
X-Google-Smtp-Source: AGHT+IEt0rYHHfLtoYwUigOXzCd9ynf0M/YgxLHlr/sd4dfyIGeWRMQ4jzueIoH7XMv3/wp0wSy0og==
X-Received: by 2002:a05:6a20:551a:b0:1a7:7d2f:6c01 with SMTP id ko26-20020a056a20551a00b001a77d2f6c01mr2992182pzb.48.1713552217279;
        Fri, 19 Apr 2024 11:43:37 -0700 (PDT)
Received: from debian ([2601:641:300:14de:df9a:a0db:2922:7fe6])
        by smtp.gmail.com with ESMTPSA id n56-20020a056a000d7800b006e6b7124b33sm3551497pfv.209.2024.04.19.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:43:36 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 19 Apr 2024 11:43:14 -0700
To: Gregory Price <gregory.price@memverge.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZiK7QtVxutwDys4K@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiK25Log7LmtBffa@memverge.com>

On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:
> On Thu, Apr 18, 2024 at 04:10:51PM -0700, nifan.cxl@gmail.com wrote:
> > A git tree of this series can be found here (with one extra commit on top
> > for printing out accepted/pending extent list): 
> > https://github.com/moking/qemu/tree/dcd-v7
> > 
> > v6->v7:
> > 
> > 1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
> >    Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
> > 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
> > 3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
> > 4. Added "Reviewed-by" tag to Patch 7.
> > 5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
> >    reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen) 
> > 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
> >     (Jonathan)
> > 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> > 8. Modified QMP interfaces for adding/releasing DC extents to allow passing
> >    tags, selection policy, flags in the interface. (Jonathan, Gregory)
> > 9. Redesigned the pending list so extents in the same requests are grouped
> >     together. A new data structure is introduced to represent "extent group"
> >     in pending list.  (Jonathan)
> > 10. Added support in QMP interface for "More" flag. 
> > 11. Check "Forced removal" flag for release request and not let it pass through.
> > 12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
> >    to avoid the side effect it may introduce to inject error to DC event log.
> >    (Jonathan)
> > 13. Hard coded the event log type to dynamic capacity event log in QMP
> >     interfaces. (Jonathan)
> > 14. Adding space in between "-1]". (Jonathan)
> > 15. Some minor comment fixes.
> > 
> > The code is tested with similar setup and has passed similar tests as listed
> > in the cover letter of v5[1] and v6[2].
> > Also, the code is tested with the latest DCD kernel patchset[3].
> > 
> > [1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
> > [2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/20240325190339.696686-1-nifan.cxl@gmail.com/T/#t
> > [3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3
> >
> 
> added review to all patches, will hopefully be able to add a Tested-by
> tag early next week, along with a v1 RFC for MHD bit-tracking.
> 
> We've been testing v5/v6 for a bit, so I expect as soon as we get the
> MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> 
> The super-set release will complicate a few things but this doesn't
> look like a blocker on our end, just a change to how we track bits in a
> shared bit/bytemap.
> 

Hi Gregory,
Thanks for reviewing the patches so quickly. 

No pressure, but look forward to your MHD work. :)

Fan

> > 
> > Fan Ni (12):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >     type3 memory devices
> >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >     devices
> >   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
> >     size instead of mr as argument
> >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> >     regions
> >   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> >     list mailbox support
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >     dynamic capacity response
> >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >     extents
> >   hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
> >   hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
> >   hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> > 
> >  hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
> >  hw/mem/cxl_type3_stubs.c    |  20 ++
> >  include/hw/cxl/cxl_device.h |  81 ++++-
> >  include/hw/cxl/cxl_events.h |  18 +
> >  qapi/cxl.json               |  69 ++++
> >  6 files changed, 1396 insertions(+), 45 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 
