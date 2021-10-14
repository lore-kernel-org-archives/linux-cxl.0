Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EA1C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 23:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E53610D1
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 23:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhJNXdz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhJNXdy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Oct 2021 19:33:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E3AC061570
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 16:31:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c4so5216859pls.6
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zk117L+WOnl50MYqP7yWKfZsHaGGLpM/r10Mqd0sAuk=;
        b=ophpHfGFARwDPV4GvxNIHeRwXNoCBFTfqfgJufSSbxJ4YULtjTirgd48E5Q4wftQfc
         A27p7dvqhv2GOrprIK8y7XEPZSOWNmW/K2f4iY4euiwvhxdUcFgyZJbZVDLh2/xuzhOY
         yhFAyOnVDnapJRFvqdJ6RJirnSU6xfrUJ2mfBotKI9UheNXkjhvw5wfKUREe/SaPc7vs
         BV3RcYgTAl5CSDUwEL0CZQi6so21oWty04xi0E+hfQVVA0Nh/LRINaOFauxIp1plrnEW
         KrbzxI+6FiZuJaSQR8rGks+smcniV6CNXelg1lA6atRB7CC4aBnLmlVvXnsXCUVlP3DN
         PxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zk117L+WOnl50MYqP7yWKfZsHaGGLpM/r10Mqd0sAuk=;
        b=EDUdJNuO14FLUDWw6nnE/hS9iDlWPBA/O/Myohxn0ZZQkufzvyD2a+4GYWpxUAav+J
         nCmNfv1CuZfj0VsVgvdrJMmFXj6Tfs3cRt9DR+Sn2J9w+rUZZqfK3O6Pr4xXkHGn7CaS
         GPUSfHAhmINSf+XgLvYElFZGFabDQuNoo1hvHbCaYU6NmysSGuSRUZC7eahPmkfUiksm
         PikcoBUEd8O+3c3Jso0FabxLHN5/yEmnT4N0lulaVoJDqKhgmp7asST/xi18YXOuK1gO
         GswMLkVS2TX8TEct5Rm33ExEOpLmGcpp+CxqNbm0bu6IQn4JpSfuc/PZdnpVBTska4fc
         +H6Q==
X-Gm-Message-State: AOAM530WgONfZGXcgulBp2PJyi+cAEzs5n5Bt96CKIzhU4+GnKBVJWGE
        kitObaxtTYCCzHJtUj2nCPCjgG57tTfcWpL75M9D+ReU9c7CRw==
X-Google-Smtp-Source: ABdhPJxRhRJZ5H0p7J/EUNnVP+Vzg7jMAc/Ub1NI7Byv9GdJlXjj+MyGg/Irjg+jGhfLJN7kQqs+hI0Q1/xqXe3ZbEA=
X-Received: by 2002:a17:902:8a97:b0:13e:6e77:af59 with SMTP id
 p23-20020a1709028a9700b0013e6e77af59mr7689537plo.4.1634254308964; Thu, 14 Oct
 2021 16:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-15-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-15-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 16:31:38 -0700
Message-ID: <CAPcyv4ia2qeMFNxSRbLbL2+EDEVbiFSj=k-fPmzFdBCa9G9Awg@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 14/17] Documentation/cxl: add library API documentation
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add library API documentation for libcxl(3) using the existing
> asciidoc(tor) build system. Add a section 3 man page for 'libcxl' that
> provides an overview of the library and its usage, and a man page for
> the 'cxl_new()' API.
>
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  Documentation/cxl/lib/cxl_new.txt | 43 +++++++++++++++++++++++
>  Documentation/cxl/lib/libcxl.txt  | 56 +++++++++++++++++++++++++++++
>  configure.ac                      |  1 +
>  Makefile.am                       |  1 +
>  .gitignore                        |  3 ++
>  Documentation/cxl/lib/Makefile.am | 58 +++++++++++++++++++++++++++++++

For the meson conversion I have hopes to be able to unify all these
duplicated custom build rules, but as far as I can see even Meson
requires this duplication and can't share build templates.
