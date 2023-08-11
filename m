Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA2C001B0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 01:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjHKBQF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjHKBQE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 21:16:04 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61862D47
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 18:16:00 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="107288656"
X-IronPort-AV: E=Sophos;i="6.01,163,1684767600"; 
   d="scan'208";a="107288656"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:15:58 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 923C8D50B1
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 10:15:56 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D202CCF7D7
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 10:15:55 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E7BBC200649E2;
        Fri, 11 Aug 2023 10:15:54 +0900 (JST)
Message-ID: <acb201df-0c24-15f8-a8e8-d540e7bc88ee@fujitsu.com>
Date:   Fri, 11 Aug 2023 09:15:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [NDCTL PATCH] daxctl: Remove unused mem_zone variable
To:     Fan Ni <fan.ni@gmx.us>
Cc:     vishal.l.verma@intel.com, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org
References: <20230809154636.11887-1-yangx.jy@fujitsu.com>
 <ZNUYFSTHC6kEirhm@debian>
From:   Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <ZNUYFSTHC6kEirhm@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27806.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27806.003
X-TMASE-Result: 10--2.841300-10.000000
X-TMASE-MatchedRID: 2UwwcHKl5CGPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizx/iZ1aNsYG7jm0
        6SVjjUzh4vM1YF6AJbZFi+KwZZttL8wvFGpbh1azBOQ+j4qQlXRMECZBMumdcI2j49Ftap9Esjv
        NV98mpPOxcTWnW31zc34K3GG6eAgrX20LPwwRkz+MTqeF52Ei21TUC56N6QJlu+/rqBF+glcGHm
        qEGnqhtqa8Z7flSDKrqWo38hoFmHI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 2023/8/11 1:02, Fan Ni wrote:
> The enum definition is not used also.
Hi Fan,

Good catch, I will send v2 patch to remove it.

Best Regards,
Xiao Yang
> 
> Fan
