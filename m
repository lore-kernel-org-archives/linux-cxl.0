Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0AJE4LF"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6469D75;
	Fri, 17 Nov 2023 17:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700270071; x=1731806071;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=HFG8kLUe4vv5Z2uiWItE1PUphf9YnXqnmGBqMdklOmQ=;
  b=n0AJE4LFhn5mSLoIMrKLJj81Ff8kghiNyALjVHTft+mLu0YbxpPcYxLS
   MjCYQ8OPyxycclcD8L9Gj4cUYdl54dTCZnieRCoWVXWCcmLboRl9BYdBj
   3ZaCqBGNcGTOf8q8ui0+0IwI2A2/V8A09lLWtANuCgKO/K3dql+8y7UkA
   ehveIrhgW6rlXD1ISVC1q59bDCl/PNv5gFBhe/WUDyXavCuMXH/LbDpI2
   Ab6dWoDCd0iuGIXvDzo+kDp04kI0DBW9m+VhjWD9fUfP4WXk5J1LyZlaa
   QYCzfe00fOIP0wpd73g7/3WpnhFBELfpi8oA0QRsMuNH0ypJEN6TCXlEQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390256190"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390256190"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889406622"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889406622"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.174.178])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:14:30 -0800
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/2] cxl/cdat: Fixes for CXL CDAT processing
Date: Fri, 17 Nov 2023 17:14:20 -0800
Message-Id: <20231117-fix-cdat-cs-v1-0-ffc2b116ca6c@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwPWGUC/x2NQQrDMAwEvxJ07kLlhqT0K6UHRVIaX9xilxAI+
 XvtHAd2ZncqnqMXenQ7ZV9jiZ9UgS8d6SLp7YhWmcI13Jh5xBw3qMkPWiB3tzG4htD3VI1JimP
 KknRpziwJpgbzFc0HM3how2/22jlvn6/j+AN4nCWuhgAAAA==
To: Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Fan Ni <nifan.cxl@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700270069; l=745;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=HFG8kLUe4vv5Z2uiWItE1PUphf9YnXqnmGBqMdklOmQ=;
 b=5UmWJPI5XCj3d4vAgaopq1s7Cf1UAxnhtlYFDOCKJjZzJOuozb40/Fq5hdSW9g1oJEGRtBNf+
 afZqlW/6QvPDZ1pifXRcqzB55w/xr2gS7mILGqH7f6RRbDwdXhA8RxJ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

These are a couple of fixes needed for DCD processing.  The first is via
code inspection and the second was found as a result of the kernel bug
found previously.[1]

Does the QEMU code require fixes tags like the kernel?

[1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Ira Weiny (2):
      cxl/cdat: Handle cdat table build errors
      cxl/cdat: Fix header sum value in CDAT checksum

 hw/cxl/cxl-cdat.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)
---
base-commit: abe893944bb3fb3ca59aaeaa8d48e52dfdc0f3db
change-id: 20231117-fix-cdat-cs-a8ed72ec2244

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

