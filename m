Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6B6C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Feb 2022 19:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbiBITcb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:32:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiBITcN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 14:32:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB3A7C1DF655
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 11:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644434589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C4e2B8CRA0Mc/Bft/aeYH9njX0ttCU4Cd8d8MvfCIbc=;
        b=F3gq8+SuBNdvkfLE7JQloJJmhyRtJkMmBWOrFZiKHx0Eix1ySuaLIG+mJrWHRpVQLtzysr
        kqMpRcHXt+hErGCgpHuTyBsSmPkllUbrevwsULlQ7kaNMxAPY0tWGynkcXt9hgyMXR23wR
        t25ocu4kF8cMr2p6ZIFY//KvWt1Pa4E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-n_HRvt7mMA2eO4F_8mrRMg-1; Wed, 09 Feb 2022 14:09:33 -0500
X-MC-Unique: n_HRvt7mMA2eO4F_8mrRMg-1
Received: by mail-wm1-f70.google.com with SMTP id a8-20020a7bc1c8000000b0037bc4c62e97so863866wmj.0
        for <linux-cxl@vger.kernel.org>; Wed, 09 Feb 2022 11:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C4e2B8CRA0Mc/Bft/aeYH9njX0ttCU4Cd8d8MvfCIbc=;
        b=N2IRRlKoET/zcJWxRb14rqWmZYEfnl7nU5SQVfhb9imnXo7RrzbRDz//SuYuoz5Z6W
         HXl0ICfnSd789nnmDTqVRaN6XwPVrKCspsO+JuRSSvDhmwt0TVigNcl6YTM681W3T7x9
         as7V9bwlU1X1NPXW8v4oqvUjwKywdT8K3n8bD8fh1fLb4uPBmX+Ptb/FtHBWJcd4NWbP
         k+t7A85cnPXel3V7BrK9tPF1orwurg6n2dUKMZ4uKNYKBHiikjedGTJNZ2/C0nlP8eqo
         YDNtlnx8BJZTf9gHD3JIB+hxJlnDxf4kxLYYS8cg+ldZrIQLMfQGg1rtxu5irMZEUJz0
         CU4w==
X-Gm-Message-State: AOAM533hacseqtNMGN0+0/7xEb8xOtlbIhBXahr9qx+slkfr303jFsWZ
        IG+frYLALsGe2CvdyLjUxTbAYRLPDllpvxFuAxJqVeSdK92DZv/6z/oIgOehjZ3bll2oumBoy+P
        ffDcx/J+J9DOWbfx/lXsl
X-Received: by 2002:a1c:f219:: with SMTP id s25mr3888607wmc.119.1644433772221;
        Wed, 09 Feb 2022 11:09:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBWebjrQrOEbPi6SSWj+FREYBf9KcLbgIKtgu5cA08Qg6VT1MVnwzJazDvD+svlGh9IwJVqQ==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr3888585wmc.119.1644433772006;
        Wed, 09 Feb 2022 11:09:32 -0800 (PST)
Received: from redhat.com ([2.55.139.162])
        by smtp.gmail.com with ESMTPSA id r12sm16792384wrw.73.2022.02.09.11.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:09:30 -0800 (PST)
Date:   Wed, 9 Feb 2022 14:09:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 23/42] tests/acpi: allow CEDT table addition
Message-ID: <20220209140746-mutt-send-email-mst@kernel.org>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
 <20220124171705.10432-24-Jonathan.Cameron@huawei.com>
 <20220209181801.00000e4d@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220209181801.00000e4d@huawei.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 09, 2022 at 06:18:01PM +0000, Jonathan Cameron wrote:
> On Mon, 24 Jan 2022 17:16:46 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> > 
> > Following patches will add a new ACPI table, the
> > CXL Early Discovery Table (CEDT).
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  tests/data/acpi/pc/CEDT                     | 0
> >  tests/data/acpi/q35/CEDT                    | 0
> >  tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
> >  3 files changed, 2 insertions(+)
> > 
> > diff --git a/tests/data/acpi/pc/CEDT b/tests/data/acpi/pc/CEDT
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/data/acpi/q35/CEDT b/tests/data/acpi/q35/CEDT
> > new file mode 100644
> > index 0000000000..e69de29bb2
> > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > index dfb8523c8b..9b07f1e1ff 100644
> > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > @@ -1 +1,3 @@
> >  /* List of comma-separated changed AML files to ignore */
> > +"tests/data/acpi/pc/CEDT",
> > +"tests/data/acpi/q35/CEDT",
> 
> Whilst reordering the series to allow partial sets to be picked up
> it occurred to me that there is reason why we should now generate a CEDT
> table unless cxl=on is set for the relevant machine.

Absolutely. But this is just an example, it's an instance of
a bigger issue: skipping new features when they are off
reduces the chance of legacy guest breakage.

> Adding the relevant conditions means we can avoid this dance
> to add effectively empty CEDT tables.  I have added a proper
> test for to bios-test-tables but that can be introduced once
> everything is in place, rather than as we go along (whereas
> for qtests/cxl-test.c I am doing a series of updates as the 
> functionality is built up.).
> 
> Makes for a simpler patch series to update.
> 
> Jonathan

