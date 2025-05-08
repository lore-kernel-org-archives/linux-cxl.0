Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C728A4431
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663509; cv=none; b=DMK7AT4yBRkHtLD5Ubq/710wqRq2uuupldgbkZMqxuQfUFNKUqtWpV6OSZbdEpc0KOX6m4gxUq9R67IHoM5meghoxGKmIAs+1jG49H+BNfoiBwgwzf1xvxj3UWV2v30MDQyQsOPGFCybzbAj7zobL1N+iFUeU3anSv0Lns3/qwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663509; c=relaxed/simple;
	bh=36a7SAsor3jpzg8fsvPB14r3WAP8lrri8LwMOerCnQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hR7oUFbt2dxcCqzeLrrzUCmDoWKE1waAlXS0XK1Epw7Q37WYQgfQSSZIJBSDyyb9N7GM2avKWDUzvJjxXtwjknBr0zoZJErV8H/2xbM/J1SqVOvlMxNoctzc1Wdqdz/IfpDR7ZalvNE8l49XVC+KIIhVtlAfYvt7H/6Oe1kNxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5Z7Z90+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Z7Z90+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7376e311086so648170b3a.3
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746663507; x=1747268307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1DUUdafSg3gAWNrrjVpbMbgAbVF/N0VART/pBT07PSM=;
        b=P5Z7Z90+GTjeCE6OZD7vf/5YPN/P9erremsPFTc5xXE4flned0yAlUKW70HZ97CW8c
         bnDhZgzcXUa4/VwczvM9wlc61yLOky6kfiWI/0epZOotSBNUcpnd2FzEkMREYeg9Piuf
         t+J+aHpLIe33ufD9O3rIaSbjIb/6UxHWUn6TZbNp1R49IKcVUMaUzZToXSPAIW/oyYpY
         S7bQKi4qrz1ymSSZrGO3dfEmXEfcFmxNjNfr9vyWHpBKkhrwjpS5hMo7SfPaGl4dX/7U
         qR2juMV+x4uFG9pLPLzJfQDDRfeT8MY5e3VLnYpFd86LkQs9Jcx5asPWMWVgLqRVLjmO
         gIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663507; x=1747268307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1DUUdafSg3gAWNrrjVpbMbgAbVF/N0VART/pBT07PSM=;
        b=mybyMGI6jrZsGy/TUJhim3YPqMyCNTlMYR4byiQBdGaHdjhTSGWJZoFdBA8i/A7K8+
         d9L1Be4Hc9sR62bocuMEiSUBaFJAKMLKg1VvE2YkBvJZycHE4QMPuat2d7EHRCL9/VVB
         reX99N36IhdkVPdMIhETrYMAaGictRTvw0DQtefIb8L/Bz1LsFu5ClPvauN+DEXKpYEd
         H0cw9seg/LhNmmwBsp4fxnileLuditJpZatEKcOBhE5/ZRYGrgjzoBlLdZy0pRLtsBYj
         lIVyyr6V9sg2g3vRGO5bCQnLyHp5pPLr1ekS3N98+aRuTsrdR3YwVG31zRL2dey7HdEG
         i/zA==
X-Forwarded-Encrypted: i=1; AJvYcCV0zaUTgd/IzQALhmeC+BXr/pEJT4aaTPF8K9WQdX0+ceiH3q1d0EL87ka56xpw+Qpd6lzP9rNtvYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4j/pCyzeVBq56pOB/Y99wDVtxIWT0Qy8jBbmppr6loRz/LcW
	NnY9VUV72KgHPtLT58BBH5q/vISol7LUXV665PX32hGqo/p8hc9u
X-Gm-Gg: ASbGncvMGrUd+pCVe7Bzbf69V3pNThTN0Mv7FlR6vyD07dSXA0G5zh7KDp04prFnkYa
	jUOsraLp303U0LnUCLpt4QIP8tF79kqlQTHAYXkR/gPrBXqXQUlIY/mPc79BhnxEzQQBEfCmPgK
	zJd/tHpElmzjdeLh3R+IGOCVEhxcvgA3wGh0YMTvGHp2nvQXm6Sdy+tTSgC620ilyuisnIcc4Pu
	OmoIOFAzbhsL+BHnwgvb6EuX+QFz1F+6aU8kvWy8MXpYC0h4sQfqq69lDtz2t8GUP0EU/RkruSo
	I5jPJYelw9WU2Yl4B6c5/4UtcWj9xxTuHyGSEiYH2IpZaGIMRQlFFe9rrwhWmA==
X-Google-Smtp-Source: AGHT+IEB0JXt6z8w2I6N2UYJl/ixcQnuaXs/9O6VqQ8Uf85PMo1g4X9kfpaFz6eYJTPAnFwaeV4U5Q==
X-Received: by 2002:a05:6a20:12d4:b0:204:4573:d854 with SMTP id adf61e73a8af0-2159af312d9mr1699263637.9.1746663506886;
        Wed, 07 May 2025 17:18:26 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 17:18:26 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Date: Thu,  8 May 2025 00:00:56 +0000
Message-ID: <20250508001754.122180-1-anisa.su887@gmail.com>
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
according to the CXL r3.2 Spec. It is based on the following branch:
https://gitlab.com/jic23/qemu/-/tree/cxl-2025-02-20.

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

Changes
================================================================================
v1 -> v2:
1. Feedback from Jonathan Cameron on v1
Addressed general style concerns (newlines/spacing, minor refactoring, etc.)
1.1. Changes Related to 0x5600 - FMAPI Get DCD Info
    - Squashed prepatory patch adding supported_blk_sizes_bitmask
    - Added new prepatory patch moving opcodes enum from cxl-mailbox-utils.c to
    new header file opcodes.h
    Needed for the check in i2c_mctp_cxl.c to ensure the FMAPI Commands
    (0x51 - 0x59) are bound with MCTP_MT_CXL_FMAPI. By moving the enum,
    the hardcoded values (0x51, 0x59) can be replaced with their
    enumerators.
    - Bug fix to return Add/Release Extent Selection Policy bitmasks
      correctly
1.2. Changes Related to 0x5601 - FMAPI Get Host Region Config
    - Prepatory patch to add dsmas_flags to CXLDCRegion struct was modified to
    store the booleans dsmas_flags is made up of instead of copying it from the
    CDAT for that region. Values hardcoded for unsupported flags.
    - Build the returned dsmas_flags from the new booleans.
1.3. Changes Related to 0x5602 - FMAPI Set DC Region Config
    - Added locking for CXLDCRegion bitmap for the case that extents are being
    added/released via a different CCI than that of the FM-enabled CCI.
    - Prepatory patch created for the above (quite short, can be squashed if
    preferred)
    - Added a check to verify that the requested block_size is supported by the
    region by looking at region->supported_blk_sizes_bitmask
    - Instead of event_record validity flag being cleared, set to 1
    - Fixed bug of forgetting to update region->block_size
1.4. Changes Related to 0x5603 - FMAPI Get DC Region Extents
    - Minor refactoring of loop filling in response payload extents

2. Feedback from Fan Ni and Jonathan Cameron on v1
2.1. Changes Related to 0x5604 - FMAPI Initiate DC Add
    - Remove redundant storage of extents in event_rec_exts
    - Refactor event record creation into helper function for re-use by release
    - Return event_record.available_extents
    (total_extents_available - num_pending - num_accepted) instead of
    leaving it blank
2.2. Changes Related to 0x5605 - FMAPI Initiate DC Release
    - Remove redundant storage of extents in event_rec_exts/redundant 2nd loop
    - Add #define for removal_policy_bitmask instead of hardcoding 0x7

Anisa Su (10):
  cxl-mailbox-utils: Move opcodes enum to new header file
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

 hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
 hw/cxl/i2c_mctp_cxl.c        |   6 +-
 hw/mem/cxl_type3.c           |  41 ++-
 include/hw/cxl/cxl_device.h  |  24 ++
 include/hw/cxl/cxl_events.h  |  15 +
 include/hw/cxl/cxl_mailbox.h |   6 +
 include/hw/cxl/cxl_opcodes.h |  72 ++++
 7 files changed, 724 insertions(+), 89 deletions(-)
 create mode 100644 include/hw/cxl/cxl_opcodes.h

-- 
2.47.2

