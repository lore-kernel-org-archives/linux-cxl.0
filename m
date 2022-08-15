Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A7AC00140
	for <linux-cxl@archiver.kernel.org>; Mon, 15 Aug 2022 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiHOPHx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiHOPHw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 11:07:52 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02A11440
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 08:07:51 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3321c2a8d4cso26509077b3.5
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xk3D0qnFEv6Js9SIYN+NeNUNen8iIiMti5KqnenDtCI=;
        b=ZH6i/Urv/InUOrTukcha3fE+bZS6aGdaVCDDgASyKAGXLUOVK7zkPfMTgD+q1XiYKe
         XpceXTzpGn6Oea5qDcf5Ku1txwNGqT7OQ0Zf4YN5VjDGBEss5z6tqHyWiU3rkow5pML1
         h9jrAC2reqibXLrKNZYLy6DyZqSjrtT5v/+ruaQVyLhJcnQKQtaPk8N8bkDBA86gD+tW
         hgH95iVJI0KZaudcu0+/KZDaZvLv+NmDN85pFcZMRIriggIhe07Dy+Yq3dFK1Xt4U827
         R8ixwyUW4xU/DkofqSF+jWfGZZjyunonJ8gAoByp4uh5rEU3k3kJ2DVzyN8qu8IrLOqP
         XMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xk3D0qnFEv6Js9SIYN+NeNUNen8iIiMti5KqnenDtCI=;
        b=DdJESbhchg0+TKw+51CcdPe7Vco9yVkvfMEijW/ApJRfSRT+oMZvt+oStdKJHRZiVM
         8dylMXYQG8ukeM1o7OacyrePgb1KkQxGRvXBSG/E2c9OBCL55gNJSXIK09OTSopIUJ73
         QdKY7KLdxLoOuErr1ddGGEIi8TurUnwu6mHhnb93Gux6nVXIEaiXyz3Ok6ZPf1MVLL4L
         xYgGGFOPzLeouZkNARM6j1+OrQyMTMF08pUXr9P0MdZPISf0FiRfy2lvCSz6aA6WAVKG
         xYyKuD7LgiEV8lnDvimuwAIyoscfhBzJvkfBQt3g/xSIeJxDK3fWAPeFFieY6DqR4Fkt
         /aSg==
X-Gm-Message-State: ACgBeo1tGgXhr9qk+GSNfBj7iYA8dHQdYXNPs3LUeLdcP8lTaPbRDew/
        xAtMpgYNxhMGotjbAFoBf+x6MSBtgnPdBex4bX8G+g==
X-Google-Smtp-Source: AA6agR4L9eBhYf/u6xcB6hHHOL1HXUayoG7nN0as29bQs6+piWi4PvaXa5/6/kh0erO8HDYmskZS0QDSiqEPNGAF690=
X-Received: by 2002:a25:d4a:0:b0:671:6d11:d14e with SMTP id
 71-20020a250d4a000000b006716d11d14emr12595202ybn.479.1660576070236; Mon, 15
 Aug 2022 08:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
 <20220808133727.00001171@huawei.com> <CAGr_yG36GSO8esyO9nn6OeOEN5zPSosEmBHbfYGwqNGiYOh9vw@mail.gmail.com>
 <20220809170825.00001b61@huawei.com> <20220811180857.00005e67@huawei.com>
 <20220812164403.00001654@huawei.com> <62f679b67828f_992102942@dwillia2-xfh.jf.intel.com.notmuch>
 <20220812171509.00006034@huawei.com> <20220815151809.0000294c@huawei.com> <20220815155516.00007ebf@huawei.com>
In-Reply-To: <20220815155516.00007ebf@huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 15 Aug 2022 16:07:09 +0100
Message-ID: <CAFEAcA-W-xnm_H_qo_YJXY0Ve75DCMH8WQkZh_AWU1RF3JQcwA@mail.gmail.com>
Subject: Re: [BUG] cxl can not create region
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bobo WL <lmw.bobo@gmail.com>, linux-cxl@vger.kernel.org,
        qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 15 Aug 2022 at 15:55, Jonathan Cameron via <qemu-arm@nongnu.org> wrote:
> In the interests of defensive / correct handling from QEMU I took a
> look into why it was crashing.  Turns out that providing a NULL write callback for
> the memory device region (that the above overlarge write was spilling into) isn't
> a safe thing to do.  Needs a stub. Oops.

Yeah. We've talked before about adding an assert so that that kind of
"missing function" bug is caught at device creation rather than only
if the guest tries to access the device, but we never quite got around
to it...

-- PMM
