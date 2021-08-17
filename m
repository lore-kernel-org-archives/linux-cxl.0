Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66307C4338F
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Aug 2021 16:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432B060FDA
	for <linux-cxl@archiver.kernel.org>; Tue, 17 Aug 2021 16:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHQQwh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 Aug 2021 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhHQQwh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 Aug 2021 12:52:37 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317E3C061764
        for <linux-cxl@vger.kernel.org>; Tue, 17 Aug 2021 09:52:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u15so10084609plg.13
        for <linux-cxl@vger.kernel.org>; Tue, 17 Aug 2021 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuMU3NKJV0Qaon1OEUkQT8bISVW5W0Zw2uFMcUvexXo=;
        b=Zo9002grxB/duRaRQsGW5bjvCwWDtyStxev5oQaGHclIiZeni2EADL+7qj4gIrllqN
         ktauVcSMrb61/lomi8byPN9nl+irdT+AwWtghlfzCXLzAlIHuAQqcrbqEJQ8hE4n10yl
         vqMAG4zO/+uHigKs3B06Ee/P3lmiM+6WM4pXzu0XX5anJ3w0/UHAuGW8VwZWNzxk/bDe
         cdUl0sVdtuci+CyNRopTUnSfMCT0X0SINdJlFMxmrRhquTMW0Fraq9X8ho6bBaGBc6hC
         4K5vowSPJ7hMR3t6D2D8l8bVH0Un4K/DQR/f6aQ7ijb+Y7UqE+qq3ADYnE9Fdnym2kYn
         tz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuMU3NKJV0Qaon1OEUkQT8bISVW5W0Zw2uFMcUvexXo=;
        b=jQXri72NDUZnMyfdZoM2zr8UlTq2DDk9nWoJS2TsS9Mt8O5p3pgXR2ZG3DzZkao64G
         XT6EOYLtssDLVMa9rLGN0yemt870Zp+kwjj2+AbJ7QkphXci1bnsxbV73tIIq3HXoGFJ
         lQb1IZZ5JoX4YR5BZ8g658bZ3eahXBr580PNEnhAY7C0rqdnFteedjFWX/SJgUQUkM4i
         gq/anX3O79Lk3t+s3dafTJttmfOEN4dbumMxhk1oB0gQh9vE+rhJmrIoimU4Jp++34nm
         uG5k6E1sU85aS70etYky7r+LfedMtSXf0Raq5Wkt5BzKz4qyV1FtDbm6mcJxAus7gQnf
         /U9w==
X-Gm-Message-State: AOAM533UoBisETaYYzULs+fxU4iGMIthmJtxbqtObb+4hzw7JxoSqEpM
        eqro8fPkMbk7rg8JLJbrrlBGsPvhKjbIccRa42wiuQ==
X-Google-Smtp-Source: ABdhPJxcWl7uEEo48tpe6tTiOGAoaE4QE1hEhR6E4tyRLc+jx9jf57BN5VYtw57RZsFuF7IBYBnG2Zmq80a71PcCAYU=
X-Received: by 2002:a62:3342:0:b029:3b7:6395:a93 with SMTP id
 z63-20020a6233420000b02903b763950a93mr4442002pfz.71.1629219123730; Tue, 17
 Aug 2021 09:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210817034908.149795-1-alison.schofield@intel.com>
In-Reply-To: <20210817034908.149795-1-alison.schofield@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 17 Aug 2021 09:51:52 -0700
Message-ID: <CAPcyv4iwM+JkExmg=bZRBU0-BKb0EGGCmKCiMEj_S7ve-AgoNQ@mail.gmail.com>
Subject: Re: [PATCH v2] cxl/acpi: Do not add DSDT disabled ACPI0016 host
 bridge ports
To:     "Schofield, Alison" <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 16, 2021 at 8:39 PM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> During CXL ACPI probe, host bridge ports are discovered by scanning
> the ACPI0017 root port for ACPI0016 host bridge devices. The scan
> matches on the hardware id of "ACPI0016". An issue occurs when an
> ACPI0016 device is defined in the DSDT yet disabled on the platform.
> Attempts by the cxl_acpi driver to add host bridge ports using a
> disabled device fails, and the entire cxl_acpi probe fails.
>
> The DSDT table includes an _STA method that sets the status and the
> ACPI subsystem has checks available to examine it. One such check is
> in the acpi_pci_find_root() path. Move the call to acpi_pci_find_root()
> to the matching function to prevent this issue when adding either
> upstream or downstream ports.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> Changes v2:
> - make subject line appear in mail header

Nice, looks good. I'll fold this in before cxl_test since it's a fix
we'll want to get into v5.14.
