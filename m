Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50212C432BE
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Sep 2021 19:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAB761056
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Sep 2021 19:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhIATUI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Sep 2021 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhIATUH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Sep 2021 15:20:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE94C061575
        for <linux-cxl@vger.kernel.org>; Wed,  1 Sep 2021 12:19:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so453384pjx.5
        for <linux-cxl@vger.kernel.org>; Wed, 01 Sep 2021 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IspLCg3oFcMgGcuKPjnrYymO26rLmbmjWCQz98/r454=;
        b=cNV1TUB+eFkZpST0sADZjI0N0vAXSwuAzPyrtDiOpaDWS5wfeW4eiDjR8cZP98rtO6
         xRmSarzHxZrBAO7DeKU7v3Y8u9o/mUHi/maWpyQ6tnlltvWEkdWfc+WXFCXMWJSJ6vyv
         IWvF1LGkb+v7XnEvBxG2PyZ1OCeqXRbttaCZTnNgWoxt60yDk7IG0TjOew01BXePLoN2
         xIOQZHv5jjDnymRiKF0FMFr9sTUtZOBixS377AAbx7++6dTw2qP6zdt8XQKg7Yi3zCjw
         KbHUfQrLFDutrpQqUZnDWxvjzCnlIf5TQX7nadcyMU7ay6tRbDUKA7CW1JkFycSPkvqt
         MSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IspLCg3oFcMgGcuKPjnrYymO26rLmbmjWCQz98/r454=;
        b=DiSA4vsHHIdkRzyaZBcQRwNNUwe9Kyw2cGuRoNhlbbX04xjSddi9gZdHqFEFtI8/9V
         e/4TpSeJcjjGETQlVV7bkprOrXwU2LbClwEKgIGIh/grqX8/2MUlSe6uyRzaTlwztBAj
         srBdi1RUAQu3koN7lsn0+XXXixwtQwEIyXgA0E9K5qQWVrz45yd7CKtCijgOYif68Kur
         pnyovHXp5NuDZQX8oT48hKBSE6FhN5P7t64Q6chFSwvx/CmB3KihYlFqH2fPS345UP0H
         VAauoLggRvbTUnCK1H7Pv9J7Vc+IPjV5JRtFZ/IcOGm2JqxqYhodz5jUabcxidNit+xW
         akpw==
X-Gm-Message-State: AOAM531c7VAWGTzw5qV3a51zvxNrR7ABLdrJFIOj3IjfdIAgVZShIRPB
        QSEHv2En7r7EaCR2NpSpThSvPA4rFhDAm8Pz6Ws78g==
X-Google-Smtp-Source: ABdhPJx4pGp5MW0KOprYmSABiXs8ARJ082/y7YbWIaLoCvBLKj1Fk5PynSRsEYO8J12Xluf66vZp5Y/ye4VNepZFoqk=
X-Received: by 2002:a17:902:e550:b0:137:734f:1d84 with SMTP id
 n16-20020a170902e55000b00137734f1d84mr980413plf.27.1630523950196; Wed, 01 Sep
 2021 12:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210830171726.2342558-1-ben.widawsky@intel.com> <20210830171726.2342558-3-ben.widawsky@intel.com>
In-Reply-To: <20210830171726.2342558-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 1 Sep 2021 12:18:59 -0700
Message-ID: <CAPcyv4iA9CywmxsT9GbOVhNcpdM1Bc4XNe69FuPLFiTuQvL+HQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/docs: Remove undocumented references
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Aug 30, 2021 at 10:17 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> When the core pmem and regs implementation was added, there were no
> structured comments added. This change allows docs to be generated
> without warnings.
>

Hmm, might be better to go the other and fix this with patches to add
documentation. At least devm_cxl_add_nvdimm_bridge() would benefit and
regs.c has some kernel-doc annotations, just needs the header section
added.
