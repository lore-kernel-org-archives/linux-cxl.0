Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53403A6EE4
	for <linux-cxl@vger.kernel.org>; Tue, 10 Mar 2026 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110498; cv=none; b=PWXN0tPmvdJMlytnHNuE6Ppypwi/CRYsWuur5OE7fgaQN7g4aDVLTNeWb4ECvOEGD1BXlVwS2Mf8IvtVluP4Rb86d9S03c0fOn6K6V/GYEu2X9gzSjCK9upsM6WgQvUczsThoEVjnTzfbOTPE7xpLrSDG1DQZsZdPnwLi5p8L1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110498; c=relaxed/simple;
	bh=UDCqHsO0bvzEg/LOF8GOb2oCSs2kkC8LVW9VWP5NtVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbztjG3XJYweq7BNuY3GTY9mUXUAfClH/puorJUE8Y60eoil+s2kC/2aj7X7FPzuWhPUvKmjp/vzFJ2tPIIIpLoTkCy1ymEBhJXeQinO0/CRPnnQTZyr/+w3QT9LH7hG4LIeuGW2pnY1/81+F1N7PT45AHOxTNaF9AsyLJMBz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DLJeqp5v; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DLJeqp5v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773110493; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=h7qbBvFJ3FiiQqx/jHT7Plqms1SRMB6Kj1f8rjsskFI=;
	b=DLJeqp5vWU6vfd+N/9PWlZGiCKkPb7l9su4icn9mePFBPClzOCyKH21vBrxlfn0KAgtnJ2wO4UOwYvm+5BvpVUVSPCk62J5JiNcTLrkaMObO64XdGqYsvwSmGPsrCQd10I2uV3LICYGUq7vyY/WOpcxFGb3uIcZ+GyxZ6FWzotY=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X-eASE7_1773110492 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Mar 2026 10:41:33 +0800
From: cp0613@linux.alibaba.com
To: ishal.l.verma@intel.com,
	alison.schofield@intel.com,
	nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [ndctl PATCH 2/2] ndctl/test: Fix meson configuration error when fwctl is disabled
Date: Tue, 10 Mar 2026 10:41:02 +0800
Message-ID: <20260310024102.25682-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310024102.25682-1-cp0613@linux.alibaba.com>
References: <20260310024102.25682-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

The meson.build script unconditionally references the fwctl
executable in the depends list of test definitions. However,
fwctl is only defined when the fwctl build option is enabled.
This causes a meson configuration error:

  test/meson.build:283:6: ERROR: Unknown variable "fwctl".

when building with -Dfwctl=disabled.

This patch fixes the issue by moving the test dependencies
into a conditional list (tests_deps) that includes fwctl only
when the option is enabled, ensuring all referenced variables
are properly defined during meson configuration.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 test/meson.build | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/test/meson.build b/test/meson.build
index 615376e..a4e3805 100644
--- a/test/meson.build
+++ b/test/meson.build
@@ -267,22 +267,27 @@ test_env = [
     'DATA_PATH=@0@'.format(meson.current_source_dir()),
 ]
 
+tests_deps = [
+  ndctl_tool,
+  daxctl_tool,
+  cxl_tool,
+  smart_notify,
+  list_smart_dimm,
+  dax_pmd,
+  dax_errors,
+  daxdev_errors,
+  dax_dev,
+  mmap,
+]
+
+if get_option('fwctl').enabled()
+  tests_deps += [fwctl]
+endif
+
 foreach t : tests
   test(t[0], t[1],
     is_parallel : false,
-    depends : [
-      ndctl_tool,
-      daxctl_tool,
-      cxl_tool,
-      smart_notify,
-      list_smart_dimm,
-      dax_pmd,
-      dax_errors,
-      daxdev_errors,
-      dax_dev,
-      fwctl,
-      mmap,
-    ],
+    depends : tests_deps,
     suite: t[2],
     timeout : 600,
     env : test_env,
-- 
2.43.0

