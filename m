Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA91C77B7A
	for <linux-cxl@archiver.kernel.org>; Sat, 20 May 2023 13:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjETNWJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 May 2023 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjETNWJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 20 May 2023 09:22:09 -0400
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 May 2023 06:22:06 PDT
Received: from zero.eik.bme.hu (zero.eik.bme.hu [IPv6:2001:738:2001:2001::2001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC8CC
        for <linux-cxl@vger.kernel.org>; Sat, 20 May 2023 06:22:06 -0700 (PDT)
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
        by localhost (Postfix) with SMTP id 820E5746392;
        Sat, 20 May 2023 15:15:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
        id 49B437457E7; Sat, 20 May 2023 15:15:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zero.eik.bme.hu (Postfix) with ESMTP id 47458745706;
        Sat, 20 May 2023 15:15:18 +0200 (CEST)
Date:   Sat, 20 May 2023 15:15:18 +0200 (CEST)
From:   BALATON Zoltan <balaton@eik.bme.hu>
To:     Peter Maydell <peter.maydell@linaro.org>
cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
In-Reply-To: <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
Message-ID: <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com> <20230519141803.29713-2-Jonathan.Cameron@huawei.com> <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 20 May 2023, Peter Maydell wrote:
> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
> <qemu-devel@nongnu.org> wrote:
>>
>> From: Ira Weiny <ira.weiny@intel.com>
>>
>> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
>> specified as little endian.
>>
>> Define st24_le_p() and the supporting functions to store such a field
>> from a 32 bit host native value.
>>
>> The use of b, w, l, q as the size specifier is limiting.  So "24" was
>> used for the size part of the function name.

Maybe it's clearer to use 24 but if we want to keep these somewhat 
consistent how about using t for Triplet, Three-bytes or Twenty-four?

Regards,
BALATON Zoltan

>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  docs/devel/loads-stores.rst |  1 +
>>  include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
>> index d2cefc77a2..82a79e91d9 100644
>> --- a/docs/devel/loads-stores.rst
>> +++ b/docs/devel/loads-stores.rst
>> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>>  ``size``
>>   - ``b`` : 8 bits
>>   - ``w`` : 16 bits
>> + - ``24`` : 24 bits
>>   - ``l`` : 32 bits
>>   - ``q`` : 64 bits
>
> Can you also update the "Regexes for git grep" section
> below to account for the new size value, please?
>
> thanks
> -- PMM
>
>
