Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EBDC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Oct 2022 21:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJRV0q (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Oct 2022 17:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiJRV0q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Oct 2022 17:26:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9D1B5154
        for <linux-cxl@vger.kernel.org>; Tue, 18 Oct 2022 14:26:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b25so9545498qkk.7
        for <linux-cxl@vger.kernel.org>; Tue, 18 Oct 2022 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1APKT53JG/wq6o2jf11XrZ2this9jjAZ26YhgTsfr3Q=;
        b=EJT5iaQECqnQH+RhOPioS0o9T6t4WM/Hn0BTupAHOI0GE+mpGwwAOZxUqRuNP43EVI
         IfiaqPO2PXtbzj3omXIr9Mgl9rUPKndG22RG9+YislkQ8CzQHHhGcEE+50/aVc04SI4V
         63FCiMiDgYTNN4qA0cPHNNXPYCJx6T72DhmWWs+FlWeq7gTKJOO85BqI2oyVtPZMhv9E
         OivLHODRXfHD3xQC/NlWvq1T7Vrw23Bt+pJHAjVAQrA97HgBwu9KWbV5vy7Np+NOCkcm
         c+Y1CT/Zth5nqwjJg+SPQTrDKCQpVUisGAfmJ/J6SYj40zuvsw1XyQdE/QRQbyqaHxqZ
         nXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1APKT53JG/wq6o2jf11XrZ2this9jjAZ26YhgTsfr3Q=;
        b=E2NOHJPwtM6XnPmZWmJrSUHbl6aYd2ntOJiWr0NtBPzQCFbAUQfQZnsBouPLo3jsl4
         RUrEQEHdUQB2DA8y7h9thIDUViYJxGsA8CrDBWe8a1P+AKE7/OYdSHIdSyZZncVewP7Y
         2kbjlL/wlKFp9xxw6IECraF0aml8tzBLbe10jcYIu/wrGs90rs8UmAsj/+gvqx37kr0y
         77UNOF7vlY/5hXpuKc8wYr9GAjM46UIvsX9q68fNdrbIEDmgsWVD1SCu4Kwutqck/P7Q
         4uKqxCO1mYq9BAOFc/r4T/9OkU79rix+JeZt+DCqOQfQlZisvd6/AMoBbJIyIs5lQyY7
         yiIA==
X-Gm-Message-State: ACrzQf31OO+IFc2yq/K4d6mxwz4xcCXUfCizwPTVQmcX6pum3rqW5l5F
        Tk28rZykzV5vtTcaYoQ0nCbEUw==
X-Google-Smtp-Source: AMsMyM5zfVX7YK8H4zeLd4F13pSOxunbIXNTbw/a8/Opu24z/18MiYx7QGM781YEO+aBz3RKXKlIdw==
X-Received: by 2002:a37:c13:0:b0:6ee:6ab3:8b9 with SMTP id 19-20020a370c13000000b006ee6ab308b9mr3291384qkm.664.1666128403760;
        Tue, 18 Oct 2022 14:26:43 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id cq10-20020a05622a424a00b0035cf0f50d7csm2657342qtb.52.2022.10.18.14.26.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2022 14:26:43 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [External] CXL emulation in QEMU contribution
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20221013160902.00001c32@huawei.com>
Date:   Tue, 18 Oct 2022 14:26:41 -0700
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Cong Wang <cong.wang@bytedance.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2DECB41B-DB90-47DF-BA8E-BEE6869BADFD@bytedance.com>
References: <20221011095228.00001546@huawei.com>
 <31569DD4-6502-4188-8962-08E0A15B08FF@bytedance.com>
 <20221013160902.00001c32@huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

> On Oct 13, 2022, at 8:09 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20

<skipped>

>> So, I would like to contribute to QEMU emulation of CXL memory
>> support. And I would like to see a TODO list. I hope this list could
>> be useful not only for me. As far as I can see, we can summarize:
>=20
> Absolutely agree on need for a TODO now there are multiple groups =
involved

As far as I can see, Fabric Management looks like =E2=80=9Cuncharted =
territory=E2=80=9D with a lot of work. I think it=E2=80=99s pretty =
interesting direction for me to start. I can read Compute Express Link =
Specification (Revision 3.0, Version 1.0). Could you recommend some =
other docs or links to take a look?

By the way, I see ARM64 support in TODO list. But nothing related to =
RISC-V. Do we need to consider RISC-V too?

Thanks,
Slava.



