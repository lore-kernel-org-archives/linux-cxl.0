Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E519258C
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624854; cv=none; b=f8WgqWT+L8bqNsfFjt2w19Lc1+/kxHgu7pCgQ3LPEOFjfMfjGC6c8l7OGQgwYXM/bBdPKMtx1zaoqB5urAHD1i0v8T3pLlxTcDpUe6+KOjpCvOVJKbuoYvtZb23sfW4T/CkbejJ+xOYleNdI4ZP7mIjIayBAYs3x1I+XD4AiTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624854; c=relaxed/simple;
	bh=6XKBmBurizIDsKL/ClGY3T4qE+YKUGlekxva2IKnRIc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUZVCRlz+H1RdJLSQMQlhI3Cr1Q8e2L2s6nBs/gW8Sqsgdfy2Eboe2YVp6pmQxRLaI9Ans5o7ec84oZULSg53QzTeH+R6rSlpLCUoeP++orwRGlKCBcSK+wbfrkoFk3EyGyjUocLAkHupjUjrtUe0dn2Ez9C8sSgMMWxjD817iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CD0N1VLx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CD0N1VLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728624853; x=1760160853;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6XKBmBurizIDsKL/ClGY3T4qE+YKUGlekxva2IKnRIc=;
  b=CD0N1VLxcAKrXa0pFvyrZSii06VFxbBagUrw1L81P7GhXpkQj5niYf1O
   HfdA9F+DOexs6sqBZXQz9kWA8sjyw5MpU6XFIFrDC1CgEsFaEPozQDa5K
   uG/Y2O/M++RwaUaLSRDD7wSvARXpMUzrIAFcPJR5LVxgoKK0R9QdSPaAp
   Hev3RC8mqb0lZwqxH+8FBMVSDqj2d2Gh4htb5t6cn+nOayWqnN8v4ybb5
   6TNlqmUD53BwKe08HFyQtWYhZqPacTtZLHXFnj/F54mxEyTA/xw8guoKs
   OyvxtUe4K8muW65LFtmv5Ka56IIcBxi/43gy8lUWxPEopW3+cBHScU0Bn
   A==;
X-CSE-ConnectionGUID: U5jSKwd5RmOYeUd+g0/QqQ==
X-CSE-MsgGUID: xwgAVo1BSoe1+QxIq/78Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="53416711"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="53416711"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:12 -0700
X-CSE-ConnectionGUID: VP0D2cswR+CiBaMxuGznnw==
X-CSE-MsgGUID: 9ZdE4PJOSROCERjgd7HXAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="114262259"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:12 -0700
Subject: [PATCH 2/5] cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com, ira.weiny@intel.com
Cc: vishal.l.verma@intel.com, alison.schofield@intel.com,
 linux-cxl@vger.kernel.org
Date: Thu, 10 Oct 2024 22:34:10 -0700
Message-ID: <172862484920.2150669.7306809902566347902.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
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
took the positition of lockless consumption of dev->driver which is
racy.

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
index e666ec6a9085..b7828b6c7826 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2084,11 +2084,18 @@ static void cxl_bus_remove(struct device *dev)
 
 static struct workqueue_struct *cxl_bus_wq;
 
-static void cxl_bus_rescan_queue(struct work_struct *w)
+static int attach_device(struct device *dev, void *data)
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
+	bus_for_each_dev(&cxl_bus_type, NULL, NULL, attach_device);
 }
 
 void cxl_bus_rescan(void)

