Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29F4C6FA99
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Mar 2023 01:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCHBfG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Mar 2023 20:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCHBe5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Mar 2023 20:34:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7E9B2E6
        for <linux-cxl@vger.kernel.org>; Tue,  7 Mar 2023 17:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678239251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u4xvnnbH4/c9Y9hiuiROtUYMuUkd9GYWk1R5PAsyYp0=;
        b=iD1jzR5nZnTrIGjyFXYJKLzKk1sG7goCxVBG8QQKSyTYOwFymlpMXxwXpQbTrpqUvJq1ur
        DAzdmLx2qly+M/VtlSilaWPsr58T8e/HCwLD98FV5AfXh0+rql9GAjoVyl5bkRqCyMRIpF
        1/92Xz8q3zwOKDBR0HAzdhg8Mn9QK6g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-pbJV8cCXPQyfKePWvwjUYw-1; Tue, 07 Mar 2023 20:34:09 -0500
X-MC-Unique: pbJV8cCXPQyfKePWvwjUYw-1
Received: by mail-wm1-f72.google.com with SMTP id n15-20020a05600c500f00b003dd07ce79c8so143481wmr.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Mar 2023 17:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678239247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4xvnnbH4/c9Y9hiuiROtUYMuUkd9GYWk1R5PAsyYp0=;
        b=gcyj4GkGhd7msERThdK0vLRQrLqknYvZyEGQ6ZYO0q4BmmsOufB/3SCJXPOo8kv86f
         9wlDrMig+Nw+2+8uXX3Sk276UyTvo5N385p2OVn+5EQdYYp9GoSrMHpava7fvp2VWi+W
         FffbPdsfYKGvqA1lm7iVlraOZAtrX4wCJv1OhLlLt1lqcmMoQ6pPqYtYb8gZU+Z452Gu
         R3mdT0hYsRptidcNXNPAUuBoOidx7aDkgnAWpeWV1REuH21uA0Tm62oJSQ7lQGb7uj9Y
         AqZ+TUbSCcg5XCexPIi3G+240tnDV3QttQHYeoLeq0Xhh7aER4cni8O6Y5D/zpggZtjA
         pGFw==
X-Gm-Message-State: AO0yUKUOy0L/KzmrEXmjpCIhWFvwJxFPwdOdDxVEr5LqxV5HvE6iHvrP
        yT3MPdwKBiqBwCuVDi7s3Ws1Ua2YjgBcC6uwliZXjqAvm3vPH5hUy+cpmzlH+Fx+orcADB+e5hP
        nwKSY5ZVIQ3V7h+lHRBQ3
X-Received: by 2002:a05:600c:19d4:b0:3eb:2b88:7838 with SMTP id u20-20020a05600c19d400b003eb2b887838mr14972746wmq.14.1678239247789;
        Tue, 07 Mar 2023 17:34:07 -0800 (PST)
X-Google-Smtp-Source: AK7set8sKEFelmOoGA64I5/yDoj+8dPF6Dp7yoFjT2RHPQ2cYH4wGV3Kg5DZg+vymhsYmZuJc5v8WA==
X-Received: by 2002:a05:600c:19d4:b0:3eb:2b88:7838 with SMTP id u20-20020a05600c19d400b003eb2b887838mr14972728wmq.14.1678239247512;
        Tue, 07 Mar 2023 17:34:07 -0800 (PST)
Received: from redhat.com ([2.52.138.216])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm13501937wrr.62.2023.03.07.17.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 17:34:06 -0800 (PST)
Date:   Tue, 7 Mar 2023 20:34:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 8/8] hw/mem/cxl_type3: Add CXL RAS Error
 Injection Support.
Message-ID: <20230307203336-mutt-send-email-mst@kernel.org>
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
 <20230302133709.30373-9-Jonathan.Cameron@huawei.com>
 <CGME20230307192642uscas1p15caa7ff372247e96544265fbd031d83e@uscas1p1.samsung.com>
 <20230307192641.GH1489326@bgt-140510-bm03>
MIME-Version: 1.0
In-Reply-To: <20230307192641.GH1489326@bgt-140510-bm03>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Mar 07, 2023 at 07:26:41PM +0000, Fan Ni wrote:
> > +typedef struct CXLError {
> > +    QTAILQ_ENTRY(CXLError) node;
> > +    int type; /* Error code as per FE definition */
> > +    uint32_t header[32];
> Instead of using 32 here, would it be better to use
> CXL_RAS_ERR_HEADER_NUM?

merged as is, fix on top pls.

-- 
MST

