Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8283D9E
	for <linux-cxl@vger.kernel.org>; Fri, 17 May 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961826; cv=none; b=SV2CdZ8Q3fDNqxClQfsNuOYcwNJwb105TPtSM8nf2LTVV3w+bwvVlY3wdZvRVR9bryOeiBdKCrV2Nx+uAQYvBE7gCj4MX7FPaawjpCdZqUyemVpYyvQ265sBQYCW2djROWcUR2VURZ1bn0YZI3IhyEyYQ1qzwFawgbYGxeGb2Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961826; c=relaxed/simple;
	bh=jFv/vvkvOlMEKIy2LHIB/tX9ynpW1uzzGJuX1d6DWgM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrdxH7Fqad5CLbiKjVha/YPdMDwucaycJV/YjXIyOpDzZG9V4udzSBy1Cvna2yHWvrMoozW9WK76w6Ou3s+LVbS6LcfJrQeIxCbDauoNmcsvHOApVOSWufAWbh9Rfhc/Z1IAll5TKL13dmi02kBs2hwUb4e0wQ4xOiDYt9Vwt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK3wuwR7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK3wuwR7"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ecddf96313so14051955ad.2
        for <linux-cxl@vger.kernel.org>; Fri, 17 May 2024 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715961824; x=1716566624; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nip+K6lz0QcnDcnFAf1QroLYXPqFj24Z42qKu2dyrSA=;
        b=dK3wuwR78rlSRRUEG/sTksiY2IvRQOgb5daGGdm0vmggXP9d7v99t11b4Q0mwxAht5
         8w2lQP4W6aawVXLAq69OROjjJEMKUVLHbc0zUCFsJaFiciS7h7JDTcv6J+W09Blu/7qT
         mX30+DCyFKyBbiNB6dQnXnywZWZzjn969YtzxnSGQMsf38YYqOfMDIwh8h2o58yS5BfD
         ws/CquyP8z56s2EK5WqyrkNpZAqlQ85MQXDoiH1miNxam3KvW9CglfWddW8aIcfTdHbD
         o/+2QRwv7VSREnVred46O/fFCTC55AZ2rpjnPu0gEvyUTXDb+54vQr9hqQA8clRi7dgX
         hw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715961824; x=1716566624;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nip+K6lz0QcnDcnFAf1QroLYXPqFj24Z42qKu2dyrSA=;
        b=gZEJGRnP4/uFmSfdL5e3oG8BZ0VOpytSAtCtCt/kLLiK7Lc37N0oi6FhOnaloGlbWr
         P7MUgrwKttj9tD1U619dYHx8n3NmDfoNYT1zPIhnIsVCpEK/GrOxWGXdS5J4nDfETWjG
         XfusfHrtdP0+OxhmCIAMV8bFuF/vrefZQQ9SZEreY25eEfwzhJ6dkghyRVZnScW2SzRZ
         iSC6GhNPZ891V7u4ZAn6xTpzg5nhM+P2rha+rLvw3GYUP9woA/XoUQ6iuQT9x1nrq5pJ
         OYleRp1s3SYI2gaUthBBkE60AEucGVHpjADn1q2e1yHGuuVjPkeoZyjLrsNyt8hCKYl3
         vhog==
X-Forwarded-Encrypted: i=1; AJvYcCVuSJACaBxos0lFj82mi8ngTOnlezOIYvNtcMPa82v2ns1hMGO33DvjEO7PUfWrlNao7ulD1uLHSjlcsNGEyxBo/4Xe71qK2SVx
X-Gm-Message-State: AOJu0YwsfTLGpH6S1NpiDGp3MTo4IY4kaPiM5NtzdA/TlEsSR0t21PZk
	sE2jZLktKYtzNtYgzyPb7ArZwBUgZwK38AVhHXBSQCZLTLZ2sykOiaLjDQ==
X-Google-Smtp-Source: AGHT+IHfUAZrjImGHWziYopFxbD1rKq0mIN2zT6jOVxG7sCEBDjWvov0GunKKtG9JYS2cLf2c17+Kg==
X-Received: by 2002:a05:6a20:438d:b0:1af:f497:8225 with SMTP id adf61e73a8af0-1aff497887amr24846273637.31.1715961822814;
        Fri, 17 May 2024 09:03:42 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:4ede:fa51:f54a:fe25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f676b08e4esm5114885b3a.79.2024.05.17.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 09:03:42 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 17 May 2024 09:03:34 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, Gregory Price <gregory.price@memverge.com>,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <Zkd_tgVITi7awu3p@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com>
 <ZkY83c9PXoop_r1A@debian>
 <20240517131852.00006bc7@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517131852.00006bc7@Huawei.com>

On Fri, May 17, 2024 at 01:18:52PM +0100, Jonathan Cameron wrote:
> On Thu, 16 May 2024 10:05:33 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:
> > > On Thu, Apr 18, 2024 at 04:10:51PM -0700, nifan.cxl@gmail.com wrote:  
> > > > A git tree of this series can be found here (with one extra commit on top
> > > > for printing out accepted/pending extent list): 
> > > > https://github.com/moking/qemu/tree/dcd-v7
> > > > 
> > > > v6->v7:
> > > > 
> > > > 1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
> > > >    Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
> > > > 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
> > > > 3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
> > > > 4. Added "Reviewed-by" tag to Patch 7.
> > > > 5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
> > > >    reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen) 
> > > > 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
> > > >     (Jonathan)
> > > > 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> > > > 8. Modified QMP interfaces for adding/releasing DC extents to allow passing
> > > >    tags, selection policy, flags in the interface. (Jonathan, Gregory)
> > > > 9. Redesigned the pending list so extents in the same requests are grouped
> > > >     together. A new data structure is introduced to represent "extent group"
> > > >     in pending list.  (Jonathan)
> > > > 10. Added support in QMP interface for "More" flag. 
> > > > 11. Check "Forced removal" flag for release request and not let it pass through.
> > > > 12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
> > > >    to avoid the side effect it may introduce to inject error to DC event log.
> > > >    (Jonathan)
> > > > 13. Hard coded the event log type to dynamic capacity event log in QMP
> > > >     interfaces. (Jonathan)
> > > > 14. Adding space in between "-1]". (Jonathan)
> > > > 15. Some minor comment fixes.
> > > > 
> > > > The code is tested with similar setup and has passed similar tests as listed
> > > > in the cover letter of v5[1] and v6[2].
> > > > Also, the code is tested with the latest DCD kernel patchset[3].
> > > > 
> > > > [1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
> > > > [2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/20240325190339.696686-1-nifan.cxl@gmail.com/T/#t
> > > > [3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3
> > > >  
> > > 
> > > added review to all patches, will hopefully be able to add a Tested-by
> > > tag early next week, along with a v1 RFC for MHD bit-tracking.
> > > 
> > > We've been testing v5/v6 for a bit, so I expect as soon as we get the
> > > MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> > > 
> > > The super-set release will complicate a few things but this doesn't
> > > look like a blocker on our end, just a change to how we track bits in a
> > > shared bit/bytemap.
> > >   
> > 
> > Hi Gregory,
> > I am planning to address all the concerns in this series and send out v8
> > next week. Jonathan mentioned you have few related patches built on top
> > of this series, can you point me to the latest version so I can look
> > into it? Also, would you like me to carry them over to send together
> > with my series in next version? It could be easier for you to avoid the
> > potential rebase needed for your patches?
> 
> I wasn't clear - I meant other way around.
> This series is built on a couple of Gregory's patches.  Gregory can suffer
> the pain of rebasing his stuff ;) (or I'll do it depending on when things
> land).
> 
> hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference 
> https://gitlab.com/jic23/qemu/-/commit/f44ebc5a455ccdd6535879b0c5824e0d76b04da5
> hw/cxl/mailbox: interface to add CCI commands to an existing CCI 
> https://gitlab.com/jic23/qemu/-/commit/00a4dd8b388add03c588298f665ee918626296a5
> 
> I was suggesting your next posting should just include those two with
> your sign-off added. That way if everyone is happy with v8 Michael Tsirkin
> can pick it up directly, saving a step.
> 
> Make sure to add Michael to the to list as well for next version.
> 
> Thanks,
> 
> Jonathan

Oh, I totally mis-understood.

Sure. I will add the two patches with my sign-off to my next post.

Fan
> 
> > 
> > Let me know.
> > 
> > Thanks,
> > Fan
> > 
> > > > 
> > > > Fan Ni (12):
> > > >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> > > >     payload of identify memory device command
> > > >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> > > >     and mailbox command support
> > > >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> > > >     type3 memory devices
> > > >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> > > >     devices
> > > >   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
> > > >     size instead of mr as argument
> > > >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> > > >     regions
> > > >   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> > > >     list mailbox support
> > > >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> > > >     dynamic capacity response
> > > >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> > > >     extents
> > > >   hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
> > > >   hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
> > > >   hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> > > > 
> > > >  hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
> > > >  hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
> > > >  hw/mem/cxl_type3_stubs.c    |  20 ++
> > > >  include/hw/cxl/cxl_device.h |  81 ++++-
> > > >  include/hw/cxl/cxl_events.h |  18 +
> > > >  qapi/cxl.json               |  69 ++++
> > > >  6 files changed, 1396 insertions(+), 45 deletions(-)
> > > > 
> > > > -- 
> > > > 2.43.0
> > > >   
> 
