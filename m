Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14EC05027
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Feb 2023 22:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjBIWX0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBIWXZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Feb 2023 17:23:25 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E502E68AD7
        for <linux-cxl@vger.kernel.org>; Thu,  9 Feb 2023 14:22:58 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r34-20020a05683044a200b0068d4a8a8d2dso1017435otv.12
        for <linux-cxl@vger.kernel.org>; Thu, 09 Feb 2023 14:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFZR6Xfgk9KAiE3ijmG6Tw9Tq94CGVcZz40hqRYtxcY=;
        b=XrNKJSt4zO+Z7rgysrOQRgXXbshDNUZwdld4u1om2RtQiZ2w2GGsoTRPQRWxpgYvwq
         zFL3Do+0RPo3nmuG4UimZ7r2bnEKaafuAuIRgWn71jtOmPHfBOoxkhTHAssqmlyJx8X9
         IhJIpy+UZSXPHD1Jaku9QiwxIGfx0zZcIg9S76TB6GAMMWBL7RHKE5r8QI1ve1u6sM9I
         JYdiosDsBB3lIchaRTmO12euDqBL8RJpjotXrM1bqsFcMqk5OoTySMREokSiMWJOUrfl
         pUjN0mxpq6jr7Gg22xErTcUm6/UY4Y34WZuUvqJTHCEdT/zyjjQH8DNKq/YPCdpSDpfp
         dh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFZR6Xfgk9KAiE3ijmG6Tw9Tq94CGVcZz40hqRYtxcY=;
        b=lkogA7yO6IfJMQwWMEgX7TNwnpqKC9T3onZhV1iv/DuO7g/dHVaNoeaZc/OCOMe+zL
         0eHtT+XdSjyTlC1ZzGCgL1GZJ3L5uFKwNRcRFhXJ7bP6lfoJL9+j0whbnN/Z8Y+GREOd
         ybbfGyOwb4tOpmuTx9joIR2i44n2sAgm2B3SK0qTFyedpX5Uf3SXE76d7ayA/0J7WQ/Y
         84zmPZw8zE9eMAyBEM4/WxTaIcbFe9FX11bjZX3cBtoTBcDjujHIL04oyADI8xsdGziV
         /iZgkbeE+c6SNF8Y1+z62vHZSPdLK3WwAVugTTryDHGrlZJ5BN7F8SK0dpk1n22iHRKk
         +MgA==
X-Gm-Message-State: AO0yUKUtUjWz7VYcd9FQMwTwENzeBZDXit++MowbIeroCUcYU/Ayx6PE
        Qhwco/9QgrnMH0z+5/zKkDk8GQ==
X-Google-Smtp-Source: AK7set/cRcC+MHYtZkFWioLDrvm6Ro5wqPLrkQKV/+pKTTs8tPoG+haFcrqrpcW2j8P4bjrB1a0ngA==
X-Received: by 2002:a9d:65d3:0:b0:68e:d218:ee44 with SMTP id z19-20020a9d65d3000000b0068ed218ee44mr2092777oth.32.1675981378242;
        Thu, 09 Feb 2023 14:22:58 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id y3-20020a056830108300b00684e4d974e6sm1306690oto.24.2023.02.09.14.22.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Feb 2023 14:22:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF TOPIC] CXL Fabric Manager (FM)
 architecture
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230209221045.GA416928@bgt-140510-bm01>
Date:   Thu, 9 Feb 2023 14:22:45 -0800
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E272B5A-5952-4680-94A6-14F588ACA7C4@bytedance.com>
References: <7F001EAF-C512-436A-A9DD-E08730C91214@bytedance.com>
 <20230131174115.00007493@Huawei.com>
 <5671D3B3-83B3-49FF-A662-509648E6D297@bytedance.com>
 <CGME20230202095410uscas1p18ff39cc89400e3bbecfef9036887758a@uscas1p1.samsung.com>
 <20230202095402.0000585d@Huawei.com>
 <20230208163844.GA407917@bgt-140510-bm01>
 <7E864E85-A36F-487B-8B70-C8C49FBECD73@bytedance.com>
 <20230209221045.GA416928@bgt-140510-bm01>
To:     Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Feb 9, 2023, at 2:10 PM, Adam Manzanares <a.manzanares@samsung.com> =
wrote:
>=20
> On Wed, Feb 08, 2023 at 10:03:57AM -0800, Viacheslav A.Dubeyko wrote:
>>=20
>>=20
>>> On Feb 8, 2023, at 8:38 AM, Adam Manzanares =
<a.manzanares@samsung.com> wrote:
>>>=20
>>> On Thu, Feb 02, 2023 at 09:54:02AM +0000, Jonathan Cameron wrote:
>>>> On Wed, 1 Feb 2023 12:04:56 -0800
>>>> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>>>>=20
>>>>>>=20
>>=20
>> <skipped>
>>=20
>>>>>=20
>>>>> Most probably, we will have multiple FM implementations in =
firmware.
>>>>> Yes, FM on host could be important for debug and to verify =
correctness
>>>>> firmware-based implementations. But FM daemon on host could be =
important
>>>>> to receive notifications and react somehow on these events. Also, =
journalling
>>>>> of events/messages/events could be important responsibility of FM =
daemon
>>>>> on host.=20
>>>>=20
>>>> I agree with an FM daemon somewhere (potentially running on the BMC =
type chip
>>>> that also has the lower level FM-API access).  I think it is =
somewhat
>>>> separate from the rest of this on basis it may well just be talking =
redfish
>>>> to the FM and there are lots of tools for that sort of handling =
already.
>>>>=20
>>>=20
>>> I would be interested in particpating in a BOF about this topic. I =
wonder what
>>> happens when we have multiple switches with multiple FMs each on a =
separate BMC.
>>> In this case, does it make more sense to have an owner of the global =
FM state=20
>>> be a user space application. Is this the job of the orchestrator?
>>>=20
>>> The BMC based FM seems to have scalability issues, but will we hit =
them in
>>> practice any time soon.
>>=20
>> I had discussion recently and it looks like there are interesting =
points:
>> (1) If we have multiple CXL switches (especially with complex =
hierarchy), then it is
>> very compute-intensive activity. So, potentially, FM on firmware side =
could be not
>> capable to digest and executes all responsibilities without potential =
performance
>> degradation.
>> (2) However, if we have FM on host side, then there is security =
concerns because
>> FM sees everything and all details of multiple hosts and subsystems.
>> (3) Technically speaking, there is one potential capability that =
user-space FM daemon
>> can run as on host side as on CXL switch side. I mean here that if we =
implement
>> user-space FM daemon, then it could be used to execute FM =
functionality on CXL
>> switch side (maybe????). :)
>>=20
>> <skipped>
>>=20
>>>>>>>  - Manage surprise removal of devices =20
>>>>>>=20
>>>>>> Likewise, beyond reporting I wouldn't expect the FM daemon to =
have any idea
>>>>>> what to do in the way of managing this.  Scream loudly?
>>>>>>=20
>>>>>=20
>>>>> Maybe, it could require application(s) notification. Let=E2=80=99s =
imagine that application
>>>>> uses some resources from removed device. Maybe, FM can manage =
kernel-space
>>>>> metadata correction and helping to manage application requests to =
not existing
>>>>> entities.
>>>>=20
>>>> Notifications for the host are likely to come via inband means - so =
type3 driver
>>>> handling rather than related to FM.  As far as the host is =
concerned this is the
>>>> same as case where there is no FM and someone ripped a device out.
>>>>=20
>>>> There might indeed be meta data to manage, but doubt it will have =
anything to
>>>> do with kernel.
>>>>=20
>>>=20
>>> I've also had similar thoughts, I think the OS responds to =
notifications that
>>> are generated in-band after changes to the state of the FM are made =
through=20
>>> OOB means.
>>>=20
>>> I envision the host sends REDFISH requests to a switch BMC that has =
an FM
>>> implementation. Once the changes are implemented by the FM it would =
show up
>>> as changes to the PCIe hierarchy on a host, which is capable of =
responding to
>>> such changes.
>>>=20
>>=20
>> I think I am not completely follow your point. :) First of all, I =
assume that if host
>> sends REDFISH request, then it will be expected the confirmation of =
request execution.
>> It means for me that host needs to receive some packet that informs =
that request
>> executed successfully or failed. It means that some subsystem or =
application requested
>> this change and only after receiving the confirmation requested =
capabilities can be used.
>> And if FM is on CXL switch side, then how FM will show up the =
changes? It sounds for me
>> that some FM subsystem should be on the host side to receive =
confirmation/notification
>> and to execute the real changes in PCIe hierarchy. Am missing =
something here?
>=20
> Hopefully I have a point ;). I do expect a host to receive a response  =
for a
> given REDFISH request, but the request/response would be OOB. I would =
go back
> to the example of hot plugging in a PCIe based devices. For example if =
an nvme
> SSD is hot plugged, then the OS notified by HW that a new PCIe device =
has been
> added. Going back to changes made by the FM, if the changes impact the =
CXL
> hiearchy that is visible to a host, it is my expectation that the host =
OS will
> be informed of the changes requested of the FM when the host HW =
becomes aware
> of the changes (the in-band change).
>=20

You are right if we talk about hardware directly connected to the host. =
It means that
CPU (or any other hardware subsystem) can receive interrupt and kernel =
can process
this hardware change. But FM can be remote and be shared by multiple =
hosts.
In such case, we need to have some software subsystem on host(s) side =
that can
execute polling or expects to receive network packet with notification =
or confirmation
of the change. Or we need to have some hardware subsystem on every host =
that
can interact with remote FM in the background and issues the interrupt =
locally
with the goal to refresh kernel metadata.

Thanks,
Slava.

