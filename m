Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8231C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 18:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiCQSqj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiCQSqi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 14:46:38 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39685D5563
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 11:45:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z3so5181410plg.8
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNtp9FR6dDO4XgEHXNGD5F1nM+oT977bFwfTyeWW3oU=;
        b=Bgn+Fd4VxGDm331tGMCq9yABSmsvxJNy2GQ2MA+THXeL5d+V2Lqggj/6jjTdcJutsV
         IcnJfvojozWayGh4EFNrojtoFwg3CUPdNrhDjyAAwe9QpCajv6wlsA/ANvDadM6DhBc/
         ebVgCKkTP9KCwZdG0ZutD/J7l0lI0ade+qqXhaYC3fFW/OP9O96TVYp1J8Grva3KY3Lw
         tSJf75xga8gG0zE4kixxxK86/46OIe097L3rn+SdSJyydPo3CZjsTJrTxfEptbT0N6bq
         tFEiEg24VZfbf+1FNtMT+O+7OstoFEqokffFjgmvb2GbMK1gKJiZp3SIUNOyxSYkaaPF
         EzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNtp9FR6dDO4XgEHXNGD5F1nM+oT977bFwfTyeWW3oU=;
        b=z51kFBHxYjKt/q8rR2aCAhdJ3x6JwC7VJA2kFPIBB7HLpdJNlxiwE117+Hwn8aljUk
         J5XANReF0zXc6JCLY/F7r05ZLnHKWf+Mr2A8I1Pz31CueuRM408m49laRpCXZhvHvlMf
         xM6E7CtUlXCfwuAGY4gLEUz9XMBajnD2h/7qrx83mzbxo+RnB9RKuL9vchJoFDDvTyoc
         VTtqUtn98HRqzMwUULUWMhPnZ9XVOorGFIUXFt7k0UGDvQy46Ckq0oOJLpAb6RsnRsK5
         YiHIVGfphKRzgXRP9EpQr1u1jprUAUMl8/2t0A7sPquEb1prw8VB7ijN1Cq1qwu8evG0
         0Osw==
X-Gm-Message-State: AOAM533pelsS9Uh10a9pNkGH4z7WCzPTMTPURjCvZdfmYhMHMdHB1cLz
        3gEyOjk6r23p6+cYW7MY3IZrcj1nVEb5bwZsNAT9RIY+iuLSXA==
X-Google-Smtp-Source: ABdhPJyPv1xK7sSgN0d3nV/xcuaT/YY8t5hlvFAFS9cGdhp/n7ne/bZCVZPgXPqzKVVd73f/F2QvH3TqdpZSYQs6+LA=
X-Received: by 2002:a17:902:d504:b0:154:172:3677 with SMTP id
 b4-20020a170902d50400b0015401723677mr2169838plg.147.1647542721716; Thu, 17
 Mar 2022 11:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730736435.3806189.2537160791687837469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220317175426.bj2bfmrkc4ep2uxk@intel.com>
In-Reply-To: <20220317175426.bj2bfmrkc4ep2uxk@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Mar 2022 11:45:10 -0700
Message-ID: <CAPcyv4jX1p7stLOuEoGvnNXhwerbe13R-RTnnTnHskCJFyqM8Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] cxl/mem: Rename cxl_dvsec_decode_init() to cxl_hdm_decode_init()
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 10:55 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-03-14 18:22:44, Dan Williams wrote:
> > cxl_dvsec_decode_init() is tasked with checking whether legacy DVSEC
> > range based decode is in effect, or whether HDM can be enabled / already
> > is enabled. As such it either succeeds or fails and that result is the
> > return value. The @do_hdm_init variable is misleading in the case where
> > HDM operation is already found to be active, so just call it @retval.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> If we're doing the rename, which I'm in favor of, maybe making it something else
> instead? I think init is usually something which cannot fail. Perhaps
> cxl_hdm_decode_probe()?

I think it's init, or at least not "probe", because the "probe" is
what devm_cxl_enumerate_decoders() is doing, right?
