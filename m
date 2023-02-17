Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F40FC636D6
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 18:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBQSbe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 13:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQSbd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 13:31:33 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A38E60F98
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 10:31:31 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e26so1726009qtq.6
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 10:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SOigeM+Gp/ahOyGEQbi37mkRzOoW10XOEAY5z6EQnI=;
        b=6/Mmh+8Po0OwD+/nkGBoEQv7fv+sX/el/UM8kGbEbaV5FxbDcjCTKlgZ+G3jwY8SkU
         kbWKDY7X8bHFw42U+LOhv22Al4F8Rb2mBh1GfdaiTEfByYa+W/6Px8Lk92zV5YuX8kGj
         V2IVx6ZxZznN/sSmaZ3TQUChFnPU1c5tNKW5LlxcsUIc1CCbMzaRBMfSP6doIg3TbhVg
         UdyrnYCsQoxml+FL4s0HPYkZa9CTsQtUu2WugMXKTrDgJwN5/2MB+wnsmAYDrI/GVWci
         M/nY17weXaSM+dwaXJjfJF0GnRWTXbkip96Mcuo14tWVzi0sWnQFyVyL2wJESQXAv0gz
         exDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SOigeM+Gp/ahOyGEQbi37mkRzOoW10XOEAY5z6EQnI=;
        b=0xjDQ+69TC0wxyy2fU9nc7BuvRKIGM10NDLDkjLlLgdcuhVRX4OoVW7CO2Cr9jk7pX
         50Yg2F1uh/FYwCa+F3hW8dxazAQv+ZTBQ/V1FFqcjGD+QqoA4dAq12HrQ8+gme9vdUVd
         DhGxPhJxLW4Fx3R6YyamaCqYoHak2G2fyuNg6whrzRFxaSlCapHKLJp1rJI/l8hlX77B
         10eBkPMH9GomX1vF4QQZ3nxIgcczmT1CcATlk2K5BzFk2M8An+OAhftQcme3qFz657Yn
         V8GagasSk2YXB1X+xhe3CTNUkgb9lY3dlIbWi0Eod8sG9VsL5ucZTTtGRl6PPMhntr+1
         TiFw==
X-Gm-Message-State: AO0yUKWah6Vq9VCJ8iFsxCA+Eq1fL2pm1wOllWqTCONhBzoFTj9Cw4Tl
        ANtlGXRH3nfe2xeBDalDxOfQmiXABb5hfjDu
X-Google-Smtp-Source: AK7set8tWa0yVrSPvvkOeHZGI6YxPzZ3iLrS/UNuAzWvaich+uaD4BIuB5/LqNBxpgDmiDGR+Zs+aA==
X-Received: by 2002:a05:622a:389:b0:3b8:385f:d72e with SMTP id j9-20020a05622a038900b003b8385fd72emr3936660qtx.48.1676658690554;
        Fri, 17 Feb 2023 10:31:30 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id a14-20020aed278e000000b003b8238114d9sm3713039qtd.12.2023.02.17.10.31.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2023 10:31:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] [LSF/MM/BPF TOPIC] CXL Fabric Manager (FM)
 architecture
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230210123257.000029a9@Huawei.com>
Date:   Fri, 17 Feb 2023 10:31:15 -0800
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EA73B59-7E5B-4FF6-9830-6C4C24FDDB6C@bytedance.com>
References: <7F001EAF-C512-436A-A9DD-E08730C91214@bytedance.com>
 <20230131174115.00007493@Huawei.com>
 <5671D3B3-83B3-49FF-A662-509648E6D297@bytedance.com>
 <CGME20230202095410uscas1p18ff39cc89400e3bbecfef9036887758a@uscas1p1.samsung.com>
 <20230202095402.0000585d@Huawei.com>
 <20230208163844.GA407917@bgt-140510-bm01>
 <7E864E85-A36F-487B-8B70-C8C49FBECD73@bytedance.com>
 <20230209110502.00001a7a@Huawei.com>
 <89DC75A8-0507-4AA1-B121-4AC398F615BC@bytedance.com>
 <20230210123257.000029a9@Huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Feb 10, 2023, at 4:32 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> On Thu, 9 Feb 2023 14:04:13 -0800
> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>=20
>>> On Feb 9, 2023, at 3:05 AM, Jonathan Cameron =
<Jonathan.Cameron@Huawei.com> wrote:
>>>=20
>>> On Wed, 8 Feb 2023 10:03:57 -0800
>>> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>>>=20
>>>>> On Feb 8, 2023, at 8:38 AM, Adam Manzanares =
<a.manzanares@samsung.com> wrote:
>>>>>=20
>>>>> On Thu, Feb 02, 2023 at 09:54:02AM +0000, Jonathan Cameron wrote:  =
 =20
>>>>>> On Wed, 1 Feb 2023 12:04:56 -0800
>>>>>> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>>>>>>=20
>>>>>>>>=20
>>>>=20
>>>> <skipped>
>>>>=20
>>>>>>>=20
>>>>>>> Most probably, we will have multiple FM implementations in =
firmware.
>>>>>>> Yes, FM on host could be important for debug and to verify =
correctness
>>>>>>> firmware-based implementations. But FM daemon on host could be =
important
>>>>>>> to receive notifications and react somehow on these events. =
Also, journalling
>>>>>>> of events/messages/events could be important responsibility of =
FM daemon
>>>>>>> on host.    =20
>>>>>>=20
>>>>>> I agree with an FM daemon somewhere (potentially running on the =
BMC type chip
>>>>>> that also has the lower level FM-API access).  I think it is =
somewhat
>>>>>> separate from the rest of this on basis it may well just be =
talking redfish
>>>>>> to the FM and there are lots of tools for that sort of handling =
already.
>>>>>>=20
>>>>>=20
>>>>> I would be interested in particpating in a BOF about this topic. I =
wonder what
>>>>> happens when we have multiple switches with multiple FMs each on a =
separate BMC.
>>>>> In this case, does it make more sense to have an owner of the =
global FM state=20
>>>>> be a user space application. Is this the job of the orchestrator? =20=

>>>=20
>>> This partly comes down to terminology. Ultimately there is an FM =
that is
>>> responsible for the whole fabric (could be distributed software) and =
that
>>> in turn will talk to a the various BMCs that then talk to the =
switches.
>>>=20
>>> Depending on the setup it may not be necessary for any entity to see =
the
>>> whole fabric.
>>>=20
>>> Interesting point in general though.  I think it boils down to =
getting
>>> layering in any software correct and that is easier done from =
outset.
>>>=20
>>> I don't know whether the redfish stuff is flexible enough to cover =
this, but
>>> if it is, I'd envision, the actual FM talking redfish to a bunch of =
sub-FMs
>>> and in turn presenting redfish to the orchestrator.
>>>=20
>>> Any of these components might run on separate machines, or in =
firmware on
>>> some device, or indeed all run on one server that is acting as the =
FM and
>>> a node in the orchestrator layer.
>>>=20
>>>>>=20
>>>>> The BMC based FM seems to have scalability issues, but will we hit =
them in
>>>>> practice any time soon.   =20
>>>=20
>>> Who knows ;)  If anyone builds the large scale fabric stuff in CXL =
3.0 then
>>> we definitely will in the medium term.
>>>=20
>>>>=20
>>>> I had discussion recently and it looks like there are interesting =
points:
>>>> (1) If we have multiple CXL switches (especially with complex =
hierarchy), then it is
>>>> very compute-intensive activity. So, potentially, FM on firmware =
side could be not
>>>> capable to digest and executes all responsibilities without =
potential performance
>>>> degradation. =20
>>>=20
>>> There is firmware and their is firmware ;)  It's not uncommon for =
BMCs to be
>>> significant devices in their own right and run Linux or other heavy =
weight OSes.
>>>=20
>>>> (2) However, if we have FM on host side, then there is security =
concerns because
>>>> FM sees everything and all details of multiple hosts and =
subsystems. =20
>>>=20
>>> Agreed. Other than testing I wouldn't expect the FM to run on a =
'host', but in
>>> at lest some implementations it will be running on a capable Linux =
machine.
>>> In large fabrics that may be very capable indeed (basically a server =
dedicated to
>>> this role).
>>>=20
>>>> (3) Technically speaking, there is one potential capability that =
user-space FM daemon
>>>> can run as on host side as on CXL switch side. I mean here that if =
we implement
>>>> user-space FM daemon, then it could be used to execute FM =
functionality on CXL
>>>> switch side (maybe????). :) =20
>>>=20
>>> Sure, anything could run anywhere.  We should draw up some =
'reference' architectures
>>> though to guide discussion down the line.  Mind you I think there =
are a lot of
>>> steps along the way and starting point should be a simple PoC where =
all the FM
>>> stuff is in linux userspace (other than comms).  That's easy enough =
to do.
>>> If I get a quiet week or so I'll hammer out what we need on =
emulation side to
>>> start playing with this.
>>>=20
>>> Jonathan
>>>=20
>>>=20
>>>=20
>>>>=20
>>>> <skipped>
>>>>=20
>>>>>>>>> - Manage surprise removal of devices     =20
>>>>>>>>=20
>>>>>>>> Likewise, beyond reporting I wouldn't expect the FM daemon to =
have any idea
>>>>>>>> what to do in the way of managing this.  Scream loudly?
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Maybe, it could require application(s) notification. Let=E2=80=99s=
 imagine that application
>>>>>>> uses some resources from removed device. Maybe, FM can manage =
kernel-space
>>>>>>> metadata correction and helping to manage application requests =
to not existing
>>>>>>> entities.   =20
>>>>>>=20
>>>>>> Notifications for the host are likely to come via inband means - =
so type3 driver
>>>>>> handling rather than related to FM.  As far as the host is =
concerned this is the
>>>>>> same as case where there is no FM and someone ripped a device =
out.
>>>>>>=20
>>>>>> There might indeed be meta data to manage, but doubt it will have =
anything to
>>>>>> do with kernel.
>>>>>>=20
>>>>>=20
>>>>> I've also had similar thoughts, I think the OS responds to =
notifications that
>>>>> are generated in-band after changes to the state of the FM are =
made through=20
>>>>> OOB means.
>>>>>=20
>>>>> I envision the host sends REDFISH requests to a switch BMC that =
has an FM
>>>>> implementation. Once the changes are implemented by the FM it =
would show up
>>>>> as changes to the PCIe hierarchy on a host, which is capable of =
responding to
>>>>> such changes.
>>>>>=20
>>>>=20
>>>> I think I am not completely follow your point. :) First of all, I =
assume that if host
>>>> sends REDFISH request, then it will be expected the confirmation of =
request execution.
>>>> It means for me that host needs to receive some packet that informs =
that request
>>>> executed successfully or failed. It means that some subsystem or =
application requested
>>>> this change and only after receiving the confirmation requested =
capabilities can be used.
>>>> And if FM is on CXL switch side, then how FM will show up the =
changes? It sounds for me
>>>> that some FM subsystem should be on the host side to receive =
confirmation/notification
>>>> and to execute the real changes in PCIe hierarchy. Am missing =
something here? =20
>>>=20
>>> Another terminology issue I think.  FM from CXL side of things is an =
abstract thing
>>> (potentially highly layered / distributed) that acts on instructions =
from an
>>> orchestrator (also potentially highly distributed, one =
implementation is hosts
>>> can be the orchestrator) and configures the fabric.
>>> The downstream APIs to the switches and EPs are all in FM-API (CXL =
spec)
>>> Upstream probably all Redfish.  What happens in between is impdef =
(though
>>> obviously mapping to Redfish or FM-API as applicable may make it =
more
>>> reuseable and flexible).
>>>=20
>>> I think some diagrams of what is where will help.
>>> I think we need (note I've always kept the controller hosts as =
normal hosts as well
>>> as that includes the case where it never uses the Fabric - so BMC =
type cases as
>>> a subset without needing to double the number of diagrams).
>>>=20
>>> 1) Diagram of single host with the FM as one 'thing' on that host - =
direct interfaces
>>>  to a single switch - interfaces options include switch CCI MB, mctp =
of PCI VDM,
>>>  mctp over say i2c.
>>>=20
>>> 2) Diagram of same as above, with a multiple head device all =
connected to one host.
>>>=20
>>> 3) Diagram of 1 (maybe with MHD below switches), but now with =
multiple hosts,
>>>  one of which is responsible for  fabric management.   FM in that =
manager host
>>>  and orchestrator) - agents on other hosts able to send requests for =
services to that host.
>>>=20
>>> 4) Diagram of 3, but now with multiple switches, each with separate =
controlling host.
>>>  Some other hosts that don't have any fabric control.
>>>  Distributed FM across the controlling hosts.
>>>=20
>>> 5) Diagram of 4 but with layered FM and separate Orchestrator.  =
Hosts all talk to the
>>>  orchestrator, that then talks to the FM.
>>>=20
>>> 6) 4, but push some management entities down into switches (from =
architecture point of
>>>  view this is no different from layered case with a separate BMC per =
switch - there
>>>  is still either a distribute FM or a layered FM, which the =
orchestrator talks to.)
>>>=20
>>> Can mess with exactly distribution of who does what across the =
various layers.
>>>=20
>>> I can sketch this lot up (and that will probably make some gaps in =
these cases apparent)
>>> but will take a little while, hence text descriptions in the =
meantime.
>>>=20
>>> I come back to my personal view though - which is don't worry too =
much at this early
>>> stage, beyond making sure we have some layering in code so that we =
can distribute
>>> it across a distributed or layered architecture later!  =20
>>>=20
>>=20
>> I had slightly more simplified image in my mind. :) We definitely =
need to have diagrams
>> to clarify the vision. But which collaboration tool could we use to =
work publicly on diagrams?
>> Any suggestion?
>=20
> Ascii art :)  To have a broad discussion it needs to be mailing list =
and that
> is effectively only option.
>=20

I tried to prepare some diagram based on ascii art. :) It looks pretty =
terrible in email:

----------------------------         ------------------
|  ---------       ------  |         |                |
|  | Agent | <---> | FM |  |         |                |
|  ---------       ------  |<------->|   CXL switch   |
|            Host          |         |                |
|                          |         |                |
----------------------------         =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94

I think we need to use some online resource, anyway. We are discussing =
with Adam what we
can do here.

You introduced Orchestrator entity. I realized that I am not completely =
follow the responsibility
of this subsystem. Do you imply some central point of management of =
multiple FM instances?
Something like a router that has knowledge base and can redirect the =
request to proper FM
instance. Am I correct? It sounds to me that orchestrator needs to =
implement some
sub-API of FM. Or, maybe, it needs to parse REDFISH packets, for =
example, and only
redirects the packets.

Thanks,
Slava.
=20=
