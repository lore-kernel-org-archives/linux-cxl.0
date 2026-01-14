Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ABE35EDA3
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380761; cv=none; b=kCz3YX8XoWHMHJg7py7jeMPzJHqRaqbFdA9UDygQof0dJ8FIwLLxzJxt7FE8xEA+Gbn2lhskyeosBiSY+cLyYhEg0Q5DtZFhDDVBdmECd0429Npp+IqRtCNr4p3NJF3ZmUjKDZibos3CEeTkgqksfGDoPhqhoLn/sVxtAZHGWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380761; c=relaxed/simple;
	bh=6Gf3O1Z46A6A3V618QjzgUC3TwEE6jvcWp4vN0GZKB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ch8xM2a50Tea8RffFlQeUbWY821EPvW6+9EsibNQRWxkGxCkZ9SHlZ+WMeoSn8ZgEaU8G0YYixxGDzX3bTBSF7ZeXcIPIbkznSZ4WAKA5MwYO2JDJg49aIbY85pnKMcpmp7cRYRVdOvRDqzuZHVDMY6EOZGgHVt5Kh7ph9J3PAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=O2hoKtaI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="O2hoKtaI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5014d4ddb54so2528541cf.1
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380754; x=1768985554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uI7G8mzCwfWt6hpevWSKMuVc2LUYnlWS3FX4pvAwGI=;
        b=O2hoKtaItOCsK9mrWDpcidNF6OXZw4nRid3syAN8ZHCBX8G28XEjz6h9VzsQD+FyQI
         mIPtqMbDU0Zsx8TnhgpQcMZyMFYVtgWeTpC25h1u/za5Gmz3RWrEuuzuBHYXDtmPE0Nw
         3ccwaG+UXmfiFnXJ88rFSSB0Z+yyTEZd6qFDxftOdaL4caFhpSFIR2lcLgIL7bhZOnyW
         AeuySrrnhQZBYvWEW8MTLa2NTrDkpOWWGwc20+vojowJCnRGjwyo5vlL6UAuv6/dBfCA
         rWdQcm0A2AHrQMZw3o0KoFJFVSxEQ/7swQnUGEtm4YQGf4vZBvVNrf49r1OD4BtF5YVe
         ilAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380754; x=1768985554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uI7G8mzCwfWt6hpevWSKMuVc2LUYnlWS3FX4pvAwGI=;
        b=B6lMUYpwWND5P1ITFi6Aw3SBC+tw4vdFMbr+b1TYnlk5P6NhCcH3k/C4RFfZsLXDe9
         X6HxRuBs9OMTLFZkiupHPXJHjTM3IWL0/+AOArd7NnXDpLKOuxyyzjiEPCB6wyZ2+rxV
         184LsUxagn6s64rt6NL/EQHrKrfJ59e1X79vPI+m6Q5FhTbyT3WzL6mI2qLD/DICfs6Y
         /RbF7Jvmp9tRshQRB1BOYUhHK+g5wGDRJrMObwNlmKfwQLtK828ZJk3lc1SeDajwEpyk
         FW3l6o437bmGVX4Tg41HYMFeiKUA5CP3ko8AWplJqysWw0St73S+tGyPqDxfY/iHfaTV
         +j3A==
X-Gm-Message-State: AOJu0YwnWeozeYNxHq8Zl+N6EOqrrJg4sbjOn1vyTW3dTd+bSRfTHPWz
	IuprfYhXPgbtRZh62LO+pyzZJol7zy1GpI46rbEw3rQwxgCOJyPvAatstszxaqKSj4I=
X-Gm-Gg: AY/fxX4e0k2h3Ii11luUqhLM1edkzAN8Jj82deKFvY6RvhuQp9wLanBWYkjJ/PvYx+y
	aXXDjMHvhOBAiB3booGrsfoHEWsTpJE+0G1/A7uq5yoTC3gaNHKEb4pouWU5N6oDuDS6ioeDCRt
	B+tttX2bXMvl2E8Qw+yovyksrmVVfQjdhiESrzW+bv7Vcu9k9xSktHbWpGmKfDNzNnlGkAcEhKw
	7n/OgHjO4UWGWwrPXEFL3r+1dBmTf6GDmWjZTwGZyLbB+zoFfWv1hhm9kBmfkstHwYPBebKKMsP
	VTBcmN0cORjaG/+ABQRw/NRN2tYgtSXZmX8nHlyw9H8doo37teAqbppR8UjVxR4EYr/ZBTYQOiB
	A2Vrr9OYeW3DwJ9Z1e6GJW/Zr1BB8tdR3I7dXHyCVrwV2hXWyNg/ZgMY4aJC37aXYDmIagXDn8f
	vabjfDF75d1AHbBFiRrusYQG6yi8xZ0Oy4lK9k9vVK6F5vr8vVDFmvceaBnFMF6uVq75NEshtAE
	ls=
X-Received: by 2002:a05:622a:58c5:b0:4f1:ab46:8e36 with SMTP id d75a77b69052e-5014a905f74mr11547531cf.9.1768380754428;
        Wed, 14 Jan 2026 00:52:34 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:33 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: Subject: [PATCH 0/8] dax/kmem: add runtime hotplug state control    
Date: Wed, 14 Jan 2026 03:51:52 -0500
Message-ID: <20260114085201.3222597-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the ability for the dax_kmem driver to control the
online/offline state of its entire memory region at runtime through a
single sysfs interface. This eliminates the need to manually iterate
over individual memory blocks when changing memory state.             
                                                                                                                                                  
Problem                                                                  
=======                                                                  
                                                                         
The dax_kmem driver currently provides no runtime control over memory
state after probe. Memory is automatically onlined using the system
default policy, and any subsequent state changes require userspace to:

  1. Enumerate all memory blocks backing the dax region                                                                                           
  2. Individually offline/online each block via
     /sys/devices/system/memory/memoryXXX/state
  3. Handle races with auto-online policies that may re-online blocks
  4. Coordinate offline+remove operations across multiple blocks

This is error-prone and creates race conditions between userspace
operations and kernel memory policies. There is no atomic way to                                                                                  
offline and remove an entire dax region, and no mechanism to prevent
external interference with driver-managed memory.

Solution
========

This series introduces a 'hotplug' sysfs attribute for dax devices that
provides atomic control over the entire memory region:

  /sys/bus/dax/devices/<device>/hotplug

The interface accepts the following states:
  - "offline": memory is added but not online
  - "online": memory is online as normal system RAM
  - "online_movable": memory is online in ZONE_MOVABLE
  - "unplug": memory is offlined and removed

The driver handles all memory blocks atomically and prevents external
state changes through a memory notifier that blocks operations not
initiated by the driver itself.

Series Organization
===================

Patches 1-4 refactor the mm/memory_hotplug infrastructure:

  - Patch 1: Pass online_type to online_memory_block() via arg
  - Patch 2: Extract __add_memory_resource() and __offline_memory()
  - Patch 3: Add APIs for explicit online type control
  - Patch 4: Return online type from add_memory_driver_managed()

Patches 5-8 implement the dax_kmem functionality:

  - Patch 5: Extract hotplug/hotremove helper functions
  - Patch 6: Add online/offline helper functions
  - Patch 7: Add sysfs interface for runtime hotplug state control
  - Patch 8: Add memory notifier to block external state changes

Backwards Compatibility
=======================
The driver uses MMOP_SYSTEM_DEFAULT at probe time to preserve existing
behavior. Systems with auto-online policies will continue to work as
before. The new sysfs interface is additive and does not change the
default probe behavior.


Gregory Price (8):
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: extract __add_memory_resource() and
    __offline_memory()
  mm/memory_hotplug: add APIs for explicit online type control
  mm/memory_hotplug: return online type from add_memory_driver_managed()
  dax/kmem: extract hotplug/hotremove helper functions
  dax/kmem: add online/offline helper functions
  dax/kmem: add sysfs interface for runtime hotplug state control
  dax/kmem: add memory notifier to block external state changes

 drivers/dax/kmem.c             | 645 ++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_mem.c    |   8 +-
 include/linux/memory_hotplug.h |   6 +-
 mm/memory_hotplug.c            | 139 +++++--
 4 files changed, 678 insertions(+), 120 deletions(-)

-- 
2.52.0

