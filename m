Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59202E401;
	Wed, 13 Aug 2025 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045508; cv=none; b=fq7k6zY1C05xWSwl37b8r/xx6rK9wNKjz/3c+fvEMeLFEvyLYntvHcrQ+RFDKQYzf8roDZvha5H2SLEEAPT6m9AY24GAvu5m+t8nwEE5Sq7x+Z/G1ESmoRkOVLkBCAcPeQWVNx7iVV9Q2uQ7CxtrD6G/5nmTJ3RUCNMBTxoHwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045508; c=relaxed/simple;
	bh=AGIFgPFIdpDcXzqv5jwEFMWlufYl1iRhk7eGFq1nUco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVoFzokvpWsF8yl3ViCkTljF4pf/1V9wJwBoom5sBx+renBmm7maVKX9KbqFEeWP9ui6Y8Yybxo/yuWYE9W9vJzEPHe0gewbelr2J+z8GKyyj+J0PZ4ahf+FO4isN916JSTFvXlA/B5DSdjv7KdFNqkkWCtZjET/FfRCE9ULryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtM8w6SE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtM8w6SE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755045507; x=1786581507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AGIFgPFIdpDcXzqv5jwEFMWlufYl1iRhk7eGFq1nUco=;
  b=GtM8w6SE/Zm5uu9t+y+CtXSyZ8hd8nEq0Zm3bH6zt/zQE4Q7nKM5FNT/
   +Lt9En0417Bu6+iylmFiztzeYgaee/VemIFVczYw0NiZ4zOKQMcFd2fFk
   +wsUxxC9M/a4lI/zIONBoQo7KE8Y2EKiHiQ23VYoPP0UJXkxq/GZIjgxR
   uu+oamzdt9pUZF6+iXH1wbPYn4mFVBg0pY4gNJBtDb4PzZ6Fj08lffBWC
   RaeOWARkllLFlOhVvsqEtSb1V2hgFt8pjFq7Ph3R4VfnBU3gnStLBEvhR
   euPelprpfpkAHYrFQHQOEHzUf6hLzaxy9g63l7oW69aZeS4C9pNhx8v4e
   w==;
X-CSE-ConnectionGUID: Z3hMTZICQmGdTHOXbzG3JA==
X-CSE-MsgGUID: o37MIK5DSAeZ8p987if17g==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57452325"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="57452325"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 17:38:26 -0700
X-CSE-ConnectionGUID: QApbMwKwQESigLaAT1eUeQ==
X-CSE-MsgGUID: oUw13QiJTKmQ9mgzv609dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166700299"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.85])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 17:38:25 -0700
From: alison.schofield@intel.com
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: allow an assignment in if condition for ACQUIRE_ERR()
Date: Tue, 12 Aug 2025 17:38:19 -0700
Message-ID: <20250813003821.2891532-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

New helpers, ACQUIRE() and ACQUIRE_ERR(), were recently introduced to
clean up conditional locking paths [1].

That led to checkpatch ERRORS:
        ERROR: do not use assignment in if condition

on usages like this:
        ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
        if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
                return rc;

That compact format was a deliberate choice by the authors. By making
this a checkpatch exception, existing ERRORs are quieted, and future
users of the macro will not be dissuaded by checkpatch from using the
preferred compact format.

[1] Commit d03fcf50ba56 ("cxl: Convert to ACQUIRE() for conditional rwsem locking")

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 scripts/checkpatch.pl | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..150f355c632e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5696,7 +5696,14 @@ sub process {
 			my ($s, $c) = ($stat, $cond);
 			my $fixed_assign_in_if = 0;
 
-			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
+			if ($c =~ /\bif\s*\((.*[^<>!=]=[^=].*)\)/s) {
+				my $expr = $1;
+
+				# Allow ACQUIRE_ERR() macro syntax
+				if ($expr =~ /\w+\s*=\s*ACQUIRE_ERR\s*\(/) {
+					next;
+				}
+
 				if (ERROR("ASSIGN_IN_IF",
 					  "do not use assignment in if condition\n" . $herecurr) &&
 				    $fix && $perl_version_ok) {
-- 
2.37.3

