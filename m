Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718BD1885AA;
	Fri, 18 Oct 2024 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280790; cv=none; b=R7ZzHuB7u4B7Wh6JwBI6EvT8Qp4U0ezJ0KdSFk/vokBrZrwTB8u5K5Hd1+S8o3xXDZuAhMydcm1AxSj4D+UvMcma1OQQeqM+n2v2W4x4eBjU9gx0TafzXo8mQPlO6S/dbqOBBERdbqS8zl1FaC4e0VHSA/nYlXaak8LRtXkfruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280790; c=relaxed/simple;
	bh=q+iZarWz6ivaTsFS50QZvoDUl/Wybi/5VV4O6gaV6W4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f0NYHGsiwDAe875yGgB2qwpkltpXn30rp/kCst1oH2oS0efVfHXPD51bZ9egT+sSzIIEMp8mmdV3nGItOvPU2kNRY7pIL2XVbG9o6nsHfyH4iitvPYMy2UJQEA0o6nUKWW20XLEXi+uuwReUKtZzjpWm+2/mnAqoSF/Jux+fVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4g3kkQb; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4g3kkQb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729280788; x=1760816788;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=q+iZarWz6ivaTsFS50QZvoDUl/Wybi/5VV4O6gaV6W4=;
  b=e4g3kkQb3WgcDp1qLK8FyutypxgpSm2Uyah2chSseNlIorw5RRzmGS/f
   s4LrH6ithNg12mxsBDFKYX32pkvecq6bbThLMFwaFdssl1zxCR0Qy4q6o
   Gppv5XCsxHOyRe1ZSf/6jvHlxr2t3LgNbawWCMIji2Ei3oigRE/SgFOXC
   64diTn3CAQ+eIdXmJCNDnqyfOq7CsafoR8+KxFJalY22+sVROEj9qAUFp
   ukKbxJxZk7118r0ipmYEAtSm7o5Han9gpsZvlXP225W5aNG/pc6LkL8UE
   wm20ptm7D3ZpGm8gW8z0sgzx7yeEHxfJ9BUuuJn9iAtRFQMJJSFlQg/F9
   g==;
X-CSE-ConnectionGUID: jHDoUCKyQBKRtSSOublkjg==
X-CSE-MsgGUID: /nsBYJN5SYGIs+rPb2AHxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28704435"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="28704435"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:46:27 -0700
X-CSE-ConnectionGUID: +Ov9jD9cQxKAiswUNHmQQw==
X-CSE-MsgGUID: aZRR4G9+ROGMUJc8/jWQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79017558"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.109.148])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 12:46:26 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/3] printf: Add struct range print specifier
Date: Fri, 18 Oct 2024 14:46:23 -0500
Message-Id: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+7EmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS2MD3eSKHN2CokRdU2NLU7PEZNO0ZMNUJaDqgqLUtMwKsEnRsbW1AO5
 +3EJZAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729280784; l=1876;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=q+iZarWz6ivaTsFS50QZvoDUl/Wybi/5VV4O6gaV6W4=;
 b=J+iUkgkxYmjd7vzBkUZGdZEnelkuuxrtjO48dp8Q5+6SoLGh8q9e9yImMpxxtzYdLMsMyYsOw
 2yr3QIQzOD1ANsZ4AGAVNRlWQjwUeXrCRkpurAIBZnRD/Gi0UlHw0Bp
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
Ira Weiny (3):
      test printf: Add very basic struct resource tests
      printf: Add print format (%pra) for struct range
      cxl/cdat: Use %pra for dpa range outputs

 Documentation/core-api/printk-formats.rst | 13 +++++++
 drivers/cxl/core/cdat.c                   |  8 ++--
 include/linux/range.h                     |  6 +++
 lib/test_printf.c                         | 61 +++++++++++++++++++++++++++++++
 lib/vsprintf.c                            | 57 ++++++++++++++++++++++++++---
 5 files changed, 135 insertions(+), 10 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240930-cxl-pra-53956ac5fc1e

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

