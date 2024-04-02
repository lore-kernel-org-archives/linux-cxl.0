Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3579EE552
	for <linux-cxl@vger.kernel.org>; Tue,  2 Apr 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017065; cv=none; b=H+1cqnbvWXWvM8rCE3QEwFtXFJQBm5xALFBnhc6aNJ2/pVM8XvfH0jGQlJ0imEQaZO3HjapwT3TyY/XxCicRHmz0YUfI7Ds3wXJvWwagfahdP9SENAFlOjRyPY2MDR+vBE9I7rw4EUWcgLf3RpF4P970+5OkDx8DJibSXFVFiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017065; c=relaxed/simple;
	bh=SCrDUhEkZxFSPTEl/r8bXpDqiMbz+gOCwj9dhEfB9cc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lkrlwfZ4pmgc9uKjp1vaFLbc4nagKURv8VPBUWlUw/KgL1PvnV3ju1wqAA9FezX7d3eg9gb1rCFgYuSo7E+pDP2bbRcVSxiabnCGRL+kx9LsxlvzkCnj+U5kLQLPXH6E8nkroYQn5Grh046B4Yweg3vd3asdpBJmV8L8TEEq8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DppPx11t; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DppPx11t"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6990dd16041so3402736d6.0
        for <linux-cxl@vger.kernel.org>; Mon, 01 Apr 2024 17:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712017062; x=1712621862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gW68csmOvBMTYM9kf5jTmocSt+5Cfpv4k9wOl9BtKJ0=;
        b=DppPx11t72+V7A0l0F9uCwbUMJ3EgBIJy3TQLpBd9vvlQv+TRQLQ+cAcXeZx/o7s6b
         SpdDZN0dewMSrJgiP+uRfgBwC6AdKXuoFRIXbiRVZ56jVJPi99NmhXl2FPMRL9U5bC7O
         vn3RiPH6D+vdVvYI6bfi/yNO7LDkLy32bzayH+mnZCHRbch1n9HcLl2+S6FS79P7ffo4
         OiCYZD/GgO873tdhxuxut4OpJzbP5XKTMxW+VcnsFPTfuFKpWGyLFFTdbe0YoWwOoG5u
         00OBm/n6OniAr1mgwdWr3h+5W0+SR7WdcR3zXGsAoPpDJ7ob8c4QypMbV10J712BSCNT
         kMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712017062; x=1712621862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW68csmOvBMTYM9kf5jTmocSt+5Cfpv4k9wOl9BtKJ0=;
        b=kfMv3iEgO51dIjhbMV8+WAij6Sua/Z6roL94q1+xo6CGcm9qq/vOR8MciKs39jfgCh
         qy6oC3O6uzqbCBZWSxNbNggoTXdGFh0nKC8uIWbFbZqILLrK9Tr25iQXRUVvZK0dwXj7
         cg43xpBT85KkXy8cHRJlYwFRkBs0iCgXpyRR4+n44r8GAhvCxwBbNLgyU0IBu+Dccqq5
         wINsJ0nE83irWd2wOETwjr+OgY+D7napWr8MgwCm+X+YOw3kRE1maGnSZib5Ds7x7sv4
         eFYdNyIRV5PVxYSxBS26cGAD1HEouQVZceNawjLL6GkHfvweZvERE/wEPe5KqsS7xth8
         innA==
X-Forwarded-Encrypted: i=1; AJvYcCU92uqxe8KmhSyzTyj0VTUtkmNmVjDnpaIiGicq95AAtCK9Fqkz4G5BYkGmoWavTctGJw3TlX13zKK0YwuTGcC54ZDaLKa8y+E9
X-Gm-Message-State: AOJu0Yw+rOMaxmMkprIAVtCFcmqN1K3I6mo8tIuYW7yDK6LSwuH54TY7
	HiCl+4lVHekDSQ/S7XsA9mkk6r+4teFUDt6dUCRQbANIHf3Uzl15GDjqgGkaXbI=
X-Google-Smtp-Source: AGHT+IHI1NovuRSzlyW3MYabIw0PVUmZGVgQf3UfVLAx8wFoGSl+V+dNtBDwUZKth1SSmnW9MKt4eA==
X-Received: by 2002:a0c:f707:0:b0:699:bbd:7976 with SMTP id w7-20020a0cf707000000b006990bbd7976mr3538796qvn.22.1712017062196;
        Mon, 01 Apr 2024 17:17:42 -0700 (PDT)
Received: from n231-228-171.byted.org ([130.44.212.125])
        by smtp.gmail.com with ESMTPSA id e10-20020a0562141d0a00b00698f9771822sm3013112qvd.83.2024.04.01.17.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 17:17:41 -0700 (PDT)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	"SeongJae Park" <sj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v10 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Tue,  2 Apr 2024 00:17:36 +0000
Message-Id: <20240402001739.2521623-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable from
normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes to
the same DRAM tier. This results in normal memory devices with different
attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different
types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the
initialization of memory tiers for CPUless NUMA nodes until they obtain
HMAT information and after all devices are initialized at boot time,
eliminating the need for user intervention. If no HMAT is specified,
it falls back to using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance
attributes through QEMU, and the guest now sees memory nodes with
performance attributes in HMAT. With this change, we enable the
guest kernel to construct the correct memory tiering for the memory nodes.

- v10:
 Thanks to Andrew's and SeongJae's comments,
 * Address kunit compilation errors
 * Resolve the bug of not returning the correct error code in
   `mt_perf_to_adistance`
-v9:
 * Address corner cases in `memory_tier_late_init`. Thank Ying's comments.
 * https://lore.kernel.org/lkml/20240329053353.309557-1-horenchuang@bytedance.com/T/#u
-v8:
 * Fix email format
 * https://lore.kernel.org/lkml/20240329004815.195476-1-horenchuang@bytedance.com/T/#u
-v7:
 * Add Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
-v6:
 Thanks to Ying's comments,
 * Move `default_dram_perf_lock` to the function's beginning for clarity
 * Fix double unlocking at v5
 * https://lore.kernel.org/lkml/20240327072729.3381685-1-horenchuang@bytedance.com/T/#u
-v5:
 Thanks to Ying's comments,
 * Add comments about what is protected by `default_dram_perf_lock`
 * Fix an uninitialized pointer mtype
 * Slightly shorten the time holding `default_dram_perf_lock`
 * Fix a deadlock bug in `mt_perf_to_adistance`
 * https://lore.kernel.org/lkml/20240327041646.3258110-1-horenchuang@bytedance.com/T/#u
-v4:
 Thanks to Ying's comments,
 * Remove redundant code
 * Reorganize patches accordingly
 * https://lore.kernel.org/lkml/20240322070356.315922-1-horenchuang@bytedance.com/T/#u
-v3:
 Thanks to Ying's comments,
 * Make the newly added code independent of HMAT
 * Upgrade set_node_memory_tier to support more cases
 * Put all non-driver-initialized memory types into default_memory_types
   instead of using hmat_memory_types
 * find_alloc_memory_type -> mt_find_alloc_memory_type
 * https://lore.kernel.org/lkml/20240320061041.3246828-1-horenchuang@bytedance.com/T/#u
-v2:
 Thanks to Ying's comments,
 * Rewrite cover letter & patch description
 * Rename functions, don't use _hmat
 * Abstract common functions into find_alloc_memory_type()
 * Use the expected way to use set_node_memory_tier instead of modifying it
 * https://lore.kernel.org/lkml/20240312061729.1997111-1-horenchuang@bytedance.com/T/#u
-v1:
 * https://lore.kernel.org/lkml/20240301082248.3456086-1-horenchuang@bytedance.com/T/#u

Ho-Ren (Jack) Chuang (2):
  memory tier: dax/kmem: introduce an abstract layer for finding,
    allocating, and putting memory types
  memory tier: create CPUless memory tiers after obtaining HMAT info

 drivers/dax/kmem.c           |  20 +-----
 include/linux/memory-tiers.h |  14 ++++
 mm/memory-tiers.c            | 127 ++++++++++++++++++++++++++++++-----
 3 files changed, 126 insertions(+), 35 deletions(-)

-- 
Ho-Ren (Jack) Chuang

