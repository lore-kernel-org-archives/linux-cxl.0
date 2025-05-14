Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB971270ECB
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221616; cv=none; b=B/Mo4qn3AirPPfg2VfELPOG8lI5tc/mByjE/0Aj09dDIas9TBE+Gnvz8QjpCkR3MDidRqjvN4h6Y5quTU86AkuitBVzhnQcg3PvF7Jtmxn0ZnSBIz44MfDs1AlipBK8qh6820qAFh1ek3xersyVUai0/u/byiYPBiq+bFoOAxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221616; c=relaxed/simple;
	bh=u1gyMu2RwQGgA8FqGP3eyYVpifNrScbjzpm3kWhWy8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZdIxKjhkk0oWnpDN7cry+rSiyG/hg52IiJvZpb2SOpw0jxaYiGFyf3azO8tGejZz5bVw5Lxj4kZucT+mSY29JjWp6lGvrW9QIPTu78cGW2F0SWqccHzYzWlmiIj9o2OXln9x5puCyZqbXvgB8Ezn+DlTgq+usyMGF6No3awCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NS+6PaMF; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NS+6PaMF"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1747221614; x=1778757614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u1gyMu2RwQGgA8FqGP3eyYVpifNrScbjzpm3kWhWy8w=;
  b=NS+6PaMFxuZMoj9k/sdn1b2M2GhTMr5dtglhHgnJu/K7VAwv6crkVMEJ
   DKDKmWPeO/FwnvPEFKQGVFLKS2ZHzgaR5V+G2+4596T+jF2wqvWQ+W8Il
   e9kEQrmJksXeq023+4mDLkcn1/gAjkYyT8NscVEiwYtt2vQQK8sBh/GaR
   Wsyu+XdRNLhZnQeA6s15CJGJOi4xAOnxlEumMPHx/5+8hEjoywx3HhTE0
   TX9s/41XnxKB9KNRP3PbuIYhw4LAc2ibnxA9ZuU817Rl1KSLVvGnd8Eel
   byLQSfGiwQovP+AYoHBe6xpVEkaedL3SYLK8Bhh7LP6AYCG8FnC+D+KEc
   w==;
X-CSE-ConnectionGUID: NztIYZOERa2vJS16OhP4hQ==
X-CSE-MsgGUID: 1uk8gwEjS0673rtfszolBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="187393647"
X-IronPort-AV: E=Sophos;i="6.15,288,1739804400"; 
   d="scan'208";a="187393647"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:20:06 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F01BD5004
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 20:20:04 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 507DED506F
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 20:20:04 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8DC831A0078;
	Wed, 14 May 2025 19:20:03 +0800 (CST)
From: "ruansy.fnst" <ruansy.fnst@fujitsu.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	sunfishho12@gmail.com,
	Ruan Shiyang <ruansy.fnst@fujitsu.com>
Subject: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
Date: Wed, 14 May 2025 19:20:03 +0800
Message-ID: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruan Shiyang <ruansy.fnst@fujitsu.com>

Now that cxl_wait_probe() has been added[1] to wait for udev queue
empty, the `udevadm settle` here is no longer necessary.

[1] b231603 cxl/lib: Add cxl_wait_probe()

Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>

===
Question to Dan:

I understand how cxl_wait_probe() work, but I have some questions about
the motivation of adding this function:  Firstly, is it function added
for simply waiting for new added CXL device been ready before cxl
command does the actual work?  Just for replacing `udevadm settle`'s
work?

Now I am facing a problem that cxl command takes a long time to complete
when I run it in a udev rule(do some configuration when CXL memdev is
added).  I found it is caused by this function: waitting for udev
queue's endding but itself is in the queue.  The cxl_wait_probe()
function does not seem to allow me to do that.  So, the 2nd question is:
is it against the spec to run cxl command in a udev rule?
====
---
 test/cxl-xor-region.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/test/cxl-xor-region.sh b/test/cxl-xor-region.sh
index b9e1d79..fb4f9a0 100644
--- a/test/cxl-xor-region.sh
+++ b/test/cxl-xor-region.sh
@@ -14,7 +14,6 @@ check_prereq "jq"
 
 modprobe -r cxl_test
 modprobe cxl_test interleave_arithmetic=1
-udevadm settle
 rc=1
 
 # THEORY OF OPERATION: Create x1,2,3,4 regions to exercise the XOR math
-- 
2.43.0

