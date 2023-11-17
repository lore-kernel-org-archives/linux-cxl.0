Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0DMTbig"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C14D10D9
	for <linux-cxl@vger.kernel.org>; Fri, 17 Nov 2023 12:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700252329; x=1731788329;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qMVKZYkvE6KRgLwOmlFgmCB6SGmyaTpZis6uKCwNnvs=;
  b=k0DMTbigpB9NZBV/XTnW6iNY1lS2zNU+Hu8nwosn1CkKdPTwSLhiPBMP
   +kIWhms8pqgGa6FgRfJPVuJWbzHfunMB2+yyPZWLtRCyiP3eIXZWNa0hB
   bmhxtjmHEbhjmyEZlV5RTF9iHQFOz6L4Mi+mO0x7Un5oenVeLciu2dV3n
   dGpStL8S38bPGlB2xZyoIlin9NuUzzJImFgZ1ZpAXz3lLSoQEbjkAaIlB
   +B45ETjX/jIG3nKzJWdSceqSnqLvBRFdPkxjTEVEoO8xZqjeSDXXVhLe3
   dJo+xW2djlSQ2arOMDF5RbXuSr6zGiOBFt8H+O9ksXfDJqh6nsHwcxR5c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="12914339"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12914339"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 12:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="14016912"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.64.85])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 12:18:48 -0800
Subject: [PATCH v3] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 peterz@infradead.org
Date: Fri, 17 Nov 2023 13:18:48 -0700
Message-ID: <170025232811.2147250.16376901801315194121.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

init_hdm_decoder() modifies port->commit_end without taking the
cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
However looking at the code, it looks like the write version of the rwsem
needs to be taken due to the modification of commit_end. Wrap the write
version of the rwsem around reading and writing of commit_end.

Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Just do the one line change. (Dan)
v2:
- Add changes from Ira and moving the lock block
- Add suggestion from Dan on using guard()
---
 drivers/cxl/core/hdm.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1cc9be85ba4c..529baa8a1759 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -839,6 +839,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
+
+		guard(rwsem_write)(&cxl_region_rwsem);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",


