Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE3C43381
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Feb 2021 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F41964D79
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Feb 2021 16:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBPQ37 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhBPQ3y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Feb 2021 11:29:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89789C061574
        for <linux-cxl@vger.kernel.org>; Tue, 16 Feb 2021 08:29:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id z22so12910666edb.9
        for <linux-cxl@vger.kernel.org>; Tue, 16 Feb 2021 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1fByGQpPQJ7ji9Gk5SJlWX6tfxT9ZmsK4Ea6wffkmI=;
        b=QRPT8UVWv6aTpPWibFh0zE5hq4I568w3C4gA52ZnCMepn66K8B5uopeXSjAZ09NyFM
         5utqkApbhaQnsf7B5mxYr6EZn9GZid3qhtOVEvAflt7wBC0FzJqSB4EIKaVu8W6yJO4b
         ZJfv3Au7MMBFfgfGS18+aosaIy1rbe0ea2z6LZO6S4RohvQkxTjbkImDB3HKlDL78U4O
         7dHmwjfdtsiaNPMMn6C5thBUH2ilinaxM4HK08ca9sKbmepq5e4kMAwDafDL/xmFGEdW
         o2V9+qYkiyF1zmFK+bNLhdktPISIgE/oV+LXOetATKKcJqQFq4ob7mO7QSsuA0ifuBN0
         n7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1fByGQpPQJ7ji9Gk5SJlWX6tfxT9ZmsK4Ea6wffkmI=;
        b=WsIOdlyPTva5f8KBIa4mON2usz/GuGp0RyV8JHUdjLShc/wv1JbmoAa54POXeUstYe
         Mcig2b6jBlepBtL+8CbM8rmN9SzkCyGLK7JvnbKzuQ8u8oPPLe2yFReJi3cKnKEyKadq
         2Uwd2tpf1BT3dFucGE7u5L1CfooD+e+mibE7dtRRrnCo3EjVB6ZmDqCG7mgx1sHib5BP
         G8kD9nCzF+9wNn7GoXum2tgQwZdT2ix/yJFChQRCkIuxVSqpNMeP96FjJyjyotrYmR6M
         K7hy9ym63ysoJKSob6jpmVVRluUTPo6mstFZmiHScyC07qJOvgZJoOdQDn8QRZLfXaiq
         mOEw==
X-Gm-Message-State: AOAM5331Q0t6Ea/YffDxkbFHioMHx5TUJA7+rLlLCsTc8WmjvDrnsfaS
        fWUp0W8zjAfus7aBiwEp5/ffN61AT9+IpBmPaFhdGQ==
X-Google-Smtp-Source: ABdhPJxzFaB5/ptOuVXtjnaH0IAfkTyeu+Cz4CmTht5eAgsbF7aauwQbd36I3lbwAe4/mPkXityqk6PBPQGKrqiQ0+M=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr21690793edd.52.1613492952244;
 Tue, 16 Feb 2021 08:29:12 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gmd_cygXK0PpGkXmJLC3_ctEpRvpi5P-QcuXusFX5oNQ@mail.gmail.com>
 <20210210112330.00003e74@Huawei.com> <CAPcyv4gOyPjVcBa_m6pvpVP+vamJ38G7ePos-2LP273y3ivJqg@mail.gmail.com>
 <20210211094222.000048ae@Huawei.com> <CAPcyv4j0Wce-76OfgqTSkveukgDXB_p2VZZpgM8XjDFd+Q-0Ww@mail.gmail.com>
 <20210212122438.00003621@Huawei.com> <CAPcyv4j1axBsy4GdRxj4JhxRXtrK-U+ikxQ3xYKCa-z-a84XPQ@mail.gmail.com>
 <20210216110643.000071f0@Huawei.com>
In-Reply-To: <20210216110643.000071f0@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 08:29:01 -0800
Message-ID: <CAPcyv4iv9kFLU7U9=VpYJZOiahUWJAZ_J_ZWCrGy1Lgqq+07kg@mail.gmail.com>
Subject: Re: [RFC] ACPI Code First ECR: Generic Target
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        Chet R Douglas <chet.r.douglas@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 16, 2021 at 3:08 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > Why does GI need anything more than acpi_map_pxm_to_node() to have a
> > node number assigned?
>
> It might have been possible (with limitations) to do it by making multiple
> proximity domains map to a single numa node, along with some additional
> functionality to allow it to retrieve the real node for aware drivers,
> but seeing as we already had the memoryless node infrastructure in place,
> it fitted more naturally into that scheme.  GI introduction to the
> ACPI spec, and indeed the kernel was originally driven by the needs of
> CCIX (before CXL was public) with CCIX's symmetric view of initiators
> (CPU or other) + a few other existing situations where we'd been
> papering over the topology for years and paying a cost in custom
> load balancing in drivers etc. That more symmetric view meant that the
> natural approach was to treat these as memoryless nodes.
>
> The full handling of nodes is needed to deal with situations like
> the following contrived setup. With a few interconnect
> links I haven't bothered drawing, there are existing systems where
> a portion of the topology looks like this:
>
>
>     RAM                              RAM             RAM
>      |                                |               |
>  --------        ---------        --------        --------
> | a      |      | b       |      | c      |      | d      |
> |   CPUs |------|  PCI RC |------| CPUs   |------|  CPUs  |
> |        |      |         |      |        |      |        |
>  --------        ---------        --------        --------
>                      |
>                   PCI EP
>
> We need the GI representation to allow an "aware" driver to understand
> that the PCI EP is equal distances from CPUs and RAM on (a) and (c),
> (and that using allocations from (d) is a a bad idea).  This would be
> the same as a driver running on an PCI RC attached to a memoryless
> CPU node (you would hope no one would build one of those, but I've seen
> them occasionally).  Such an aware driver carefully places both memory
> and processing threads / interrupts etc to balance the load.

That's an explanation for why GI exists, not an explanation for why a
GI needs to be anything more than translated to a Linux numa node
number and an api to lookup distance.

>
> In pre GI days, can just drop (b) into (a or c) and not worry about it, but
> that comes with a large performance cost (20% plus on network throughput
> on some of our more crazy systems, due to it appearing that balancing
> memory load across (a) and (c) doesn't make sense).  Also, if we happened
> to drop it into (c) then once we run out of space on (c) we'll start
> using (d) which is a bad idea.
>
> With GI nodes, you need an unaware PCI driver to work well and they
> will use allocations linked to the particular NUMA node that are in.
> The kernel needs to know a reasonable place to shunt them to and in
> more complex topologies the zone list may not correspond to that of
> any other node.

The kernel "needs", no it doesn't. Look at the "target_node" handling
for PMEM. Those nodes are offline, the distance can be determined, and
only when they become memory does the node become online.

The only point I can see GI needing anything more than the equivalent
of "target_node" is when the scheduler can submit jobs to GI
initiators like a CPU. Otherwise, GI is just a seed for a node number
plus numa distance.

>   In a CCIX world for example, a GI can sit between
> a pair of Home Agents with memory, and the host on the other side of
> them.  We had a lot of fun working through these cases back when drawing
> up the ACPI changes to support them. :)
>

Yes, I can imagine several interesting ACPI cases, but still
struggling to justify the GI zone list metadata.
