Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14533C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 23:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6448610F9
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Oct 2021 23:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhJNXfr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhJNXfr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Oct 2021 19:35:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1538C061570
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 16:33:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f5so6910914pgc.12
        for <linux-cxl@vger.kernel.org>; Thu, 14 Oct 2021 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Jswe3R1B4VfWqfjRbG6Ud02Qe/FCGGNBzIi1gtFNqg=;
        b=RK5lLJi3+ze1eOuntTw/jCBXxTeZ97uZy7OvrLculC2mlbmsT4LFUZXm69fHye1O3A
         MA8+EyMkwblo0zw1ktT5n3TEW/aOsJ0C3tWrbg/wQJfgeVF1sjvtcnTu6ZROOr3uJnc+
         GRWcAcI8BP2wrqFD7LFgq3Z8qNUe5R5AamwLQ+R5IsG78kyfzireb/pib2tLmqNF6a0j
         4DfnvqkljjiqtHystR1QnuYOc1SlfUkWoEdwzo2FmhOyyvmSvIcuzSQU2OjbIkypDiWj
         6MzfCvG/Zb4yYf3tcWwiO+FWmQLjUSn9LNzXaejzJMihVbQmI9qfFXpYGeaBIgSsXZjT
         yTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Jswe3R1B4VfWqfjRbG6Ud02Qe/FCGGNBzIi1gtFNqg=;
        b=QEHmzG6zhOvIdrfQwrjEbpVtT0gCSbIKQIW9+xsN3H2BvW/cPrCVUDEoN3G8l5BbRO
         BzRCnf7YYj1BdZzvo5lwt69tfaKm1x7FgxsZfyve/lQMth4PJjM6Ap83GlnAKFFjdgyx
         GhzYMd4D+++Hkufv6ImZgZSi0iP7SAEaf/zH/MZNu+qG7cN3wL1dP/v3m6+hz1rPHkZD
         VZwBrIB6qcb9MdAARSuU9a5kBC/kv71cZXAFrIduaMTLH6aU8beymW4nbEoGUD62qy9z
         2JdDwhP0RCojWjoQNp/pHviON0tHHH4xGtYQv1G/igEYGfm75aKH9VclTZmT90lyk52R
         nAug==
X-Gm-Message-State: AOAM532Xlvyw6FA9+FW4c26V3qFSWTq+AGFPng7CA5oyrysns5RDNegK
        +pvVpSQUWYAyzjtrpNzRj4zjKzZJrInmDqMzbF958A==
X-Google-Smtp-Source: ABdhPJzT+hk/s1aZs1TKlM05Q0fxCTVYdLx3Dr/d+atwp+D7aq7+hU7rOlyr3IE2RJlY6KYZze+/nsI2UZlZa6YHcSI=
X-Received: by 2002:a63:6bc2:: with SMTP id g185mr1632779pgc.356.1634254421450;
 Thu, 14 Oct 2021 16:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211007082139.3088615-1-vishal.l.verma@intel.com> <20211007082139.3088615-16-vishal.l.verma@intel.com>
In-Reply-To: <20211007082139.3088615-16-vishal.l.verma@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 14 Oct 2021 16:33:31 -0700
Message-ID: <CAPcyv4gO3XHgS0Agxgg0ftVPZp5rdQKW-U8KKU_BVaaWgPLGiw@mail.gmail.com>
Subject: Re: [ndctl PATCH v4 15/17] ndctl: Add CXL packages to the RPM spec
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Oct 7, 2021 at 1:22 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Add CXL related packages - the cxl-cli utility, the libcxl library, and
> development headers to respective RPM packages in the main spec file.

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
