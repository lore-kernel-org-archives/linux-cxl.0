Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363BEC38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 11:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjA1Lce (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 06:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjA1Lcd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 06:32:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178CE4F362
        for <linux-cxl@vger.kernel.org>; Sat, 28 Jan 2023 03:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674905551; x=1706441551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=utNWtFkj1h5ePpZMPLwDNj69iXdwi4QNqkZTvLdTzXc=;
  b=Q8QjmQqvHKsEHLWjm47CMlmM7J0NktL2f+NuqI9SAsP6QHqjUSuwjfF5
   v0pk3T2zEyEd8j2O29OlPWp9AZ7Ij/ebJd7YJ+7feICEWcNPLjBg4xWZq
   xBTUNTif5B7iUjJtEZqvtoj6XeCX/nWxGFvtc6HZrtMAhYNeJCImJkVDQ
   SxN8Hbx/87Tmj5G8ig/LBls3R8SZpbPy/kTTIRvRTXBQmFeQbDGaH74Ro
   /tCaeVG+o+C/oIu1NuQe98LcE7lxNAjXz3Ku/Wo4YlGzaJDyH6Vqtzkcu
   JFVQsv2uEHJFdyw4w35SvqA2yRk51pIQ8B5+48FwCGBl6wAqnFjQ86HTa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310905631"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="310905631"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 03:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="752288601"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="752288601"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jan 2023 03:32:27 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLjRa-0000bx-2S;
        Sat, 28 Jan 2023 11:32:26 +0000
Date:   Sat, 28 Jan 2023 19:32:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <202301281915.t1bQicuY-lkp@intel.com>
References: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126180458.5145-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

I love your patch! Yet something to improve:

[auto build test ERROR on 172738bbccdb4ef76bdd72fc72a315c741c39161]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Cameron/cxl-pci-Set-the-device-timestamp/20230128-152300
base:   172738bbccdb4ef76bdd72fc72a315c741c39161
patch link:    https://lore.kernel.org/r/20230126180458.5145-1-Jonathan.Cameron%40huawei.com
patch subject: [PATCH] cxl/pci: Set the device timestamp
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20230128/202301281915.t1bQicuY-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f36cca050cf662048001b7b7686040270e4a8c00
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-pci-Set-the-device-timestamp/20230128-152300
        git checkout f36cca050cf662048001b7b7686040270e4a8c00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/cxl/pci.c:5:
>> include/linux/timekeeping.h:67:8: error: unknown type name 'ktime_t'
      67 | extern ktime_t ktime_get(void);
         |        ^~~~~~~
   include/linux/timekeeping.h:68:8: error: unknown type name 'ktime_t'
      68 | extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
         |        ^~~~~~~
   include/linux/timekeeping.h:69:8: error: unknown type name 'ktime_t'
      69 | extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
         |        ^~~~~~~
   include/linux/timekeeping.h:70:8: error: unknown type name 'ktime_t'
      70 | extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
         |        ^~~~~~~
   include/linux/timekeeping.h:70:34: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
      70 | extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
         |                                  ^~~~~~~
         |                                  timer_t
   include/linux/timekeeping.h:71:8: error: unknown type name 'ktime_t'
      71 | extern ktime_t ktime_get_raw(void);
         |        ^~~~~~~
   include/linux/timekeeping.h:77:15: error: unknown type name 'ktime_t'
      77 | static inline ktime_t ktime_get_real(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:82:15: error: unknown type name 'ktime_t'
      82 | static inline ktime_t ktime_get_coarse_real(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:93:15: error: unknown type name 'ktime_t'
      93 | static inline ktime_t ktime_get_boottime(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:98:15: error: unknown type name 'ktime_t'
      98 | static inline ktime_t ktime_get_coarse_boottime(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:106:15: error: unknown type name 'ktime_t'
     106 | static inline ktime_t ktime_get_clocktai(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:111:15: error: unknown type name 'ktime_t'
     111 | static inline ktime_t ktime_get_coarse_clocktai(void)
         |               ^~~~~~~
   include/linux/timekeeping.h:116:15: error: unknown type name 'ktime_t'
     116 | static inline ktime_t ktime_get_coarse(void)
         |               ^~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_coarse':
>> include/linux/timekeeping.h:121:16: error: implicit declaration of function 'timespec64_to_ktime'; did you mean 'timespec64_to_ns'? [-Werror=implicit-function-declaration]
     121 |         return timespec64_to_ktime(ts);
         |                ^~~~~~~~~~~~~~~~~~~
         |                timespec64_to_ns
   include/linux/timekeeping.h: In function 'ktime_get_coarse_ns':
>> include/linux/timekeeping.h:126:16: error: implicit declaration of function 'ktime_to_ns' [-Werror=implicit-function-declaration]
     126 |         return ktime_to_ns(ktime_get_coarse());
         |                ^~~~~~~~~~~
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:147:15: error: unknown type name 'ktime_t'
     147 | static inline ktime_t ktime_mono_to_real(ktime_t mono)
         |               ^~~~~~~
   include/linux/timekeeping.h:147:42: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
     147 | static inline ktime_t ktime_mono_to_real(ktime_t mono)
         |                                          ^~~~~~~
         |                                          timer_t
   include/linux/timekeeping.h: In function 'ktime_get_boottime_ts64':
>> include/linux/timekeeping.h:190:15: error: implicit declaration of function 'ktime_to_timespec64'; did you mean 'ns_to_timespec64'? [-Werror=implicit-function-declaration]
     190 |         *ts = ktime_to_timespec64(ktime_get_boottime());
         |               ^~~~~~~~~~~~~~~~~~~
         |               ns_to_timespec64
>> include/linux/timekeeping.h:190:15: error: incompatible types when assigning to type 'struct timespec64' from type 'int'
   include/linux/timekeeping.h: In function 'ktime_get_coarse_boottime_ts64':
   include/linux/timekeeping.h:195:15: error: incompatible types when assigning to type 'struct timespec64' from type 'int'
     195 |         *ts = ktime_to_timespec64(ktime_get_coarse_boottime());
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_boottime_seconds':
>> include/linux/timekeeping.h:200:16: error: implicit declaration of function 'ktime_divns'; did you mean 'ktime_get_ns'? [-Werror=implicit-function-declaration]
     200 |         return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
         |                ^~~~~~~~~~~
         |                ktime_get_ns
   include/linux/timekeeping.h: In function 'ktime_get_clocktai_ts64':
   include/linux/timekeeping.h:205:15: error: incompatible types when assigning to type 'struct timespec64' from type 'int'
     205 |         *ts = ktime_to_timespec64(ktime_get_clocktai());
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_coarse_clocktai_ts64':
   include/linux/timekeeping.h:210:15: error: incompatible types when assigning to type 'struct timespec64' from type 'int'
     210 |         *ts = ktime_to_timespec64(ktime_get_coarse_clocktai());
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:249:9: error: unknown type name 'ktime_t'
     249 |         ktime_t                 real;
         |         ^~~~~~~
   include/linux/timekeeping.h:250:9: error: unknown type name 'ktime_t'
     250 |         ktime_t                 raw;
         |         ^~~~~~~
   include/linux/timekeeping.h:264:9: error: unknown type name 'ktime_t'
     264 |         ktime_t device;
         |         ^~~~~~~
   include/linux/timekeeping.h:265:9: error: unknown type name 'ktime_t'
     265 |         ktime_t sys_realtime;
         |         ^~~~~~~
   include/linux/timekeeping.h:266:9: error: unknown type name 'ktime_t'
     266 |         ktime_t sys_monoraw;
         |         ^~~~~~~
   include/linux/timekeeping.h:285:44: error: unknown type name 'ktime_t'; did you mean 'timer_t'?
     285 |                         int (*get_time_fn)(ktime_t *device_time,
         |                                            ^~~~~~~
         |                                            timer_t
>> include/linux/timekeeping.h:288:25: error: expected ';', ',' or ')' before 'void'
     288 |                         void *ctx,
         |                         ^~~~
   In file included from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/mm_types.h:19,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/cxl/pci.c:6:
>> include/linux/ktime.h:71:23: error: conflicting types for 'timespec64_to_ktime'; have 'ktime_t(struct timespec64)' {aka 'long long int(struct timespec64)'}
      71 | static inline ktime_t timespec64_to_ktime(struct timespec64 ts)
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h:121:16: note: previous implicit declaration of 'timespec64_to_ktime' with type 'int()'
     121 |         return timespec64_to_ktime(ts);
         |                ^~~~~~~~~~~~~~~~~~~
>> include/linux/ktime.h:80:19: error: conflicting types for 'ktime_to_ns'; have 's64(const ktime_t)' {aka 'long long int(const long long int)'}
      80 | static inline s64 ktime_to_ns(const ktime_t kt)
         |                   ^~~~~~~~~~~
   include/linux/timekeeping.h:126:16: note: previous implicit declaration of 'ktime_to_ns' with type 'int()'
     126 |         return ktime_to_ns(ktime_get_coarse());
         |                ^~~~~~~~~~~
>> include/linux/ktime.h:148:19: error: conflicting types for 'ktime_divns'; have 's64(const ktime_t,  s64)' {aka 'long long int(const long long int,  long long int)'}
     148 | static inline s64 ktime_divns(const ktime_t kt, s64 div)
         |                   ^~~~~~~~~~~
   include/linux/timekeeping.h:200:16: note: previous implicit declaration of 'ktime_divns' with type 'int()'
     200 |         return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
         |                ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ktime_t +67 include/linux/timekeeping.h

0077dc60f274b9 Thomas Gleixner    2014-07-16   66  
8b094cd03b4a37 Thomas Gleixner    2014-07-16  @67  extern ktime_t ktime_get(void);
0077dc60f274b9 Thomas Gleixner    2014-07-16   68  extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
b9ff604cff1135 Arnd Bergmann      2018-04-27   69  extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
9a6b51976ea3a3 Thomas Gleixner    2014-07-16   70  extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
f519b1a2e08c91 Thomas Gleixner    2014-07-16   71  extern ktime_t ktime_get_raw(void);
6374f9124efea5 Harald Geyer       2015-04-07   72  extern u32 ktime_get_resolution_ns(void);
8b094cd03b4a37 Thomas Gleixner    2014-07-16   73  
f5264d5d5a0729 Thomas Gleixner    2014-07-16   74  /**
f5264d5d5a0729 Thomas Gleixner    2014-07-16   75   * ktime_get_real - get the real (wall-) time in ktime_t format
f5264d5d5a0729 Thomas Gleixner    2014-07-16   76   */
f5264d5d5a0729 Thomas Gleixner    2014-07-16   77  static inline ktime_t ktime_get_real(void)
f5264d5d5a0729 Thomas Gleixner    2014-07-16   78  {
f5264d5d5a0729 Thomas Gleixner    2014-07-16   79  	return ktime_get_with_offset(TK_OFFS_REAL);
f5264d5d5a0729 Thomas Gleixner    2014-07-16   80  }
f5264d5d5a0729 Thomas Gleixner    2014-07-16   81  
b9ff604cff1135 Arnd Bergmann      2018-04-27   82  static inline ktime_t ktime_get_coarse_real(void)
b9ff604cff1135 Arnd Bergmann      2018-04-27   83  {
b9ff604cff1135 Arnd Bergmann      2018-04-27   84  	return ktime_get_coarse_with_offset(TK_OFFS_REAL);
b9ff604cff1135 Arnd Bergmann      2018-04-27   85  }
b9ff604cff1135 Arnd Bergmann      2018-04-27   86  
a3ed0e4393d688 Thomas Gleixner    2018-04-25   87  /**
a3ed0e4393d688 Thomas Gleixner    2018-04-25   88   * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
a3ed0e4393d688 Thomas Gleixner    2018-04-25   89   *
a3ed0e4393d688 Thomas Gleixner    2018-04-25   90   * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
a3ed0e4393d688 Thomas Gleixner    2018-04-25   91   * time spent in suspend.
a3ed0e4393d688 Thomas Gleixner    2018-04-25   92   */
a3ed0e4393d688 Thomas Gleixner    2018-04-25   93  static inline ktime_t ktime_get_boottime(void)
a3ed0e4393d688 Thomas Gleixner    2018-04-25   94  {
a3ed0e4393d688 Thomas Gleixner    2018-04-25   95  	return ktime_get_with_offset(TK_OFFS_BOOT);
a3ed0e4393d688 Thomas Gleixner    2018-04-25   96  }
a3ed0e4393d688 Thomas Gleixner    2018-04-25   97  
b9ff604cff1135 Arnd Bergmann      2018-04-27   98  static inline ktime_t ktime_get_coarse_boottime(void)
b9ff604cff1135 Arnd Bergmann      2018-04-27   99  {
b9ff604cff1135 Arnd Bergmann      2018-04-27  100  	return ktime_get_coarse_with_offset(TK_OFFS_BOOT);
b9ff604cff1135 Arnd Bergmann      2018-04-27  101  }
b9ff604cff1135 Arnd Bergmann      2018-04-27  102  
afab07c0e91ecf Thomas Gleixner    2014-07-16  103  /**
afab07c0e91ecf Thomas Gleixner    2014-07-16  104   * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
afab07c0e91ecf Thomas Gleixner    2014-07-16  105   */
afab07c0e91ecf Thomas Gleixner    2014-07-16  106  static inline ktime_t ktime_get_clocktai(void)
afab07c0e91ecf Thomas Gleixner    2014-07-16  107  {
afab07c0e91ecf Thomas Gleixner    2014-07-16  108  	return ktime_get_with_offset(TK_OFFS_TAI);
afab07c0e91ecf Thomas Gleixner    2014-07-16  109  }
afab07c0e91ecf Thomas Gleixner    2014-07-16  110  
b9ff604cff1135 Arnd Bergmann      2018-04-27  111  static inline ktime_t ktime_get_coarse_clocktai(void)
b9ff604cff1135 Arnd Bergmann      2018-04-27  112  {
b9ff604cff1135 Arnd Bergmann      2018-04-27  113  	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
b9ff604cff1135 Arnd Bergmann      2018-04-27  114  }
b9ff604cff1135 Arnd Bergmann      2018-04-27  115  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  116  static inline ktime_t ktime_get_coarse(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  117  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  118  	struct timespec64 ts;
4c54294d01e605 Jason A. Donenfeld 2019-06-21  119  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  120  	ktime_get_coarse_ts64(&ts);
4c54294d01e605 Jason A. Donenfeld 2019-06-21 @121  	return timespec64_to_ktime(ts);
4c54294d01e605 Jason A. Donenfeld 2019-06-21  122  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  123  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  124  static inline u64 ktime_get_coarse_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  125  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21 @126  	return ktime_to_ns(ktime_get_coarse());
4c54294d01e605 Jason A. Donenfeld 2019-06-21  127  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  128  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  129  static inline u64 ktime_get_coarse_real_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  130  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  131  	return ktime_to_ns(ktime_get_coarse_real());
4c54294d01e605 Jason A. Donenfeld 2019-06-21  132  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  133  
d48e0cd8fcaf31 Jason A. Donenfeld 2019-06-24  134  static inline u64 ktime_get_coarse_boottime_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  135  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  136  	return ktime_to_ns(ktime_get_coarse_boottime());
4c54294d01e605 Jason A. Donenfeld 2019-06-21  137  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  138  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  139  static inline u64 ktime_get_coarse_clocktai_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  140  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  141  	return ktime_to_ns(ktime_get_coarse_clocktai());
4c54294d01e605 Jason A. Donenfeld 2019-06-21  142  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  143  
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  144  /**
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  145   * ktime_mono_to_real - Convert monotonic time to clock realtime
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  146   */
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  147  static inline ktime_t ktime_mono_to_real(ktime_t mono)
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  148  {
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  149  	return ktime_mono_to_any(mono, TK_OFFS_REAL);
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  150  }
9a6b51976ea3a3 Thomas Gleixner    2014-07-16  151  
897994e32b2b0a Thomas Gleixner    2014-07-16  152  static inline u64 ktime_get_ns(void)
897994e32b2b0a Thomas Gleixner    2014-07-16  153  {
897994e32b2b0a Thomas Gleixner    2014-07-16  154  	return ktime_to_ns(ktime_get());
897994e32b2b0a Thomas Gleixner    2014-07-16  155  }
897994e32b2b0a Thomas Gleixner    2014-07-16  156  
897994e32b2b0a Thomas Gleixner    2014-07-16  157  static inline u64 ktime_get_real_ns(void)
897994e32b2b0a Thomas Gleixner    2014-07-16  158  {
897994e32b2b0a Thomas Gleixner    2014-07-16  159  	return ktime_to_ns(ktime_get_real());
897994e32b2b0a Thomas Gleixner    2014-07-16  160  }
897994e32b2b0a Thomas Gleixner    2014-07-16  161  
9285ec4c8b61d4 Jason A. Donenfeld 2019-06-21  162  static inline u64 ktime_get_boottime_ns(void)
a3ed0e4393d688 Thomas Gleixner    2018-04-25  163  {
a3ed0e4393d688 Thomas Gleixner    2018-04-25  164  	return ktime_to_ns(ktime_get_boottime());
a3ed0e4393d688 Thomas Gleixner    2018-04-25  165  }
a3ed0e4393d688 Thomas Gleixner    2018-04-25  166  
9285ec4c8b61d4 Jason A. Donenfeld 2019-06-21  167  static inline u64 ktime_get_clocktai_ns(void)
fe5fba05b46c79 Peter Zijlstra     2015-03-17  168  {
fe5fba05b46c79 Peter Zijlstra     2015-03-17  169  	return ktime_to_ns(ktime_get_clocktai());
fe5fba05b46c79 Peter Zijlstra     2015-03-17  170  }
fe5fba05b46c79 Peter Zijlstra     2015-03-17  171  
f519b1a2e08c91 Thomas Gleixner    2014-07-16  172  static inline u64 ktime_get_raw_ns(void)
f519b1a2e08c91 Thomas Gleixner    2014-07-16  173  {
f519b1a2e08c91 Thomas Gleixner    2014-07-16  174  	return ktime_to_ns(ktime_get_raw());
f519b1a2e08c91 Thomas Gleixner    2014-07-16  175  }
f519b1a2e08c91 Thomas Gleixner    2014-07-16  176  
4396e058c52e16 Thomas Gleixner    2014-07-16  177  extern u64 ktime_get_mono_fast_ns(void);
f09cb9a1808e35 Peter Zijlstra     2015-03-19  178  extern u64 ktime_get_raw_fast_ns(void);
a3ed0e4393d688 Thomas Gleixner    2018-04-25  179  extern u64 ktime_get_boot_fast_ns(void);
3dc6ffae2da201 Kurt Kanzenbach    2022-04-14  180  extern u64 ktime_get_tai_fast_ns(void);
4c3711d7fb4763 Thomas Gleixner    2017-08-31  181  extern u64 ktime_get_real_fast_ns(void);
4396e058c52e16 Thomas Gleixner    2014-07-16  182  
d6c7270e913db7 Thomas Gleixner    2018-03-01  183  /*
06aa376903b6e8 Arnd Bergmann      2018-04-27  184   * timespec64/time64_t interfaces utilizing the ktime based ones
06aa376903b6e8 Arnd Bergmann      2018-04-27  185   * for API completeness, these could be implemented more efficiently
06aa376903b6e8 Arnd Bergmann      2018-04-27  186   * if needed.
d6c7270e913db7 Thomas Gleixner    2018-03-01  187   */
fb7fcc96a86cfa Arnd Bergmann      2018-04-27  188  static inline void ktime_get_boottime_ts64(struct timespec64 *ts)
a3ed0e4393d688 Thomas Gleixner    2018-04-25  189  {
a3ed0e4393d688 Thomas Gleixner    2018-04-25 @190  	*ts = ktime_to_timespec64(ktime_get_boottime());
a3ed0e4393d688 Thomas Gleixner    2018-04-25  191  }
a3ed0e4393d688 Thomas Gleixner    2018-04-25  192  
06aa376903b6e8 Arnd Bergmann      2018-04-27  193  static inline void ktime_get_coarse_boottime_ts64(struct timespec64 *ts)
06aa376903b6e8 Arnd Bergmann      2018-04-27  194  {
06aa376903b6e8 Arnd Bergmann      2018-04-27  195  	*ts = ktime_to_timespec64(ktime_get_coarse_boottime());
06aa376903b6e8 Arnd Bergmann      2018-04-27  196  }
06aa376903b6e8 Arnd Bergmann      2018-04-27  197  
06aa376903b6e8 Arnd Bergmann      2018-04-27  198  static inline time64_t ktime_get_boottime_seconds(void)
06aa376903b6e8 Arnd Bergmann      2018-04-27  199  {
06aa376903b6e8 Arnd Bergmann      2018-04-27 @200  	return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
06aa376903b6e8 Arnd Bergmann      2018-04-27  201  }
06aa376903b6e8 Arnd Bergmann      2018-04-27  202  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
