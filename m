Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19009C001DB
	for <linux-cxl@archiver.kernel.org>; Sat,  2 Sep 2023 14:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjIBO7N (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 2 Sep 2023 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjIBO7L (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 2 Sep 2023 10:59:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958661706
        for <linux-cxl@vger.kernel.org>; Sat,  2 Sep 2023 07:59:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso130635e87.0
        for <linux-cxl@vger.kernel.org>; Sat, 02 Sep 2023 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693666747; x=1694271547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SABuL+uXgGmHiLnH+elbso2HPH3mPzksBTp/wYBICw=;
        b=OSiyzrw6cYYoeQv+dMpacWaFzjU2dTi5fedgEqMglFRZG9zpAhxvvrDhyEHZ3CH6sp
         Fm/9K15TDWD21HRUL09qwRwOF/vmcDg/quzVviQLAFF4Z21aDPjKoSc6ZbK9KNjPmNgO
         qcdl0zTqD+RIpWgeh70pRTxKif5qjrMTn3aj8NWb5CjnW5mvzW4YAu0yk/neJ7Tn6/Mo
         bjXztVyZRsGVQ54cBqs9I3xjkv/IeTqFRscmGC/Ks0gHYRRAGZhgGvD61WWfsUAq/xMQ
         3ecykQ1R7c4Yg/d28ObUW9xjbcqsbtU5cW6A+0uQozYrACz7iSIeU8TgMGUP8DFQkaiP
         xi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693666747; x=1694271547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SABuL+uXgGmHiLnH+elbso2HPH3mPzksBTp/wYBICw=;
        b=YDpDuLKX0x+vpNh2sE/hzeh85K4JILwlIvRVHzF+ZqVS1zjj6akdW4KtO6ZvibWGLC
         npka4No8KSA0pHyKcNLt9Vj+Vp1GqPOTOutbU6DNHGSO/ZAnQtEcWBS6KOyd2OqELrnw
         W/8Z5cQgtGNbLmH24rnUw+wizL5JE6NPXsSml/uXrOWwBzB02klCxYzVE3G8DWQgLhjZ
         bd4mlzhLvLViBUdrUL8E/UVFz2jqms1ZKcECH+FvNV1kqre97odglwtohT8moYuFmarv
         L2hRFNPRsYaYFfOgCznOSzV2UzTugk59SHQ7xS+9wCj+Q5PFPGwPAaDjvxX+4ulU4fWZ
         yn8A==
X-Gm-Message-State: AOJu0YxXOsGyoe08ara0BzaPx8E2MydMEiBzLHnNdSeFbpmJdppt8Q0F
        gyyBcQsZYzvc5HieMtBVfNoT/IALm13VdKA2C6I=
X-Google-Smtp-Source: AGHT+IFQJqQWncz3TENfeZbuaKfTJwAyqywFmzhoZQ8XEQzLc+vMw2gvwRrs+0glGFeflATEOQC+hr4e2EqGkL2Hobo=
X-Received: by 2002:a05:6512:15a3:b0:4fe:15b5:a5f9 with SMTP id
 bp35-20020a05651215a300b004fe15b5a5f9mr4051890lfb.54.1693666746539; Sat, 02
 Sep 2023 07:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAEvOrRz9s8CumbuMbkCU+eCHgAp20X6q0i1D6fi5vfa5_F6JnA@mail.gmail.com>
 <20230810173322.0000543c@Huawei.com> <CAEvOrRyvaFBzhzP7kxWeCpYY-u5wjwAo6076FGhN_k-+NadUDA@mail.gmail.com>
 <CAEvOrRzPNwNFrg4Brw7axzgxv6WFeYr0rnsDGmSSNpn9hca-3Q@mail.gmail.com>
 <20230811145223.000040de@Huawei.com> <CAEvOrRzE76U2g_8=V3F-4fqwosRz3n9kO+40E_iG74EcbQBxtw@mail.gmail.com>
 <20230823180323.000052d5@Huawei.com> <CAEvOrRyquLL6-d=vOyB9NNOPVE370qjV0zu8XBsTJmpOBx2UNw@mail.gmail.com>
 <ZPHyoJsZDnzpU7C4@memverge.com> <CAEvOrRw2e3cn=2fNXO8_iX0kg09an-OSx1fnjx7ciGGhZo9f9A@mail.gmail.com>
 <CAEvOrRy9qoydCqxq7xv1QNM+z+YQZyQORtqdDU2VcVKP42CJhA@mail.gmail.com> <SJ0PR17MB5512449C5FFD76AD50B3D3AF83E4A@SJ0PR17MB5512.namprd17.prod.outlook.com>
In-Reply-To: <SJ0PR17MB5512449C5FFD76AD50B3D3AF83E4A@SJ0PR17MB5512.namprd17.prod.outlook.com>
From:   Ravi Kanth <mvrravikanth@gmail.com>
Date:   Sat, 2 Sep 2023 20:28:54 +0530
Message-ID: <CAEvOrRwOWT5HuoUsjkUyt6HpXQhWVR2Hv6cxJPP+4+0xNQpM8g@mail.gmail.com>
Subject: Re: Support for CXL v3.0 spec with QEMU
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Sajjan Rao <sajjanr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ok. Got it. Thanks Gregory.

Ravi

On Fri, Sep 1, 2023 at 10:07=E2=80=AFPM Gregory Price
<gregory.price@memverge.com> wrote:
>
>
> > However we saw the below crash when we sent the command for the first t=
ime.
>
> That's expected, there's an explicit warning the first time a raw command=
 is sent.   This is intended behavior, no crash has occurred.



--=20
Ravi
