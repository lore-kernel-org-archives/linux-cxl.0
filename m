Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA2C76196
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Apr 2023 23:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDGXZm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDGXZm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Apr 2023 19:25:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429FCC03
        for <linux-cxl@vger.kernel.org>; Fri,  7 Apr 2023 16:25:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54c12009c30so107505497b3.9
        for <linux-cxl@vger.kernel.org>; Fri, 07 Apr 2023 16:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680909914; x=1683501914;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhtRuKtih92dcCeJ3vkIc1sSk8c54hFFyB8JYf/WUhA=;
        b=I3Uln1zDMbPZe0YLgMy+ybnjq75LPfWt7uZzuFVcIWPzEO75Y+Y62QlhAu/ub21roo
         ZBOhjaZOZFphW6dHa6gN2wapMR1WYLP50iiOPdZzrwq1QvRkNWk/WeK2zuGotCYV7Uut
         ouwXuhuGJXbpy17415a5NDeo+duGf3Fi7grGpw7zCnIUztkLlhAMyC9ozwOTZX8/cJHU
         IyeFwJK31n0o4Lr7AUQrzEAc2cNsMpeiicxUaB716vizyEr6HSv6HCtldzcNR2VPoiNt
         o0XYjvRolKQx3jzp/zbxERphWf4UbRU/thanPf1v16RA0+wct2bIM747rU3mycF39TMW
         yZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680909914; x=1683501914;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhtRuKtih92dcCeJ3vkIc1sSk8c54hFFyB8JYf/WUhA=;
        b=uSRPTLftLGjoEVdPtVZdryarSD+r0d6EJ872PefuZT9UXkGHAT2AqHs9HU8p2V8ocW
         BvdLDgZAvtbJIsRer7vcDSRSnhgxXU7SIJzb232wTuxnq6R2mlo5WsMJUqEJFjvjfNtA
         98tXEChfe46Ks5nm63UA1Y+h1dNEbYXaEiKkVRUdbs1ZqTSyU5gPjc91SfY+o3jYpw0A
         xzUU2UCY+mXtQR/87feXGBKcKeuTsDeVK+JYAB4rCVGrxHXbFK/aMBxt+d04iTz65cVq
         RwVGf7YNi9SWBLsDKkR5NfJvqFYsCzt1Q4PkN/CXn7TvkdM32kl18gjwb61fZK1/F32k
         Ei4A==
X-Gm-Message-State: AAQBX9e0rl+E2TlH+ZvktYA+7cQXM2b04ZiTHoEhNp0HpVbT0nCqh4C4
        IFTRyJ7+Y4ARaA0mhqK4ZPSBhJ5S63zOuYYFhm0=
X-Google-Smtp-Source: AKy350b+PUB1d1bhaZ9BG/hA0lb9sW0nr4MI24oRdpyamyYg4u7Tjn3OfGNe5WKRHDvpi5olLBqwxw==
X-Received: by 2002:a81:6804:0:b0:543:8177:5c6b with SMTP id d4-20020a816804000000b0054381775c6bmr3216872ywc.29.1680909914047;
        Fri, 07 Apr 2023 16:25:14 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id x138-20020a0dd590000000b00545a0818489sm1319987ywd.25.2023.04.07.16.25.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Apr 2023 16:25:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] CXL Fabric Manager (FM) architecture diagrams
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <90aea04c-dab2-4b7e-bfc6-09a1240793a9@nmtadam.samsung>
Date:   Fri, 7 Apr 2023 16:24:59 -0700
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C2C2FAF-E295-4C7D-A276-D71D1D6BC047@bytedance.com>
References: <20230306185913.1060918-1-slava@dubeyko.com>
 <20230307172105.00006132@Huawei.com>
 <F6C3F73D-904C-4667-AB97-E12E64F4681F@bytedance.com>
 <20230310120126.000057b9@Huawei.com>
 <CGME20230316204601uscas1p1b131148afb011f5af5c3aa30cb660331@uscas1p1.samsung.com>
 <C6DF19E3-B5BB-47AE-8234-C6F0C9EF7C63@bytedance.com>
 <20230406204227.GA5971@bgt-140510-bm01>
 <05CEF439-92A8-45C0-A72F-A6E1FE5275D9@bytedance.com>
 <90aea04c-dab2-4b7e-bfc6-09a1240793a9@nmtadam.samsung>
To:     Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Apr 7, 2023, at 4:18 PM, Adam Manzanares <a.manzanares@samsung.com> =
wrote:
>=20
> On Fri, Apr 07, 2023 at 11:18:43AM -0700, Viacheslav A.Dubeyko wrote:
>> Hi Adam,
>>=20
>>> On Apr 6, 2023, at 1:42 PM, Adam Manzanares =
<a.manzanares@samsung.com> wrote:
>>>=20
>>> On Thu, Mar 16, 2023 at 01:43:25PM -0700, Viacheslav A.Dubeyko =
wrote:
>>>> Hi Jonathan,
>>>>=20
>>>>> On Mar 10, 2023, at 4:01 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>>>=20
>>>>> On Thu, 9 Mar 2023 14:28:51 -0800
>>>>> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>>>>>=20
>>>>>>> On Mar 7, 2023, at 9:21 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>>>>>=20
>>>>>>> On Mon,  6 Mar 2023 10:59:13 -0800
>>>>>>> Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>>>>>>>=20
>>>>>>>> Hi Jonathan,
>>>>>>>>=20
>>>>>>>> You can find diagram online now:
>>>=20
>>> Hello Slava,
>>>=20
>>> Thanks for putting these together. I think we need descriptive text =
to add=20
>>> context to the diagrams. I suggest adding a wiki.
>>=20
>> I enabled the wiki. Let me know if you have troubles to access it.
>=20
> I can see it, but I am unable to edit pages ATM.
>=20

As far as I can see, you need to clone the wiki. And then you can follow
to regular git way. I mean you can edit locally, make commit and
send pull/merge requests.

Thanks,
Slava.

