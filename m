Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06EC27603F
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515029; cv=none; b=nrqHl/VxOTqKaSmmu902Gg2WAX4OjUU4hfVq9zXFqFBB8++x3v03+ZxiSsd9tHRicoV+2ARVgSPImwUruC1gUYLtfw6DUvbJJuHVGCROSPwCj6v8LT2LfkjIPVGu3F9313grlALFE0cNet9DY+cBO65A4ga79nm2+4zzCgESWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515029; c=relaxed/simple;
	bh=VmPSktMl1lxP/T3+ym7lvUDDnyMWnH/qiDksT+mgyiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIOt4BfpUtXSQaf1XQ4n/cR+nLZ5WRPQWQ4OZHcDPC06VTKXL7DMneAU6keDJPlQugZJfSNqo494WjkvDNGvoszG2DZt6oaOOz4uyORD4qZDVqzx5YXliaXV4wv5RvCw+U2gcz6ryLdM5KA+WKd8OiO3HpM5QhExLZnPU+A5afk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TF5aC93Z; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TF5aC93Z"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786515018; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=a3nekCCxShRBBNnZRf6LzrmcA8LRrb1K9GGzxSXaZH4=;
	b=TF5aC93ZvkRq6ryJ0aNi6a0cttK8p0S4X4nsRb1FJ5sALFmWkp6rHg8LMNWSkX/KYqoB7+aMH7CVrx7lVhhC8KLvCKyCz/UEN9KkGyJ4z/cA1y1va/iZ27YYFobL7zbaPHmWQ4IVTYlN4MAccFi8TnYQz+1aDR0bFaPeYpStCqI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8qhx7k_1786515017;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8qhx7k_1786515017 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 14:10:17 +0800
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
Subject: [PATCH v2] cxl/hdm: Fix out of bounds read of the decoder target list
Date: Wed, 12 Aug 2026 14:10:17 +0800
Message-ID: <20260812061017.56916-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_hdm_decoder() reads the HDM Decoder Target List register of a switch
or host bridge decoder into an 8 byte on-stack image and copies
cxld->interleave_ways bytes of it into cxld->target_map, with nothing
bounding the count against the 8 target port IDs the register can hold.
cxl_port_setup_targets(), which programs the same field from the region
side, refuses the configuration up front with 'iw > 8 || iw > nr_targets';
the enumeration path has no equivalent gate.

Values above 8 are legal hardware encodings, not corruption.
interleave_ways comes from the 4-bit Interleave Ways field of the decoder
control register through eiw_to_ways(), which returns 16 for eiw 4 and 12
for eiw 10, and the driver accepts whatever firmware left programmed there
before it enumerated the decoder.

The copy loop therefore reads up to 8 bytes past the union, and the stack
residue is stored into target_map as target port IDs. Those IDs are matched
against the port's dports by find_dport() when the decoder's targets are
populated, so a byte that happens to match an unrelated dport's port_id
installs that dport into cxlsd->target[].

Reject the decoder, which is how the eiw_to_ways() and eig_to_granularity()
failures in the same function are already handled. A decoder whose target
list register cannot describe its own interleave is not a configuration a
region can be attached to.

Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
This was patch 5/8 of the "cxl: Assorted fixes" series [1]. Per review
feedback that series is not being reworked as a whole; the fixes are resent
individually instead. Patches 1, 2 and 7 of the series are dropped, as those
issues are already fixed in cxl/next.

v1->v2:
- rebase onto cxl/next
- rewrite the commit message to describe the behaviour rather than narrate
  the code change (Alison Schofield)

[1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/

 drivers/cxl/core/hdm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..9d49b48a4456 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1084,6 +1084,18 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
+		/*
+		 * The Target List register only holds
+		 * ARRAY_SIZE(target_list.target_id) entries, so a switch
+		 * decoder cannot interleave across more ports than that.
+		 */
+		if (cxld->interleave_ways > ARRAY_SIZE(target_list.target_id)) {
+			dev_warn(&port->dev,
+				 "decoder%d.%d: Interleave ways: %d exceeds target list size\n",
+				 port->id, cxld->id, cxld->interleave_ways);
+			return -ENXIO;
+		}
+
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;

base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
-- 
2.43.7

