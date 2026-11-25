Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610645;
	b=vtxADSXUsjOlbM/zIVxtHiouGAVSOPVE8zHC5KUjoALxsKo3Cuv0f74PUqNEyWB8xqEy
	 IzwJFjD2mrmiqeDtjT3NxjJ9eTsWKnNHHU9rxPMBHWdqmevRqKp8wuw7gaR5Kn2QzlOft
	 YMFhj7KwEx7y3kiANJGkmrmz1DnWdFDf3+dt2juAsofZz9J6QgUlgPNBls1b7OhKrFxo9
	 sEsCvji9iXZEtSJLQlUOQljbdULh7IzGigO+75fFHS1wpKCA8vhPn7FHgPoLzHyrRLEMI
	 aqIYd2eh/fY/JofTOXw7Yq86O4Vk3eAYNCp34ycH3+j+K/cjxxHqC3xQ3cJw2/4SeKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
	b=jxQGUUkgtmFj2XhYnnRNvspyPM+QnyeFz23UZn3yAI9l9KPOr4GvfSncr0okdbZCqX3d
	 sbsXzzPaz8sXAnxhQoDQYDGGxF3dsj+6VbiZxkfiQEMn/95QfbcZCCRq7q5NKQW+L6Fuh
	 rEMiKjxFwXRij2/rG8xqXsO1hL8YOvmw2ijk/o+AKa89QRQswHutuHWC5kd4U4jtya8f5
	 BBlizf2VEINcoO9vPyt55nwBiNNafUlpE3MWemuzccN1h2a5nuX+pSbMjbe8ts3OO6aBP
	 fCQXLDOwEtwIEUhlAV36fw1NBgZM6RJhAUxA5fnye/P8ANu0hzV2/gVloBHj4JWGpMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZUlKqTc;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6815606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6815606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZUlKqTc
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-385d8a00598so8445214eec.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795610644; x=1796215444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
        b=qZUlKqTcN5p56BxyZZmeuC1b3uSeZzEsKFG5Bf22PhYORte5Z911Q5/5DiZH3Kp0m2
         M3IotSHl5HfME/9nLYvMyud08m5mEimYDNO3E0RVQ7BwN3nwesE6AJnOLBKRCfdz8iPQ
         YW0hXN1bLp4eUYlEBeSxfwFlyu5csecY7ttQ+bNIm8b2rpc4RuLOHOk55Ur5UZmHko/i
         yMKliz+3CW0rbsJJvSnybTjS7p3TWYYtoD9Oj9/8SAiuv7sKDGBVQiZY4XjiOsydsOsW
         c1LxinaibkVr0xphTwmBhUoZuTHGd9BL3D7Z2Jf0dUjCRJInq+AWDsu5I4A/TidmX8QN
         Vgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610644; x=1796215444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
        b=ljMcaTkcb++vVjdFFYfbVv1rhYp+m41iq5JqYzb8NhcMVaN5LqTIZjtsXEGPE4GPNa
         XUtHsGzgbHiE4bBuLoL13iiUY19U9/ctE0uyvzD3wMKA9pr82Id1e1dYEr2UwCld6A6B
         eRpo0+K0OEmFXcpn9JTHwbbAhGH5K1rqnbnem3wiojFvjS6F4NzGQW3oAiTRKIWncl2B
         VgFFzo8ZJ2bwtfZd6GrTVMEz+AXZjLFl6+3GgvL6JidcyizZhYZnR9OybhMOr+8fXxhP
         PrjStawx6jnW7gT4v+M4JB5QSCTix8hQGlA/rsJzXDI3tyMVo3N9/LlYBiqFIvJY7G3N
         z9Zw==
X-Gm-Message-State: APuU4Z+2mfatP3f9KHbeZtiawnflCFijDD2PscAjyKdwBn4aiwnwgjEp
	tIMyHkJsUSLfdh2WFjdRqnuHnIsGVoIeVpu70H5nQEHMmAJAaS/trLQkKMtStlnL
X-Gm-Gg: AZFdTZfN2DZnh0ZRpuY8q8TLrCCKe8tIOCzBherMkY/CM0mkzJzQVLhdPvjL5xEyW6H
	/hZKPk/FdUx/Jve9JagZfc8wc83gukvtHmjqZBs5LBGWYwZRZpnN/HGup2uZUz9+g9yxFj9rOOY
	MzQ0BWHaFsRHcqY2wbehRSNbq10uzCASkY0hU+HCNOmEyMsKZRzRfgOO3Mh5RYs+Z0srqk+HCP4
	A24SZ4jKewzhzJx63RBIkvGO2J6HdYbMjElWY0wXENTRP3P1rqM3WLSIHObSXwLxqt8VPx69RDE
	DugiVCyUtlY5ZziOVYYACAxxMeYplKdCr2y4uamLWU+qMYnhCgdrG0p9+fpYw9B2DPT2ePX/HE8
	4UQXhnygSebmFmQilPToEbH8Q38RNaSuFHrFEAGfP0dh5YxmnFaL7JcKUKTOj2ZXjp9D0iLKamr
	GW7YrjsA12pMzAObVY213oz6xRB/rh/eTZ+4UecKNXrYGtyZj2dZwrq2CIpP44nTj6lG6IsH/Zm
	i2T+w9kRcWSF+Vqs9LZeQAiMKuHiBxwnuheCPFv9dVJbli8Up9CvSHEqqUhSyiRhihQi9xwAfDL
	S6V5lFnhU3wIHTnXjvAN6MxrlRuRtUtYpHTiNTL6t+M=
X-Received: by 2002:a05:693c:8641:20b0:383:50b7:1d78 with SMTP id 5a478bee46e88-38571223ee7mr20197872eec.40.1795610643703;
        Wed, 25 Nov 2026 04:44:03 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm55841836eec.6.2026.11.25.04.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:44:03 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	John Groves <jgroves@micron.com>
Subject: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
Date: Wed, 25 Nov 2026 21:43:54 +0900
Message-Id: <20261125124358.3583223-1-unsung0317@gmail.com>
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

