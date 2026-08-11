Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420D13B71C5
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448186; cv=none; b=BAnqqfwUsULM1A6uiYZs79LN8X/UFP4da5nhRk5tHMT+HzmlsyHiMgLeeljT8QGnVopbBNN7GwQVgW80T6vb8YhvnG8230pSJMzbPm9vxFTwwOVWgR5pADKCFORQh7vzfvlFXQsmLSBpxdyHFa+ieCraFKp4dXFt+DOc/HBj7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448186; c=relaxed/simple;
	bh=NDT/HN7wom8qrGdhBDGUjcYQRLvN5Yv7RztsrH1XUJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoPuXpPPVdqyQs/vU2Lr78BW/VZdlYtwHHh0/i2vGGl9Nmi6FLVtQVUywnn2pnz6ouk0Dz97F2EQUrA9AhV/mQ98T54lrs50+X4iAtfvEQD2S+AixOuBZKxumdnfAI7Y7FQjmd6SSx6DJMjxgc0wHIGrnSBJZymizZH55I4GoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ahCxyIzu; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ahCxyIzu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448181; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FAAA48ppTjqeWs0KTaKHZFjYiHHXvLsxMIuW/EydZRc=;
	b=ahCxyIzuebYC0S8kht4pij0yMFxlGFI2YqdUvSrgNtiKcr9sYIQ+V0BRGHtJy7b9sdtRih6uDCDNJbdy+keoUx6Wc95vVbMn8q9nGJbONfxkWBPO+kXgJbE/fUDJylMXhd/M7+9+07QKEHeZGGkEyiRt8DP1niPqDLQXx+EP6Ws=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oJZ54_1786448180;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oJZ54_1786448180 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:21 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 6/8] cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering
Date: Tue, 11 Aug 2026 19:36:06 +0800
Message-ID: <20260811113608.2815625-7-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811113608.2815625-1-kanie@linux.alibaba.com>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_endpoint_gather_bandwidth() combines the endpoint's upstream link
bandwidth with the bandwidth from the endpoint CDAT into an uninitialized
on-stack array:

	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
	...
	cxl_coordinates_combine(ep_coord, pci_coord, perf->cdat_coord);

__cxl_coordinates_combine() only assigns the output bandwidth when both
inputs are non-zero:

	if (c1->write_bandwidth && c2->write_bandwidth)
		out->write_bandwidth = min(...);

That form is intended for the chained 'out == c1' calls that follow, but on
this first call @out is fresh stack. A device whose CDAT DSLBIS does not
report a bandwidth for an access class leaves the corresponding ep_coord
entry untouched, and cxl_bandwidth_add() then accumulates that stack
residue into the region coordinates that are published through the region's
sysfs access coordinate attributes.

pci_coord and sw_coord are less severe but still wrong. Their producers,
cxl_pci_get_bandwidth() and cxl_port_get_switch_dport_bandwidth(), only
fill in the read/write bandwidth fields, so the latency terms are read
uninitialized by the unconditional read_latency and write_latency sums in
the same helper. cxl_bandwidth_add() propagates only bandwidth, so those
sums are discarded rather than published, but the reads themselves are
still undefined behaviour.

Zero initialize all three, which also makes an unreported bandwidth read
back as 0, the value the rest of the CXL performance code already uses to
mean "unknown".

Fixes: a5ab0de0ebaa ("cxl: Calculate region bandwidth of targets with shared upstream link")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/cdat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5c9f07262513..3c6a1537f89b 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
 	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
 	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
 	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
-	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
-	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
-	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
+	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
+	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
+	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-- 
2.43.7

