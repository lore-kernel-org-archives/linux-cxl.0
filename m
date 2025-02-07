Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC938385
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956874; cv=none; b=Hd54FWt0eebNGDJlThgKMH903l/vOoAzAu9WBo3Fbk99SHKECv1JSfQmZWBoNSfb3N5sf1aTjPXlt/nhOEgR8tDDR2vLyGep7aiovKers8itNlnprOwaYnEPC7S4j9G1lgVBp+RsuEn3L9OtpMU3WoEHF3PL7f+TF+UpeMefUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956874; c=relaxed/simple;
	bh=K7M5RQ+qnf9I3OVxUPYfB9eo6qjJs7xuCQQ8SxIh74w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GBTDc+TtcG4bF4FBXuOqwzPXL2ypaoqo+MSOngmjrMKpLVY5nGClYu1APL5PWeVtic7KfjvUXujkxvx94aQ/Z1jFF2/0BvmVrfwMWMayI1cZv4CSRiu79o+g/uVhv9va07PJNxBa5HcYOKHqCWrW+giE0OEYGveOhpm20H3RyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAQ59x1z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAQ59x1z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738956872; x=1770492872;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K7M5RQ+qnf9I3OVxUPYfB9eo6qjJs7xuCQQ8SxIh74w=;
  b=dAQ59x1zmFwb5Ls21RbQA7Q9qPYHlhpy+ZWdRLk/9JxGh4IHFwDHqvut
   epf8khaDCdOfNdZAOVq9I9BARiu1O8kV2y8M695h5rZyppj7lehja8VpD
   Ym2JE15x32vkWS5fBVz0ivy2UjwtfZA2rY2wH8FjbJAytXlmi2jaUEHuV
   vxuu3V0yUJD1VPaJ9cuZWSQxFjOzivIqRPR7ewYWcfE9C4LVB+rIQ/y1e
   8PNbess/Q/BE4XI+yLbTuJAdKbxEbLbYB81bV7cKkzMBIOvkvZuPimjI+
   7EdCHqzAasplcB7ZX1MtFzAl9yQL6OL+zN+/1WFl2iOEo671mLxfnTv8l
   w==;
X-CSE-ConnectionGUID: thADedGhRmCi+xjLMzJfAA==
X-CSE-MsgGUID: 7U4M3T4bQmeVe2EK4+Yu6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="38806901"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="38806901"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:34:31 -0800
X-CSE-ConnectionGUID: N4chW0sNT7WEjNidY5Y1XQ==
X-CSE-MsgGUID: o7POaVS5TY+mLgtjXZxwUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112234740"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.111.82])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 11:34:30 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/mbox: Check enabled_cmds before sending SET_SHUTDOWN_STATE
Date: Fri,  7 Feb 2025 11:34:25 -0800
Message-ID: <20250207193427.1711233-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL specification defines CXL_MBOX_OP_SET_SHUTDOWN_STATE as
optional. Check the enabled_cmds bitmap before sending to device.

This appeared with cxl-test where mock support for this command
is not present and -EIO is returned, leading to a WARN_ONCE()
stack trace and dev_warn()'s on every cxl_nvdimm_probe.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Not sure what we actually want to do when not supported.
Most cmds just return 0, like I did here, but maybe for
this functionality something more is warranted.

wrt cxl-test support, also not sure if this feature wants some
round-trip testing support via cxl-test mocking. I do like the
-EIO from cxl-test as a loud reminder when running cxl-test 
that something new has come in that cxl-test doesn't know about.


 drivers/cxl/core/mbox.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index c5eedcae3b02..f06a1ed81a6c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1289,6 +1289,10 @@ int cxl_dirty_shutdown_state(struct cxl_memdev_state *mds)
 		.state = 1
 	};
 
+	if (!test_bit(CXL_MEM_COMMAND_ID_SET_SHUTDOWN_STATE,
+		      cxl_mbox->enabled_cmds))
+		return 0;
+
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_SET_SHUTDOWN_STATE,
 		.size_in = sizeof(in),

base-commit: 5585e342e8d38cc598279bdb87f235f8b954dd5a
-- 
2.37.3

