Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE820323
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647817; cv=none; b=Wi0u8RSNDDcl9l36RYSkXXr2xWRbWIXUwptcZ/OQmwNkkvxkjiOsIC1O81+hwaQb7ztUhN2vCYVI+3RzV2+pat2MoeNCF0uIfwKaz15Fe5gb3IxMaN7hFrDGMvQ7fb8i8GVnN8yi1nrAzLyivFBPQKJi9zoVCQWoee4Q4JJp/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647817; c=relaxed/simple;
	bh=dwNJEPj6jHE8CJs/VGrofccHyDyGMrVYwMK3E8SxFxY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9gCHEKagMlB22LiRBnrDr4RK82X6J7n/HLAVC2091A+bRx6XkdWthdEW+OemazdZ/mQyEYtUTOoslFjpJHczBsi+LCvXTz3ptOgxrBw2CB/QrZeOmecAEgKEyxdQvlK1nGJQ6lHvauHfukVHiDxYLjNsun2YP5H/8N9f8ORakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sb6UDXEk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb6UDXEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729647815; x=1761183815;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dwNJEPj6jHE8CJs/VGrofccHyDyGMrVYwMK3E8SxFxY=;
  b=Sb6UDXEkxHZNmva6JK0IUhHb9U6ZmImNJ1nD4Q5nhp1/bBrCP4h8q9IK
   DjbDyw70ERUCJThuChXcf2xSAYPc9tH2V3U0zoY3QlKmQN0/up1Tmi9Kh
   8wo7RvY3tmY1H9X1bldr0X/i8zdFcHMem4Q2PczysSVL5Gtoexv9Z06f3
   6StnArzhlkzjW39Oa8NdRIhLDYLmLgfZ8ZJqJWNWfywGOci9OfuieXEG/
   S6NAfcH9Z7P3tFmkF8W8M8+/7XRvmVANzjp9QrI0SEl+novIrDDYq1mkF
   USSKX1YXATOjhYG+zjXLXA4t0x2zzSySfllelOXbMmfobvtZ16AaQyXMg
   w==;
X-CSE-ConnectionGUID: 3tLA65WnQHudjTrBz1rEuQ==
X-CSE-MsgGUID: PZkkgdrsS1S7Vgy0oxS3rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28658053"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="28658053"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:43:34 -0700
X-CSE-ConnectionGUID: A5sJ9CMKQKaDfFLJv4akpg==
X-CSE-MsgGUID: XKNHBFwMQs2mMbQSOZKAag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84630734"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:43:34 -0700
Subject: [PATCH v2 2/6] cxl/port: Fix cxl_bus_rescan() vs
 bus_rescan_devices()
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com
Cc: vishal.l.verma@intel.com, alison.schofield@intel.com, dave.jiang@intel.com,
 linux-cxl@vger.kernel.org
Date: Tue, 22 Oct 2024 18:43:32 -0700
Message-ID: <172964781104.81806.4277549800082443769.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

It turns out since its original introduction, pre-2.6.12,
bus_rescan_devices() has skipped devices that might be in the process of
attaching or detaching from their driver. For CXL this behavior is
unwanted and expects that cxl_bus_rescan() is a probe barrier.

That behavior is simple enough to achieve with bus_for_each_dev() paired
with call to device_attach(), and it is unclear why bus_rescan_devices()
took the position of lockless consumption of dev->driver which is racy.

The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
is merely by inspection since the bug that triggered the discovery of
this potential problem [1] is fixed by other means.  However, a stable
backport should do no harm.

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e666ec6a9085..af92c67bc954 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2084,11 +2084,18 @@ static void cxl_bus_remove(struct device *dev)
 
 static struct workqueue_struct *cxl_bus_wq;
 
-static void cxl_bus_rescan_queue(struct work_struct *w)
+static int cxl_rescan_attach(struct device *dev, void *data)
 {
-	int rc = bus_rescan_devices(&cxl_bus_type);
+	int rc = device_attach(dev);
+
+	dev_vdbg(dev, "rescan: %s\n", rc ? "attach" : "detached");
 
-	pr_debug("CXL bus rescan result: %d\n", rc);
+	return 0;
+}
+
+static void cxl_bus_rescan_queue(struct work_struct *w)
+{
+	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_rescan_attach);
 }
 
 void cxl_bus_rescan(void)

