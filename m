Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E55DC433DB
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3F961A16
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Mar 2021 19:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhCXTIh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbhCXTIc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Mar 2021 15:08:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77530C061763
        for <linux-cxl@vger.kernel.org>; Wed, 24 Mar 2021 12:08:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id w3so34708284ejc.4
        for <linux-cxl@vger.kernel.org>; Wed, 24 Mar 2021 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eqthZoZ24hBKip/rpytb3Jw5ErL/sxzA8WMYUKwyAfg=;
        b=uPYi4SzDipjalS815p3jLLVPTQE5hGgWicR3QBBRxyKplVZiA81He7VrpFCy7sIE5n
         85kmUU3Af3xU689pmoJGzXSvl7aybl6vw8WvgCeTHoPVUN5wQB46+llWYB9Ek/O+zqlq
         YWlG1eMjw5j/CWTSEn2ZnfMgAED7N59RO4OnV2o17EgmcVUkFXKnNf9WC+X0JNlx+Ffw
         ip53beNMgDyCFnAdTQdGjo22pWPpTcbuCpcYETFdsUjTjeWh3/yOWzyKyv1vMwZ0EmpQ
         lFztkPRLKq4E2VTgYlMxP0025WvafUkbUPZoAGVwVyYfAUAPhOnSDJThBU82PpO3nUdI
         GBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqthZoZ24hBKip/rpytb3Jw5ErL/sxzA8WMYUKwyAfg=;
        b=nd1w6l/GMyUKGrxFzyBPn6dQOGnndKnqdgHhtmDgmzb0z4pc5iCq8AuFM9cAJthgFg
         U5Asj3+vtw2nAEd14uAU340IO7SUaua5Kb+/cioGoQsyL2IYpn1Dp3Axj3T14YBaPcnT
         OCP5ADDJOsLLdFPMjQLLOkNI3I1vlWWstSz18DidKXbo1oXPM/lv21mubIS4YHniC8lK
         FZZdzR2ionuzErrQeM7LqxeKyKkX8xgJ+ICVMlix7jn8UaZViWiaQ4OBrA3TIoZFL5Ri
         WpT4muJYi7cx0lvH0qi22uMsagVUeZyNTP77sOOW1lYaLX7ZcsQ8/2Oxu/cCV/ioY8R7
         qV+w==
X-Gm-Message-State: AOAM531lZZCfmOY+/ut3RX8F7UNMe3oOIWYa2Q27psCjvbxEJMjcUFGE
        UfxZb8BMvrGA3NJecIIIont1MW/XMXtPc0LQUD4AYhcfRcDk8g==
X-Google-Smtp-Source: ABdhPJwLaZcOmB8Yla1Xr4tCyTq80RomQZM0ap0Otgk6RtHaE3ue8wlnH2Dno8OBfAXEhtzM0znVhi5j65z4fk7OxS8=
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr5403301eje.472.1616612911208;
 Wed, 24 Mar 2021 12:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210324141635.22335-1-rrichter@amd.com> <20210324184257.GV3014244@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20210324184257.GV3014244@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Mar 2021 12:08:20 -0700
Message-ID: <CAPcyv4gNvnMEL3kOjTYJjYG=7-N=jUUg-5+EqVszEHgSvF+XOw@mail.gmail.com>
Subject: Re: [PATCH] cxl/mem: Force array size of mem_commands[] to CXL_MEM_COMMAND_ID_MAX
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 24, 2021 at 11:43 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Wed, Mar 24, 2021 at 03:16:35PM +0100, Robert Richter wrote:
> > Typically the mem_commands[] array is in sync with 'enum { CXL_CMDS }'.
> > Current code works well.
> >
> > However, the array size of mem_commands[] may not strictly be the same
> > as CXL_MEM_COMMAND_ID_MAX. E.g. if a new CXL_CMD() is added that is
> > guarded by #ifdefs, the array could be shorter. This could lead then
> > further to an out-of-bounds array access in cxl_validate_cmd_from_user().
> >
> > Fix this by forcing the array size to CXL_MEM_COMMAND_ID_MAX. This
> > also adds range checks for array items in mem_commands[] at compile
> > time.
>
> Can't we use ARRAY_SIZE?

An ARRAY_SIZE() check in cxl_validate_cmd_from_user() would work too,
but it wouldn't give the compiler protection that Robert mentions for
going the other way where mem_commands tries to add an entry that is
out of bounds relative to CXL_CMDS.
