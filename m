Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4C46BF;
	Fri, 15 Aug 2025 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220010; cv=none; b=drssC4XJgsuOiOHPQNVcElYokGz10NfJ2vcmrV1CwY+SGTT39gfQjIU2XEdcR6s3t0htCUHzCZavgT8VcrTr4g4LRAkgHwEX78IXgASShhvYkVVKdTmS6rqCHQWeVQ6OzNjlVz2e3UoMYom24uBMRT0WzhSAFY/jIu0c4iBPpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220010; c=relaxed/simple;
	bh=2RCrh8tyaR2qIqxDk/GOR9mU3HwpsnZkWA4dwyzc3Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gtQolb4UXql2RUiffZrQQylbVShl98+1d05Kdi/Vgs252Qti3TzxtSD8kIJZDwv71GdyAxqOKErokiCWgLyZBEprLPob7ICCLnTGt/fduaGqXBVs9v7M6UQnSltCsR3edGhOVwN3Bhkn1l2k1lXNial/ZMpep9ybUtVZEUJhKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF82C5fW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF82C5fW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755220009; x=1786756009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2RCrh8tyaR2qIqxDk/GOR9mU3HwpsnZkWA4dwyzc3Ws=;
  b=nF82C5fWjMI08E0VJY2Q2pAU3cW6RLJO0LVjidBBgfkF7DpL9WqTsl/J
   7khcvTyADnodgizqS1vsy3tafqppBRUSRH3ZL10MasxTNMsYge0sxl2pq
   A5/Ot7Y9/DJjBNDagPVNPhbR4x5gJDWgX2oWQu1VH7O+UDMJWDBXXwdNW
   2mKArVMBOTn0zlx9HHPhTyZ2BJonOGciLyJuCgeejOA1k/I4wk3Os3y63
   v0AK/0OvJivH1771wycPUKUDaCRpXGVrcLFC5+xh/G8q1jKU2zM5L+X1P
   n3WhE6N/1eBmBHdKRvYbzyGmg4jl7bcFOitbnBdSHGp03nSNAU7Y2CzZh
   Q==;
X-CSE-ConnectionGUID: Mq1GSQIRRm6psU+OtrdgHA==
X-CSE-MsgGUID: cL1CUw8LTd+iPeqOFGzHTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="80128005"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="80128005"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 18:06:48 -0700
X-CSE-ConnectionGUID: FsyV3GWURP6ytoNoTEDFug==
X-CSE-MsgGUID: NAMSCyyWS+6nWLhywM+hAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167249182"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.92])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 18:06:47 -0700
From: alison.schofield@intel.com
To: Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: allow an assignment in if condition for ACQUIRE_ERR()
Date: Thu, 14 Aug 2025 18:06:43 -0700
Message-ID: <20250815010645.2980846-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

New helpers, ACQUIRE() and ACQUIRE_ERR(), were recently introduced
and employed here [1] to clean up conditional locking paths.

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

Changes in v2:
- Remove next that skipped other rules (Joe)
- Replace \w+ with $Lval for more precise pattern match (Joe)
- Only allow lines where all assignments are to ACQUIRE_ERR
- Tested many more allow and trigger conditions.
  Will share in reply to this post.
- Update commit message

 scripts/checkpatch.pl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e722dd6fa8ef..30435967d8c4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5696,7 +5696,18 @@ sub process {
 			my ($s, $c) = ($stat, $cond);
 			my $fixed_assign_in_if = 0;
 
-			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
+			if ($c =~ /\bif\s*\((.*[^<>!=]=[^=].*)\)/s) {
+			    my $condition = $1;
+			    my $allow_assignment = 1;
+
+			    # Allow single ACQUIRE_ERR assignment, reject everything else
+			    while ($condition =~ /\b($Lval)\s*=\s*([^,)&|]+)/g) {
+				 if ($2 !~ /^\s*ACQUIRE_ERR\s*\(/) {
+					$allow_assignment = 0;
+					last;
+				}
+			    }
+			    if (!$allow_assignment) {
 				if (ERROR("ASSIGN_IN_IF",
 					  "do not use assignment in if condition\n" . $herecurr) &&
 				    $fix && $perl_version_ok) {
@@ -5721,6 +5732,7 @@ sub process {
 						fix_insert_line($fixlinenr + 1, $newline);
 						$fixed_assign_in_if = 1;
 					}
+				    }
 				}
 			}
 

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.37.3

