Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81987C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 11:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbiA0L2k (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiA0L2k (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 06:28:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0EC061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 03:28:40 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id jx6so5271000ejb.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 03:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=YvrL/Egk4nS2MmgDpirIBVn4n5zZKOT5j5awxLHZgMI=;
        b=C3aYpUSuRQU+Eaq/IvY8H25i37v6mnqkYX0sQp+oGNsqDDmAMFG6klDPMFgCGOk/ow
         R2nNrCvz22wXjNqW7PTG8c2yB8VZLobFnz0/j2SihdGgUaJgAaxLdKmRkvJmmbyV1khI
         kWRwYe+GVXh9oDAJUqlk0p/XEn5V5vd/2Fi1poWOiqN+eo8gjKUGPdzM/C4Uc6vFp3Kw
         p+TF60BDaoCXWegYYfLTO9myP/xzZY65F8QUuJr/Kd4oJwxC7tUsxoyLnvkO5eiaIbsk
         LAoSvD1LqPD46aTIAVnMdcIh4vn0TIe1JPmspthTdpXbnbh5QiboPO/mRjgLJ/wM+3hm
         ilNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=YvrL/Egk4nS2MmgDpirIBVn4n5zZKOT5j5awxLHZgMI=;
        b=WnXvllyS4MZ9RQlAu1mhK/cnFdauK3lYnNaHpZtcBwRHBDPfhxbXIxSY4+wnYlGGem
         qG8uenYFgWCjJAZnm8EKLy+1+dux6c5i2fZTCyavyYktngKT4+M5THa06lpbX3h1B3tN
         VghGzUscqa3mfwRpcVrd1iob2BmzljAqDV3T+T0DD28a8mPi2jBe7EmFh96q5RFeaLTW
         FdNL5OZJMHrwQTNKASEcVU5cskIkSjBXmc6SAPpetnKY/xs0bj4StX+P0iSsAGYdYYyp
         eixGTLvfM5loYIONgU2AAifXG41lkliM7m8y85R321TzUX880xbBh9Vz4kRFNnjf/ATn
         EGuA==
X-Gm-Message-State: AOAM531SetS30O4w2GYcgikT6HUOFhFO2yEefm8eOZg9JKvLQg/YRu/w
        tRQKoLHs+Lo9twTvCEiAApQQHw==
X-Google-Smtp-Source: ABdhPJyFUvCjQFocN+c+Rncff/AYlu92A8AqOPrFaYiHE0qs1/B7gVn7bEQ4ZzBlVTeI+/f4FNoBvg==
X-Received: by 2002:a17:907:7ea7:: with SMTP id qb39mr2560073ejc.547.1643282918573;
        Thu, 27 Jan 2022 03:28:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id k24sm7036526ejv.179.2022.01.27.03.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:28:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id F34B01FFB7;
        Thu, 27 Jan 2022 11:28:36 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-8-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 07/42] hw/cxl/device: Add memory device utilities
Date:   Thu, 27 Jan 2022 11:28:31 +0000
In-reply-to: <20220124171705.10432-8-Jonathan.Cameron@huawei.com>
Message-ID: <87h79pbeor.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> Memory devices implement extra capabilities on top of CXL devices. This
> adds support for that.
>
> A large part of memory devices is the mailbox/command interface. All of
> the mailbox handling is done in the mailbox-utils library. Longer term,
> new CXL devices that are being emulated may want to handle commands
> differently, and therefore would need a mechanism to opt in/out of the
> specific generic handlers. As such, this is considered sufficient for
> now, but may need more depth in the future.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
