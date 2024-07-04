Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89784A39
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053502; cv=none; b=EuLlwmNGqcsDd3RJluoe1ZDS3L580lzsvKmoeuhdbhFw3qkkfGt9naZf1hbpFoZF2L7qUjinVzo/iFlGIjEFSyhcsS3qZqXtFrt4NJdZgW0GHu7NnYufq//RDMlpGypHOWjk4Yu2y2ZI+UFWTXtkII4QKC7j5DxLUQRbI+NoFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053502; c=relaxed/simple;
	bh=yeFjQXLd6tPDLlfnIp++6OSupggtmbE6CSYJ0l5nQZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZGJOpE80uN1nrXRDKYr+TDykUt7u6vw3XwgZzFRLSRio9ercgBCataBwR8+lGFy6qk4qqSUuXXrgVYeCgmm1iXXvLxYHNILT8zp4u/VwHsSJAojFyoUPXovo7hPE3jDx0TQMCRj9YqdchbfkqrwnD+fcXZVc+ksdARhddm34UJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBXrxIHO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBXrxIHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720053501; x=1751589501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yeFjQXLd6tPDLlfnIp++6OSupggtmbE6CSYJ0l5nQZ4=;
  b=BBXrxIHOZkMWPitfYfGB49Flo1UtiejvasZY4UQhmKs78ZrmXjPTKK6O
   bam7CwPhJvIvGYjYn//M3XTl448UAfN/g9BPERgBYJUn+xMQpzhGIokR1
   ytDqa8QOiuE2mLPkSlHvF12dEgsNNjldB4V9QGvK9iGK15NM8SLY+4dMS
   emfxYt6738xWaQzL7zni3A9Y6cbIT45Ubdmwp9mZ8WCWnLRkJ1WEjVi7X
   dztbq0Kme9cFiooeHyYJIlSMyEQHrdO0RI2ilUXDIfDf5uYJVpibSr4Mi
   U/D0xiP7n6RmXQy76Vpf+yedNq5Mys6atNUwXBNVijEvHJFHqsGuCTcK1
   w==;
X-CSE-ConnectionGUID: SQr7MjC4Q+iWz4/dEFSxag==
X-CSE-MsgGUID: aL0/orDRQhizXXhYGOhd3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17178753"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17178753"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:38:20 -0700
X-CSE-ConnectionGUID: kSgBSNS8Tb2mybFcl6SvNA==
X-CSE-MsgGUID: PrvLrwL6QVOSeB50ryMsCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77579909"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.113])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:38:19 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] Return EBUSY on inject poison limit reached
Date: Wed,  3 Jul 2024 17:38:15 -0700
Message-Id: <cover.1720052137.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Validation users are asking for the ability to recognize when
their injection testing has hit the limit of the device.

Change the drivers error code for this failure to EBUSY and do
the same in the cxl-test mock of inject poison.


Alison Schofield (2):
  cxl/memdev: Replace ENXIO with EBUSY for inject poison limit reached
  cxl/test: Replace ENXIO with EBUSY for inject poison limit reached

 Documentation/ABI/testing/debugfs-cxl |  7 ++++---
 drivers/cxl/cxlmem.h                  |  2 +-
 tools/testing/cxl/test/mem.c          | 13 ++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.37.3

