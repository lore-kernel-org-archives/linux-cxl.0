Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F329898B
	for <linux-cxl@vger.kernel.org>; Fri, 27 Jun 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041574; cv=none; b=YnJmy3mCFLjdrhZlxtOt3Y8Fe9oBcXg41rwrnsuBmE4btslM9/n5yWbD/GDqhVKpCfg9yEWYENgzCEEMLuJrXEycaL4ocfRiHzzvoPX2s2DOMGWgsM98ZTSDXAs2qkWGoi6BDd8tpCOx1MQe1DKSQZ5NxMGsVA1SHC2X9UOFvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041574; c=relaxed/simple;
	bh=Y/SDB5f0ajfwc7mR5jKv1dqpq1v410PDcQ2R+VZEUYU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AEY6ozjkOvs64x19OkLwaardBv3DG42625RWIm03c5nhlC9jnRsEOFk1nna/t+rh7nBibxitbk3OWdH7IVPF4bvVi2W7CkvwZFQMHZg7qdq5DaNrOB/iyXkwsNc2+GQ4JD1em0wuQayUrKReeewToHGJhk9+oyAyN/2Uf32a3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAn6skNL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAn6skNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751041572; x=1782577572;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=Y/SDB5f0ajfwc7mR5jKv1dqpq1v410PDcQ2R+VZEUYU=;
  b=NAn6skNLuwhkUHNVagKA7c2DIHmbHmJ5jNcJNV+PN4cQ52+c5S3cT9e5
   zDMbw3KoEQcne78WK8yqRktWXQ7Y/jLz4btCt5ZeytMb0FBRccs+r+wo+
   hVe5bDWYcnhkdRp18aIkxrVwyXbozmN5/52drwSwWhL6PjU4WEa8a92wQ
   ThwnDAEMIis9WCCr2PEqVy31/mrMoAqSJd1BTbq9dPcaw/A0iF0r6EAbI
   fwvGtKPARGIOwOjAiAMep717LjliQfoPZ7c0EVJDqWOFFjdQRESeIi8cb
   kY0CVke9/akSFo6671A3ujhSZsGprF68Nt9WBwSryK0TmrYq5RLpnvGxh
   w==;
X-CSE-ConnectionGUID: wbPwo/nbSnWR/34eEhosyg==
X-CSE-MsgGUID: IV5P+dq+QeiQTtSAyhP7zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="70794161"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="70794161"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:26:12 -0700
X-CSE-ConnectionGUID: /2+iMP4zS6GzM+PpDLZXHA==
X-CSE-MsgGUID: Laqs0TsERbqLyzbBlCcvtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="176522788"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.109.77]) ([10.125.109.77])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:26:11 -0700
Message-ID: <f6947076-4709-4346-8917-105743dfb98e@intel.com>
Date: Fri, 27 Jun 2025 09:26:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) fixes for 6.16-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.16-rc4

...to receive a small collection of CXL fixes.

These fixes address a few issues in the CXL subsystem, including dealing with
some bugs in the CXL EDAC and RAS drivers.

Besides the last commit, which is self contained and have been in linux-next for
2 days, all the other fixes have been in linux-next for more than a week. There has been
no reported issues.

---

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.16-rc4

for you to fetch changes up to 0a46f60a9fe16f5596b6b4b3ee1a483ea7854136:

  cxl/edac: Fix using wrong repair type to check dram event record (2025-06-25 12:05:45 -0700)

----------------------------------------------------------------
cxl fixes for v6.16-rc4

- Fix return value of cxlctl_validate_set_features()
- Fix min_scrub_cycle of a region miscaculation and add additional documentation
- Fix potential memory leak issues for CXL EDAC
- Fix CPER handler device confusion for CXL RAS
- Fix using wrong repair type to check DRAM event record

----------------------------------------------------------------
Dan Carpenter (1):
      cxl: fix return value in cxlctl_validate_set_features()

Dan Williams (1):
      cxl/ras: Fix CPER handler device confusion

Li Ming (4):
      cxl/edac: Fix the min_scrub_cycle of a region miscalculation
      cxl/Documentation: Add more description about min/max scrub cycle
      cxl/edac: Fix potential memory leak issues
      cxl/edac: Fix using wrong repair type to check dram event record

 Documentation/ABI/testing/sysfs-edac-scrub | 16 ++++++++++
 drivers/cxl/core/edac.c                    | 18 ++++++++----
 drivers/cxl/core/features.c                |  2 +-
 drivers/cxl/core/ras.c                     | 47 +++++++++++++++++-------------
 4 files changed, 57 insertions(+), 26 deletions(-)
