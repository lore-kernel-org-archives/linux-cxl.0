Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21402566
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 00:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182698; cv=none; b=lRCiUYZ9DI53ossBocRzgJaAsT+8d8Nc//tRfwihm40liq1JkP6SV04b4Y/heYy/8Rkjl/ch/FazdGLPPBg+aIM/aC+V8zEicm6A7l/2q3RSCPZbL37n8vFJHpNuZOG5ic10WJQESuz68+7KspXUoG3sohCL8D8YYIvWSt5SX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182698; c=relaxed/simple;
	bh=4bRnpWyIomTvL+JDFF9OWsEmsl4cL/1Rp/99rRr5/d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB1/xo9zlAENLZS8u0fFJXkWR1VFVBM9WL5LBPYjSIbVZdVPk1Pwb4X3d1ScfKgKmXrpabZNe3VsAJP+DTGLLY1hTyKVmRTik2+cjf6x515Y6iToIwlWJDzIycku0nV/AJUXU7vxMSzIhttgvk0SGAMBwSzP2Dt50XuKSKK8Myk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E43CC4CEE4;
	Wed, 14 May 2025 00:31:38 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	gourry@gourry.net
Subject: [PATCH 2/4] cxl: docs/platform/acpi/srat fix memory table misalignment
Date: Tue, 13 May 2025 17:31:31 -0700
Message-ID: <20250514003133.584401-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514003133.584401-1-dave.jiang@intel.com>
References: <20250514003133.584401-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the misalignment in the SRAT table example.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/driver-api/cxl/platform/acpi/srat.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/cxl/platform/acpi/srat.rst b/Documentation/driver-api/cxl/platform/acpi/srat.rst
index 56d7bbb18c3b..cc7687645de7 100644
--- a/Documentation/driver-api/cxl/platform/acpi/srat.rst
+++ b/Documentation/driver-api/cxl/platform/acpi/srat.rst
@@ -39,6 +39,6 @@ Example ::
         Address Length : 0000003CA0000000
              Reserved2 : 00000000
  Flags (decoded below) : 0000000B
-              Enabled : 1
-        Hot Pluggable : 1
-         Non-Volatile : 0
+               Enabled : 1
+         Hot Pluggable : 1
+          Non-Volatile : 0
-- 
2.49.0

