Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061814BF9B
	for <linux-cxl@vger.kernel.org>; Fri, 12 Apr 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956004; cv=none; b=Ku8wbsQh6FNwFTpXQrlhTbEFsU6LKHXf1B/18jIlnVneY7keXSy/uEu2wghEqyb2uD3qmRkZCFD29Z2lHMpZJKw7S9I1cLDnDDVC2FZzMaBzvWODPFY4+Ztt7K8BJTTsr/vcbsdi/Hbm+5EF6R0UjLX5VozQvrn5tFjGohQouPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956004; c=relaxed/simple;
	bh=CSEdPdPYTjr5gHfBvjI2/VJYMO4SMTS2WFurQWRnuug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXSp0ONGbLKO7lyfT7/Qve10Xig7tcx5RkEUM8No0FRoIedlbSOJuX8Om4AiD+PMSAG+vDkUqn9ZeVUASHvfyPAtJjHlxGOoBdmUAbQQVKPl0VLMux4P1phNtU2BEZxSuEXSEs5M4/LDKH5/S5IVUZdHSkWoWuh2KxjRGrLbr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDnQBlC+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDnQBlC+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956002; x=1744492002;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CSEdPdPYTjr5gHfBvjI2/VJYMO4SMTS2WFurQWRnuug=;
  b=SDnQBlC+mBE067tC925ZeDGFgjjoQze64ul979apiInH6WlTjZgVQ/Nd
   38yjWX0JJp3uzny5tVXQiyeOTWpU5ZN4xkR4I6z+upzRLxFwHQS/mONP3
   edGYvWk87daYjsRNqnxD45XFs2MlILOcv6Ww5FyShL2h7hSrBEE4oBcd/
   b8Cq2Fi9LrvITxgbvPYj6KgEicVK/wK5h5v3UHE1rpFgmWE8W5yPfYeWF
   GmDYOGYJYAtguPfNZLZk7JE+pppmRao2+lmpw7E59VbggURbQQGuBw96h
   80PQOb9TYFWT6vtwMt+S90yGpKptHmMZB+q9cB/toxOdWVuikooTtxAuO
   w==;
X-CSE-ConnectionGUID: 9WG7GVSTRZqiXgAR5mZdmg==
X-CSE-MsgGUID: ZAJtOPZvQ7+6ZyrohKTHjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="12211951"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="12211951"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:06:21 -0700
X-CSE-ConnectionGUID: +7qdXTwXRMOYzGYPZOPyEA==
X-CSE-MsgGUID: ZtLyK7EISFG2CfvLsqMyjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21909770"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.213.183.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:06:12 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Fri, 12 Apr 2024 15:05:40 -0600
Subject: [PATCH ndctl 2/2] daxctl/device.c: Fix error propagation in
 do_xaction_device()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-vv-daxctl-fixes-v1-2-6e808174e24f@intel.com>
References: <20240412-vv-daxctl-fixes-v1-0-6e808174e24f@intel.com>
In-Reply-To: <20240412-vv-daxctl-fixes-v1-0-6e808174e24f@intel.com>
To: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.14-dev-5ce50
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=CSEdPdPYTjr5gHfBvjI2/VJYMO4SMTS2WFurQWRnuug=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDGmSi5zmtUwysZc/7huavtrHtX/bgdnP1jzUdY6qfTB/1
 0uP9B9LO0pZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRrgCGf2btKvvX+H07tEB5
 Y97M8ASBWRcMDl8+8V9xk4NM7nQLQSaG/5FOHAc+hH5mrb1Vczr9Zuj0k+xPcmv/pH3Z6lY64Vm
 tByMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

The loop through the provided list of devices in do_xaction_device()
returns the status based on whatever the last device did. Since the
order of processing devices, especially in cases like the 'all' keyword,
can be effectively random, this can lead to the same command, and same
effects, exiting with a different error code based on device ordering.

This was noticed with flakiness in the daxctl-create.sh unit test. Its
'destroy-device all' command would either pass or fail based on the
order it tried to destroy devices in. (Recall that until now, destroying
a daxX.0 device would result in a failure).

Make this slightly more consistent by saving a failed status in
do_xaction_device if any iteration of the loop produces a failure.
Return this saved status instead of returning the status of the last
device processed.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 83c61389..14d62148 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -1012,7 +1012,7 @@ static int do_xaction_device(const char *device, enum device_action action,
 	struct json_object *jdevs = NULL;
 	struct daxctl_region *region;
 	struct daxctl_dev *dev;
-	int rc = -ENXIO;
+	int rc = -ENXIO, saved_rc = 0;
 
 	*processed = 0;
 
@@ -1059,6 +1059,8 @@ static int do_xaction_device(const char *device, enum device_action action,
 				rc = -EINVAL;
 				break;
 			}
+			if (rc)
+				saved_rc = rc;
 		}
 	}
 
@@ -1070,7 +1072,7 @@ static int do_xaction_device(const char *device, enum device_action action,
 	if (jdevs)
 		util_display_json_array(stdout, jdevs, flags);
 
-	return rc;
+	return saved_rc;
 }
 
 int cmd_create_device(int argc, const char **argv, struct daxctl_ctx *ctx)

-- 
2.44.0

