Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1079C636D3
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 18:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjBHSEp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjBHSEn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 13:04:43 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD839B9A
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 10:04:14 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d7so6897732qvz.3
        for <linux-cxl@vger.kernel.org>; Wed, 08 Feb 2023 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF7M+Kj3n0+D3QyEmfqAMrT5IWsgyIgzncbmovOdPhI=;
        b=YQt7VUiE3eFSEFVaeUdNcB1FuoIgWysGFfLvmDD3t/ImN+bvSKA41/y7wy+oxAHQpY
         EYyOrs2l29SHFuR1GWTo8RvLw9t9pmr7nnUc98Zd9l8HnAlBY5LRPpeIiXkMMxwmcaBG
         20NRE5zi8QcDIeTUTzSI5uDkA1mL1PnRHX35tnxtZqeBUPg874Q8AtHuJdIPiHQG4pmw
         xoCXIBi+kC8cX0w2EhXZ4dhK9oOHi4mmxOfFtGJ/T5zSd0YfiISO6OPh+upkozeUfeHF
         bW6AvMqPYfkAMf25JdDvlwf+nxtgPVT1MRxb+sSLDFMSEwFO9KRiIITQAoxxk582hTms
         CEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF7M+Kj3n0+D3QyEmfqAMrT5IWsgyIgzncbmovOdPhI=;
        b=lA0ejqX0AMbiDW5bhXnX4yV2wpLWykxCk4DtMB94TrzJUBh109CIig3TdWrLx89THD
         gzlpDvYTDx+mU6gcTRZMAy6NKX9fEbM/HKAveCPxmGfuCcCDq9/bcBrLN794ScqsGQTp
         IBSuOCGJjMxjcZaE1TaAHSB22Ob26Ey9L5AnrFVOO4eAvYpjA2X69HX6aWbvjik1+MCr
         reeRbeGf1DGwJh4bjTZ7Wz6kIeEZJLy+6tK6X4/yI7+csoqcLICcbQ2MI9P89gkFDw1k
         aclcqVoK3Q6YE9cG4mTP7nebt6vPwQ5DI1yAkTfPzZx0YbN6bZGAXBljVLrslMfETlHS
         s2yA==
X-Gm-Message-State: AO0yUKWnWIv5zEhA6PYQksiPfQ2NjlaFUpmQLAvj3tfFmBwBI4pvgS5l
        TkTNjwoR1dXw6tX8hCOH9XW8UQ==
X-Google-Smtp-Source: AK7set94oQ93TcgiV4kB2SnWYkbxOL75GEa3U+AN9OGYy6F76zXtm1RRbjgjsNT/gUZJ8pZ8FXbrcw==
X-Received: by 2002:a0c:c683:0:b0:56c:1b8e:826e with SMTP id d3-20020a0cc683000000b0056c1b8e826emr2562806qvj.15.1675879450780;
        Wed, 08 Feb 2023 10:04:10 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id n2-20020a05620a294200b006f9ddaaf01esm12544061qkp.102.2023.02.08.10.04.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2023 10:04:10 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF TOPIC] CXL Fabric Manager (FM)
 architecture
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230208163844.GA407917@bgt-140510-bm01>
Date:   Wed, 8 Feb 2023 10:03:57 -0800
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E864E85-A36F-487B-8B70-C8C49FBECD73@bytedance.com>
References: <7F001EAF-C512-436A-A9DD-E08730C91214@bytedance.com>
 <20230131174115.00007493@Huawei.com>
 <5671D3B3-83B3-49FF-A662-509648E6D297@bytedance.com>
 <CGME20230202095410uscas1p18ff39cc89400e3bbecfef9036887758a@uscas1p1.samsung.com>
 <20230202095402.0000585d@Huawei.com>
 <20230208163844.GA407917@bgt-140510-bm01>
To:     Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Feb 8, 2023, at 8:38 AM, Adam Manzanares <a.manzanares@samsung.com> =
wrote:
>=20
> On Thu, Feb 02, 2023 at 09:54:02AM +0000, Jonathan Cameron wrote:
>> On Wed, 1 Feb 2023 12:04:56 -0800
>> "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com> wrote:
>>=20
>>>>=20

<skipped>

>>>=20
>>> Most probably, we will have multiple FM implementations in firmware.
>>> Yes, FM on host could be important for debug and to verify =
correctness
>>> firmware-based implementations. But FM daemon on host could be =
important
>>> to receive notifications and react somehow on these events. Also, =
journalling
>>> of events/messages/events could be important responsibility of FM =
daemon
>>> on host.=20
>>=20
>> I agree with an FM daemon somewhere (potentially running on the BMC =
type chip
>> that also has the lower level FM-API access).  I think it is somewhat
>> separate from the rest of this on basis it may well just be talking =
redfish
>> to the FM and there are lots of tools for that sort of handling =
already.
>>=20
>=20
> I would be interested in particpating in a BOF about this topic. I =
wonder what
> happens when we have multiple switches with multiple FMs each on a =
separate BMC.
> In this case, does it make more sense to have an owner of the global =
FM state=20
> be a user space application. Is this the job of the orchestrator?
>=20
> The BMC based FM seems to have scalability issues, but will we hit =
them in
> practice any time soon.

I had discussion recently and it looks like there are interesting =
points:
(1) If we have multiple CXL switches (especially with complex =
hierarchy), then it is
very compute-intensive activity. So, potentially, FM on firmware side =
could be not
capable to digest and executes all responsibilities without potential =
performance
degradation.
(2) However, if we have FM on host side, then there is security concerns =
because
FM sees everything and all details of multiple hosts and subsystems.
(3) Technically speaking, there is one potential capability that =
user-space FM daemon
can run as on host side as on CXL switch side. I mean here that if we =
implement
user-space FM daemon, then it could be used to execute FM functionality =
on CXL
switch side (maybe????). :)

<skipped>

>>>>>   - Manage surprise removal of devices =20
>>>>=20
>>>> Likewise, beyond reporting I wouldn't expect the FM daemon to have =
any idea
>>>> what to do in the way of managing this.  Scream loudly?
>>>>=20
>>>=20
>>> Maybe, it could require application(s) notification. Let=E2=80=99s =
imagine that application
>>> uses some resources from removed device. Maybe, FM can manage =
kernel-space
>>> metadata correction and helping to manage application requests to =
not existing
>>> entities.
>>=20
>> Notifications for the host are likely to come via inband means - so =
type3 driver
>> handling rather than related to FM.  As far as the host is concerned =
this is the
>> same as case where there is no FM and someone ripped a device out.
>>=20
>> There might indeed be meta data to manage, but doubt it will have =
anything to
>> do with kernel.
>>=20
>=20
> I've also had similar thoughts, I think the OS responds to =
notifications that
> are generated in-band after changes to the state of the FM are made =
through=20
> OOB means.
>=20
> I envision the host sends REDFISH requests to a switch BMC that has an =
FM
> implementation. Once the changes are implemented by the FM it would =
show up
> as changes to the PCIe hierarchy on a host, which is capable of =
responding to
> such changes.
>=20

I think I am not completely follow your point. :) First of all, I assume =
that if host
sends REDFISH request, then it will be expected the confirmation of =
request execution.
It means for me that host needs to receive some packet that informs that =
request
executed successfully or failed. It means that some subsystem or =
application requested
this change and only after receiving the confirmation requested =
capabilities can be used.
And if FM is on CXL switch side, then how FM will show up the changes? =
It sounds for me
that some FM subsystem should be on the host side to receive =
confirmation/notification
and to execute the real changes in PCIe hierarchy. Am missing something =
here?

Thanks,
Slava.

