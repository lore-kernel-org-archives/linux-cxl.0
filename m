Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5C40F8F8;
	Fri,  7 Aug 2026 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140615; cv=none; b=vGDj3HmlBopotjkb7g85WXrbhkvlSaDrqUHLIehZcKg1BAWXNgTkvArYbG+X5sHus9ahSuS1h1IRHde8b02ADl0Q0Wy5D7C7kyipdgx0blVW1rptLt7j6LY3fvzStddIz3EFPJ/jjWByGgpOufASPJckbvJCYNyBEm7YpJk9LiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140615; c=relaxed/simple;
	bh=Rxeyts2J+BktJktwM2KvtcO72hJSx+d4YSQZNechytc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUV9SrMTOtJhVGz110mWrp3VghY/aESR9VEK7O2RSVnueLBYNg4J2b12jioSeXrPPKjHYbY5wrKZo4HBbh2qRRGrVW51YWwJcMNSHotzQHEbMixIa4Gfi0BOMgb46+UC0bPgfQMAg0vFu3uzE8p488keD8cW7ZeXkWlOgyN604w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkCnWMpB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkCnWMpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786140613; x=1817676613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rxeyts2J+BktJktwM2KvtcO72hJSx+d4YSQZNechytc=;
  b=AkCnWMpBnQbpyKLvLH7ONVmWxUeyQIpCd5pXuNY/z5kdFNXLCo60+1rT
   Y3fIa1g0yifasqKQJW3B8qIgcrbH1x2Iz8sMBGCmn0Bp6tUann1dUVOFY
   7oFS1XYqAeTI6ekQO4SRL2b2yb4QUQ4hZ/3EB177obgNMkFdKcBpHbVIx
   E02B+4MUWkN97KRIshN+l1lTmwmjdt4GIr9ibkQdUgLmY5oD6R/8NVxrP
   M6ggRczkElGQhDog7lQux3emkjPLVVGoI3sq6pPW8FmUKG6wVKr+kmxBm
   F8/r/qvw/N7USGdj0NsbFdd6wHI8/e4li96hGOHSZ1nB3Y8uWglVwkgXy
   Q==;
X-CSE-ConnectionGUID: XJC2hrNvRHWZ4al9HmAL1w==
X-CSE-MsgGUID: kdIfY9F7R5mPbmea4vwjLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="97355676"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="97355676"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 15:10:12 -0700
X-CSE-ConnectionGUID: 1ozVTaRvQ5is0CVcq/hGow==
X-CSE-MsgGUID: e6ijwpisTXmMeLEaVOkMJQ==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 15:10:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/2] docs: python: abi_regex: catch the right exception for a bad regex
Date: Fri,  7 Aug 2026 15:10:03 -0700
Message-ID: <9f6fa7a9aa6ba9a26b484b911976713356b3fd44.1786139549.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While validating recent CXL ABI documentation updates with
get_abi.py, the 'undefined' mode was found to abort instead of
reporting undocumented ABI entries.

Older Python releases raise re.error, while newer releases expose
re.PatternError. Catching the compatible re.error exception handles
both cases.

Use re.error so the scan continues and reports the remaining
results.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
- Update commit msg to say catches the compatible re.error (Sashiko)
- No code change


 tools/lib/python/abi/abi_regex.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/python/abi/abi_regex.py b/tools/lib/python/abi/abi_regex.py
index d0c5e3ede6b5..69d8507b7382 100644
--- a/tools/lib/python/abi/abi_regex.py
+++ b/tools/lib/python/abi/abi_regex.py
@@ -155,7 +155,7 @@ class AbiRegex(AbiParser):
             if self.search_string:
                 if what.find(self.search_string) >= 0:
                     print(f"What: {what}")
-        except re.PatternError:
+        except re.error:
             self.log.warning("Ignoring '%s' as it produced an invalid regex:\n"
                              "           '%s'", what, new)
 
@@ -194,7 +194,7 @@ class AbiRegex(AbiParser):
 
                 try:
                     self.re_string = re.compile(self.search_string)
-                except re.PatternError as e:
+                except re.error as e:
                     msg = f"{self.search_string} is not a valid regular expression"
                     raise ValueError(msg) from e
 
@@ -223,9 +223,9 @@ class AbiRegex(AbiParser):
                 for r, s in self.re_whats:
                     try:
                         new = r.sub(s, new)
-                    except re.PatternError as e:
+                    except re.error as e:
                         # Help debugging troubles with new regexes
-                        raise re.PatternError(f"{e}\nwhile re.sub('{r.pattern}', {s}, str)") from e
+                        raise re.error(f"{e}\nwhile re.sub('{r.pattern}', {s}, str)") from e
 
                 v["regex"].append(new)
 

base-commit: 075b74841bd0065a3bda3440873c747938e69b68
-- 
2.37.3

