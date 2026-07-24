Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37B3B5306
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925446; cv=none; b=XD7P53YfXqeH9b0p7FxCzvJNVHA1YUec16+TqbA6wWdK3lNVw1NMl7B4bCgSMBsRAObI7uOwUAe4QaP5i+F9mIQfwnJe6+/osp79D9UmVIAwqRdTAMbotTsYno891Rq3swzXL7jPx5XvGIsdnudwNQWeZuk/yzsMwc4FKeWTJNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925446; c=relaxed/simple;
	bh=F75awUvkTS9HCuFZcrp8Iw5x+yGyj3JetNTkLydcUPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a57RfEzQWEVauTETvcjJ9ceWpfpZk/0mBJlz9qbhvgemJgjnz2HEQwU2csNvOdONjjLyyl47rIgpIvCxvMBM0wBQ/H/3rwmnSSoJ14cXmlrilR4pdPG1jM6bl+1by/YqMA1CZHbuyTuZsEhQ/vtJNyw8fxqRTLN35bb8P/kt2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlGZ7/az; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlGZ7/az"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784925444; x=1816461444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F75awUvkTS9HCuFZcrp8Iw5x+yGyj3JetNTkLydcUPI=;
  b=KlGZ7/az3wgsK660bURqHQkL21F0kMbwOwtOJfg+c93nZUJp5MSgfOtr
   otzW7E41gcFmXh+bCJVRHmd4Bh4Sywp2t0RcjnTvSO6zNUqq2e48c9d5J
   8LGmKR3AI3YFsk/oGkkHr5IU4/FuIZs5ZcaZiyNbybMEJ4dwJMqm18f/c
   Le1Z1oRCFa14RFJWZAebm6BRUqSGBtvfsiV9UtXwDDaGK25rUD1xNMQE+
   NU7ttgflWE8ZbsFl1faY5XTa2wRPCay/GW3F1lqpKbXVVAXBhIfVT6Lch
   0x4UEARwNGRMqbErO7B6+cWK4s+vD9oIJvTDG6OTqwqDyFuF5luS66sLX
   g==;
X-CSE-ConnectionGUID: zGeeONw4TXOJmCHDVuYCOQ==
X-CSE-MsgGUID: +hxzaKoeSLKg/oZNAYIP5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="103008225"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="103008225"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:37:23 -0700
X-CSE-ConnectionGUID: MesgnBBOToSoqmiCJBGpVg==
X-CSE-MsgGUID: ZkR/nI9XThaUOu5wy/34+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="258872372"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 13:37:22 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/3] cxl: Format the device serial number as unsigned
Date: Fri, 24 Jul 2026 13:37:16 -0700
Message-ID: <cover.1784924949.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Changes in v3:
- PATCH 1 commit messaged updated with link to work-around direction
- No other changes.


This series supersedes the previously posted standalone fix:
  cxl/pmem: Format nvdimm serial number as decimal

That patch addressed the immediate auto-unlock failure caused by the
kernel formatting the nvdimm security key description differently than
the decimal 'id' sysfs attribute used by ndctl.

Further review uncovered a second formatting issue affecting the same
serial number. The CXL device serial number is a u64 PCIe Device Serial
Number, yet several kernel interfaces format it with signed "%lld".
Devices whose vendor OUI sets bit 63 therefore appear with negative
decimal serial numbers.

Serials with bit 64 set are expected. The most significant byte of the
PCIe Device Serial Number contains the vendor OUI, so vendors such as
Montage naturally produce serial numbers with bit 63 set.

Rather than merge the decimal-format fix and immediately follow it with
another patch changing the same code to "%llu", fold both fixes into a
single series that consistently formats CXL serial numbers as unsigned
where appropriate and adds cxl_test coverage for the large serial case.


Alison Schofield (3):
  cxl/pmem: Format the nvdimm serial number as unsigned decimal
  cxl/core: Format the memdev serial number as unsigned in TP_printk
  cxl/test: Assign one mock memdev a full-width serial number

 Documentation/ABI/testing/sysfs-bus-nvdimm |  3 ++-
 drivers/cxl/core/pmem.c                    | 10 ++++++----
 drivers/cxl/core/trace.h                   | 10 +++++-----
 drivers/cxl/cxl.h                          |  3 ++-
 drivers/cxl/pmem.c                         |  2 +-
 tools/testing/cxl/test/mem.c               | 15 ++++++++++++++-
 6 files changed, 30 insertions(+), 13 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

