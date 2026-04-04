Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DA42248B9
	for <linux-cxl@vger.kernel.org>; Sat,  4 Apr 2026 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775266490; cv=none; b=peF9ZNIIcHDVbk6TEq23gWMVcF/X5IhdF6SmG5DL3oqsiJRHNYM5qkZwIa/LhSmVH36n8veuPXA3UTxBrQSTZ7KDgv7MIUuGq/CdB39OUGEltoJCkC0zXRX1UwOOArl7Tj1MoblppBObWbF8MmZsqRpeLgSXWi25bKKFRQLeQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775266490; c=relaxed/simple;
	bh=VexOKT53SR2Imwb0pZcMVdJC22LaigvYnaArxH0XH30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzlmbLn1hCOvqUYlC6MpqydP/9CHvedfe29Op46g+uqOLEbmLGKGQCi34Ws+KQxovbx0vNpDOYGnwFV/MC1eHGwHmR6/FFYVCltMjmSV/gOxqYzB6aVQSJRy51rrNumn1g1ZytwLea2h9TB/C7q+ERXTmtlZb/48fdFEfqPiKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uol+R9vz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uol+R9vz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775266488; x=1806802488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VexOKT53SR2Imwb0pZcMVdJC22LaigvYnaArxH0XH30=;
  b=Uol+R9vzUyM469sCVbLzCQjwtsulsaUvVlC0PJQRHgm8gh8h+l1PjIO0
   9b+mNyEhfW6jvHjHRFVJnI5H2TTPsFCH0rBclI6B3yzhwzVHpYCnddjfU
   yxJQ3KkNPgCcUNdOvS3MFUIUWiyarkcbQ+U/n2800LHFwH/NjcCKGbNNa
   qbKKlELHL+JyBcLbCdVy7/Rx9tm5M+aFZw6nZ8RwxXC7bl/+fO/CB0LBu
   Bp0p9pOuD5GLUgq5DgZaLCNjNqb/kxDgxCFn/kEkXtQq8nOA3u3LjxrfF
   FJibAUcXjbXzLhI1IWecINcE+Kr/PhWseDVCfDNcMuJnm09NwWOuLFnbW
   g==;
X-CSE-ConnectionGUID: WQl/o3b1S6ymfIoxiCQvnA==
X-CSE-MsgGUID: 0sR/NgK9RbS4Agtzv7acMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76218256"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76218256"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 18:34:47 -0700
X-CSE-ConnectionGUID: BNHKh+w5Tbeef/VamTmLAA==
X-CSE-MsgGUID: GNf9LcatTYiO8GFC93bMdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="257856874"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.12])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 18:34:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>
Subject: [ndctl PATCH 2/3] cxl/region: prevent partial teardown on out-of-order destroy-region
Date: Fri,  3 Apr 2026 18:34:40 -0700
Message-ID: <14c870a73b062b7dc22fc9d2453aeff8f89fd4b7.1775265383.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c2eccb9b0e596820940bfc7ec839ff807f3ac613.1775265383.git.alison.schofield@intel.com>
References: <c2eccb9b0e596820940bfc7ec839ff807f3ac613.1775265383.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Destroy-region will partially tear down a region for an out-of-order
decoder reset request, resetting decode state and removing targets
before later failing in DPA release. The user sees:

cxl region: destroy_region: decoder11.0: set_dpa_size failed: Device or resource busy

After that failure, follow-on operations (list, enable, destroy) can
fail even after correcting the order.

Validate endpoint decoder teardown order before starting cleanup. If a
later endpoint decoder on the same port is still active, fail early with
-EBUSY and a targeted message.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 cxl/region.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/cxl/region.c b/cxl/region.c
index 95a7aa14268c..85d4d9bb54f2 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -831,6 +831,64 @@ out:
 	return cxl_region_disable(region);
 }
 
+static int region_destroy_validate_order(struct cxl_region *region)
+{
+	const char *devname = cxl_region_get_devname(region);
+	unsigned int ways, i;
+
+	ways = cxl_region_get_interleave_ways(region);
+	if (ways == 0 || ways == UINT_MAX) {
+		log_err(&rl, "%s: error getting interleave ways\n", devname);
+		return -ENXIO;
+	}
+
+	for (i = 0; i < ways; i++) {
+		struct cxl_decoder *ep_decoder, *decoder;
+		struct cxl_port *port;
+		struct cxl_memdev *memdev;
+		int id;
+
+		ep_decoder = cxl_region_get_target_decoder(region, i);
+		if (!ep_decoder)
+			return -ENXIO;
+
+		port = cxl_decoder_get_port(ep_decoder);
+		if (!port)
+			return -ENXIO;
+
+		memdev = cxl_decoder_get_memdev(ep_decoder);
+		if (!memdev)
+			return -ENXIO;
+
+		id = cxl_decoder_get_id(ep_decoder);
+
+		cxl_decoder_foreach(port, decoder) {
+			struct cxl_memdev *other_memdev;
+
+			if (decoder == ep_decoder)
+				continue;
+
+			other_memdev = cxl_decoder_get_memdev(decoder);
+			if (other_memdev != memdev)
+				continue;
+
+			if (cxl_decoder_get_id(decoder) <= id)
+				continue;
+
+			if (cxl_decoder_get_dpa_size(decoder) == 0)
+				continue;
+
+			log_err(&rl,
+				"%s: destroy blocked, %s still has later active decoder %s\n",
+				devname, cxl_memdev_get_devname(memdev),
+				cxl_decoder_get_devname(decoder));
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
 static int destroy_region(struct cxl_region *region)
 {
 	const char *devname = cxl_region_get_devname(region);
@@ -843,6 +901,10 @@ static int destroy_region(struct cxl_region *region)
 		return -EPERM;
 	}
 
+	rc = region_destroy_validate_order(region);
+	if (rc)
+		return rc;
+
 	/* First, unbind/disable the region if needed */
 	if (cxl_region_is_enabled(region)) {
 		if (param.force) {
-- 
2.37.3

