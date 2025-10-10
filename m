Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0AB256C91
	for <linux-cxl@vger.kernel.org>; Fri, 10 Oct 2025 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129882; cv=none; b=ZEl4/sr0gMIZ2bFQKN2kofsC+Kc9PqEFKuPklfQ9mf7x6mJPExQ/Jtu2fTZrkZHRgdy4iW4vA4OBKv2rAF79pDM1s9viiJFWsEDgVrFgknM61Qct4tfeiXJFQaqOEpRg6MM3+YMqAcWOZ+oYbQoPxHdwFzZua211wUbiX24kt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129882; c=relaxed/simple;
	bh=nHCQvMR5ggSnNy/WvWEkS4DxA0yf1P85LRNCznhHFCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdUFe9ig2r1lSYv7zJ3HUQP/ojz4ISUQHwpOsYX+WZYd5OmPUndH6lu/EzJhu7AYh0TGVqJMSIJkBb79LB33WbCv5+3C/TOKGchb4c5ypflmW9uP3O/tmpizcJ1GMrYs+S5QnIWVdW67KeukRVuVb4a53LZ1TJ0ZVUTZrhf2L2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34891C4CEF1;
	Fri, 10 Oct 2025 20:58:02 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 2/3] cxl: Set range param for region_res_match_cxl_range() as const
Date: Fri, 10 Oct 2025 13:57:54 -0700
Message-ID: <20251010205755.205280-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010205755.205280-1-dave.jiang@intel.com>
References: <20251010205755.205280-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function takes two parameters and compares them. The second parameter
should be const since no modification should be done to it.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..0ce50998c49f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -831,7 +831,7 @@ static int match_free_decoder(struct device *dev, const void *data)
 }
 
 static bool region_res_match_cxl_range(const struct cxl_region_params *p,
-				       struct range *range)
+				       const struct range *range)
 {
 	if (!p->res)
 		return false;
-- 
2.51.0

