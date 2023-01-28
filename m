Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA49BC27C76
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 05:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjA1FjY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 00:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA1FjX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 00:39:23 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868EA78AE0
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 21:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674884361; x=1706420361;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uH9xRg9/ZpKRPSrDgeyjwVSf2rEpxREJnIjexdlqyrc=;
  b=dlCLPjfa386G+GgkJHzC0zBWmtltdDLlJ3p/12iH0bXQj5KKE7mfB0VM
   LdAb83O3F93fihqsWJOVBiZtH952MuYsRhWk1iBZSMk0twNmnfZjpFx96
   RXm7NNPHbuAfa8GYIHWvEM3Z3h5FUSZIOpKCsrGmIrTSTgmGwkEudQ6Np
   BMYl49T36CHKr4AqAsTBLcaEwwZqY8gRXNbc3HTbhATgJRDPDA5Hm49lH
   J2Q6Rxpy+EC4AaaXMRROU9M+tVWxsx8C+2SrX8FAeMPB3GnshugmZaxh3
   cluVIMFZ+LWz735Qg43SFc4ztPeHqy7nsz3bWIAIdAstihfOTuiZieYuO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="354571972"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="354571972"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 21:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="665494599"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="665494599"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jan 2023 21:39:19 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLdvq-0000QD-0O;
        Sat, 28 Jan 2023 05:39:18 +0000
Date:   Sat, 28 Jan 2023 13:39:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [cxl:for-6.3/cxl-ram-region 16/18] lib/stackinit_kunit.c:34:13:
 error: conflicting types for 'range_contains'; have 'bool(char *, size_t,
  char *, size_t)' {aka '_Bool(char *, long unsigned int,  char *, long
 unsigned int)'}
Message-ID: <202301281339.j8qhil5k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git for-6.3/cxl-ram-region
head:   a7cf664d7e997ac36b0f466af2e2be33464ab598
commit: b879b3c78181c4a89c4a15d6cd7fc75cb1a353a6 [16/18] kernel/range: Uplevel the cxl subsystem's range_contains() helper
config: x86_64-rhel-8.3-kunit (https://download.01.org/0day-ci/archive/20230128/202301281339.j8qhil5k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=b879b3c78181c4a89c4a15d6cd7fc75cb1a353a6
        git remote add cxl https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git
        git fetch --no-tags cxl for-6.3/cxl-ram-region
        git checkout b879b3c78181c4a89c4a15d6cd7fc75cb1a353a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/stackinit_kunit.c:34:13: error: conflicting types for 'range_contains'; have 'bool(char *, size_t,  char *, size_t)' {aka '_Bool(char *, long unsigned int,  char *, long unsigned int)'}
      34 | static bool range_contains(char *haystack_start, size_t haystack_size,
         |             ^~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/page.h:21,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from arch/x86/include/asm/preempt.h:9,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/kref.h:16,
                    from include/kunit/test.h:21,
                    from lib/stackinit_kunit.c:14:
   include/linux/range.h:16:20: note: previous definition of 'range_contains' with type 'bool(struct range *, struct range *)' {aka '_Bool(struct range *, struct range *)'}
      16 | static inline bool range_contains(struct range *r1, struct range *r2)
         |                    ^~~~~~~~~~~~~~


vim +34 lib/stackinit_kunit.c

50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  33  
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23 @34  static bool range_contains(char *haystack_start, size_t haystack_size,
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  35  			   char *needle_start, size_t needle_size)
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  36  {
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  37  	if (needle_start >= haystack_start &&
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  38  	    needle_start + needle_size <= haystack_start + haystack_size)
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  39  		return true;
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  40  	return false;
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  41  }
50ceaa95ea0970 lib/test_stackinit.c Kees Cook 2019-01-23  42  

:::::: The code at line 34 was first introduced by commit
:::::: 50ceaa95ea09703722b30b4afa617c972071cd7f lib: Introduce test_stackinit module

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
