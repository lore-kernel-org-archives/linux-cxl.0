Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB724C05027
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 05:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjAWFvY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 00:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWFvW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 00:51:22 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4D814222
        for <linux-cxl@vger.kernel.org>; Sun, 22 Jan 2023 21:51:21 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jl3so10369164plb.8
        for <linux-cxl@vger.kernel.org>; Sun, 22 Jan 2023 21:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F2bAIvRaNnm7jbJz2qenrgqEXsiobPZg611lA3e9hsA=;
        b=DDjmRSTXzUMbvbnvXQhQ2HPUXgrfDgQ1Y42AXP9NoCARXmB57f821v8wSkQR+AruUb
         IuH3cxiPt8pB77uPdAsEJ7br290rgr0MFdIf3xV6hNdFu4doYWrnDkBA5bNjScWXS++6
         ckwcdcn1g0mOkSa95HrYAOBxwdBN/GIhB4iTfhGZsCn/VS4xVn/yeGQyB+cUCgDL2Rcn
         xsQl+ku/ErcpQ+1x4fNbZnbHqFFl0SeurdXDPD9/Gry3VKKOLrOzJWgr4O6V4OIdZTfe
         pb5nmgUPNZrX6OmxOCOibq29KsFoJQO28Ki1Zl2Ud/s+6iJvGRetB7NlacmXKQUtSLTX
         oHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2bAIvRaNnm7jbJz2qenrgqEXsiobPZg611lA3e9hsA=;
        b=r5BEaUR+q6gnBqR93XIwtgGstrmFC8YaxXwRo1bfXMQSBwIdglUEWHiai5AV52B5rV
         s+wztwc1OtzmL1jxIfU01FZ8ONSW3frYSzfWkRHagELMy/ZhLfWJV9F+S96zlAX8H6cX
         xCQkv0TeR+MdKN7MjLN1ZSnkTZjklF65Fc6DwTyGYmfH8uBtfHNUxSHzvgYIMnVYh1NX
         pNc6yNvg/WP+t1n5fbvWiCh/1ePjqisG03zzoJvwjpdH/SQYleJyMtjOJXqb80TMV+LL
         xzugExEVOEtR0ZilEIwu+gcgqG9gRTfVSAN/EOmidoNvNw5R+Is1gWrLjMGDM2qR/NaY
         UyGQ==
X-Gm-Message-State: AFqh2kpCwpnK2BrFbOI5NrdaS2yalmODRGC19GCIBEc4YqC8lJQ5GP0p
        MQ97hr8/shI5Iui29kgP1isa7A==
X-Google-Smtp-Source: AMrXdXtyslRg6ne51nW7e/NmkhU+kAhHUXUjiJMamtx+1tTyrPW4DS7BBzNk8JRvkgZr+t9N2JHjbA==
X-Received: by 2002:a17:902:ac97:b0:194:d5ff:3ae3 with SMTP id h23-20020a170902ac9700b00194d5ff3ae3mr428982plr.2.1674453081217;
        Sun, 22 Jan 2023 21:51:21 -0800 (PST)
Received: from [2620:15c:29:203:7beb:a8b0:cc9f:9116] ([2620:15c:29:203:7beb:a8b0:cc9f:9116])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b0017fe9b038fdsm3454941plv.14.2023.01.22.21.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 21:51:20 -0800 (PST)
Date:   Sun, 22 Jan 2023 21:51:19 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
cc:     lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF BoF] Session for CXL memory
In-Reply-To: <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
Message-ID: <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com> <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:

> CC: LSF/MM/BPF mailing list. Sorry, missed the list.
> 
> > On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko <viacheslav.dubeyko@bytedance.com> wrote:
> > 
> > Hello,
> > 
> > I believe CXL memory is hot topic now. I believe we have multiple topics
> > for discussion. I personally would like to discuss CXL Fabric Manager
> > and vision of FM architecture implementation. I am going to share the topic
> > in separate email. I would like to suggest a special session for CXL memory
> > related topics.
> > 
> > How everybody feels about it?
> > 

I think this makes a lot of sense, thanks for suggesting it.

Should this be a BoF or just a normal topic proposal?  I assume that there 
could be several different topics of interest all related to CXL.mem.

Specifically interesting would be the division of work between the kernel 
and userspace to manage memory placement on systems with locally attached 
CXL.  And, further, what APIs userspace would have at its disposal for 
explicit optimization of this placement that would exist beyond what is 
available for NUMA.

I assume we might also want to chat about CXL 2.0 extensions that would be 
useful, especially for cloud providers.

I'd be happy to join in any of the proposals for these topics, just let me 
know!
