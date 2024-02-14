Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7761170E
	for <linux-cxl@vger.kernel.org>; Wed, 14 Feb 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894824; cv=none; b=i5J8WglMhPV0F1JY23lDpA/tsWk9xp17CXtyGdxwLhaCOlRaOLUFOiDhzfhjVw5XatJ183vXrRE+WpYJ4e+bmDJ6iTeIpLFsjNYSRR5MvRj10ijYcbekEgERkZ2cnzt+2L0mgHkNEJpvgjFaBXXgDBYXPNm+BL/XIsdXjYZfqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894824; c=relaxed/simple;
	bh=UoCmVSsZO7p4zif1BP+d6fFdML4HydLbPY786jkrMCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bReMuTHXyFNgWSgKf8KzyzL6eaaaTNTPmu2oudvXewcwTRkPHdKCCIf7POSkbjZoNNCdx1ggS65NBk1FH6tzRu6ZQTOYecVpeaEETqE+depbZC8OF1j7fuLH0x1X5kn7GfPxaHdqmWvW5G4BeVVcF00Kfbe+HzYZLCJHcsnV88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTB358/0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTB358/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707894822; x=1739430822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UoCmVSsZO7p4zif1BP+d6fFdML4HydLbPY786jkrMCY=;
  b=OTB358/0oOQ+fAyIrFRBDH0Y/fGpoWwUbW2RPGpkBbF93odnS8UkIYFL
   jFT+oYbpDDQ+qfZh4ra9EDlUc5gQFFEljyDrukoNf0l4isJBQD7tThS8c
   K2xmUdUENfqM/zYxQcPgk5z6VnmRWRhJyGcNd68JGcEBMnC68cSyKMb/X
   yWIphKuygD5t02mWEGdFAvuEcz7HZm/BrWxDcexaBjSYVHYAJkKqdt6G/
   SYWIIT0XJJTYf8gvz1n/Ck+YkaSxVfL8sOay7KonnSugalBvOGpgRCPWJ
   4TCCSKKu4iPuucynNHwCUHSn3rnY2hq5fEWhRsFhLPqgIcrjpS3vpkhBU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27374450"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="27374450"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:13:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7758537"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.66.223])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:13:41 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl/test: Replace an illegal CFMWS definition with a useful x3 CFMWS
Date: Tue, 13 Feb 2024 23:13:36 -0800
Message-Id: <d8bbae3ea5dc59bd4972236fe06adb5ec85e5c21.1707891715.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707891715.git.alison.schofield@intel.com>
References: <cover.1707891715.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

cxl/test has a small set (3) of CFMWS's that become available when
cxl_test is loaded with this module option: interleave_arithmetic=1.
That gives users of cxl_test access to root decoders that use XOR Math
for interleave arithmetic rather than the default Modulo.

The existing x4 CFMWS definition is an invalid configuration because
it repeats Host Bridges in the interleave set. A patch to remove its
usage in the CXL unit test cxl-xor-region.sh is in flight.

Coincidentally, there is another CFMWS definition queued for addition
here and a patch to use it in the CXL unit test is also in flight.
Rather than tear this CFMWS out and adjust the indexes only to follow
it with another patch to introduce a new CFMWS, do a switch in place.

Transform the illegal x4 CFMWS definition into a useful x3 version.

Fixes: 7a7e6edfca85 ("tools/testing/cxl: Add XOR Math support to cxl_test")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

I realize this switcheroo is atypical for a patch. It seemed to be a
cleaner repair, especially when trying to push this cxl/test change
with the acpi driver patch in this set. Say the word and I'll split.

Also, I'm not looking to put back a 4-way HB interleave at the moment,
because it's not a unique case (similar to 2-way in the calc) and also
because I have a patchset in the works that supports all the HB interleave
configs. This sets focus is repairing, not enhancing.


 tools/testing/cxl/test/cxl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a3cdbb2be038..e7e4afabc97a 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -329,14 +329,14 @@ static struct {
 				.length = sizeof(mock_cedt.cfmws8),
 			},
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
-			.interleave_ways = 2,
+			.interleave_ways = 8,
 			.granularity = 0,
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = 0,
-			.window_size = SZ_256M * 16UL,
+			.window_size = SZ_256M * 12UL,
 		},
-		.target = { 0, 1, 0, 1, },
+		.target = { 0, 1, 2 },
 	},
 	.cxims0 = {
 		.cxims = {
-- 
2.37.3

