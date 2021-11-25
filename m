Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03230C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Nov 2021 01:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhKYBzH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347031AbhKYBxG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Nov 2021 20:53:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B225C08C5F1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 17:09:14 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f65so3703866pgc.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 17:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9iFe3RwyivFttW+TFl33gFw6GIboF2oWAdzCGeXeq3s=;
        b=Fs7IVQqk1chiXsPmiwjZzCJGZtN7SI39LqeaE56ii+QyVd2iscl/wk6O1eiW/M4buJ
         wDmTNmEDXjUxQjh4O7KG93X0w4AvSgg1t5Zya13sZJQB2C5jHbC5d9vDhPoric9C0HMn
         GB5C+4qiOpqqOTxLjSKDpOyY/p95QWDugseU35jYck8oVbE9aaebmq9yNK41Ey1qO1QL
         rjvdShXuSPGXe3nkAxhZWVO3Ext6BcdkTU92QwUUmC6Ce2R3DdPqB+J+R4eA51Q2ZF69
         XEp8Kh/hB4lzIeP3W12ut4MWXXKO4W4WOhxPl65jHRmiZpWcjzeWOOFKzZ0OnSuIG87K
         4PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9iFe3RwyivFttW+TFl33gFw6GIboF2oWAdzCGeXeq3s=;
        b=Jo2TjdhvijdNYwdSoygjdc9tucqd5bxY8Ud4lSIjufbJ/iRshSJrLbCxgkpn1C61it
         0/081Kuw3f33kHd2NHrRiGe8jkx7+ezKALjzU9qoMfySfjevLQeZ0B70klolYx/LRr6H
         tMrbUzNdjWnuMH/MCDG8kDWs8vhCOPgwkJInNmhg/S+93DZjyPMXmy3Hz5tIAml0+fxB
         RZo0017KYDoN1h2pkoenjl0Cs+keeKqxhlvAk3MCCC864uj4YQ3pbwGJPe566sX/GIOW
         s95gHEIFgU0QjoHzVRtxMkMuWWK+EjzdB5mhNz776cmbfjar47S8xs/OvoS38ECz50ku
         zeFw==
X-Gm-Message-State: AOAM532Q7cCh67R5FXMOBSrrd0IHNFVVHm9ArRT2eKtYTCSU3e8wUOQE
        UFDBo7Qm6+LultfEPELFM0o9Ak8062UglRzOMs430w==
X-Google-Smtp-Source: ABdhPJzGTkzgA+qvyskIs6DP71xpPFoSgC+lYJl5AHjKP2/k36+XnT1g3D0JHWYhV66J2Ebkk7cc8GsiVLnmCp8oZcA=
X-Received: by 2002:a62:7ec4:0:b0:4a3:219b:7008 with SMTP id
 z187-20020a627ec4000000b004a3219b7008mr10860067pfc.3.1637802553944; Wed, 24
 Nov 2021 17:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-15-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-15-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 17:09:03 -0800
Message-ID: <CAPcyv4inKyG7biUh6nxhq9Y22-D5Pg4FgJeZw7mbhSrfwqxGcA@mail.gmail.com>
Subject: Re: [PATCH 14/23] cxl: Introduce topology host registration
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The description of the CXL topology will be conveyed by a platform
> specific entity that is expected to be a singleton. For ACPI based
> systems, this is ACPI0017. When the topology host goes away, which as of
> now can only be triggered by module unload, it is desirable to have the
> entire topology cleaned up. Regular devm unwinding handles most
> situations already, but what's missing is the ability to teardown the
> root port. Since the root port is platform specific, the core needs a
> set of APIs to allow platform specific drivers to register their root
> ports. With that, all the automatic teardown can occur.

Wait, no, that was one of the original motivations, but then we
discussed here [1] that devm teardown of a topology can happen
naturally / hierarchically.

[1]: https://lore.kernel.org/r/CAPcyv4ikVFFqyfH2zLhBVJ28N1_gufGHd2gVbP2h+Rv2cZEpeA@mail.gmail.com

No, the reason for the cxl_topology_host is as a constraint for when
CXL.mem connectivity can be verified from root to endpoint. Given that
endpoints can attach at any point in time relative to when the root
arrives CXL.mem connectivity needs to be revalidated at every topology
host arrival / depart event.
