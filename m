Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699461;
	b=saDLjRLiN+RQhwHdJyv4cihsn/ldOyjLRfNWk/9tkfPQZA8Z0c7Tg0vMxjzHbxd3UK7S
	 ctOOTM95u85ubOOfzpOoBV6n9ER0UwwT9JaHEhE/6TmTJkzXuq6eA7rqXP+5dncRvvrxN
	 OtbsTSiXzkOc27mKT/3CVmVha7usnfkp04YpGqEvU9wIg+bhZxsqRGA+bDD3Mc4ogbhJx
	 J+NB7pGKq0yy6w27RihjF7zRmb6GdAqhuWVbodEcS9N8yWb6Ve8FoKGG8qE6OjL3u066H
	 /R5jQ6ikGKid4ue1L3h2RnwWdLxm2C5yWIcwWphLzQT/VgK4k/DSe262ZnlqvWNdf9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699461;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=6HeAXp7yX1tk/C25b06NP0zuPlHPPh/+Hik7J1wwkx4=;
	b=vjxk4/kogrsAvMwLh6nT9oyyDI7aM5hPfnOqjNYwm0N7oTl09iVaTWB6/nFUAMAwp7c6
	 tKSJ2DNQlTU7CTjlTWwGmhT1v9v87Ph+pf2v9tvzwyXL2sfW1okwVUcHxw6QtZD3Egh3D
	 rvn9yMSSIvIDI6WwYvYYDAidiTmXhLdb3B0fM0YT/icKPYd57q7Xa6xDvqzSuprvQh/pz
	 OeIG1Toa6QqaXlAaUFLRkx5XJQPqzfv4TCRqi3vmWtswku4zNlVDM+X2+P/a4IlqADPIp
	 pkoRaS8pY6fuaVTENFnH0R1mBOiGOcP+UgpYqFrUoHMAWcPMkrCoBGTqbjlXCGHMtsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=karaolidis.com;
	spf=pass smtp.mailfrom=karaolidis.com;
	dkim=pass header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=gTIswOwx;
	arc=none smtp.remote-ip=109.224.244.106
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF150606A329
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 09:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF150606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=karaolidis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=karaolidis.com header.i=@karaolidis.com header.a=rsa-sha256 header.s=protonmail3 header.b=gTIswOwx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karaolidis.com;
	s=protonmail3; t=1793699458; x=1793958658;
	bh=6HeAXp7yX1tk/C25b06NP0zuPlHPPh/+Hik7J1wwkx4=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gTIswOwxYUKlWxErWTokOEKDObVzE4bKBY/CclpMYDcrnQpos3B4Chm/GAQYdO9ne
	 NCFU0Nm/1acbnYIthTxWyYkezlUio/rHrN/azR3xwQEZMaNqLXJKpWBSme9JxsDdaw
	 V0dbE/uGxqH3/S0wBEoxxPbZ0B2UmuqECjGzQDAu1v3bON1zqqm620nPTnzvUJdFs+
	 Of5brxqy7L/afeq3PfYPi+apdJYg++v6cjNoxjdvstDhJp7WM0AUweiwEXIQhxYuH8
	 43h9QzoQUBw0aYisHyXYYPyh8zDBRKigXj4AzQM9r4xH396hHJH7F+YiC6LKeX3nIc
	 kGnJU8S/ELKsQ==
X-Pm-Submission-Id: 4jJkN811Fsz2Scj6
From: Nikolaos Karaolidis <nick@karaolidis.com>
Subject: [PATCH RFC 0/6] virtio-mem: support memmap_on_memory
Date: Tue, 03 Nov 2026 09:50:06 +0000
Message-Id: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNj3bLMopLMfN3c1FwQzk0s0E0zTk02N7YwMjc3SlEC6isoSk3LrAC
 bGa0U5OasFAsRLC5NykpNLgGZplRbCwC08b65egAAAA==
X-Change-ID: 20261103-virtio-mem-memmap-f3ec7382772d
To: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Oscar Salvador <osalvador@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, 
 Hui Zhu <teawater@gmail.com>, 
 Georgi Djakov <georgi.djakov@oss.qualcomm.com>, 
 virtualization@lists.linux.dev, linux-mm@kvack.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Nikolaos Karaolidis <nick@karaolidis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3925; i=nick@karaolidis.com;
 h=from:subject:message-id; bh=NNPpcglNLpTNsJShxSz++7ZYM10avVud+ofnAjWB9aY=;
 b=owJ4nAFtApL9kA0DAAoB2mjImL9M9YgByyZiAGrprndObZ4nJcHkyOGnR8X98GzRHnZPY00og
 5ZdyhePWdMUsIkCMwQAAQoAHRYhBLMZG7EWqsMYjymWX9poyJi/TPWIBQJq6a53AAoJENpoyJi/
 TPWIl/cQAOEJLHdPO99uWz96izDeMCElaiPsorxDa1dY2D7aoG+gVGFyjbiVLoPG9ccyV1X8GgC
 87APtvVTOGWAICVzNMI0UPWriIepArKYeYAc4lBS+3NAYLHRT4/MLnOtyM3+L8309oIOtWqqGar
 STGxvYP4Mu/EjXRXgFqg6x88Yps/JzPTJX6kKzl7djrtOi/e29OebonxeqcTSnaDQVgKERsH4+e
 idJTNqaGL+oCQMJFGD6xzdqeNOoMJF0SnhSS6okBcXzUOhJq0LUUYMIW5Y2XU26bZ9sgw2fTEPv
 ILJ9/LI0xqeNBobSe3mYGTqv87IWSHaHiM/Y3Ua7sKQ11xvuGB0B9gzRTEh+A/hoQa96hLsXuTo
 6satoUNqNKdss39D/7karpqARuukEM0TJowUmDXgcpDyRa0TbaTL2yuORmsZrSJWvdyaAPMYSyX
 7nozNOBTetb1iZoBDllZqEGy4SLiJzqbweJMPAR44VrLXUQsqgKPDuSjWZw5Bd0DWprJcMABQBJ
 PATSor2IAhktB3UF9AoNqLs3PO9hWpzb7/8Fmkkp1oIMHpdtcVal1e3uR7VduKLW9QmJFZUB/Qe
 zz++rHq/JxPYPxJb9tDy9nR8zT9oQg6P7r/CyBFWdyUCitOiOeSrPA5kJ/mxLafm00ve7nFBY92
 vwP46+z4AtqoCW2pzw+clRg==
X-Developer-Key: i=nick@karaolidis.com; a=openpgp;
 fpr=B3191BB116AAC3188F29965FDA68C898BF4CF588

virtio-mem adds memory without MHP_MEMMAP_ON_MEMORY. With the memory
onlined to ZONE_MOVABLE, a VM that grows to many times its boot size
can run short of unmovable memory. I ran into this while working on
a guest-initiated memory negotiation project.

David wrote last year that memmap_on_memory support for virtio-mem had
not been worth the effort, because virtio-mem adds memory in small
blocks [1]. Each block is small, yes, but the memmap adds up when
scaling to many blocks.

This picks up Hui Zhu's RFC from 2021 [2] and follows David's review of
it [3][4]:

1. Big Block Mode first (patch 3). Since commit 6b8f0798b85a
   ("mm/memory_hotplug: split memmap_on_memory requests across
   memblocks"), the core uses one altmap per memory block, so this also
   works for big blocks spanning several memory blocks.

2. alloc_contig_range() with pageblock granularity, so subblocks can be
   2 MiB: done since v5.19 (Zi Yan's series, 448b8ec3bf11).

3. Sub Block Mode only if the memmap spans complete subblocks (patch 5).
   With larger device blocks, the driver warns and continues without
   memmap_on_memory, as David suggested in 2023 [5].

The other review points on [2]:

- Plugging more than requested: if no more than the memmap subblocks
  remain to be plugged, the driver stops short of the requested size, so
  this doesn't happen.
- Error handling: if unplugging the memmap subblocks of a removed memory
  block fails, the block is left in VIRTIO_MEM_SBM_MB_PLUGGED and
  virtio_mem_cleanup_pending_mb() retries.

Georgi, Cc'ing you as you mentioned out-of-tree virtio-mem patches that
use memmap_on_memory [6].

Tested in QEMU/KVM (x86-64 guests) on v7.3: 128 MiB, 1 GiB
and 2 GiB memory blocks; device block sizes 2 MiB to 1 GiB;
ZONE_MOVABLE, kernel zones and offline blocks; force_bbm;
memory_hotplug.memmap_on_memory=force on a kernel without THP;
grow/fill/unplug cycles with memory held during unplug; 600
offline/online cycles from user space; random resizing under a memory
hog; injected failures when unplugging memmap subblocks; the
memory-hotplug selftest; virtio-mem as a module, reloaded. Also with
KASAN, lockdep, and DEBUG_VM. Built for x86-64, and the changed files
for arm64, riscv, and s390.

An LLM was used to review the series against the core, write the test
harness, and draft the cover letter and changelogs. I have reviewed all
of it.

[1] https://lore.kernel.org/all/1efcb368-fcdf-4bdd-8b94-a705b7806bc2@redhat.com/
[2] https://lore.kernel.org/all/20210623115839.3524-1-teawater@gmail.com/
[3] https://lore.kernel.org/all/CADFyXm7Ky+S2gq5ht2h_tX9bLsoOSuctCkG==VYAH0uUHGp+QQ@mail.gmail.com/
[4] https://lore.kernel.org/all/bc36b6fe-0d1a-6fe2-e8f3-49bbcaebcf41@redhat.com/
[5] https://lore.kernel.org/all/1bf30145-22a5-cc46-e583-25053460b105@redhat.com/
[6] https://lore.kernel.org/all/fb932d7f-0ba7-415d-ab36-e948d2bbb537@oss.qualcomm.com/

Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
---
Nikolaos Karaolidis (6):
      mm/memory_hotplug: add and export mhp_memmap_on_memory_nr_pages()
      virtio-mem: prepare memory notifier for a self-hosted memmap
      virtio-mem: support memmap_on_memory in Big Block Mode
      virtio-mem: move virtio_mem_sbm_try_remove_unplugged_mb()
      virtio-mem: support memmap_on_memory in Sub Block Mode
      Documentation/admin-guide/mm: document virtio-mem memmap_on_memory

 Documentation/admin-guide/mm/memory-hotplug.rst |  18 ++
 drivers/virtio/virtio_mem.c                     | 268 +++++++++++++++++-------
 include/linux/memory_hotplug.h                  |   6 +
 mm/memory_hotplug.c                             |  15 ++
 4 files changed, 236 insertions(+), 71 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261103-virtio-mem-memmap-f3ec7382772d

Best regards,
--  
Nikolaos Karaolidis <nick@karaolidis.com>

