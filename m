Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F84B0487;
	Thu,  6 Aug 2026 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060179; cv=none; b=mhRmt0xAmPx73XwQbstqFe2TbUswG0gBTCdTrKPBAzcFmi4GvXHh/qtzgM6NdiJPl/iudvl+04iyG7Q1Dz4la0UuySbLZGGuCfD8szqDskaxRDFVecK/ojH7Sjyf7i+FHi/8+eZgnfA0aXVoFSV5olSqmrL6Bzq/aZ+tgLrfOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060179; c=relaxed/simple;
	bh=thmOqfNL7lZVCp9Y1pwyWjHq8zHEYwrpW5LzO9XcKjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2jo/vev1IczwljCGNs4g4qdSzHUvbPi9kQ+pq9RbzKhm/J7oKi0z/r6o99WMnv//1lgfjsybso/lAcHFeIDJhDHuOkeMt5LUXFAW6P+rOlCyiF6cSca/6ornXwcY/q0giDe2aVgsJgNyjM+nDSqU3iPYM9gVUiZ4uCdAnbPDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KkcwjyQy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KkcwjyQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786060177; x=1817596177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=thmOqfNL7lZVCp9Y1pwyWjHq8zHEYwrpW5LzO9XcKjY=;
  b=KkcwjyQyieNyUi80KY44xuupFOcVj8LYRBVZdW2D7wXn0Vmd3JzD/6pb
   aF4gq96oCvVzLMrsuWAGJKx+ljxG3J8L5f11DjHvsmz35vX3oEXXCbXep
   z4zcfu8EEivExgV9P76JctHsXhBEMSk6IoMtV+1VgFTF0dymyM7XFqRFK
   s3mQ9q8RDhH5HngymOjFXDQuqZK+hdZMOa7yocyrzx/Yir/h1rIk8zhcY
   kchF/BWfCozmpoqYLwWroHwu7umVBL06+4v0y4puSful7H5rSH49azvah
   cRz1fhlqGTO4D1hJyP+rEEpIqC+pjXhCv3eU7UjnuA526rFrGtGLKbCqD
   Q==;
X-CSE-ConnectionGUID: nC7TLM/VTPuiiBojIuFLdg==
X-CSE-MsgGUID: 071qRmQoT3OJC3qKj/Xx9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="98030010"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="98030010"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:49:37 -0700
X-CSE-ConnectionGUID: q6+9UzNbQniL0u41JyMLKA==
X-CSE-MsgGUID: XuQTcQWZTE6Lx0wFu9XpTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="286921844"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.8])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 16:49:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] docs: python: abi_regex: catch the right exception for a bad regex
Date: Thu,  6 Aug 2026 16:49:26 -0700
Message-ID: <d57d3ddc0d7d883bd61ad07c6d3969b622fd446f.1786058698.git.alison.schofield@intel.com>
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
re.PatternError. Catching only the newer name causes the scan to
abort when an invalid expression is encountered.

Catch both names so the scan continues and reports the remaining
results.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
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

