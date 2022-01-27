Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D70FC433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbiA0MFK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 07:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiA0MFK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 27 Jan 2022 07:05:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34140C061714
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 04:05:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v13so4315808wrv.10
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jan 2022 04:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wC5AJAToOzdyWv76wjRLKppn9pQtgWR38O4l4EJP0E0=;
        b=ALLf2LsuxHIZC5I1LP7FulLCCIxU9f7vI6+K2R/gzZkj5/+onZppJOefECeXSY5TrN
         qfE0Tw+kNTqRoQzmTpkJsfEcs9ah0CQ4Lr08Z4Ki1K/OOb/DV4vCRew/pPogpnQyWbZY
         yuM1wIvgcoB4hOVVp4lSNk32C+AyxljiXpYBxUhHxFIKdIPWdTG+WE+NeojAQNIAgCkd
         iaurGRPCzB0VJgWZY77QmHtqVxva4iOlhOnkiK8sX3ecPGqb0m/D351FIfFJLJG/3Y8V
         zwDy3i/Jv9pz+AAoqOtOX5rji6UFVpSLOyayJ9PN7YaBoQszUEX44KlLczB9cb/e4ORq
         /9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wC5AJAToOzdyWv76wjRLKppn9pQtgWR38O4l4EJP0E0=;
        b=H9pD8XgvnaRhE860Q/M2u/9yczUZ2zzyFA3N2lqNZKfhZVxqsAn7s4ComFp+6/ncxb
         95AEIiIn2GRqMXtDrsEP96oYkrf6xyad+eJDMo9wKT7Q40TEttb156hP48/ieyS8Xg5K
         QTNVqSv4VjPdTbqlKhJPwTdKiPZPCn1P/iF7EwTgeKkIPtnvAm3bRYIrVtsGQS3c4XQ1
         +YUDXln6lsWZj0k2CCZEUUhuf57EYrZhATEu85G3mro4AMpKeXGPuyfjKWElzgPpR1Kt
         Yeyi8zYFOz/WISDuEZHtYraeQ4bL7mqRaI22NkIDOr5GBrxcVbexDp+X3o/Le5iNrQrk
         8Csw==
X-Gm-Message-State: AOAM531qpLKk49E/2ue3jMs9Y5HhhmCteNKujpxKjmn6LZsIcxdsXRyl
        IRE+puwg8+zPf7eMrxoGyk6tGA==
X-Google-Smtp-Source: ABdhPJwlXJ9yWjlrcjJcAF/GSPCFnEUgq6J5oh9ztAq8cJhZb6ef5bBQX0jf0nF6m4LJNiA/tlkiqw==
X-Received: by 2002:a05:6000:1292:: with SMTP id f18mr2836522wrx.133.1643285107124;
        Thu, 27 Jan 2022 04:05:07 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id k37sm10803669wms.0.2022.01.27.04.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:05:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id 11FA21FFB7;
        Thu, 27 Jan 2022 12:05:05 +0000 (GMT)
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-13-Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v4 12/42] hw/pci/cxl: Create a CXL bus type
Date:   Thu, 27 Jan 2022 12:05:00 +0000
In-reply-to: <20220124171705.10432-13-Jonathan.Cameron@huawei.com>
Message-ID: <87r18t9yfi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Ben Widawsky <ben.widawsky@intel.com>
>
> The easiest way to differentiate a CXL bus, and a PCIE bus is using a
> flag. A CXL bus, in hardware, is backward compatible with PCIE, and
> therefore the code tries pretty hard to keep them in sync as much as
> possible.
>
> The other way to implement this would be to try to cast the bus to the
> correct type. This is less code and useful for debugging via simply
> looking at the flags.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
