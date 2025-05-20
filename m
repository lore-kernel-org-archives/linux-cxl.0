Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A724290C
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748397; cv=none; b=lLJUjQ6mfsSjojE8jsyyMmO05k1yhq6oC/SLwCeLYU1hSmvXTRYwea3oJ/yyEupB3JnApYSmziDQ6DgCnj4ib2ob1oVkCZhWP3QfOEl1HxAJq/I6EMYIOWQ742uI17YzVV28K0DCNDiiGFlQgnyY9zg5Q/i//5b5eJjoXIs0ZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748397; c=relaxed/simple;
	bh=XXL1GfmyiPCudHHHdEpyDsjLfOqtHi6+XjLoO0sxQaM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUtxuoolZEnnO6/Xv71gEpd+4ntxgFcbL6IzMjDH57fJJlO4Tc11H+02IdvLpILhEFPLJNz6qs4O2JHqHGEEYer6qHdlIosmuTCnv1Kr3tPoT72d+Ic5e17QYrigK+VkYapFsSsxL3TFGLiH4fX28FoQWk9EE2lr4ldhxhbIZps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1wZK5chjz6L5BG;
	Tue, 20 May 2025 21:36:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 15792140114;
	Tue, 20 May 2025 21:39:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 15:39:49 +0200
Date: Tue, 20 May 2025 14:39:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands
 0x5600-0x5605
Message-ID: <20250520143947.00000337@huawei.com>
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  8 May 2025 00:00:56 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> This patchset adds support for 6 FM API DCD Management commands (0x5600-0x5605)
> according to the CXL r3.2 Spec. It is based on the following branch:
> https://gitlab.com/jic23/qemu/-/tree/cxl-2025-02-20.

Nice work - this is very clean and well presented.

I would like Fan to take a look an provide some tags as DCD modeling in
QEMU is more in his area of expertise than mine!

I think this series is much more ready for upstream than much of
my staging cxl tree so I'll rebase it to go near the front.

Today I'm focused on getting test cases to Richard for the TCG issues but
after that I'll spin a new tree (probably pushed out under a name
that makes it clear there is a known nasty problem though!)

Jonathan


> 
> The code was tested with libcxlmi, which runs in the QEMU VM and sends 56xxh
> commands to the device (QEMU emulated) through MCTP messages over I2C
> bus. To perform end-to-end tests, both MCTP and DCD support are needed
> for the kernel, so the needed MCTP patches are applied on top of Ira's DCD
> branch https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.
> 
> For the tests of commands 0x5600 (Get DCD Info), 0x5601 (Get Host DC Region
> Config), and 0x5603 (Get DC Region Extent Lists), DCD kernel code is not involved.
> The libcxlmi test program is used to send the command to the device and results
> are collected and verified.
> 
> For command 0x5602 (Set DC Region Config): device creates an event record with type
> DC_EVENT_REGION_CONFIG_UPDATED and triggers an interrupt to the host
> if the configuration changes as a result of the command. Currently, the kernel
> version used to test this only supports Add/Release type events. Thus, this
> request essentially gets ignored but did not cause problems besides the host
> not knowing about the configuration change when tested.
> 
> For the command 0x5604 (Initiate DC Add) and 0x5605 (Initiate DC Release), the
> tests involve libcxlmi test program (acting as the FM), kernel DCD
> code (host) and QEMU device. The test workflow follows that in cxl r3.2 section
> 7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
> steps,
> 1. Start a VM with CXL topology: https://github.com/moking/cxl-test-tool/blob/main/utils/cxl.py#L54.
> 2. Load the CXL related drivers in the VM;
> 3. Create a DC region for the DCD device attached.
> 4. add/release DC extents by sending 0x5604 and 0x5605 respectively through
> the out-of-tree libcxlmi test program
> (https://github.com/anisa-su993/libcxlmi/blob/dcd_management_cmds/tests/test-fmapi.c).
> 5. Check and verify the extents by retrieving the extents list through
> command 0x5603 in the test program.
> 
> The remaining 3 commands in this series (0x5606-0x5608) are related to tags
> and sharing, thus have not been implemented.
> 
> Changes
> ================================================================================
> v1 -> v2:
> 1. Feedback from Jonathan Cameron on v1
> Addressed general style concerns (newlines/spacing, minor refactoring, etc.)
> 1.1. Changes Related to 0x5600 - FMAPI Get DCD Info
>     - Squashed prepatory patch adding supported_blk_sizes_bitmask
>     - Added new prepatory patch moving opcodes enum from cxl-mailbox-utils.c to
>     new header file opcodes.h
>     Needed for the check in i2c_mctp_cxl.c to ensure the FMAPI Commands
>     (0x51 - 0x59) are bound with MCTP_MT_CXL_FMAPI. By moving the enum,
>     the hardcoded values (0x51, 0x59) can be replaced with their
>     enumerators.
>     - Bug fix to return Add/Release Extent Selection Policy bitmasks
>       correctly
> 1.2. Changes Related to 0x5601 - FMAPI Get Host Region Config
>     - Prepatory patch to add dsmas_flags to CXLDCRegion struct was modified to
>     store the booleans dsmas_flags is made up of instead of copying it from the
>     CDAT for that region. Values hardcoded for unsupported flags.
>     - Build the returned dsmas_flags from the new booleans.
> 1.3. Changes Related to 0x5602 - FMAPI Set DC Region Config
>     - Added locking for CXLDCRegion bitmap for the case that extents are being
>     added/released via a different CCI than that of the FM-enabled CCI.
>     - Prepatory patch created for the above (quite short, can be squashed if
>     preferred)
>     - Added a check to verify that the requested block_size is supported by the
>     region by looking at region->supported_blk_sizes_bitmask
>     - Instead of event_record validity flag being cleared, set to 1
>     - Fixed bug of forgetting to update region->block_size
> 1.4. Changes Related to 0x5603 - FMAPI Get DC Region Extents
>     - Minor refactoring of loop filling in response payload extents
> 
> 2. Feedback from Fan Ni and Jonathan Cameron on v1
> 2.1. Changes Related to 0x5604 - FMAPI Initiate DC Add
>     - Remove redundant storage of extents in event_rec_exts
>     - Refactor event record creation into helper function for re-use by release
>     - Return event_record.available_extents
>     (total_extents_available - num_pending - num_accepted) instead of
>     leaving it blank
> 2.2. Changes Related to 0x5605 - FMAPI Initiate DC Release
>     - Remove redundant storage of extents in event_rec_exts/redundant 2nd loop
>     - Add #define for removal_policy_bitmask instead of hardcoding 0x7
> 
> Anisa Su (10):
>   cxl-mailbox-utils: Move opcodes enum to new header file
>   cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
>   cxl/type3: Add dsmas_flags to CXLDCRegion struct
>   cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
>   cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
>     DC event types
>   hw/cxl_type3: Add DC Region bitmap lock
>   cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
>   cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
>   cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
>   cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
> 
>  hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
>  hw/cxl/i2c_mctp_cxl.c        |   6 +-
>  hw/mem/cxl_type3.c           |  41 ++-
>  include/hw/cxl/cxl_device.h  |  24 ++
>  include/hw/cxl/cxl_events.h  |  15 +
>  include/hw/cxl/cxl_mailbox.h |   6 +
>  include/hw/cxl/cxl_opcodes.h |  72 ++++
>  7 files changed, 724 insertions(+), 89 deletions(-)
>  create mode 100644 include/hw/cxl/cxl_opcodes.h
> 

