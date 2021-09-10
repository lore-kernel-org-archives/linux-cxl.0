Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38189C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 19:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB6A611EE
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 19:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhIJTBw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJTBw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 15:01:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FEC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 12:00:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w6so1751387pll.3
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfHDEhHIHaQZKQiQV1uFMmIq9850LcL1pXZWyOJHksI=;
        b=IDHF8NLD88kefhZXmuvQlpxp3yhS6QwE0PCzH7gTFANy5dR2fLT7yfqLnvsDwo+sz9
         aNG2QxMMFdtT1mx4UAulyWZA5rEFCmj4jBjTzBIudWJU/4C0sT8532UoKa3PGCy1YLS1
         7nUQ2QJwKROTR/J/KFYiMquolHpPGe9E+qP5hPEUo6ndzaB8MKkvJBRqlluWb54rDDAa
         7sYcXtOAR1FtAfITigYj06eLf6qMLk2bBiCKFIBrpjE5iVNLPdayIeR1Q34zPSBZ5TUc
         HQK4bVVL6GZDwoWCEYATFhZgfdAPBW7hpRGO92hSd50Wj0DCYuqDRYVeWak22L13CxOt
         7yLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfHDEhHIHaQZKQiQV1uFMmIq9850LcL1pXZWyOJHksI=;
        b=eGazAxKHNsNqBkJBfTc0PqDzEBUiorW9WEv3Epfx25ND5VGaSFMn0N0bUPvOVJSTu0
         8bcKNqRdmZ0E8bL1LAfAXLx3rzr9SDnYQ822HlKVP9G28v0Z7hAgtMZfbr/XAufRdFJV
         VeKp+9+qXAG0SjTOjv9pNxyd1GZGYh6K08u5Z5ft1PmaRxyHxGY/ajd+DzQX768VLbmj
         JchGaZSEnoYDb5x+GIKYqRznKjujMhNHuoDLTIuGnUdeG93VJ2CNHTUHelQU6u34TOek
         91NiZlqSKjKhZNZUTs9vZ0tg9DhTTb6poTuprCA8hurYwpl8F0om62EzYGz6yli3qNKJ
         SmDw==
X-Gm-Message-State: AOAM530Ag12MErYfrWQ5RN/5pxpZSn1ljPElO53s+9dlmYPOU4Fw+Rcf
        0EAe+hZgxFD5rH5ejFOdEiLiYE/lpyDBJIwPunGHnw==
X-Google-Smtp-Source: ABdhPJyu3GyQkiJWka5uKdWUlpMVKKF8gFvMShYDlhvT4H0h/8eFDuGyRT4KuhfQTa81GETak606eSgLcGgVa1mjuKA=
X-Received: by 2002:a17:902:8c93:b0:13a:1dd7:485b with SMTP id
 t19-20020a1709028c9300b0013a1dd7485bmr8848410plo.4.1631300440478; Fri, 10 Sep
 2021 12:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
 <20210902195017.2516472-4-ben.widawsky@intel.com> <20210903152517.00005399@Huawei.com>
In-Reply-To: <20210903152517.00005399@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 12:00:29 -0700
Message-ID: <CAPcyv4ijcEMLEn4QDxDd=ML65PKG4YMnwrMBCUdSHGWKYfJhQA@mail.gmail.com>
Subject: Re: [PATCH 03/13] cxl/core: Ignore interleave when adding decoders
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 3, 2021 at 7:25 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 2 Sep 2021 12:50:07 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > Decoders will be added to the bus either already active (committed in
> > spec parlance), or inactive. From the driver perspective, the set of
> > devices comprising the former are those which are brought up by system
> > firmware; decoders that implement: volatile regions, persistent regions,
> > or platform specific (ie. CFMWS) constraints. Such devices have a given
> > interleave programming already in place. Inactive decoders on the other
> > hand, do not have any interleave programming in place. The set of
> > devices comprising that are hostbridges, switches, and endpoint devices.
> >
> > Allow adding inactive decoders by removing this check.

I thought I agreed with this initially, but the spec initializes the
default value of IW to 0 (== x1 interleave). It is impossible for a
decoder to ever have less than one interleave-way defined. Instead
"Decoder Size == 0" is a disabled decoder.
