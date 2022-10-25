Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522E5C38A2D
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 18:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiJYSqS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbiJYSqL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 14:46:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3C16CD1E
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 11:45:46 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t25so8782573qkm.2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hM8pzTtmVBeBJlUFammpYzjTSwbv7nmoemRrgo5ZJ3k=;
        b=PO3WwcOvEGomxvfgLFAJFFTHa6s/x/wPXg3PCUyds3ccji1cSxEjwvovYio8t9RqvD
         UvP/WuhBrUvq7JeeRi8lYoXgIilhl/Jpum0fSt2liDgMrUJjpisfhSHaP0g276IG+SC/
         F5wrAIXcwb/uPiechBnKirNGsec0EoClg/ECa6GjF/zttqNRr0qL22WAAvogCvZRCufb
         w/v3DjeOIXKj7yeF/2mnLl1+aOZEqnh2YEWyCMYEbilB+m5ckzENJJNKZy6//6KwVWT7
         1JOd9BP9arAyvdDUOfJ4G/PEQ418bXQXKLPF4sjm0UzVCy5KMZXITs3LvDuaYiFLJNK1
         pr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hM8pzTtmVBeBJlUFammpYzjTSwbv7nmoemRrgo5ZJ3k=;
        b=obqSm+AN1FtbUPnftEBlo69QuEytuVUtaRYAivWQLZckfvntIvpTMhbSbtn9yN0ZsB
         J0NC6u/lMUPT8+bkzA3kz8AhTLmaK2KiWLwZ724u8FIBsZ/mrp4te7g16HtQOAW7c/j8
         wbVqhk5ylNjnvXA9K8V8OrXs80bpn66Wui+2AU9QnJkORkl3hWgO6GsjxW8u+h+9bFrK
         OU9ng18OZR1TkjoLHtazfRJyaFF914DBh1pITeFCBX1L45EWUEYULA62/Kj++kizpujE
         EU79edSBfy2ctieDYH7AEW5L7VeJuVl/Q+X6EhXwUY+XDrw5STtM1r/MISRc6f2aWnWh
         UmtQ==
X-Gm-Message-State: ACrzQf3kZp+jRPi6uQKSMVCdWLONfArjtuRXNnY2mZ5ID/fCr4Cp7T2W
        KWQYeNbaVOl3vnrKL634yVsV0A==
X-Google-Smtp-Source: AMsMyM73wWs/Qr17iomjMd9bjUTOLloGCBohW4Rdg/pBND5vYXkED0kfWf7FRPh5Km6Gd9ZgqLXetQ==
X-Received: by 2002:a05:620a:4054:b0:6ec:5735:2e20 with SMTP id i20-20020a05620a405400b006ec57352e20mr27931687qko.321.1666723545566;
        Tue, 25 Oct 2022 11:45:45 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:edbe:91c3:a3e:30fe])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a454d00b006a6ebde4799sm2576001qkp.90.2022.10.25.11.45.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:45:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [External] [RFC PATCH 1/1] cxl/pci: Add support for stand alone
 CXL Switch mailbox CCI
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20221025114251.000031f8@huawei.com>
Date:   Tue, 25 Oct 2022 11:45:42 -0700
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F46B7B5-B965-4E32-9704-01C1CE5B74DD@bytedance.com>
References: <20221024155322.16661-1-Jonathan.Cameron@huawei.com>
 <20221024155322.16661-2-Jonathan.Cameron@huawei.com>
 <E102AAEB-6AC8-45E0-A804-A7CDDB81B5B4@bytedance.com>
 <20221025114251.000031f8@huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

> On Oct 25, 2022, at 3:42 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
>>>=20

<skipped>

>>> +
>>> +static int cxl_sw_major;
>>> +static DEFINE_IDA(cxl_swdev_ida);
>>> +static DECLARE_RWSEM(cxl_swdev_rwsem); =20
>>=20
>=20
>> I am not sure how good and safe could be static semaphore. Currently,
>> I cannot share any potential troubles with it. But lifetime of this
>> semaphore will be the same as module itself. So, it sounds that we
>> will take memory even if functionality of this module never will be
>> used. And I assume that we pollute the global namespace with the name
>> of this semaphore.
>=20
> Modeled directly after the equivalent in cxl/core/memdev.c
>=20
> I'm not sure I care about the tiny amount of memory the semaphore will
> take up. Which namespace are you referring to?  =46rom a C point of =
view
> it's static so local to this file. I might be missing another form of
> namespace? (maybe debug or something like that?)
>=20

I think my worry is more semantical one. Usually, we need to use any
synchronization primitive (for example, semaphore) to guarantee
consistent access/modification of some variables or structure=E2=80=99s =
fields.
So, if cxl_swdev_rwsem is not part of any structure, then it is not =
clear
semantically what variables or structure=E2=80=99s fields needs to be =
protected
by semaphore. Potentially, it could be source of misunderstanding
if anybody else tries to modify the code or fix bugs. But I am OK with
current approach and I don=E2=80=99t see any other serious issues here.

Thanks,
Slava.



