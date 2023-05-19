Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC9EC77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 15:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjESPe1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjESPeZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 11:34:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B11A4
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 08:34:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f41d087a84so7070825e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684510463; x=1687102463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pb9IlaicBSZmt7qrRMrBNGyHNyEEKbiHOY+2Qsbwrp8=;
        b=OEm7ZVNFrEuKa0zKtRQstZVvGSPX5WsXc57vNzp2m2siW+Ukl2WW5esCMhd+94qKun
         IRmb9lUr4KhEAPfLJjdaeTGEGy3XoHDOvBmy719eQSsp3yQ5o2D6hRAi+httYS2RC4D7
         J/rmvmPeVgzy//wApP6CBDqwp1Jd91V8gmHWG8cAoRMlreUVBfMU0h0qfQzBKhF8VKgo
         Kb3gX/SoGMFAtmeD6GmMz5qTslyOnQ1hPl2kfwrdI63w8OrNtOLHhJdabPR691AjYjJD
         f93BqyOoWRkUAQozuOgPNEuA9g9amaQkLvusjrowMZXbZhC84O8DH454PjraaYTlLGCX
         5cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684510463; x=1687102463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pb9IlaicBSZmt7qrRMrBNGyHNyEEKbiHOY+2Qsbwrp8=;
        b=EZKEDONqT2y1ZXK+h51N061AhUROAOB+QJpoyADdQa+WV+GHHElM481aGJJKhNWZa3
         MK8vxYAMCYjp93ZNz1AR5HbuK5G4yTc9cpZIrmN0GqGVRd4flmX+YcrzDq0QDkx6XoLO
         /loo4Ws+XuMj5JfCgXhAUU9o6pdy1TbfvgP9Iolsf5kPMfRFmUqndVG+auaKsbNTtC2n
         QkF3c8AmcPJRstfFGGgVlXCNQkB42MJU0GU63JHBagQlVIiPmAaCIGDYvhlajW1tTqsJ
         WxcKyAC9fWc0gS9p+FvXpOB2LkL0hmjPqgbSBgW77QsowbWTt/wFLTrXMyCXbeqdTm7B
         S1RA==
X-Gm-Message-State: AC+VfDwJngupJkQMxGSM26tZVJBy+EVcC5I0eH6hw3pegzCMfdFADGu/
        rScZS4hR4G/gDiNDw0BdWJpf9Q==
X-Google-Smtp-Source: ACHHUZ7S6zs9OzweLMjvrmbwMW2f5GLkSI0QGJZiCAhjxUAHIGFy51/SczsTUK4bOM1a7pnTqHKHSA==
X-Received: by 2002:a05:600c:b97:b0:3f4:1848:4dff with SMTP id fl23-20020a05600c0b9700b003f418484dffmr1863436wmb.7.1684510463008;
        Fri, 19 May 2023 08:34:23 -0700 (PDT)
Received: from [192.168.69.115] (mau49-h01-176-184-41-228.dsl.sta.abo.bbox.fr. [176.184.41.228])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm2747095wmk.22.2023.05.19.08.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 08:34:22 -0700 (PDT)
Message-ID: <6dc139cc-ec19-196f-017a-cb0a415af3e5@linaro.org>
Date:   Fri, 19 May 2023 17:34:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v6 6/7] hw/cxl/events: Add injection of DRAM events
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
Cc:     linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
References: <20230519143043.30191-1-Jonathan.Cameron@huawei.com>
 <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230519143043.30191-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

On 19/5/23 16:30, Jonathan Cameron wrote:
> Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> provides information related to DRAM devices.
> 
> Example injection command in QMP:
> 
> { "execute": "cxl-inject-dram-event",
>      "arguments": {
>          "path": "/machine/peripheral/cxl-mem0",
>          "log": "informational",
>          "flags": 1,
>          "physaddr": 1000,
>          "descriptor": 3,
>          "type": 3,
>          "transaction-type": 192,
>          "channel": 3,
>          "rank": 17,
>          "nibble-mask": 37421234,
>          "bank-group": 7,
>          "bank": 11,
>          "row": 2,
>          "column": 77,
>          "correction-mask": [33, 44, 55,66]
>      }}
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/mem/cxl_type3.c          | 116 ++++++++++++++++++++++++++++++++++++
>   hw/mem/cxl_type3_stubs.c    |  13 ++++
>   include/hw/cxl/cxl_events.h |  23 +++++++
>   qapi/cxl.json               |  35 +++++++++++
>   4 files changed, 187 insertions(+)


> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 7e1e6257ce..5e82097e76 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -55,6 +55,41 @@
>               '*device': 'uint32', '*component-id': 'str'
>               }}
>   
> +##
> +# @cxl-inject-dram-event:
> +#
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
> +# This event type is reported via one of the event logs specified via
> +# the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @log: Event Log to add the event to
> +# @flags: header flags
> +# @physaddr: Physical Address

Could this be a clearer description?

"Physical Address (relative to @path device)"

> +# @descriptor: Descriptor
> +# @type: Type
> +# @transaction-type: Transaction Type
> +# @channel: Channel
> +# @rank: Rank
> +# @nibble-mask: Identify one or more nibbles that the error affects

> +# @bank-group: Bank group
> +# @bank: Bank
> +# @row: Row
> +# @column: Column

Why do we need bank/raw/col if we have physaddr?

These are optional. Shouldn't we check they are valid
in qmp_cxl_inject_dram_event()? (No clue, just wondering
if there is some duplication here).

> +# @correction-mask: Bits within each nibble. Used in order of bits set
> +#                   in the nibble-mask.  Up to 4 nibbles may be covered.
> +#
> +# Since: 8.1
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'physaddr': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transaction-type': 'uint8',
> +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +           }}
> +
>   ##
>   # @cxl-inject-poison:
>   #

