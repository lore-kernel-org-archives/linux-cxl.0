Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BB405C5C;
	Wed,  2 Sep 2026 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788393269; cv=none; b=H2GilEsC9VmPeCx37PNZde40C5fGFljy2qILvQysR7qtNDvcvaIwUHevyHOs/0M5BNTqn9Nm2fq5FQzv/Q8RAyZoRlvI6kCITMT5xqYi8Zq1uUKWRJHavgVWfem9x3HK/Izj8dGRicWNkAuvqqCLhkJsmQ3QRqg/dOk/Vu2JYos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788393269; c=relaxed/simple;
	bh=VjTrOPNyyHmmJn44xY1gnT/VJVlYsMU5Bael5W7/Lkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKuM2ihWf4FiRf6CbbERIVXzfOGlAf+PjuKxjMH9+V+CWNDCD9UmsJ8gZX8TO2EMV/7CSmce7jzvafmFkqkObhYO6fvzbsc7GY1cfDlnDEw35hrQ7jvJdVkHpjesYWHpaonZQuuzCG55WoNL2EysyojdDRBLkvftwoc18CWad+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B697C1F000E9;
	Wed,  2 Sep 2026 23:54:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] MAINTAINERS: Add Richard Cheng to CXL subsystem as a Reviewer
Date: Wed,  2 Sep 2026 16:53:48 -0700
Message-ID: <20260902235348.3563444-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Richard as a reviewer for CXL subsystem.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..25d61ce9506a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6567,6 +6567,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dan Williams <djbw@kernel.org>
 R:	Ira Weiny <iweiny@kernel.org>
 R:	Li Ming <ming.li@zohomail.com>
+R:	Richard Cheng <icheng@nvidia.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/cxl

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.54.0

