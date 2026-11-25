Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608633;
	b=jdIGtmV5iQ+9qML4Y3g7Rd00r3lCPhb3KhDq7wojpGpWvZ9Ht+cPuEmQJYS6aswP3/iy
	 S+fwkZGVpCSBzxmoKWvLd2BARToZ5nZN7sdQ41q//9t5KmVljGMc0SooeDe7mGCpMClMG
	 mFNF3fhkV/WFkeHFruo7ctIteAwv2Qz2xPOrT7nbBJVpydqVIw1nnxAaYS3s0SgDbwkk0
	 p6mQZy1NWsM/EhQTzTJ0CCWijG3BPvTyQjAs+Pl67GFUUrpOp7cUjUH3yjnzEqyFxrGvM
	 PJmu1uiMMXpdFiN0v+zaaUncxsghmZ5I6sLWSfq30pE0F0C1qbJNiZvDplohItOr+6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608633;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=teCiq3/IJSOFnCwrRz/KsIITrdIRIZwu2S42elp1laQ=;
	b=tXk/kLZstSUCErrpLk8TQ2xVwqnCrGSAswVqPmlu1rc2L6N3FgiSF3HFTbAnb9f+mEWt
	 elxF1Vox3ac9fH266FGUd+WiT6jJxPvcp6bVt6v/a0HxnYKlSXo9gt+fqapaO553BK6LH
	 t9q5L/XK++LPbAlTYuHg2h9SLki4Jh0KmCDRAAb6TPrnwHDjgGmZPfwbUXhcXopZfC2hp
	 p5/3nslmNjAE4b79t3lBE/ckD769spcvcFnsCphm6oYaqEvHWNZvel8HCjMrX4CkaodUb
	 Y3ZRN5HrDMmVXbxi/zC2sU94Irod6E/yvC/O6ifAgNV8HG1pAFN9khaw/Rngwl+kNyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qyShYa2N;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB793606A323
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB793606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qyShYa2N
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cde1479f76fso3186105a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608632; x=1796213432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=teCiq3/IJSOFnCwrRz/KsIITrdIRIZwu2S42elp1laQ=;
        b=qyShYa2NzKEmUjiLHvQZ5zAyVtUqHrOVOJO4l4btuLjfE5yTEIBYyYkhagXPqHx6o2
         rKx9MS0L3ewKwCCW6p5wXYnVEepOHP492a3/WHPvE0ItJAy1jyT8wFPQ17/OCHy7jPqH
         vwVcRNg2oyAKioIeo/KxHoREtE8twFhv+RpRXH5osOtaSZ4qYMdN0HrXByDynB16PMXz
         F4EYvNODcMN3uz2a6MGlub92OjdyhcwOwopZhoUX9Y87stQJZUdVp2M6zfJSoiOIfPvw
         xYxhFCLP24qe8WLRVOKO9o1lTSaVI86ClMOVW/YhlLj5yAe/qo/7cZ94P6OV+a4wt18w
         5h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608632; x=1796213432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=teCiq3/IJSOFnCwrRz/KsIITrdIRIZwu2S42elp1laQ=;
        b=WWh/Yo4VVWBUIs3NjILW39CKbCYON8Xxfu6Y2cBhfIQiXLbdeirLww8Vfte+8/uw5i
         rF3RI98UK2HcqHyI/bIKWRLPczuYf7ndBbkFQ4EnqCi+A8IIYXoZ7xMfOwRmUIjZ6yDV
         DPOBMCMO1J6LJZe2HW8HMoTxabjQgurosXZ0TvJhu3tqOhgK0Cpim1KqfbcVA7Le5yqe
         3BoEBqA9rEBzFgfs7EFcCJv46Y9d/xBIitNFMh8QotV3v2w/tp/ZAIrVD1D+12LTvVyN
         N3rz2Ctjicz8lLgYkLdVYP06ypNelCP2hasaMtOqJzZWuCVp86PZVArmuM0bNcj1ZP7r
         Nc/w==
X-Forwarded-Encrypted: i=1; AL+hErGVcmKQ1BTHhcPuuYZDb2+SRWB5gaAfuKcjy/1GOPv5WSvM27X74tsIupCEoBAJw2IM1+nzYoq67S8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9q1WPVPzaxPgGrDnN5h1taV+tOROm3vsz94ZFJC7mjFEAACj7C
	1cN0NYurPVjBAds7sTN9rgxYuDTKZmLFWyrMhcSlPhMXtuKaI/oqko1eSOkF+g==
X-Gm-Gg: AZFdTZe5gtVkpk/Dczt2He5Khh1drphZMUVb8R/SroU/oa/q3oFlDi9Atm8PD0dX9dk
	TRMd3ugtXv1NVNxIqQxnwI0/l4DAqvRdzo9habQCIWmzhh6vl+MyCdH3/HsnuCW5GBliCCK7Wkw
	mEk+tXii6qTy0QG6v/5YZrA190wa7xkOjixLWn1/i0QK+EWY15PZQIjz4gvKLmEjZabep29UJjV
	P95RJ6ksKbvOeZFYByly6a5eeNvCQaNOlRNTyRYN4/wYl10xlD86i6IaXf1gRw+P4efP7s2liSz
	+VGmC0hsH1iKvZWFHATEJxWd4A0RZUwwJQL9JFosOxa7h9C5TFEyICP2shOFxOeV6qvOZFPsZQz
	MugwujUQpM38i1a7m6/ZMUZDzrztP+49wbLWELpX02COPyv6LPFiK31kyshE3cnsyVYqa/sMlQn
	xU6SvRv4OQ6mFWnFrV48w5Yg8hMwCccYatzlcBp8/aczl92kAMclIFH3stVcRqEnnFyuR84toT4
	CdVc4FgCKtanqEmSI1T8hCKmZB8vXc7XeKlSDQWMUuIvXCYvUlkAa7nCY9q3Eh8XPqq/arafaQi
	aZPq7Rb20gZLkLzrG0VABqvGf/YL3vlQp3TPC7h7cHQ=
X-Received: by 2002:a17:90b:1c81:b0:3b3:c179:45b2 with SMTP id 98e67ed59e1d1-3b41c9735bfmr16305811a91.64.1795608631864;
        Wed, 25 Nov 2026 04:10:31 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm12707554a91.0.2026.11.25.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:10:31 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: unsung0317@gmail.com,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
Date: Wed, 25 Nov 2026 21:10:21 +0900
Message-Id: <20261125121025.3574705-1-unsung0317@gmail.com>
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

