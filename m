Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A559C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410D761215
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 23:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhIJXyL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 19:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhIJXyL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 19:54:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0046C061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:52:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mi6-20020a17090b4b4600b00199280a31cbso2068786pjb.0
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSKtVHgs0BDQC6A8k2LGZx9TY+ghccdUjzGPf+pBci8=;
        b=lTShpvIt3SQ2UB9lyrtG9BnDjvHa1qLL7pulOYcBxSfIM8kSHjGissoCZLsmPDLwSl
         sGzFnEw17rRY+57TTin6PRoN6u499Ghm2H2laZNcf8GkJGfpTfZfKlLbjVqYtX/a/H9D
         U8Z+Z+YULkqa+6hhB0hkwCRelb9+03ouhMv996yh4EUJ/sJyNg029YI0aeUz+SHithq+
         QCgSUAkhOfQwlgPVc9dh98TT6l7TiUuB/kbYVn45ynXaxL0ZTjCJTenVtMUqGbyTvJ24
         VYf71cFH+M9EmsG4gxhdobAwCU6LTF5nOGCZKxfp+L3sesHs0lSkcQ2LIBoHqB6iD8Tq
         7sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSKtVHgs0BDQC6A8k2LGZx9TY+ghccdUjzGPf+pBci8=;
        b=P38TYqll9RGkcvN6sKrsYOWcfr+U8ptNTSPbGczNSAy2l33oBkm8bSknfgn7Q57tWO
         zU82OpMvfGJzkxq5nO+5yuAb5tkAIY6/VDKKU7jml9mGWpA23LAOMdGCO34EGo1gA6g3
         yzeNhxh3TkVb6DpWhMwB44V/qjbN4uFFJl/GThokUspKtqjfRwvz4rTotx0uFdd5sNp7
         IYGMgvDKmYMKzFRr2Z+mZK8t1hx95QCrHhime19ecjmLsysq3DNzNTHtwvsFCVZsrdHx
         oz+lpO64nFPvhQDNw/8D/PRtvshStONNzVDV6w3IWrpTfgseqLZuYCC/NwyKIyHozLCv
         yKmQ==
X-Gm-Message-State: AOAM533+cQHUoKVBfyS1Ei7RblrkeudDLTsUsz28PPivp/zAKlPPADIZ
        86fVThacghpStVdO662g2FGSxtmeh2tbS6N42rWGa8WpUUE=
X-Google-Smtp-Source: ABdhPJxv/Oic2ignlcDAD/Bi/2nIAUmNVRfg4Gzw3hV4KVE5tbwQHEvY2UdZdPidAhbPkBarZvTLzuDyXCz0cgPPf6Y=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr150547pjb.220.1631317979173;
 Fri, 10 Sep 2021 16:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-11-ben.widawsky@intel.com> <20210903171405.000024fe@Huawei.com>
In-Reply-To: <20210903171405.000024fe@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 16:52:48 -0700
Message-ID: <CAPcyv4jkw+QGwc3ZrQkVvOLcLpjstcyYror-TYKJQUZT1An9gA@mail.gmail.com>
Subject: Re: [PATCH 10/13] cxl/core: Map component registers for ports
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 3, 2021 at 9:14 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 2 Sep 2021 12:50:14 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > Component registers are implemented for CXL.mem/cache operations. The
> > cxl_pci driver handles enumerating CXL devices with the CXL.io protocol.
> > The driver for managing CXL.mem/cache operations will need the component
> > registers mapped and the mapping cannot be shared across two devices.
> >
> > For now, it's fine to relinquish this mapping in cxl_pci. CXL IDE is one
> > exception (perhaps others will exist) where it might be desirable to
> > have the cxl_pci driver do negotiation. For this case, it probably will
> > make sense to create an ephemeral mapping. Further looking, there might
> > need to be a cxl_core mechanism to allow arbitrating access to the
> > component registers.
>
>
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> As you predicted I don't like this. Needs some thought on how to get
> around the mapping games though and it's Friday afternoon so I'm not
> going to offer any concrete answers...
>
> Not totally obvious to me where RAS will be handled as well.
> I think we definitely need an arbitration mechanism here.

Poison consumption is handled via typical memory_failure(). Event
record and event interrupts can be handled by the PCI driver
potentially notifying the memdev driver if necessary. Port specific
error handling (RAS component registers) can be handled by the port
driver.

> Wouldn't it have been nice if all these capabilities had been nicely
> padded so we could map them individually.  Oh well!
> Gut feeling is this will only get worse for future versions of the spec
> so we should assume there will be lots of stuff shoved in here.

I'd prefer to run away from arbitration and towards sub-drivers
providing services with distinct lines of ownership. In the rare cases
where a driver can not act independently there should be a well
defined driver API to request help from the register block owner, not
pass around access to the register block.
