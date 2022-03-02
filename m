Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CAEC433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Mar 2022 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiCBQIY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiCBQIX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Mar 2022 11:08:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2C22E6B9
        for <linux-cxl@vger.kernel.org>; Wed,  2 Mar 2022 08:07:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i11so2912146eda.9
        for <linux-cxl@vger.kernel.org>; Wed, 02 Mar 2022 08:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=3tw+/dxXxPhC+vkYuGpxcbT7uVsWPReMTgAw09Ymdxo=;
        b=CH/HBfJkRkUqcOhRweS+9Bak3CCces6EnsazPPm2bvU0LkNZTusLHGIbrUb5VYNSYi
         EPuGuEvqo53PL3dBo8Q62F5c/7liA/SHqNZgg5BEfF1sf3HEecHw0YqS0W9eqqKTbskx
         yHgNvukTgpcOcaFT7yjBVYuUmpX+Yy4NhZ1VzD9MevlCLxJzRXw+TR63YMbMOSXYnsqV
         2wIcHAl4zz94rrbIdgMt40QPrpkCWJbFW02OULZsKGnN56ZtcSj6dTUBQvD+pwgJtPpw
         5tECg8iCLJjynh6JdxAVMbwI7d8H3w0ZuuK2z+3FRRSl9XRbyjCRvyAqCb6z9FaD5Fn+
         frgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=3tw+/dxXxPhC+vkYuGpxcbT7uVsWPReMTgAw09Ymdxo=;
        b=jT1Gt1+tfUL7yvkGGQ8r4leFqBrJPuqziD6kRQ60Nh7fnni0x+qmuyBlGOJrvkHaRT
         ttpEugP/onh/lAv/kTYXqd9VDZbe8Jv3dq2/UqReX5av1baYX57RgmdqN1IbUSZVZ5Hw
         5913xKPDSzyOyBQb0uuX86YmXezcVHJ9EchLdR+Xp9P1hQQ0QS6v9c4U64fzvuHXOrUL
         eYqZY42Ql4Ws4WZd3hjzAPNQOy5uYQlpbUn2INNoXQuFTMq6oPwEWxRGA8BxqXa6B5ws
         wylCE2Wjf8dNWnpeOYK3LAt6tkq98rkIUCxDNbMGQxtVNKYeIEqroWd8O7MtU05Sgwrr
         zbRw==
X-Gm-Message-State: AOAM532k4TWF2g+uEsSJreBC65xIGbUihKB6NQX+W7SJnmgoeBtZ6djN
        DSJR3KX5Xax6w5CPzxLPfkO+MA==
X-Google-Smtp-Source: ABdhPJwdNC6d05iW2OqD3Ug2ZdYJ/FQC9oOahHGv2WWXCuh5wPRtw2wC3N+jvBBKoSKz7diYT1Iwrg==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr30730277edt.186.1646237257595;
        Wed, 02 Mar 2022 08:07:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id ky5-20020a170907778500b006d1b2dd8d4csm6520671ejc.99.2022.03.02.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 08:07:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 140E31FFB7;
        Wed,  2 Mar 2022 16:07:36 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-32-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.9; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 31/43] CXL/cxl_component: Add cxl_get_hb_cstate()
Date:   Wed, 02 Mar 2022 16:07:31 +0000
In-reply-to: <20220211120747.3074-32-Jonathan.Cameron@huawei.com>
Message-ID: <87tucgibhz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> Accessor to get hold of the cxl state for a CXL host bridge
> without exposing the internals of the implementation.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
