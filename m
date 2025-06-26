Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FAE26B77F
	for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976891; cv=none; b=nc6E78ODfU3asEDJ3sq33ONbXiX7/xm08x36rcZJ5L3UgmmSesc8yb28PrvzmuW1yKGu1lTP9LMWXpMGzGHkJ/GoRqqCApcmuRCADbqdEP75npK891Fy3MbCCiRrIDJmv0eJAq2Om407KrItGX+KpNmb6/Ue60TRqUKElkJ1x9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976891; c=relaxed/simple;
	bh=B/8RGRMCn7w59RcoP96jzK2krxKvVyo2uo7T4RuZxx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1HYBnPyaETts+bMc1ZyqQ3VuoE5PfcUv3/1y/PiVPL/sH0vuLTi7Ne26OZSkEFYT6UcL7JHwee2bTq58WXn7u/UBOvjzd++73ixjjB/Xpv39kUZADWB7gfGBY+aapSDpXdcCkwZ0KUK+Idbz8fFvywc4Z0u8iLpdJzACpfYYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6osRHo9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6osRHo9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23636167afeso17561915ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jun 2025 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750976889; x=1751581689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBvEswFRBQqL5L/YGfeRisUGWo6c5sSXSxbxfcjgW8Q=;
        b=W6osRHo9nBOhoybiva0Mm3gp7fDAvsZdyjFTa9fNStua5/TgHDc4v+vy+dFOjs6vBP
         d8LHW0e/WXOyuylTGTrfRzD43FWwqcuXW3H4DWB6QhworswGZYFIfOKhZv/7pzMf3QLP
         zx/EO+k0s/zuvegii+3eQZkeW4w7KpajrAn+O5hXEaZVqWUBULFRp2u2QtDZ5Gmh0D2E
         EN5ttnj2lsdtKAtMUsTn3spQYtnFX1CkEI1yW4bGIX6ymi3CHyeo0TobHficjouX/hsq
         LpoFBpgz9HaTUDW0aEB8Bhh1SXf72mQeU9znryoZ2vpuUyVorqmcNdp/i2/CfCX5WHge
         kFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750976889; x=1751581689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBvEswFRBQqL5L/YGfeRisUGWo6c5sSXSxbxfcjgW8Q=;
        b=X/VosE5JiDCLqJGugIVqjGwCjbCFzW4SO1DyPGOKyAAc95Vy9QiUODvofxtYvGxJKf
         GR3CJEQpzasT1y9NY7LRHcLW5g3WpgqWGyHUdUxrzH1KiMJtGIWh6ryKwIWmYJYPhf0A
         26aHShFHxNv4ZaEwALM1r/pWpWnNyoUp22oH+jso/8PjRIzq9KJippm83G6/j97VfUfx
         ITNr73W+tkDR3/3dejgD+u741iVmEdKOOeJXEUfFwbhidT+fcqXjgzXjsRt6C9VUFTIc
         jd0lImho2MUh+qvxYv2EwE5Ai9uHjrspiBofGyL58luuxk8Uoy1f34UWj7If868QqZYU
         YJOg==
X-Forwarded-Encrypted: i=1; AJvYcCW/XmbbS1FdhgJa7FVaFP6SdhReQG90zlmmTFS7mQgKEv/7N0VeHoiMUN6kmx9c7em3kRNikfNTHGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCc88T3la0nXxXJ0iybXJk2tFu2Q/VL569rKUkLk1WH3QlpM2k
	UbumYlnkZ18pwHPysYNKZcCgXnOvCdT7lgHNMzBybMvvmNAW9tTgk8tI
X-Gm-Gg: ASbGncswepn/iwfqIseYTaWptYl6EcslX7aKcRheNVcZhsn22FGYQz1fOyBGnSXJqn0
	E/fYWjK/LrEKb1FYuzcDjuEZnti+St2zFP4+X2GGwB/sF6hfW4fZqAjxC0eGUCEVrRnOSHAcBsP
	YuYGZyOP4OHN7OB3T0pEkJiodf2ZoxA+9btp6OLXE6vw7uhm2l6EBas0kK8A9CyoMjceTaXMlms
	sSN5udGR8cNDXVX6pGGVfT/yeVUQpOhrH8XfiKdSyGnRk8xg3Jm9PyPXGt/HmCBdDKZJDA4q1Ji
	leykWhqQnjjaQBUiIjNJsx5ZYSdKTbTAE9QgtSF5AwKvEetC9CCjmRB6WH48GgG0F0KvJw2sO32
	jayIkxis=
X-Google-Smtp-Source: AGHT+IF1iODfHE8fzSjYQHYGuvuHvcDNhOO3OqdyuwV7o34VK7Drc2bBOMI0nsIntVIGfCzv0pMHDg==
X-Received: by 2002:a17:902:f90c:b0:234:f182:a735 with SMTP id d9443c01a7336-23ac45e24a2mr9349075ad.34.1750976889205;
        Thu, 26 Jun 2025 15:28:09 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 15:28:08 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	alok.a.tiwari@oracle.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v4 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Date: Thu, 26 Jun 2025 22:23:23 +0000
Message-ID: <20250626222743.1766404-1-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anisa Su <anisa.su@samsung.com>

This patchset adds support for 6 FM API DCD Management commands (0x5600-0x5605)
according to the CXL r3.2 Spec.

The code was tested with libcxlmi, which runs in the QEMU VM and sends 56xxh
commands to the device (QEMU-emulated) through MCTP messages over USB.

Test Configuration:
 - Kernel:
To perform end-to-end tests, both MCTP and DCD support are needed for the kernel.
The kernel version used is Ira's latest DCD branch which is based on 6.15-rc2,
which includes the upstreamed support for MCTP over USB:
https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-04-13

- QEMU:
To enable MCTP over USB in QEMU, Jonathan's RFC patches are applied on ToT master branch
(https://lore.kernel.org/linux-cxl/20250609163334.922346-1-Jonathan.Cameron@huawei.com/T/#m21b9e0dfc689cb1890bb4d961710c23379e04902)

For the tests of commands 0x5600 (Get DCD Info), 0x5601 (Get Host DC Region
Config), and 0x5603 (Get DC Region Extent Lists), DCD kernel code is not involved.
The libcxlmi test program is used to send the command to the device and results
are collected and verified.

For command 0x5602 (Set DC Region Config): device creates an event record with type
DC_EVENT_REGION_CONFIG_UPDATED and triggers an interrupt to the host
if the configuration changes as a result of the command. Currently, the kernel
version used to test this only supports Add/Release type events. Thus, this
request essentially gets ignored but did not cause problems besides the host
not knowing about the configuration change when tested.

For the command 0x5604 (Initiate DC Add) and 0x5605 (Initiate DC Release), the
tests involve libcxlmi test program (acting as the FM), kernel DCD
code (host) and QEMU device. The test workflow follows that in CXL r3.2 section
7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
steps:
1. Start a VM with CXL topology:

 '-device usb-ehci,id=ehci \
     -object memory-backend-file,id=cxl-mem1,mem-path=/tmp/t3_cxl1.raw,size=4G \
     -object memory-backend-file,id=cxl-lsa1,mem-path=/tmp/t3_lsa1.raw,size=1M \
     -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1,hdm_for_passthrough=true \
     -device cxl-rp,port=0,bus=cxl.1,id=cxl_rp_port0,chassis=0,slot=2 \
     -device cxl-upstream,port=2,sn=1234,bus=cxl_rp_port0,id=us0,addr=0.0,multifunction=on, \
     -device cxl-switch-mailbox-cci,bus=cxl_rp_port0,addr=0.1,target=us0 \
     -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
     -device cxl-type3,bus=swport0,volatile-dc-memdev=cxl-mem1,id=cxl-dcd0,lsa=cxl-lsa1,num-dc-regions=2,sn=99 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb0,target=us0 \
     -device usb-cxl-mctp,bus=ehci.0,id=usb1,target=cxl-dcd0\
     -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k'

2. Load the CXL related drivers in the VM & configure MCTP endpoints:

3. Create a DC region for the DCD device attached:

cxl create-region -m mem0 -d decoder0.0 -s 1G -t dynamic_ram_a

4. Add/release DC extents by sending 0x5604 and 0x5605 respectively through
the following libcxlmi test program:

https://github.com/computexpresslink/libcxlmi/blob/main/examples/fmapi-mctp.c

5. Check and verify the extents by retrieving the extents list through
command 0x5603 in the test program.

6. Create a DAX Device from the extents added:

daxctl create-device -r region0
daxctl reconfigure-device dax0.1 -m system-ram

The remaining 3 commands in this series (0x5606-0x5608) are related to tags
and sharing, thus have not been implemented.

v1: https://lore.kernel.org/linux-cxl/20250317164204.2299371-1-anisa.su887@gmail.com/
v2: https://lore.kernel.org/linux-cxl/aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in/T/#t
v3: https://lore.kernel.org/linux-cxl/20250605234227.970187-1-anisa.su887@gmail.com/

v3 -> v4 Changes
================================================================================
1. Rebased on upstream ToT and retested with MCTP-over-UCB

2. cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
 - Move condition to return success if new block size == current block size
 after bitmap checks because list of what should fail with unsupported doesn't
 allow an exception for a noop request according to the spec
 - Picked up Fan's review tag

3. hw/cxl: create helper function to create DC Event Records from extents
Based on Fan's feedback on the FM Add/Release patches from v3, reuse code from
qmp_cxl_process_dynamic_capacity_prescriptive() to use in both qmp interface
and mailbox commands.

Created helper function to create DC event recs and insert into log from
qmp_cxl_process_dynamic_capacity_prescriptive().

4. cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
- Fix local tmp array (CXLUpdateDCExtentListInPl *list) to be declared with
 g_autofree/g_malloc0
- Use helper method from refactored QMP code to create/insert DC Event Records
 remove previously defined helper method cxl_mbox_create_dc_event_records_for_extents
- Remove previously defined helper method cxl_mbox_dc_add_to_pending() because
 it is not used by any other methods.
- Removed unreachable return statement after default case in switch statement

5. cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
- Fix local tmp array (CXLUpdateDCExtentListInPl *list) to be declared with
 g_autofree/g_malloc0
- Use helper method from refactored QMP code to create/insert DC Event Records
- Fix CXL_EXTENT_REMOVAL_POLICY_MASK definition to be 0x0f instead of 0x7.
The removal policy should be bits[3:0] per the spec. 0x7 only covers bits[2:0]
- Add missed check for if extent in the list covers a pending extent if Forced
Removal Flag is not set
- Removed unreachable return statement after default case in switch statement

Status:
First 6 patches have Fan's review tag
(cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info ^.. cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists)
Last 3 still need review tag.


Anisa Su (10):
  cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
  cxl/type3: Add dsmas_flags to CXLDCRegion struct
  cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
  cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
    DC event types
  hw/cxl_type3: Add DC Region bitmap lock
  cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
  cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
  hw/cxl: create helper function to create DC Event Records from extents
  cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
  cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release

 hw/cxl/cxl-events.c          |  38 +++
 hw/cxl/cxl-mailbox-utils.c   | 494 ++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c           |  82 ++----
 include/hw/cxl/cxl.h         |   1 +
 include/hw/cxl/cxl_device.h  |  28 ++
 include/hw/cxl/cxl_events.h  |  15 ++
 include/hw/cxl/cxl_mailbox.h |   6 +
 7 files changed, 604 insertions(+), 60 deletions(-)

--
2.47.2

