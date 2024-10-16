Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BF1D47AE
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729121057; cv=none; b=dSvUTk6gFl7cS1xgFaA+pjFgv1EszqDf146L9gAzdDzmtFoeK2NcwMmA/WsOvcSdL5j6OhwUI0koD7y0BmXaAxIJK8Fp9sN0JBJDhtI2FOI3BzbkFyxwjJE5XcMj1fZlSvGyDehO1lHzMpOlrmnv0J0WGgip3PpvUqs8xqgchYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729121057; c=relaxed/simple;
	bh=w7jB3Bmg0IHrfZyI7lRmgUtFfpbyIYZk93HT0ALZqTE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qgj13uDM9r94AbtAQkAxV1ksnm8/lQUbarHL0K6b4E9w1pJck5ccGfFuRutSpz8KOteUWjzyR6Vspb3D5nh+wxstu3J5m/nek03U/3jkoy03/toGqMa4dKysy5xesEGuNd4NAZSVRDYcrJ7iEpbD3UtcBlTJVoDzdtDKxjzTQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTrruH8M; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTrruH8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729121055; x=1760657055;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7jB3Bmg0IHrfZyI7lRmgUtFfpbyIYZk93HT0ALZqTE=;
  b=HTrruH8Mea1NYVMvic2a998zs6Mju8VoWvoOb93tmRizdmye4BrH9Pn7
   XAxvH5yctiAPHkr7E3oQKB/UrZzNnGBYgQqCekL1fvrGT/0CAfWwTPRpn
   jNgfS/+s59x0D19IvnyABI2Oq9seRL7Ufv/8K0gF0tLEugjTl7fhnYiqF
   pg/iDwd6wxp74gzutToXd1Ub/WNhflhE9X9COsynRO/vB9VGjfVc3+22a
   F6/sZYK3RAiWAne5WV2vyZCoN3bi8hE4qIA9mehtyp5zkipAaxQAeL0aj
   hpblD3NkFk2+O4T8dOtytm1yO7gCTgpf3ganoBEt5ZM4ZvoipJhH2nu0c
   Q==;
X-CSE-ConnectionGUID: i1xfTxdWScGQrdOt74Gx0w==
X-CSE-MsgGUID: FQPtJ0/bRMi4Y7M1yXxXog==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28377986"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28377986"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 16:24:15 -0700
X-CSE-ConnectionGUID: +tVlDz/OTMKgxHi3eVp/KQ==
X-CSE-MsgGUID: h4sU0QfRTqCBY1qAB7dLyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,209,1725346800"; 
   d="scan'208";a="78529246"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.250])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 16:24:15 -0700
Subject: [PATCH 2/2] cxl/port: Revert __free() conversion of
 add_port_attach_ep()
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com, dave.jiang@intel.com
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Li Ming <ming4.li@intel.com>,
 linux-cxl@vger.kernel.org
Date: Wed, 16 Oct 2024 16:24:13 -0700
Message-ID: <172912105192.1414627.12908026603084784872.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172912104335.1414627.1377616790909088415.stgit@dwillia2-xfh.jf.intel.com>
References: <172912104335.1414627.1377616790909088415.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Dan points out via smatch [1] that the conversion of
add_port_attach_ep() to use cleanup helpers does not correctly handle a
pointer reassignment case.

    drivers/cxl/core/port.c:1591 add_port_attach_ep()
    warn: re-assigning __cleanup__ ptr 'port'

In the case that @port is not found and a new @port is created the
cleanup method changes from __free() to devm.

Revert the change for now as this function is not amenable to cleanup
helpers without a wider refactoring.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: http://lore.kernel.org/2a19289b-0bcf-42c4-82a9-268a922535f2@stanley.mountain [1]
Cc: Li Ming <ming4.li@intel.com>
Fixes: dd2617ebd2a6 ("cxl/port: Use __free() to drop put_device() for cxl_port")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 54dd2cd450ca..8e6596e147b3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1544,6 +1544,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			      struct device *dport_dev)
 {
 	struct device *dparent = grandparent(dport_dev);
+	struct cxl_port *port, *parent_port = NULL;
 	struct cxl_dport *dport, *parent_dport;
 	resource_size_t component_reg_phys;
 	int rc;
@@ -1559,18 +1560,12 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	struct cxl_port *parent_port __free(put_cxl_port) =
-		find_cxl_port(dparent, &parent_dport);
+	parent_port = find_cxl_port(dparent, &parent_dport);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
 	}
 
-	/*
-	 * Definition with __free() here to keep the sequence of
-	 * dereferencing the device of the port before the parent_port releasing.
-	 */
-	struct cxl_port *port __free(put_cxl_port) = NULL;
 	device_lock(&parent_port->dev);
 	if (!parent_port->dev.driver) {
 		dev_warn(&cxlmd->dev,
@@ -1605,8 +1600,10 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 			 */
 			rc = -ENXIO;
 		}
+		put_device(&port->dev);
 	}
 
+	put_device(&parent_port->dev);
 	return rc;
 }
 

