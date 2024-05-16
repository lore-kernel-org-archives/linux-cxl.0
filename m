Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191586FD5
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879139; cv=none; b=OfoV61y3Tqwm5pSMJ4P1OYnNn7Q18xdNpDY3Vom+yQajcxzvD/dBACRuM7xBp4gjdEkYyk6yt0i6z+5OfOIJpnNaWGI09WW2/GF6kkxYUYiMuEDwD+2OX32EQ/KxkYzLQn+iopOZ/EnW6pR5jQSdkPIDXdPgkh4QZrQolzifm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879139; c=relaxed/simple;
	bh=dMGDJK57NFbqwxsL5rWJKeGo+IbDnllRFgbbJy7r3PM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW8WnYMUqslxwrMAsIOm+4fd2B7Ke1Fs7wSnwQmblnoh+Wn3ZEylEj/soQJ9nTQc7GLgi73zre+IAan5oB8l4eT7P2kYgJCRn7F0QhZ+2p8Go/Qh+SPonAVVjZP0SmxI79fG5xAlvAD1KSJD6MwBZIUqqSWrPHCK2ossQgtWJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUEeSdz2; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUEeSdz2"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de603e3072dso9319380276.1
        for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715879137; x=1716483937; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=svnRaxp+qCp2pAr6pMbLzaQmbhTIyubR1YovLRC4saY=;
        b=cUEeSdz2E5eQUJneHgsCis8gd12Kh/D/sSn6jXWttlgnge9PTwT/Kv6xTtXXg/2R+F
         meIIwkCjseShq+VTi4fXCi62qP36GAhWKofaIQ1ygpETXp8YI2QMMeJW+1uYJeckQhIJ
         tO5HDVtBKAS50oUWC8OAjvul9Wf8PGiNja7fTaaWSlotOlD88nZJYkYBLjFDni/ccOcF
         bZ1tVS0UcqbO7OBCoHz7eJk7tUBWLxhPnrKbzc3E2An/QwP51eASBdBwcrANux+8BdZu
         DqkXE3W2ic80XIYkQSYt/ozLRkuqZj6+hl7bGDp9YXnnvQPvZHDbJiOJmrFSALILU4kE
         Xzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879137; x=1716483937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svnRaxp+qCp2pAr6pMbLzaQmbhTIyubR1YovLRC4saY=;
        b=qQQ4vW+DENRLKxHI9CXXZWNQXWd72AYqPngMdtQudgrfQc9vOeMxdT3qUkM3jOlcCn
         zrWge8SLkxSoM7fzrdwxLFOsoDKIElh+wY1r6harQHKboCDxrZvQSjdzyYqbFkfXnllc
         DdH9XANpDMWKhIeW+8df1aBCmztj/Swr8LXqsQnPPR4nM5dSb7L8LuIJWQCcSqdPuuGC
         bw2STdKQTUdBXYgXSsZzWEf5LDcjzlxzdWis8Hy/uoWh1QnSiNV9VnN11HLB+ut2uo8v
         6PV4bfmQY48WDfA6S3xU2+llN8kcwBPMBCaFGP20Q4AdWIhmHsHug8mqgRS7/PhnKQ0t
         GnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLKcPgpiugdee3mQHNdzwWUqYX1AsbAnDqP8yy55EykRd4CYj/JtX4NW0Rcl4rlh/TJjjoVHlDmejyv6gbFtMYPA0wjRSgZtAY
X-Gm-Message-State: AOJu0Yz1jGJpjC8esR+chYb/E8HueKufAreF8mmBG3VQMNQBCjd1HB1+
	iFAUtPraGDAHpLZARiI0N4uFO4uf5pv0d2TCt8nwEU5KRdbgpIIR
X-Google-Smtp-Source: AGHT+IE2RR+DAaC1q8ZIc/X2VU9lfjSHeBKCNRpKBlWm9zEWrGg9+a0nR1xLQb1psmgPdXiB357Fdg==
X-Received: by 2002:a25:a322:0:b0:de1:2843:9465 with SMTP id 3f1490d57ef6-dee4f3089e4mr18532854276.30.1715879136944;
        Thu, 16 May 2024 10:05:36 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd38293bfsm3515687276.52.2024.05.16.10.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:05:36 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 16 May 2024 10:05:33 -0700
To: Gregory Price <gregory.price@memverge.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZkY83c9PXoop_r1A@debian>
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
I am planning to address all the concerns in this series and send out v8
next week. Jonathan mentioned you have few related patches built on top
of this series, can you point me to the latest version so I can look
into it? Also, would you like me to carry them over to send together
with my series in next version? It could be easier for you to avoid the
potential rebase needed for your patches?

Let me know.

Thanks,
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
