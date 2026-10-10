Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B6320A5C4
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673026; cv=none; b=dSGiHygPRs7QSwcU/e29kePJCDpNKhhCZNi/eUyL85BSrpMclCK64l2ubM9fL6mnriD08j1ZzzvbweYUl4q+iY8mi9WhWYkOq0pY3mNiINqQvRMqWq+ad01DhKvD5l4bOW/C6u8etfdiLLeWH7ur8Dq62OEzzLU7I/wdnzbsMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673026; c=relaxed/simple;
	bh=v9xElfPDtUKLBbAOUyC6WEp4xXa0Taz+orpIfsa4F2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoyHxQitsxxPLmaaCUMt6WTomwu7VIzy2jYmBeP3HWUtcpoJp0Fcx1VIvzTFnZyhm341qxfqMzuL6eAY+aZy9Csr2rgel0k3YGsmglgjYusEdYIG+2L+ZNEFdqktETewDcvDJaZz8lJ/LLKdxgD59rUgzdO6tbCPOjDkcHtLqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4hV3XB0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4hV3XB0"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-88bd2b44f3aso319413b3a.0
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 15:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791673023; x=1792277823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ch8jJvcOl0DuSm2wf0+1Uy+KIAeGMYwyi2l0FK4u8IM=;
        b=k4hV3XB0n7HKRnRRBlNcsms4eFbcoBicAczlCBdu7tF3omduleLqeRJ0Tn/cKgjGLw
         8fvPT+O8Wwy5C1282XYk26GVDcULGccr3sdcHeJl816B1fzHbTgU+XF+3mGE4kjpGzHa
         gQQ4B3WpaSgCYbrD1UqtFL98ney19hcSxbdnWGdjWANGGarqWwyRN+5dV2DB655ZsKO6
         rsLdNYOtiWvy0crmsP16Uev8VU1gykhCflFq0CHJqj0VrSXnXj3zdSLoG6/6jxA2aG2O
         bn2kdwcs03gcwEB1Qux3bHmCjPO5RWoK28FAgDB635EyrDD+1k5l0w0iIW9o8Ryq0WR8
         6ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673023; x=1792277823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ch8jJvcOl0DuSm2wf0+1Uy+KIAeGMYwyi2l0FK4u8IM=;
        b=ETNct51Mmau5dxaXz9816QQ9mp2MMoYIaB11ZDlMOBqNuB/ZNqlMzG4fzXE62Ev8Aa
         4irtABTw0ky2q9DeewAH2xlWXP31qdhfqq7fBm+SsePk0rbZTYPigwCs4NhSIXj2DYDV
         DTM+r6eindW/WBaZZiV9BRRF93gXdaJ+z86nga7xwx6B6wclS6sLkmsjtBLRgaVnHdl7
         vwNf/87hwEc07FRuMzwQkKY2+IUK8162xMRLiF3cDz4KrdO9UlCaKXqvPbGldpxGt+nL
         FG1ooxGGHJl0zp+y0R4XRrhMA0BsLKewV14AawMDpVsdCU0m5YaDJ60gz7RzV+CnHG2I
         77wQ==
X-Gm-Message-State: AFq9FYI1oeMBZK0Tyqpu9cLmp5FpJsZ3pRc8qYWzV7yNjMoKAolY4UDb
	QaGyC46dyX65nDdZzDHaMy0qPrzuxHEwsqsSyZW1supiTPqXpjFMfAFNRT2rm7ay
X-Gm-Gg: AYBFou0R7vOkh0bkmeUQf97yl81S/MR5snMul/ZiC6Evy5gSCaxvRPaNFgfaAMLSf+Y
	q7IDdibSSmdZ3xCD/hZgTAIvnMQzQYLcPtp5FkDCahaFK/gSk2HvwKmC2nkwrCy1NsfXsCabNaj
	qSmM5/AVr1c9dYIRmHYzutNYEalinDiso8VlJNsah0EyM9zOBqHU+VizPW/dBUEOBI/KO+ZISrg
	joSsN+teYJ8jseYrlDo/0z4wpZ5Ik5KPDH6+x5RooOWGyUxumMawoSzKRub6bxblGrphf6CD102
	I59IeRE0BwitJB3YEybQD+7/23XsX7IjidLNw/OQDVoVv50ed1KxKRiVkS8UxYa8mKPv50oaV3W
	B1IuUTtkyBUyxZja8RwEHbKBH+TEqKKOS7fkDnm8XQfF6eEZpDtzfIehB92sEQlv23J606jOhel
	0s7jKgLrIsPzqsgu9qhR03DWzyfWIq5akr4eD1wGL0zsjiFhyjrpZHXv9Vto+USUSJy7Pjhqc3W
	JuleZmlb/IPQRiYM6bUrsCezYUL
X-Received: by 2002:a05:6a21:398f:b0:3dd:85a9:55a3 with SMTP id adf61e73a8af0-3e16bee802emr5923819637.37.1791673023130;
        Sat, 10 Oct 2026 15:57:03 -0700 (PDT)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e07329sm2603662a12.5.2026.10.10.15.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:57:02 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v16 0/8] DCD Prep Series
Date: Sun, 11 Oct 2026 07:54:51 +0900
Message-ID: <20261010225852.10727-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the first eight patches of the Dynamic Capacity Device (DCD)
series. They set up: DCD enumeration, CDAT handling for DC partitions,
the event interrupt plumbing, a preparatory refactor, and
documentation of the DPA partition layout. They stand alone and keep DCD
disabled. They are not dependent on the rest of the series.
Patch 1 detects the 48h command set and then leaves mds->dcd_supported
false. The flag is only turned on by the series that adds DCD event
handling, so every DCD specific path added here is shut off at runtime:
cxl_configure_dcd() never runs, no DC partition is created, no DCD
interrupt is armed, and the CXL_PARTMODE_DYNAMIC_RAM paths are
unreachable. The intent is to land the enumeration and plumbing while
the extent to DAX pipeline is still under review.

Based on v7.3-rc6
v15: https://lore.kernel.org/linux-cxl/20261007201828.952-1-anisa.su@samsung.com/

v15 -> v16 Changes:
===================
A quick respin:

 - Patch 2: cxl_configure_dcd() took Identify Total Capacity as the end
   of static capacity, but Total Capacity is only required to be >=
   ram + pmem. The static end now comes from the last static partition's end dpa
   +1 instead of info->size. Check that DC starts from there. (Richard).

 - Patch 3: dsmas_entry.qos_class initialized as CXL_QOS_CLASS_INVALID, so a
   DSMAS entry that is skipped for lack of DSLBIS, or whose QTG lookup
   fails, no longer reaches update_perf_entry() with qos_class 0, which
   is a valid class. (Sashiko).
   
   The DSMAD handle check now checks handle > U8_MAX instead of
   handle & ~0xFF (Dave).

 - Patch 6: when the DCD vector cannot be requested, tell the device
   not to use the vector: dcd_settings is cleared with
   Set Event Interrupt Policy, so a device does not keep signalling a
   vector with no handler while the
   host considers DCD off.  The Set command is re-factored into a new helper
   cxl_event_set_int_policy() (Richard).
   
All other patches are unchanged.
I kept the review tags on patch 3, since the changes are minimal and
dropped tags from 2 and 6.

Patch organization
==================
 1-3: enumerate DCD command support, read the DC configuration, and pick
      up DSMAS data for DC partitions.
 4-6: split event msgnum configuration from irq setup, factor out the
      interrupt policy check, then configure the DCD event interrupt.
   7: preparatory refactor -- enforce partition order while collapsing
      the ram/pmem specific partition helpers into one.
   8: document the DPA partition layout the previous patches enforce,
      and where Linux is stricter than the specification.

Testing
=======
This series leaves mds->dcd_supported false on purpose, so
cxl_configure_dcd(), cxl_dev_dc_identify() and cxl_dc_check() are
unreachable at runtime as posted. The tests below are done with the rest
of the series on top, otherwise testing would not yield any meaningful
results.

HW:
Tested add and release of one 2G tagged extent on a DCD with a sharable
partition, driven from the system's BMC with FM-API Initiate Dynamic
Capacity Add / Release over MCTP, to confirm the DCD interrupt
configuration and the DSMAS attributes are read properly. The device
is sharable, so an add without a tag and sequence number is refused.


cxl_test:
ndctl cxl test suite
16 of 17 pass, cxl-features.sh skips for lack of FWCTL

Anisa Su (1):
  Documentation/cxl: Document DPA partition layout and ordering rules

Ira Weiny (7):
  cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
  cxl/mem: Read dynamic capacity configuration from the device
  cxl/cdat: Gather DSMAS data for DCD partitions
  cxl/events: Split event msgnum configuration from irq setup
  cxl/pci: Factor out interrupt policy check
  cxl/mem: Configure dynamic capacity interrupts
  cxl/core: Enforce partition order/simplify partition calls

 .../driver-api/cxl/linux/cxl-driver.rst       |  35 +++
 Documentation/driver-api/cxl/maturity-map.rst |   4 +
 drivers/cxl/core/cdat.c                       |  99 +++++-
 drivers/cxl/core/hdm.c                        |  24 +-
 drivers/cxl/core/mbox.c                       | 285 ++++++++++++++++++
 drivers/cxl/core/memdev.c                     | 100 ++++--
 drivers/cxl/cxl.h                             |  14 +-
 drivers/cxl/cxlmem.h                          |  88 +++++-
 drivers/cxl/mem.c                             |   2 +-
 drivers/cxl/pci.c                             | 207 ++++++++++---
 include/cxl/cxl.h                             |  29 +-
 tools/testing/cxl/test/mem.c                  |   2 +-
 12 files changed, 792 insertions(+), 97 deletions(-)


base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.43.0

