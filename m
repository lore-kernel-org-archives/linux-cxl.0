Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23642C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 23:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiGNXQz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 19:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiGNXQy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 19:16:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB3670E52
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 16:16:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso4547203pjo.0
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0U4hhVqs2XR4EGw7i9A15ZtnFqXn5xHqzpWu8rdBRXQ=;
        b=QTwTjlefrBuqy2BMDgdjp0mIxBocMbXhoHlpn7pYKIWdee558ap9B8I6D4gINjGDWZ
         VhDCf9Pj4X7dquH0h1IgrCgmin3bzDsrQW4/xW/Rvpn7pueDufpMHkxjfAKMyeeJMVR1
         VC4Sbm99NCuOb15242J+NNMl9sQHy/ED6HJ3FvoEmBcfMQ/ToBJp682oQsFCitekjWRq
         +0mVdNJ/2+SD6msmKon1sKAPOvquoDf8M5h12+/9wjxy44fdOZ+4WE4WTTdeUjPE8zgj
         6aVj78gf7m49wc94wOzlrz3GxMUAoQS+743g4D27oDGO7BnTTkFEF3bD8TSu8AlUKxvY
         9KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0U4hhVqs2XR4EGw7i9A15ZtnFqXn5xHqzpWu8rdBRXQ=;
        b=G9la0WHxd8y78UtfZ+01HUmkBiu5JD9O91JtAZpME0SFOAoYXO/Bm1LrimR8DabZmd
         VHV7NtQLMzg78w4lKHFHmvk1DlYL2/zU7JUW8zY54+habBeYn3CzEhPGOk+wfv8iPnSz
         LL0NJCIq+QYQFTLhXkNO90EKJgJLWAHqd8A16FddujlYZoIWDQ5HluNP0hE1O+ZCZDYM
         4SLMwNf3UTWkVoAt6V93N01u8vAGY7fBgT6sL9rJOev1DaT/xPqCRKgEDkInov314kdV
         kl9FyA9f0qkQCBS1Dq1uIE0eftQFqikXu0OjMfOzQHF/+Zhy1UqGvd7sKGLhO3q4DkDH
         uRJA==
X-Gm-Message-State: AJIora9OHKI01TlhJJOtNhEzNKZ19da4BEN5ICmtMSMttmnL+5iEXhsE
        IaogYv2FgIXRGw2AjlItHqI=
X-Google-Smtp-Source: AGRyM1v20eluAf47eDG4BGowBvU11p4wm1w2XSBjlm2hd7FAZFn4EmSR7QwxAE9cs/yAWXdaDh0ZsA==
X-Received: by 2002:a17:902:b08a:b0:16c:68b6:311 with SMTP id p10-20020a170902b08a00b0016c68b60311mr9936361plr.166.1657840613057;
        Thu, 14 Jul 2022 16:16:53 -0700 (PDT)
Received: from MacBook-Pro-91.local (c-107-3-179-31.hsd1.ca.comcast.net. [107.3.179.31])
        by smtp.gmail.com with ESMTPSA id w6-20020a17090a780600b001f09d9b6673sm1999509pjk.7.2022.07.14.16.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 16:16:52 -0700 (PDT)
Date:   Thu, 14 Jul 2022 16:16:49 -0700
From:   Matthew Ho <sunfishho12@gmail.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH ndctl] cxl: Add list all option to the cxl command
Message-ID: <YtCj4feLExxytkPt@MacBook-Pro-91.local>
References: <20220714182737.60714-1-sunfishho12@gmail.com>
 <8546b123eb6303db6b863a2670d64aa87434f196.camel@intel.com>
 <20220714191521.sy45sjpkpxijdefr@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714191521.sy45sjpkpxijdefr@offworld>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jul 14, 2022 at 12:15:21PM -0700, Davidlohr Bueso wrote:
> On Thu, 14 Jul 2022, Verma, Vishal L wrote:
> 
> > On Thu, 2022-07-14 at 11:27 -0700, sunfishho12@gmail.com wrote:
> > > From: Matthew Ho <sunfishho12@gmail.com>
> > > 
> > > This adds a new subcommand cxl list --all, which is equivalent to cxl
> > > list -MBPEDTHIiu. This addition makes it easier to list all the CXL
> > > devices at once, as one does not need to append a subcommand for each
> > > device. --all is also easier to remember than -MBPEDTHIiu. When
> > > region support is added, this will be updated to include it.
> > > 
> > > Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> > > Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
> > > ---
> > >  cxl/filter.h |  1 +
> > >  cxl/list.c   | 15 +++++++++++++++
> > >  2 files changed, 16 insertions(+)
> 
> You also need to the manpage (which I also missed) via:
> 
>      Documentation/cxl/cxl-list.txt
> 
> and of course, same for Vishal's suggestions below.

Ah, will add.

> 
> > 
> > Hi Matthew, thanks for sending this - I agree it gets tedious trying to
> > list multiple things.
> > 
> > However, I think we should do this similar to ndctl-list's --verbose
> > options, where adding the number of 'v's adds in more and more detail.
> 
> Yeah I agree, and was not aware that ndctl has this. Furthermore perf
> tooling also uses this.
> 
> > 
> > For example:
> > 
> > cxl list (default) : Regions and memdevs (this isn't there today, but
> > in a pending series I'm about to send out).
> > 
> > cxl list -v: -RMBDPT
> > 
> > cxl list -vv: -RMBDPTi
> > 
> > cxl list -vvv: -RMBDPTiHI
> 
> Makes sense to me.

Sounds good, will implement it this way.

> > 
> > -u/--human can be excluded from the verbosity levels as that can be
> > passed in if needed, and there may be use cases where it isn't desired
> > (in scripts).
> > 
> > Thoughts on this - do you want to take a shot at implementing it this
> > way?
> 
> Sounds good to me.

Will do.

Thanks for all of the feedback!

Best,
Matthew
