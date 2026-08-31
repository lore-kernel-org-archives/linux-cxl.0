Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF03A75B8
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168151; cv=none; b=GTNKWvscQfGc7mwGc9f4rrDRJRJL9I5LjU53AWJaXT0ab/WRAG7TZz8IMxpHwfeJpk9KNB6UEiJe/kZaefx8ViJgxJPlPvCQkJuqrPlPoEK4XSHpKnUYumrBHFaiTsklHhqHyTaWUfP4/x+Jr1/3duyTIdk3hGZieieV2iGdsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168151; c=relaxed/simple;
	bh=GQY1mJCXkXPdS/QBTV7ipjAa3WFdLT4/fkrbey7SLGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbbqc4AosQnyOriSJtrbRZohqdP7KM1bbsmEgdpv6sWIn5d7D1HSrrUqPCEYC0hAynTv6dPUwI3IUJKnXklHaE1kY6JXdaU6XtTuVN1IrogP6NBD8o/yqxtm09rd7ImM9y/gDqmo8e010iyTiHtVOGYTP3tyg//3J9MOFGiAVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rRRlbVLf; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rRRlbVLf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788168147; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pe4P6ci2t6zFNNLm62HbrDA8HEvRs0PZdS2anO7K144=;
	b=rRRlbVLfFI5yTZ76P1ndQYwNHWA1x98bFqUDhB9vrDqxysOHaml1oYTV4ZjKxAdWb4UTYQND0LedquLLsn5yPx9CRxpm4gE808unD3Xf9alWgmiLjpGBNRjyJznAkT7rjpcSH4qSMuUOYsXjWdnI2mwL/oMSE7pW3oLW/NX6++U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9wdSoB_1788168146;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9wdSoB_1788168146 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 17:22:26 +0800
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
Subject: [PATCH v4 2/2] cxl/port: Fix uninitialized coordinates reported for RCDs
Date: Mon, 31 Aug 2026 17:22:16 +0800
Message-ID: <20260831092216.540644-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260831092216.540644-1-kanie@linux.alibaba.com>
References: <20260831092216.540644-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_endpoint_get_perf_coordinates() returns success for a Restricted CXL
Device without calculating coordinates, so the caller's output array is
left uninitialized. Callers treat it as valid and can expose the stack
residue as access coordinates.

Initialize the coordinates to zero before returning for an RCD. Zeroing in
the helper rather than at the caller keeps the @coord output contract the
exported function documents.

Reported by the Sashiko review bot.

Fixes: 5d211c709059 ("cxl: Fix cxl_endpoint_get_perf_coordinate() support for RCH")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
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

