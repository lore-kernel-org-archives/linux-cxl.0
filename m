Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169215AAC6
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856428; cv=none; b=QT8p6vTwc3XPuXsreMwbwjKpl377RHqYg8VWPAQs1+D25v9//SQr7uYw0eAx/KOo6DYO7ji7/tTgdBxBddEfOPBNyfGt5TOKqjvclIFmq0FbMSJjutyRuasrEhvSOIS4G+ifwv/Juofc0OKWJI61nmV0Vecmp8w24Pe9/4sKmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856428; c=relaxed/simple;
	bh=TqICa00hk2wlfl7MJuKZd+BkSLFWbviuyYoTOtIxw70=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sB+q3JsB/0/0QZXhzc7myH1bby7hKmpZA5ZbjenSLmzifg16NNrkY9lPCVlqaRaBtb05M32XMYiknIWVe8bkFpwAyyI1EjWFR0yzyii3zw6HSbLevu0nKXCUqdufF5/lAgoo0RJpFYHaXqBOCn+gfrDnZbu4PTDIwjoYiarKK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPBhtT//; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPBhtT//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719856427; x=1751392427;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=TqICa00hk2wlfl7MJuKZd+BkSLFWbviuyYoTOtIxw70=;
  b=JPBhtT//1VyYIdH27oHqqNzDkcvm7auQNOsAL1qtV/ufstL72JUVOeVp
   cy4KIBRRLbSHz+oZe0ilCwaQrgz+qZavGeNXD/sZIIah6Se/3L/2+C/66
   yYJQ+dqkrTfS2isOth7UFHAk1BWqhx5K+v1Vmusn+c88sZX8HzjFZqP0y
   reJmlCQp4bAiQH81W9GBegGF/99eZyxysjSlt0c3WKXzPTDS7k5kBwaba
   VB/OrX8s0LwzrQWcDo1DR0nX2UtuALDlWbzCBZZsuwVLE/nSIX+OW7R3Z
   y9hcVpBFsrpt0XS++ZjEBAnZvh5IvL7x5iNiIfd27LLolngdayE6qDcrR
   Q==;
X-CSE-ConnectionGUID: Vu0fKVJSQV60i7Ug6ENjFQ==
X-CSE-MsgGUID: tkNTfDuoQHOiBSIcMikF8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27597175"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="27597175"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:53:46 -0700
X-CSE-ConnectionGUID: Iv89hjB8R1ijbXfHSIg0kA==
X-CSE-MsgGUID: RtR/OYc0QYWKxhhEBAs5qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="45576917"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.46]) ([10.125.111.46])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 10:53:45 -0700
Message-ID: <e5477d05-93e0-4268-90ca-581e3f492b4e@intel.com>
Date: Mon, 1 Jul 2024 10:53:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.10-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.10-rc7

...to receive several fixes for the CXL subsystem.

A fix to deal with NULL cxl_nvd pointer during persistent memory auto assembly.

A fix to address NULL pointer dereference in CXL region lookup.

A fix to add proper checking for CXL region interleave capability during assembly.

A kdoc fix for CXL documentation.

This has build success notification from kbuild-robot. It has been in the -next
for several days with no reported issues.

---

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.10-rc7

for you to fetch changes up to a0f39d51dbf72c28283bd201b97559ed82bc0fe5:

  cxl: documentation: add missing files to cxl driver-api (2024-06-25 14:45:27 -0700)

----------------------------------------------------------------
cxl fixes for v6.10-rc7

- Fix no cxl_nvd during pmem region auto-assemble
- Avoid NULLL pointer dereference in region lookup
- Add missing checks to interleave capability
- Add cxl kdoc fix to address document compilation error

----------------------------------------------------------------
Alison Schofield (1):
      cxl/region: Avoid null pointer dereference in region lookup

Li Ming (1):
      cxl/mem: Fix no cxl_nvd during pmem region auto-assembling

Yao Xingtao (2):
      cxl/region: check interleave capability
      cxl: documentation: add missing files to cxl driver-api

 Documentation/driver-api/cxl/memory-devices.rst |  15 ++++
 drivers/cxl/core/hdm.c                          |  13 +++
 drivers/cxl/core/pmem.c                         |  16 ++--
 drivers/cxl/core/region.c                       | 103 ++++++++++++++++++++++--
 drivers/cxl/cxl.h                               |   6 +-
 drivers/cxl/cxlmem.h                            |  21 +++--
 drivers/cxl/mem.c                               |  17 ++--
 tools/testing/cxl/test/cxl.c                    |   4 +
 8 files changed, 170 insertions(+), 25 deletions(-)
