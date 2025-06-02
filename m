Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BEF523A
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886422; cv=none; b=NcZt8lPLQ7rLt8x5jjpCdC9liQrZU6WNzEqDZgQHihgPWWJPUEP3W1gzUPMpDHo/UeD1U/7UYBas9BJ0rjL29VsLKfwIVzVRy6faMCC+Hg6gmSl9L+MNtq9yCRnJVaVS+5r3T6ErpOL1eK+4N2hz1iCJbD4mQm++3m37A9fY1pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886422; c=relaxed/simple;
	bh=uOuNxcoptLo+I7LePoEOmLrnV5RBxcvnAiOvfseCwQo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkaDdYxd1UCzxnMD08KYFJeqJRGIXKUN0LU1Pe6zKQ0WYonIL8kiqk2PkZVG3pwkQrQKYX5LTi/Ve7NQLk4sqZQdmE9kbF5kwnAHDBsjmiSlRYDVbb3ILyQMHgIw4U3BXJDV4OUoOkY7bgWvHmCSqOlxBeiVxUABtwrXfKM6i9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDD9DtFE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDD9DtFE"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so4092512b3a.3
        for <linux-cxl@vger.kernel.org>; Mon, 02 Jun 2025 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748886420; x=1749491220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXOxmjxJTW7vpVDwTCYY+gUTdvFyCG/DWn1e8gUxoXc=;
        b=WDD9DtFEarbUQedwjJzcrS4mpBZsdSxiQ56vvN9Io5hxWn9D3WNgGUxG0nK2205til
         9uDSXePLbPrifGck1g5IAF3EG1OIymBp1+EaIYfeHCaGqC/y59eRDfUYTTLWaizT0MrT
         fcBYT+lk1GNneC1UTn4cXjDIjNe77BAFmcgkMxG29AVuFFIuMLxk29sjatgZ8s024US0
         LVmTtk3q8VTGTfXAgXApxKcaF9XS/aeUKAqfexwLJbnT8TV93nxyvhj2kIw0iZFsIAoq
         mn6Re7yCVBxy+PIkyjaXaIK8ee2wZ6aTwhKyuIDomzPlhyqIgBrFQtaOVmsYpuKob/6R
         nlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748886420; x=1749491220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXOxmjxJTW7vpVDwTCYY+gUTdvFyCG/DWn1e8gUxoXc=;
        b=RANwvCT9sWLQUJBoNbsA4kMaTkBV6KeBFxmi0R4p9w+bctQRIfEtLxfrfXJhHrqaaR
         m/bLAHkHnlQ/t70sqMCZhnXDSZTaVOdfn7x3ZKcjt5fWwXYw5QtySxPpJ2sRtFL1U3YZ
         vWMkv0LIgeq+lUSquO6dG/LjsiKyJGoL74I5oBpRG81Du13fSMUoWG+B+xwsZb+XpuoA
         5SLNCGbu03oEdxE1QaI4IhSD/0WjapVbMwj3YYxzgg43cNF3Nu3n727NkoA5tdSQaj9V
         iWAZ0Ec9cQXiDeDHGyMc4fsdJCXbYgE2Rz+UKhhmiOARfxT03QNUsx9y66nieX3OwQ3i
         beug==
X-Forwarded-Encrypted: i=1; AJvYcCVqv1uEbq6+8OueWUc9S2BFVesVrggoqV8fDmjlmJLOC22nzKz6OJQOwkau4RokYbkN9geI2BqDpcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+qaAQqkX4gpkiu+v+aAv2kE9nqJB5EWGKxBw3W7Xtq/Ii681j
	leFLerSU+uQazj3zGPNjzj2xkL/jEvuSnMcb5kj5Dny71BpZV5ypd1GUKWf40Q==
X-Gm-Gg: ASbGncuRtDejY1vmyniHh89Yobto3go0gPEALrU0w0ne5kzPcamd4WoF5JbBWad78rT
	Mds6viLa14M/O12Qr5Giku2C+o7bv03ZKmsQ3NCborL1LPDC3PClp0/abL1twNJIo2VY17krhdq
	WcllTwK++30gtv7WlgCfB9/MQmIl83S4mKVQmtnaOZlQw8v37SOGt0t6U96eshp0G1YUd+KCiUq
	5skIcEJb0nLDaluwZmfhl/JLfGJ5C0fBJDha9l4YUh95px59LgBAOCK9a9AVn32rT7z5gQkN+1K
	x2AtT5TVVEKLP03Uj4CjSgdjwYHmPSKHPmy601HaEtQDZ5lbmSTwJBeixTUeObWRLqL1QXkac5b
	K1g==
X-Google-Smtp-Source: AGHT+IGwTXr02neCGnVcFeoVH37rrSREjgCOPvTOpyw3Wo4CW4jsOWStJ26+hgejI175AltkHOrL8Q==
X-Received: by 2002:a05:6a00:10c8:b0:747:cffb:bb37 with SMTP id d2e1a72fcca58-747d1833514mr11642565b3a.10.1748886419565;
        Mon, 02 Jun 2025 10:46:59 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab75csm8138278b3a.52.2025.06.02.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 10:46:59 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 2 Jun 2025 17:46:57 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, anisa.su887@gmail.com,
	nifan.cxl@gmail.com, dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Message-ID: <aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250520143947.00000337@huawei.com>
 <20250530152655.00007132@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530152655.00007132@huawei.com>

On Fri, May 30, 2025 at 03:26:55PM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 14:39:47 +0100
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
> > On Thu,  8 May 2025 00:00:56 +0000
> > anisa.su887@gmail.com wrote:
> > 
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > This patchset adds support for 6 FM API DCD Management commands (0x5600-0x5605)
> > > according to the CXL r3.2 Spec. It is based on the following branch:
> > > https://gitlab.com/jic23/qemu/-/tree/cxl-2025-02-20.  
> > 
> > Nice work - this is very clean and well presented.
> > 
> > I would like Fan to take a look an provide some tags as DCD modeling in
> > QEMU is more in his area of expertise than mine!
> > 
> > I think this series is much more ready for upstream than much of
> > my staging cxl tree so I'll rebase it to go near the front.
> > 
> > Today I'm focused on getting test cases to Richard for the TCG issues but
> > after that I'll spin a new tree (probably pushed out under a name
> > that makes it clear there is a known nasty problem though!)
> 
> Anisa,
> 
> Ideally I'd like to get the majority of this upstream once you post
> a v3.  To do that I'd like to break the dependence on mctp_i2c in patch 2.
> These commands are equally valid via a switch-cci (and that path to the
> fm owned ld_mctpcci is already upstream).
> 
> If you could send it as two series. One of which sits on upstream and
> doesn't include the i2c_mctp part and the other of which is applied once
> that support is available in my tree that would be great. I'll squash
> the i2c_mctp part into the patch that adds support for that in the
> first place.
> 
> I'll deal with rebasing needed for other command introductions etc.
> 
> There are just enough open questions in this series that I haven't done
> this rework directly (though I did start doing it - hence the missing
> include note in one of the patches).
> 
> Thanks,
> 
Sounds good, will do :)

Thanks,
Anisa
> Jonathan
> > 
> > Jonathan
> > 
> > 
> > > 
> > > The code was tested with libcxlmi, which runs in the QEMU VM and sends 56xxh
> > > commands to the device (QEMU emulated) through MCTP messages over I2C
> > > bus. To perform end-to-end tests, both MCTP and DCD support are needed
> > > for the kernel, so the needed MCTP patches are applied on top of Ira's DCD
> > > branch https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.
> > > 
> > > For the tests of commands 0x5600 (Get DCD Info), 0x5601 (Get Host DC Region
> > > Config), and 0x5603 (Get DC Region Extent Lists), DCD kernel code is not involved.
> > > The libcxlmi test program is used to send the command to the device and results
> > > are collected and verified.
> > > 
> > > For command 0x5602 (Set DC Region Config): device creates an event record with type
> > > DC_EVENT_REGION_CONFIG_UPDATED and triggers an interrupt to the host
> > > if the configuration changes as a result of the command. Currently, the kernel
> > > version used to test this only supports Add/Release type events. Thus, this
> > > request essentially gets ignored but did not cause problems besides the host
> > > not knowing about the configuration change when tested.
> > > 
> > > For the command 0x5604 (Initiate DC Add) and 0x5605 (Initiate DC Release), the
> > > tests involve libcxlmi test program (acting as the FM), kernel DCD
> > > code (host) and QEMU device. The test workflow follows that in cxl r3.2 section
> > > 7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
> > > steps,
> > > 1. Start a VM with CXL topology: https://github.com/moking/cxl-test-tool/blob/main/utils/cxl.py#L54.
> > > 2. Load the CXL related drivers in the VM;
> > > 3. Create a DC region for the DCD device attached.
> > > 4. add/release DC extents by sending 0x5604 and 0x5605 respectively through
> > > the out-of-tree libcxlmi test program
> > > (https://github.com/anisa-su993/libcxlmi/blob/dcd_management_cmds/tests/test-fmapi.c).
> > > 5. Check and verify the extents by retrieving the extents list through
> > > command 0x5603 in the test program.
> > > 
> > > The remaining 3 commands in this series (0x5606-0x5608) are related to tags
> > > and sharing, thus have not been implemented.
> > > 
> > > Changes
> > > ================================================================================
> > > v1 -> v2:
> > > 1. Feedback from Jonathan Cameron on v1
> > > Addressed general style concerns (newlines/spacing, minor refactoring, etc.)
> > > 1.1. Changes Related to 0x5600 - FMAPI Get DCD Info
> > >     - Squashed prepatory patch adding supported_blk_sizes_bitmask
> > >     - Added new prepatory patch moving opcodes enum from cxl-mailbox-utils.c to
> > >     new header file opcodes.h
> > >     Needed for the check in i2c_mctp_cxl.c to ensure the FMAPI Commands
> > >     (0x51 - 0x59) are bound with MCTP_MT_CXL_FMAPI. By moving the enum,
> > >     the hardcoded values (0x51, 0x59) can be replaced with their
> > >     enumerators.
> > >     - Bug fix to return Add/Release Extent Selection Policy bitmasks
> > >       correctly
> > > 1.2. Changes Related to 0x5601 - FMAPI Get Host Region Config
> > >     - Prepatory patch to add dsmas_flags to CXLDCRegion struct was modified to
> > >     store the booleans dsmas_flags is made up of instead of copying it from the
> > >     CDAT for that region. Values hardcoded for unsupported flags.
> > >     - Build the returned dsmas_flags from the new booleans.
> > > 1.3. Changes Related to 0x5602 - FMAPI Set DC Region Config
> > >     - Added locking for CXLDCRegion bitmap for the case that extents are being
> > >     added/released via a different CCI than that of the FM-enabled CCI.
> > >     - Prepatory patch created for the above (quite short, can be squashed if
> > >     preferred)
> > >     - Added a check to verify that the requested block_size is supported by the
> > >     region by looking at region->supported_blk_sizes_bitmask
> > >     - Instead of event_record validity flag being cleared, set to 1
> > >     - Fixed bug of forgetting to update region->block_size
> > > 1.4. Changes Related to 0x5603 - FMAPI Get DC Region Extents
> > >     - Minor refactoring of loop filling in response payload extents
> > > 
> > > 2. Feedback from Fan Ni and Jonathan Cameron on v1
> > > 2.1. Changes Related to 0x5604 - FMAPI Initiate DC Add
> > >     - Remove redundant storage of extents in event_rec_exts
> > >     - Refactor event record creation into helper function for re-use by release
> > >     - Return event_record.available_extents
> > >     (total_extents_available - num_pending - num_accepted) instead of
> > >     leaving it blank
> > > 2.2. Changes Related to 0x5605 - FMAPI Initiate DC Release
> > >     - Remove redundant storage of extents in event_rec_exts/redundant 2nd loop
> > >     - Add #define for removal_policy_bitmask instead of hardcoding 0x7
> > > 
> > > Anisa Su (10):
> > >   cxl-mailbox-utils: Move opcodes enum to new header file
> > >   cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
> > >   cxl/type3: Add dsmas_flags to CXLDCRegion struct
> > >   cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
> > >   cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
> > >     DC event types
> > >   hw/cxl_type3: Add DC Region bitmap lock
> > >   cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
> > >   cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
> > >   cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
> > >   cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
> > > 
> > >  hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
> > >  hw/cxl/i2c_mctp_cxl.c        |   6 +-
> > >  hw/mem/cxl_type3.c           |  41 ++-
> > >  include/hw/cxl/cxl_device.h  |  24 ++
> > >  include/hw/cxl/cxl_events.h  |  15 +
> > >  include/hw/cxl/cxl_mailbox.h |   6 +
> > >  include/hw/cxl/cxl_opcodes.h |  72 ++++
> > >  7 files changed, 724 insertions(+), 89 deletions(-)
> > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > >   
> > 
> > 
> 
