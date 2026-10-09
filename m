Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95AB3EC82B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583937; cv=none; b=La6Y5+RZfQtuaO2Mk/Vfwrw6mZCtx5G/CjuFdtv5ICE3xmImhqnLqx2bcwIoOxA4bjirgk38yo44hjN5Qx3f9n5oDfHwNVqkafFinmlmVdMsLBe8V5Rc6TYEKvqF+knsvUlwZ9X+HnBGemmlc/xkd/DBpQcQE4nUdSkKeL6xsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583937; c=relaxed/simple;
	bh=QhWVRaj+D3gYcE+C0btHQ/apNXtyTrFZ+9RW2tXzNDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJJWpiOeK2Ck3bnjp1bdWZ36EqJCWJP5OJBWMQJb3yk1RAwoG/uSkLbcp/9XSpEo9EOipOuV644X5WDWfiuDLKpezhpqDYciE5ZigYm7IO7Xdvaw4cQ+R9vmwcUcc7tUlCW2Q1rzX/AbbWhhP3PrmLYcGtTQBsj/nR5Q4PMrdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpP7qU0N; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpP7qU0N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791583933; x=1823119933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QhWVRaj+D3gYcE+C0btHQ/apNXtyTrFZ+9RW2tXzNDU=;
  b=mpP7qU0NJlYRjKzJZvQ6s0pfvP8XlYvdAMff8Wl/W18A2UXLNC+0WIQ5
   vAYrQ5PwzcssLbQXbDMDbFd03X0WAn09/T6EX5/MhfZFm7mENxeMqb7pl
   O76zWmYhFHzOtZMCY8ha9o1YRf8Gk8ld+KzVx9ClRuWpw+EsooUBGAWG0
   9ksdRbB6GHZzhXVSGjEvJPvKTMtd1GSQZkFrmCxXRSIaztYmvEd2o8BoY
   iNLNz71i9pJkcRUhKDOKrhOqKDzOcUXKhG6YYO8E8jfjd0jVt04Xkeqmx
   vqNAdrMU/zjL9t0yGbJ4EhmbeDpo8TI98EzZujw09X1KV/KLnBCI28qPa
   w==;
X-CSE-ConnectionGUID: eTF7qxBpQGuZLRJ7VuQFsg==
X-CSE-MsgGUID: GyHxxPGyTA+FqAe736/KnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="294825"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="294825"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:32 -0700
X-CSE-ConnectionGUID: aBYZb12hR1qXvZx4Kn/L+g==
X-CSE-MsgGUID: 2y5ewVcNTEGhJsrAX0LCsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="505706"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:11:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/3] tools/testing/cxl: Preserve DPA skip across mock decoder reset
Date: Fri,  9 Oct 2026 15:11:21 -0700
Message-ID: <6885e00e91e676dddf0de71722d16c8ad4dfe52e.1791582353.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1791582353.git.alison.schofield@intel.com>
References: <cover.1791582353.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mock decoder reset clears the DPA skip before releasing the decoder's
resources. This leaks skipped capacity and can cause a later DPA
allocation to fail with ENOSPC.

Preserve the skip until the DPA resource is released.

Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 tools/testing/cxl/test/cxl.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 62bd92b3be45..aa140307e0c3 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -913,15 +913,13 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
 
 		cxld_copy(&td->cxled.cxld, cxld);
 		td->cxled.state = cxled->state;
-		td->cxled.skip = cxled->skip;
 
-		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
-			td->dpa_range.start = 0;
-			td->dpa_range.end = -1;
-		} else if (cxled->dpa_res) {
+		if ((cxld->flags & CXL_DECODER_F_ENABLE) && cxled->dpa_res) {
+			td->cxled.skip = cxled->skip;
 			td->dpa_range.start = cxled->dpa_res->start;
 			td->dpa_range.end = cxled->dpa_res->end;
 		} else {
+			td->cxled.skip = 0;
 			td->dpa_range.start = 0;
 			td->dpa_range.end = -1;
 		}
@@ -1001,7 +999,6 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 			to_cxl_endpoint_decoder(&cxld->dev);
 
 		cxled->state = CXL_DECODER_STATE_MANUAL;
-		cxled->skip = 0;
 	}
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
-- 
2.37.3

