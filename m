Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E9156675
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879546; cv=none; b=crzIoz2A8SowH62uvsJUqaWnKsSDB3afzp1hOmraesctJVBTH0Rn4sQOhp67R3sLCMnZ+9SqRs+5yzHL3Jp1QZDaBv3X4lIe91XeTccG/mzmgAqmPyl8domboz3bkswqtyvJ1RuT6+lDif3PJQqVugYMMTBRa20zg9QaFDpt0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879546; c=relaxed/simple;
	bh=UcnuifV+Zp9ilK81hOJiJovEa6lfk0AG8GVEsxTKKhw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPFkq26fgzXkCnYLU5uOZKGEgjlvUOWHNSk1b6T73d5gfDAK+4boROrYTP0PS9PG+psp+1TorYn7xozdT9yUEOhDCFYYW2LLJ7MlZJT9+F8C1STX5xwujVQIScLgEb/m35r5DJcPISsQ0siR30UswaMIfQ2+uAVJvEYGMNFmzSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SREIRCnH; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SREIRCnH"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-deb99fa47c3so8565175276.2
        for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715879544; x=1716484344; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=snPyh1RNmFPpaf4s2wMbMsVnyHhD/A9xFV3JyNxhnhg=;
        b=SREIRCnHLqaLpfXpowOMEPsYqqpg6FL59PqX6Vf04znGHdplXuhB6TDHWuyKkg9lwU
         /kl+deAbIUXJHLv94xK+rRWRYPW6oKLdBUFGDzC3mMpbFwIaqHtBWLq8+i2mp8UXZPl+
         tdbeQE/Y8zP68/28vUh/+A3KHVGXRoenNkCsN79fbF/DLoFXv6SkSQh9iwBH7MXcdSU5
         l6AFJWuqTZ6MZnULnUf5wEotl3s4ycKC8q4iY1wzp8uQ8hsynY8LQ4jsRP4cXg+VWFS8
         NmOg0svsmVpg+sgwewJr+/86gJce7lq8KzOpu3eq0DR0wQ4qrnCbWiH2zcWwe3cS7UQQ
         UmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879544; x=1716484344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snPyh1RNmFPpaf4s2wMbMsVnyHhD/A9xFV3JyNxhnhg=;
        b=JbIOeX7yCEYSn6tEcKJHtJaL7F/sILXKZ0smjz5+0dq+nfY99ht7w/NDQLqTGKW6sD
         Ayy4lAwzMZxs6A/rh4n9fof6Atl1qFgH/Ia80ZMV9SfC8k+9Vhh8KiHSiKYZYlfTdRJZ
         n0bw10kMbTbWp7DMga060/Uw+beJZfdHES/fV6u89fCrX8/XVEsfW+CzgyGtvDx6B4JO
         cUtkQZWQYzw6umPCQNTbdxk/A7mY7j6luHBVLxhAFgTDgNVDyY13S4Pme8LA0/fRlc8Y
         iIqSE6RLrx6cwY5BOnvO7D8wTHwocCQKkCHKsZUCfh8LwWbrwzgw2Jsq5gG9FUC+azSs
         iS6A==
X-Forwarded-Encrypted: i=1; AJvYcCXgM8d4RAwcgg4dJQHAl3G8S+zs5RtTAyH++Pn/f9w44BNniIV/i8zk6HHSmbSRLH+XR+PGVn7MrucDH0127VMteSKmzTBORL81
X-Gm-Message-State: AOJu0YwZk/PszPzBgd0Hl59W6SVnU3Lrpa86qeNvUrohtlD2pbQKKK8m
	DHwgkVdwWKo3dKGUMJAt9X1IStRt4irJiQawEBTDfmtP++SgmwPs
X-Google-Smtp-Source: AGHT+IEWmL1dlJHYMl9hrGJxzFwQWp75Gt/TK3FJTnQhi4RuoY146wK4nRuaqzXyu8ODpPW9uJAdGA==
X-Received: by 2002:a25:2e0c:0:b0:de6:40b:fef2 with SMTP id 3f1490d57ef6-dee4f2d8e89mr18715674276.18.1715879544040;
        Thu, 16 May 2024 10:12:24 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd34fde87sm3559038276.0.2024.05.16.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:12:23 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 16 May 2024 10:12:19 -0700
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"Jorgen.Hansen@wdc.com" <Jorgen.Hansen@wdc.com>,
	"wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZkY-c1V-o4100onE@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <d708f7c8-2598-4a17-9cbb-935c6ae2a2be@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d708f7c8-2598-4a17-9cbb-935c6ae2a2be@fujitsu.com>

On Tue, May 14, 2024 at 02:16:51AM +0000, Zhijian Li (Fujitsu) wrote:
> Hi Fan
> 
> 
> Do you have a newer instruction to play with the DCD. It seems that
> the instruction in RFC[0] doesn't work for current code.
> 
> [0] https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@samsung.com/
> 

For the testing, the only thing that has been changed for this series is
the QMP interface for add/release DC extents.

https://lore.kernel.org/linux-cxl/d708f7c8-2598-4a17-9cbb-935c6ae2a2be@fujitsu.com/T/#m05066f0098e976fb1c4b05db5e7ff7ca1bf27b1e

1. Add dynamic capacity extents:

For example, the command to add two continuous extents (each 128MiB long)
to region 0 (starting at DPA offset 0) looks like below:

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "hid": 0,
      "selection-policy": 2,
      "region-id": 0,
      "tag": "",
      "extents": [
      {
          "offset": 0,
          "len": 134217728
      },
      {
          "offset": 134217728,
          "len": 134217728
      }
      ]
  }
}

2. Release dynamic capacity extents:

For example, the command to release an extent of size 128MiB from region 0
(DPA offset 128MiB) looks like below:

{ "execute": "cxl-release-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "hid": 0,
      "flags": 1,
      "region-id": 0,
      "tag": "",
      "extents": [
      {
          "offset": 134217728,
          "len": 134217728
      }
      ]
  }
}

btw, I have a wiki page to explain how to test CXL DCD with a tool I
wrote.
https://github.com/moking/moking.github.io/wiki/cxl%E2%80%90test%E2%80%90tool:-A-tool-to-ease-CXL-test-with-QEMU-setup%E2%80%90%E2%80%90Using-DCD-test-as-an-example

Let me know if you need more info for testing.


Fan

> 
> 
> On 19/04/2024 07:10, nifan.cxl@gmail.com wrote:
> > A git tree of this series can be found here (with one extra commit on top
> > for printing out accepted/pending extent list):
> > https://github.com/moking/qemu/tree/dcd-v7
> > 
> > v6->v7:
> > 
> > 1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
> >     Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
> > 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
> > 3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
> > 4. Added "Reviewed-by" tag to Patch 7.
> > 5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
> >     reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen)
> > 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
> >      (Jonathan)
> > 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> > 8. Modified QMP interfaces for adding/releasing DC extents to allow passing
> >     tags, selection policy, flags in the interface. (Jonathan, Gregory)
> > 9. Redesigned the pending list so extents in the same requests are grouped
> >      together. A new data structure is introduced to represent "extent group"
> >      in pending list.  (Jonathan)
> > 10. Added support in QMP interface for "More" flag.
> > 11. Check "Forced removal" flag for release request and not let it pass through.
> > 12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
> >     to avoid the side effect it may introduce to inject error to DC event log.
> >     (Jonathan)
> > 13. Hard coded the event log type to dynamic capacity event log in QMP
> >      interfaces. (Jonathan)
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
> > 
> > Fan Ni (12):
> >    hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >      payload of identify memory device command
> >    hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >      and mailbox command support
> >    include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >      type3 memory devices
> >    hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >      devices
> >    hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
> >      size instead of mr as argument
> >    hw/mem/cxl_type3: Add host backend and address space handling for DC
> >      regions
> >    hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> >      list mailbox support
> >    hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >      dynamic capacity response
> >    hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >      extents
> >    hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
> >    hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
> >    hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> > 
> >   hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
> >   hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
> >   hw/mem/cxl_type3_stubs.c    |  20 ++
> >   include/hw/cxl/cxl_device.h |  81 ++++-
> >   include/hw/cxl/cxl_events.h |  18 +
> >   qapi/cxl.json               |  69 ++++
> >   6 files changed, 1396 insertions(+), 45 deletions(-)
> > 
