Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C9EC4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E67F6101D
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 22:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhHKWsD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 18:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhHKWsD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 18:48:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140B6C061765
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 15:47:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l11so4703966plk.6
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 15:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OztpKFyFkHWq5WmztlCUxj24iVog+SfKlFUjwOQEcIM=;
        b=Ee5VvOM4+VyN0yPauYS9IvJ9A6xbJ1FPxuOaat69KAXUI++RH/9oGYOP25DAXvA7ub
         u2kQW2QMmNNyt8vw2iAeV6dJp19mwcmf0au7qoDzB8vLkFPpSwha1GKZw6ufXzyPKV9C
         WFCM7Fpr+gVD898Q2Dr+ziDEZe8H7y0XyX/ijFkSeBL6iquo+wLgNjsP3eNbWmeukcL6
         XB2zUp6erLruYx+oc6ptvw4HXUGo0ek9WmK6KL74voFg2erwcoC3TVr7jlMfrkdNwm3E
         yTxM+V5ISgNrFkEdpdXwZWZEmpeOpUrQvlgqWPgAmGQPUUrIpS9iedbAJS7cK6Y0MzqB
         KWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OztpKFyFkHWq5WmztlCUxj24iVog+SfKlFUjwOQEcIM=;
        b=ihCjGIVIayuQ+1pUJTqRK0arX/fgujomxnwkBk7gm8bT9haq42JQs2tBD5YO90Q7vY
         fnRnPn3/BA5QkDkjpay/GwblNkSFaZmf0dG9NgASvmO1VO53f4PblkF5cwTtIO3ZPM0r
         LsT6IBXh0tXfr1NskCI4AVEaYfS5BUpJKv3QvXxzpI9Ei8zcPlZgvYysqKOFrOTiaXQM
         NLS+FHYa1gdhlrCrPofiUVS0qxNn0w9Rs/nM9GDYKo1rAOsbKcRxyoDB4R1u5Xb6MfVZ
         yEBNVAW4wrEeQgkchPcfTEsj5GgbQaVwAWVHhZ7XsEYQG9pFq9tM9Pa/sXxj5E5ll281
         6Esg==
X-Gm-Message-State: AOAM532mlbOsiNfEnwFDQ4N4BrSeq5c680rzm9N6DZfGBVwgPYgHzkui
        Sij+QHrKezUkUDrKB/yqrYHThJCTw6F+x06UemrqtA==
X-Google-Smtp-Source: ABdhPJwPiM+NKEtruzRpK/NiP66bEuzTYZ4j9DmM8ubfJBKgrpBiXCa+LC9RkMHZ7UAJFPKXOAuDfLO0UiUHM5H7org=
X-Received: by 2002:a17:90b:18f:: with SMTP id t15mr12593468pjs.168.1628722058608;
 Wed, 11 Aug 2021 15:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162854811511.1980150.3921515741758120378.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210811194905.000034f6@Huawei.com>
In-Reply-To: <20210811194905.000034f6@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Aug 2021 15:47:27 -0700
Message-ID: <CAPcyv4gZgkTtoVhMR+YWZHv2P9xeBQ3-a_2nRQ6euSQ-eaY5Jw@mail.gmail.com>
Subject: Re: [PATCH 09/23] libnvdimm/labels: Add address-abstraction uuid definitions
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 11, 2021 at 11:49 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 9 Aug 2021 15:28:35 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The EFI definition of the labels represents the Linux "claim class" with
> > a GUID. The CXL definition of the labels stores the same identifier in
> > UUID byte order. In preparation for adding CXL label support, enable the
> > claim class to optionally handle uuids.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I've already commented on 10 and 11 so this was backfilling tags
> for the ones I'd looked at earlier but looked good to me.
>
> I'm not all that familiar with this code yet, so all my checking was off the
> "does it look locally correct?" variety.
>
> Out of time for today, and not sure when I'll get to looking at the remainder.

I appreciate the slog through this legacy nvdimm code!
