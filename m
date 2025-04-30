Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C051E1DF1
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745971983; cv=none; b=dnPX3fl2Pe4Q8+lE4QTaxfaKoh7nb0pkt6QHZlFL9t50+lk54bnOHCsttIboveNaG59TDKMcyxlJ40UAd89nZLU4YFOxZBIoIfthp6ijM2Bjt5gPSVRiChKmKptPiWC8WGJsgZUnE+PEP2rA9Lpvu4NEF4boXul1SgBwB47MIrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745971983; c=relaxed/simple;
	bh=od5Us0DmJZn5ET4lRp8ewWoLEj/tIGTNdfUdU5eEZAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skWUpcfsz3VzSp3VT7ritQkVK9eJoBYUPeu0GLdaLqWkZtIYQjRvCaO+NOqYM5bcOKAXl0ZP7iEHc1ohN487g0RgaPeT6A5PaUXUbGQI4YdoLP1E8vLM0eUTqb9oBsaZ57PacHw7P2vJ+6Bx/EnhHtLmikLgsjr1+axhlCrNi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rBW4aMck; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rBW4aMck"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4774193fdffso122586671cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 29 Apr 2025 17:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745971980; x=1746576780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP8IwuTcI0ddxoNDYzSPYNwSxCLdaHiFssczpGgKsDE=;
        b=rBW4aMckVVP6jFgUTXnmgnDDMkKxImvzDCr7MiFyAWCdKqdD2NgI4SHjsiEG4I6b1a
         5a27QwSF8GiavY/JB1n0RO5WsKnRsKkw9umD1H1qlcxrQjJ0hHdb7yVGUEtrJ4gpWBDZ
         h1fT+7jyHtNmA+bhytqAGd3rLzpZdROeI3L7mAK8X0zHrTkjzg1MF3j7mXRTCUSlDDmf
         vgHghdGr/6JH27yTAy28FtrIXmp3Z9cU3egqXnrn0TXvMlJ6kSZbW6uSThAbq6uJllFy
         DgPGacVs6mef218DfILSgh64cYSAhntPgvkHYgpk4tnYRZo/7fEgt2SeWso3ECY7U3tE
         iw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745971980; x=1746576780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP8IwuTcI0ddxoNDYzSPYNwSxCLdaHiFssczpGgKsDE=;
        b=rNUaQnp3/Z3+HIbLOz1SnEvgQeKII45jkn7hvNVj1HV6T3y/r/NrX1w1pSD8WkhDJ7
         kNFni49hz+7KeiU2OMuOR2Lc/CHTkEICG4bL1oKr0Ut0mhU3yhqxqmH0NZUHzCSsxSm+
         +aWZPl/es07jBtW+OKQXu7EK3hYolaltydVfeDHHnCdWUKNIk5U9FovgGhgL/01npO7U
         o3Y8BBPj6N0AenGw47ZWa8gqXF5Fi090b++C7/BCsSRbvRw16xrubQBxzMzVJRKc7jdJ
         6bIGvp/act4a1zx6OMOLzcuu8JOMJAAvDDLZpWaz8hfaJDC5+y6wkA2FmDasLpBKYvyH
         hliA==
X-Gm-Message-State: AOJu0YxhFihlBZWQGjMOJ48SVjd+gE3Hb65YglD8kAM0prU7hzNuwrD2
	2aMfvD8ruyGLPnbmd+Oe9KRjr7sIU19KJPzJFMG++ePgcla6kNpOLZ+NZ34Y5IRwSgqb3WoWjqC
	e
X-Gm-Gg: ASbGnct9X6qrD1ViENIVVJPlm5dECNR3fmYIFworUVqQmGdOg5vX0t2feFQ7Kk9N3h0
	717m3ZIovO3SB63M03gV9U2JqBmUpVouXQp7cGqjn4dLpf6CxkYb9Zt/e3Tyq5qvFx8Kuh8OkSn
	OuI2i+ryG7biZ8fqmD5I6PC7ZbJO/yCk/eVUSK60GvZu+AIvuJzs8/SdOC/zc9w3Lk5NN2ED3jW
	83wT98MTl4L+p49qmAMYKY8nrPFfwRgIyAYwmGvvxIxbiSGnsZCxkMq12CKpjDFU7ls2uwe0zoP
	vH0BYxJMSZxQ/8I02qTfAlU8yw3plzB1gKX//eot7ijRsVUF0HMqkmFkHs6ukVLpwflPhdLn72O
	TeyMsjNDqnrgiKM0e856M826uIDvk
X-Google-Smtp-Source: AGHT+IEulUJ1ZdOBlX0WQlJws5c+EW19ARfMKYcw/63vGp1jBFQt+HKkN0nBlJDN/wRBATMWao2v2w==
X-Received: by 2002:a05:622a:5808:b0:476:86bc:8b41 with SMTP id d75a77b69052e-489e67b4669mr9808011cf.52.1745971980333;
        Tue, 29 Apr 2025 17:13:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7a820esm87634411cf.41.2025.04.29.17.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:13:00 -0700 (PDT)
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
Subject: [RFC PATCH 14/17] cxl: docs/allocation/reclaim
Date: Tue, 29 Apr 2025 20:12:21 -0400
Message-ID: <20250430001224.1028656-15-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430001224.1028656-1-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
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
 .../driver-api/cxl/allocation/reclaim.rst     | 50 +++++++++++++++++++
 Documentation/driver-api/cxl/index.rst        |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/allocation/reclaim.rst

diff --git a/Documentation/driver-api/cxl/allocation/reclaim.rst b/Documentation/driver-api/cxl/allocation/reclaim.rst
new file mode 100644
index 000000000000..deb59422492c
--- /dev/null
+++ b/Documentation/driver-api/cxl/allocation/reclaim.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Reclaim
+#######
+Another way CXL memory can be utilized *indirectly* is via the reclaim system
+in :code:`mm/vmscan.c`.  Reclaim is engaged when memory capacity on the system
+becomes pressured based on global and cgroup-local `watermark` settings.
+
+In this section we won't discuss the `watermark` configurations, just how CXL
+memory can be consumed by various pieces of reclaim system.
+
+Demotion
+********
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
+==========================
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
+*************************
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
+*******************
+When enabling both Demotion and ZSwap, you create a situation where ZSwap
+will prefer the slowest form of CXL memory by default until that tier of
+memory is exausted.
diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 52bc444506bc..e20defe9c20e 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -48,5 +48,6 @@ that have impacts on each other.  The docs here break up configurations steps.
 
    allocation/dax
    allocation/page-allocator
+   allocation/reclaim
 
 .. only::  subproject and html
-- 
2.49.0

