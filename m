Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1131C69D
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783819731; cv=none; b=mEs8R9sXP2sRt5FoMdjD2xtBQGHZSeggvRl93dzFzYpRjYvVWXG+RnMGbcAdTa4oddIS6UoB3s1C/y0Q3rru1nyhZVQz61WuNIZAjrnEcMM+dX7JnGueqfWWAwgcfLUwrBfmsZd9fgPU8OBriFuMMzNl8iWCU47eMPHKwUoYHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783819731; c=relaxed/simple;
	bh=I1pX+EU+29jmNUkTqq+l7S9W0S1tlX5T78bpS3+QUKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KK4QSJULYdqiElWWsxKNfH/M/+CRVo4uqZ4ZJ+MV2ZdoycJsi0iaX9gPRugIxnI0iQ97+9I/JhO5dwdGPmXxPcVtMEeDSy/ksfczE3r4vDrClD2xzHl5krfjOKk86Ti7UfxjimRqvSD0LgCXsKqBUt1T3n7d03HOgnWNNQZKbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crK60ks8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crK60ks8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783819729; x=1815355729;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I1pX+EU+29jmNUkTqq+l7S9W0S1tlX5T78bpS3+QUKE=;
  b=crK60ks8EusOzUtmPhAVWo25IubukdAmuknfhKyAQ3anY39xd9jjOib/
   qUi70fouyJdh8VOSeKaPF1lBV8Al2LCDEsHXi4zM/CvAH9wBRHFknYXBm
   AiJueaEpMrOJVgAsj52hAtbNXvEAraPwOni3gE9Bqom40N4MRimTFxwi7
   s8hxfzOllhKu01XT8Y9BvLxgayLshqSeXLiYtEf8ztNYI5DM1Vwnb5S8M
   qlevXfGqYZpShbs20i0KW5Q1o/IGN60Pysc7jykEl1xMBDTaxW7Cf4IgX
   2j3KeckoenszFhVTFZ7TGQrH3PxHNAjvyX5Fhclpq707BLlvEHkry6IZR
   w==;
X-CSE-ConnectionGUID: QibgfSxmR1SzMdDxa4gQ9A==
X-CSE-MsgGUID: Nl7YN3CSRAyfb1sR/KyYxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95079529"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95079529"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 18:28:48 -0700
X-CSE-ConnectionGUID: TTbZeMTeTbSiZ9zQKDzZYw==
X-CSE-MsgGUID: q2/dMQ1yTwm+YkHGFbHsLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254711087"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 18:28:46 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/port: Restart port enumeration when a sibling adds the dport first
Date: Sat, 11 Jul 2026 18:28:41 -0700
Message-ID: <20260712012843.1792090-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Endpoint probes can race while enumerating a shared switch. If a
sibling probe adds the dport first, the losing probe treats the
existing dport as an error and fails to enumerate the endpoint.

Treat this race the same as the existing port-created case by
restarting the port walk, allowing it to find the existing dport
and continue enumeration.

This race was discovered while testing a cxl_test mixed-granularity
topology, where twelve endpoints behind shared switches are probed in
parallel during module load.

Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..65f2d2f1eb00 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1749,8 +1749,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 					     parent_dport, uport_dev,
 					     dport_dev);
 		if (IS_ERR(dport)) {
-			/* Port already exists, restart iteration */
-			if (PTR_ERR(dport) == -EAGAIN)
+			/* Port or dport already exists, restart iteration */
+			if (PTR_ERR(dport) == -EAGAIN || PTR_ERR(dport) == -EBUSY)
 				return 0;
 			return PTR_ERR(dport);
 		}
-- 
2.37.3

