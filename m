Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE26C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Jan 2022 22:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiAaW3n (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiAaW3n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Jan 2022 17:29:43 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BFC06173B
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jan 2022 14:29:42 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d18so13811461plg.2
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jan 2022 14:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRkB2wipl7+jhUqvhRWOl4c9knyQgjfnb91drCfn3VM=;
        b=J/67zQAd5y8SNt2WlbqkgxafOmsYqxM/lvBo58anjlSDI+giv+9a2US1AL1DkHQQPS
         7FfgAtp9h5kxEP2jhOD4EBU/iB7aYHCjzAgkNMQCYfwSW7Bw7Rq36duG0x5Drf7zaprA
         br/s4ZcjSbDhT5A/zdtPrxYM4kxDqST3hsHJwaSEBjE+AgfAjmDKsrh2H6J5Pb1xceOM
         AVGpY0diQSoj1JZUyPsA7iw8geStuynoDqgmBwUVIOLtEHmk4tEoToXg/FS5sr3BhV5L
         bfeanuhcGnUJURDYGVkRRwK5HN4TF8QFznilZYzapFL6nb3lmNkg4zUydjm24/o3EnJB
         5Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRkB2wipl7+jhUqvhRWOl4c9knyQgjfnb91drCfn3VM=;
        b=44mh+85E0FLQLFBHBeNm5Kp/0ybgd4qabLu+yrpr6sAtkCHzItZo5dOov2L34fQS/s
         eTqBpVO1JajtD1pnjEhTW9+LldYYk593XJW6CtUr+E1hXkTQXv5K5ia+RkVLxXcamLkY
         P2Fty5kONFmWLzYbbc8zfNjlou2QoBC/5moTeNju+A0/R1+EpNGLiuurBpooYJueucdS
         MVRovM///1RIBLDnObybFkx0KcsFD8ld9LKsrwnOKEMLkUDyKViL3LdWvV8y8ETXitr+
         21Lci90joZavmwrl9iPH2ot+JDHLWbrsVyqWpOijHGzIjj3vAjdg/xCgYJ7JxEssWJA4
         1kqQ==
X-Gm-Message-State: AOAM531c7FulSxhh90XWk6R8yVZ/wwRMLqWRQlf1vIqRb5CpqqXM3KTK
        R3vAWnIom7H8fRVuytEYqnbM9VMCJGAf70pOs12L1w==
X-Google-Smtp-Source: ABdhPJz07t1Yd9XkjGJzVP7cdliEvXQKPZm2/2/PGEcdxIjnCdxc2cNfzZfYJjHUVM32OPwLgMM+HE7p9CSgIHG6cgk=
X-Received: by 2002:a17:90a:640e:: with SMTP id g14mr36623090pjj.8.1643668182515;
 Mon, 31 Jan 2022 14:29:42 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298418268.3018233.17790073375430834911.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131145358.0000322a@Huawei.com>
In-Reply-To: <20220131145358.0000322a@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 14:29:34 -0800
Message-ID: <CAPcyv4iUGhR7EQ5WkxpqZg+9eFzK9LwrhSWZSZzZKmjiRO5sDQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/40] cxl/core: Fix cxl_probe_component_regs() error message
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 31, 2022 at 6:54 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 23 Jan 2022 16:29:42 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Fix a '\n' vs '/n' typo.
> >
> > Fixes: 08422378c4ad ("cxl/pci: Add HDM decoder capabilities")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> FWIW
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Possibly worth pulling this out and sending separately.

Yeah, if some other for-5.17 material shows up I might send this along
too in advance of v5.18.
