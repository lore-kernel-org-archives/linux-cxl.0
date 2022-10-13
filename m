Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1994C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJMRJe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 13:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMRJe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 13:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BBDB4893
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665680972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MPsevQZI2YFT5WxyapevNPOSIvH7V9m0ouOuBstER0g=;
        b=Z0cQiDpawhlqMxCPJpNtmeSAB3iw3wRdGVaV3cniR3wXv4eD8oAXrHsy8COVqq5/WXwxf6
        axji4SqPDW/i23nFlro5rgiVM+rcGeJz8vHuZptZARdoi+RisTx6Vd6VBhSjSLzRZAi+HX
        PjrYYtFdiGJ6zFc+uOaOoMK03SrjaMI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-5sYFHhUcOL6B6lrLNvsneg-1; Thu, 13 Oct 2022 13:09:31 -0400
X-MC-Unique: 5sYFHhUcOL6B6lrLNvsneg-1
Received: by mail-wm1-f70.google.com with SMTP id 3-20020a05600c020300b003c5eefe54adso1103700wmi.9
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 10:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPsevQZI2YFT5WxyapevNPOSIvH7V9m0ouOuBstER0g=;
        b=jG8nVKLiX8uVrZcDcqrKbCOqpV68lrfwHtpHulJ5GVXiVMZP82UFcuW5cwP+IhB4QT
         2uS4yL6loPM0up8pTNGj2EXoOK6V429H1OwDNKIO/ZBJqZtMzoD8ZJ+2qxy3ypFh0Bxn
         aVIJ9wr5jrQqA1S8K1B6hsUymnxSNl2tUwudhQ7rrgbEiuIEWegE3lzHeIoioC67Myro
         bSX20QTq7S8cMQHhlinlml1xVJRRN9mV4RTQEUiz1DJSIcdHnJPobzoZnhCflw8PPmQu
         EU1bzfHxoomL9z7NF/lAT5uRg3hldCuJkgxL2AzU5KH+ta6Z2cShLKeXrweYujHnBlNQ
         wFJA==
X-Gm-Message-State: ACrzQf1Oh/Zh24THxbVBK7wU0V4f5RrIN6ib/VIYCjAYMw1AFM+v80CA
        FSKaYwQV9bhV5dxTN8PdPDvRh1IklgTUhXHMIgF+BP8n2iVFWbGyobHICZoRJ3xrmGWnwOIKYqn
        7UrZtj3Gt0+aYC/NCGIM0
X-Received: by 2002:a5d:408e:0:b0:22e:650a:ec4b with SMTP id o14-20020a5d408e000000b0022e650aec4bmr710513wrp.212.1665680970296;
        Thu, 13 Oct 2022 10:09:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7BB9rBZwVA8TUQYbFSgyFj0EK5O2zi2BfR7zDBQMld8l8nUceBJpiwSiK4odw6KRLeMDudOA==
X-Received: by 2002:a5d:408e:0:b0:22e:650a:ec4b with SMTP id o14-20020a5d408e000000b0022e650aec4bmr710499wrp.212.1665680970090;
        Thu, 13 Oct 2022 10:09:30 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c001100b003c6bbe910fdsm5841564wmc.9.2022.10.13.10.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 10:09:29 -0700 (PDT)
Date:   Thu, 13 Oct 2022 13:09:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Ben Widawsky <bwidawsk@kernel.org>,
        linux-cxl@vger.kernel.org,
        Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
        Chris Browy <cbrowy@avery-design.com>, ira.weiny@intel.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v8 4/5] hw/mem/cxl-type3: Add CXL CDAT Data Object
 Exchange
Message-ID: <20221013130840-mutt-send-email-mst@kernel.org>
References: <20221013120009.15541-1-Jonathan.Cameron@huawei.com>
 <20221013120009.15541-5-Jonathan.Cameron@huawei.com>
 <Y0g8UgumJwqU4QyB@memverge.com>
MIME-Version: 1.0
In-Reply-To: <Y0g8UgumJwqU4QyB@memverge.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 13, 2022 at 12:26:58PM -0400, Gregory Price wrote:
> Other than the nitpicks below, lgtm.  Not sure if you need a sign off
> from me given the contributions:
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> > +/* If no cdat_table == NULL returns number of entries */
> > +static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> > +                                         int dsmad_handle, MemoryRegion *mr)
> > +{
> > +    enum {
> > +        DSMAS,
> > +        DSLBIS0,
> > +        DSLBIS1,
> > +        DSLBIS2,
> > +        DSLBIS3,
> > +        DSEMTS,
> > +        NUM_ENTRIES
> > +    };
> // ...
> > +    if (!cdat_table) {
> > +        return NUM_ENTRIES;
> > +    }
> 
> the only thing that i would recommend is making this enum global (maybe
> renaming them CT3_CDAT_[ENTRY_NAME]) and using CT3_CDAT_NUM_ENTRIES
> directly in the function that allocates the cdat buffer itself.


Yes I think I agree here.

> I do
> understand the want to keep the enum and the code creating the entries
> co-located though, so i'm just nitpicking here i guess.
> 
> Generally I dislike the pattern of passing a NULL into a function to get
> configuration data, and then calling that function again.  This function
> wants to be named...
> 
> ct3_build_cdat_entries_for_mr_or_get_table_size_if_cdat_is_null(...)
> 
> to accurately describe what it does.  Just kinda feels like an extra
> function call for no reason.
> 
> But either way, it works, this is just a nitpick on my side.
> 
> > +static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> > +{
> > +    g_autofree CDATSubHeader **table = NULL;
> > +    CXLType3Dev *ct3d = priv;
> > +    MemoryRegion *volatile_mr;
> > +    /* ... snip ... */
> > +}
> 
> s/volatile/nonvolatile

