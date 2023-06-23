Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A2BEB64DD
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jun 2023 07:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFWHAk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jun 2023 03:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjFWHAj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Jun 2023 03:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9DC211E
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687503591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5FfHalw8xCTw9CMZhOOuU7kD3v6HXxUzJ0PHEjZOUY=;
        b=A3iYxulRECVi/GEO3CGrygWwQDGvGYabht459qrawUCDVXtNKRir+U2M+V7T6/U3ADElz1
        risSf2TKRRsXclbrFwHmYX8+g00sG5QOEZW5K27JmsSPcFJneH431BEOMT0fe9KfF3wi1y
        m9BcuoOZ+Az+T37L3L8k3SLGRbw4i6I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-gPNPpT7ZN8ioHbk1tNp97g-1; Fri, 23 Jun 2023 02:59:50 -0400
X-MC-Unique: gPNPpT7ZN8ioHbk1tNp97g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3127d83b31cso194647f8f.1
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 23:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687503589; x=1690095589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5FfHalw8xCTw9CMZhOOuU7kD3v6HXxUzJ0PHEjZOUY=;
        b=doo86/TJBRVareAh0rEEMFvGKGRuztDUONOFhCfA0aiukzdQSOWAf6JKr7H0xnBsN/
         AvKrruxVgLbWZdvY4TibC/HEQO57jDwp1uVnkhF3aEi9iq8ofA1TxPbtyS7V1wToWepY
         4vOA4hbfiBcrLwPz6tvuKEghGciZCAfWmVq8iQI5S3Yrs5ywTiweDhqo/RHXk7SwBtGC
         u1p9FgKoyC+h/MWZxVDzWzkqVGYiESZ4YKYbaLSzpapaoL4bQL2mp+Jc/wy2c4EBt5xc
         xE8KOZH8+qGct0oxFr7sTK66axpw7GkUE9JySl3Um3ge+rldOihPdefPF7ATYUSrt4cI
         893w==
X-Gm-Message-State: AC+VfDwtw4VaC8EdEJKU+Z71q/JOewfB4RXpxa56InX518PCc9uI/C3H
        aSn74ixhuEQMo4JBSOTODpmgrvNJlbmkZpptzSfvncoK/jglFSuvaj4bJpvOvGUOwNcjvjP5UwD
        Q0FH7vHQThGtNqXKoNowx
X-Received: by 2002:adf:ec03:0:b0:306:36ef:2e3b with SMTP id x3-20020adfec03000000b0030636ef2e3bmr15881829wrn.70.1687503588888;
        Thu, 22 Jun 2023 23:59:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nS1FyyFtV/ouSSfRPSckt6bSMMjXNJzEuCHNDMJ/MHr/jQsx6YJ4qf3iXhfMVYInxKAypyA==
X-Received: by 2002:adf:ec03:0:b0:306:36ef:2e3b with SMTP id x3-20020adfec03000000b0030636ef2e3bmr15881810wrn.70.1687503588618;
        Thu, 22 Jun 2023 23:59:48 -0700 (PDT)
Received: from redhat.com ([2.52.149.110])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d470e000000b0030647449730sm8872184wrq.74.2023.06.22.23.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 23:59:47 -0700 (PDT)
Date:   Fri, 23 Jun 2023 02:59:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v8 0/4] hw/cxl: Poison get, inject, clear
Message-ID: <20230623025836-mutt-send-email-mst@kernel.org>
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, May 26, 2023 at 06:00:06PM +0100, Jonathan Cameron wrote:
> v8: Formatting fixes for QMP docs from Markus Armbruster (thanks!)

This and other patches add a bunch of over-80 chars lines.  I'm not
going to intervene here as cxl has lots of them but maybe scan over cxl
codebase and shorten where appropriate.
Thanks!

-- 
MST

