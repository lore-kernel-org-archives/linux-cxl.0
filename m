Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9082FC433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Feb 2022 21:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiBAVJt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBAVJt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Feb 2022 16:09:49 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F451C061714
        for <linux-cxl@vger.kernel.org>; Tue,  1 Feb 2022 13:09:49 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so3942502pjp.0
        for <linux-cxl@vger.kernel.org>; Tue, 01 Feb 2022 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfkXO1SmtkeMFUVSjvOQaqvQ+wHw5M7LGlS5Mzh9l6g=;
        b=kWlOYQrzrIg8Ucw66RplSgM6whdDw/Mz1z9iyt2dyGE/KJXUWZDi3iBQ1IKXcKGPLY
         qDKcWPSDgTz5z3XE+FiQrtW2QAJ4BArh/UzDO2LmvBgjGsi+VMnYRdL95Pwb4vJs5GVw
         8daSdqYv0u1sIlX/T5AnKtMxNycMy+zjC811VFW1JyNoHZHHmkkl7rz1Txv409pblJBA
         H96vayr1EQSaBvShBIt88oWYMT3aEx79xcQYxceVba7ss6eFNX0pNKe/wQnwJonv+8w1
         +v5yBpXqeQlg9FzQdbfniUiFnbCw17LVQUK6pA6ktJGWv5n4RKaB/aN/KrtR7WAYSVLn
         uePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfkXO1SmtkeMFUVSjvOQaqvQ+wHw5M7LGlS5Mzh9l6g=;
        b=tEOwCj+ftMgaXgju0yWSnEblV9dZkAaDSOHAOOorC1CrePANfB+gLNI3N0hic1G25D
         mKXhdxyZf7zFMQD4QPVOllX+t/OBm4/8++gio/sjcuQZ9C+UrMLQaPEfeuy9HgTVjpIc
         beZxwDXA+raIM7XxVYuI/bxRNjNYTYvRW5pAPN4Vd7iSqeD6FZAnnQJcW5HprKKsd9l6
         g0cBthWUCKVZ+1WyODFxsSCxqeZ0daNNFLA+Ti60teocLRjVe3BrSDPPcYM6UNPpq1AB
         MxVwpgljQEiG33XSpphXNkogGdcqjp0VX9gQwpSRJ7V2l8orQCcWNSjBtzEwnDnW/ZKM
         mZ8g==
X-Gm-Message-State: AOAM53116P8dDMCxTWZLj3/ZGKAYtiqMu1KH7yYd1KEFFWK4PFtUhs7p
        Ba/Rav6K6hQE3GYoB7GcWL9OiJGAWxTNpgt40KLuPw==
X-Google-Smtp-Source: ABdhPJwxrhpjOmKbpFy9646jr5PcqrEbt3VRXObtW3+qrnpZHuE5dGOHs+xgCzm77qFq0pYWb0bEuGnXcbI9Bwr8vAk=
X-Received: by 2002:a17:90b:3ece:: with SMTP id rm14mr226745pjb.220.1643749788965;
 Tue, 01 Feb 2022 13:09:48 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298425201.3018233.647136583483232467.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220201151728.zgc55ckks672gedz@intel.com>
In-Reply-To: <20220201151728.zgc55ckks672gedz@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 13:09:42 -0800
Message-ID: <CAPcyv4hQ2BFWT7D45UYaL0JfTuSfpaAWbKdqLYsrbRYifre7HA@mail.gmail.com>
Subject: Re: [PATCH v3 25/40] cxl/core/port: Remove @host argument for dport +
 decoder enumeration
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 1, 2022 at 7:17 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-23 16:30:52, Dan Williams wrote:
> > Now that dport and decoder enumeration is centralized in the port
> > driver, the @host argument for these helpers can be made implicit. For
> > the root port the host is the port's uport device (ACPI0017 for
> > cxl_acpi), and for all other descendant ports the devm context is the
> > parent of @port.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I really like removing @host as much as possible everywhere.

It's only possible where the parent device is the host.

> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
