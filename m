Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6D292901
	for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066928; cv=none; b=tEl1Zbge/VBmX2+Z/iGCuiREtU4A3fZE6a7wrMxXR+4FceS/FMnC4kgM8d0xQyFQk1AovHf/3BFHlGAAahlTcMU6fGpDej28gV0NmUsrImhSa5JN7D1vCd3KisXE5VpppkXY9VwRKCtTn/mWCoAcAgCvX6/QZYNybPhK34GyGDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066928; c=relaxed/simple;
	bh=C+4bukmEyuUogjFKJzPVkC+0PLpktTTguS9gLaYvHGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S33rnCU8zCFMUgy9TXSJULCobYgc9NooZKvXqQAdcG94YRzRgC2iUIxLemgBF3rS9iUUT3YFo279f3y50/Pr18jLs6gV691MDW+Kqby0BLpZ+yqD7WCrmKwXyn3ZGD+aIeF1/x/Ei6kKjSOkIP9uIqSkTGOLAfws/EgG8ZWaEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j1uN6XYM; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j1uN6XYM"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c55500cf80so469420385a.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747066925; x=1747671725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTTxOKtOTvxz/X6EnOnjuA5x3BeIonRn1m9gLvf8T78=;
        b=j1uN6XYMkXQr1Ef4pnhT81/B2aFvhR9IYRwrf7OnT/XdMNgSgJGFRJkgqB6Ny4p3v0
         qEVcEuzodEC/5ZhaSueNRmjlDlLK35QiycRkZ25q9AkOFaLaG5IdeyYRNe8AWE9OmxHt
         Yiqgj6iJ9cbYk5NvlOC8yDj/X98NXJt/REQKaxmtLT/c0BDSp4yhpwoBAqeiKwqZh6Hi
         4F4IZVKyP50dNN59WnNpKu/PWcnng0rujfZCzBG2kfF21S5B3wpg1QaFiqDB20cKDmFF
         lcF55ErNc2mUL+07j0T4ptplrOTQK1pek68V5kpxRtkSqor+eG9hyBEOiWWm1tuOo50u
         Wvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066925; x=1747671725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTTxOKtOTvxz/X6EnOnjuA5x3BeIonRn1m9gLvf8T78=;
        b=veczBvNg7HCiUIESoFLQjI8MWT4CNXdcPiuYqmWMXcxr+h2KqQ9RTXTZQAVNvCdcG0
         0YMy1Rgp6EvnOI2YfqCWi8ENEPOVMBpZTkV6vLnieY44LQmOP7snLti91aNgGmFKiY39
         xxVVNCxJ1p1fSYtt2ijcwHR/MXc5UYqaj8WLSvSKEgsYSUnMeTjPNpfvy8ZlMTFxa9pm
         lsILLxgtYt2BX+v/CmO9QQy5rPbtyab6ixlW8wgvoF5s49bFWw5s6ieGLkxhNj5KwA6a
         +5XjsrEQuT1fsZSBI+F1FEl514JK/LibcVrj/KdaX2IQjPCOS+WT3mRzA9KY+2GQjuv5
         Px4Q==
X-Gm-Message-State: AOJu0YxdleEwWkpY6SQKfXR9kojumKkxhGRw8R9MOls9uF9bq2+B5fdy
	WqhF/YFeu/hJI7oFW9MpuihqvE+OoWJHc5aKCP1zO/rzsBvtRWnm4TlxM55iEjiezAnzU8vlSi3
	4
X-Gm-Gg: ASbGnctyWvh88+751aBtfiW/PZo40kFR/6gYkOZVZolcyOJSZgT3847aOxyZtlD9pTT
	7O6QuQhRhBO/HSoXrZSkx5cQdr/qbM4MypAyDZiCdCRCPhpb6iEZBuwp7W4BH2iRgJOCRre6l/Y
	gSHxfYPSHhhTz9iFY7vusDH7RoFqPUVgLpTnvs17wd+VAa4jnN/3Nq//AZyYeziuo7b+G+tuTMw
	3K303uQakmQz4EmMnmZfCt4HiCdrWP1N63aUpSxb19SThHr1MN4cCCXIZMAX40BhKHuYi69kHlM
	QM48T4Vaky2Ghp7l0J0EbEDnRTG7XHGW8nvfTPX113wQY17jyDBpYxzLywrrPZUGBRiJx9o4Se/
	ibGOB3aEA+MhJd9LXqAjLjL7i+rnWZVElou/1
X-Google-Smtp-Source: AGHT+IHV0UN/KhozVIrARpAytA6jarV108Aoyqsz27PknFZSu3HGQ8itoHJAY+cqjXAR3dS9EUlrqQ==
X-Received: by 2002:a05:620a:4403:b0:7c5:9a6c:b7d3 with SMTP id af79cd13be357-7cd01157590mr2261077885a.37.1747066924959;
        Mon, 12 May 2025 09:22:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583961sm52461791cf.58.2025.05.12.09.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:22:04 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [PATCH v3 15/17] cxl: docs/allocation/reclaim
Date: Mon, 12 May 2025 12:21:32 -0400
Message-ID: <20250512162134.3596150-16-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512162134.3596150-1-gourry@gourry.net>
References: <20250512162134.3596150-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document a bit about how reclaim interacts with various CXL
configurations.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../driver-api/cxl/allocation/reclaim.rst     | 51 +++++++++++++++++++
 Documentation/driver-api/cxl/index.rst        |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/allocation/reclaim.rst

diff --git a/Documentation/driver-api/cxl/allocation/reclaim.rst b/Documentation/driver-api/cxl/allocation/reclaim.rst
new file mode 100644
index 000000000000..f40f1cae391a
--- /dev/null
+++ b/Documentation/driver-api/cxl/allocation/reclaim.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+Reclaim
+=======
+Another way CXL memory can be utilized *indirectly* is via the reclaim system
+in :code:`mm/vmscan.c`.  Reclaim is engaged when memory capacity on the system
+becomes pressured based on global and cgroup-local `watermark` settings.
+
+In this section we won't discuss the `watermark` configurations, just how CXL
+memory can be consumed by various pieces of reclaim system.
+
+Demotion
+========
+By default, the reclaim system will prefer swap (or zswap) when reclaiming
+memory.  Enabling :code:`kernel/mm/numa/demotion_enabled` will cause vmscan
+to opportunistically prefer distant NUMA nodes to swap or zswap, if capacity
+is available.
+
+Demotion engages the :code:`mm/memory_tier.c` component to determine the
+next demotion node.  The next demotion node is based on the :code:`HMAT`
+or :code:`CDAT` performance data.
+
+cpusets.mems_allowed quirk
+--------------------------
+In Linux v6.15 and below, demotion does not respect :code:`cpusets.mems_allowed`
+when migrating pages.  As a result, if demotion is enabled, vmscan cannot
+guarantee isolation of a container's memory from nodes not set in mems_allowed.
+
+In Linux v6.XX and up, demotion does attempt to respect
+:code:`cpusets.mems_allowed`; however, certain classes of shared memory
+originally instantiated by another cgroup (such as common libraries - e.g.
+libc) may still be demoted.  As a result, the mems_allowed interface still
+cannot provide perfect isolation from the remote nodes.
+
+ZSwap and Node Preference
+=========================
+In Linux v6.15 and below, ZSwap allocates memory from the local node of the
+processor for the new pages being compressed.  Since pages being compressed
+are typically cold, the result is a cold page becomes promoted - only to
+be later demoted as it ages off the LRU.
+
+In Linux v6.XX, ZSwap tries to prefer the node of the page being compressed
+as the allocation target for the compression page.  This helps prevent
+thrashing.
+
+Demotion with ZSwap
+===================
+When enabling both Demotion and ZSwap, you create a situation where ZSwap
+will prefer the slowest form of CXL memory by default until that tier of
+memory is exhausted.
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 7acab7e7df96..d3ab928d4d7c 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -46,5 +46,6 @@ that have impacts on each other.  The docs here break up configurations steps.
 
    allocation/dax
    allocation/page-allocator
+   allocation/reclaim
 
 .. only::  subproject and html
-- 
2.49.0

