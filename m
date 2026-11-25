Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610531;
	b=Y61gqnGb1OFb5iG7UGtlOX0MvDE064FsWwBfQ6kFrxkcES9SwR/GY7MrzK48XB6M+DFj
	 ZOS5025TKYi1FbO8n/qVHeHKXmgzL7wNVFirOe5TmxSuUz/66Sff/1wEy90db4MGauaBr
	 QTIqwiC/oq/5pMto3dv0U43kVfDm8HW202LqM5f42QF42Hdu97BEa6hsmEzPiR2QI0QfX
	 bTtUy8qIKx80PU0TMYCrhh0rjl+/J8w+X+6xi7tXT4WfShPdPWdWoRR4xCXkF7Ylu2fsR
	 H38/9JcjsXxGfekDT4CD/2aj89UpLfoBYMGb0ZPwneH+5IMXkYo6+xgJ9Yn3Utfn30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
	b=ezyHJB1DCfanvUKU75uBUO4GwDiHztsnX6+1stHdKcF2Qcvvu2mBm4mjHDHthFuRdJ2+
	 p9mBZ1MFhkts+EOkTSxX8H+oIgLpqV1498AgZANofHoV6ko4N4gvOoSDuCl08Sf7Mk8Ne
	 /qyQAsdxWsqAHfieBLI2y2+GGD6Sw8seFMyCLHhhe1P1LIEBOysDrKzjnswM0SGXU8Ysq
	 83/K0LEaX7PJM5Y3/8viLE/beCEFT9dzOU8uXa0caTJq9b27/SuOtCE+PxH7qCCo1lM0D
	 BeHLvHkzNrzRk77v0x0KQbsEu4apXvL/H+Q0mUGi0gfXaaswoRdmMzzSnjQnGTNkpVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSHr4nDD;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2478B606A327
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2478B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSHr4nDD
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f03f3631b2so30973445ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795610530; x=1796215330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
        b=LSHr4nDDCD1kEl/LkLVdE/pQHt59qNUCmCYATaZ9LpTLrCXQeQayyoKcdQWmV0HiY9
         R+byIS0cy1ylXWfLijomKGA9nQHSx0ckqnp1HvRqv1YvGxJF36pSiFTM/165fuEul/U+
         JizmqgoJsLuHk+eb79QOCpeWmYzKa1Rk/D3QgUdnSW3c4vNqstZhuJUGkZh4nP1gAtvu
         3rzF5Je6da2D1edhTKFJZQ9nleK4I6+EEvzKeHHm81YQpHm7GnyNM2pksC+bxFEYhsHp
         N/i+8/4mzoX1A/smaYZrUZfW7RK2MGEVnngv5zbVjljiUoQ46p//wTuTmzg7SrW+1Mrx
         1Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610530; x=1796215330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
        b=LQsXPUfTCamW8ZrGgd3622D+27AA4uh5mSSD8CkLV5dTGGAURxmsNRnecT5d6KAX7n
         vmRv6UvMFItoyg9rtcnEQWHJDGQiw7n9EO3N9SQIcv3qteV3SDnlridptNk/ZVjLjy1a
         z0/c+kXTpFQG+oai937G84g/E3FPgIczwigqxljvipDk4s1AeLsHd8mRtqjmfHRNvEv+
         zQzk5wnGtlrsCGZ1V3GaW7hSFYEQA1PHKupoVKH5AJUqd55lTDcvxzAlKN2hcl0257q+
         fF5vK54KdtB7AAwkSQJIHBsOH/SeZcysPNW5tygHPfpeRcjph2PlfnBCAl5pB7SLNvBJ
         gSpQ==
X-Forwarded-Encrypted: i=1; AL+hErFIHms4kqQUfrE28IVEbFkfpLM0rR5VHS7/0WLQA6cjbh71rYriPsukrHE95iBSO7O5zxHbOEbu0HI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8f0DdClRqow/wWIBkAxvFKhOBWv5an21StgsVHI748tfAhnMWr
	e6V0lW4Hgp2xP/zmmnWYTxLbZ/xUdk/yF2z+OLfQeroLC1hvjHLGkj3/20bxRQ==
X-Gm-Gg: AZFdTZe5gJXXdWZCQsatNUHsG5jaVS2UfllEq7bC3J/flRPVtwP6fzqDjXrd6XDKjqo
	suYPtuxNjMf2CDEw8onqeM39PLsL7fm1IGrCXsRPXqg1oAleccDvQIkdQ1dSl3ChZr0ZKUvAFSP
	2iY1FgqkLwIsJ0/v8E0+rA3quoKQzRywA+PIBJZg7LGNkqB7F77qtVGDG4vf8NYZTfqZ4gpdmXE
	GUCfWyfqQIEPj0FNq5bsTcfeHqKzTHS9fWjadpUYmih/EBCH7LVaBX+fiCTluTQmCWeaukwommS
	p6pAJpGnholFDM1KqTjvaTgxU0LQW7fB6/EMLd+W42kBPyFRRPsgAcVRZXv5mw2kcYcsI4utt/k
	PmO5pNSZsf93liHrUwSAdmzblxzg0hs7t1SbqeROZDN0mhVTCw8hOwdUmwK7y0M1a5bA19h3uVc
	7WHADHL2XuOdJxcrbnl4LUl1Wzka8HbpUpLEmkyImjSHB/VaFKMAB14r9iP0hADZBzYyMvuog7S
	586H8nA+JUSkvqPfP+AX8znBTsVeLUvca4d4UJaWADEQqAYmyp55+kKvSDdtQXLt6I8hX4wuCAH
	wyVKHAMUX5hlNdbHBUfdYobauNj0tWr57+5jCetuu9Q=
X-Received: by 2002:a17:903:3b83:b0:2e9:58c5:8c68 with SMTP id d9443c01a7336-2f03f248adcmr166294545ad.54.1795610530347;
        Wed, 25 Nov 2026 04:42:10 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14fc8csm83843735ad.74.2026.11.25.04.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:42:10 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: unsung0317@gmail.com,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
Date: Wed, 25 Nov 2026 21:41:59 +0900
Message-Id: <20261125124203.3582585-1-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets userspace activate an uploaded slot online once the
device no longer decodes any memory, the same condition sanitize uses.
Uploads keep their current behaviour; activation is a separate,
explicit step:

  1. upload as today (slot N becomes pending for the next cold reset)
  2. move the data away, offline the memory, destroy the region
  3. echo N > /sys/bus/cxl/devices/memX/firmware_activate
  4. recreate the region and online the memory

Patch 1 lets Activate FW complete as a background command; without a
poll budget the mailbox reports a timeout at once.
Patch 2 keeps the pending slot and the activation capability from Get
FW Info.
Patch 3 adds the attribute.
Patch 4 lets cxl_test advertise online activation.

Questions:
- Patch 3 requires that the device decode no memory, as sanitize does.
  The driver cannot tell how long a device holds CXL.mem requests while
  it switches firmware, and the comment on the RAW command block list
  says activation "requires adjustment / coordination of transaction
  timeout values at the root bridge level". With no memory decoded
  nothing can time out. Is that the right condition, or too strict? It
  means moving the data away first.
- The Online FW Activation Capabilities ECN to CXL 3.1 allows Activate
  FW to complete as a background command (8.2.9.3.3), so patch 1 waits
  for it like Transfer FW. Should it carry a Fixes: tag? John Groves
  raised activations longer than the 2 s mailbox timeout at the June
  2025 CXL collab sync; patch 1 may overlap with a patch from that.
- Patch 3 holds cxl_rwsem.region only to check the decoders and set a
  FW state bit that makes decoder commit refuse the device with EBUSY,
  as sanitize does. An earlier version held the rwsem across the
  command (up to 30 s); with an activation emulated in the kernel,
  create-region and region sysfs reads on other devices then waited
  for the whole activation. The cost is that a create-region on this
  device that races the write fails instead of waiting. Is that the
  preferred trade-off?
- After a timeout the device may still be activating, so patch 3 keeps
  refusing regions, uploads and sanitize until the slot shows as
  running or a later activation succeeds. A later error does not count,
  since it may come while the device is still busy. A device that ends
  up on its old firmware stays refused until cxl_pci is bound again.
  Reading the Background Command Status register would end this
  sooner, but needs a new mailbox callback. Would that be acceptable?
- Should the pending slot stay set after an online activation? QEMU
  keeps it, cxl_test clears it.

Not addressed in this series:
- State cached at probe (CEL, timestamp, event interrupt policy,
  features, Identify, CDAT) is not re-read after activation.
- Unbinding the port above the endpoint during the command tears the
  endpoint down, which clears HDM decoder enable and Mem_Enable on the
  activating device (exercised in QEMU without kernel warnings).

Testing (QEMU 11.1.3, one type3 device, guest v7.3.1 unless noted; no
real hardware, so an activation that really takes long, polling while
it runs, other hosts and other CCIs are not covered):
- Functional and race tests (concurrent writes, upload, create-region,
  cxl_mem and cxl_pci unbind, mailbox readers, kill -9, sanitize,
  upload cancel) on release and lockdep/KASAN kernels, 20-50x: no
  warnings; kprobes showed no activation while a decoder was committed
  and no commit while activating.
- A test-only build emulating slow and timed-out activations, release
  and debug, 20x each: refusal during and after a timeout; a failed
  activation after a timeout stays refused, with uploads and sanitize,
  until cxl_pci is bound again; a cxl_mem unbind waits for the command;
  a port unbind during the command. Create-region failing after the
  port is bound again also happens on plain v7.3.1, so that test does
  not check regions afterwards.
- The whole flow (move the data away, offline, activate, online, move
  it back): 100x without data; 20x with a process rewriting 2 GB on
  the device's node (longest write stall 78 ms, in QEMU only); through
  a maintenance script, deferring when there is no room (10x), rolling
  back when room runs out (20x), and SIGINT/SIGTERM/SIGKILL at each step
  (60x); and these mixed for 4 hours (1,462 iterations). No failures,
  and the data was intact after every iteration.
- cxl/next 32af781935: applies cleanly, no W=1 warnings; QEMU gets no
  root decoder there (CFMWS with both HDM-H and HDM-DB, rejected since
  e4c3f0d966), so only the tests without a region ran (all passing).

I designed the change and directed the work. An LLM coding assistant
(Claude Code) wrote parts of the code, the changelogs and the test
harness at my direction, and was used to review the code and run the
tests. I reviewed every line of the series and take responsibility for
it.

Unsung Lee (4):
  cxl/memdev: Poll for completion of Activate FW
  cxl/memdev: Keep pending slot and activation capabilities from Get FW
    Info
  cxl/memdev: Add firmware_activate to activate firmware without a reset
  tools/testing/cxl: Add a knob to advertise online FW activation

 Documentation/ABI/testing/sysfs-bus-cxl |  45 +++++
 drivers/cxl/core/hdm.c                  |   7 +
 drivers/cxl/core/mbox.c                 |   5 +
 drivers/cxl/core/memdev.c               | 209 +++++++++++++++++++++++-
 drivers/cxl/cxlmem.h                    |   8 +
 tools/testing/cxl/test/mem.c            |   8 +-
 6 files changed, 274 insertions(+), 8 deletions(-)


base-commit: 32af7819352bae9c690ebe277a44eceb501d5c68
-- 
2.34.1

