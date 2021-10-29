Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088EBC433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FE961040
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Oct 2021 20:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJ2Udi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhJ2Udi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Oct 2021 16:33:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9115AC061766
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:31:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y1so7536539plk.10
        for <linux-cxl@vger.kernel.org>; Fri, 29 Oct 2021 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ymmo2A7BEQ1+28sc7A2NxErQEApUXGqGSzSqJXEh2pU=;
        b=Q2cuz+3eePvcHvAkE04MigmpYT21zC6M/9I3JJIoCa9/YpPiJrLnYEMhj0bTAJZWXy
         1pYpKA2TSwTbqo6v0xU2ectDkple0835FZn0k5HI08tahgVBVzzj/BwM6n8KvaDILQad
         RFQrRlnoOuMtTeqzCJmIzAy269z35DQl5kvUT5OgxpHBRfwT/wdO0N0jPhpVlfOk5Lca
         pky8v75VaBXO06meQ4Fk1r8+HLkidZF32JhMR4Ng3uzZn9MCb2TMV1z81DPLMrgDNrvV
         +u/dN0W38c5ayUI6lgSxr8juGpLXkmDYduAOMchoU58ZyqlgvSD7OsRPMJZawRB6iycX
         JBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ymmo2A7BEQ1+28sc7A2NxErQEApUXGqGSzSqJXEh2pU=;
        b=iWq5rtt/LXyDdZLr5qqGLhGRzBib5jrzDQNlNLwReU7KpY068VCoaqfZnqSbbQlqco
         qu4mwcpeZnpBUBrmw1xP03q0tpUAbY0m6wPbk+vqrzyREoMRIIJultOMXVqZn1UvNp92
         w7TsQmlWkzAG43OtncaiFW07hIUzHZAIzKYfialfEvSYyzhHK7TK7Rp3y0GLU7TwBXoO
         XBbaQoH9P0/Ga376RiiSOSmEwF7Qp4ictDDLpV4gcwGg3WFn4tudUi39WIHqrdNndcOa
         RzqJ9hcVpa/aZoHwH53ZrQqRRgCyhYhiszbuMCxW/61rylgjv8mwHM+pKtBbkLtGZsIa
         NVnQ==
X-Gm-Message-State: AOAM531y+9xtqGdZ+oL++axVLnc4EeIW0f7Yo+fHg4/j+HkBD/vI1l+x
        jFRWdldLTIP3kRdybJ7FgJRA/X2YjtxkrSBkcC0yHQ==
X-Google-Smtp-Source: ABdhPJxiyOWCIr03ZgQZ4kDVGpJ8EVC3EI+NXLQyhT62zzUqc/L2g7WHKj3syXVpId3sssH80wthf3Kk/cAgwg4oynk=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr13449184pjb.93.1635539469120;
 Fri, 29 Oct 2021 13:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com> <20211022183709.1199701-5-ben.widawsky@intel.com>
In-Reply-To: <20211022183709.1199701-5-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Oct 2021 13:30:57 -0700
Message-ID: <CAPcyv4jn9E16SA=nVpNcZLN+OqbxoLoKn_t4gYt9ikpywecXrg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/28] cxl: Add helper for new drivers
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

s/cxl: Add helper for new drivers/cxl: Introduce module_cxl_driver/

...as "Add helper for new drivers" could be any kind of helper
anywhere in the stack.

On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Many CXL drivers simply want to register and unregister themselves.
> module_driver already supported this. A simple wrapper around that
> reduces a decent amount of boilerplate in upcoming patches.
>

Other than the subject clarification, looks good to me.

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/cxl.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f06c596fad71..4483e1a39fc3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -317,6 +317,9 @@ int __cxl_driver_register(struct cxl_driver *cxl_drv, struct module *owner,
>  #define cxl_driver_register(x) __cxl_driver_register(x, THIS_MODULE, KBUILD_MODNAME)
>  void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>
> +#define module_cxl_driver(__cxl_driver) \
> +       module_driver(__cxl_driver, cxl_driver_register, cxl_driver_unregister)
> +
>  #define CXL_DEVICE_NVDIMM_BRIDGE       1
>  #define CXL_DEVICE_NVDIMM              2
>
> --
> 2.33.1
>
