Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00199137923;
	Fri, 17 Oct 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718652; cv=none; b=k9FMOEkkapHvZ95irYcleTtx/z1uJrfRYXp5oaBwemJ8o+mX9K2TKRPTf77TEY1IR+/AL9u1k/sB07vSyhVzIz8bKcnZqZQu7wfQoUqsYEDjyf1TfxdQ81Rwv6E3d+VY6Y/rWWXGzY28LyBWIPaP5nMfb+/z0Y/Ttb+lvy0cI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718652; c=relaxed/simple;
	bh=xamKdc8Fy5z0epEQXm3Wn0WLPZuqYDYYH6wCE5QSiow=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=nApw5YdNuOPMUVnQUBFvdfv2g5HBWNmCd9W/XpeneNBZx0/vYQKOREG7NCM/uLBC6s7NAOHisiNIWXa7LeoirXmNiuvnaFnbn5y+01wRXLak32POZIoqHaL7SuXpTZB+SG5MbLVzJGWFywungsWtLz7n777aEnLVgFxblQNTJfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJMcpOPR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJMcpOPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760718651; x=1792254651;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=xamKdc8Fy5z0epEQXm3Wn0WLPZuqYDYYH6wCE5QSiow=;
  b=CJMcpOPRu4b4lr/HiCh7AxVhq8jyvfAfrYd/0Wx8DkOnMcpWMhKn84jC
   6eJkHeL2nEPT3I4N1kcjyuTYwCzArgykbPndhgyVk6+vQebDK2XJkY9nq
   nK3MIvI7KjFE/TuS70SJy8NJgxV0tlyFKfYn6yAoOuzBY8npzfoG2gr7y
   YZ7xWs3Gp4CUxKNKC17swP/fDlJDq6aI28Rwcdm1G7UYJDoxB+zy4R8da
   y0cn6kE90BoG6E5MBN0iiHtgJwvvnGA/0jw7UOVwfQwoKNflsrhpZ8NbL
   upRYvfJSi67ZtJdc0mJlTWQQXQRJ0DD+pyeXs/4bpsF3OdaqmcT/nBoYu
   g==;
X-CSE-ConnectionGUID: mTnngB8KRIC+0IrbUm86Ig==
X-CSE-MsgGUID: p7TpgJ7dRUSFaTO3rb3COA==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="63081518"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="63081518"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:30:50 -0700
X-CSE-ConnectionGUID: IPaMK2wETFqPXTkZGZ7+GQ==
X-CSE-MsgGUID: j8isfBWFQCafPWqdPO0t6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="181907541"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.48]) ([10.125.108.48])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 09:30:50 -0700
Message-ID: <ea01d693-0d81-419c-ae20-6332feadd412@intel.com>
Date: Fri, 17 Oct 2025 09:30:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.18-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.18-rc2

...to receive a small collection of CXL fixes. In addition to some misc fixes
for the CXL subsystem, a number of fixes for CXL extended linear cache support
are included to make it functional again.

While 0f6f1982cb28 ("cxl: Set range param for region_res_match_cxl_range() as const")
is not a fix, it's a small change that addresses a compile warning that arose from the fix
f4d027921c81 ("cxl: Fix match_region_by_range() to use region_res_match_cxl_range()").

These have all appeared in -next for a few days with no reported issues.

---

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.18-rc2

for you to fetch changes up to a4bbb493a3247ef32f6191fd8b2a0657139f8e08:

  cxl/trace: Subtract to find an hpa_alias0 in cxl_poison events (2025-10-14 14:48:14 -0700)

----------------------------------------------------------------
cxl fixes for v6.18-rc2

- Avoid missing port component registers setup due to dport enumeration
  failure
- Add check for no entries in cxl_feature_info to address accessing
  invalid pointer.
- Use %pa printk format to emit resource_size_t in
  validate_region_offset()

CXL extended linear cache support fixes:
- Fix setup of memory resource in cxl_acpi_set_cache_size()
- Set range param for region_res_match_cxl_range() as const.
  (Addresses a compile warning for match_region_by_range() fix)
- Fix match_region_by_range() to use region_res_match_cxl_range()
- Subtract to find an hpa_alias0 in cxl_poison events to correct
  the alias math calculation.

----------------------------------------------------------------
Alison Schofield (2):
      cxl/region: Use %pa printk format to emit resource_size_t
      cxl/trace: Subtract to find an hpa_alias0 in cxl_poison events

Dave Jiang (4):
      cxl/features: Add check for no entries in cxl_feature_info
      cxl/acpi: Fix setup of memory resource in cxl_acpi_set_cache_size()
      cxl: Set range param for region_res_match_cxl_range() as const
      cxl: Fix match_region_by_range() to use region_res_match_cxl_range()

Li Ming (1):
      cxl/port: Avoid missing port component registers setup

 drivers/cxl/acpi.c          |  2 +-
 drivers/cxl/core/features.c |  3 +++
 drivers/cxl/core/port.c     | 26 ++++++++++++++------------
 drivers/cxl/core/region.c   | 11 ++++-------
 drivers/cxl/core/trace.h    |  2 +-
 5 files changed, 23 insertions(+), 21 deletions(-)
