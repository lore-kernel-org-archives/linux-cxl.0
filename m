Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68E5C05027
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 19:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjAZTFM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 14:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjAZTFL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 14:05:11 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5053C34
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 11:05:10 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 129so3262419ybb.0
        for <linux-cxl@vger.kernel.org>; Thu, 26 Jan 2023 11:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rGkhJmSyXGRAv7yUIkT+up2AFBL4prNC/7g/FTZVKM=;
        b=dJ1RVFuMJTrfuG8GWp3aIEWB/cLIb0RL9TkvOrjcSFBLXlMx3sW9Lgy7mbXo8aAG59
         eN//lbfI+RhFwzd+vCwOSpiOPza/GX9KTK6qFeOj6XGgLMReYlSesp/tYixYaXiv9ZjB
         fPSm+C3kZYSazvUMhBNCJh/nUVme2Ixk+5LB7uO2pLA5KjQ1bRIMP9Er39UbyEsX7+md
         e5X9E1ssKv2s6iYyzBhRS0EtwckPj+So67XaBT06S4TTuc0c55p3peHUn5nGkVTrGtGs
         0KqpEVpFnwjl+Xe1+C1Jpmle6LeacTY+202OkA6jTOMZ5c17XbLQhB27LW4i5SlcBHYT
         LMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rGkhJmSyXGRAv7yUIkT+up2AFBL4prNC/7g/FTZVKM=;
        b=NwJ9l/YKypSqoXWWOxCBHaqQRqQRSR11+2WJ+couo8rJljzwW4d82+bHGe/T22slPz
         6Z8pEMUpvlqUPRt0CG/c4/CVsW1rEoaIo01GwBBs0GFam6TAM5r3GmV0Rq+g4/WNCrsi
         8ajFzTkusnVoe32kGelr0SxdN8vm8Yn+pcbJ1gN1ORpjna3KpZNFxrzv3vGQGqrJuPWM
         /qUBAUtcesDF2e2X/WXkfiq+hDMuekU14T/BwDEGxLtM1IJm3HPayFkyit8mYEuYQ+FM
         9cWv60lLy7POIP5VE4FhC5A+gCUoJ03ZRqp4gyNEwAKyZzSinm5eVvegfr/2AOKjmszg
         SXfQ==
X-Gm-Message-State: AFqh2krH4wsvGuI1uq0dKe0N7Bg+z2FcL3ztFPxV5KZ1wN1GToL16CYf
        QTwVqq+VlXZf57tzcl+qHI0ZPw==
X-Google-Smtp-Source: AMrXdXsHIA6Pklm5FpldL3clK+R0KKU0s6iAW4CNncQuOb4DcoIWd5vcV9bzVf/mqCcFFwloKFH6sA==
X-Received: by 2002:a25:c58c:0:b0:70b:60af:d182 with SMTP id v134-20020a25c58c000000b0070b60afd182mr22200082ybe.39.1674759909321;
        Thu, 26 Jan 2023 11:05:09 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id j12-20020a05620a0a4c00b00706afbdeb01sm1426325qka.8.2023.01.26.11.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 11:05:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for CXL memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230126165810.GA354177@bgt-140510-bm01>
Date:   Thu, 26 Jan 2023 11:04:55 -0800
Cc:     David Rientjes <rientjes@google.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Fan Ni <fan.ni@samsung.com>,
        "ks0204.kim@samsung.com" <ks0204.kim@samsung.com>,
        "kim1158@gmail.com" <kim1158@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C14AC19-4D4C-49B4-85BA-BEA359D9FB3D@bytedance.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <CGME20230123055124uscas1p24ec9bf64b225fa5d943dd94ff70311ba@uscas1p2.samsung.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <20230123174553.GA341216@bgt-140510-bm01>
 <A1AF948D-C703-44E9-A668-602F9FE621C3@bytedance.com>
 <20230126165810.GA354177@bgt-140510-bm01>
To:     Adam Manzanares <a.manzanares@samsung.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Jan 26, 2023, at 8:58 AM, Adam Manzanares =
<a.manzanares@samsung.com> wrote:
>=20
> On Mon, Jan 23, 2023 at 10:30:34AM -0800, Viacheslav A.Dubeyko wrote:
>>=20
>>=20
>>> On Jan 23, 2023, at 9:46 AM, Adam Manzanares =
<a.manzanares@samsung.com> wrote:
>>>=20
>>> On Sun, Jan 22, 2023 at 09:51:19PM -0800, David Rientjes wrote:
>>>> On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
>>>>=20
>>>>> CC: LSF/MM/BPF mailing list. Sorry, missed the list.
>>>>>=20
>>>>>> On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko =
<viacheslav.dubeyko@bytedance.com> wrote:
>>>>>>=20
>>>>>> Hello,
>>>>>>=20
>>>>>> I believe CXL memory is hot topic now. I believe we have multiple =
topics
>>>>>> for discussion. I personally would like to discuss CXL Fabric =
Manager
>>>>>> and vision of FM architecture implementation. I am going to share =
the topic
>>>>>> in separate email. I would like to suggest a special session for =
CXL memory
>>>>>> related topics.
>>>>>>=20
>>>>>> How everybody feels about it?
>>>>>>=20
>>>>=20
>>>> I think this makes a lot of sense, thanks for suggesting it.
>>>>=20
>>>> Should this be a BoF or just a normal topic proposal?  I assume =
that there=20
>>>> could be several different topics of interest all related to =
CXL.mem.
>>>>=20
>>>=20
>>> +1 for a normal topic proposal.
>>=20
>> By the way, Samsung SMDK (memory development kit) suggested memory =
model
>> in user-space and kernel memory subsystem modification. I assume that =
we need
>> to discuss the memory model and kernel-space modification. So, it =
could be one of
>> the CXL related topic. Could we expect that Samsung guys deliver a =
talk?
>=20
> +Kyungsan Kim
>=20
> It is my understanding that Kyungsan, who is the lead for the SMDK =
project is=20
> interested in sharing with the community some lessons learned from =
working with=20
> CXL attached memory and a CFP is planned.=20
>=20

Sounds pretty great for me. :)

Thanks,
Slava.

