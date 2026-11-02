Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654384;
	b=hk1zHiycs03qoVe/N12+8U2xt386J+vVyOSc+8QT7gnqPG8aYEpILDQJ1P2EKj7qBDYM
	 uxPouEavIOwHDpCDGvzGwXEAw8EPvnKXPTy75pVqCxxP5YacpoeU/9bQTagYPdFpuknrZ
	 wgy8oJcN9OnTbbdxFh9Yee4z4kwWkas5IWldPY82uYc7EicOGqND7AcbTtXp/dhpcRUqf
	 pcx4rZD9aMHb+yza0zq8p6mqlJP1o+Qut0kXf7k1mGPysQhNtsXPJ+Aatpd0CQJN32dpm
	 xmp9aJzwB84OEMdspQ1x0+gmaxgz/bxfr01wBCnPo5H3AQHEAabmC2OP9KHgwGmp8uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654384;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bl4nBJ+jPqbeGkBbC70UjTA+IKil0peLV/sYI2/jfsM=;
	b=TF6k1sxhoX8z0ZHQ11yUtDnTEw8t8SPMIkHLAnnYBJ3mKXDH7ow2Zz584xLwZEzCDTS0
	 VAsT6nmGySi4bUWOwwYRPOwvbsnQf6JSt9z1rhmoJ683iEPzjCFP+r2Aj7PcTgUf0c0Pc
	 Q3PKTlMYJYvNvssFg5YZtsd2Ee1P6es/1mvcar5KAr+xNaAbudf2xyqCZ9KbSEnRSlAZv
	 MCqRmXuFwoSQL+U+HcATkfxtWm1RQsqbgice7a1rWLZK+cqd6ffSrNPVqqqWr10QgRHN+
	 2c6Bxy9zaP52LcPOMT3zdhqmG4UdNSQZcddKUnp7U693PUkHisvwvSpauXw2JuCZ+0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Uk/DQ0S9";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BD606A32C
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 21:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 988BD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Uk/DQ0S9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793654384; x=1825190384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VbLn49I12WtEtKqcyIV2MMpnYzZ4WtR006PqQbCa8II=;
  b=Uk/DQ0S9aOv3DDp5spAYI+tQhDnG+hPnqwGPG7fyO/Tr8QWVCmhTRUMg
   5rc+053baUZMm55ketCDcdE5bby4c9+mJ0rSP643rzbMZrWIIIkZzWC54
   TPaTZdTs36BIfWvgL6tpkrImhsQkF5uuahtG+UcEaJtQFxzeRG02NHz8K
   G9b5nEyn+BUjVAv+FR3C4l0Z95TdvOa+uhryfUFpfxZpaop2xb4B0CNcA
   SAcZg35xYInMtK0SQ6pcSSiJ2FYhBkqTA29frRGZre9InUDlMu3ddJRf8
   sWn7z4bSfhcGcjXBsreE7zv+ewp5ySLCvRcF8A4MH8nEq0gZKaFVGVZVh
   w==;
X-CSE-ConnectionGUID: sJVUqFm3ScGeh87rpgdK3w==
X-CSE-MsgGUID: YNBQpSJ1S8aZR0Uo17GG5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2242580"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2242580"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 13:19:44 -0800
X-CSE-ConnectionGUID: AU1ZLu/wSnCJ+Xgfrjt22g==
X-CSE-MsgGUID: 1y4zUhuUQumG5IE08uajUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="8062481"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 13:19:42 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 2/2] cxl/Documentation: Describe clearing a region targetN position
Date: Mon,  2 Nov 2026 13:19:37 -0800
Message-ID: <e87248b8d13d3f07741243a45891365450c66881.1793653629.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
References: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The region targetN ABI documents that writing to an occupied position
returns EBUSY, but does not describe how to clear the position. Clearing
a position is supported but undocumented, leaving no documented recovery
path after writing the wrong endpoint decoder.

Document how to clear a position by writing an empty string, how clearing a
position decommits a committed region, and how the region can be committed
again after all positions are filled.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v3:
- Restore the original entry text and append how to clear a position
- Rebase on 7.4-rc1
v2: https://lore.kernel.org/linux-cxl/efa1a098550077dc3571796ba0102ddabe1e9b0d.1792989098.git.alison.schofield@intel.com/

Changes in v2:
- Say that writing the endpoint decoder already at a position succeeds
- Split the entry into paragraphs and drop the v1 error code reordering
v1: https://lore.kernel.org/linux-cxl/a007c751d88ee64c9d0b7bb3c69a486c42358b36.1790829690.git.alison.schofield@intel.com/
---
 Documentation/ABI/testing/sysfs-bus-cxl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 7352dbd70bc7..3629c983f05c 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -568,6 +568,10 @@ Description:
 		not an endpoint decoder. Once all positions have been
 		successfully written a final validation for decode conflicts is
 		performed before activating the region.
+		To clear a position, for example to replace an endpoint
+		decoder, write an empty string (echo > targetX). Clearing
+		a position in a committed region also decommits the region.
+		It can be committed again after all positions are filled.
 
 
 What:		/sys/bus/cxl/devices/regionZ/commit
-- 
2.37.3

