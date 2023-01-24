Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4491CC25B4E
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 18:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjAXS0U (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjAXS0U (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 13:26:20 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A6B3D0BA
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 10:26:18 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id n24-20020a0568301e9800b006865671a9d5so9722319otr.6
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 10:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK+Syss145zgpvKrtGpCbzgufzpZQGuwTsc+kzXUyqc=;
        b=CvPNCiEC6Bbw8Wq+7E9LZ4BHPga84N73wWFnI9wlOjjrwTEuwA7tvE9aqRG2ULiJn2
         uTO1u9TxOMqxaWF78VK5TUUl/jCaC4kkH28cmi/5iXfeXbIOpQEf7ggFKIzZQyNqD1Al
         h5r5Cn2K9MOfSQJbTl2IJsFURLklf+hdzfRLWjANnggpsalx/0Ld2N+xDAF0pam+OL8a
         FqRg/r91OVsC2SMtCTd+sW+0CmPorS0EZTNFDBo0NLMKA7wOLQ1ffXTkKwdHWnDlqsfC
         fd9fQJc+FdXNGjeSRqGhIs0/Fkmzl7qNVu0aKq10rosezBAIX391SS9720IRA4qLlhwE
         AfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK+Syss145zgpvKrtGpCbzgufzpZQGuwTsc+kzXUyqc=;
        b=rL/WVmAiBzr8H+CrIUksuzbHGTBagNnLBM2VqXkiFwTlzAfGjxPLMcN9Yl1U9EBNUx
         VNj/bz6yl+G5HF/SzBtEuonDmoTsxBGzZ3StuwhmvBV71UGAIRmLxI5QPorUOI+yYMol
         RP2iR7Fth9fIPU1J4t2V7ZKrT6QxppRUsDRYSvoch9Ouzfp0h2F5NrNbIejlYrxKjjRI
         ACvbbpGfV8I6NeZTdtaVkDxWvrLVjkgC2AvKMfbqJUVg3lrvuOj9GGN4OT1AEfY/5t8y
         traOtUf8fDKNCN01CVOFbH5bpxwAlfCvEnD4eKW7OliUhv0VZ5HwJbL4Fbw+NRs51A0W
         zySA==
X-Gm-Message-State: AFqh2krodoaaME8srxCEZMSmNdD2Je4CkERjjzzHBdQf0InL2L/Yqv4A
        zMQBh96JleoIDF23VCknhbaM8g==
X-Google-Smtp-Source: AMrXdXs0MhXlMgg9+X2HjM02Pr88JK31zQ6xga6b+8mJ4SNrLdXGoiN04IgRZnjPaOY9BO9i8xtAyw==
X-Received: by 2002:a9d:639a:0:b0:684:dc1c:fe85 with SMTP id w26-20020a9d639a000000b00684dc1cfe85mr15803242otk.36.1674584776396;
        Tue, 24 Jan 2023 10:26:16 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id s25-20020a0568301e1900b006865f605ce3sm1202836otr.54.2023.01.24.10.26.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2023 10:26:16 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for CXL memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230124101255.000016a5@Huawei.com>
Date:   Tue, 24 Jan 2023 10:26:04 -0800
Cc:     lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D128AE23-E33C-4B0E-8A8A-4FDE4E29E637@bytedance.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <20230124101255.000016a5@Huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Jan 24, 2023, at 2:12 AM, Jonathan Cameron =
<Jonathan.Cameron@Huawei.com> wrote:
>=20
> On Fri, 6 Jan 2023 14:20:42 -0800
> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>=20
>> CC: LSF/MM/BPF mailing list. Sorry, missed the list.
>>=20
>>> On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko =
<viacheslav.dubeyko@bytedance.com> wrote:
>>>=20
>>> Hello,
>>>=20
>>> I believe CXL memory is hot topic now. I believe we have multiple =
topics
>>> for discussion. I personally would like to discuss CXL Fabric =
Manager
>>> and vision of FM architecture implementation.=20
>=20
> The fabric manager is rather disconnected from the host side of things =
(all
> out of band communications), so it would be a stretch to build a stand =
alone
> topic around that for LSF-MM. If we have the right people in the room =
/
> online, it would be good to discuss it (so part of a wider sessions on =
CXL).
> I'd love to get some traction before LSFMM though! Host aspects such =
as
> Dynamic Capacity Devices and sharing feel more LSFMM suitable.
>=20
>>> I am going to share the topic in separate email.
>=20
> Did I miss the email, or not sent yet?  That topic is obscure enough =
we definitely
> need some background if anyone outside of CXL folk is going to have =
any idea what
> we are talking about.
>=20

You missed nothing. :) I am still polishing the FM related topic. Sorry, =
I was busy
with other tasks.=20

>>> would like to suggest a special session for CXL memory
>>> related topics.
>>>=20
>>> How everybody feels about it?
>=20
> A lot of the interesting bits currently strike me as rather =
speculative
> (no code), so sessions might not be as productive as shooting at an
> implementation. That's less true of FM stuff as we really do need
> an outline of an architecture plus some planning on that.
>=20
> Could we have something to shoot at for other topics in the
> time frame?  maybe...
>=20

I believe even discussion before implementation could make sense.
Because, it provides the way to make the architecture/API vision more
clear and understandable by everyone sometimes. :)

Thanks,
Slava.

