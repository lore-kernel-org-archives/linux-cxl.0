Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F082262D14
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036688; cv=none; b=WK3jTdfXLWX5SuFwTECFHUrCELJ0QJCaI2/BwfBwTf8pXe9FMSK/n8N6P9ZStR1GmGRi6jM241llC35F4s0Z1Z3LuDmpCOxcoJsiY6tqu/1lHXneBJXqA9zDw7kq1rkWCpwzRwxg63IdqpCOPl2kchq+ezG6xTFDwzOZschkLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036688; c=relaxed/simple;
	bh=fSoRlnSmuQfl7ZxHPvsaxZElUPVqtO8ei3VkyP+sGlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW9dq0C/ehHmV0wrqE4CRPEQjqsI1VcJUXnC6CmTsFrIebpDsc+n3JILwodBI+Ohd/iaODJ5yBKOFEiDLQ60dIzxKOZuAj632wWvUjBvXGcpoOArpWWlzBhK5VO/PkOYxTr99erKZtwlrNRsVK0MxbrzOoSlvHlbDevJHWR9Fg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fZzCLFlR; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fZzCLFlR"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c081915cf3so15110985a.1
        for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036685; x=1746641485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tbt8tCPdtGfAIVOyjjS42F8T26gzOQDX+9RCN/0lBgM=;
        b=fZzCLFlRj67Mt2er8z5Aw5Q5JVrmDB6JZFA5ZARFksGaSjqrWzcbdj+0fcCv/911dj
         3FmVCqmjQlO89nzAdJ42VgFaUquyGe7bYwKpK+r0mq2hSjU6ximELepfgKqSUazxZpGW
         nAA9rRG54GkpIjMlXfv6OHU0PEPcoiUWD5V4CIIP/o0Bnka8L1jK2ryHUHDh+qgE7GAd
         0Ey7W68nTyJ6BC3CZX6wP2pVvM5Xrfh0lX7HxI8apFpolJ0c8S56J/qGBNQTSeObiOID
         xXVvI285iWYu75z9hc7sUCxMIP30aZvrYupW3GoHfa/o0d1aDuBy3D9nYkLWjakvQac7
         CxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036685; x=1746641485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tbt8tCPdtGfAIVOyjjS42F8T26gzOQDX+9RCN/0lBgM=;
        b=Ba2gN+L+4CfdHtQ9UdDTA5TQFMRQHwarIN1WAEelOW4pejglyPweJxWrVam1Ow0a6l
         0uDfqO26LdVkBR3rKp/8CLZKw1erkDepyJ5aI+CnI8krj/J7M6wuHzlbP7mHju29q81E
         on8Ib04e1/4hfyJtHOFdt/YJn0qWuTgtRk6X4/OeiRpzvnyAybGab6EdSh1s2oeUbllC
         CzmISV+oPCAMIBvWganPsEOWqfrSFifSoOje4D6ATXhP2x201KfKyEySLbQNYPnNMhgG
         QTwoBKt0Y6WuetX7yVcwOlKkuMz1JEeQlxNmNlOwcsjQv1dczpAbamHo7haXCGY45jIr
         sPUQ==
X-Gm-Message-State: AOJu0YzjsMx3qWEvPNn0bVqGABrmohecJVP65xjBWuBHizFMC8d3ZTbx
	xKteLwfeAe06B0EcQkucBUukqmU+zpReCFBcAI4ArFaSJQGil/9m0oOyZKIAwaWRRFH5i9nYWOO
	+
X-Gm-Gg: ASbGncvpX+5oduy4sSD5AI/GSW7i7ZxHwy4pIEqlw2vGjkQb4lf1PobQ/GbNWxnJTkM
	iP2qHrleDQ5e5hQ2igODTU3EO0HYEsmD1wKVZ7C1lLWUj2LDOV2bPUgCIDtpatqJX+pi4ZSOc6n
	GYvv4f/3btWDEY29bps4Lk9V1q5rgp9pXqa2l9GYywkadFXTaJB9UTkcWB+nvo/+v+/yMrpGy2b
	hUhrsV1TCVjdjRamk1c3OfHEtAdHZkZKdKC8keOLGNnXYbWzJb3v/aBCdoAU2Fc2rkV5LTXgP0h
	Y1p2YfIY8hrajPCJ9wO9QNmRmfNZcWLZA4KrD4DzeQCsxPS/6jFw/MmJnkKDbI1bo+hl2i9GUKe
	dlUariRPTdeiP+w4sMtJQ9MQhldBc
X-Google-Smtp-Source: AGHT+IF7lGDo2V4OWxe67pw6pes0roVjPL60qV8ZkhzEjnVw85shlE47W9reKIhwnUyuTehJMjsREw==
X-Received: by 2002:a05:622a:4c87:b0:476:739a:5cf3 with SMTP id d75a77b69052e-489e46a4769mr63495651cf.1.1746036685174;
        Wed, 30 Apr 2025 11:11:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:24 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/18] cxl: docs/allocation/reclaim
Date: Wed, 30 Apr 2025 14:10:44 -0400
Message-ID: <20250430181048.1197475-15-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430181048.1197475-1-gourry@gourry.net>
References: <20250430181048.1197475-1-gourry@gourry.net>
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
index 000000000000..f37c8b1cc3bd
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
+as the allocation target for the compression page.  This helps prevernt
+thrashing.
+
+Demotion with ZSwap
+===================
+When enabling both Demotion and ZSwap, you create a situation where ZSwap
+will prefer the slowest form of CXL memory by default until that tier of
+memory is exausted.
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 2be2855e5870..a768144698e9 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -47,5 +47,6 @@ that have impacts on each other.  The docs here break up configurations steps.
 
    allocation/dax
    allocation/page-allocator
+   allocation/reclaim
 
 .. only::  subproject and html
-- 
2.49.0

