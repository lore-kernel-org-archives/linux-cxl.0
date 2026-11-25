Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609978;
	b=KQUNr9Cbp8dQWMe9moLD3y2x/qMiwmS17GguSmyNJFn7DXRlIHLx9qNfwqHbSHALxBIR
	 kxeZ1u5MW5w0QB8/qlt1OnpVfjzpYOZe0L3CjYdbGDZjxp9656mTBiExIPPylnDbQffvU
	 jDz/M/3WF8+pQtcX/FBLS88vIN3Ho0MKj/pYSbz87/qmwrkMvb+8jV1BgrFd1Bred5ZMx
	 46i0XJfcnZza9BC7+RuUubDcSAcL7d7KZN1ohb0BBVSuqidRSZx9FZgh9sk/3J99SLZXi
	 0bPJIZUEyRmxq5lUNeybLxKm+ieqbR/jlLLIUdm7xOfSO3vZ4v0m3mtvrcj4KBHBggg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
	b=cjLY2GSw9ms/Jj2rCdTwtqiGhIwokIhMAomxOhfExYyzN7/ChAGh6k8ONFnLTKgzd3Hd
	 ak+9LTb3hUKyk3lX/kit7x9rRGloiElNHZ+2nx0wjgt6Azk57POenNEP5YioCqGY2cCov
	 Ps3yT9vMzvq3iedkX0cP+s9rnvjyuvuVBHakNkRzoyQYF4QxkTH8nQsR9Rrx7eAsAIO4W
	 Jgbw4Zgak0jtfOU5JlE+tcaNThjIGoTCebINki8e01UpT0C9LIWX2pbbqLzAezu8V3Dlg
	 WG9n01oPQPyR/NktaszgGs/O00+mrfRA6tl+uOEkhTuELUVfg433zkUPLQ4yC7Yio2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4bY55tl;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89973606A332
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89973606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l4bY55tl
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so8015865c88.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 04:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795609978; x=1796214778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
        b=l4bY55tlX4SlhSDYtTYQ93eHvF8GIIYYIAjCJZKJfckS0gN9N/RNwUtW1RKz/rPvX2
         aYEdug9u7ASzcMJezHy+pjxBdYyTc+C1gWGt8ksNCjZRhAMjz2i6ESmA/awy3lesy7Jh
         dz7qQVUNGsYkdYPazo564dQLXU5+eVZ1fx9FyQR2PCma+FTYjulpKvdRnoxLa6+6mQON
         Jz9by3W5vzPTKYF7kfyataveB1PLInHTxFalDorcKWK51/ZtquYgGU27FtcqyCovGKzp
         zLbtnG/iXBPp04IwJl6jC+1lbKVYEJDneqGsffUGLl/PxrippoyCg7Pgx7htp124C30B
         IoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795609978; x=1796214778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SHWtXulVx+NJs1MOoLJTeedDG+BaUJLRXW17KRhzrqc=;
        b=hwxF7DYUZ3/7lQEPosfci25JPLl8TizPK3UzYtInyEtRZRahKZHcSJBNqiQTjUVrmI
         +b7opYsZBXu8mmdvKenIGJyzewNztb0oL3AUVwJp47svLm7cn5bwD4Lt8UJfcLVM/Zw2
         z+FRVQ8fQG5+9nIeT7YteeaUlDoWq4eyBUzhWZSucNiPCJtkxpnIRoS0+xrusZBPs9cH
         iMnpXZ/D2x2IGFMbkdQhJKq2hA6bt8kXuri7sTm6X9syZFWMoCSguVYnVV6si2TKnu17
         tK2Wd9JQRIygo51LytxXJEe97mm+N4V/f4JE3jxfi9BoVW+o7/5ZTKp18KOiEGjF3hqD
         huVA==
X-Forwarded-Encrypted: i=1; AL+hErHgsDAoWOkn+qyDJkLykBccZA7PNvy8ModPN31n5YR9ukdql12LAN05Mqs74LnGIz1eBWQwZTlXcq4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IskayLXrN0IIhE3jl+XQKrM06Tbf2dwra4pW3lfSbq5OIsCkJ
	pDhKdlVZtpNAvRT0kjgYN7EnKddFrXzYl6sLcW/lqGjFvGTP8eBa2/5iHUpq0w==
X-Gm-Gg: AZFdTZczBw83TweMG8drDayApHtOob4HuBk6HwJ2kOIekvsWL5Bf886UnbvyaWBqfVk
	KD1hS0fKPx2wDVi7cXHrU2y4o1691GvGArm+RFtSBz3kgkkH/zjw7DGcpLSiUXaCoM4CRPq0Sds
	4oKabKLxSii6GiKv740GyNTqC0Uy2V3/dXFl3BhWXFIovL+fn9u14vda4+YG+V0d5wX9cytg3nu
	YSkJ3rnH8FOxG9H8K0nNJwcuNfF3ZjZ2TXbU6WiyW5YDdz25USgeFv/wXkAiLE0pqrPSbrPYiUb
	ZA/1XozunCAV/LDo87Enj19/6H70IeUzqrkDrl78Xc0m8tF8ntkcBJ8AqCL9P7je+4wZxT4z13L
	h8CkvzS9Sj/apnlYQ0jEBBjmgv9SnlCZfN0cmxMvXUo99lwwfxx6W9oyGDMhanRuHIYXukH2vJE
	CUUsw08G5uWxAcfMGWw9SU6r5IdlBK9Zxoua7no+k2wnIMHrHiDdx+6CS+o/1KOvDGeiKJIGoyv
	Iv2yeoiLX+Db+Rl/1RglSauN+CRQeOqmf65uHIrOWtmu4fUqnEXBRcXxMlj+hhePdRjyxd0Ja9s
	KEJVMyaoMI32f/TWJAh6C61AU2eGsnYI6RZy1g3V6Ds=
X-Received: by 2002:a05:7022:3c0e:b0:190:596:4071 with SMTP id a92af1059eb24-1b55689f722mr15106374c88.11.1795609977516;
        Wed, 25 Nov 2026 04:32:57 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm34890020c88.11.2026.11.25.04.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:32:57 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: unsung0317@gmail.com,
	linux-cxl@vger.kernel.org
Subject: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
Date: Wed, 25 Nov 2026 21:32:48 +0900
Message-Id: <20261125123252.3580458-1-unsung0317@gmail.com>
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

