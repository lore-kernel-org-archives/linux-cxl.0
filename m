Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51A03624B2
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 02:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994683; cv=none; b=THQ+XMbt3TgvUboUWc4uDL3SOisqZDJv8faTtwm7oZLw2gkqRIvsC9hBv3yWa/VX7txa7X4bslt7LnmYnL8qRr/QTBIGMjll0hR62cdZQMYpqmHvH0HaLwKPmHfhJlSmg5bZHbzWeiISYbx2an7az6pmvFG9KcBORB8D3URYfz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994683; c=relaxed/simple;
	bh=VscBFBl6h+GV4K3hDMm8MiwiBEFe8M64dLIsGmyqK6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NisuA4Va13+RUTOgm7/km0dkGKO6TDNdPK/BQ4zbU16+rByGVTVLTwvGvg2bHqwGtdLSAcxBqmUMhy1ukT3w5alHY9eKUV80Ufcz7Klaqn3QwZEBDnAtta/kIo2AwE8M/sMZgPbM/KdCxwNiE8qeavRHvxJB74c/OTa7UQg1grI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRKbnnLt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRKbnnLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783994683; x=1815530683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VscBFBl6h+GV4K3hDMm8MiwiBEFe8M64dLIsGmyqK6A=;
  b=GRKbnnLt5ct7Sl4zinR9q1N7N/e5qQ8Rs6MyWpiQCf+/YlbawXEzY59Q
   enr1c8ApTe5IoJTqtfKzisPQfNI812nixdjn9cIL1eth6OOD5wAbngq3Q
   nv6plhoSFYIIuKlhxvASHfmboumNBq7XNRKQt6yDxd+IAtUg0IxBngtDW
   IYzLQsLXtDJM106V20Ff9JwN4kjiHNMMeDjpueBxSviDHn1AYnvziu+w5
   tA9EASDAO4eFvaCE11g3L/vrAZ3A5kxawSJWXkHz0AUooJMSj6WmJ2yfv
   3G6H3maVpAhSakEVcFo+xGka6LerhiHTu711Af0A+6p4ESE+hdaHXDf/l
   A==;
X-CSE-ConnectionGUID: /aqeqvxsS+2u8IkcMR64SQ==
X-CSE-MsgGUID: f7i1yHDDSxC2hnPcka/BuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84804520"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84804520"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:04:42 -0700
X-CSE-ConnectionGUID: 8oSm8mcFRbiHy1M1XS9zDw==
X-CSE-MsgGUID: 1DFDmdt+TkymqeTVP1jv2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255221411"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.12])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 19:04:42 -0700
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
Subject: [PATCH v2] cxl/port: Restart port enumeration when a sibling adds the dport first
Date: Mon, 13 Jul 2026 19:04:35 -0700
Message-ID: <20260714020438.1822669-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Endpoint probes can race while enumerating a shared switch. If a
sibling probe adds the dport first, the losing probe finds the dport
already present, gets -EBUSY, and fails to enumerate the endpoint.

Treat this race the same as the existing port-created case by
restarting the port walk, allowing it to find the existing dport
and continue enumeration.

This race was discovered while testing a cxl_test mixed-granularity
topology, where twelve endpoints behind shared switches are probed in
parallel during module load.

Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Commit log: note that race is btw different dport add paths for the
  same shared dport (Ming)

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

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

