Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0A3DEFF1
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389582; cv=none; b=oeTJ+Xw0Q/2LIvoi6oEYMagrOKVBlY/xrNzFhhaHFAszVfHQLQh6Ubj/QR7MCSYf8uXqnwzZ0KbadVFvxVm4It8lmUEw5sAytqeoUev2g2yDgCRYYyol6kzf+VgmJcDTLTICh/wnmkreuk2EGhA/9X/LFUTOubr1xBnUb49a6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389582; c=relaxed/simple;
	bh=GnLbtMxfmAlSeQBKElN8xkJ5rhy4OyDZugragq9IdKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCkdNpaacPqOJi1evn3kjL08QrSXUMRHRiHPXIl9C0fvlJNqqed47n0L09L7NTgh3aqwrnsSXMNFCmA0qmbuNRWSQuLelyhvdNzlHSj1AAuPT0C3E8+3qxRMoO9rqeWWiw844MF+WFtsScoDzEo1eBh/8gmtsjffhsbZMrJFU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj0MErXO; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj0MErXO"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-139b914bab6so2445850c88.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389580; x=1782994380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UOsxoE2qJ+aGb1vIUj9jY9mH6HRMsMtjuvpt/oQ8KKI=;
        b=Lj0MErXOkUd/IMcVox2Q4LVzUPI9gPk1E2aXWQiJXtgmDXYsXxzjsTkJu7Pxt1oGzI
         wzAxFX3tD5ZZnUpyodQ+leiLL/yZXk84cCEUBuxK+JVjazb84KxkaE5k5GU4Zpyp2zp6
         dpvkqHiJgBEUGLNeeZDHj1G5J9CYkV5o4T19GWkAgEBuW8pdzGDDU7TAP42xFQzCCPwD
         b25yzLzvnbM1oIx5Hjajl7A5Gy5dKXbiiR0gx80kJS8rVdZjiNEfjlOKYxFSH6zhF5vL
         5GUNSf2xKh4gR0duQcTJaYq6rYdABe5VmdRwtoQ6+AhLD0WzdeehwxNN5AJP4oIzN0+a
         fZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389580; x=1782994380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOsxoE2qJ+aGb1vIUj9jY9mH6HRMsMtjuvpt/oQ8KKI=;
        b=E0iWjW5pknBIa5r3yeXnnEMtyeQeR2FcmRohKKQAsDdYI5o4SahzBfZhPEB8wiANWl
         DwTikTbA7x//r818/rs9t9iYmUfFdBwOj5iZfaXb3RLvRDo35htJLfVXhvGBln6jJHJn
         uBKsOm56UAPvS8hAFFxCSA1qIXWR8mdsfCHe1QiPDssTLKt29Hd+DU7GhL9v6I+jPw/Z
         /XhqXnUOQKvYuz0mv6dyaf6lyiy/YHDYFbL/3MFoL6aZ2sAavOKNX4f3TbAg1pYZl8k7
         GuANZZvIiSwcH6Ku/BifjqPs1/+gTRIL8YrcxBOyLPmaI4kx8a6p3ERH50zzgUxxEe8P
         KJAQ==
X-Gm-Message-State: AOJu0YwsoHp6aCXk8npyvbIGlrEQiXsDWmDl5DIFuo6MI2zfgV1A0x9h
	wgv44121WgXw93qO7RaiF+M7PUyS5hmWB0LVgWOqxKzW4BsjWCN2a1uO7XjbLg==
X-Gm-Gg: AfdE7cm95u/fWVj64VATjRFdj0NjVDreoOtYtfTkcABs24JH+Gisd+wczSBGXNw/uKo
	KN1a7Rp4bdnSOs2ZVsGHNpDf094M9h1u4W8XTMg7WiL/fx0aiWya6UJU0FWAjzOPKKyN8j+XMx2
	06pF+yqe2UUo6YG1yuOlWbInuTqY5E2hFqurO4ayWh7wzg/sgThIdmb+J5ugUJclCqgdXTYsMHy
	U+gFrAR8fG4zt/OorS+VrHCHNttqdD3Yvt6fEF4ispHwq/KLxLkuAEKACq6RR9fUsZB7ERO+VnI
	9ZfCFF01WhgsHaevnF7HgZ+3xd1GF2mEOj8RX55+tkqCd6xVD8i6L1NNHCv7p4AJw0A0x2nSBTK
	H1BwCoQed+e49UWLu+9EHb97OQ29En/yy1RCaEhF/s3LglZ8xkzvQsaHuoCx8/Sw/bXnKqHbH55
	ZAScSbFyjwYyN3Q44GTxQOCpj0QarP871Htk3onJSaAZsfxa6jy4MB8brRDJ+QtXOL2C2k
X-Received: by 2002:a05:7022:91f:b0:137:64ad:a636 with SMTP id a92af1059eb24-139dbbaf052mr2178449c88.27.1782389579463;
        Thu, 25 Jun 2026 05:12:59 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f77602sm7422206c88.8.2026.06.25.05.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 05:12:58 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [NDCTL PATCH v7 0/5] Dynamic Capacity additions for cxl-cli
Date: Thu, 25 Jun 2026 05:09:34 -0700
Message-ID: <20260625121242.603807-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL Dynamic Capacity Device (DCD) support is currently being worked on
in the kernel.  cxl-cli requires modifications to interact with those
devices.

A new partition type 'dynamic_ram_1' has been added which cxl-cli needs
to know about.  Add support for the new decoder type.

With DCD, regions may or may not have capacity.  The capacity is
communicated via extents.  Add region extent query capabilities, and a
'daxctl create-device --uuid' option to claim those extents into a dax
device on a sparse region.

Add cxl-test support.  cxl-testing allows for quick regression testing
as well as helping to design the cxl-cli interfaces.

This series applies on top of cxl/pending (5fcbbee, "test/daxctl-famfs.sh:
Add nfit_test famfs mode-transition test").

Series Branch: https://github.com/anisa-su993/anisa-ndctl/tree/dcd-2026-06-24
Kernel Branch: https://github.com/anisa-su993/anisa-linux-kernel/tree/dcd-v11-06-23-26

Changes since v6
================

Structure / process
 - libcxl, cxl/region: squashed the Dynamic RAM 1 library support together
   with its cxl-cli user into a single patch, so the new API and its first
   caller are reviewable together (Dave Jiang).
 - Added the missing Signed-off-by lines, and picked up Dave Jiang's
   Reviewed-by on the Dynamic RAM 1 and cxl-test patches.
 - Rebased onto current cxl/pending

Library versioning
 - libcxl: the new exported symbols now live in a fresh version node
   (LIBCXL_13) instead of being appended to the already-released LIBCXL_9
   (Richard Cheng, Dave Jiang).
 - daxctl: daxctl_dev_set_uuid() moved to a new LIBDAXCTL_12 node (famfs
   support took LIBDAXCTL_11 on pending).

Bug fixes
 - libcxl: free the per-region extent list in free_region(); the extents
   allocated while scanning were previously leaked when the region was
   freed (Dave Jiang).
 - libcxl: removed the unused CXL_REGION_EXTENT_TAG define (Dave Jiang).
 - daxctl: daxctl_dev_set_uuid() now propagates the real error - a
   negative snprintf() return and the errno from sysfs_write_attr() /
   sysfs_read_attr() - instead of masking everything as -ENXIO, so e.g.
   the -ENOENT returned when a uuid matches no extent reaches the caller
   (Dave Jiang).
 - cxl/test: pass the (now required) tag argument to remove_extent() in
   test_event_reporting() (Dave Jiang).
 - probe-ordering race seen on v7.1-rc1+ (kernel commit 39aa1d4be12b) is
   fixed kernel-side by moving existing-extent processing into
   cxl_dax_region_probe().
 - The other failure reported in cxl-security.sh reported by Alison
   in the last version is an unrelated, pre-existing hex/decimal bug being
   fixed separately:
   https://lore.kernel.org/linux-cxl/ddc1d44c-37ef-473e-9f87-efe207d8bcbf@intel.com/T/#t

Output
 - cxl/region: the region-query extent listing emits "uuid" (matching the
   commit-log example), and is omitted entirely for non-DC RAM/PMEM
   regions rather than emitting an empty "extents": [] (Alison Schofield,
   Richard Cheng).

Signoffs
 - Update Ira's author/signoff to iweiny@kernel.org

base-commit: 5fcbbee57319e718bf522436ea6595bd0f71296c

Anisa Su (1):
  daxctl: Add --uuid option to create-device for sparse regions

Ira Weiny (4):
  libcxl, cxl/region: Add Dynamic RAM 1 partition mode support
  libcxl: Add extent functionality to DC regions
  cxl/region: Add extent output to region query
  cxl/test: Add Dynamic Capacity tests

 Documentation/cxl/cxl-list.txt                |   29 +
 Documentation/cxl/lib/libcxl.txt              |   33 +-
 Documentation/daxctl/daxctl-create-device.txt |   12 +
 cxl/filter.h                                  |    3 +
 cxl/json.c                                    |   70 +
 cxl/json.h                                    |    3 +
 cxl/lib/libcxl.c                              |  186 +++
 cxl/lib/libcxl.sym                            |   13 +
 cxl/lib/private.h                             |   13 +
 cxl/libcxl.h                                  |   21 +-
 cxl/list.c                                    |    3 +
 cxl/memdev.c                                  |    4 +-
 cxl/region.c                                  |   27 +-
 daxctl/device.c                               |   72 +-
 daxctl/lib/libdaxctl.c                        |   53 +
 daxctl/lib/libdaxctl.sym                      |    5 +
 daxctl/libdaxctl.h                            |    1 +
 test/cxl-dcd.sh                               | 1275 +++++++++++++++++
 test/meson.build                              |    2 +
 util/json.h                                   |    1 +
 20 files changed, 1799 insertions(+), 27 deletions(-)
 create mode 100644 test/cxl-dcd.sh

-- 
2.43.0

