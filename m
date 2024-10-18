Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED6202F8D
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267993; cv=none; b=KgRDHjB5iT7tNUR7hD2kGk9vy5qGjtIzPGCh6J8vpeYPIosskv0JIuWRvsrTjRPzu1ws01Jz+qiNtugILjYABTQcvLUdDDyQqLrvWbsKkAMhE8F7Tl5vEosWxNPI7Bu4JyUFET053StYKgP4YHkWVPC/RAmmnt9Wc5PRG20mz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267993; c=relaxed/simple;
	bh=VvSSM5PHvpdy1x7r8Z7eeUMWMXNadGwitEhL38kROeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9FXkaSAZHyOZLjJuzQav6q/gRa+3cMLDRcEMM9j/muMHt0+kagJkLS0MB5tP4KYoOOgeACmpYdzPF9Ep0Ydmyp1tUFBRf9I3uT6Q6qOEEVjN46p0mhwPLcTQ5WipuQJA3Dkc936VT/+TOUuwT+G6s6ZJZBM3mZ/tPzWlO6PlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rNRfN12X; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rNRfN12X"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1434b00a2so184485285a.0
        for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729267990; x=1729872790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngioInjflIeuk03TT5q8AniH0tXIsTkJB53uyQo/6Qo=;
        b=rNRfN12X1YQEnb/lJyBAXsasfKMaAhIYbZ+e62a2xmn/nEt+iIovb5h9nU1mBiknW9
         38Rq1DNHGyOW4ilDbG4svXjia/zOBR2nitkjQ/zxuqztLLtxvEvV1zsEGUMscToLQVIQ
         G2EgOs5EsU0s12xhf8flsnBQPYnCE3RTdPUMv8I4qKf3gcFyreChx0ndOa0iCeDDYC/p
         8vUNa44DKg9qWL+DTvQ62AucziWkf6vgBTrY6vOiu5bALnhiFOfXFshrke+QNEaYGwQY
         a+rfTWqSQGxrVG5f4pdhyPFbZVG+iaIA8Q3BptuG6NRNGsBkqJU9dbcRVYvrSgDVDJem
         eXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267990; x=1729872790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngioInjflIeuk03TT5q8AniH0tXIsTkJB53uyQo/6Qo=;
        b=YWx4J/G58CxtCUaf7UBphfbMFW9NuapMCE38leesPKAYuES5eaBkjWwVzxRiE/hA8y
         MMFTOoEc9ukQo+yZS421J1AxnfbAnfAWRSKzfL6jT06s4gFRwO3fTP1WG6tO4W0hEcOI
         uayv1oeZ2Zdc+l7lvo1LNlWTrUJCBZRECW0W0mCcmBHivuWslBC996vNqmpjWIzpjgx0
         bSL0cYO82aR97DPbSZ7fbVIS2fx2E1rRxQ27JdBUTloJwrWbToInzvdA6n1edQv5Vkq8
         QUGcwNmP8/cJEgiGYulP/5cDD3hm4uJ/65++VjYFG+C3uGxmvMDXtKhwfdpDMNhlBnmN
         vHWw==
X-Gm-Message-State: AOJu0YyThV3SuSdGtzehKMso7U4gENzIHvCEAszogQpGaTiwoDGjUz96
	daclgDQtZNM4D2zUGjkOh9RBpBX3JuVFOr9uS2sLrxHQqGrW33gJ464B5WalpUb3aua7Jyn2hcS
	2
X-Google-Smtp-Source: AGHT+IHY5SQOsi749VokI/SC5N20+Gor9GxNzD5XoMRkvXOZrmI5mdWm1kkZQ5dxDrcjzVVApCxXdg==
X-Received: by 2002:a05:620a:4614:b0:7b1:4073:e8c9 with SMTP id af79cd13be357-7b157b5aae0mr360782385a.20.1729267989507;
        Fri, 18 Oct 2024 09:13:09 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156fa55cfsm81677385a.67.2024.10.18.09.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 09:13:08 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	svetly.todorov@memverge.com,
	jonathan.cameron@huawei.com,
	nifan.cxl@gmail.com
Subject: [PATCH RFC v3 0/3] cxl: Multi-headed Single Logical Device (MHSLD)
Date: Fri, 18 Oct 2024 12:12:49 -0400
Message-ID: <20241018161252.8896-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MHSLDs allow multiple hosts to access dynamic capacity on a single
backing device. This complicates DC management because adds,
removals, and accesses need to be vetted such that hosts don't
stomp on each other's data.

This patchset proposes a set of hooks to be called in cxl_type3.c
when each of the above events happens. The results of the hooks
can be used to prevent illegal DC operations in the corresponding
cxl_* functions. 

It also proposes an implementation for MHSLD emulation. The device's
state is stored in a shared memory-backed file (on Linux, under /dev/shm).
Extent ownership is tracked in a bytemap, wherein every byte acts
as a set of flags showing which host ID can access the extent at that
index. Blocks in an extent are claimed via compare-and-swap. Failure to
claim the entirety of an extent is treated as a failure; the host will
parse back over any blocks claimed so far and mask out its corresponding
ownership bit. Operations on block states are done via atomics. This
allows claims on unrelated extents to be serviced concurrently.

Block state is relegated to a u8 to conserve space.
Therefore only 8 heads are currently supported.

The MHSLD device inherits from the CXL_TYPE3 class and adds the following
configuration options:
--mhd-head=<u32>
--mhd-state_file=<str>
--mhd-init=<bool>

--mhd-head specifies the head ID of the host on the given device.

--mhd-state_file is the name of the shared-memory-backed file used
to store the MHD state.

--mhd-init indicates whether this QEMU instance should initialize
the state_file; if so, the instance will create the file if it does
not exist, ftruncate it to the appropriate size, and initialize its
header. It is assumed that the --mhd-init instance is run and allowed
to completely finish configuration before any other guests access the
shared state.

The shared state file only needs to be intialized once. Even if a guest
dies without clearing the ownership bits associated with its head-ID,
future guests with that ID will clear those bits in cxl_mhsld_realize(),
regardless of whether mhd_init is true or false.

The following command line options create an MHSLD with 4GB of
backing memory, whose state is tracked in /dev/shm/mhd_metadata.
--mhd-init=true tells this instance to initialize the file as
described above.

./qemu-system_x86-64 \
[... other options ...] \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-ram,id=mem0,size=4G \
-device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
-qmp unix:/tmp/qmp-sock-1,server,nowait

Once this guest completes setup, other guests looking to access the
device can be booted with the same configuration options, but with
--mhd-head != 0,
--mhd-init=false,
and a different QMP socket.

The first patch in the series moves the CXLUpdateDCExtentListInPl
struct to a shared header. This allows DC-management code outside
of cxl_type3.c (like mhsld.c) to see which extents have been
accepted by a host in its DC-add response.

Signed-off-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>

Changes in v3:
- rebase on 10_15_2024 branch, handle renaming issues
- dc->reset to legacy_reset update 

Changes in v2:
- remove explicit init_mhsld script
- implement remaining DC add/remove logic

---
Svetly Todorov (3):
  cxl-mailbox-utils: move CXLUpdateDCExtentListInPl into header
  cxl_type3: add MHD callbacks
  mhsld: implement MHSLD device

 hw/cxl/Kconfig              |   1 +
 hw/cxl/cxl-mailbox-utils.c  |  44 ++--
 hw/cxl/meson.build          |   1 +
 hw/cxl/mhsld/Kconfig        |   4 +
 hw/cxl/mhsld/meson.build    |   3 +
 hw/cxl/mhsld/mhsld.c        | 456 ++++++++++++++++++++++++++++++++++++
 hw/cxl/mhsld/mhsld.h        |  75 ++++++
 hw/mem/cxl_type3.c          |  17 ++
 include/hw/cxl/cxl_device.h |  24 ++
 9 files changed, 608 insertions(+), 17 deletions(-)
 create mode 100644 hw/cxl/mhsld/Kconfig
 create mode 100644 hw/cxl/mhsld/meson.build
 create mode 100644 hw/cxl/mhsld/mhsld.c
 create mode 100644 hw/cxl/mhsld/mhsld.h
---
base-commit: c4f85d1b04caf0a2baeccb13790da5e2a42fb0d9

-- 
2.43.0

