Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720D6F53E
	for <linux-cxl@vger.kernel.org>; Tue, 24 Jun 2025 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750726425; cv=none; b=eVjR3YVQLHnVYoN3ndnISfvr5+K/Fr+w/VZ2KtHDUusVeXb0Z8CDJo3CxfUv6ogReK7dQWbyVQUqjbduTgIhOLPsyJWZPsrTTcaFZN2bG24ISZtd5wElL7Wyf5GauN+mWmapz/bQD5qvS+s5pt90BNVj/Yh2MXhFbmU9uREi04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750726425; c=relaxed/simple;
	bh=6ue5SkOOnonCi0JVDNz8fAzqfFyNh5999bTGySBe1es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWSfkHTQROiJNa9qZQjzVOqsDjkKAV8TffVrkcGuU4ocmGhpIKrP7XF55PKiFJGSxp9XhSH94Sn/xNsr6ipxhmUUa1UCjmH66qZqeQgVNJeToZybB0z3ZDQLd1ERgiODcqtPgogg/OwQkeaJTIqUcoe38TnmqAmulj9zPgFT2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaTRXbYR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaTRXbYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750726424; x=1782262424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ue5SkOOnonCi0JVDNz8fAzqfFyNh5999bTGySBe1es=;
  b=WaTRXbYRXVTpTljOsykU+4Fixx48pnsQOz2scN/vWVoNbr5Q8m0Naqky
   0jLiBxTOPEBE+Bej5rbjgJggXXvlXx4MntTPyMmXKHp35Ry+nI3jmXPok
   f+sQeVpyBK2dV7PVvMEsCYjOgtwoATgU67Q6AIFTP7owN8yLLTNEkMbjo
   HWZCN/6KE8MoY9kbC2cwSDM0XBNEjjA0oxB4j6xoNUJNiwkRimcHlq1nf
   YLlA8VQATSVw9YczYpdQw3e/E4knnji+f8JwtE74s3ilMB+X0uluy0ZOx
   +vvZMUtCo/Bto+Doc6TPoCWun90VKsqXamkYne91aTlmdKjWcZFfB2ref
   A==;
X-CSE-ConnectionGUID: 15BNyCyiSISI7vijg86Z9w==
X-CSE-MsgGUID: c030k/6oR+aZjIdsRi7WAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56728809"
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="56728809"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:53:44 -0700
X-CSE-ConnectionGUID: ze8YSi1UQjCWqy34JIqebA==
X-CSE-MsgGUID: AuUYo+4wQsaLwnT0GLyC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,260,1744095600"; 
   d="scan'208";a="156129155"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.202])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 17:53:43 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/region: Introduce HPA to DPA address translation
Date: Mon, 23 Jun 2025 17:53:35 -0700
Message-ID: <4c4a1a52a4651b726ef66d9020e71e731b74cb5d.1750725512.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1750725512.git.alison.schofield@intel.com>
References: <cover.1750725512.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Add infrastructure to translate Host Physical Addresses (HPA) to Device
Physical Addresses (DPA) within CXL regions. This capability is being
introduced for use by follow-on patches that will add poison inject
and clear operations at the region level.

The HPA-to-DPA translation process involves several steps:
1. Apply root decoder transformations (HPA to SPA) if configured
2. Calculate the relative offset within the region's address space
3. Decode the interleave position using the region's interleave ways
   and granularity settings
4. Identify the target memdev based on the decoded position
5. Compute the final DPA by adding the decoded offset to the memdev's
   DPA base address

It is Step 1 above that makes this a driver level operation and not
work we can push to user space. Rather than exporting the XOR maps for
root decoders configured with XOR interleave, the driver performs this
complex calculation for the user.

While not immediately apparent in this diff, broader examination of
the region.c code shows that this work is basically the reverse of
previous work where a DPA is translated to an HPA. This is notable
because it demonstrates that these calculations reuse existing logic
rather than introducing new algorithms.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 85 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6e5e1460068d..d2d904c4b427 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2972,6 +2972,91 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	return hpa;
 }
 
+struct hpa_decode_result {
+	u64 dpa_offset;
+	int pos;
+};
+
+struct cxl_dpa_result {
+	u64 dpa;
+	struct cxl_memdev *cxlmd;
+};
+
+static struct hpa_decode_result decode_hpa_to_dpa(u64 hpa_offset, u8 eiw,
+						  u16 eig)
+{
+	struct hpa_decode_result result;
+	u64 bits_upper;
+
+	if (eiw < 8) {
+		result.pos = (hpa_offset >> (eig + 8)) & GENMASK(eiw - 1, 0);
+		hpa_offset &= ~((u64)GENMASK(eiw - 1, 0) << (eig + 8));
+		result.dpa_offset = hpa_offset >> eiw;
+	} else {
+		bits_upper = hpa_offset >> (eig + 8);
+		result.pos = bits_upper % 3;
+		bits_upper /= 3;
+		result.dpa_offset = bits_upper << (eig + 8);
+	}
+
+	result.dpa_offset |= hpa_offset & GENMASK_ULL(eig + 7, 0);
+
+	return result;
+}
+
+static struct cxl_dpa_result __maybe_unused
+cxl_hpa_to_dpa(struct cxl_region *cxlr, u64 hpa)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_dpa_result result = { .dpa = ULLONG_MAX, .cxlmd = NULL };
+	struct cxl_region_params *p = &cxlr->params;
+	struct hpa_decode_result decode;
+	u64 hpa_offset;
+	u16 eig = 0;
+	u8 eiw = 0;
+
+	lockdep_assert_held(&cxl_region_rwsem);
+	lockdep_assert_held(&cxl_dpa_rwsem);
+
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_err_once(&cxlr->dev,
+			     "HPA 0x%llx not in region [0x%llx-0x%llx]\n", hpa,
+			     p->res->start, p->res->end);
+
+		return result;
+	}
+
+	/* Apply root decoder translation */
+	if (cxlrd->hpa_to_spa)
+		hpa = cxlrd->hpa_to_spa(cxlrd, hpa);
+
+	ways_to_eiw(p->interleave_ways, &eiw);
+	granularity_to_eig(p->interleave_granularity, &eig);
+	hpa_offset = hpa - p->res->start;
+
+	decode = decode_hpa_to_dpa(hpa_offset, eiw, eig);
+	if (decode.pos >= p->nr_targets) {
+		dev_err(&cxlr->dev, "Invalid position %d for %d targets\n",
+			decode.pos, p->nr_targets);
+
+		return result;
+	}
+
+	for (int i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+
+		if (cxled->pos == decode.pos) {
+			result.cxlmd = cxled_to_memdev(cxled);
+			result.dpa = decode.dpa_offset + cxl_dpa_resource_start(cxled);
+
+			return result;
+		}
+	}
+	dev_err(&cxlr->dev, "No device found for position %d\n", decode.pos);
+
+	return result;
+}
+
 static struct lock_class_key cxl_pmem_region_key;
 
 static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
-- 
2.37.3

