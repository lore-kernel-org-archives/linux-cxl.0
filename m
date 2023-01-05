Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C943FC54E76
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 02:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjAECLs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 21:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAECLr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 21:11:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD3C3C;
        Wed,  4 Jan 2023 18:11:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29BD5B818C0;
        Thu,  5 Jan 2023 02:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5123C433F0;
        Thu,  5 Jan 2023 02:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672884703;
        bh=WikqvB81sbI4yD5Fle5R/1qidHqXw3OMFbIXoN7Oqu8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sdvwNqfO3gxvtO6ov+cbDxWxHtNWowodmlWLw+5zqfosMBqfvdo5dzJ+dTWaYgpEn
         EC/mE/AG1TDQeGtr7k1t1wyy1FZtNDc59fRWvaQW3b26We9F5diue3mAgzPkVY8qhz
         G3LdB6l0/2/+PfPPQ0leQfGPqYdxxMO55bjLPip2OYG0l5DWVAp74gWi/GdxIo5dme
         5qm7mDtfC6nY4xyuh8IfH/34+4n28dvJ1pcM0uY483u4H2NlZEjp22am6lMUgOMiSf
         eEiZ4RzR+CYzXtO6/RJb5synkHqcdh2QP9aWZm6eLty5prurYNB5Ilbl56fRHqyqjo
         chVYhA+1Q2iSQ==
Received: by mail-oo1-f43.google.com with SMTP id d9-20020a4aa589000000b004af737509f4so6835035oom.11;
        Wed, 04 Jan 2023 18:11:43 -0800 (PST)
X-Gm-Message-State: AFqh2kqvEkWSEZFDt7d7Sg9R2ehJm+2J+tu7vXgfGbNlEsauBsY3Q+2P
        Rj+HRWVRK3tl6IV1sJy6Pznv5vGgY239Vm8ufXc=
X-Google-Smtp-Source: AMrXdXtRwe4YbedyvtyWU1D/YNQp5PeJWp/CF7Lp1/K7gkRce6kg2VlIC3YWaR6Li7Wg12l00gCAiwYEhsjuC+acWV4=
X-Received: by 2002:a4a:a34c:0:b0:4a0:31ba:82bb with SMTP id
 u12-20020a4aa34c000000b004a031ba82bbmr2323587ool.96.1672884703251; Wed, 04
 Jan 2023 18:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20221214231718.1002194-1-mcgrof@kernel.org> <Y5vvVTwt+FfxTUke@bergen.fjasle.eu>
 <Y7XStqJcM3wYxUXf@bombadil.infradead.org>
In-Reply-To: <Y7XStqJcM3wYxUXf@bombadil.infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 Jan 2023 11:11:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS4SGV8-tYnfLd3BDvJP_ZVz9_Yx-MWCD3mXBqJ0-jzuw@mail.gmail.com>
Message-ID: <CAK7LNAS4SGV8-tYnfLd3BDvJP_ZVz9_Yx-MWCD3mXBqJ0-jzuw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Modify default INSTALL_MOD_DIR from extra to updates
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, nathan@kernel.org,
        ndesaulniers@google.com, linux-kbuild@vger.kernel.org,
        alison.schofield@intel.com, dan.j.williams@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com,
        lucas.de.marchi@gmail.com, linux-cxl@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 5, 2023 at 4:25 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Dec 16, 2022 at 05:08:53AM +0100, Nicolas Schier wrote:
> > Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
>
> I've queued this onto modules-next.
>
>   Luis


Acked-by: Masahiro Yamada <masahiroy@kernel.org>

-- 
Best Regards
Masahiro Yamada
