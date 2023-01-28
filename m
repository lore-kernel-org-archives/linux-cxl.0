Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73ADC27C76
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 11:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjA1LWf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 28 Jan 2023 06:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1LWe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 28 Jan 2023 06:22:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6A126EC
        for <linux-cxl@vger.kernel.org>; Sat, 28 Jan 2023 03:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674904951; x=1706440951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=18dFkmDjFhSbNLYKQ4ggLCbHGjndOxx/EwPwggTLhy8=;
  b=G/MgI7cAqhpH8dyGnknh+s+/pwTyhZ4DR2vVJ+hC8Krvzq+fchI7dHT4
   feJVtYW6CWbuImqxBhSGTrPhNn9nOMkUJ0jMpwAD8djvZzbhxYl4qDt+G
   zWg4ZyGNO9ZG/zak6vQSLRpK6bLaaAB9boc6PEEHrAQ9bOmHnBOjdAU46
   YnkkxcHDbUQgAhqN6CjvF29TthhudszUWxyHCHUCn5DWSrMQ6kco/Yyqe
   EUjzzKo+7sKu9z4yaLxVRsfjFs8PbEoxFNLlgF+ZNNxmzI1zDte0xK+Nk
   a8zolTUUFdGllFe5h3VXwrcv8ePPM3gXo/Z8z3d4Z8bbstegwfhvscObq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="327300122"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="327300122"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 03:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656912542"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="656912542"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2023 03:22:27 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLjHu-0000bV-1R;
        Sat, 28 Jan 2023 11:22:26 +0000
Date:   Sat, 28 Jan 2023 19:21:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com
Subject: Re: [PATCH] cxl/pci: Set the device timestamp
Message-ID: <202301281954.CS360mGh-lkp@intel.com>
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
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20230128/202301281954.CS360mGh-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f36cca050cf662048001b7b7686040270e4a8c00
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonathan-Cameron/cxl-pci-Set-the-device-timestamp/20230128-152300
        git checkout f36cca050cf662048001b7b7686040270e4a8c00
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cxl/pci.c:5:
>> include/linux/timekeeping.h:19:43: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
      19 | extern int do_settimeofday64(const struct timespec64 *ts);
         |                                           ^~~~~~~~~~
>> include/linux/timekeeping.h:21:47: warning: 'struct timezone' declared inside parameter list will not be visible outside of this definition or declaration
      21 |                                  const struct timezone *tz);
         |                                               ^~~~~~~~
   include/linux/timekeeping.h:20:47: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
      20 | extern int do_sys_settimeofday64(const struct timespec64 *tv,
         |                                               ^~~~~~~~~~
   include/linux/timekeeping.h:41:39: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
      41 | extern void ktime_get_raw_ts64(struct timespec64 *ts);
         |                                       ^~~~~~~~~~
   include/linux/timekeeping.h:42:35: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
      42 | extern void ktime_get_ts64(struct timespec64 *ts);
         |                                   ^~~~~~~~~~
   include/linux/timekeeping.h:43:40: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
      43 | extern void ktime_get_real_ts64(struct timespec64 *tv);
         |                                        ^~~~~~~~~~
   include/linux/timekeeping.h:44:42: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
      44 | extern void ktime_get_coarse_ts64(struct timespec64 *ts);
         |                                          ^~~~~~~~~~
   include/linux/timekeeping.h:45:47: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
      45 | extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
         |                                               ^~~~~~~~~~
   include/linux/timekeeping.h:47:27: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
      47 | void getboottime64(struct timespec64 *ts);
         |                           ^~~~~~~~~~
>> include/linux/timekeeping.h:52:8: error: unknown type name 'time64_t'
      52 | extern time64_t ktime_get_seconds(void);
         |        ^~~~~~~~
   include/linux/timekeeping.h:53:8: error: unknown type name 'time64_t'
      53 | extern time64_t __ktime_get_real_seconds(void);
         |        ^~~~~~~~
   include/linux/timekeeping.h:54:8: error: unknown type name 'time64_t'
      54 | extern time64_t ktime_get_real_seconds(void);
         |        ^~~~~~~~
   include/linux/timekeeping.h:67:8: error: unknown type name 'ktime_t'
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
>> include/linux/timekeeping.h:118:27: error: storage size of 'ts' isn't known
     118 |         struct timespec64 ts;
         |                           ^~
   include/linux/timekeeping.h:121:16: error: implicit declaration of function 'timespec64_to_ktime' [-Werror=implicit-function-declaration]
     121 |         return timespec64_to_ktime(ts);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h:118:27: warning: unused variable 'ts' [-Wunused-variable]
     118 |         struct timespec64 ts;
         |                           ^~
   include/linux/timekeeping.h: In function 'ktime_get_coarse_ns':
   include/linux/timekeeping.h:126:16: error: implicit declaration of function 'ktime_to_ns' [-Werror=implicit-function-declaration]
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
   include/linux/timekeeping.h:188:51: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
     188 | static inline void ktime_get_boottime_ts64(struct timespec64 *ts)
         |                                                   ^~~~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_boottime_ts64':
   include/linux/timekeeping.h:190:15: error: implicit declaration of function 'ktime_to_timespec64' [-Werror=implicit-function-declaration]
     190 |         *ts = ktime_to_timespec64(ktime_get_boottime());
         |               ^~~~~~~~~~~~~~~~~~~
>> include/linux/timekeeping.h:190:13: error: invalid use of undefined type 'struct timespec64'
     190 |         *ts = ktime_to_timespec64(ktime_get_boottime());
         |             ^
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:193:58: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
     193 | static inline void ktime_get_coarse_boottime_ts64(struct timespec64 *ts)
         |                                                          ^~~~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_coarse_boottime_ts64':
   include/linux/timekeeping.h:195:13: error: invalid use of undefined type 'struct timespec64'
     195 |         *ts = ktime_to_timespec64(ktime_get_coarse_boottime());
         |             ^
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:198:15: error: unknown type name 'time64_t'
     198 | static inline time64_t ktime_get_boottime_seconds(void)
         |               ^~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_boottime_seconds':
   include/linux/timekeeping.h:200:16: error: implicit declaration of function 'ktime_divns'; did you mean 'ktime_get_ns'? [-Werror=implicit-function-declaration]
     200 |         return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
         |                ^~~~~~~~~~~
         |                ktime_get_ns
>> include/linux/timekeeping.h:200:57: error: 'NSEC_PER_SEC' undeclared (first use in this function); did you mean 'CLOCKS_PER_SEC'?
     200 |         return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
         |                                                         ^~~~~~~~~~~~
         |                                                         CLOCKS_PER_SEC
   include/linux/timekeeping.h:200:57: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:203:51: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
     203 | static inline void ktime_get_clocktai_ts64(struct timespec64 *ts)
         |                                                   ^~~~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_clocktai_ts64':
   include/linux/timekeeping.h:205:13: error: invalid use of undefined type 'struct timespec64'
     205 |         *ts = ktime_to_timespec64(ktime_get_clocktai());
         |             ^
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:208:58: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
     208 | static inline void ktime_get_coarse_clocktai_ts64(struct timespec64 *ts)
         |                                                          ^~~~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_coarse_clocktai_ts64':
   include/linux/timekeeping.h:210:13: error: invalid use of undefined type 'struct timespec64'
     210 |         *ts = ktime_to_timespec64(ktime_get_coarse_clocktai());
         |             ^
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:213:15: error: unknown type name 'time64_t'
     213 | static inline time64_t ktime_get_clocktai_seconds(void)
         |               ^~~~~~~~
   include/linux/timekeeping.h: In function 'ktime_get_clocktai_seconds':
   include/linux/timekeeping.h:215:57: error: 'NSEC_PER_SEC' undeclared (first use in this function); did you mean 'CLOCKS_PER_SEC'?
     215 |         return ktime_divns(ktime_get_coarse_clocktai(), NSEC_PER_SEC);
         |                                                         ^~~~~~~~~~~~
         |                                                         CLOCKS_PER_SEC
   include/linux/timekeeping.h: At top level:
   include/linux/timekeeping.h:224:57: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
     224 | extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
         |                                                         ^~~~~~~~~~
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
   include/linux/timekeeping.h:288:25: error: expected ';', ',' or ')' before 'void'
     288 |                         void *ctx,
         |                         ^~~~
   include/linux/timekeeping.h:305:44: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
     305 | extern void read_persistent_clock64(struct timespec64 *ts);
         |                                            ^~~~~~~~~~
   include/linux/timekeeping.h:306:50: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
     306 | void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
         |                                                  ^~~~~~~~~~
   include/linux/timekeeping.h:309:45: warning: 'struct timespec64' declared inside parameter list will not be visible outside of this definition or declaration
     309 | extern int update_persistent_clock64(struct timespec64 now);
         |                                             ^~~~~~~~~~
   In file included from include/linux/timer.h:6,
                    from include/linux/workqueue.h:9,
                    from include/linux/srcu.h:21,
                    from include/linux/notifier.h:16,
                    from arch/mips/include/asm/uprobes.h:9,
                    from include/linux/uprobes.h:49,
                    from include/linux/mm_types.h:16,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/cxl/pci.c:6:
   include/linux/ktime.h:71:23: error: conflicting types for 'timespec64_to_ktime'; have 'ktime_t(struct timespec64)' {aka 'long long int(struct timespec64)'}
      71 | static inline ktime_t timespec64_to_ktime(struct timespec64 ts)
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/timekeeping.h:121:16: note: previous implicit declaration of 'timespec64_to_ktime' with type 'int()'
     121 |         return timespec64_to_ktime(ts);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/ktime.h:80:19: error: conflicting types for 'ktime_to_ns'; have 's64(const ktime_t)' {aka 'long long int(const long long int)'}
      80 | static inline s64 ktime_to_ns(const ktime_t kt)
         |                   ^~~~~~~~~~~
   include/linux/timekeeping.h:126:16: note: previous implicit declaration of 'ktime_to_ns' with type 'int()'
     126 |         return ktime_to_ns(ktime_get_coarse());
         |                ^~~~~~~~~~~
   include/linux/ktime.h:130:19: error: conflicting types for 'ktime_divns'; have 's64(const ktime_t,  s64)' {aka 'long long int(const long long int,  long long int)'}
     130 | static inline s64 ktime_divns(const ktime_t kt, s64 div)
         |                   ^~~~~~~~~~~
   include/linux/timekeeping.h:200:16: note: previous implicit declaration of 'ktime_divns' with type 'int()'
     200 |         return ktime_divns(ktime_get_coarse_boottime(), NSEC_PER_SEC);
         |                ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/time64_t +52 include/linux/timekeeping.h

93b5a9a7051e51 Ingo Molnar        2017-02-05   15  
8b094cd03b4a37 Thomas Gleixner    2014-07-16   16  /*
8b094cd03b4a37 Thomas Gleixner    2014-07-16   17   * Get and set timeofday
8b094cd03b4a37 Thomas Gleixner    2014-07-16   18   */
21f7eca555ad14 pang.xunlei        2014-11-18  @19  extern int do_settimeofday64(const struct timespec64 *ts);
86d3473224b004 Baolin Wang        2016-04-08   20  extern int do_sys_settimeofday64(const struct timespec64 *tv,
8b094cd03b4a37 Thomas Gleixner    2014-07-16  @21  				 const struct timezone *tz);
8758a240e2d74c Baolin Wang        2015-07-29   22  
0e3fd810c4f41d Arnd Bergmann      2018-07-10   23  /*
0e3fd810c4f41d Arnd Bergmann      2018-07-10   24   * ktime_get() family: read the current time in a multitude of ways,
0e3fd810c4f41d Arnd Bergmann      2018-07-10   25   *
0e3fd810c4f41d Arnd Bergmann      2018-07-10   26   * The default time reference is CLOCK_MONOTONIC, starting at
0e3fd810c4f41d Arnd Bergmann      2018-07-10   27   * boot time but not counting the time spent in suspend.
0e3fd810c4f41d Arnd Bergmann      2018-07-10   28   * For other references, use the functions with "real", "clocktai",
0e3fd810c4f41d Arnd Bergmann      2018-07-10   29   * "boottime" and "raw" suffixes.
0e3fd810c4f41d Arnd Bergmann      2018-07-10   30   *
0e3fd810c4f41d Arnd Bergmann      2018-07-10   31   * To get the time in a different format, use the ones wit
0e3fd810c4f41d Arnd Bergmann      2018-07-10   32   * "ns", "ts64" and "seconds" suffix.
0e3fd810c4f41d Arnd Bergmann      2018-07-10   33   *
0e3fd810c4f41d Arnd Bergmann      2018-07-10   34   * See Documentation/core-api/timekeeping.rst for more details.
0e3fd810c4f41d Arnd Bergmann      2018-07-10   35   */
0e3fd810c4f41d Arnd Bergmann      2018-07-10   36  
0e3fd810c4f41d Arnd Bergmann      2018-07-10   37  
8b094cd03b4a37 Thomas Gleixner    2014-07-16   38  /*
6546911ed369af Arnd Bergmann      2017-10-19   39   * timespec64 based interfaces
8b094cd03b4a37 Thomas Gleixner    2014-07-16   40   */
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   41  extern void ktime_get_raw_ts64(struct timespec64 *ts);
d6d29896c665df Thomas Gleixner    2014-07-16   42  extern void ktime_get_ts64(struct timespec64 *ts);
edca71fecb77e2 Arnd Bergmann      2018-04-27   43  extern void ktime_get_real_ts64(struct timespec64 *tv);
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   44  extern void ktime_get_coarse_ts64(struct timespec64 *ts);
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   45  extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   46  
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   47  void getboottime64(struct timespec64 *ts);
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   48  
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   49  /*
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   50   * time64_t base interfaces
fb7fcc96a86cfa Arnd Bergmann      2018-04-27   51   */
9e3680b1750b9a Heena Sirwani      2014-10-29  @52  extern time64_t ktime_get_seconds(void);
6909e29fdefbb7 Arnd Bergmann      2017-10-12   53  extern time64_t __ktime_get_real_seconds(void);
dbe7aa622db96b Heena Sirwani      2014-10-29   54  extern time64_t ktime_get_real_seconds(void);
d6d29896c665df Thomas Gleixner    2014-07-16   55  
8b094cd03b4a37 Thomas Gleixner    2014-07-16   56  /*
8b094cd03b4a37 Thomas Gleixner    2014-07-16   57   * ktime_t based interfaces
8b094cd03b4a37 Thomas Gleixner    2014-07-16   58   */
a3ed0e4393d688 Thomas Gleixner    2018-04-25   59  
0077dc60f274b9 Thomas Gleixner    2014-07-16   60  enum tk_offsets {
0077dc60f274b9 Thomas Gleixner    2014-07-16   61  	TK_OFFS_REAL,
a3ed0e4393d688 Thomas Gleixner    2018-04-25   62  	TK_OFFS_BOOT,
0077dc60f274b9 Thomas Gleixner    2014-07-16   63  	TK_OFFS_TAI,
0077dc60f274b9 Thomas Gleixner    2014-07-16   64  	TK_OFFS_MAX,
0077dc60f274b9 Thomas Gleixner    2014-07-16   65  };
0077dc60f274b9 Thomas Gleixner    2014-07-16   66  
8b094cd03b4a37 Thomas Gleixner    2014-07-16   67  extern ktime_t ktime_get(void);
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
4c54294d01e605 Jason A. Donenfeld 2019-06-21 @118  	struct timespec64 ts;
4c54294d01e605 Jason A. Donenfeld 2019-06-21  119  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  120  	ktime_get_coarse_ts64(&ts);
4c54294d01e605 Jason A. Donenfeld 2019-06-21  121  	return timespec64_to_ktime(ts);
4c54294d01e605 Jason A. Donenfeld 2019-06-21  122  }
4c54294d01e605 Jason A. Donenfeld 2019-06-21  123  
4c54294d01e605 Jason A. Donenfeld 2019-06-21  124  static inline u64 ktime_get_coarse_ns(void)
4c54294d01e605 Jason A. Donenfeld 2019-06-21  125  {
4c54294d01e605 Jason A. Donenfeld 2019-06-21  126  	return ktime_to_ns(ktime_get_coarse());
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
