Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D42C6FD1D
	for <linux-cxl@archiver.kernel.org>; Fri,  7 Apr 2023 18:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjDGST1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Apr 2023 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDGST0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Apr 2023 14:19:26 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C365BC
        for <linux-cxl@vger.kernel.org>; Fri,  7 Apr 2023 11:18:58 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54bfa5e698eso142712007b3.13
        for <linux-cxl@vger.kernel.org>; Fri, 07 Apr 2023 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680891537; x=1683483537;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QRLw3FpV4dZUvmeYhYCBfGzONyi+IBkarTQtTjScYY=;
        b=I+dSh/AqtlF7O30rQMPtWfY1usL1dvYpC0oDd1BiWyLetbBG4F9V4MsuoeUCRmZFax
         VARt6TqiU8Z1aJAtWhTd46tv1b4YZZXXpfF6oYvAVldIj4FpSFlUauj+Zewdm729rOu4
         KmKpY2Jw2M7nuMMuMNx2twDSkrOoWZ8p9lxwkajw0ApcHGyo8oxElV3R+8MDMQRe5nRC
         aZIhhObrI46/X3YTLfctHAnYC4C1lfM5B/7RAuxpCWbqNaKY/YhC4r+Z7v23tbuc5uus
         F/DT8BZMs2VynYs7iPPoc3ue0mb78l2ec83jJGLcmRs//Awt/hYVH20sjKqHPBaW6bju
         HfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680891537; x=1683483537;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0QRLw3FpV4dZUvmeYhYCBfGzONyi+IBkarTQtTjScYY=;
        b=Q1GoONz9esppRdfWAt/AdaSBqbUGGnJGgAArfCb6X2XyRqpobVDnKroh5dx4cxHTdM
         KBGc5g+0Jo1yoVPATrtMAn3Wv9feDPpJINSIOdkV7vYgHccXMSUIIoA72Hlb/zcHf/94
         IP1vo5xhR+Obz1h5ZQjA1w7rA2x/XFN1FeOMMrVxrv9Bd2CSmq8P+vI8cqO5UCbckKaY
         DhpuiOhCcYVGHWKFryt1sCLLuNVuieNT8A0sxYjVgbGvBC7Id5N2odYxuyHV5bsBRHhu
         xFhFUjXv8m3xf9e8GUEaPQjt4IT3M9ml00BH6XpYrJssXqf+KbuA7XlQDz+kF2NkDNZc
         +4Gw==
X-Gm-Message-State: AAQBX9d1snjk0JQDTdCqXUF7elmD8KfexbXNJe6o5/LTwpQw/2Y9O1qT
        14enWFQmduZbu0Bpy4p5J5ohZw==
X-Google-Smtp-Source: AKy350ZjIr2yPfMac7sKRtrDhqEP2BcacEk4QhP314FVxK5WMWtuJTXrBO/w5n+XMSXkzehEfKDSDw==
X-Received: by 2002:a81:4e0f:0:b0:541:63c6:a938 with SMTP id c15-20020a814e0f000000b0054163c6a938mr3040794ywb.12.1680891537574;
        Fri, 07 Apr 2023 11:18:57 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q133-20020a81998b000000b00545a0818501sm1140607ywg.145.2023.04.07.11.18.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Apr 2023 11:18:57 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] CXL Fabric Manager (FM) architecture diagrams
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230406204227.GA5971@bgt-140510-bm01>
Date:   Fri, 7 Apr 2023 11:18:43 -0700
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <05CEF439-92A8-45C0-A72F-A6E1FE5275D9@bytedance.com>
References: <20230306185913.1060918-1-slava@dubeyko.com>
 <20230307172105.00006132@Huawei.com>
 <F6C3F73D-904C-4667-AB97-E12E64F4681F@bytedance.com>
 <20230310120126.000057b9@Huawei.com>
 <CGME20230316204601uscas1p1b131148afb011f5af5c3aa30cb660331@uscas1p1.samsung.com>
 <C6DF19E3-B5BB-47AE-8234-C6F0C9EF7C63@bytedance.com>
 <20230406204227.GA5971@bgt-140510-bm01>
To:     Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Adam,

> On Apr 6, 2023, at 1:42 PM, Adam Manzanares <a.manzanares@samsung.com> =
wrote:
>=20
> On Thu, Mar 16, 2023 at 01:43:25PM -0700, Viacheslav A.Dubeyko wrote:
>> Hi Jonathan,
>>=20
>>> On Mar 10, 2023, at 4:01 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>=20
>>> On Thu, 9 Mar 2023 14:28:51 -0800
>>> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>>>=20
>>>>> On Mar 7, 2023, at 9:21 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>>>>>=20
>>>>> On Mon,  6 Mar 2023 10:59:13 -0800
>>>>> Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>>>>>=20
>>>>>> Hi Jonathan,
>>>>>>=20
>>>>>> You can find diagram online now:
>=20
> Hello Slava,
>=20
> Thanks for putting these together. I think we need descriptive text to =
add=20
> context to the diagrams. I suggest adding a wiki.

I enabled the wiki. Let me know if you have troubles to access it.

> =20
>=20
>>>>>>=20
>>>>>> (1) Diagram 1: single host with Fabric Manager (FM)
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D6d4281=
7d-0c3f6bfe-6d430a32-74fe48600158-e525dd835650a36b&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram1-cxl-fm-single-host-with-fm.p=
df__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOUyGyroMSJFLjcvROfs=
CKFs1MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8TuzI6n8Hlk$  =20
>>>>>=20
>>=20
>> Diagram 1 has been reworked.
>=20
> Once we have a wiki it would be great to document how we enable =
logical
> connections to the host. We also need to define all of the terms used =
in the=20
> diagram. I can post a v1 once the wiki is enabled.
>=20

Sounds great! Let's do it.

>>=20
>>>>=20
>>>>>>=20
>>>>>> (2) Diagram 2: single host with orchestrator
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3Dbfd57f=
d6-dea89555-bfd4f499-74fe48600158-f6b28a23672be168&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram2-cxl-fm-single-host-with-orhe=
strator.pdf__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOUyGyroMSJ=
FLjcvROfsCKFs1MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8TuzeCJmksA$=
  =20
>>>>>=20
>>=20
>> Diagram 2 has been reworked.
>=20
> I think the orchestrator does not always have to be over a network =
connection.
> In Diagram 1 the APP is acting as the orchestrator IMO because it =
directly
> interacts with the FM.=20
>=20

If we don=E2=80=99t need to go through network, then we don=E2=80=99t =
need orchestrator at all.
It means that local FM can manage all requests. The point of =
orchestrator is to manage
multiple FM instances through the network connection.

> Do you think it would be valuable to have a bit more detail about =
where the FM
> and orchestor reside. For example orchestrator could be another host =
and FM
> could be part of the switch. I'm trying to come up with more detail =
without
> being tied to a particular architecture. I suppose the wiki will help =
here.
>=20

I think that problem with going into more details is losing the =
generality of the diagram.
Also, more detailed diagram makes picture more complicated. Technically =
speaking, orchestrator
could reside on the same machine or on another dedicated machine. =
Showing the particular
placement of orchestrator and FM can initiate discussion related the =
feasibility to have FM
inside of switch, for example. And it=E2=80=99s not important from =
software point of view, currently,
as far as I can see.

>>=20
>>=20
>>>>>>=20
>>>>>> (3) Diagram3: Multi-headed device
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D626e6b=
92-03138111-626fe0dd-74fe48600158-4dacfa8033223c46&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram3-cxl-fm-multi-headed-device.p=
df__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOUyGyroMSJFLjcvROfs=
CKFs1MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8TuzVSc7k_E$  =20
>>>>>=20
>>=20
>> Diagram 3 has been reworked.
>>=20
>=20
> Can you remind me why we need both heads of the MHD to be connected to =
the=20
> same host?
>=20

I think it=E2=80=99s one to the potential case. Diagram 3 shows the case =
of connected both heads
to one host and diagram 4 shows the case of connection of heads to =
different hosts.
Technically speaking, we cannot exclude the case of connection of both =
heads to the same host.

>>>>>> (4) Diagram 4: Multi-headed device + Orchestrator
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D777537=
1c-1608dd9f-7774bc53-74fe48600158-eaab011af7366bc3&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram4-cxl-fm-multi-headed-device-o=
rchestrator.pdf__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOUyGyr=
oMSJFLjcvROfsCKFs1MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8TuzftBJ=
kJc$  =20
>>=20
>> Diagram 4 has been reworked.
>>=20
>>>>>>=20
>>>>>> (5) Diagram5: Multiple hosts with Fabric Manager (FM)
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3Df03a75=
11-91479f92-f03bfe5e-74fe48600158-97054848fb228380&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram5-cxl-fm-multiple-hosts-with-f=
m.pdf__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOUyGyroMSJFLjcvR=
OfsCKFs1MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8Tuz6UJQkqk$  =20=

>>>>>=20
>>=20
>> Diagram 5 has been reworked.
>=20
> I am thinking the multiple hosts and single host with the orchestrator =
off the
> hosts shown can be represented with a single diagram.
>=20

Do you mean diagram 2 and diagram 5? Possibly, yes. But I believe it =
makes sense to show
the both cases on independent diagrams.

>>=20
>>>>>>=20
>>>>>> (6) Diagram 6: Multiple hosts with orhestrator
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D55b499=
bc-34c9733f-55b512f3-74fe48600158-8fbd9efa3688d19c&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram6-cxl-fm-multiple-hosts-with-o=
rhestrator.pdf__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOUyGyro=
MSJFLjcvROfsCKFs1MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8TuzaEytq=
Fw$ =20
>>>>>=20
>>=20
>>=20
>> Diagram 6 has been removed.
>>=20
>>>>>>=20
>>>>>> (7) Diagram 7: Distributed Fabric Manager (FM)
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D2f929e=
7e-4eef74fd-2f931531-74fe48600158-45f23959e990d9c3&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram7-cxl-fm-distributed-fm.pdf__;=
JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOUyGyroMSJFLjcvROfsCKFs1=
MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8Tuz_smZe_0$=20
>>>>>>=20
>>=20
>> Diagram 7 is Diagram 6 now. And it=E2=80=99s reworked.
>>=20
>=20
> The fun begins! Is there an implication that each switch will have an =
FM
> component? Once we have the wiki we should try to describe the most =
likely
> scenario that would produce this topology.
>=20

As far as I can see, not everybody is convinced that FM can be inside of =
switch at all.
We need to take such possibility into account. I assume that switch =
could contain simplified
FM implementation. But if you need more powerful FM, then it will be =
outside of the switch.

>>>>>> (8) Diagram 8: Layered Fabric Manager (FM) and separate =
orchestrator
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3Df31a68=
c9-9267824a-f31be386-74fe48600158-2837aeae8831a63e&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram8-cxl-fm-layered-fm-and-separa=
te-orchestrator.pdf__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOU=
yGyroMSJFLjcvROfsCKFs1MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8Tuz=
GsyovOU$  =20
>>>>>=20
>>=20
>> Diagram 8 is Diagram 7 now. And it=E2=80=99s reworked.
>=20
> What is the TOP FM and bottom FM responsible for?=20
>>=20

As far as I can see, it is the implementation of layered or hierarchical =
FM
infrastructure. The bottom FM represents leaf level of the hierarchy and
the top FM can be imagined like a index node of the hierarchy or tree.
So, the top FM can work like an index node of tree with the goal to find
the proper instance of bottom FM.

>>>>>> (9) Diagram 9: BMC based layered Fabric Manager (FM)
>>>>>> =
https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D14514e=
e3-752ca460-1450c5ac-74fe48600158-0c34c12aaa752376&q=3D1&e=3D93cc7f88-264f=
-4371-963b-b0f922c6255f&u=3Dhttps*3A*2F*2Fgithub.com*2Fcomputexpresslink*2=
Fcxl-fm-architecture*2Fblob*2Fmain*2Fdiagram9-cxl-fm-bmc-based-layered-fm.=
pdf__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WOepCxwyOun3qkuCOUyGyroMSJFLjcvROf=
sCKFs1MLgQagV8Ijg_oyEnnH4md9RO3YgIouhzWUr6Xfi1RYJdR7wk8Tuz1Yn7XZU$  =20
>>>>>=20
>>=20
>> Diagram 9 is Diagram 8 now. And it=E2=80=99s reworked.
>=20
> Where is the layering here? It looks like the BMC has the entire FM.
>=20

Yeah, maybe the title needs to be reworked.

>>=20
>> Please, check the online version of diagrams and
>> let me know if I need to rework any diagram.
>=20
> Thanks for putting this together. Once we have a wiki in place I think =
it is
> a great spot to reference when we have discussions about open source =
code
> development.
>=20

I enabled the wiki. So, let=E2=80=99s start collaboration in wiki space.

Thanks,
Slava.

