Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609816;
	b=s5c9CD0KwtkcIwdFOvf9XnL6AM2gBqBXyk6EdJBv0AODo46TOSTod/aRjbi1IPgXU1W7
	 5C9ZA7GxQqD5/t0X8qwv02mMXfxDNB68b9mE2aUSdlw7GR/uGcZ34JgZ+/N6GTxyVUbHh
	 ehVTa8w+8O0lMrq+5JeF3UmPjDb/OKeH1xBH2Aik6YjYoWyiaY1fjlQWznXWedHDRg5Za
	 jkm56Y5MaiB0DsfHQxlf4oWobp2qgjttAEwINTgfePmdFcxQzEm85KkI0Rr6h2uxpCvn6
	 wpOPng3Nh3pBltlqi4j7GUwI5nLheDgFCNLKL3cVlUiPWCe4kKDdjZu4zIgU2ohOkuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609816;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
	b=5jMtmW+h6PGFo1+Mt8MRgGLYt2CN9Bpz4NtO1oVxKl+HBDIE8eY+vsbbVQlCN+nmTgRj
	 jjoY43OLTZvtQsy4RoLTiVltkGIUpZL5HjtPxUnNsOS6z2o96/V1GJJWfrU1s/J7JqcK/
	 oAHGV1LGZmuNKmt/1szlZzBEa+WZ16akPiWHLNgx4rV2AF/5dsfhW8GJwOoLSNUo7sreX
	 uTmIIIyFTalwPQ5MXVttgTqUbJnPGx0xYb9azMMyDqUGpV1/TUF1cUy407MDHirm2pvRZ
	 7r80fwA2/glcnefBDAsmEJAFFznB2696J1yaT7viPaZuXRDOGOjO5DbTYxQ0Rq/GJ+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFBBJvxB;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795A606A329
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A795A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lFBBJvxB
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b3d4d3bba3so2846744a91.3
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609815; x=1796214615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
        b=lFBBJvxB7pqZaHQm1GVimbMSgXSLe3WZUCaUndG3C1s5O2iWkDA1wudgrjKxvGtHSZ
         eEvLvNwdV0raW7FJ1LqS/Zqgri9/gcMEAR2kvqJaemKTm7lD3d1SVZvKcHS/wz6wO29Y
         pvBKYIS+R5XQJ27yYBXsb8RmckuJues3s1GR24WWSsBKqNNUNPRQFmfy/yBKOb1trHYJ
         XmWnY9OFDoffbowV2JQxyltB49YwMsvqHYxrrld6oVVZ3hFNUyxdfJjml8y4aJE2UkyH
         wPi3QRKNrfO6io24yrF8fmoqR0ifXIbbsEUnUZuCRmwzUUcqe+UVbTQpzQeI4tGl8Iuo
         rVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609815; x=1796214615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
        b=VpFchpmuiRKB7u2xXKCtGQyN1N69ZwCs3XU9yY7Z4oivNQVaBgfMLRcVkIe8SLfCHu
         2t7Vr1hcbG8z0nUQsRWxCoRXrgG7SheGkpjO/9XFxV4/205JoofCogBq6JSVBZ3fIIi9
         X28rHbERVTllZsXTYh0dd6V2DLlXuc5YOeLZDXf8TblG3JXtFJbm9st1eyu4caUApsJA
         G6ZIK7e4+ldAd+VfyRN7HT78m1FbVLrOPm52u2wOcsG+4fk6stUwifKlr0OVkdz/5z+s
         C9W0mlQvUq3VBUa0OJTNDBFzhBclhItltp8dohW2oPnNZqhdgScVVRxc68rITWLNdnXV
         4Wlw==
X-Forwarded-Encrypted: i=1; AL+hErFmxiziQuYcfhju7INvJEBiVL+zazLMCKrNlI1wyZSvtWb/Pff1IPSLwNdb9XF9+SWfc0LICgpIlFA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/roh7Kn6WpzE1y63L1lVBOg5ojeTy9QLCnpUbB4sxvsh6VMu6v
	+CLrr5lcUviRlCq7m0OBxICh7psOYhCqRepWnQvCssREI/+dPdoqnvMMoJpucw==
X-Gm-Gg: AZFdTZfPyNWMaxawjF2xtj+CFI0LjHvhSZJypCZc5L90/1+CHCrUPS68lvLL2RgVu/1
	/gtgnNmmydkYUuxEE3ny3RDa6y8asMie39M+wahRKlhsVNs19G1p0jAdKWNmDkQJFriI17P43zr
	qn6C0edsv3sOSpuSJ8o4eS9udisKEDJqlToaWxtogHQi6lWD4k9DN3BQKvTZ9p3tpnpimYwinq0
	WaJGd2qjbVdya172NlToMEjDH4AJE20gMuqxzqfgQ069OkC/4fYfiuXXdeVFwsxYUorl3L+mUWN
	1k0i7IHsX1AwBU9ivf93/MCgC7SNddOOQb0BtQRi1v2OXxufmbgFdWuKy6xxiK8E/ZnAacvOg/m
	xsJak7cVWeaQlsXUckQX0MMqABm3Rmbikek4dfsWTe6bI+h9DArBHZsIdBDZSjw/RNmXVUMdhQW
	FblcA46+ei97UeNnmm97nsEDVwOq82bblLwM5D5cDL28UQAg+r+uCw1r7cFS4tAQGU6IBY7nSxB
	tI25ICEb/QSBZ/+GEVIXWoCEUqqvkgEhBrSuG5duJXlpLqJiUVrOe+Q+0M01eEXth3yhRmXXMv4
	WOWs5tcH6xKkS7x9nwXKPWC/tEMK8SFRU0Lufy+rdTQ=
X-Received: by 2002:a17:90a:e7c6:b0:3b5:a3:4423 with SMTP id 98e67ed59e1d1-3b500a34682mr701318a91.28.1795609814721;
        Wed, 25 Nov 2026 04:30:14 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0575d9sm8705076a12.25.2026.11.25.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:30:14 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: unsung0317@gmail.com,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
Date: Wed, 25 Nov 2026 21:30:05 +0900
Message-Id: <20261125123009.3579635-1-unsung0317@gmail.com>
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

