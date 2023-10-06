Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45063AC
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RySmav0P"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0BEA
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577507; x=1728113507;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q7vhPUDWXNfqWDELlhMeBc9BZqLxKU3D4bjQ/FDoOLE=;
  b=RySmav0PNdg+H7sJpV9T3UH5UMEYaPur2kVcmqiKR1KG3yYq4o0NmQtY
   1NHGzlNxcdZyXvyPiTMtjecYtwbAeECkP41ybHCh40ve7NczvPjMhAQf3
   nKJ5Wn1nvUJ1FZttAYjrKbrsuSqQ8NSq3xf7yTl6/W5lb7EJqCn++8PR+
   HCXACbgWgvANm18DQK2FyiJN6YHf85xGnDbViVumhkfVEWir9pJ/Vppr/
   bIr1yDprtZDffnIeMIXOgUP/EqYRvaV6tPw9h4pYjgvP20uwextUktZie
   WDsCQ0Os0C+s+a3sutfV/CYHB6ygelPrJKwPquP5KrTwP71RHnjO8rcwf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368775566"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368775566"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842736311"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842736311"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:31:34 -0700
Subject: [ndctl PATCH 0/2] cxl: Add sanitization notifier tests
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Date: Fri, 06 Oct 2023 00:31:34 -0700
Message-ID: <169657749402.1491881.12666757616880845510.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add cxl-cli infrastructure for awaiting sanitize operations, and
introduce a new test to validate the kernel ABI for sanitize.

---

Dan Williams (2):
      cxl/memdev: Add a wait-sanitize command
      cxl/test: Validate sanitize notifications


 Documentation/cxl/cxl-wait-sanitize.txt |   44 ++++++++++++++++++
 Documentation/cxl/lib/libcxl.txt        |    5 ++
 Documentation/cxl/meson.build           |    1 
 cxl/builtin.h                           |    1 
 cxl/cxl.c                               |    1 
 cxl/lib/libcxl.c                        |   63 ++++++++++++++++++++++++++
 cxl/lib/libcxl.sym                      |    5 ++
 cxl/libcxl.h                            |    1 
 cxl/memdev.c                            |   34 +++++++++++++-
 test/cxl-sanitize.sh                    |   76 +++++++++++++++++++++++++++++++
 test/meson.build                        |    2 +
 11 files changed, 232 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/cxl/cxl-wait-sanitize.txt
 create mode 100644 test/cxl-sanitize.sh

base-commit: 76768f88cebae1a298d8f42c6d135e5acc09dcb4
