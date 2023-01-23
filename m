Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8923CC25B50
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 18:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjAWSdP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjAWSdO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 13:33:14 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A1ABB9E
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 10:32:36 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id p1so13943970vsr.5
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc7WdrHhbFMwlzolUP7MydM/5qJnV6PyeWILVnZ0/bk=;
        b=apBtD0/WTgTGWDeqxalwmbT94HTe4C5wb3MH5vlWD5Sjsb60PZ1oJFK12gnI366Ue7
         pEqH9SwCk2EIZ9XMdwNZnp0V2TQaGMGxtxM6sfhgaCOw+/35wTQFUZV9wRDgAnKra6dM
         xIozQEnhIqYtPRIrwUOOSCvmOKXXpFYA1tiHgRmQCTMtz1qA/ztElujcJHfFTSSm2pND
         shVPYMJeeGuuJJllaYr5y9cq8ChjASnnjCFIfavIpU/24fwXSqevHL04/wnfpX42ToEs
         gZrNbg7wy0aVtg2L4e/q3+BJreOlEV3mOvYSJIY4BDcway/FjThWcFhkSR7Ys8gXoOou
         zTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zc7WdrHhbFMwlzolUP7MydM/5qJnV6PyeWILVnZ0/bk=;
        b=OFwZqB4FI1lUqRuhCGf3CqTDXeT7PCTa7NFuBRrDUuctqEPs8rBSMVHeVL0VT75gAF
         yTVph+jIuDt+9xwBSJNhmyX1pRGsnQsQds0l6B2ueniO7sbHG1nuV9cspKHp2AlKRoKp
         O1oXJ6Xetv6DLDGfvu/DpaCg0XGUisnEcgmEgpoMRcB81AfvR7S9r6wC0eiR7y7UQFKL
         LPphaeq88nqX6OuUJr7vSl6bkCUq1pD3KvnPCWGtWxdpg100npfoHPLarPtcCfEwDuH/
         Yf2EF+nsTslRNZE7A/u/ji5qy58BQ4pbfewJNZ+DA4URV/6DQlgJ6eCC79Goh1osAiND
         yXbg==
X-Gm-Message-State: AFqh2kqWH6ruRzxE5ckr/2YtjYdZa/jwhu7pq6cGK0glyyvKd/GDyzup
        vpnlVEtsuYkSKJHvMSFGNzUUDg==
X-Google-Smtp-Source: AMrXdXtsUkOQyaG7CFm58Z+fPa9eNNeVsTXOFnzjGrPwNxyQpnygYMuJqKDh9EDRE0rxxO31r0DJNg==
X-Received: by 2002:a05:6102:5c2:b0:3d3:eda9:f34 with SMTP id v2-20020a05610205c200b003d3eda90f34mr13350085vsf.25.1674498755642;
        Mon, 23 Jan 2023 10:32:35 -0800 (PST)
Received: from smtpclient.apple (ec2-52-52-7-82.us-west-1.compute.amazonaws.com. [52.52.7.82])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a0d8500b006eee3a09ff3sm32331294qkl.69.2023.01.23.10.32.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:32:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for CXL memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <Y87SIJm4XLBAmiIY@casper.infradead.org>
Date:   Mon, 23 Jan 2023 10:32:22 -0800
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        David Rientjes <rientjes@google.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Fan Ni <fan.ni@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1704CC6D-A107-4A2B-97E2-56770EFCBCB8@bytedance.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <CGME20230123055124uscas1p24ec9bf64b225fa5d943dd94ff70311ba@uscas1p2.samsung.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
 <20230123174553.GA341216@bgt-140510-bm01>
 <Y87SIJm4XLBAmiIY@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Jan 23, 2023, at 10:29 AM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Mon, Jan 23, 2023 at 05:46:00PM +0000, Adam Manzanares wrote:
>> The session about DCDs at Plumbers comes to mind here. In addition, I =
think this
>=20
> What's a DCD?

DCD - Dynamic Capacity Device (CXL Specification 3.0)

