Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879936EAA8
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753590; cv=none; b=fYltiMB0vUNCNpEUyJvUIPr1z2Ha/qB67+989wvYh08ypTWRYqoE2TTAXmLvNgDI5MWPuWuN3giG8GHBjACQ5L4Hd4WqzPguKAGKya6q6hvmUY0RWqdH5XiWnQ1jjMC2fEyfNypo8T/m+eauZ4Yph18i4pzwZuTdN8zTH1fU+FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753590; c=relaxed/simple;
	bh=OO3TKWf34d6TmJ3YYQE3nOs3BbFwnIEL8H0dVEHAsis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIwyOrOWMaCvZZ8hUu9sFqCuVWjwOwCqcKdg4FP003M0w49HhzJHQQlKR3YAN8/hooQwoJJt1SEiaedU323tnqX7Wc8YhlYmPVGrEciGvEW8lA+r3EqycMk525XOgriY8oje8k2yYpjbvch3pnqtbz2qtm6mYLavTlhGMev+970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B049A1F000E9;
	Wed, 22 Jul 2026 20:53:08 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	sashiko-bot@kernel.org
Subject: [PATCH 1/3] cxl/region: Guard against unset partition in poison_by_decoder()
Date: Wed, 22 Jul 2026 13:53:00 -0700
Message-ID: <20260722205303.3184787-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722205303.3184787-1-dave.jiang@intel.com>
References: <20260722205303.3184787-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

poison_by_decoder() reads cxlds->part[cxled->part].mode after checking
only that cxled->dpa_res is set. During enumeration __cxl_dpa_reserve()
sets dpa_res but leaves cxled->part at -1 when the range maps no
partition, and the decoder is still added. cxl_get_poison_by_endpoint()
then walks it, indexing part[-1] out of bounds.

Skip decoders with cxled->part < 0, matching cxl_region_attach() which
treats an unset partition as a dead decoder.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=4
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..ec0dc4284c3c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2959,6 +2959,9 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (!cxled->dpa_res)
 		return rc;
 
+	if (cxled->part < 0)
+		return rc;
+
 	cxlmd = cxled_to_memdev(cxled);
 	cxlds = cxlmd->cxlds;
 	mode = cxlds->part[cxled->part].mode;
-- 
2.55.0

