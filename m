Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8046EC9D;
	Fri,  7 Aug 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140616; cv=none; b=Gr0Br+svh77nL97OrSX8FPG6TOETt/JEzf18n2Dvyan8rrkXnYr35WnwIc1xaEQ+iqAVnmjCONdYmrHlj16R+DsZTJZsgKIjfTVAuIn4ad4PLUg6I/eN+mNmeoSNrzsRxgusTKRRKrBUX/fv/X/ts+BNaZ67lypx6rYdVTEpbMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140616; c=relaxed/simple;
	bh=OIJ4NpRUNV6fCJ/4BcVN0UjqGJ2aTDW/1EGKpTcycfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoOOZGWLOtGpsIyL3E1X/qooVnF144vmgYWSpGd4moq49AMH/YDUoRLNWZE/Z9Gr8DJWf20n0bj8jvK/6fZ8lIaim8vzdLbiB9DM5c1E5annc87cB3Ib2l4DO4qO1w2+Xnd/UDUJlAUYF5KLeAeAXQOamR05sjXLa1h3Ef8zIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nu6fxcMq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nu6fxcMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786140614; x=1817676614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OIJ4NpRUNV6fCJ/4BcVN0UjqGJ2aTDW/1EGKpTcycfQ=;
  b=nu6fxcMq1Cx4HUSMY9iR98aN/gA9YOyS9IrDN8/Nl/4+wSQOLCO8m2Ci
   6hfmTY/y4ABRBjnCAFJM7OiUGG6CbdZk2qyiCx35ndsc6I32LIfXCI6Jl
   umSOEIYPSTrgJ2tRYojz/2s80SRREsh2Z4RRR7f7aq34jR6ocNv1uBMsn
   sQkShHZZwC2n3njBdR0ZnU2aNrsv1LjmatwJmpXXKfce4IrlzcE8yLUR6
   MlCaPVri2VaF1rkUZYRViK4T1tDDa5XqNOcgDln7ux4lSZcTMKWO+YUsL
   Cvpwc7lbBVJILefo10yhGCWLTlVKRWPKgdZ/52oDy/MGFDrXDc7mb6lH+
   w==;
X-CSE-ConnectionGUID: Ely2Qf+USJmM/BSDYC+c9g==
X-CSE-MsgGUID: HMH/Rip6QYqzvatC9+WdMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="97355680"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="97355680"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 15:10:13 -0700
X-CSE-ConnectionGUID: HY77v3cbSwqrtsJZZiPUtQ==
X-CSE-MsgGUID: KNyBLxvjSTW7jHjBgLJXrg==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 15:10:12 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 2/2] docs: python: abi_regex: convert adjacent index placeholders
Date: Fri,  7 Aug 2026 15:10:04 -0700
Message-ID: <cc893dca3aaa3ec833ba70d1f32c3e7342b7faf2.1786139549.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <9f6fa7a9aa6ba9a26b484b911976713356b3fd44.1786139549.git.alison.schofield@intel.com>
References: <9f6fa7a9aa6ba9a26b484b911976713356b3fd44.1786139549.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While validating recent CXL ABI documentation updates with
get_abi.py, every decoderX.Y entry was reported as undocumented.

The placeholder conversion mishandles adjacent index placeholders,
producing patterns that cannot match the corresponding sysfs paths.
As a result, valid ABI entries are reported as undocumented.

Handle adjacent placeholders independently so generated patterns match
the documented paths. This fixes decoderX.Y entries in the CXL ABI and
other ABI documentation that uses the same naming convention.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- No changes


 tools/lib/python/abi/abi_regex.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/python/abi/abi_regex.py b/tools/lib/python/abi/abi_regex.py
index 69d8507b7382..198ecbf49c51 100644
--- a/tools/lib/python/abi/abi_regex.py
+++ b/tools/lib/python/abi/abi_regex.py
@@ -65,8 +65,7 @@ class AbiRegex(AbiParser):
         (re.compile(r"\[[^\]]+\]"), "\\\\w\xf7"),
 
         (re.compile(r"XX+"), "\\\\w\xf7"),
-        (re.compile(r"([^A-Z])[XYZ]([^A-Z])"), "\\1\\\\w\xf7\\2"),
-        (re.compile(r"([^A-Z])[XYZ]$"), "\\1\\\\w\xf7"),
+        (re.compile(r"(?<![A-Z])[XYZ](?![A-Z])"), "\\\\w\xf7"),
         (re.compile(r"_[AB]_"), "_\\\\w\xf7_"),
 
         # Recover [0-9] type of patterns
-- 
2.37.3

