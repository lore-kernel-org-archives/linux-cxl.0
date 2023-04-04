Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0FEC6FD1D
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Apr 2023 21:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjDDVJp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 4 Apr 2023 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDDVJo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 4 Apr 2023 17:09:44 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB791734
        for <linux-cxl@vger.kernel.org>; Tue,  4 Apr 2023 14:09:18 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id cu4so24975777qvb.3
        for <linux-cxl@vger.kernel.org>; Tue, 04 Apr 2023 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680642558; x=1683234558;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2JNoT5A3zpIgQHs9Kbz57lZw1UiuEoQ6fylZEBtymY=;
        b=XWiCM8gFxm3oq2a6moSMkkMk6X/ShvPDWip+ctZ0eEgRG1P8Fo4tvKepmno5aioT+H
         rp3TyI3aQgxpU0e2vM5cKJ8L1kx4930mRnpbVoalkJLAKbkVIQ+JEbBqQO/NolSZnmdU
         dkhV4iUQlvtSrVX5Vu2Qii8gHtMbYxmxKesatR891rF6co5WSWjaPjgd7Vp6RE/z+S4D
         sQf1OpImqtHlw2aUgJjHbB39RNNR7g2XxjGIFK6f6EgC26poRIh0q15tcYT2vbPJx5M3
         Amc9P1l2I6ni91ANzWWGohZfpqdzLmxUS/l8elcWXF5YMeqjBAMEVSEgGaGallblu9Pp
         5SSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642558; x=1683234558;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2JNoT5A3zpIgQHs9Kbz57lZw1UiuEoQ6fylZEBtymY=;
        b=qy58p3cV5FsfZ6jEHwIGMzcX3/g00UC7lt0xNb793pnz1pSf1ts8yaJbUy7AKEyi1+
         cHXGcnNUyfQbRlIoDAJup31/gqVlyX2Vj7/Vir0kVTIhQdMPbbHX/ZAE+d2GxLSDI4jb
         6bO2m2T9b9czQdc6j3KoSxtzdpnxTUpWQ7CQl15vdJu6iyhJZbD0X5x1T3QpjKuDU3s3
         wOhmx9TvI0Jk4wLKFk8u1JRCMlQvdGbENteRW5jB9WaSclWLcRkhiWjk/rQ9iQcm4Pwy
         yxCs9YyUn5qftO/3I+9RA1Rn5dFjd8V5F3jrqeGYSwWNOOAIct7G47/DWvQ3tKKl4YDS
         7ZaA==
X-Gm-Message-State: AAQBX9e5emY1hIrUzUtVNBvHyAt7X+0mkRixPEbGdb/4A/K2azmH1+kJ
        7PWYiJy/MEeXK9O9+aUg99hhdQ==
X-Google-Smtp-Source: AKy350aJx3/Yq4mFTh+fAUblqwl9Aw93NKCtrOL/zeep7ssRyt7SXJjL8ss2WiTYDRZm2FBtLW/Eqw==
X-Received: by 2002:a05:6214:c81:b0:5e0:f92c:4558 with SMTP id r1-20020a0562140c8100b005e0f92c4558mr5677194qvr.10.1680642557870;
        Tue, 04 Apr 2023 14:09:17 -0700 (PDT)
Received: from smtpclient.apple (ec2-52-9-159-93.us-west-1.compute.amazonaws.com. [52.9.159.93])
        by smtp.gmail.com with ESMTPSA id 21-20020a370415000000b0074683c45f6csm3907764qke.1.2023.04.04.14.09.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2023 14:09:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes
 for CXL
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <ZCgasNpBjtQje8k+@memverge.com>
Date:   Tue, 4 Apr 2023 14:09:04 -0700
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "seungjun.ha@samsung.com" <seungjun.ha@samsung.com>,
        "wj28.lee@samsung.com" <wj28.lee@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C539716C-B936-4AC6-814D-8DB6C44C81F2@bytedance.com>
References: <ZB/yb9n6e/eNtNsf@kernel.org>
 <CGME20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8@epcas2p2.samsung.com>
 <20230331114525.400375-1-ks0204.kim@samsung.com>
 <ZCvgTA5uk/HcyMAk@kernel.org> <20230404175754.GA633356@bgt-140510-bm01>
 <ZCgMlc63gnhHgwuD@memverge.com>
 <D0C2ADD0-35C4-4BE4-9330-A81D7326A588@bytedance.com>
 <ZCgasNpBjtQje8k+@memverge.com>
To:     Gregory Price <gregory.price@memverge.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Apr 1, 2023, at 4:51 AM, Gregory Price <gregory.price@memverge.com> =
wrote:
>=20
> On Tue, Apr 04, 2023 at 11:59:22AM -0700, Viacheslav A.Dubeyko wrote:
>>=20
>>=20
>>> On Apr 1, 2023, at 3:51 AM, Gregory Price =
<gregory.price@memverge.com> wrote:
>>>=20
>>> On Tue, Apr 04, 2023 at 05:58:05PM +0000, Adam Manzanares wrote:
>>>> On Tue, Apr 04, 2023 at 11:31:08AM +0300, Mike Rapoport wrote:
>>>>>=20
>>>>> The point of zswap IIUC is to have small and fast swap device and
>>>>> compression is required to better utilize DRAM capacity at expense =
of CPU
>>>>> time.
>>>>>=20
>>>>> Presuming CXL memory will have larger capacity than DRAM, why not =
skip the
>>>>> compression and use CXL as a swap device directly?
>>>>=20
>>>> I like to shy away from saying CXL memory should be used for swap. =
I see a=20
>>>> swap device as storing pages in a manner that is no longer directly =
addressable
>>>> by the cpu.=20
>>>>=20
>>>> Migrating pages to a CXL device is a reasonable approach and I =
believe we
>>>> have the ability to do this in the page reclaim code.=20
>>>>=20
>>>=20
>>> The argument is "why do you need swap if memory itself is elastic", =
and
>>> I think there are open questions about how performant using large
>>> amounts of high-latency memory is.
>>>=20
>>> Think 1us-1.5us+ cross-rack attached memory.
>>>=20
>>> Does it make sense to use that as CPU-addressible and migrate it on
>>> first use?  Isn't that just swap with more steps?  What happens if =
we
>>> just use it as swap, is the performance all that different?
>>>=20
>>> I think there's a reasonable argument for exploring the idea at the
>>> higher ends of the latency spectrum.  And the simplicity of using an
>>> existing system (swap) to implement a form of proto-tiering is =
rather
>>> attractive in my opinion.
>>>=20
>>=20
>> I think the problem with swap that we need to take into account the =
additional
>> latency of swap-in/swap-out logic. I assume that this logic is =
expensive enough.
>> And if we considering the huge graph, for example, I am afraid the =
swap-in/swap-out
>> logic could be expensive. So, the question here is about use-case. =
Which use-case could
>> have benefits to employ the swap as a big space of high-latency =
memory? I see your point
>> that such swap could be faster than persistent storage. But which =
use-case can be happy
>> user of this space of high-latency memory?
>>=20
>> Thanks,
>> Slava.
>>=20
>=20
> Just spitballing here - to me this problem is two fold:
>=20
> I think the tiering use case and the swap use case are exactly the =
same.
> If tiering is sufficiently valuable, there exists a spectrum of =
compute
> density (cpu:dram:cxl:far-cxl) where simply using far-cxl as fast-swap
> becomes easier and less expensive than a complex tiering system.
>=20
> So rather than a single use-case question, it reads like a tiering
> question to me:
>=20
> 1) Where on the 1us-20us (far cxl : nvme) spectrum does it make sense =
to
>   switch from a swap mechanism to simply byte-addressable memory?
>   There's a point, somewhere, where promote on first access =
(effectively
>   swap) is the same performance as active tiering (for a given =
workload).
>=20
>   If that point is under 2us, there's a good chance that a =
high-latency
>   CXL swap-system would be a major win for any workload on any =
cloud-based
>   system.  It's simple, clean, and reclaim doesn't have to worry about =
the
>   complexities of hotpluggable memory zones.
>=20
>=20
> Beyond that, to your point, what use-case is happy with this class of
> memory, and in what form?
>=20
> 2) This is likely obscurred by the fact that many large-memory
>   applications avoid swap like the plague by sharding data and =
creating
>   clusters. So it's hard to answer this until it's tested, and you
>   can't test it unless you make it... woo!
>=20
>   Bit of a chicken/egg in here.  I don't know that anyone can say
>   definitively what workload can make use of it, but that doesn't mean
>   there isn't one.  So in the spectrum of risk/reward, at least
>   enabling some simple mechanism for the sake of exploration feels
>   exciting to say the least.
>=20
>=20
> More generally, I think a cxl-swap (cswap? ;V) would be useful exactly =
to
> help identify when watch-and-wait tiering becomes more performant than
> promote-on-first-use.  If you can't beat a simple fast-swap, why =
bother?
>=20
> Again, I think this is narrowly applicable to high-latency CXL. My gut
> tells me that anything under 1us is better used in a byte-addressable
> manner, but once you start hitting 1us "It makes me go hmmm..."
>=20
> I concede this is largely conjecture until someone tests it out, but
> certainly a fun thing to discess.
>=20

OK. I am buying your point. :) But, at first I need to allocate memory.
The really important point of CXL memory is the opportunity to extend
the memory space. So, swap is not addressable memory and it is useless
for memory space extension. Let=E2=80=99s imagine I have small local =
DRAM (and
maybe some amount of =E2=80=9Cfast=E2=80=9D CXL) + huge far CXL as swap =
space. But I cannot
use the swap space for allocation. So, this swap looks like useless =
space.
At first, I need to extend my memory by means of =E2=80=9Cfast=E2=80=9D =
CXL. And if I have
enough =E2=80=9Cfast=E2=80=9D CXL, then I don=E2=80=99t need in far CXL =
memory. OK, it=E2=80=99s always
not enough memory but we are hungry for addressable memory.

Large memory application would like to see the whole data set in memory.
But it means that this data set needs to be addressable. Technically =
speaking,
it is possible to imagine that partially data set can be in the swap.
But the first step is memory allocation and prefetching data from =
persistent
memory. Bus, as far as I can imagine, memory allocator will be limited =
by
addressable memory. So, I cannot have the whole data set in memory =
because
memory allocator stops me.

Thanks,
Slava.

