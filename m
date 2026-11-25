Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608794;
	b=2ygH4IAGN4mqu4imS4o54/IF+aYtSff3NQX86AZJ1ZwwLfNbo0tueLH4IvDdZhr4hh7H
	 2X3reCEOKhD/P9JQJBLE3TCZRyaiaSK9Vbrws3IwDOwJZgrmRiB9aVk8Sno5ArYfol3n+
	 TkmrS6ATm2qZ5zeTM+2h+Dp9y1gyQL7dZRr+KvLGZr/bdrfN4grrkcH1fNr31SQWTK5gu
	 nMfeTK/+obapsa6h692dxQl6YXL+D/dMGaF7XzfdA5Gbc5YwriMd0K6pFpDxBcz+5AtIy
	 0rFLOxtBApGBGFfM54WooMYBe4mVbsVxYutkPNqHOi9q2AgvZ1giVhA7X+LsIREv8aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=teCiq3/IJSOFnCwrRz/KsIITrdIRIZwu2S42elp1laQ=;
	b=vgphadJ2rbpYAJTlY1XkrjXzlg8QxCT/Dl1q4Z3bNBbtaomQemccqGEopVgWrv5bDwex
	 BBRkTzBfbgeqRtcMxxI7MY1KWVvRxsIJlXTsnD4sqn+WU+LCt03HGkoideWvgDIBB/KMp
	 hZJ1P7m9jjtNVJgSuODNrRRFGdAmbxWxBvQEBWQPee/wMd66aiYfQII71YJyTkfxFwqPS
	 9fX/Cp96pqblOzTftWBR9bNPE0ovPZGBGiHitwv2/PZi+C7Efr4VNb2QI7WKDp/5ZnmnI
	 gEZgIT7XpHQWio/Z/Q0giTewzvfJ8UoMiRub/sEQ91S0wLfgYWYzxzmcLDA+6nmGT1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mWVF6vUn;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBEA606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FBEA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mWVF6vUn
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb9f760337so3299090a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608793; x=1796213593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=teCiq3/IJSOFnCwrRz/KsIITrdIRIZwu2S42elp1laQ=;
        b=mWVF6vUnaciGxznGYb2d8RRBdAysoMRngXQntzgtcOoRNtEO40rjb5OG5IR6IXMEM2
         ghCBtn69iC/ATSKlMp7htFdJ5owXY8kDnESrQq/ohlLsGUnASOVzlJ7ZqgX3klO+50JU
         hKAOCSczhIWeaUfsD/rPIR2wn1vIkNwgtJp/R9hrIeYThOE17LMBQ2cXhC0+2QQy0d6y
         3APBbv1DYlH/+bSCZBs3ObyMw+5qgrRU5GcOq8rV7QDdxQo2un1EFeE0G7lj3fix3sNm
         tGRez8PZwWJzuPMTxywKsj2WvBI9rp9e4e8TSW6zerPNgaILuqrnXvYbpDIbmvV2lBjH
         fMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608793; x=1796213593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=teCiq3/IJSOFnCwrRz/KsIITrdIRIZwu2S42elp1laQ=;
        b=w0mgTuVY6+Zca3ZdoK286D5JW7P+hKF+78zG+a9z8M56AuhPXvJRccR2HN9FPuAFI4
         QTPCyrz/QnvKErCoAD+UYAp1DtvYtgOR28XRqlWZJTQ6kSZfLcjvYfo4MFyBWpvnFzDp
         antz16TkozjEBrBdqYNhidXS9FRol6eC4ZZKUPRPPn2yPm3XdxG5SUcgRQ8MOn9hoEuO
         WGBMI+BS0sn1X0P4aCGII7jQGYVc0vQ8j2dV+VdolGNcIqzuoIa0p5ZA8nD1aHWZEcqi
         ZN5gkQzJM188z+4+Lb1aFR1R7P6NJuu6O/9wYdi0w57+bHvNS5tsg4IAAqOURCUGjT4O
         Xd1w==
X-Forwarded-Encrypted: i=1; AL+hErG2G7jZhFXyG11+6cXQkPbYkcDhjFMaFTDnl4m6vApiREAXokpvZaRdkBTsHq26jmNhg0f4Gprm9LM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DwImWDOM3YKacuV24b4S2ne9QrbntbszD6nzEVXXDwlFteWKQ
	rSRcjhT4ta94mhruU8jYpoxaqFzjPtsSuzReppIFE5ISsW0JVG6wQ3yz
X-Gm-Gg: AZFdTZemZj3cFw+d77V4aRApMfNblAW28x+IqpBod5EZuzhbjKRzADsImsGzHMLfrKD
	B68df8UZWT0YWWR8L44gHHKbdYKpkKCr82/BHvnSJg1csKjGyCXB1tMe3o3OYHgDRts3/RGk2A7
	JBCLMOPPoKLgN7gEYxeqMIuYxS32UUbC3R1cgySyC2OuWo+LAfdz0BxmIkxChrn2mtyf+SGC3yX
	5XdRucJaoncYAoXWoXyvjTtNUGiSysvoZg1DLnPO7Hjw1Ej5JE5yu+cBdw7Vix1r1PLsr8m3yu6
	Hl7f57Go6Cv15BR6ZQ1CLZpcWYmu7dET5VchjzyynwrLB4msEfAOFFtYCTh4BzJ+WmOwPL3qndG
	OYQBz/PehNUBd4bCVE8+rcdPYiwcHaGWq01NuoaYoSgoKNEgcSZSeSTR3RPsOKU22/5UwczfBUO
	DGqQdyxl3e6Svo7YSXDPeHcHJkPaL/fB9dBYdemlscJUw5UGyfziCnUJTdJrZpkpjhhq9x/aVm8
	rhYMOAgfZydzWFDYdd27TlSHDnEYi+OMClDf0PSIRsUsMNKETN1emO2j0bCXJRr2Q8AeU+UBnE5
	iexdoSTBWVxdNcjLDdGKQ0RPFRyjY1UYZebB6Hcj5Rw=
X-Received: by 2002:a17:90b:390b:b0:3b1:d40:2c4e with SMTP id 98e67ed59e1d1-3b41c56f34amr11199574a91.0.1795608792682;
        Wed, 25 Nov 2026 04:13:12 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41adcfe23sm27508238a91.15.2026.11.25.04.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:13:12 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: unsung0317@gmail.com,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
Date: Wed, 25 Nov 2026 21:13:04 +0900
Message-Id: <20261125121308.3575452-1-unsung0317@gmail.com>
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

Open questions:
- Online activation is meant to let the device keep serving requests.
  Patch 3 still requires the device not to decode memory, as sanitize
  does, because the driver cannot tell how long a given device holds
  CXL.mem requests while it switches firmware. The comment on the RAW
  command block list says activation "requires adjustment /
  coordination of transaction timeout values at the root bridge level";
  with no memory decoded there is no transaction to time out, which is
  how patch 3 avoids that coordination. Is that the right condition, or
  too strict? It means moving the data away first.
- Can Activate FW be a background command per the spec? QEMU's CEL
  marks it so, and patch 1 waits for it like Transfer FW; no Fixes: tag
  until that is confirmed.
- John Groves raised at the CXL collab sync in June 2025 that firmware
  activation can take longer than the 2 s mailbox timeout. A patch from
  that discussion may overlap with patch 1.
- Patch 1 assumes the device can still be polled for completion while
  it activates in the background. A device may stop answering the
  mailbox meanwhile; this needs checking on real devices.
- State cached at probe (CEL, timestamp, event interrupt policy,
  features, Identify, CDAT) may change with the new firmware. This
  series does not refresh it.
- Patch 3 holds cxl_rwsem.region only to check the decoders and set a
  FW state bit; decoder commit then refuses this device with EBUSY,
  like sanitize. An earlier version held the rwsem across the command
  (up to 30 s). With an activation emulated in the kernel (QEMU
  completes it at once), create-region and region sysfs reads on other
  devices then waited as long as the activation (about 30 s for 30 s),
  against tens of ms with the bit; after a timeout the earlier version
  let a decoder of the still activating device commit. The cost is that
  a create-region on the device racing the write fails instead of
  waiting, and after a timeout the device refuses regions until a later
  write finds the slot running or an activation succeeds. Is that the
  preferred trade-off?
- After a timeout patch 3 clears its mark only on a fact: the slot shows
  as running, or a later activation succeeds. An error from a later
  Activate FW is not taken as a sign that the device is done, since it
  may come while the device is still busy with the earlier one. The cost
  is that a device which ends up keeping its old firmware refuses
  regions, firmware uploads and sanitize until cxl_pci is bound again
  (uploads and sanitize are refused so that no state changing command
  depends on the device answering Busy). The Background Command Status
  register, which cxl_pci already uses to detect completion, would tell
  when the earlier activation has finished; reading it from patch 3
  needs a new mailbox callback. Would that be acceptable?
- Hosts sharing the device are not visible to the decoder check, and an
  activation through another CCI (e.g. MCTP from a BMC) is not reported
  to the host.
- The device lock held across the command keeps cxl_mem from being
  unbound or probed meanwhile, but unbinding the port above the endpoint
  (or the endpoint port) still tears the endpoint down. No decoder is
  committed then, so none is reset, but the teardown clears HDM decoder
  enable and Mem_Enable if the driver set them, i.e. it writes to the
  device while it activates.
- Should the pending slot stay set after an online activation? QEMU
  keeps it, cxl_test clears it.

Testing (QEMU 11.1.3, one type3 device, guest v7.3.1 unless noted; no
real hardware, so an activation that really takes long, other hosts and
other CCIs are not covered):
- Functional and race tests (concurrent writes, upload, create-region,
  cxl_mem and cxl_pci unbind, mailbox readers, kill -9, sanitize,
  upload cancel) on release and lockdep/KASAN kernels, 20-50x: no
  warnings; kprobes showed no activation while a decoder was committed
  and no commit while activating.
- A test-only build emulating slow and timed-out activations, release
  and debug, 20x each: refusal during and after a timeout; a failed
  activation after a timeout stays refused, with uploads and sanitize,
  until cxl_pci is bound again; a cxl_mem unbind waits for the command;
  a port unbind during the command. Once the port is bound again,
  create-region fails on plain v7.3.1 as well, so that test checks no
  region afterwards.
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

