Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D21AF0A4
	for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229806; cv=none; b=Ffi0qLCEUCxnoSOPdovz2nWEPVe7j27v6kUSCeqlD0kuEYponktPT3RMjhOSrqV71L3LFko6NQrrjaroGxzECrSSYzWsPdnqMDFhZCKEK3eFApVaVhXGmMZ+B+3RLwoEqEuq7TAGwb0c2gs0YIERZZ3KXJojoiEdUJ0dEDWe5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229806; c=relaxed/simple;
	bh=yG5pcePs1Hv96fgpM+zJefjAd+fkOPeolfRYYG/yRwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZUyhzpm92T2bvLQhXethCH48RTHMjEX9DHsMnkTcNeLKnAvRsSaG3DbgJv/u34xjU6tCTUbq8u/08qTWODB+Saat0xdbAJQeAUk/fawdYiY/wwlLVmFuC0TxUt9Sgl6LkjMO2umQBKrtTZrf9XxaiBrlkENXZQgfjZj1WBIKAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp8ZJVG5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp8ZJVG5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-226185948ffso22897925ad.0
        for <linux-cxl@vger.kernel.org>; Mon, 17 Mar 2025 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742229804; x=1742834604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKWGb0xW/VNXy4e+PoryomDkITqKcXXBo5BJIUKrMV8=;
        b=Hp8ZJVG5uYJARDLX7bTE9YLihQvJt6yA+6A01tUGYEEg3iloenLGZi3hMhzdX7mcAe
         vhCvckh46B8G6bRPm89TPoTsiKrwAfrzzoUCavqp/VqXxwOlhKWJKUrG7qQ3T53PtC5f
         X5HaaWYK4A512PA9Ux5mjzrw5cjTJj2NfklzPkCwEdKM2KBd3ejubDdPBrq4olh3mMBw
         wkz29pJVsYrBFBo5z4vT/EppPsoS0KLhiK79LB4R1I+QFGBLjKYOkXOGBOxTD7qStKG/
         BECf1y+SRGFfG0178OOAluPP1iWSPY6tFfHu9JLE7GqHjg02nQtM4i9gp58e4dKYaTf5
         BFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742229804; x=1742834604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKWGb0xW/VNXy4e+PoryomDkITqKcXXBo5BJIUKrMV8=;
        b=bWrppQl+3EZLEnvaFBXlhL/vSfDIZvfGf0/N2MujecvX/yB/nt5zGIs5bDWFeg1eMr
         eWmcAdFXSovh/0LixXyIt5C3P66yFtXd7JnItuSlFfzZjMVhZZivfONwObSmfOO+guMi
         aUmKjVLZGLm0FxzeEFtw+h6JX0I3/rob026VUB4Zf1lrGqm1RknBvV1KTxC7ZNBm9tZi
         4cd/SOQI/CZEPgj6gJHQlRV3foRm7a0j0OI2mpoUOzhIxrROfplZ2hFxseyRCXqcPffX
         52MeNjPm0ZLBsfwOOdUovD0L9di3hmWJX7ERPKpdNQ4zS2TzVGu9PS8zya7QePUaMGQD
         h9ig==
X-Forwarded-Encrypted: i=1; AJvYcCVLKlGacyHbPMQTa4ZjlEyo1IxYh65C2fMwtszpDxzJGvLrsQW318pF/FeXlTSjSPjcU1ju+FFQSgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQypjqGG8OVlIggCP4D1jLDxu9o52685BEG+i00O7KM08XNcE
	ZGCVqATrAVAGJfA1igyBMcO+YsLP/WBncwHvlCAwtZ7cBQxbjaCi
X-Gm-Gg: ASbGncsZKCyScJQwfDKvVbXfjyXSap4OqobaBIx7xJyEYRrYGibm2BQma9/Y/5SJEpt
	mbX6zDFTFBmyDwgd038O6PZXk02QMfqw9161baM8dfOzuROJ9WUEQPbWX3qGJDbrIOJPbSa6iKL
	GRnZhmVJY15X6/xGkvZuscR0z3qa0kssd8I13FDLmC9LTzC8ZJ2WGqXfrnv3VoJoUYdXS8LD9wi
	2Q04A/tZNg/99QbDCBjlVRWMfNw8Bt8lji5lpqy3OIun8n6jlepQ23CgWPkgchwbMcdUA9w7BRt
	DXtDrCIZThZn3m/Jm6JQRZShC7AL94+mTEy7b7U/9gN/mqo/KK4v3oC2XaWPc+Sc6EnefudZr9x
	+
X-Google-Smtp-Source: AGHT+IH9p6E0f1a89GLwu2C7cg2ESZb+bq8ju/C/Z66+M78p2Lkv4/2MGDvYhXh2yH5uQ4mdRDnvlQ==
X-Received: by 2002:a17:902:da8a:b0:223:62f5:fd44 with SMTP id d9443c01a7336-2262c5f0c94mr2111025ad.40.1742229804444;
        Mon, 17 Mar 2025 09:43:24 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:43:24 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 0/9] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Date: Mon, 17 Mar 2025 16:31:27 +0000
Message-ID: <20250317164204.2299371-1-anisa.su887@gmail.com>
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

Anisa Su (9):
  cxl/type3: Add supported block sizes bitmask to CXLDCRegion struct
  cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
  cxl/type3: Add dsmas_flags to CXLDCRegion struct
  cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
  cxl_events.h: move definition for dynamic_capacity_uuid and enum for
    DC event types
  cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
  cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
  cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
  cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release

 hw/cxl/cxl-mailbox-utils.c   | 615 +++++++++++++++++++++++++++++++++++
 hw/cxl/i2c_mctp_cxl.c        |   6 +-
 hw/mem/cxl_type3.c           |  30 +-
 include/hw/cxl/cxl_device.h  |   9 +
 include/hw/cxl/cxl_events.h  |  15 +
 include/hw/cxl/cxl_mailbox.h |   6 +
 6 files changed, 660 insertions(+), 21 deletions(-)

-- 
2.47.2

