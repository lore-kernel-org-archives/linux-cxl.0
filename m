Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C0C77B61
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Apr 2023 17:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDJRrG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Apr 2023 13:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJRrF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Apr 2023 13:47:05 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5990C171D
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 10:47:04 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54c17fa9ae8so211329937b3.5
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681148823; x=1683740823;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rtR1KQ3AqrOVvZCzQlb6jCWmGPQKc6qNmt9LztgmJM=;
        b=BqbhM9JMvMAyMmkt7kMrlBFKSDVBInnQ1LH97f8g/RNriLbcr9kGlvFiM3kFx9p7kT
         k3DElh125L3hk2n0Oq02XuS+WiFPPfz0sSvZSZ84yCA5Q/wQj7MLaoqC8WAYECZWqgFE
         JSf9VFkalZBIIBX9YFvNBWPWX2cdfo/TkEn0UoNVO+xtFEtGHOH0XKmzqb8P4icODO1r
         x5e/JsFjPI6CcwCQvS03Z2iXtfZ/bbrsxDUvjd5Qy2UbfhXhGdaOKZK6C4OSB1AEcPif
         y9wkz7D60qzPGCDFFz25BUfeOgY+OEGzm2lpZweBi4Dg1IUn85XAOaKhriu84dKvF5Ho
         STXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681148823; x=1683740823;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rtR1KQ3AqrOVvZCzQlb6jCWmGPQKc6qNmt9LztgmJM=;
        b=j0RCn/A5Xd5Y80D6wwoBxbKYIhuoKjRPigCfk1qOTwFj1V+OtmW6RGiGjRM5Q53dxq
         OIJle0vY+eyedEhOlPzKQGJ3xT2G4UqUc0tZMASVvmKi8K/Xho7t72ESUNdzFHeorA9c
         pntSTFWRH+888B6U9kTIIWTko+ZvsNNTyju4lP1qb12Qvmiw/cMj3syeuL/wU+rBlHxU
         vlJP8GHrabvLqurLz1w6v1uSdvPRdh3UeA+tzaLk6U6h7gJpb/Zvm9P3EnMhbZAeKEo6
         7/jIC+jKgyU0QveIEEM1lPWVU/6XnyTwoU6Ct7RHRt58YxW7y422K0juxGILKVTiVvZP
         FsuQ==
X-Gm-Message-State: AAQBX9d+jFakGnAZSIrBOPfzPk3MCXAABW7T1zEUMK5QJlkS6+L1/KPi
        bPOECzKzQF84u3eRINOgNNzBMg==
X-Google-Smtp-Source: AKy350ZDxReVUeZGSiN9OtREAUcY12spdX+6/+Rz+W9m1AdQN2kfh2aFaMblSkdCUrERM6FGfbByAw==
X-Received: by 2002:a81:4890:0:b0:54f:3322:cbec with SMTP id v138-20020a814890000000b0054f3322cbecmr210620ywa.28.1681148823539;
        Mon, 10 Apr 2023 10:47:03 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id 80-20020a811453000000b00545a0818480sm2968877ywu.16.2023.04.10.10.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2023 10:47:03 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] [LSF/MM/BPF TOPIC] BoF VM live migration over CXL
 memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230410030532.427842-1-ks0204.kim@samsung.com>
Date:   Mon, 10 Apr 2023 10:46:50 -0700
Cc:     dragan@stancevic.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-cxl@vger.kernel.org,
        Adam Manzanares <a.manzanares@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        seungjun.ha@samsung.com, wj28.lee@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1DEC12D4-9D85-4AC1-BEE5-92E7E8189C2D@bytedance.com>
References: <5d1156eb-02ae-a6cc-54bb-db3df3ca0597@stancevic.com>
 <CGME20230410030532epcas2p49eae675396bf81658c1a3401796da1d4@epcas2p4.samsung.com>
 <20230410030532.427842-1-ks0204.kim@samsung.com>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Apr 9, 2023, at 8:05 PM, Kyungsan Kim <ks0204.kim@samsung.com> =
wrote:
>=20
>> Hi folks-
>>=20
>> if it's not too late for the schedule...
>>=20
>> I am starting to tackle VM live migration and hypervisor clustering =
over
>> switched CXL memory[1][2], intended for cloud virtualization types of =
loads.
>>=20
>> I'd be interested in doing a small BoF session with some slides and =
get
>> into a discussion/brainstorming with other people that deal with =
VM/LM
>> cloud loads. Among other things to discuss would be page migrations =
over
>> switched CXL memory, shared in-memory ABI to allow VM hand-off =
between
>> hypervisors, etc...
>>=20
>> A few of us discussed some of this under the ZONE_XMEM thread, but I
>> figured it might be better to start a separate thread.
>>=20
>> If there is interested, thank you.
>=20
> I would like join the discussion as well.
> Let me kindly suggest it would be more great if it includes the data =
flow of VM/hypervisor as background and kernel interaction expected.
>=20

Sounds like interesting topic to me. I would like to attend the =
discussion.

Thanks,
Slava.

>>=20
>>=20
>> [1]. High-level overview available at http://nil-migration.org/
>> [2]. Based on CXL spec 3.0
>>=20
>> --
>> Peace can only come as a natural consequence
>> of universal enlightenment -Dr. Nikola Tesla

