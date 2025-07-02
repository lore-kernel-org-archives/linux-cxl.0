Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22021C187;
	Wed,  2 Jul 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751440872; cv=pass; b=kDYzp1fZY+ZO7xjPgzERB+yV3PcQumEHdJOWBTaEvbMp3++9f6K+D5m+lQAk30Vz1WrIZsvsLZGef9qg+Jom72rP1/nvBk87SOprR/jB+TvBbOqUBl/pdV/nb/YJvoVRqUIAIUtA9ennEqaZUOvI5fHvVrnbHdKM1dWw21Llxrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751440872; c=relaxed/simple;
	bh=S114L2iaIYpkVV4VfzR0lfxqoNVY5F/Xzs3RQMO7MKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwLlaxWaqJWReBjmlyRSi488WRp/zfOk9wIrtQR0QBEPcwn6vT0TnuBCoRdOg9wOEcU+7aC3qHkfZyZ5ChEKXIbdrfLJemTxnqc+tmw75GfEWYu4QVcfnT/m5WRJKooqN3Nhp9YHx4+B6KIjWR0negXF1mnxrbGWxS0oURuyIaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=a8dni1CT; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="a8dni1CT"
ARC-Seal: i=1; a=rsa-sha256; t=1751440846; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DxyfkYIln57eBfe2zNSyP0brpSr/at/3WdFKK52iHEbEsZSKFHksX3x2Nqwuev8vWCc2nXr0fmBkIJV81YMbv4b0/VC6r/K4z68X68U1/TwiBeGXw3TSKo2dpiyGMNpcEX26AlER0kHVbhw/7GdNSIO7gCj4FtBuwNJvf+7fUwA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751440846; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z8b+DydmPobt0XiakmL63ZHpV1KAKyIZRoX6dUVOoFo=; 
	b=W+LMuO7NfaRVnkNsVXEEA7NTyac11H/TxbLSHdCQ96RigBPJ0lhsiotOP2OoC9ZFHSGgKEd3yrxtDpuZZDE8H4P4GuelJ45AddETl+ADuBMWSsQqjZUMrdcE6L8jl8yorS9/rnJGfVILdUXWlZDNqI/ajJws/sQbbF/kDofLqjA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751440846;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=z8b+DydmPobt0XiakmL63ZHpV1KAKyIZRoX6dUVOoFo=;
	b=a8dni1CTMkkFD8gQEJTWH2IJOmZVn/5vVbPhl5p16Qt06HgvzRpxJaBvAMOfzMj4
	g2UCXZ5Wj33HdO/edZ8Dof0GJBXyEx2a4Q1kcQqlmwZdgX8ZIo8EDT6AS1Psn7ORVWS
	yLTiwEEIwSZqfd76n8JMnPQJXGG31EJYZV6/6gDY=
Received: by mx.zohomail.com with SMTPS id 1751440843487415.9172586350676;
	Wed, 2 Jul 2025 00:20:43 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: akpm@linux-foundation.org,
	andriy.shevchenko@linux.intel.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2 1/3] resource: Introduce a new helper resource_contains_addr()
Date: Wed,  2 Jul 2025 15:20:06 +0800
Message-Id: <20250702072008.468371-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227599239ccdadb5c9849b19b200000f02c86e50e45b52f4b2e8baa756ef6ac1f515f44947a93330e:zu080112271e459cd3a74e67f702c8d8be00004dbf5dc542a7c87d5397a80306c82eb8a90bf37d3075b51c6a:rf0801122d0a779dd16595c0016ffa114a00002c56a1600733c67c49d05629c4ebc0aaafcea26e2fdbade9a4cc1b0242a885:ZohoMail
X-ZohoMailClient: External

In CXL subsystem, many functions need to check an address availability
by checking if the resource range contains the address. Providing a new
helper function resource_contains_addr() to check if the resource range
contains the input address.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
v2:
* Implement a general helper resource_contains_addr(). (Alison)

base-commit: 0a46f60a9fe16f5596b6b4b3ee1a483ea7854136 cxl/fixes
---
 include/linux/ioport.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index e8b2d6aa4013..75f5e9ccd549 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -308,6 +308,14 @@ static inline bool resource_contains(const struct resource *r1, const struct res
 	return r1->start <= r2->start && r1->end >= r2->end;
 }
 
+/* True if res contains addr */
+static inline bool resource_contains_addr(const struct resource *res, const resource_size_t addr)
+{
+	if (res->flags & IORESOURCE_UNSET)
+		return false;
+	return res->start <= addr && addr <= res->end;
+}
+
 /* True if any part of r1 overlaps r2 */
 static inline bool resource_overlaps(const struct resource *r1, const struct resource *r2)
 {
-- 
2.34.1

