Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B36C433F5
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Dec 2021 02:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhLRC2O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Dec 2021 21:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLRC2O (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Dec 2021 21:28:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E65C061574
        for <linux-cxl@vger.kernel.org>; Fri, 17 Dec 2021 18:28:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c22-20020a17090a109600b001b101f02dd1so7296712pja.5
        for <linux-cxl@vger.kernel.org>; Fri, 17 Dec 2021 18:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfHXjsRQo0Ui4puyVFxSD3WvugUAt4jhbTNKOmv07Ro=;
        b=YYmsm2lUtXi/ZwO9tOneh75xbima+MqE1v/rzkMVR5SQI0xaijiSBIdHTLzgpnJ+ks
         9R9n1orniY3dAyJUwLBrwDbsBwxFQyjupSwjXF0nOE/V71NSyzje5Bnk4aQ+jnIzwOnJ
         dQ/uxhTjyPlYnmAPOr+sqLZ+VXtSh3FtrUBGkWzH50SPDHEa+aTVTzDCah8i+nt/Dcr0
         1QB7rHukgdRgXZnLw8hg9L89xMIo8eTY5CIkQafsJbZBeapizy5MGHjmG6ow+hpS+GPH
         nHUxuvMZsNL3vVA9fiZ2pTqFru+K7vny2dqbiiDekjPqE0gzqAE7qOUZuwXZ8pdtyOyW
         3wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfHXjsRQo0Ui4puyVFxSD3WvugUAt4jhbTNKOmv07Ro=;
        b=7c2x0ayihnAgIKDYonOKAO3xqx1xf/sK1/3mzRUtrWNuoFK+i5xNNsGB0MTmmTIHlz
         RhKTLCqKz+bAi351erAD17QhcmcONFD4qNcOK46pAF6q9iyHBqvpIdK8AK52K77otwsZ
         NcHZk1QokD4j+ZVASOHuOBH008y/Z1elCrazGZyuWLfRayHN8eUyskZAPqxMdxtvvXga
         Db37I58qpe0cD89YhVskw6FKf9vKKpaWHcgI6ylEBc3XMfgMzFtkN8WcBXkgYr/RZFV6
         G3usXRAnpMy20L6aF4zhqN4YXHTvdjm96mMgT3UeLI80v7lYt0mxGGmCC8tvGrzuLxme
         BE2A==
X-Gm-Message-State: AOAM533NF5LYfkTXXoFWheHj04cm4PWcjyEUXG+wo/sOBhPvRmjXvtrJ
        Y1dSu8FaJQ5pz4+nrkDMndwtrJhRfLee/iWkE8ZtI4xpbqs=
X-Google-Smtp-Source: ABdhPJzas+sA2cpPHpahOZJDKYMEclQ8LYKUWh+wBsOnPCUfwsVgws+Lcnv4drjWBNeXgvJIwPlA1UwziWzWSx+iIw0=
X-Received: by 2002:a17:902:bb87:b0:148:a2e7:fb52 with SMTP id
 m7-20020a170902bb8700b00148a2e7fb52mr5870998pls.147.1639794493185; Fri, 17
 Dec 2021 18:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20211218022511.314928-1-vishal.l.verma@intel.com>
In-Reply-To: <20211218022511.314928-1-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 17 Dec 2021 18:28:02 -0800
Message-ID: <CAPcyv4hGOw0wp7iR24vVXG_jCRTFwaxMNmq+qJH_8tpG8K8zfg@mail.gmail.com>
Subject: Re: [ndctl PATCH] libcxl: fix potential NULL dereference in cxl_memdev_nvdimm_bridge_active()
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Dec 17, 2021 at 6:25 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Static analysis points out that the function above has a check for
> 'if (!bridge)', implying that bridge maybe NULL, but it is dereferenced
> before the check, which could result in a NULL dereference.
>
> Fix this by moving any accesses to the bridge structure after the NULL
> check.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  cxl/lib/libcxl.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index f0664be..3390eb9 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -420,12 +420,15 @@ CXL_EXPORT int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev)
>  {
>         struct cxl_ctx *ctx = cxl_memdev_get_ctx(memdev);
>         struct cxl_nvdimm_bridge *bridge = memdev->bridge;
> -       char *path = bridge->dev_buf;
> -       int len = bridge->buf_len;
> +       char *path;
> +       int len;
>
>         if (!bridge)
>                 return 0;
>
> +       path = bridge->dev_buf;
> +       len = bridge->buf_len;
> +
>         if (snprintf(path, len, "%s/driver", bridge->dev_path) >= len) {
>                 err(ctx, "%s: nvdimm bridge buffer too small!\n",
>                                 cxl_memdev_get_devname(memdev));
>
> base-commit: 8f4e42c0c526e85b045fd0329df7cb904f511c98
> prerequisite-patch-id: acc28fefb6680c477864561902d1560c300fa4a9
> prerequisite-patch-id: c749c331eb4a521c8f0b0820e3dda7ac521926d0
> prerequisite-patch-id: 9fc7ac4fe29689b9c4de00924a9e455cd9b58d53
> prerequisite-patch-id: e019f2c873ac1b93d80b9c260336e5d3f46b0925
> prerequisite-patch-id: b69ecc9d68ce5e7c79b62cea257663519f630da2
> prerequisite-patch-id: 928a32f4c1ff844df809ccf1aba8315cac723d93
> prerequisite-patch-id: ae29f23cedf529da1fe8e39f8cde1df827d75fa1
> prerequisite-patch-id: f3d8fc575f5afed65be8a7b486962e8384eabc1a
> prerequisite-patch-id: 74859f43302dcc442dfb1e29f6babad75d229bf1
> prerequisite-patch-id: 696c2d5caf0bd4eac645035f72a7077efbf3e6cd
> prerequisite-patch-id: e3ef7893a1df9ecc6b76dee78f2b27cc933ad891

git-send-email adds this by default now?
