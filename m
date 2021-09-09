Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B32C433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 21:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E04610C8
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 21:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345513AbhIIVLz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345073AbhIIVLy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Sep 2021 17:11:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1ECC061574
        for <linux-cxl@vger.kernel.org>; Thu,  9 Sep 2021 14:10:44 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id l11so1925153plk.6
        for <linux-cxl@vger.kernel.org>; Thu, 09 Sep 2021 14:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG1c0x+0/lVVOXIHX3HpgQkWwFlp9iGDH9PblGIsiAk=;
        b=EyRlvOY8RpnBWH5Nbr4sKz/zrlu2CSQocU0YQiaEjF5OoXFMfbxS2pQZMfAXGMXIfv
         erHLWdHJOOBhDOIqrznjhwBddqBIpjWNM3JvkFcHvRmGPMAv8DK5gzNjP1EypQPnC9hD
         aRBPLIXAORFW0R8f1YUGsVAxGum/gwB3/a+23ZHLMBVPYS4+9NKvNPCh4gmVjwskmhnS
         ecq9gnqeAA6cUwiLc11hHD1aFF/VlEqIER/5/fs22oQ4Il4TLxsvCgtT2OE2nGnWspw1
         Pg8jkIb2tUOyMKqBxG2VNKn7JYI0S4+3+4sjpFw6GJ8u0BtquhuCVLlw9nZwkzwOP4mu
         W8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG1c0x+0/lVVOXIHX3HpgQkWwFlp9iGDH9PblGIsiAk=;
        b=2y7JmdJXJxr3sRbqpwVzfiz99dRqgstgHze7lCIi/rDfFKdC+o0PxSu35WO+P3+RSM
         9REkN6LhDNq8a0mNL34zEr2clPbsJ8/Nj8mzd6m8SpaNATdhHaSdme09cuOETmZdXRwh
         6fBmc+nigjMRUAF2AUOChlA0zaGS9zQGJwmQdrYOvQAVAfmUKriY74nNgh/5hXZiie9r
         Vwmhw4zZvDcmJXIzDW7eRZ07WuwZlE03kIWXLBfBWLHc4Y8ZBCWQuDhNJ56ZIDpFlzxQ
         swtlh1goH6ZBOywkNeXKr7d0q5NCCeFm9bjOPTv2k0UIxSDlGvkMm0CN3PblrQd35I4K
         6A2g==
X-Gm-Message-State: AOAM530jYi/OOkHzLXJ85P+RKqkM3sQIydgqnwpdRgeF6D80ymiUOJQh
        viDegvULo1HXolEFBWyqUNHvmPqUYQeSitethUJToA==
X-Google-Smtp-Source: ABdhPJzlxcCP7Hb984HZFtYsiJ0Isrx0l8Uh6HhNFtFSwIMpAEt6kIRDehsecyRJmVHfOo4UQRQZuLiRxY+agEjLV9U=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr4427221pls.89.1631221844391; Thu, 09
 Sep 2021 14:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116433533.2460985.14299233004385504131.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210909162005.ybqjh5xrbhg43wtr@intel.com> <CAPcyv4h3LmmpTt_0Om0OCxWPXo-8jucA-9p3rwhx_j2vCFEj9Q@mail.gmail.com>
 <20210909210527.eyxreaq2vim3wfps@intel.com>
In-Reply-To: <20210909210527.eyxreaq2vim3wfps@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Sep 2021 14:10:33 -0700
Message-ID: <CAPcyv4jFcEgbZBrBpDZJ+ciyaUz8ev3xj2A3kaDAOcgTCM6V2g@mail.gmail.com>
Subject: Re: [PATCH v4 08/21] cxl/pci: Clean up cxl_mem_get_partition_info()
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 9, 2021 at 2:05 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
>
> Caching is totally fine, I was just suggesting keeping the side effects out of
> the innocuous sounding cxl_mem_get_partition_info(). I think I originally
> authored authored cxl_mem_identify(), so mea culpa. I just realized it after
> seeing the removal that I liked Ira's functional style.
>
> Perhaps simply renaming these functions is the right solution (ie. save it for a
> rainy day). Populate is not my favorite verb, but as an example:
> static int cxl_mem_populate_partition_info
> static int cxl_mem_populate_indentify

Sure, I would not say "no" to a follow-on cleanup patch along those
lines that brought these two functions into a coherent style.
