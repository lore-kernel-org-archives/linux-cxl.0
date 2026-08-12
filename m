Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701B3E3DA4
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 08:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523452; cv=none; b=MDOEmVWjS52gcSo3K805GThs4D7zxPlRGcekdYcisRPp8C7+13A8OW5t3yZ1sr7EGR5srKhvZosyWyVlDsjVbbWY0eKbRF2YG/3n5EZZcJ5LtGw7ws8i/CePsqPLAcQdeKyy37+2fphe5TB5w3amhMd7CRn2qouoDpR6746S9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523452; c=relaxed/simple;
	bh=pC24eGeR7WzVxfZpOP2985EE4ZDbcu8w7laytrHkDLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeZmfPpcLImP6cw575YsBRjYBlQHwCSX+hbNvwfE0WWSD1FbM9K3MrtM9AqbB664UOIuX9PMuXciFD2a+AGm8WpgaBlGqSIXwh+IvgQU1u+TI4VnFxlR1QQIT3zThYvfB2zTlZxqqjmdfwVXla6y3+s6/Faurj1qa3cUyZ8xdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b/KJtBXi; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b/KJtBXi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786523442; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PnRoXOE0k5yZn7jYBeVbPJFJfeOLuD+mK1Zj1iMbZ+E=;
	b=b/KJtBXi5v5BdGorplATqFxrU4iwmcC0eWat4WaPzwSUQFMz/vdYQiqlj3/CTsm0zjZLROE5tXw4ih9O2rqt+MIBYpXu9HlqdBaNbx+0r+DI9X9MTcZjV+TOH0KoXLXkWcXFWOQsTbAkvHwLQ/tAD4fOdHW3Mft+LxMbDB8wtLo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8r40Ah_1786523441;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8r40Ah_1786523441 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 16:30:41 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/2] cxl/port: Fix uninitialized coordinates reported for RCDs
Date: Wed, 12 Aug 2026 16:30:35 +0800
Message-ID: <20260812083035.372308-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260812083035.372308-1-kanie@linux.alibaba.com>
References: <20260812083035.372308-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_endpoint_get_perf_coordinates() walks the CXL path and copies the
accumulated numbers into the caller's array with set_access_coordinates()
just before it returns. For a Restricted CXL Device it never gets that far:
RCH topologies are covered by HMAT and cannot be hotplugged, so the walk is
skipped and the function returns 0 with the output array untouched. Every
caller is told the coordinates are valid while nothing was written to them.

Its only consumer, cxl_port_perf_data_calculate(), keeps the array on the
stack and does not pre-zero it, and endpoint CDAT parsing is not gated on
the topology: cxl_endpoint_port_probe() calls read_cdat_data() and
cxl_endpoint_parse_cdat() for every endpoint port, RCD included. So an RCD
that exposes a CDAT combines stack residue with the values from its DSMAS
entries.

The residue does not stay in the driver. __cxl_coordinates_combine() sums
the latencies unconditionally and takes the minimum of the bandwidths when
both are non-zero, so it lands in dent->coord, which selects a QoS class
through cxl_root->ops.qos_class() and is copied into the memdev's
cxl_dpa_perf, where cxl_memdev_update_perf() publishes it through the
memdev's access coordinate sysfs attributes.

Clear the output on the RCD path so the function honours its contract for
every caller. Zeroing at the single caller instead would leave the exported
helper free to report success without writing anything, which the next
caller would have to know about; and zero is the value this code already
uses for "not reported", so an RCD now reads back as unknown rather than as
plausible numbers.

Fixes: 5d211c709059 ("cxl: Fix cxl_endpoint_get_perf_coordinate() support for RCH")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db..fea43a92744c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2394,8 +2394,10 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 	 * Skip calculation for RCD. Expectation is HMAT already covers RCD case
 	 * since RCH does not support hotplug.
 	 */
-	if (cxlmd->cxlds->rcd)
+	if (cxlmd->cxlds->rcd) {
+		memset(coord, 0, sizeof(*coord) * ACCESS_COORDINATE_MAX);
 		return 0;
+	}
 
 	/*
 	 * Exit the loop when the parent port of the current iter port is cxl
-- 
2.43.7

