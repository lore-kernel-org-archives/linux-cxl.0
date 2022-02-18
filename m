Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699F5C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Feb 2022 21:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiBRVxx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:53:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiBRVxx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Feb 2022 16:53:53 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB3653B61
        for <linux-cxl@vger.kernel.org>; Fri, 18 Feb 2022 13:53:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x18so3368096pfh.5
        for <linux-cxl@vger.kernel.org>; Fri, 18 Feb 2022 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZXhaWbIOXPQuT8HgBVIhKVVo55naTZ6jyJBspy9kt4=;
        b=CDiKJo+2jkhA827OSKNjg9iykVaGNhfa9oxg5fwXUWWCNQZOjLGAix7tO5YjzkL/Ss
         XMwD5IMw3t94TowotEMldgov1lqUr7dMrANeViPK8j0yxC1/vaiydq+2+98UMRxbBHbH
         fo3VqEeFUT3gyEFZXrIfl9rPjZDjZl/ITsoiPu1h8fgAep1fK3WuFDq0jsudLZM6eSZk
         M32r6xV4d3PfvU+pD5osbN2GgyZkkHunjiUp9WGAvtN//QK/o2WIkWCvm46q5zhaKm51
         Nay0QA1OOLi/CLSCOOGaeSyQzqPPgaydnbGIhQS4WjZ1JLu3MQmn3HCXr34rAVyzIH8p
         xr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZXhaWbIOXPQuT8HgBVIhKVVo55naTZ6jyJBspy9kt4=;
        b=CFvSsExnfHyLt9vdYRuq8M/ZbMlFLYA1kJRlSUpS1fILj4dOVtFgzr4X4JUu1P7v+2
         4m9sB5/v6FdJsTkdQQ02ReJNxobgVdYipVr45ymmoBBnoeBPTpmEWeVH/9odNgK5yceb
         KY8iBDt+74wqOn4zkiyXLwIzAaNNURzHMtxOG77pOjEcsx5T1Oe1ZN4Be4RvbfSnihDk
         uqJNETzwfGnmYXqZxHMtGnKOEHePZf29SouCo6puONLX7hyTnQ1HE0wbZLnwP1MUDIrd
         AnnqTJGKxxJXZCeudRe4/Na7EMWyRL6AZ6Vlhy7a3HoXglgZylxcXHr1ViT2gi8lhgz/
         jPTg==
X-Gm-Message-State: AOAM530ZmXxcYdlJrDrRafrIVQW9PFeiAYpoS7GaXroBni/jJUCnb1Vv
        ouSTjXT/xqMLEM9joLmZpa7f9cPUrw9XFyDh1ojQfA==
X-Google-Smtp-Source: ABdhPJy5ssiXYUNonyfu/HjJBCdDQCLxCIw8UJpjcjS1wK2sHSvuZZeBneLbc0kOqNe87wUfmX2j7YIiihiYLa2Igmo=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr9561872pfu.3.1645221215341; Fri, 18 Feb
 2022 13:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-10-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-10-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Feb 2022 13:53:24 -0800
Message-ID: <CAPcyv4gA+iimMxGay2ri9eceOrYr_5Hhjfomzh910rQExOtoKg@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] cxl/region: Add infrastructure for decoder programming
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> There are 3 steps in handling region programming once it has been
> configured by userspace.
> 1. Sanitize the parameters against the system.
> 2. Collect decoder resources from the topology
> 3. Program decoder resources
>
> The infrastructure added here addresses #2. Two new APIs are introduced
> to allow collecting and returning decoder resources. Additionally the
> infrastructure includes two lists managed by the region driver, a staged
> list, and a commit list. The staged list contains those collected in
> step #2, and the commit list are all the decoders programmed in step #3.

I expect this patch will see significant rewrites with the ABI change
to register endpoint decoders with regions. It's otherwise redundant
to have a 'targets' array and then yet mosre linked lists to walk the
decoders associated with a region.
