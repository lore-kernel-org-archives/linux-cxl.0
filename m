Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DFFC433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Mar 2022 08:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiCIIQh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Mar 2022 03:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCIIQh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Mar 2022 03:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74F3F163D5B
        for <linux-cxl@vger.kernel.org>; Wed,  9 Mar 2022 00:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646813738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQGsDgfSF8Kw9vxZ+gu1l0IplnaO0hq0RNvBXA+sM54=;
        b=TCjQ/KokoodHMfZVowO+9ue4rhGY8AJKdQnrS10bInMkcO/zxckl3659ZdtRSjENHD9DGI
        +wRa7HPxD5qQlsuRsKOvCL9Ba9k2wb/nuyy6CNKNTBjvHC2WQOh1weIzIpp0XaH3GVEcrF
        xmWYkMB3hlnuLbcK2/6P+cn6cgL049U=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-ixCNgKL6Njm5XQRYGM6NeA-1; Wed, 09 Mar 2022 03:15:37 -0500
X-MC-Unique: ixCNgKL6Njm5XQRYGM6NeA-1
Received: by mail-pf1-f200.google.com with SMTP id x8-20020aa79ac8000000b004f6caa3e63dso1120815pfp.17
        for <linux-cxl@vger.kernel.org>; Wed, 09 Mar 2022 00:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQGsDgfSF8Kw9vxZ+gu1l0IplnaO0hq0RNvBXA+sM54=;
        b=0VPaOaS53qLNuwuc9TI/Qbv6hBp26MhrB4JXBd2utUqW2LvUc8DiO15GPUg7Cl+JSI
         0K7X0D5g8vGmGtDX/IQL2ZmDeJH9ar/9UNFDxonEedTLR7az1dOlmYJhgFxHPFxxWLzf
         G+Ss/O3YAYIqi4dWArUYp7GSxgDhQaDMzUpVYCiOEZ+8u99zFADVOLxyK1mylTS+jOqJ
         r2OK2JZYQYbYPa45w6ELNygBUnFPh0AqZwnFs/2kLQfGJRQNBvRh+1+Qv0dxXrkNzxro
         9S5HspR45VTCB/38nqqDaRuwXT04vVYEdPP2eVwq2M33L/wYYbrYzB8c5Quxy+5UIL8a
         3lbg==
X-Gm-Message-State: AOAM5331jvvivudTttj+5qiMbVjVl0N78cf9VU6AJI54O6OydMlEdhXQ
        8vO0cr/dwcwpVARYcn5tImrO/bUMXgPGajqXpBUllCY6grkfAkganKSn9WeN4eWZfYi2riHjsDI
        GxGn1zF/tpkeExlSS9mGY
X-Received: by 2002:a05:6a00:84b:b0:4f7:439b:64e6 with SMTP id q11-20020a056a00084b00b004f7439b64e6mr4208192pfk.51.1646813736299;
        Wed, 09 Mar 2022 00:15:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjt7wYmUS6huK2BOrY+8jGjuBaXK2e76PQHDJmizQXhGrpH7EOG83FDPQiglJ8wFF696nACA==
X-Received: by 2002:a05:6a00:84b:b0:4f7:439b:64e6 with SMTP id q11-20020a056a00084b00b004f7439b64e6mr4208159pfk.51.1646813735990;
        Wed, 09 Mar 2022 00:15:35 -0800 (PST)
Received: from xz-m1.local ([94.177.118.47])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm1750449pfu.62.2022.03.09.00.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 00:15:35 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:15:24 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Ben Widawsky <ben.widawsky@intel.com>, qemu-devel@nongnu.org,
        Samarth Saxena <samarths@cadence.com>,
        Chris Browy <cbrowy@avery-design.com>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v7 00/46] CXl 2.0 emulation Support
Message-ID: <YihiHNxVjDFI0Z8r@xz-m1.local>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
 <20220306163119-mutt-send-email-mst@kernel.org>
 <20220307093918.00002f20@Huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220307093918.00002f20@Huawei.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Mar 07, 2022 at 09:39:18AM +0000, Jonathan Cameron via wrote:
> If any of the memory maintainers can take a look at patch 34 that would
> be great as to my mind that and the related interleave decoding in general is
> the big unknown in this set. I just realized I haven't cc'd everyone
> I should have for that - added them here and I'll make sure to CC them
> all on V8.

https://lore.kernel.org/qemu-devel/20220306174137.5707-35-Jonathan.Cameron@huawei.com/

Having mr->ops set but with memory_access_is_direct() returning true sounds
weird to me.

Sorry to have no understanding of the whole picture, but.. could you share
more on what's the interleaving requirement on the proxying, and why it
can't be done with adding some IO memory regions as sub-regions upon the
file one?

Thanks,

-- 
Peter Xu

