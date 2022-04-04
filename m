Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443DC433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 03:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiDDDlh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 3 Apr 2022 23:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357416AbiDDDlf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 3 Apr 2022 23:41:35 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F443981F
        for <linux-cxl@vger.kernel.org>; Sun,  3 Apr 2022 20:39:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k14so7316558pga.0
        for <linux-cxl@vger.kernel.org>; Sun, 03 Apr 2022 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDRL7Fg58CRSznIsX+uUpwsvzfO16Q6Vn18HomJigiA=;
        b=beyB3PwGJFQZeEFhohudf1/G+w52FN1agmHa6GgsLsNQojlg17prS9K6hd0dE37mO7
         ZNJBqWD8gM6PogmCMoSJkzsgMeqZTlhh3Fo46aFWsaCTsR4Mbi9ly+kvYkD6PAm8MqJM
         OAyJnirZqRvHS0u99Pny7ALAix7ShqgD6McZMkDDWQoE+lNTBMsSqnvrPQOyrrt/KUq2
         KuXMOksAFB8TlhxeJtkhYH8bXWkOhIrtBVWcblYl7Vj/cIPNovE9ATX5C8COm3BKj3gC
         4XUTkk8cFz5+3Off/UI7pmMHVAxM0RaHkah8j7tIkS3zysEtfn9E1O/IWE9iZ+k6M9dP
         GXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDRL7Fg58CRSznIsX+uUpwsvzfO16Q6Vn18HomJigiA=;
        b=Pf059J6HPRoezs8ic29qtvd3XtKgAltF4qByhGyaNCCfQNWD50GkKdtEC/A2Y84mLH
         GsutYiwVbkgTLNPgehNUTrLhcFki0n7hI+LYxIMuH/jzVqdo/VpWryU1nCoksksN8l4f
         pmbjy3kPXYtQ+0iq0ojAN8y9RmEWLJpU1GiVMlgZpxsAkEVw/BGtngH3O324bZndpEUs
         1QZtmvh0vwHQZCatjNC2rQEl7wlu6pNq/ur1dIb2NSaX46mpKaoPTuLlAgWp8mKgYKOv
         gYDDqG6CAcjddpaMSc7CpOTSGxhnKnjQNcW9n1kSDAjLvQRIKkVWp2kPhxe2lLuE2wIO
         oQ6g==
X-Gm-Message-State: AOAM531NKVUVMNNbu4fz3quwNVAR83xdGRSbvALkNv7WBvUdbnoBUpAe
        ijpqo+0eKO/A/XN+VB2nyKiJgTkutzgFeA6LKZ/YOmGE1UM=
X-Google-Smtp-Source: ABdhPJyYEofIV/vCUumnrBHynddyGYZYSBLWFLQzKlN68Ug0zdDsLs9H+Q9JauL6GcSrZarriHm2eV21c0vvntcoS4k=
X-Received: by 2002:a63:1117:0:b0:399:2df0:7fb9 with SMTP id
 g23-20020a631117000000b003992df07fb9mr2084284pgl.40.1649043580247; Sun, 03
 Apr 2022 20:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220404021216.66841-1-dave@stgolabs.net>
In-Reply-To: <20220404021216.66841-1-dave@stgolabs.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 3 Apr 2022 20:39:29 -0700
Message-ID: <CAPcyv4i5vjX8jEzkT1OY2BwkbzvEpXVGkU5iQM_EiWU=eSrTWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] cxl/mbox: Robustify handling of mbox_cmd.return_code
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Apr 3, 2022 at 7:12 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Hi,
>
> Changes from v1 (https://lore.kernel.org/all/20220317234049.69323-1-dave@stgolabs.net/):
>  - Patch 1 now just removes the lock comment, instead of moving it. (Dan)
>  - Modified pach 3 to use CPP hackery + misc table improvements. (Dan and Adam)
>  - Dropped patch 5 per concerns about implications with FW. (Dan)
>  - Picked up Adam's review tags.
>
> Currently the return_code from a completed mbox command is handled as
> either successful or not. This series teaches the driver to better deal
> with the different returns from the hardware, allowing better debugging
> and mapping to proper kernel errno semantics (which are left unchanged
> for now) as well as more ad-hoc handling.
>
> Applies against linux-cxl's next branch.
>
> Patches 1 and 2 are small nits.
> Patch 3 and 4 implement and use the new calls.
>
> Thanks!

Looks good to me, applied to cxl/pending for 5.19
