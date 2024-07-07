Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C74A38
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jul 2024 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720317230; cv=none; b=n7pnpxpBQuC0CsOJtxfcSD4JB3UGlt15KLaua6kOYANW5P1RV4osDCWxA5iAXP/I1mQYash85kxc6AJ0LVhhqN+agBZUChW7rMFzbV89xO7OYf8nHtFwci6YMyLTkt1GjQMywmM33jU87iEIjHNrTezPQeA6nWaX6WV9Q+32PNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720317230; c=relaxed/simple;
	bh=wJd2PXZfooHANQm+s1DLQNKghqcFrh4f3e3lL9mVnVU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZKF46xc/Dw5OSs4aCxKGPdDLKThoSgBn0FcOhdj8yP4CkWPNQ00KDmLTlPssutBTH66wTJSLtMZrixqmhcZs6Wjok5OF5zbKWavHmK+p0kF2BtTRx9xQV8kgEu+2JS+jeIfBYsGmCB4y2J4FsALIOAN3yfw6E1AKsfpMiRrf5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sw9gMRJI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sw9gMRJI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720317229; x=1751853229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wJd2PXZfooHANQm+s1DLQNKghqcFrh4f3e3lL9mVnVU=;
  b=Sw9gMRJI/VchrNkeUF/0TSwoMTHGGVt0C3zIME/diAH0kfX7tZLvqsQP
   1Pdd5xQszwII5SGsCM/yJ5rPwmBGTk+AcstPfI2f8/SsZwbjfW9KvbYNV
   kw5xbngqta9Cv0rePcQRxIrJNh582pVslZmKI/XZLN8eFznt4i9tuLeW9
   90YiFSEyc5cQG+s9adADa+XyUx/bzE0ydnSBK9a7G6QGTogvAXzDrxPdM
   53MFfZeb668vzvLY6DeP65Yo+MLzwj7GteWkD/L6JdW9D5PREGqbrAnT9
   zC9yHnRvAV6D9L60L+BWRG76TZFhE8YYtdTQ/EbFPGor9XME2r2JfLFAX
   g==;
X-CSE-ConnectionGUID: YC6WlLGRRvaZAi1tFWoz3w==
X-CSE-MsgGUID: H/fiN/kZTvO6JIwjTZh7pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17680728"
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="17680728"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 18:53:48 -0700
X-CSE-ConnectionGUID: lcIgm0KRQ0GiLTDSMmq0QQ==
X-CSE-MsgGUID: 8G7tnHrbRVe7Q2WGVaHs3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="46948293"
Received: from pgarg3-mobl.amr.corp.intel.com (HELO localhost) ([10.209.105.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 18:53:47 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/2] Return EBUSY on inject poison limit reached
Date: Sat,  6 Jul 2024 18:53:42 -0700
Message-Id: <cover.1720316188.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Changes in v2:
- Use poison_inject_dev_max in cxl-test dev_dbg() msg and note that
  change in the Patch 2 commit log (Xingtao)
Link to v1: https://lore.kernel.org/cover.1720052137.git.alison.schofield@intel.com/

Validation users are asking for the ability to recognize when
their injection testing has hit the limit of the device.

Change the drivers error code for this failure to EBUSY and do
the same in the cxl-test mock of inject poison.

Alison Schofield (2):
  cxl/memdev: Replace ENXIO with EBUSY for inject poison limit reached
  cxl/test: Replace ENXIO with EBUSY for inject poison limit reached

 Documentation/ABI/testing/debugfs-cxl |  7 ++++---
 drivers/cxl/cxlmem.h                  |  2 +-
 tools/testing/cxl/test/mem.c          | 15 +++++++--------
 3 files changed, 12 insertions(+), 12 deletions(-)


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.37.3

