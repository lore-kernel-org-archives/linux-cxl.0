Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D923765
	for <linux-cxl@vger.kernel.org>; Wed, 27 Mar 2024 04:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513014; cv=none; b=gp6APm1q58/xOB1uTMBgHGhHUp9k8Yi9cl1WiaFXYLVsAxPt0nPZdLSkBARSHyo9QqDDEoI4LU6E4SQtJAY7eM3MOiprUhmjM40mVwtJrCUy4ztZ1wIOtEZW9nSeNdG2dBDm8evGVCP8p3tr77p3SPI8VGbkTt/Ep2LqREwZXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513014; c=relaxed/simple;
	bh=zcsNrVfji+EEPmbTMnRib8noXYuBhV9F4dhJWkO7jpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=er19H8wbakIf2XatEnSH+0q29WAe2km9w1OhkJtDka+k6qQq8iFleIDEB2gOj5rDA37AuyvRL3KM4dtAqT97wVeDE0z4gxHAdEYLD76WcWFWk+DPMYSq6I5jYK6b6I0rYjYxPeqnDXLCqBiojw9tntWrfGSSb1vMt9yZs4wum1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BvJrjiuz; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BvJrjiuz"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430c63d4da9so44654311cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 26 Mar 2024 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711513010; x=1712117810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wMdVp0KhU9BZV6tV0/g9FLJmEvDvjHVVK/qsvqbWJ7I=;
        b=BvJrjiuzjdl4nbixdUKeAR81PJgx6qef1U1toS2O0IfHDXviWVHO71GWoKDEtuVsgG
         ZxHGheX33SPOhV6tzupeAWI3oPw76l7gMofSjAgiJNwvwIpNypI8ACjrXN/dg5FA2eQw
         zZq752vxKupinF1RGHRDn/sMVAqk0IgPetzQfaaDbQArtvATROxWHxxNSPxq1QLuDEL8
         qL1lFA4NtZSa0hWxLKfbYH0vCyrr8IlK8E3sPdgae4/DotmqCQIeNgWKYPFjBaNLqbSt
         wNsHmNMq74SkqdL6cy0SnpsDyaDSyoHC5IEf+qqPr6iqAVd0swVu04N1048XwGx+wNpV
         3Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711513010; x=1712117810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMdVp0KhU9BZV6tV0/g9FLJmEvDvjHVVK/qsvqbWJ7I=;
        b=U1QFPjWgvYkDGBrUULr+mANlsPgJi51CbDz6r33PtVgM24e02++RaZNDps6Z1s79iS
         CpF14HYVXkx+bFOoys5MNmTNoAeGHnf/PsFxacJYu9JCHiwsNrWlw36OgbrciaLyzhlZ
         qhp5muu3QUTX5Clt/Vm2uDjCzWEVoabk3hkMzhSEKHT85UKqYS7ttjX2iyOH2/SShKqX
         2hPqTsD1wSZhPl+Rlm24BO7QVQ4peS3mxqBh4cMaon/8T7USBZisECbt1ju3E/FOkawf
         3PlVWQbrd+dspHMGH9wgXjcH3wIqCZApDZS18dGo9HzW3cWhbHm1F5N9vX/Ale33omLd
         DSJg==
X-Forwarded-Encrypted: i=1; AJvYcCUZS/e1apfqf6NT4hnvsmRqliER9wnGNwWvEaBzNy9K8GkpF90WG7WdVEhsUVurWCKGMcPQ1y/nUcTMSsbbxl2X2m0OtPDL8LtN
X-Gm-Message-State: AOJu0YwrA31cA+6Z3+QXigB35EG2UV1MHcqL8x+519mmzPip9sh8K6Ax
	a8en7xBvSslmM+H+wf84DwjUQKF9QHQTBW0X6ULaVR2arhHVlucAkAUzHGb4qXQ=
X-Google-Smtp-Source: AGHT+IFPKIzBXhDWX0vwwecPPOx0TLesoDld5lggWtVvDT+Jl49ZpjG37mTEKqJH3a4f9GmGUE7nhA==
X-Received: by 2002:a05:622a:407:b0:430:f228:5f87 with SMTP id n7-20020a05622a040700b00430f2285f87mr3797120qtx.31.1711513010098;
        Tue, 26 Mar 2024 21:16:50 -0700 (PDT)
Received: from n231-228-171.byted.org ([147.160.184.93])
        by smtp.gmail.com with ESMTPSA id hb11-20020a05622a2b4b00b0043123c8b6a6sm4370696qtb.4.2024.03.26.21.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:16:49 -0700 (PDT)
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
Subject: [PATCH v5 0/2] Improved Memory Tier Creation for CPUless NUMA Nodes
Date: Wed, 27 Mar 2024 04:16:44 +0000
Message-Id: <20240327041646.3258110-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a memory device, such as CXL1.1 type3 memory, is emulated as
normal memory (E820_TYPE_RAM), the memory device is indistinguishable
from normal DRAM in terms of memory tiering with the current implementation.
The current memory tiering assigns all detected normal memory nodes
to the same DRAM tier. This results in normal memory devices with
different attributions being unable to be assigned to the correct memory tier,
leading to the inability to migrate pages between different types of memory.
https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

This patchset automatically resolves the issues. It delays the initialization
of memory tiers for CPUless NUMA nodes until they obtain HMAT information
and after all devices are initialized at boot time, eliminating the need
for user intervention. If no HMAT is specified, it falls back to
using `default_dram_type`.

Example usecase:
We have CXL memory on the host, and we create VMs with a new system memory
device backed by host CXL memory. We inject CXL memory performance attributes
through QEMU, and the guest now sees memory nodes with performance attributes
in HMAT. With this change, we enable the guest kernel to construct
the correct memory tiering for the memory nodes.

-v5:
 Thanks to Ying's comments,
 * Add comments about what is protected by `default_dram_perf_lock`
 * Fix an uninitialized pointer mtype
 * Slightly shorten the time holding `default_dram_perf_lock`
 * Fix a deadlock bug in `mt_perf_to_adistance`
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
 include/linux/memory-tiers.h |  13 ++++
 mm/memory-tiers.c            | 117 +++++++++++++++++++++++++++++++----
 3 files changed, 119 insertions(+), 31 deletions(-)

-- 
Ho-Ren (Jack) Chuang

