Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072146A61B
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932089; cv=none; b=UsxktHBH/nGKC0lJ8yaKtfpYJG+/cyepPaTZ0tbRXTC9FKhfObJ471ChYJr/U6aYhAKmIiaJDOSXYAHSDBtzu3p6UW10jwpZl9UnVzMcHZiOghrvtwWXvSRiZFoeJPbP6l5hvnJnJxc321ETmnA/viQuxtWDig0IyYKr48Grt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932089; c=relaxed/simple;
	bh=WxeSXqkn8XQJ2DQnBiL86YuseSZpjXQe3lXtFLiggI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRyVQd85Au+uG8zGbhBewuZ6aQMj3Af9axfsasV9gnhdApKE3nlsnWOwUDez71wjmK5x9VVh/loCzGRGoWs9rhUp1uVTQYuQFL3XKUarfHWjmBQvMYYKuIt+NQXb2veRoX9+9InfGSdbLZXcFyYxXuVvlzpj0EhXJ5SIC9wkPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNGrUy+l; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNGrUy+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784932087; x=1816468087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WxeSXqkn8XQJ2DQnBiL86YuseSZpjXQe3lXtFLiggI8=;
  b=LNGrUy+l2DRnc506AESRrqFNq1exNVH+LSlrVJoHLDeKEa+gpGORaaFe
   vOjhz5zPiQZA5RhotBDELQGoLuTbJtGBk+sXecYbSm298Hb314LdeHzXk
   pel/agNEbrGBHR1cM67wG1DX3XHY2ytuo0WLMv25zl8Qtw0UP+Az0TJRx
   jLGEyyWlIFQKlnlI0Zp02vC4VlrbBaeiPP3Jp59EeDKgziK0gMfYszPmO
   H7SHdfUrp91sOFa1mL2jvkY+8HNcBnVz1gNPPbNWIFnLq9q8cdaQ1Mttg
   q9EVcbQS3vENbx46Ud1AFFHe6G7WL/UIK3IplVEeghBcrNwsxTyJBcCtZ
   g==;
X-CSE-ConnectionGUID: csZXY7BTTUSIMxlQBKTnHg==
X-CSE-MsgGUID: HDk3cTabSyeq66M5zalwLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85547901"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85547901"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 15:28:07 -0700
X-CSE-ConnectionGUID: XYaoNQBnT1mWe9tQTKZ2cQ==
X-CSE-MsgGUID: HJDB+E81Q1awLa1OOiHekw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="297052658"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 15:28:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3 1/2] cxl/region: Fix use-after-free in find_pos_and_ways() error path
Date: Fri, 24 Jul 2026 15:28:01 -0700
Message-ID: <10deb519b543ef693ce23148b509a03fe1c07d0c.1784931354.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path releases its reference to a switch decoder before
logging an error that includes the decoder name. If the released
reference is the last one, the decoder can be freed before the error
message accesses its name.

Drop the reference after the error is reported.

Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v3:
- Log dev_name(dev) instead of dev_name(&cxlsd->cxld.dev) (Jonathan)
- Remove double space in commit log (Jonathan)
Changes in v2:
- No changes in v2


 drivers/cxl/core/region.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..6d902e1c4161 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1938,14 +1938,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 			break;
 		}
 	}
-	put_device(dev);
-
 	if (rc)
 		dev_err(port->uport_dev,
 			"failed to find %s:%s in target list of %s\n",
 			dev_name(&port->dev),
-			dev_name(port->parent_dport->dport_dev),
-			dev_name(&cxlsd->cxld.dev));
+			dev_name(port->parent_dport->dport_dev), dev_name(dev));
+
+	put_device(dev);
 
 	return rc;
 }

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

