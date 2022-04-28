Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3C1C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Apr 2022 22:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347530AbiD1WNV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiD1WNU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Apr 2022 18:13:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB45BCB61
        for <linux-cxl@vger.kernel.org>; Thu, 28 Apr 2022 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651183801; x=1682719801;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OGGG3wfPvKPhHFNm2pE/kyGBmEmBBn2InpMBsH1ScMs=;
  b=Mw+CDiNATxdc4KVW+KgCGhA6GO2BYb/FPBhB2eEu0NdK8tx4D7RNKAOG
   iLMnzLTSdpwIrlqqnwquSpS3Tv0DggfwW9RmPEe6dp3/2IaJJClYO+Soz
   ekKi/y5YOhvXPrUOmnQGWTg5s3GMHnauLw4LoDojSDgakfkEA/rjIHyDg
   xkh/V/AbqT6X+RvPSRb8obKpDFFxBeruIWTd/wxpjarfgtt6ONHn718GL
   fpANzH7HsJz7TSXj31PXbn7gBEuNks5OWw973gOvSsGkN9RMFMYzrqvNv
   v9BbdbSBL6nhUG4HHZ0/Gr8HX3WlgRuERI8iS7wAu5WND08K1REFhWs7V
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="248371540"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="248371540"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="581670809"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 15:10:00 -0700
Subject: [ndctl PATCH 00/10] CXL topology unit test
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Thu, 28 Apr 2022 15:10:00 -0700
Message-ID: <165118380037.1676208.7644295506592461996.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vishal,

Here is a series that adds a unit test for CXL bus operations around
port discovery and memory device enable/disable events. Along the way it
adds some helper commands ('cxl disable-bus') and calling convention
cleanups ('cxl list -p $port'). Some other miscellaneous fixups and
cleanups are thrown in for good measure.

---

Dan Williams (10):
      build: Move utility helpers to libutil.a
      util: Use SZ_ size macros in display size
      util: Pretty print terabytes
      cxl/port: Fix disable-port man page
      cxl/bus: Add bus disable support
      cxl/list: Auto-enable 'single' mode for port listings
      cxl/memdev: Fix bus_invalidate() crash
      cxl/list: Add support for filtering by host identifiers
      cxl/port: Relax port identifier validation
      cxl/test: Add topology enumeration and hotplug test


 Documentation/cxl/cxl-disable-bus.txt  |   37 +++++++
 Documentation/cxl/cxl-disable-port.txt |    6 -
 Documentation/cxl/lib/libcxl.txt       |   12 ++
 Documentation/cxl/meson.build          |    1 
 cxl/builtin.h                          |    1 
 cxl/bus.c                              |  159 +++++++++++++++++++++++++++++++
 cxl/cxl.c                              |    1 
 cxl/filter.c                           |   12 ++
 cxl/filter.h                           |    1 
 cxl/lib/libcxl.c                       |   18 +++
 cxl/lib/libcxl.sym                     |    1 
 cxl/libcxl.h                           |    1 
 cxl/list.c                             |    1 
 cxl/meson.build                        |    3 -
 cxl/port.c                             |   30 +-----
 daxctl/meson.build                     |    1 
 ndctl/meson.build                      |    2 
 test/common                            |   12 ++
 test/cxl-topology.sh                   |  166 ++++++++++++++++++++++++++++++++
 test/meson.build                       |    2 
 util/json.c                            |   26 ++++-
 util/meson.build                       |    2 
 22 files changed, 448 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/cxl/cxl-disable-bus.txt
 create mode 100644 cxl/bus.c
 create mode 100644 test/cxl-topology.sh

base-commit: 97031db9300654260bc2afb45b3600ac01beaeba
