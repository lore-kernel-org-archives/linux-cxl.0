Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FAFEA1
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUXpb4lJ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012DE9
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577160; x=1728113160;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ibUTLhUbLnbjKTKdLdCDBXD0pt+VdN5vLQrlR4YDj74=;
  b=mUXpb4lJgAwlelQHtN3k+dxpOnHWElbODKVT5IMFmZYsI1FjY+Ytl7M8
   K38d0vIPJvwgn5Jwrp8jRqG80gYQcQNpZSk97mEAxYDB0mgF5OtbC59vJ
   DvtPRpB1YmVfG8UCWYRMloQ/qMiBHAj3+nheqNHVX/EGEODx8nIzdjkTO
   wUdtzZJs6onPIxCs1dsCfrcsHcKUoYr545r4ylFNd2pfNWal9y+L20hlM
   wah0Ds+KvmO6u2DTGJvFwG+E88y8K6euFzr/GwHuTClb8RU6GWBsk93WV
   4+hTNkx2+6qiOCW7H4zqJq6RJOm3KpkRUiks90ZLQ5vOQhsEQvOsLpOLJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368775163"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368775163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842735364"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842735364"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:25:58 -0700
Subject: [PATCH v3 00/10] cxl/mem: Fix shutdown order
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Date: Fri, 06 Oct 2023 00:25:58 -0700
Message-ID: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
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

Changes since v2 [1]:
- Fix @dev vs @host confusion in cxl_sanitize_setup_notifier()
  (Davidlohr)
- Fix hardirq vs threadirq context for taking mbox lock in the handler
  (Davidlohr)
- Switch a test to boolean notation (Jonathan)
- Clarify why cxl_sanitize_setup_notifier() takes @cxlmd, instead of
  @mds (Jonathan)
- Drop export of cxl_mem_sanitize()
- Make it more obvious where some setup functions are taking an @host
  parameter vs an device object / context to operate on parameter.
- Fix synchronization between sanitize and decoder commit
- Add cxl_test infrastructure to regression test these ABI paths

[1]: http://lore.kernel.org/r/169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com

---

While fixing a crash where the cxlmd->cxlds validity needed to be
maintained over the span of the memdev being unregistered, I made a note
to come back and cleanup sanitize notifier setup/shutdown
implementation. Jonathan went further and noticed that the fix needs
that rework first [2].

[2]: http://lore.kernel.org/r/20230929100316.00004546@Huawei.com

The special wrinkle of the sanitize notifier is that it interacts with
interrupts, which are enabled early in the flow, and it interacts with
memdev sysfs which is not initialized until late in the flow.

After some other cleanups, a self contained
cxl_sanitize_setup_notifier() is introduced to centralize that
incremental setup work, and leave cxl_memdev_shutdown() alone to
coordinate closing down the ioctl path relative to the unregister event
of the memdev.

As I went to checkout the notifier in cxl_test I realized that it
insta-crashes since it tries to read registers from a sysfs attribute.
It turns out that could be fixed as a side effect of fixing the race
between issuing the sanitize command and committing decoders.

Given the new locking and the fallout from not having regression
coverage here I went ahead and extended cxl_test to exercise these ABI
paths. Watch for the related cxl-cli set next.

---

Dan Williams (10):
      cxl/pci: Remove unnecessary device reference management in sanitize work
      cxl/pci: Cleanup 'sanitize' to always poll
      cxl/pci: Remove hardirq handler for cxl_request_irq()
      cxl/pci: Remove inconsistent usage of dev_err_probe()
      cxl/pci: Clarify devm host for memdev relative setup
      cxl/pci: Fix sanitize notifier setup
      cxl/memdev: Fix sanitize vs decoder setup locking
      cxl/mem: Fix shutdown order
      tools/testing/cxl: Make cxl_memdev_state available to other command emulation
      tools/testing/cxl: Add 'sanitize notifier' support


 drivers/cxl/core/core.h      |    1 
 drivers/cxl/core/hdm.c       |   19 +++++
 drivers/cxl/core/mbox.c      |   55 +++++++++++----
 drivers/cxl/core/memdev.c    |  157 ++++++++++++++++++------------------------
 drivers/cxl/core/port.c      |    6 ++
 drivers/cxl/core/region.c    |    6 --
 drivers/cxl/cxlmem.h         |   13 ++-
 drivers/cxl/pci.c            |   88 +++++++++++-------------
 tools/testing/cxl/test/mem.c |   78 +++++++++++++++++++--
 9 files changed, 256 insertions(+), 167 deletions(-)

base-commit: 6465e260f48790807eef06b583b38ca9789b6072
