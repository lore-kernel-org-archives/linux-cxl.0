Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F8C7618A
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Mar 2023 20:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCPUoF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCPUoE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Mar 2023 16:44:04 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DE2A14F
        for <linux-cxl@vger.kernel.org>; Thu, 16 Mar 2023 13:43:38 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x1so3250115qtr.7
        for <linux-cxl@vger.kernel.org>; Thu, 16 Mar 2023 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678999418;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc6swQhb68yJtfW+drht1iCVBwdNeIL7MkstjP5wXKo=;
        b=HN1hJfzGjT1pJnP1Lwcjj0tCopWtxTRQAB5uHBPYVvK0Uv4IyafxHmjSVoxlpFi9Uj
         XELxEQ869VKYus4pQbzINp0vzq5RClwvotvyK7l83l2ZsjhQMKbgPtXVZCuKvoxrmKla
         hi2686o/gT38LFH+Y+A265Akjz1my5YJe4HZ8QV1AgoUpt9YB8898TIOA01n5JcRIacC
         /t44iw+OhjjlqYQfcQ5mmV6CcKX1Ra3uJ7xGl+RvYh8e1MFDB4Y69Ww8Z2HrhtexHzGZ
         6U34i9hUoCIwNJtl8YcIe6MDELi2kmNeYR3znocZlEk3/oJWA/ECUtzIFdfxYgGmYHXF
         VIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678999418;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc6swQhb68yJtfW+drht1iCVBwdNeIL7MkstjP5wXKo=;
        b=BDvULYU3TrRLAodAp19NdI2OC+f22KaAd1F81gaxnvmWSEGtBt0Ljz/HC5NGGHs2WG
         IW3TedXiFLdJIsbvZHGBUS6r5nHyELdA6M3wzyi+xm2Uabr2i0gfpHgGIQIwONP0zaWg
         29iNYFwXRTUyqVa+Cw6sOB3O6yjBjt2/7SXAtkapcCSx7tRbHb0wR8n9hOkTAFcPBy+H
         T7EKWbMhvcN1Xan8AcM0pE1vLDVHBcRJ7Ve7/aQM7xY4mZyRsQV/FRKnUm95DkQhwSzd
         fxYLdVReHh2Izuacm2NU8FgliCA+eJLgkGBx6PYp/c4I69VgBcz9qkR5KwZS+TWPFh7n
         KFrQ==
X-Gm-Message-State: AO0yUKVINwZ+JBxlfWUh8OjSBj+tPz9rgAOj2P8u2F8mO9GVAXIHv6+I
        8YNDPLR6Xz0LMsF2WrJLexFdrA==
X-Google-Smtp-Source: AK7set+edYIIsPrYAkmna+sJazz+LGumAoJ5gXPJPI3ZVP1+MlbhS8g/gBp/sM5wHHUK4R5hOlJLuQ==
X-Received: by 2002:ac8:5903:0:b0:3b9:cd2a:f13d with SMTP id 3-20020ac85903000000b003b9cd2af13dmr8593759qty.59.1678999418019;
        Thu, 16 Mar 2023 13:43:38 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id e12-20020a05620a014c00b0073b27323c6dsm219555qkn.136.2023.03.16.13.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2023 13:43:37 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] CXL Fabric Manager (FM) architecture diagrams
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230310120126.000057b9@Huawei.com>
Date:   Thu, 16 Mar 2023 13:43:25 -0700
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6DF19E3-B5BB-47AE-8234-C6F0C9EF7C63@bytedance.com>
References: <20230306185913.1060918-1-slava@dubeyko.com>
 <20230307172105.00006132@Huawei.com>
 <F6C3F73D-904C-4667-AB97-E12E64F4681F@bytedance.com>
 <20230310120126.000057b9@Huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

> On Mar 10, 2023, at 4:01 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Thu, 9 Mar 2023 14:28:51 -0800
> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>=20
>>> On Mar 7, 2023, at 9:21 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>=20
>>> On Mon,  6 Mar 2023 10:59:13 -0800
>>> Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>>>=20
>>>> Hi Jonathan,
>>>>=20
>>>> You can find diagram online now:
>>>>=20
>>>> (1) Diagram 1: single host with Fabric Manager (FM)
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
1-cxl-fm-single-host-with-fm.pdf =20
>>>=20

Diagram 1 has been reworked.

>>=20
>>>>=20
>>>> (2) Diagram 2: single host with orchestrator
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
2-cxl-fm-single-host-with-orhestrator.pdf =20
>>>=20

Diagram 2 has been reworked.


>>>>=20
>>>> (3) Diagram3: Multi-headed device
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
3-cxl-fm-multi-headed-device.pdf =20
>>>=20

Diagram 3 has been reworked.

>>>> (4) Diagram 4: Multi-headed device + Orchestrator
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
4-cxl-fm-multi-headed-device-orchestrator.pdf =20

Diagram 4 has been reworked.

>>>>=20
>>>> (5) Diagram5: Multiple hosts with Fabric Manager (FM)
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
5-cxl-fm-multiple-hosts-with-fm.pdf =20
>>>=20

Diagram 5 has been reworked.

>>>>=20
>>>> (6) Diagram 6: Multiple hosts with orhestrator
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
6-cxl-fm-multiple-hosts-with-orhestrator.pdf=20
>>>=20


Diagram 6 has been removed.

>>>>=20
>>>> (7) Diagram 7: Distributed Fabric Manager (FM)
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
7-cxl-fm-distributed-fm.pdf
>>>>=20

Diagram 7 is Diagram 6 now. And it=E2=80=99s reworked.

>>>> (8) Diagram 8: Layered Fabric Manager (FM) and separate =
orchestrator
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
8-cxl-fm-layered-fm-and-separate-orchestrator.pdf =20
>>>=20

Diagram 8 is Diagram 7 now. And it=E2=80=99s reworked.

>>>> (9) Diagram 9: BMC based layered Fabric Manager (FM)
>>>> =
https://github.com/computexpresslink/cxl-fm-architecture/blob/main/diagram=
9-cxl-fm-bmc-based-layered-fm.pdf =20
>>>=20

Diagram 9 is Diagram 8 now. And it=E2=80=99s reworked.

Please, check the online version of diagrams and
let me know if I need to rework any diagram.

Thanks,
Slava.

