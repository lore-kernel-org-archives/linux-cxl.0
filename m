Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B8CC61D97
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 18:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbjA3SJI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjA3SJH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 13:09:07 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC665A3
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 10:09:04 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id p185so10780769oif.2
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 10:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhth2oFV7Evo8+1RvggAXk4T0fqlP3gd7k7PLyHC0Yc=;
        b=ym6zkKjZ0FPM8leo+MJBKcsiMXAHiBhh02cIPbmatLNWBvKajbToJni8+CXhGLP00O
         euR0aNWIiz5EP+coo40mdWBxaRSY3e8kIdP8QqZUECwuqjxQTiM0xAIyNi8AfWeNxQT1
         wGOKTfIQ4nVmFMhpMCu001a0c8iXTpkYvcSWKQHclrxFP+ypsQwWWIPkFvbNhn6kB2G5
         rB3moSRsaREjGEf31s8z92z12YOa0UjhQyXNRoaMDKCdYt9dBdhblAtluc0Ce3kH2soI
         I7x1oYPWnZhs0QmBJ1djaadODJglYcQPZDqh63d4pHFxKK6R+Q+Dd0tTV7oIxyoGNEoJ
         MoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhth2oFV7Evo8+1RvggAXk4T0fqlP3gd7k7PLyHC0Yc=;
        b=qjl79DgydxxM+D8SwZuPDpcl3DmgnA3h1CLMhQZtXpjSSZGS7ogYtNafXkPQ4+ulzt
         zPcWy7vfaw1S+AtmcGalUFpzrAQXDcpkkYtF37xinkCJ3MxFIhI4Hj7gW2mfCHA45of0
         ezMm620Y9WMCtCAJXKgC72AZJwb/akFaLMsHWueg3OTFIKgMrWVnizaItJWZeSSg+AjV
         L6rB6iyBoAi0fgBDvS+3SiCxBo0m/GUD0YXRX8kBJdIVf3syDT0yhpNysIznQcPl9o7z
         SNTH5xWnoUf/6/lo7sO9x42VgwotcC86m4vaIO4s1AKG3jTuTTxHiXId5geXfsFI0Lb8
         va0w==
X-Gm-Message-State: AO0yUKWN6ZHa/dqflTUUzL3QpggPBnG9Xv1JcqZyHF0Ghy1Q7xoBMLoo
        pL8OQ5ytF6YbNDfsSsHgfAFpBmTSFYy/5OxP
X-Google-Smtp-Source: AK7set/hzA7YLPOi5ZNZMk9AA/ukfoPg0bEwzoIyvzDJcHFEX8B4BihSkTE51WAmNLC/mqCaWxihJA==
X-Received: by 2002:a54:418e:0:b0:378:477c:3e0e with SMTP id 14-20020a54418e000000b00378477c3e0emr2334098oiy.45.1675102144072;
        Mon, 30 Jan 2023 10:09:04 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id 12-20020aca210c000000b0037874ef31a1sm492286oiz.51.2023.01.30.10.09.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jan 2023 10:09:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for CXL memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <CAARenASO6hTw+JX-JOau6mzhvkWr20Yw0GQnYjGhE2hi239woQ@mail.gmail.com>
Date:   Mon, 30 Jan 2023 10:08:51 -0800
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        David Rientjes <rientjes@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Fan Ni <fan.ni@samsung.com>, ks0204.kim@samsung.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <3399472D-3A0E-4FB2-AD37-1A85DB53891B@bytedance.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <CGME20230123055124uscas1p24ec9bf64b225fa5d943dd94ff70311ba@uscas1p2.samsung.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <20230123174553.GA341216@bgt-140510-bm01>
 <A1AF948D-C703-44E9-A668-602F9FE621C3@bytedance.com>
 <20230126165810.GA354177@bgt-140510-bm01>
 <8C14AC19-4D4C-49B4-85BA-BEA359D9FB3D@bytedance.com>
 <CAARenASO6hTw+JX-JOau6mzhvkWr20Yw0GQnYjGhE2hi239woQ@mail.gmail.com>
To:     MTK <kim1158@gmail.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Kyungsan,

> On Jan 28, 2023, at 5:45 PM, MTK <kim1158@gmail.com> wrote:
>=20
> Thank you Mr. Slava and Adam for introducing our research.
>=20
> If I was given an opportunity, I would like to share and discuss=20
> - A case of memory tiering solution for CXL memory, Samsung SMDK, =
which works across userspace and kernelspace : why and how
> - Some lessens learned from Industry while CXL integration
> - Proposal for possible Linux MM expansions for CXL memory
>=20
> Regarding FM topic, I'm also interested in what we should supports for =
CXL 3.0 and later topology.
>=20

Please, send the topic suggestion then. :) You can check LSF/MM/BPF CFP =
page for guidance.

Thanks,
Slava.

