Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5098353A95
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649265; cv=none; b=mjhp4eI6Y1BUfQRiMiJulS/VkXJ+MQ4hCfkkZN6GKMHd9bzbWkSBmkDNJ+4bjD8066iO2RO3d07XxrN8ja8MZyZYzrVc3d04YxT+EmtcRixtYDxqMvXA5sgxG7Ko/PX1NiK+EEvXZcH0He+scJ5q/Nst5zQiz7atxYcjNFYR2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649265; c=relaxed/simple;
	bh=+QHbSFdGJ6vVLpUF7xybyfof9oQqRwUNeSgR1wtYWF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O/qlIOxPy2CSYpeRC16sXpjc3UzDy1YGF42ZlShZ9JSa7uEbhs9b+6Z1cmju3wgtUX+AWYrQpBGLVRb4A3azVgLozA9pBLlL+ydehZjGH/5pH4r9CsbKDLLfXf/wp7y1L5X2m9sFGZI8E9+qLgG9QXXR9XatKxWCL4V2yBwBe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZH99EBbk; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH99EBbk"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1433e7b057fso534361c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 09:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791649263; x=1792254063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yijvi9zg0Pj6BOdFjk5FdPLKcBndaQKT70J63Zutecw=;
        b=ZH99EBbk97T2lFCQ8S/K3rCZRWJskzmprZ+QLNzdPBEMmI55rxnKkJRc/VZTGp9zMI
         21Co6nya/PcCXNkzosL/j5CyfaD8ZEGbcD5A3zC6BN01An9imZy9VaV82CMrsadRSgqg
         gV1sMgwXFmie6Lxb937BectSm0mhK0AElyhu3r4ViyoglrwG5+FLBsmpe4kDOyQvmzfO
         yTMef/QOxug1yFOVLKaRk4ekc1g7j6T/7JbxudwoUtz9qBaTA2Hh5wBXym/pCZ5BRgv9
         nLMSMF7yRt9UJzHo4+85FXvl2rpBkws0b/hzX0Wo4RmeXejej57yeEnk3QxvZyoAUITi
         GU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791649263; x=1792254063;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yijvi9zg0Pj6BOdFjk5FdPLKcBndaQKT70J63Zutecw=;
        b=y8jgLkoLcQo64tpmlNFaylKqG4MZQW8HjnvpMJ8Y9xI6Ymg+o5kXCBlLyRH2garuJv
         30gZPlFQT1IV3h/pad55NP/Emx8f9l3k+kG74zP9ebIJLRgPrcQSwl8jPbt97qOsBqo+
         tnwbvOwyAwOS/SDbXNK0m1BUIAWvXO0DnBy3fGpF8nfYUsf0WRfbb/DxJtajUhM2hBFn
         ziFkMzeXwNv+FZInDBiRGmqPhvLW8T4gXpKe1vgoSjPBLuZwhpN7Ui9ntpX7yf9QM4zi
         r26k5RTAYOfFdkSFQonpL/naVP81wPGu+4WDb21XZjSc2HMDvP91vRL8TZBLJtFgUTzb
         G8jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDLg+fIgFWo7mbm42SrtFbql4G7TnUDIpJA4pm5XpPt0jMN4AYqPPapfl0tM9SA9RmMjuM0vNHJtU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZEsOoBjV30vL9D3paN5D364UC+a2JzBicDJ4q5qfvjxXI/YSz
	udOitv7hetAXBiZNRnc/RUGIkihNUmTMc9z2fiQJY+qWalf7c12p8vqz
X-Gm-Gg: AYBFou0gbXmn8m5gdl3kf+kW504NT6oBMMRN08HlnjBwkQiT9LFytVMVGhLR+O4fXSN
	YM643rt6QjJSu4qejsO7YIx29OtUZjEW+QBYZq6Vk5SzPvmLjz/+ejcXPca0VWl48ec35ck8Y0C
	9nIIqE0z4zmU6QxL/tUkB5jAXKMyL8m22GefH/Mn0Iqmc0Yng1dEhFqANK3ivtYZDPPlQF7i/j/
	yY1ZiSRumaAj4KShDXN1ymEwpGrbo2mbTRL536j/KBEaL9NvraM7a4qSbT1BYa0sQl8aLVP/jEp
	WD/6R9Y21oYFRLgtsQHri0hTfOXp4bskDMSGpsQYqRlCLD3Qa3GUZKtUHCGxzfg9CQGsFubrZOk
	IafpZD8OHPJmFwe95ep98eT7KFZTDKJ56VPyw+pCYLOJWSIjpWzkQ1C5v5RScNYQvJbXt5I/nuo
	UCZy2Xpnee3pTRx5LCZd20qcg+XxzHmIzylCm81zVRbm+KjbZsD8jUcSHTYT742NjSbBByf+EIX
	De/Hisjb+5hDGkJVQ==
X-Received: by 2002:a05:701b:260c:b0:144:f85a:a188 with SMTP id a92af1059eb24-16a56ab4575mr5965520c88.2.1791649262450;
        Sat, 10 Oct 2026 09:21:02 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([115.96.176.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm15778622c88.14.2026.10.10.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:21:01 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Subject: [RFC PATCH 0/5] cxl, mm: Keep device-reported poison out of the page allocator
Date: Sat, 10 Oct 2026 21:50:08 +0530
Message-ID: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A CXL memory device keeps its own poison list: the DPAs it knows to be
bad. The list lives on the device, so it survives a host reboot, a power
cycle, and moving the device to another host.

Linux reads that list only when user space writes trigger_poison_list.
Nothing reads it when a region is assembled, so with a device that
already has poison:

  1. the RAM region is assembled and dax/kmem onlines it;
  2. every frame enters the buddy allocator, including the ones the
     device would have named had anyone asked;
  3. a task is handed one and reads it: machine check, memory_failure(),
     SIGBUS.

This series reads the poison list at region probe, before the range is
onlined, and keeps the frames it covers out of the allocator. Nothing is
unmapped or signalled, and no runtime path changes: the frames never
enter the allocator, so this is not forwarding latent poison to
memory_failure().

Dependency
==========

This is built on Breno Leitao's hwpoison series [1], which keeps frames
poisoned before a kexec out of the next kernel's allocator. The approach
here, withholding frames as they are onlined rather than taking them
back out later, follows [1]. [1] hooks __free_pages_core(), splits a
block around its bad frames, and marks them with hwpoison_boot_page().
Patch 4 adds a second source to that hook.

The two cover different cases. [1] records frames in a bitmap spanning
the RAM the EFI memory map describes. Memory hot-added after boot sits
outside it, and CXL region memory is hot-added after boot. [1] also
carries its record across kexec only, while the device's list survives
reboot and migration.

Applies on next-20260908 plus [1] v5. The num_poisoned_pages_inc()
change agreed for v6 [2] does not touch these patches. Patches 1, 2 and
5 touch only drivers/cxl; patches 3 and 4 touch mm.

Design
======

Which records are withheld. A corrected error never reaches the poison
list, so every record is uncorrectable. Only records with source
Internal, a failure of the device's own media, are withheld. External
poison was written by the host into healthy media and a rewrite recovers
it; Injected poison comes from the Inject Poison test command. Withholding
either would make a recoverable state permanent.

No host-side storage. The device is the source of truth and is re-read
on every probe. When a location is repaired (sPPR, sparing, hPPR) the
device drops it from the list, and the next probe onlines the frame
again. A record persisted by the host could not learn about the repair.

Volatile ranges. CXL r3.2 8.2.9.8.4.1:

  If the device does not support poison list for volatile ranges and any
  location in the requested list maps to volatile, the device shall
  return Invalid Physical Address.

A device that returns it, or that has no Get Poison List at all, is
onlined as today with nothing withheld. This is also the reason for the
RAM -EFAULT tolerance poison_by_decoder() has carried, without a comment,
since f0832a586396 ("cxl/region: Provide region info to the cxl_poison
trace event").

Incomplete lists. If the device reports overflow, the host stops at
max_errors with more records pending, or a media scan is in progress,
region probe fails rather than onlining on a partial list.

Translation. Each record is mapped to the pages it covers through
cxl_dpa_to_hpa(), including the extended linear cache alias. PFNs are
collected in an xarray, which removes duplicates and keeps them sorted,
then coalesced into ranges and registered once per region. The ranges
are unregistered when the region is torn down.

Out of scope: regions with normalized addressing, and PMEM regions
converted to system RAM through device-dax.

Patches
=======

1. Snapshot the full Get Poison List across continuations into a
   caller-owned buffer, keeping overflow and scan-in-progress state.
   Also bound the record count by the returned payload, and reject an
   empty payload with More set.
2. Factor the per-decoder query out of poison_by_decoder().
3. Add a registry of PFN ranges known bad before online. Readers walk it
   under RCU, since __free_pages_core() runs concurrently across nodes
   during deferred init.
4. Consult the registry from [1]'s free_poisoned_block() and
   __free_pages_core().
5. At RAM-region probe, read each decoder's list, translate, and
   register before the DAX region is created.

Testing
=======

QEMU 9.1.0, x86 q35, one 512 MiB volatile cxl-type3 device, 1-way
region at 0x190000000.

QMP cxl-inject-poison records poison as Internal. The kernel's debugfs
inject_poison goes through the mailbox and records it as Injected, so
both cases can be tested without a mock.

Three 64-byte records were set up before the region was created:
 
  DPA       Injected by         Source     Result after create-region
  ---       -----------         ------     ----------------------------
  0x100000  QMP                 Internal   withheld (PFN 0x190100)
  0x200000  debugfs (mailbox)   Injected   not withheld, source filtered
  0x300000  QMP, then cleared   -          not withheld, no longer listed
 
create-region logged "withholding 1 frame(s) reported poisoned by the
device", and HardwareCorrupted rose to 4 kB: one page, for the one
Internal record.


To reproduce:
-------------------------
1. T1 (Terminal 1): boot the guest
vng --disable-kvm -v -r ./arch/x86/boot/bzImage \
  --disable-microvm --memory 4G --cpus 4 \
  --append "memhp_default_state=online_movable" \
  --qemu-opts="-machine q35,cxl=on \
    -object memory-backend-ram,id=vmem0,share=on,size=512M \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
    -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
    -device cxl-type3,bus=rp0,volatile-memdev=vmem0,id=cxl-vmem0 \
    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
    -qmp unix:/tmp/qmp.sock,server=on,wait=off"
	
	
2. T1(Terminal 1), in the guest as root: set up and check
# mount -t debugfs none /sys/kernel/debug   2>/dev/null
# mount -t tracefs none /sys/kernel/tracing 2>/dev/null
# echo 1 > /sys/kernel/tracing/events/cxl/cxl_poison/enable
# echo 'file drivers/cxl/core/region.c +p' > /sys/kernel/debug/dynamic_debug/control

# cxl list -M -D -u                       

[
  {
    "memdevs":[
      {
        "memdev":"mem0",
        "ram_size":"512.00 MiB (536.87 MB)",
        "serial":"0",
        "host":"0000:0d:00.0",
        "firmware_version":"BWFW VERSION 00",
        "poison_injectable":true
      }
    ]
  },
  {
    "root decoders":[
      {
        "decoder":"decoder0.0",
        "resource":"0x190000000",
        "size":"4.00 GiB (4.29 GB)",
        "interleave_ways":1,
        "max_available_extent":"4.00 GiB (4.29 GB)",
        "pmem_capable":true,
        "volatile_capable":true,
        "accelmem_capable":true,
        "qos_class":0,
        "nr_targets":1
      }
    ]
  }
]



3. T2, on the host: inject two Internal records over QMP(Qemu Machine Protocol) 


$qmp() { printf '{"execute":"qmp_capabilities"}\n%s\n' "$1" | socat - UNIX-CONNECT:/tmp/qmp.sock; }

$qmp '{"execute":"cxl-inject-poison","arguments":{"path":"/machine/peripheral/cxl-vmem0","start":1048576,"length":64}}'   # DPA 1 MB
$qmp '{"execute":"cxl-inject-poison","arguments":{"path":"/machine/peripheral/cxl-vmem0","start":3145728,"length":64}}'   # DPA 3 MB

4. T1: inject an Injected record, and clear one

# ls /sys/kernel/debug/cxl/mem0/            
clear_poison  dpamem  inject_poison

# echo 0x200000 > /sys/kernel/debug/cxl/mem0/inject_poison
# echo 0x300000 > /sys/kernel/debug/cxl/mem0/clear_poison


5. T1: check the device’s list before creating a region

# echo > /sys/kernel/tracing/trace
# echo 1 > /sys/bus/cxl/devices/mem0/trigger_poison_list
# cat /sys/kernel/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:4
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
            bash-194     [001] .....   511.644231: cxl_poison: memdev=mem0 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff hpa_alias0=0xffffffffffffffff dpa=0x200000 dpa_length=0x40 source=Injected flags= overflow_time=0
            bash-194     [001] .....   511.644343: cxl_poison: memdev=mem0 host=0000:0d:00.0 serial=0 trace_type=List region= region_uuid=00000000-0000-0000-0000-000000000000 hpa=0xffffffffffffffff hpa_alias0=0xffffffffffffffff dpa=0x100000 dpa_length=0x40 source=Internal flags= overflow_time=0
# cat /proc/iomem 
190000000-28fffffff : CXL Window 0

6. T1: create the region

# cxl create-region -m -t ram -d decoder0.0 -w 1 mem0
cxl region0: Bypassing cpu_cache_invalidate_memregion() for testing!
cxl_region region0: withholding 1 frame(s) reported poisoned by the device --------------------> Withholding  1 frame 
{
  "region":"region0",
  "resource":"0x190000000",
  "size":"512.00 MiB (536.87 MB)",
  "type":"ram",
  "interleave_ways":1,
  "interleave_granularity":256,
  "decode_state":"commit",
  "locked":false,
  "mappings":[
    {
      "position":0,
      "memdev":"mem0",
      "decoder":"decoder2.0"
    }
  ],
  "qos_class_mismatch":true
}
cxl region: cmd_create_region: created 1 region
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 1007394
Policy zone: Normal

# cat /proc/iomem

190000000-28fffffff : CXL Window 0
  190000000-1afffffff : region0
    190000000-1afffffff : dax0.0
      190000000-1afffffff : System RAM (kmem)

512 MB is 0x20000000, so the region ends at 0x1afffffff

./tools/mm/page-types -a 0x190000+0x20000 -b hwpoison -l
offset	len	flags






190100	1	___________________X_______________________


             flags	page-count       MB  symbolic-flags			long-symbolic-flags
0x0000000000080000	         1        0  ___________________X_______________________	hwpoison
             total	         1        0


7. T1: check exactly one frame is out of the allocator

# grep HardwareCorrupted /proc/meminfo       
HardwareCorrupted:     4 kB

Not yet covered: interleaved regions, extended linear cache, poison
list overflow, hot-remove of a block holding a withheld frame, and real
hardware. I intend to cover these before a non-RFC posting.

[1] https://lore.kernel.org/linux-cxl/20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org/
[2] https://lore.kernel.org/linux-cxl/arEz7lp9_nRGwHPm@gmail.com/

Shaikh Kamaluddin (5):
  cxl/mbox: Add Get Poison List snapshot support
  cxl/region: Factor decoder poison-list retrieval
  mm/memory-failure: Add a pre-online poison registry
  mm/page_alloc: Keep pre-online poison out of the buddy allocator
  cxl/region: Register device poison before exposing RAM

 drivers/cxl/core/mbox.c        | 137 ++++++++++++-
 drivers/cxl/core/region.c      | 363 ++++++++++++++++++++++++++++++++-
 drivers/cxl/cxlmem.h           |  25 +++
 include/linux/memory-failure.h |  92 +++++++++
 mm/memory-failure.c            | 175 ++++++++++++++++
 mm/page_alloc.c                |   8 +-
 6 files changed, 787 insertions(+), 13 deletions(-)


base-commit: a9d7ced84989ec05be09b4b8428759ef60450a0f
prerequisite-patch-id: fe9d44deb8ccc48c0311bc4131bdf733eb353b34
prerequisite-patch-id: 4cabe6adb37cd8c218bd43c97970bc65f313b671
prerequisite-patch-id: 52ad24bceedb9c03df167f10573166a1d97ba97d
prerequisite-patch-id: 44bfbc8aa3c4b19593f7b0d466fbc0cb99b99f76
prerequisite-patch-id: 2d344a5322ff07c7895a59d2425540a30e4e0630
prerequisite-patch-id: e776f306dcbdda3f6972187ad1e43a62c2754890
prerequisite-patch-id: 3ef887599e31ef973d6d9ca15d0462d55f5f0409
prerequisite-patch-id: a23fe88ab4529b6a6669a991e15cf1631311391c
prerequisite-patch-id: 111c69880ed0e148cdda285896c006e8d1fc98a8
-- 
2.43.0

