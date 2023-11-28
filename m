Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l71sah5U"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA388170B
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 12:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701204298; x=1732740298;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xiWunW3tLxatCcTsfAT92QSg8IT5oJt1XnrD1Z6qJbw=;
  b=l71sah5UhMbKRiUny1ZWvhdrZauyjUI4TfOdVZN1tIDr4/oaVcia9d9t
   Gj0K1jUA0D8+RbCkZgvvDqz5OU20AO2oAFeNbDOHP6/tfKFNcoCNf6A/V
   +BdGQy6PEqWuZKjO2PWxJvedsl5ZDtnpKb8i31E+XpJ24G/McwlWXANtw
   4wq3R0EtX+EdGt1g8q+mfHuvbXrWn2qCcGyAUy5owd/Yb7ZQSxSFZ7oIY
   nC7k7jcHvRNtuq3fq+zHAzWq5XpqqmAcZH1OXhr++aGNvYpzzBc+H+adt
   FBUWfUN5AbOXKxp+3UaffQDAu6qHe+vpolk283sQdyJhhNGiIBradDStr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424171259"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424171259"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:43:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="834761200"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="834761200"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.164.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:43:57 -0800
Subject: [NDCTL PATCH v2 2/2] cxl: Add check for regions before disabling
 memdev
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc: vishal.l.verma@intel.com, alison.schofield@intel.com, caoqq@fujitsu.com
Date: Tue, 28 Nov 2023 13:43:57 -0700
Message-ID: <170120423751.2725915.8152057882418377474.stgit@djiang5-mobl3>
In-Reply-To: <170120423159.2725915.14670830315829916850.stgit@djiang5-mobl3>
References: <170120423159.2725915.14670830315829916850.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a check for memdev disable to see if there are active regions present
before disabling the device. This is necessary now regions are present to
fulfill the TODO that was left there. The best way to determine if a
region is active is to see if there are decoders enabled for the mem
device. This is also best effort as the state is only a snapshot the
kernel provides and is not atomic WRT the memdev disable operation. The
expectation is the admin issuing the command has full control of the mem
device and there are no other agents also attempt to control the device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Warn if active region regardless of -f. (Alison)
- Expound on -f behavior in man page. (Vishal)
---
 Documentation/cxl/cxl-disable-memdev.txt |    4 +++-
 cxl/memdev.c                             |   17 ++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/cxl/cxl-disable-memdev.txt b/Documentation/cxl/cxl-disable-memdev.txt
index c4edb93ee94a..34b720288705 100644
--- a/Documentation/cxl/cxl-disable-memdev.txt
+++ b/Documentation/cxl/cxl-disable-memdev.txt
@@ -27,7 +27,9 @@ include::bus-option.txt[]
 	a device if the tool determines the memdev is in active usage. Recall
 	that CXL memory ranges might have been established by platform
 	firmware and disabling an active device is akin to force removing
-	memory from a running system.
+	memory from a running system. Going down this path does not offline
+	active memory if they are currently online. User is recommended to
+	offline and disable the appropriate regions before disabling the memdevs.
 
 -v::
 	Turn on verbose debug messages in the library (if libcxl was built with
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 2dd2e7fcc4dd..1d3121915284 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -437,14 +437,25 @@ static int action_free_dpa(struct cxl_memdev *memdev,
 
 static int action_disable(struct cxl_memdev *memdev, struct action_context *actx)
 {
+	struct cxl_endpoint *ep;
+	struct cxl_port *port;
+
 	if (!cxl_memdev_is_enabled(memdev))
 		return 0;
 
-	if (!param.force) {
-		/* TODO: actually detect rather than assume active */
+	ep = cxl_memdev_get_endpoint(memdev);
+	if (!ep)
+		return -ENODEV;
+
+	port = cxl_endpoint_get_port(ep);
+	if (!port)
+		return -ENODEV;
+
+	if (cxl_port_decoders_committed(port)) {
 		log_err(&ml, "%s is part of an active region\n",
 			cxl_memdev_get_devname(memdev));
-		return -EBUSY;
+		if (!param.force)
+			return -EBUSY;
 	}
 
 	return cxl_memdev_disable_invalidate(memdev);


