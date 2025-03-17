Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D121A452;
	Mon, 17 Mar 2025 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194933; cv=pass; b=VM/7kT+kzHlbDLkFMt6cdTR1Q+0HMO/ujlF0FxJRMOJScRDRGeerbL26oKuavTHeaSeNUqfKNA0ZS6EsTo8vZuy+Q/Zs5H12lmgpXc6HBJi6CTAUuyfq+cBNPBAitFQ5WHbQXt+DI6ZUZXSFawmBrbBLn8q+Of8HFY6Z6FpS8Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194933; c=relaxed/simple;
	bh=8fReS3rxRVLc5d/1XePRj/z4Ry1ZED+zpk3vKn3fSUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pv1tAAf3sTBR1rKsdlaBL1tkJ5QcCKlCVI7MrhmXcIgERrh8IKh3j/9hF5A1rkhc51+HB4TJe81Ubrv3EWsqiaQnOlD9uKR+3Lt2mGpAO7OKKMaHOQWImXR+OPyXG6WLM0q7KMCjS1Yen8IC2X46AfPNer5W2TxupW+mzrZblGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=JMH2Q7ha; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="JMH2Q7ha"
ARC-Seal: i=1; a=rsa-sha256; t=1742194916; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O4xq25xONEXQxWg4pE2JZ+7l5PoPdDZxyOgotY+QAhcM8XFFBp52rDPHbzSf4o5AUhA36Bwise4gqqv4gRoKrqc6dhLo+UH73GAYAfwdF6kCpkDpBQqDglXgw3ngwe19gQ7mCnejolI6GcCZLZsscVFvHm7hEe4aiRPaLuh7tXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742194916; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j7VLNHpvlqympmTHXfhbQdNBsjuGwlw6SBiAnCPTfQE=; 
	b=e+7qFKZCrSQ+uqMyIIKTJ/NAIcYVEk1ErmnoUHO1VWuHyhYpmWINWrS6Vi1Xv7PImpNcBirbU/Mc9F7PymYFkMn6L9Rw6/S4suILozN8L5h7dmSKnOyz70aigmrHo6pHWvdErRxZMS6fPCvzq9Po/JmTmuF6+mztmoLKNXUrz5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742194916;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=j7VLNHpvlqympmTHXfhbQdNBsjuGwlw6SBiAnCPTfQE=;
	b=JMH2Q7hajefkUkt7i4zanZrItjWFNx4FCKbJNs72EG5BG7LYAFzX1HhkFFgBXs2o
	Jae3ULTCNlL5KjB+vpumX/cIw5P0sJXNE6LHXWM23dmSgB8NF9ZRSmwayuM/d4oD0S6
	shzPPJVx26pAMEWr0bxemc/g1ry+kMziu0OPlh1k=
Received: by mx.zohomail.com with SMTPS id 1742194912719350.78126542977304;
	Mon, 17 Mar 2025 00:01:52 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/1] cxl/region: Fix the first aliased address miscalculation
Date: Mon, 17 Mar 2025 15:01:24 +0800
Message-Id: <20250317070124.815028-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227e788ca486aab4208182a1cab0000b35e43420a2b75935596d1412138f64f148e61396ad1b5d4f5:zu08011227fc7aa54d9e1a2d7e3346b5fa0000b234697d1a157c4cac0af96a601a0d03cc4ed46ac4beec2f36:rf0801122d59bd6280a59f82665331de6d000072a928510dbd8bd066b863ea7c12d0cd486603449d7ffc0f51c2fb4e535f74:ZohoMail
X-ZohoMailClient: External

In extended linear cache(ELC) case, cxl_port_get_spa_cache_alias() helps
to get the aliased address of a SPA, it considers the first address in
CXL memory range is "region start + region cache size + 1", but it
should be "region start + region cache size".

So if a SPA is equal to "region start + region cache size", its aliased
address should be "SPA - region cache size".

Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6d8bdb53f258..c3f4dc244df7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3460,7 +3460,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 			if (!p->cache_size)
 				return ~0ULL;
 
-			if (spa > p->res->start + p->cache_size)
+			if (spa >= p->res->start + p->cache_size)
 				return spa - p->cache_size;
 
 			return spa + p->cache_size;
-- 
2.34.1

