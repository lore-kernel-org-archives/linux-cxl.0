Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E5FC77B7F
	for <linux-cxl@archiver.kernel.org>; Sat, 20 May 2023 17:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjETRId (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 20 May 2023 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjETRIb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 20 May 2023 13:08:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C63102
        for <linux-cxl@vger.kernel.org>; Sat, 20 May 2023 10:08:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so29756025e9.0
        for <linux-cxl@vger.kernel.org>; Sat, 20 May 2023 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684602505; x=1687194505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMkCQYgPnXGE90YMUOC4Ohpkx8GIoVEN+6c9iF44+QU=;
        b=fN00iQjH20qvLxc9mP2IL6ZpucHT2RDbSkrYMVXCY+rTP6vYVMFpKvVVAKPi0wxsla
         0NxixEWNiQBhPLEcTHKwPBDq1g1suxGIBU++nOYbAz1R9jbr5vBifB9erGh+ZV+vMena
         I0DBdvdqBuspvVfIgA6x6R7ZjcHMJpBl2zUmbVNEljQRjvhS1uyLAOkzuWaBVkcfESzB
         03YgzyauWqycACvYmj+nE4kYdAr/3V7WHNpoQGLul9eGDH+BitiDAc9RSKSKoLdhQCvh
         iikYHPia5tl1tWF49Qdbocy+kWJdOr+4b70M/k8z+FwuL8BIDi46Ibwl01IQZot/nPap
         atjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684602505; x=1687194505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMkCQYgPnXGE90YMUOC4Ohpkx8GIoVEN+6c9iF44+QU=;
        b=arNjcxPqHMOFnh+tjW+LJiauxWG0q50erJhamNqlbFp+HqUWSEJECONRS1OqLxLRSf
         jE9mGQ5Aw38nko8Os3Jz9+dl0bFb/z07ds/3iVffiAqaNr5hOWL5uGahvc/wh9pSkfDk
         fXSB7f5PZIzyXO2agMdQzfWdZmNXRqPszxD1sYDxTQ3kCbcSmGlkiofDqLJ6qlm6t4W4
         Xgny25mptS2GnIm3kem/BL2LqR0OXEb1dnThRUCefO+cd4G7KUneiDgUudjqu3sGOhv8
         5KaU04rcZrgdo9yfW9R3EA5slHNVE+DFD2ywov5xnOt1/e0Eu8do1ZB13rGqulOJxpDN
         0PEg==
X-Gm-Message-State: AC+VfDygNH8GE1oOFlgqOLARNo2/zMSyL1nrNCu6pt9EAO8zjMfNA9wN
        4BzX7BrSOTO5Gx0W+DtYgL2xuw==
X-Google-Smtp-Source: ACHHUZ6VVjkq+HEraagKzGdrcrMhbXkh/MXcbfHfjRREI0kWfyFkL4XWv8xtBJ43tgs4YpmsSga8lQ==
X-Received: by 2002:a5d:6a09:0:b0:309:48b9:977b with SMTP id m9-20020a5d6a09000000b0030948b9977bmr3938836wru.22.1684602505609;
        Sat, 20 May 2023 10:08:25 -0700 (PDT)
Received: from [192.168.69.115] (cho94-h02-176-184-4-185.dsl.sta.abo.bbox.fr. [176.184.4.185])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d4dc5000000b0030644bdefd8sm2446907wru.52.2023.05.20.10.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 10:08:25 -0700 (PDT)
Message-ID: <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
Date:   Sat, 20 May 2023 19:08:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
Content-Language: en-US
To:     Richard Henderson <richard.henderson@linaro.org>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Peter Maydell <peter.maydell@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
 <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
 <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 20/5/23 17:15, Richard Henderson wrote:
> On 5/20/23 06:15, BALATON Zoltan wrote:
>> On Sat, 20 May 2023, Peter Maydell wrote:
>>> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
>>> <qemu-devel@nongnu.org> wrote:
>>>>
>>>> From: Ira Weiny <ira.weiny@intel.com>
>>>>
>>>> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
>>>> specified as little endian.
>>>>
>>>> Define st24_le_p() and the supporting functions to store such a field
>>>> from a 32 bit host native value.
>>>>
>>>> The use of b, w, l, q as the size specifier is limiting.  So "24" was
>>>> used for the size part of the function name.
>>
>> Maybe it's clearer to use 24 but if we want to keep these somewhat 
>> consistent how about using t for Triplet, Three-bytes or Twenty-four?
> 
> I think it's clearer to use '3'.
> When I added 128-bit support I used cpu_ld16_mmu.

There is also ld8u / ld8s / st8.

> I think it would be clearer to not use letters anywhere, and to use 
> units of bytes instead of units of bits (no one can store just a bit), 
> but changing everything is a big job.

So:

ldub ->  ld1u,

lduw_le -> ld2u_le,

virtio_stl -> virtio_st4,

stq_be -> st8_be.

Right?

Also we have:

cpu_ld/st_*
virtio_ld/st_*
ld/st_*_phys
ld/st_*_pci_dma
address_space_ld/st

While mass-changing, we could use FOO_ld/st_BAR with FOO
for API and BAR for API variant (endian, mmuidx, ra, ...):

So:

ld/st_*_pci_dma -> pci_dma_ld/st_*

for ld/st_*_phys I'm not sure.
