Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6902566;
	Sat, 26 Oct 2024 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903620; cv=none; b=L+ZnDaoENU6h/NGE32xEifzYXarC4tFhIvH6ZtgB9tJK41qOU+17JN8ewMppAj4nfidbvH5+Qpkha5Wm89OiGcSitQcFM6YMiLrJ8r4mOP4cxKnxkxwrdR7PQooQtcmh2zxgjao88cmUZsNB5DgNk9bKj9UPwoylhB0MIQ0d9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903620; c=relaxed/simple;
	bh=47b2/WJ6vDXFTAeNa837xT+uK7Z6vlyEMJasVeR7icY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cbjTLwGve+eF6wFLeF+C8LyKs1hK/zIe5fX+6f2DE9pYcGvIJagBi44cVP1jj4MqzkRZViG1uiXGGv6+3QjCjN18CDseYirLHXnyxoEB+GQctl7JaM8hz7DGqXaJwQ/T7juJmH+yCrS0yY1db5nyPcMXEBqeM1v5AMF1LnxJXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9Gb/C1Z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9Gb/C1Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729903618; x=1761439618;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=47b2/WJ6vDXFTAeNa837xT+uK7Z6vlyEMJasVeR7icY=;
  b=W9Gb/C1ZYR1TEunt9bJOxHozeyJ8veY3MUqnRCgnmEvFY1Oa6hAQA1oS
   /mSo73hpnZ8faIyEHZHczNAhXXWYIPUHIUQUmWClNBP/YqYtvfY79mQe+
   va+CRoi8TS9AFhkLTzaB2bq5HgEqn1CuMNZ2F1MeSoEoKP1TVC5zdz2R+
   lZjqpAa5mZK8Hc9kFJaEHXRAbjfUyH3VYZIvArYE4HRyiEGIkMZY7sk8G
   1IkLMrVRKBfkGuXCVUI5+IaS5mEtH/3y81k0xON8MuGZspNxpVOFCsYbB
   /n6JEeBHaBjjAwsa4WVmxVCUsoV7vbwAIpzM0GLp3fWhuHLPHoOxGGudd
   g==;
X-CSE-ConnectionGUID: AugCS7GNT6G/KItIW/JQxw==
X-CSE-MsgGUID: 79PALpJkRDiXC6hYmeStWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40974426"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40974426"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:46:58 -0700
X-CSE-ConnectionGUID: tjcj/06fTVyhIkLuPaQQOw==
X-CSE-MsgGUID: ejX7LmZVRvm2DAP3MVvPrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85851627"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO localhost) ([10.125.111.138])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:46:55 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v2 0/4] printf: Add struct range print specifier
Date: Fri, 25 Oct 2024 19:46:52 -0500
Message-Id: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPw7HGcC/z3MQQ6CMBCF4auQWTumLVTBlfcwLEqdyiRISUsaD
 OndrSxc/i8v3w6RAlOEW7VDoMSR/VxCnSqwo5lfhPwsDUqoRnS1QLtNuASDuu70xVjtrCQo7yW
 Q4+2QHn3pkePqw+eAk/ythyGFbP9Gkijw6ppuMLpVoh3uPK80na1/Q59z/gJwzgZ5ngAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729903614; l=2159;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=47b2/WJ6vDXFTAeNa837xT+uK7Z6vlyEMJasVeR7icY=;
 b=UPV64GngUdXvSVAcPEVcC4WJBK+YwVVpCoF1yHP/3ESET/Y0CLNpUnaD5ZmCPcyJdpDPSYX1h
 JuC1/tolKiQCromOWtN6e2V60tGcgpOS1yHUZgokUuF0te1L+q5Dig6
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Support for the Compute Express Link (CXL) Dynamic Capacity Devices
(DCD) have grown a number of uses to print struct range.[1]  Support for
a printf specifier '%pra' was being worked within a large series and has
garnered a number of comments and discussion.

To better accelerate both features introduce a separate series to settle
the struct range print enhancement divorced from the CXL DCD feature.

Struct range is used to store a number range similar to struct resource.
Printing struct range becomes cumbersome having to specify 2 specifiers
and the members of the struct.  Furthermore, print output benefits from
using a standardized format.

Add to the pointer specifier support for struct range.  Share code with
struct resource for more standardization.  Add tests for struct resource
to help prevent regressions.

%pra was settled on as the most reasonable format in previous
discussions.[2]

Link: https://lore.kernel.org/all/20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com/ [1]
Link: https://lore.kernel.org/all/66cea3bf3332f_f937b29424@iweiny-mobl.notmuch/ [2]

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- Andy: s/resource_and_range/resource_or_range/
- djbw/Petr: Address comments on documentation
- Link to v1: https://patch.msgid.link/20241018-cxl-pra-v1-0-7f49ba58208b@intel.com

---
Ira Weiny (4):
      test printf: Add very basic struct resource tests
      Documentation/printf: struct resource add start == end special case
      printf: Add print format (%pra) for struct range
      cxl/cdat: Use %pra for dpa range outputs

 Documentation/core-api/printk-formats.rst | 20 +++++++++-
 drivers/cxl/core/cdat.c                   |  8 ++--
 include/linux/range.h                     |  6 +++
 lib/test_printf.c                         | 61 +++++++++++++++++++++++++++++++
 lib/vsprintf.c                            | 57 ++++++++++++++++++++++++++---
 5 files changed, 141 insertions(+), 11 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240930-cxl-pra-53956ac5fc1e

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

