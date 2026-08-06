Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E24B0486;
	Thu,  6 Aug 2026 23:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060180; cv=none; b=aoiQ9v6cYnSHyZzUwPQxv1Cc7ujm/J8eZaeXg6ndIhUxT9+O/G9KLJpWBN/7m2eQzmqiJcthxP16JroibsJXrpAvMuw98vRl9Slkk6VVHRl5OLN2FAUY6uIYYT+jg7Sv0JNnZRfIwcfHu5ajbqfjPszYX0K0A7Gj0T86nHT/bMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060180; c=relaxed/simple;
	bh=fMNVom8SbhoIYiytTjbk8+yR2Rf9rQDnWRvvepC9//Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRQfw7EJ27ZAP4T5BDWVYms01qwO8BYmTCKaDqR3EyrQcC8oFeCl9QQHiEXcxlRP6jrjn2I74CoWR10IXVyXAgU6icSsS00EKdYq5NKWiYWoDj6REiBdC6BLkDHsgR/s052lQCvJgD4svhq/bNTrvA3s7O/v0hFBu6UbVJLUFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3893wZj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3893wZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786060179; x=1817596179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fMNVom8SbhoIYiytTjbk8+yR2Rf9rQDnWRvvepC9//Q=;
  b=A3893wZjSPX3oL/J+2SKYUcMkw3zXqia0c1y8+FTjxzTLRejRz7jsmZZ
   N5J34uM2AxK5PEMWlvKCrzTg9uqIroi5KpT2B4bqA2eqAtcV6BABkd/6V
   OnW7w6OncfmA/I2XyhysOFXdzcJHUDHBhrZHO/9wMEKm6/2bJwaPuh5oX
   fGaivg7Z7iqQ1ydtPOyO09j9H7jeaIMhaPd0pExjJKWFiToZa8+Ff41Py
   DZdUkdssVb+N8QayV5HKoNGOaBQDQIKSLOA4Czhf6pFmbxDUU2q+whJjB
   robUqkpUWapeQ054XXdm+zMerZtPvG71gPy+AB8sWdda+n1mWQoi3tXTH
   Q==;
X-CSE-ConnectionGUID: OehoV2uYQKipK5fJJJ5Vbw==
X-CSE-MsgGUID: jVHqNxDxS9yvkbqeUkLfqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98030013"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="98030013"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:49:38 -0700
X-CSE-ConnectionGUID: rgsREohFTueTDdGtLhf9yA==
X-CSE-MsgGUID: iYmSfGXeSxablS741VJ3Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="286921848"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:49:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] docs: python: abi_regex: convert adjacent index placeholders
Date: Thu,  6 Aug 2026 16:49:27 -0700
Message-ID: <c9eda77481427c866a0c22f42eef565a33eebd03.1786058698.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <d57d3ddc0d7d883bd61ad07c6d3969b622fd446f.1786058698.git.alison.schofield@intel.com>
References: <d57d3ddc0d7d883bd61ad07c6d3969b622fd446f.1786058698.git.alison.schofield@intel.com>
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

