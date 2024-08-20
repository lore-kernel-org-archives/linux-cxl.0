Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440443179
	for <linux-cxl@vger.kernel.org>; Tue, 20 Aug 2024 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168031; cv=none; b=b0PXBX/OLfX48ZeQ/L2nGv3Qm1lEQBkGnQFaqHQ0Ym5eA5DTr9UuO7IolxY66SUKvMn/3MYn2HdANvhItWHbULXkHva1t2GU2h7+xLjKRbdkuYkTRfZ9PwXPwkST2tz45gkCB9tJk9o1aiPlX89ULntEArnrUue8eF+rtTaV/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168031; c=relaxed/simple;
	bh=uEObr4E/aIscSJYev8IMqeHRwPESgMc7BOdHL0YMbas=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ct+sQoL4Oz0cQBQt2GYcx2eYrTzaDaJ6USVllubWku78rSAAKLqnoFt51dWgVvNTKZPJ/aUPg2orr1q0oiv7eFXR2KUzR4rufwgx3+KYLJxKuKuXMcVNVpkcCrDxWnkKCYoYh8KmRhs0rU/5Jer0h5SLEw1z7K1WPTbTvI5ABiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pvaj0Upy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pvaj0Upy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724168029; x=1755704029;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=uEObr4E/aIscSJYev8IMqeHRwPESgMc7BOdHL0YMbas=;
  b=Pvaj0UpypmOHUL49ZltvLcNL8t3emQIQGME1AKrVWLZtUeZtPQPjO+9J
   YRJgxXvCm183Moot9PesoZPMf3acHmoi4/BVyDOTL189DSt4m62o6PVJk
   VBPJZCWqOn772SiaM7VkfxvDF3UZ7vaKo8fWbA6Kinw2bgizZ7VJ92/c5
   xbZ8ibMMQzV8rFnda5gk4tuPEl5TBqiu4HLXvdIW+S76VRw+0Bt9mX8ci
   3XSAxh/i5UfixZOkObJL/3F9WGOmqiX5NsCEasgKAUfCKhy6VDYPJNg5Y
   NurQ2HhCix7CjY4sUM/H25knPtd+SjyzNCxxA/17GK+3YBpXLMd1VLSm6
   w==;
X-CSE-ConnectionGUID: OR5OATYDSMaEG/WkZQ8/4w==
X-CSE-MsgGUID: es8mRLNgSEuqt35xxgucmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="13115296"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="13115296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 08:33:47 -0700
X-CSE-ConnectionGUID: 8ZlvjEoxQWK9AmDlCcQSZQ==
X-CSE-MsgGUID: SMbWGdFCTG2BYvpuO4FHxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="98246050"
Received: from cdpresto-mobl2.amr.corp.intel.com.amr.corp.intel.com (HELO [10.125.108.88]) ([10.125.108.88])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 08:33:46 -0700
Message-ID: <104af007-3deb-41d6-a32b-0fd12173cdb2@intel.com>
Date: Tue, 20 Aug 2024 08:33:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.11-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:
  
  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.11-rc5

...to receive 2 fixes for CXL subsystem.

The fixes include a check for RCH dport before accessing pci_host_bridge and a fix
to address a KASAN warning for the cxl regression test suite cxl-test.

These have all appeared in -next for a few days with no reported issues.

---

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.11-rc5

for you to fetch changes up to 2c402bd2e85b44dc00ef85b5c0e217de684b5372:

  cxl/test: Skip cxl_setup_parent_dport() for emulated dports (2024-08-09 15:14:12 -0700)

----------------------------------------------------------------
cxl fixes for v6.11-rc5

- Check dport for RCH topology before accessing pci_host_bridge
- Skip unnecessary dport setup for cxl-test to fix KASAN warning

----------------------------------------------------------------
Li Ming (2):
      cxl/pci: Get AER capability address from RCRB only for RCH dport
      cxl/test: Skip cxl_setup_parent_dport() for emulated dports

 drivers/cxl/core/pci.c        | 10 ++++++----
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/mock.c | 12 ++++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)
