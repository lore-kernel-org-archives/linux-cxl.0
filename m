Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C814012
	for <linux-cxl@vger.kernel.org>; Sat, 15 Feb 2025 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585610; cv=none; b=H9pFjF+khlkXfoi+2a4MxLoSJZpN2nZVxikf7m5o58fN2PLMYwc24jy6UjW4+GEIL6WT2B0JH3r3mkeOyWyo5JWqx9QHpXWCKhFEnRDp/wakMUgQOqe3K6yRLdapsnJOtK0psmXJ3CuuFHxkAL/vE7ptpNOv9a5GpBXWf1YtpYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585610; c=relaxed/simple;
	bh=wegVozxu6q46LilThDAiVgrwuSpj+jm4ui6RIcG+YRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnYF/58jRjL5S2J4GHdRn37cnlj5ZaFNhCBRvpihgNl+iP4lLnjOFe493eCgUtMe6gIzme9QUtjXn5WXCvZWOn0pGZdgASz+f1cPaQcCHr+xHDuL4MbOtxtnXyFJgHdctDvAbGncUH2WE3f2ynUwR1D91NoRlN7KIJzKhe64P5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5BLEY4N; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5BLEY4N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739585609; x=1771121609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wegVozxu6q46LilThDAiVgrwuSpj+jm4ui6RIcG+YRo=;
  b=Y5BLEY4NpT6SYXdgg9+NbW0tCqFsaeBKuO7w940iR2NhzagrhROSFhig
   x++ucLDJ8q0/WDYEzwc1pwd5BTIoUojfpmuzrsT6ClpZndmIUXbiJacoF
   5XkEiFZbd5NanzinOogPyQIALxy8YYkOWlfuc66BurToq0UEZK2KlNJZ9
   YWmcXkPHIYHsqx84n14rswW8cFjVcfW/xa1Ri0PqqW1CFJkho9pLR8Nku
   8qrH5wE2raXGYimMa2Bdr+atHUfkuC+1KWBKvADrbHLEMgndz6bmy9Mf0
   3IzOzLNvyNgIZIJfMPVOKTtRISqIE7vKIFAIAXlLGximZ/V0dAS3RaOA5
   w==;
X-CSE-ConnectionGUID: ZeNyP1HTQ2eYL4sQecXBIw==
X-CSE-MsgGUID: N9/oSCpJRByn/lzew8Eq8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="44109895"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="44109895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 18:13:28 -0800
X-CSE-ConnectionGUID: bmLIowOpRVyK+82qVXmwzg==
X-CSE-MsgGUID: 3MHaEyJYQrCZmahTsXmoWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150773211"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 18:13:27 -0800
From: alison.schofield@intel.com
To: nvdimm@lists.linux.dev
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [ndctl PATCH] cxl/lib: remove unimplemented symbol cxl_mapping_get_region
Date: Fri, 14 Feb 2025 18:13:16 -0800
Message-ID: <20250215021319.1948097-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

User reports this symbol was added but has never had an implementation
causing their linker ld.lld to fail like so:

ld.lld: error: version script assignment of 'LIBCXL_3' to symbol 'cxl_mapping_get_region' failed: symbol not defined

This likely worked for some builds but not others because of different
toolchains (linkers), compiler optimizations (garbage collection), or
linker flags (ignoring or only warning on unused symbols).

Clean this up by removing the symbol.

Reposted here from github pull request:
https://github.com/pmem/ndctl/pull/267/

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/lib/libcxl.sym | 1 -
 cxl/libcxl.h       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 0c155a40ad47..763151fbef59 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -208,7 +208,6 @@ global:
 	cxl_mapping_get_first;
 	cxl_mapping_get_next;
 	cxl_mapping_get_decoder;
-	cxl_mapping_get_region;
 	cxl_mapping_get_position;
 	cxl_decoder_get_by_name;
 	cxl_decoder_get_memdev;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 0a5fd0e13cc2..43c082acd836 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -354,7 +354,6 @@ struct cxl_memdev_mapping *cxl_mapping_get_first(struct cxl_region *region);
 struct cxl_memdev_mapping *
 cxl_mapping_get_next(struct cxl_memdev_mapping *mapping);
 struct cxl_decoder *cxl_mapping_get_decoder(struct cxl_memdev_mapping *mapping);
-struct cxl_region *cxl_mapping_get_region(struct cxl_memdev_mapping *mapping);
 unsigned int cxl_mapping_get_position(struct cxl_memdev_mapping *mapping);
 
 #define cxl_mapping_foreach(region, mapping) \
-- 
2.37.3

