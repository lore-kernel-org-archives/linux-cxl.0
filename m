Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57150C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 17:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2759461163
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 17:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhINRCh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhINRCg (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 14 Sep 2021 13:02:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAA44610E6;
        Tue, 14 Sep 2021 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631638879;
        bh=YaevgdA3tVWWqnK3qgrVO5mk33AE2bodpz5BWxEyBmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwWUY0+ycvXN5JE7MclYpLdYiVyU4Us3oCwRmKhdQJleDF++Rgn+dMx/Zt3dlbr0v
         Z8BtyDYbPh7/siqDh8MmQmxzjjeMk5Z+8OP+sDlWgMGFkvQvlD4TkMckO2lT3mbi2R
         G/Yrwpw8P6DO/4MmRnRBAodlCJgprmEZa0TSw5GgXTG0Vayw39BOwna4XTOfCvjCmM
         rlx6o2URwvgOX/+S4cdqWpVSjSfTPmHuorKzKUiFSQDgjWmuQEmQQTBg1nJbdwp+Zq
         kk+QcAxgy8NFhH4N/br3ky+lSmprKvCTKTElPsRzHG3D03my1OwPc2OOqXtLiFj6h0
         JQ7NvK+Qu1uKg==
Date:   Tue, 14 Sep 2021 13:01:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.14 04/25] cxl/pci: Introduce
 cdevm_file_operations
Message-ID: <YUDVXV8egoZP05SF@sashalap>
References: <20210913223339.435347-1-sashal@kernel.org>
 <20210913223339.435347-4-sashal@kernel.org>
 <CAPcyv4i5OHv2wHTO1Pdjz+qzAAWEha-7HdDdt42VyO_FasLSEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPcyv4i5OHv2wHTO1Pdjz+qzAAWEha-7HdDdt42VyO_FasLSEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 14, 2021 at 08:42:04AM -0700, Dan Williams wrote:
>On Mon, Sep 13, 2021 at 3:33 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> [ Upstream commit 9cc238c7a526dba9ee8c210fa2828886fc65db66 ]
>>
>> In preparation for moving cxl_memdev allocation to the core, introduce
>> cdevm_file_operations to coordinate file operations shutdown relative to
>> driver data release.
>>
>> The motivation for moving cxl_memdev allocation to the core (beyond
>> better file organization of sysfs attributes in core/ and drivers in
>> cxl/), is that device lifetime is longer than module lifetime. The cxl_pci
>> module should be free to come and go without needing to coordinate with
>> devices that need the text associated with cxl_memdev_release() to stay
>> resident. The move will fix a use after free bug when looping driver
>> load / unload with CONFIG_DEBUG_KOBJECT_RELEASE=y.
>>
>> Another motivation for passing in file_operations to the core cxl_memdev
>> creation flow is to allow for alternate drivers, like unit test code, to
>> define their own ioctl backends.
>
>Hi Sasha,
>
>Please drop this. It's not a fix, it's just a reorganization for
>easing the addition of new features and capabilities.

I'll drop it, but just to satisfy my curiousity: the description says it
fixes a use-after-free bug in the existing code, is it not the case?

-- 
Thanks,
Sasha
