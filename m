Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6283CEEAA42
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Sep 2023 03:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjIODk5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Sep 2023 23:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIODk4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Sep 2023 23:40:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF03268A
        for <linux-cxl@vger.kernel.org>; Thu, 14 Sep 2023 20:40:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68c576d35feso1516719b3a.2
        for <linux-cxl@vger.kernel.org>; Thu, 14 Sep 2023 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694749252; x=1695354052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc99nGQEALaOKSDIv77AhBK5hwBb20YJz7YOm9x4L4E=;
        b=XEhpL1Cj3P5lfDWoPdowuEYT+4HHVhVw2VWxjzsfzbtTPQdCELPGJOozCOlcm91fBr
         29BiMQBcw8QA3BvCvdMA3ikYrJkTPe2SfsgC02GqJtUZx9/SxFzIKol0Gyk+FCVKcfNs
         +cA/bF7NZPXj1QHd4dD6txKFGVwZYc74Fdstw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749252; x=1695354052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc99nGQEALaOKSDIv77AhBK5hwBb20YJz7YOm9x4L4E=;
        b=SqZHC2be85Gg2A1O6+IV7pQIxKtRbu3oXK4rxs+XYOM81fCeF7W1StLaY3MEuXgttq
         1Aa60u4ZLa6uwO1T0GpuSy03gqDhi5CK7YbAE/6hNDneNxrBfp3GZKQQ/2DAjduwvDuY
         4KA7K41Uj4jEj8eZqJBhyR6EB5n+LZgxq4rCiHKTQs+b51FtYOSQp0zU31A95bc2Ztdr
         4Rs4BDediuWHnktzcd8y/ogQvyt0wrOcgY/4O8GQESA6/ERyTmeMYqfcKSzTMDOWru9T
         4ShkfGbFGBNz1DnYnfDaiO1a4KjTa5R9FqwWMX3Cn1s386ZMrd/Eoh1hccrTJnNcxBwZ
         Kwxw==
X-Gm-Message-State: AOJu0YxqajqK4fqCLgqGGq1vKcaGcXw/0HFibuWxNl8mJzVhjcqWBRCL
        ejsE97ZRkDBoYkEwXy/ReMrosQ==
X-Google-Smtp-Source: AGHT+IGUVQH82U3M6N+LIrmpbwDAgOk8qDJI3k10x+RZOm4I6k7dxUmPvfPK9RmDvzM1gsHxP/20aw==
X-Received: by 2002:a05:6a00:22d0:b0:68f:d320:58bb with SMTP id f16-20020a056a0022d000b0068fd32058bbmr631169pfj.8.1694749252213;
        Thu, 14 Sep 2023 20:40:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x14-20020a056a00270e00b0068fe7c4148fsm2016065pfv.57.2023.09.14.20.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:40:51 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:40:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] dax: refactor deprecated strncpy
Message-ID: <202309142040.7FCE9E230A@keescook>
References: <20230913-strncpy-drivers-dax-bus-c-v1-1-bee91f20825b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-dax-bus-c-v1-1-bee91f20825b@google.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Sep 13, 2023 at 01:10:24AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> `dax_id->dev_name` is expected to be NUL-terminated and has been zero-allocated.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer. Moreover, due to
> `dax_id` being zero-allocated the padding behavior of `strncpy` is not
> needed and a simple 1:1 replacement of strncpy -> strscpy should
> suffice.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
