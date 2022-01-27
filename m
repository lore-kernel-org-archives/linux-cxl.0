Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03565C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 11:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiA0Ln4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiA0Ln4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 06:43:56 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5BEC061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 03:43:55 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p15so5153656ejc.7
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 03:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2N9cN3h/UZ0Mx+yontKSZ6W8jCJoG/OyvT9j9ERzeeU=;
        b=SqHrleKW7mHYf01f1d8nxX03OHXGMR9oTw4lJ7yYBnSFjkNZZJapn20HwgtP03FSAJ
         etP0GuBaTTpqMTuN6vxYQddNbFvENeCktrd7uCGXJkpnubkk/JWPxXGV4qfxRSLrL7SC
         efYAf/h5YBHaFCZj2tRijNC0uLOfa5Yw3yfbgVaAP4Ub6ciSoq+o7lZIvEXFNPXde3mK
         KReVQgGUGofDYhmaW8RN2Zb076gfkWv1lWiMUrw/tpB4oc8lv5IUfqI+6npXPpwwlrXQ
         dpLytUbTJgjayUoTMrufaPhN28Fr2f2jvIjPCVWhitvMp+p9jdsqzb8wGfsAGoV2Wm9w
         aYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2N9cN3h/UZ0Mx+yontKSZ6W8jCJoG/OyvT9j9ERzeeU=;
        b=szsh4ac7c8l8Oc6k+JhcnXAQqRocVIqQBi7r/ZI4VLyg/nsjB8hN0eFeiVlhTTdylv
         F740XV2dFxXLJDZvEfLcHMRbVdMGVB6/BhyMhpIi9fvT1jEmQDj/beMq/+bgl8qYBqyj
         zM6PLRntTTrG4Sst3kH7JebgIN6hKmlZ6VJ2WMVTRms0JwDyXHXuVm6Oqivm0cXASpg4
         mSgTphnkC1zNQmra0dQVwH9uy3q9okcbAwdM218QaGqcNIi5TT2hGxY4ENxefgdIq/Cz
         m4eCyxBwV2fpYMlKRPM2sHX7i/yAX6ZhYay6hCrIG2VYKg0+mAE4fMrDApCqOWerqX0e
         F1Vg==
X-Gm-Message-State: AOAM533IwxIUCjIWJ0EdfJUZ0LoayPsl4c3nd+PY+6izXusmhSqVA5Mi
        o50FZ4c4V/BMNgqrH3rmml1VjA==
X-Google-Smtp-Source: ABdhPJxTIUV4T5ohOksd0JWN9v1WHYWW2CAyEsEulLdSrB5UwGfgkdQSOdBbnqqNSMPzitiShCmk/w==
X-Received: by 2002:a17:906:5d0a:: with SMTP id g10mr2517012ejt.37.1643283834397;
        Thu, 27 Jan 2022 03:43:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id lo15sm8554102ejb.28.2022.01.27.03.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:43:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id C2EC21FFB7;
        Thu, 27 Jan 2022 11:43:52 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-9-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.6; emacs 28.0.91
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 08/42] hw/cxl/device: Add cheap EVENTS implementation
 (8.2.9.1)
Date:   Thu, 27 Jan 2022 11:43:48 +0000
In-reply-to: <20220124171705.10432-9-Jonathan.Cameron@huawei.com>
Message-ID: <878rv1bdzb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> Using the previously implemented stubbed helpers, it is now possible to
> easily add the missing, required commands to the implementation.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
