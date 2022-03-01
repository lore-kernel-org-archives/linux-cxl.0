Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0189C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 17:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiCARqN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiCARqN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Mar 2022 12:46:13 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9943D2AC6C
        for <linux-cxl@vger.kernel.org>; Tue,  1 Mar 2022 09:45:31 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so33037459ejc.1
        for <linux-cxl@vger.kernel.org>; Tue, 01 Mar 2022 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dLRHgK7nPexBu1vWY80XXHBQPDHlcif0KUYC1mcwzmc=;
        b=RxMY1ZosMAOqRVJ/Q62iGfyo95fbP7PR/q3HCI0Yl5X+WKrMAtsYJcz2z5M8aA2Q65
         WiD4nvxaeVrSJC8R1TPXf3uk3gjbCXIV/y9bL107A98UMmBX2C68R1ZbBrknt1ThFpQy
         inUdpcVOP/TRbKl7oZqBorP9efVpVkA/LMBpAt9i801dSRvOE03I4sy/Fo+o4TX5Dv8U
         6lK4cbocAAOr4wqb1AHUW3delmzzmKiV/rnqVaYWFWsg3kLdjKYkdBjH9+lSbfJBsUua
         Y2yEIV1GgNmm+n3T+KYYZOfPD2juSW23n6+CQndOvnLCwlrggeRB0c9j1qGgxohbqpFf
         MTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dLRHgK7nPexBu1vWY80XXHBQPDHlcif0KUYC1mcwzmc=;
        b=m9VAJC34biOveKzFYnToEWYLM3QZq0d1bl0/rILVJH09J4QWiptn2gCnJ1rXkbjMdn
         F/lQCTlqJxnUts1MCA5z+BeTRhAxfkzVAJkfH6Ix/nSDeKde7wogBm90Bz9HqRG8kP3p
         PCHVd46ccUzyJMuGHJXX/ITpGxImNH/io3xlfEL9otxvVaE+znvWtTBRj9Y58vOrZu6D
         CLi+q6s4HdSloOgST+j3DGpbEQmP4ukaQ8o2CSVxdO2ESMD/64i7Pt7EAV3zapKbRQ0E
         Nu7bZDrGv89L5GzNbGzMW7AdkaAVA9aSYEsn8kq5mnIb9+JbH/8kcvBZAGjkPCLutSE9
         Kd7w==
X-Gm-Message-State: AOAM533MbauTYWepG25TaeLDJhEdP2k5KP1ajVBhtkp+rdtUQII6nLel
        5m5nKFjl90+UI8Og9SrlHJ03Nw==
X-Google-Smtp-Source: ABdhPJzmX8W2OEZNcd9SAtFhpUufuevKMDHeZSOP6NoY6+6SsTnfPsVTmH1d++kdm+Wva3rTdxEJXw==
X-Received: by 2002:a17:906:b28b:b0:6cc:734c:812d with SMTP id q11-20020a170906b28b00b006cc734c812dmr20182689ejz.657.1646156730177;
        Tue, 01 Mar 2022 09:45:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm5495649ejb.82.2022.03.01.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:45:28 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 31FBF1FFB7;
        Tue,  1 Mar 2022 17:45:28 +0000 (GMT)
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
 <20220211120747.3074-11-Jonathan.Cameron@huawei.com>
User-agent: mu4e 1.7.9; emacs 28.0.91
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
Subject: Re: [PATCH v6 10/43] hw/cxl/device: Add log commands (8.2.9.4) + CEL
Date:   Tue, 01 Mar 2022 17:45:23 +0000
In-reply-to: <20220211120747.3074-11-Jonathan.Cameron@huawei.com>
Message-ID: <87y21tlg7b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> CXL specification provides for the ability to obtain logs from the
> device. Logs are either spec defined, like the "Command Effects Log"
> (CEL), or vendor specific. UUIDs are defined for all log types.
>
> The CEL is a mechanism to provide information to the host about which
> commands are supported. It is useful both to determine which spec'd
> optional commands are supported, as well as provide a list of vendor
> specified commands that might be used. The CEL is already created as
> part of mailbox initialization, but here it is now exported to hosts
> that use these log commands.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
