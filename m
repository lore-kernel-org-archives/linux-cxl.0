Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28AA43CE6D
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448184; cv=none; b=qntXsTNouYIsJa7YEAMmNJCYCc5nb+WAZbntB4Fb9abcwtcyTmSnvgVc5L3A8BSBDxFXyzaNXRdj+OhSs/t1LzFwkGAeQlAX9eJIP4ntodkCKQH1+n3VLiSFxGMCALdLiojXoU80/FrCkDNAt3jZzIVLvmexB6oO8S7+REaleL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448184; c=relaxed/simple;
	bh=uC7X8HY9CF1B2KKQqdp21IYKNQZANWEkCORxPQEf4ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa53X45b1RGBRKUdbK5IhQf24qiEyFPb6uNeOyNYN4juvSTU7dDwY5cQKcIaDo6pagBqyX8YSVY+hqBrxvp7T0DfXHeB0LTlyidweIUrWy5Ym13y36aPIH3ZhjPSLgTI7pj7NndFBvTpBBBqsS04BKeuk28yJ/skbD4cvWxxObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dIZuiwUy; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dIZuiwUy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448177; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Oh5qC9ZfUFJnNzOz5dynF8LEfapY6a6EtLvIar8vO9E=;
	b=dIZuiwUyWDdL5xe3dYZSsxsE+4vv/QQCexfJJzpZViC/X9lTLx/pxyE6leJDZxNJElUOa0YS/lYLumvPxuwLvdbDFEILx4SDVoFG5gPTVLunzN2nQljF+xZ3OciyvGGvE5fJVr5nLNtex6djL28IiAX1yYGmAsZFD+MFoBAHDLU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oJZ3z_1786448176;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oJZ3z_1786448176 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:16 +0800
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
Subject: [PATCH 2/8] cxl/features: Bound the Get Feature output by the user output buffer
Date: Tue, 11 Aug 2026 19:36:02 +0800
Message-ID: <20260811113608.2815625-3-kanie@linux.alibaba.com>
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

cxlctl_get_feature() allocates the output buffer from the size userspace
asked for (fwctl_rpc.out_len, arriving as *out_len), but then asks the
device for a completely independent, also userspace supplied, amount of
data:

	out_size = *out_len;
	count = le16_to_cpu(feat_in->count);
	rpc_out = kvzalloc(out_size, GFP_KERNEL);
	out_size = cxl_get_feature(..., rpc_out->payload, count, ...);

cxl_get_feature() loops until it has read @count bytes into
@rpc_out->payload, so any 'count' larger than the output allocation
overflows it, with up to 64KB of device supplied data landing past the end
of the object. An out_len of 0 additionally turns the allocation into
ZERO_SIZE_PTR.

Reject the request unless the allocation can hold the Feature data at the
offset the mailbox writes it to, i.e. sizeof(struct fwctl_rpc_cxl_out_hdr)
plus @count.

Note that struct_size_t(struct fwctl_rpc_cxl_out, payload, count) is not
the right bound here: @payload lives in a union whose largest member,
'struct cxl_mbox_get_sup_feats_out', is 8 bytes, so
sizeof(struct fwctl_rpc_cxl_out) already covers the first 8 payload bytes
and the resulting bound would reject valid requests that allocate exactly
the header plus the Feature data.

Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/features.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 0ab1a8547b7e..b631643ecc7a 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	if (!count)
 		return ERR_PTR(-EINVAL);
 
+	/* cxl_get_feature() writes @count bytes at @rpc_out->payload */
+	if (out_size < sizeof(struct fwctl_rpc_cxl_out_hdr) + count)
+		return ERR_PTR(-EINVAL);
+
 	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
 		kvzalloc(out_size, GFP_KERNEL);
 	if (!rpc_out)
-- 
2.43.7

