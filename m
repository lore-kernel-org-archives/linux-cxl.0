Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED133A8732
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673067; cv=none; b=lg9Z5caVZDHzM8jgt5ba4lLqB5bOAkzG7cBzkIP+fjOyAQHFIpDLLJuxIC7zkX8WfhYXI3FlCzSaZnbdgKa2/meLZI1QDhgOFQKV/o9wtl0OMF6slUMgDoFItfLkPJAYBhY97vO2+R1emxOzi4GFi3nYLCJPmRUQruCMjagWDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673067; c=relaxed/simple;
	bh=JnmxjIlhNrqNDcxHSzbYS1DDAMqga2BAmEwhynazEsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/JkHtHQQspknCoEKUcQC0Sz189oPmbeaZT9rz51+a88jO2z1QgByf4PYiY5/68JZQo56f0XVjjL1GYZ7kE4w9yc541fbEi/mBm46qfIbTz7+7f3DnRJvWQbGEPgQ9aQMbVsG5eJEuY1H0VJw2wODvepXYVZRe39awthdzPMScc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMvYeEA2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMvYeEA2"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-887beafb714so352178b3a.1
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791673062; x=1792277862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1YTLtaT9iHCUU2BwSqHbgs21TBjanDGosXtNAr9CKhM=;
        b=nMvYeEA2zcin4GIJXpH/LCjr1mP53GlkKzkpC4Cc61Vm6+sWPvudsdWnRXgbDeZ2pq
         s2zLVlXqDiXhjLp8Xp2CjUQZAXVKtFYayavtd5azE9uC1KpbVU6AMzYMQzUAwGIvlzLp
         g9rGSkgVDXqmTWE1VBtYFwMiRRc1CwYCNOBj1w31RdK08KVFiIKlrI/KV2UA0HOvSMCo
         /xMwiaHHxtWmrJhZ5zx33F2815bLvAEnJiy4LQEU8lxQDUaMeHUK4K6mXUdksn+Ij0bs
         jyzKL62iLwAWnj+CBAhtCYKJUYUFsI5UxM7s2EC+uscOpLbMgJRxpWvhUrwz12t4ueoH
         j/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673062; x=1792277862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YTLtaT9iHCUU2BwSqHbgs21TBjanDGosXtNAr9CKhM=;
        b=Ai0YnwV70Dluq/64CeugUQh38amn33k45GorJr66QAxWVdBojLcLiYEkgCAAuBRTMx
         Jw/8SLOuICiqkvHOO+tfcVwsVyNuE30Ie3rwIY7YJDi+4U3QeSId5Q9dp0sI3N1CP0lx
         Q6WGo1cgKKrjh57kFG3wP9PgaVTN4dMRfpEjT0EaDUoet5BTpUFgovCgn7WzlOQaKyUI
         KB12N7OJpSo3b/e/UEwQcxVmJP2441T9cI8gIKzx6OB0oE/apegjwbye41IUNt4xcdc9
         GVweRK1oQDuBvmvUZkkWRw/wIk1xGJtewvJqPGcv2l8UEDHFYCtGNJVDj3JPZflqoDAS
         EfFg==
X-Gm-Message-State: AFq9FYLrYDYSx3I7bmCyCSoVXxYkjg1FLoC+FPEII7NGOMsf5O33Qwd1
	I5jWptAzR54XH7p9mfcqByiDtpIhKTHlljW/hEnnk5CiennO5VG/ms97RkJHrsA+
X-Gm-Gg: AYBFou2AKA4/m1QntsnySqHCJYoWHJaudfxiC0iQKcRf/QWwCr0Ek8ih6m5zPJqr1vg
	6xrCK4QzKxPpAhTTUmH8KhbvHiSmZefOygt6S0Nzybus4IBtQjgn8x4l28BMx5EV5NQPNUlpR63
	5rrmUiMhVtq7e20flOvOlCKyBliugCPBoTNQXRat896tL0LKT4Gq7X5A54a2AOSldVWS0nqnSZ3
	NDiFaljmzzsyzrsPmxZJomvz+IHARjm16DNgmWh98EnXVWxpCjSLvBJAQZZMEBJy4lcrZx7EZqx
	SWdlZy1GpzeOdmeBy+J640fRytTPoTLIHS6MwYJB40stakiX7whK+ESMWLl2qz2Jye8HUrzu/4G
	4xStF3O/45+h715c/zFL/EfZEoiIrPyC2Cub6WLANCYbXiGdzs7TVvO+2mBwoL7QlGE8fvn1YH7
	hPGGJLRBWS7EqWe6hsngg/m5C0ZcRQ993fjPEQTQYeAKtWutaKQ2J3G5NLwnQUX4UEm1LnKWTqR
	9OMLYBWMYFPRwkglu0cZlXZ0Yl2
X-Received: by 2002:a05:6a21:178a:b0:3d3:ad3c:49a9 with SMTP id adf61e73a8af0-3e16be86b53mr4752997637.23.1791673062136;
        Sat, 10 Oct 2026 15:57:42 -0700 (PDT)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e07329sm2603662a12.5.2026.10.10.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:57:41 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v16 8/8] Documentation/cxl: Document DPA partition layout and ordering rules
Date: Sun, 11 Oct 2026 07:54:59 +0900
Message-ID: <20261010225852.10727-9-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010225852.10727-1-anisa.su@samsung.com>
References: <20261010225852.10727-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DC Partitions complicate DPA ordering. Add a DPA Partitions section to
cxl-driver.rst describing spec-mandated and Linux requirements for the
layout.

maturity-map.rst breaks the DCD entry into sub-items so the map shows
what this series lands: partition enumeration is [1], event handling
and DC-backed DAX regions remain [0] until the follow-on series enables
them. The parent stays [0]; nothing is usable yet.

Suggested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 35 +++++++++++++++++++
 Documentation/driver-api/cxl/maturity-map.rst |  4 +++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index dd6dd17dc536..212df4fb8d63 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -181,6 +181,41 @@ A Memory Device is a discrete base object that is not a port.  While the
 physical device it belongs to may also host an `endpoint`, the relationship
 between an `endpoint` and a `memdev` is not captured in sysfs.
 
+DPA Partitions
+~~~~~~~~~~~~~~
+A memory device presents its capacity as one flat `Device Physical Address`
+(DPA) space divided into `partitions`, which Linux lays out in a fixed
+order::
+
+  DPA 0                                                     end
+  +---------------+---------------+---------------------------+
+  |      ram      |     pmem      |       dynamic_ram_1       |
+  +---------------+---------------+---------------------------+
+  part[0]         part[1]         part[2]
+
+Part of that order is required by the CXL specification and part of it is a
+Linux choice.
+
+The `ram` and `pmem` order is mandated.  CXL r4.0 section 8.2.10.9.2.1 "Get
+Partition Info" (4100h), Table 8-310, mandates that volatile capacity starts
+at DPA 0 and pmem starts at the DPA immediately following it.
+
+Dynamic Capacity partitions only need to be 256MB aligned according to
+CXL r4.0 section 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
+(opcode 4800h), Table 8-347. So a device could leave a gap between ram/pmem
+(static) capacity and its first DC partition, or between one DC partition
+and the next.
+
+Linux chooses not to support gaps between static and dynamic capacity: the
+first DC partition must begin at the DPA immediately following static
+capacity -- after pmem, after ram on a device with no pmem, or at DPA 0 on
+a device with no static capacity at all.
+
+Currently, only one dynamic partition is supported. A device may report up
+to eight (CXL r4.0 Table 8-346); Linux configures the first as its
+`dynamic_ram_1` partition. Gaps between DC partitions are not checked, since
+only the first is used.
+
 Port Relationships
 ~~~~~~~~~~~~~~~~~~
 In our example described above, there are four host bridges attached to the
diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index 282c1102dd81..fefd31899229 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -150,6 +150,10 @@ Memory-pooling
 * [1] Hotplug of LDs (via PCI hotplug)
 * [0] Dynamic Capacity Device (DCD) Support
 
+  * [1] DC partition enumeration / configuration (Get DC Config, CDAT DSMAS, event interrupts)
+  * [0] Extent add / release event handling
+  * [0] DC-backed DAX regions
+
 Multi-host sharing
 ------------------
 
-- 
2.43.0

