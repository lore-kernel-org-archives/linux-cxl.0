Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF4C211484
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749166953; cv=none; b=qesFt1yW0DwWAlMi1nAtbZ/lgSbC6PUhvBURIWewvQybw4u7EBf3AGSnb7ml0nmRMDRL5Secx5q6sYSIcM22Ep9hJ1IWiWXJASbV6oSrnrtmUlq5mIWjqGOfvCdDRfHHe/rHMySM+WAlHttILnGw9GEw2Q/wJ8g2ORW1SNHlgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749166953; c=relaxed/simple;
	bh=YpRKAfp9GnpuXbfyBdyvyue+o2PbQ1i7W2nV+/lJg4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PpT2sKqtQEatHuKIXDZau8M7ldX4zltz0Rsj0r9WLROZC+/M6l+kz/tEP10r5ufE208FhRbOuf0XWdT5TS3cRZASB5fpCSpI7v6lWdnFbeA4ngAqHDkSqZnN9G38BXCo4ml/Oqh3OKmegg7rMlJXRPCmSszQOFIhrD0v30GMG8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISEXIs7h; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISEXIs7h"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c035f2afso1246674b3a.2
        for <linux-cxl@vger.kernel.org>; Thu, 05 Jun 2025 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749166951; x=1749771751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aS7/2pgQjaGIOkdRt5swxrbQrIIOnIX9dYGmTh+yU1s=;
        b=ISEXIs7hCYRMlEC7BfEexhRlwMivv7zPcfvlVRjGsKU78VjUsfsdSujRpTN7vDFxmN
         8Rac+17fzK8+zD8ab8Vs7gjodG6ctkBgIRYDcwxAwzwCtU+/TfF2r3ZoBkhajHmuFsNo
         AVgY23nlGrVnLWD1VRsXjoTSi3YmtJe7MbLslNwiZ+heVRcty0Md4D7p4sRebwQADuvF
         QDMIOsj9eNcgseOTm96nvdSYr451b8Z5ux+JrW0uAgpMOoXmAgEi4HhDksRUqqgL/Eec
         HqhpjE3juWjW01UV289Lf48QfLgNwffVvSPSICtFp9TXIp/WGyBVG4WylGLIY3BqBO2W
         zORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749166951; x=1749771751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aS7/2pgQjaGIOkdRt5swxrbQrIIOnIX9dYGmTh+yU1s=;
        b=quAYDw2R7hqqb2JqFJ6pI6JvuRAQzhHQuda5JEAVxWQGt6mrGq7v1sdcwhzxhdHlQM
         jv5wPzHbUnvPXkGNKDiIizLPTkNwyuy6TfB51M1RXmv/DQd9XZxAXqMFicXO+4JIihYo
         7ZdxAmDncAOgVVUv3kq78fALXmn1pYsNC5Vjf32zNKcA6qejfXHmgeKQInp1KMS29cpb
         T5kQsy42zICxQCmRJV73XTohEdcz5CWpjgHY/rtIXWnSiFQEe8zxvyLuNCRTfnAdoCD1
         vnxuDbYwQGKna1Te/KmKL7kwWuIqTxkL5iqpf1jJv1r/t6UWg7BVKWvegeXKsMUSUh8h
         duag==
X-Forwarded-Encrypted: i=1; AJvYcCX0HqKZhOMFGwQMwnF3WQRI8lHvL5jWnpOerEejv0yrARYK2WWbdcHtbN1/gCHXg8e59ntNzZ6KmsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM35aaTvIawq4MRmHSxQYEMxt1V9m68vPZ6gDVWis8e1Z8VWok
	y32sGr3KqbFcX+J+p90xiahgi9AshuTcb7+PHdq9GzgPLMtIvRqRCn+vk8BXjA==
X-Gm-Gg: ASbGncszPSqcIwRwQjbdF8IOWhzz+/pAzbRjiDDPQvUxW2dLL8Q0wgWZrjrM9xgN4yj
	bPvTSiBK705RV9uP7ke0V3jUbbQZAUQbUJkGyZGGFU0Jugoijny0ShbRclR5jPO42M/q1zsXeS7
	8/6PjEwvPpxSoPuV35qSe28By6cDd4AUSpymI81VSFXnHxza30wfge44ZKC10w1DZB2fqmi8w7s
	rHzU42R0SIqYrKk4OQAvSbaUyD92H5CIiTCvb7VfWcL91h1CWYNM5J7zW5/+i8HIUMyorwQoo7Y
	dDfimvDtlBsdiFNpNy25PqDIX9OC5pkYXfRfns1V67ynFZ1tOz68Ca+ISq8zYroiD6xwAPG1/uH
	QTrwc+co=
X-Google-Smtp-Source: AGHT+IHZ5xV0NBtOLkefRKfzjrVkVLrS4cyy5U4ejLxEHSBXWHnD8axXX9s1pLp01wCrkTiA5MD/uQ==
X-Received: by 2002:a05:6a00:1ad4:b0:742:aecc:c47c with SMTP id d2e1a72fcca58-74827fcd87cmr1950563b3a.7.1749166950952;
        Thu, 05 Jun 2025 16:42:30 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 16:42:30 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v3 0/9] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Date: Thu,  5 Jun 2025 23:42:14 +0000
Message-ID: <20250605234227.970187-1-anisa.su887@gmail.com>
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
commands to the device (QEMU emulated) through MCTP messages over I2C
bus. To perform end-to-end tests, both MCTP and DCD support are needed
for the kernel, so the needed MCTP patches are applied on top of Ira's DCD
branch https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.

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
code (host) and QEMU device. The test workflow follows that in cxl r3.2 section
7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
steps,
1. Start a VM with CXL topology: https://github.com/moking/cxl-test-tool/blob/main/utils/cxl.py#L54.
2. Load the CXL related drivers in the VM;
3. Create a DC region for the DCD device attached.
4. add/release DC extents by sending 0x5604 and 0x5605 respectively through
the out-of-tree libcxlmi test program
(https://github.com/anisa-su993/libcxlmi/blob/dcd_management_cmds/tests/test-fmapi.c).
5. Check and verify the extents by retrieving the extents list through
command 0x5603 in the test program.

The remaining 3 commands in this series (0x5606-0x5608) are related to tags
and sharing, thus have not been implemented.

v1: https://lore.kernel.org/linux-cxl/20250317164204.2299371-1-anisa.su887@gmail.com/
v2: https://lore.kernel.org/linux-cxl/aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in/T/#t

Changes v2 --> v3
================================================================================
1. Rebased on ToT master branch + applied Fan's patch fixing DC extent tracking
(https://lore.kernel.org/linux-cxl/20250529163925.2916725-1-nifan.cxl@gmail.com/)
2. Picked up Fan's review tag on several patches. Still need review tag for the
following:
- cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
- cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
- cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
3. Changes:
- 0x5602: Deleted redundant function cxl_mbox_dc_event_create_record_hdr() and
replaced calls to it with existing function cxl_assign_event_header(). This
is done in the below patches as well, which also add records to the event log.

- 0x5604: Deleted redundant function cxl_mbox_dc_prescriptive_sanity_check() and
replaced calls to it with existing function cxl_detect_malformed_extent_list(),
which was originally added by Fan for the DCD Add/Release Response
commands (0x4802 and 0x4803), which needs to check for similar errors.

Deleted helper functions to count # of pending/accepted extents because Fan's
fix for dc.total_extent_count to correctly track pending and accepted extents
means we don't need to add them up separately.

- 0x5605: Similar to above, uses cxl_detect_malformed_extent_list() and
additionally, reuses existing function cxl_dc_extent_release_dry_run() to
detect additional errors that can occur in the case of releasing extents, which are:
    - extent to release is not actually block backed
    - releasing extents would cause the device to exceed max. extents supported

Because these patches have been rebased on upstream QEMU which is missing I2C
MCTP support, I have retested them in a manner similar to what is described above
but hacked to add the FM commands to the general T3 mailbox (initialized by
the cxl_initialize_mailbox_t3() function). Then libcxlmi is used to send
the FMAPI commands via ioctl instead of MCTP and the output is verified.

Anisa Su (9):
  cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
  cxl/type3: Add dsmas_flags to CXLDCRegion struct
  cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
  cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
    DC event types
  hw/cxl_type3: Add DC Region bitmap lock
  cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
  cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
  cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
  cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release

 hw/cxl/cxl-mailbox-utils.c   | 538 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |  45 ++-
 include/hw/cxl/cxl_device.h  |  24 ++
 include/hw/cxl/cxl_events.h  |  15 +
 include/hw/cxl/cxl_mailbox.h |   6 +
 5 files changed, 605 insertions(+), 23 deletions(-)

--
2.47.2

