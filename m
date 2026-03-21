Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86366261B98
	for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774105452; cv=none; b=h0mg2V8MWknHlz5f/QTpDvvyqEqQKeKiDpNtgq1rXjCA0FrdaxS8NNelXN54c07Xc4IXKs5L+G1jEENM+P2wajZb+oggN8LUx9BOTxco6Edmm3mmys68/Jew6R+f8ISwwo/d/oRv7EsyKPl7UBK9kg0LbJGv7M29WDeViFPSHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774105452; c=relaxed/simple;
	bh=aDELlooxNdwnVkBOav2pG7nLNFo7hMZ9D//B2Ne87+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSMkt6rj4i5gighSOZB/Jp5Z4HCPzsXtzOsiBF9xK354gHgrHVOwxvCl5Xm+hT3qzTPlQ8Ok2ug7zwwgl5SkzzpZIiTQDkN2W4niu8S7tCz9/Yelq5KAts/lX6uhO8Gmo68MCiZvuLCa2R7etgUXzzbrYj9iLyXWMR5rUqL+oW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DEu/f8k4; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DEu/f8k4"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-950c41532e1so1465508241.1
        for <linux-cxl@vger.kernel.org>; Sat, 21 Mar 2026 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774105448; x=1774710248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81HYMZ3vgCAeT6eFRo3fsP2FLDXA0ujBDRYZ8Ob/cJk=;
        b=DEu/f8k4q++Fv9YwpZE/Tv5ZfqM1WenYwre39Ghq4c0iL41utjSEwJBgz3onCy0ApA
         F2VbVz3b/XYSp5lFJDjSq0OIv79zNp/WS5GOv6JC4saPfpqbZCzprGPWTw5oNT0v+vs8
         Tad9e6yQbs6n/+j8rCjnBW7OqPys/07r/oEuR+EB9S8V5Vofs/JMexzm3ZW5vbP310BT
         PsdHBthiH8R+f5c09n4CmWbTcgiYkgvibmiRRPOXOUE9dKcZBcLGZ0mt+feR/tHdkiix
         xkLb2VdnuVupfcjUEUjLVRS/ihTYyT1XjiSfso0lMrvxlZqY77v7HaPDJKZsuR4T5dp/
         JqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774105448; x=1774710248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81HYMZ3vgCAeT6eFRo3fsP2FLDXA0ujBDRYZ8Ob/cJk=;
        b=eZYV+iAoG4A/Ei1PF8RDy/bOsBSJBXhuXLQS1oGRq6VdF6qnU6b2R2MAhfRBpzw4fK
         +GfL24xkieQprxqZbxD9nSBQnHbbULq71OZqcZk34I8YbrpyMh5m0qTcsUd9Q+s4Nflz
         VbdDGItj+2yOW1bkndKZPEyZ6spAEgn7pC2WxgojZx83jUGZ2Ic4kNqMd7OSepj5YWTb
         j58CTFnGBZRL4dz4bXOztoY6XM5aHCZ7kWrn98c3WZbDnY+dHn1KQdjn/LbjzWqHD0vg
         Me7+AYo1zAKRy/fbr5hOHPrOEXghNmlxlCS/5d6vLuEHG3ztljHTHh6LiGHymNGD4vKz
         37yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgn54+VGw46BGHLxiXWznUq+99tvMoLQDkQ37pb8piMBEEpyMGpL7MoT0xApJW8EaSwOPuD/253nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJ32P6514LBMPhAy2UzrWJZtl1pUj/T3ltctV2hQTxhk0oVba
	Sex6uNzKeerCzoE0CqW02SJmkhGkPQ3XRB5yXqIUiCttb7/jgWOcVaUtKFNJmNZ2foE=
X-Gm-Gg: ATEYQzzYxncxWk4eAp1EYcbL1zlSe546UKXvAsqm1q1BUZopRfCDR7wmgAbEmqAFwMW
	ytvKPwY87KMphTGF2Jm7CRm+Mi7XUQ4wpZcWMXzmyVb+0vMnG6DgT7++x46W98w9rIn9Bt2EPYa
	rN5yj5tPyGgPJlSDSbP0g84WvFQEEpciUPdxxHH4U8PCxJDi0WhXGKE5q7yjk2eQOA9cCbYN+sf
	AUe6wLy1RrayrE2qhJSCMjlBrvhj1qoIhY/IlSV/BjJIBtfSnKq2mBSvicKaaZyL71Cgk6sL00g
	bKCydGusqZkVNQtfEBIzDRXrVpBkTqD+jbihPbdpG0yJJyHwFZXTRo/zTKDSm9WA4ZFQGUhuZuu
	HtSvkZ5HToJ7URgWf92aDUalsewgaLYHlHdwxc80c3cjUgot5uqc5QO9vMGBZWgDwR2FF7vO2e4
	b4x4k9yS6h4MpExfiywrZnMgG8+nXK5SJBhYCRWCVtDCD3k4jS76/E966t/whpmTySrxOBXvF6e
	45fR5GKpmCRlB/iZVOInMmS1g==
X-Received: by 2002:a05:6102:5989:b0:602:79ed:643c with SMTP id ada2fe7eead31-602aea8cc48mr3376178137.7.1774105448304;
        Sat, 21 Mar 2026 08:04:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90ba89fsm391979885a.40.2026.03.21.08.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 08:04:07 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	osalvador@suse.de
Cc: dan.j.williams@intel.com,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/8] dax/kmem: atomic whole-device hotplug via sysfs
Date: Sat, 21 Mar 2026 11:03:56 -0400
Message-ID: <20260321150404.3288786-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dax kmem driver currently onlines memory during probe using the
system default policy, with no way to control or query the region state
at runtime - other than by inspecting the state of individual blocks.

Offlining and removing an entire region requires operating on individual
memory blocks, creating race conditions where external entities can
interfere between the offline and remove steps.

The problem was discussed specifically in the LPC2025 device memory
sessions - https://lpc.events/event/19/contributions/2016/ - where
it was discussed how the non-atomic interface for dax hotplug is causing
issues in some distributions which have competing userland controllers
that interfere with each other.

This series adds a sysfs "hotplug" attribute for atomic whole-device
hotplug control, along with the mm and dax plumbing to support it.

The first five patches prepare the mm and dax layers:

  1. Consolidate memory-tier type deduplication into mt_get_memory_type(),
     removing redundant per-driver infrastructure.
  2. Add a memory_block_align_range() helper for hotplug range alignment.
  3-5. Thread an explicit online_type through the memory hotplug and dax
     paths, allowing drivers to specify a preferred auto-online policy
     (ZONE_NORMAL vs ZONE_MOVABLE) instead of being forced to the
     system default.

The last three patches build the dax/kmem feature:

  6. Plumb online_type through the dax device creation path.
  7. Extract hotplug/hotremove into helper functions to separate resource
     lifecycle from memory onlining.
  8. Add the "hotplug" sysfs attribute supporting three states:
     - "unplug": memory blocks removed
     - "online": online as normal system RAM
     - "online_movable": online in ZONE_MOVABLE

Transitions are atomic across all ranges in the device.  Backward
compatibility is preserved: probe still auto-onlines when the configured
policy matches the system default.

Specific notes for maintainers:

I downgraded a BUG() to a WARN() when unbind is called while the dax
device is not un an UNPLUGGED state.  This is because the old pattern of
toggling individual memory blocks is still used by userland tools, and
will disconnect the `hotplug` value from the actual state of the overall
memory region.

Unless we move to deprecate per-block controls, we should just WARN()
instead of BUG() as an indicator that userland tools need to be updated
to use the new pattern (the old pattern is subject to race conditions).

The first two commits are semi-unrelated cleanups that conflict with the
changes made in the refactoring commits. (memory-tier dedup and align_range
helper). These are intended to be used for future cxl region extensions,
but if you prefer them to be dropped or submitted separately let me
know.

This is technically v3, but the patch line has diverged considerably and
I've reworked the cover letter, apologies for prior obtuseness
Link: https://lore.kernel.org/all/20260114235022.3437787-1-gourry@gourry.net/

Gregory Price (8):
  mm/memory-tiers: consolidate memory type dedup into
    mt_get_memory_type()
  mm/memory: add memory_block_align_range() helper
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: export mhp_get_default_online_type
  mm/memory_hotplug: add __add_memory_driver_managed() with online_type
    arg
  dax: plumb hotplug online_type through dax
  dax/kmem: extract hotplug/hotremove helper functions
  dax/kmem: add sysfs interface for atomic whole-device hotplug

 Documentation/ABI/testing/sysfs-bus-dax |  17 +
 drivers/dax/bus.c                       |   3 +
 drivers/dax/bus.h                       |   2 +
 drivers/dax/cxl.c                       |   1 +
 drivers/dax/dax-private.h               |   3 +
 drivers/dax/hmem/hmem.c                 |   1 +
 drivers/dax/kmem.c                      | 457 ++++++++++++++++++------
 include/linux/memory-tiers.h            |  34 +-
 include/linux/memory.h                  |  22 ++
 include/linux/memory_hotplug.h          |  32 ++
 mm/memory-tiers.c                       |  29 +-
 mm/memory_hotplug.c                     |  67 +++-
 12 files changed, 501 insertions(+), 167 deletions(-)

-- 
2.53.0

