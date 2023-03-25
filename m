Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B02C6FD1F
	for <linux-cxl@archiver.kernel.org>; Sat, 25 Mar 2023 14:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjCYOYI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 25 Mar 2023 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCYOYH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 25 Mar 2023 10:24:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAC3132DE;
        Sat, 25 Mar 2023 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679754246; x=1711290246;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G5dKp3GhNYs5afXAsBYrDFF1t73ncz8rHznKQk17txc=;
  b=eEPmpibVvLikWxd8u9UAnUu8GVW6bqnYqMjzoMz+Fbbpy5o1AQMEaE8q
   6T+Zn/Qv28JWhKVIaBI9WyJuPkcZIaGUkVdpJuvPmAA/mE0zG2thmSPXu
   jo44sDMMHElA1b59M+GV4GOUAXmHNRcj9PUxi5DIAzopA4w31AIfTVs+P
   XBlJBolrxvz1ZOqrSp5e98p349CFbVhOQHQ6/O2K97IaYttPom6jDa0/w
   omRG593PQC3cDGabx6bhl/VeZhcNZa1gJj1LeNa0Ijh7qxukZQ+7Of2Ca
   6STIydLkrEveAYO/KkGw7Smus82oqD0UGngg9XasSoOgZK7AMlJywnO52
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="342372207"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="342372207"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 07:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10660"; a="793780446"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="793780446"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2023 07:24:03 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pg4oN-000GJd-1B;
        Sat, 25 Mar 2023 14:24:03 +0000
Date:   Sat, 25 Mar 2023 22:23:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [cxl:for-6.4/cxl-type-2 20/22] htmldocs:
 Documentation/driver-api/cxl/memory-devices:454:
 ./drivers/cxl/core/region.c:678: WARNING: Inline emphasis start-string
 without end-string.
Message-ID: <202303252234.exORHn1K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.4/cxl-type-2
head:   0b80e8b55828313bcd08c4740646689e648de444
commit: e68a88d2ee505c0f142b2ff072acc95621131eb6 [20/22] cxl/region: Define a driver interface for HPA free space enumeration
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=e68a88d2ee505c0f142b2ff072acc95621131eb6
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.4/cxl-type-2
        git checkout e68a88d2ee505c0f142b2ff072acc95621131eb6
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303252234.exORHn1K-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/driver-api/cxl/memory-devices:454: ./drivers/cxl/core/region.c:678: WARNING: Inline emphasis start-string without end-string.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
