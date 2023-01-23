Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F7FC05027
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAWS12 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjAWS11 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 13:27:27 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E533445
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 10:26:18 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d13so9658152qvj.8
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 10:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3nVx8sjzdLTAXcU1Id1zY4sD+sl1E1UhpfUDFhJlB4=;
        b=4Eh7EFTCFL8lFQ4X/as4sxrGsBRhCe28Q0PxIgf10yLsW0YqQmuFL/YNtyk0AXeF91
         77AkksbPaFC/qsbvMfKVhOWPQCis6aVUIlx2uDE/hBLHeCrrs2qqEmY2UYtVh2J6hsqM
         izXTazs+lIkDCXO+DYbe6NiLVB8bAn9n9ztytKyimwhhbGmXaYtBsT7tMYyliqvJGfhI
         Z7HXiuEpYK/1ZiPC50nMDrfC7kdr0ko3Z6OvtnVeGVeeWwEZW/OlbtuFEnehS/sevxTE
         0cuXxzYKhGGJsXgdM5bBd4sW5mgzLqODHZ9jfjkYAYJsH88iaRO5GX+1M1oyCvz5uQvH
         tkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3nVx8sjzdLTAXcU1Id1zY4sD+sl1E1UhpfUDFhJlB4=;
        b=YRq/BhwISrKcXCaOjyKe1EgCCSyqX7KyTaFHDeeY6+OFCMjZdxYtQw8DUQ+ZXkRLUl
         yRxW2UGJ1i30ug1ReorMB+/tVcUuShxpl5ES0ZR9tjH1QeVxY1YIlCLwCkfgCWVwktYl
         1vBfFE4VBKe1cXhlY12RTToEoIJ2fWUCI++LVH2acWaeFvzbu+wnj15ndv7w41UDmXyl
         epmpltfACkXSZnMYPNb/10U5cJUaha87gYnDmMlqHAuGHuSa2UE5loUF3trFasQKA/4b
         mxBbTH8fgTtJceQjGRhfalQveqeXMuQv4Q9yBqnpZ2pI2U9al9O4jen6MA/zpXo8NGN2
         e1YQ==
X-Gm-Message-State: AFqh2kpKfuRAhQDyU2UzvImNIPxk276jlXtqAopGNoIrtWeSaQK9Ctec
        YI6vY7BvtKAOhUgnEkGmsKloJg==
X-Google-Smtp-Source: AMrXdXts3n71xugKLberEh810NFatBsThiAAjvKI9SvpHIe3nd6ucUFqb6pPp3nRq9ASNp/4iZBK3Q==
X-Received: by 2002:a05:6214:3106:b0:4c7:29a8:1ff9 with SMTP id ks6-20020a056214310600b004c729a81ff9mr40509385qvb.30.1674498375094;
        Mon, 23 Jan 2023 10:26:15 -0800 (PST)
Received: from smtpclient.apple (ec2-52-52-7-82.us-west-1.compute.amazonaws.com. [52.52.7.82])
        by smtp.gmail.com with ESMTPSA id y4-20020a05620a44c400b007069375e0f4sm14021641qkp.122.2023.01.23.10.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jan 2023 10:26:14 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF BoF] Session for CXL memory
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
Date:   Mon, 23 Jan 2023 10:26:02 -0800
Cc:     lsf-pc@lists.linux-foundation.org, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Duen-wen Hsiao <duenwen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <77970B17-6154-4948-ACBF-84DB4745C591@bytedance.com>
References: <F75E3DE0-CDF2-407A-9AF7-8EAE1D177559@bytedance.com>
 <38D49DA9-3C57-4951-8CBA-5D2BB0C40D9C@bytedance.com>
 <dd0d92fd-51dc-f5ac-26f9-7446118d654e@google.com>
To:     David Rientjes <rientjes@google.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



> On Jan 22, 2023, at 9:51 PM, David Rientjes <rientjes@google.com> =
wrote:
>=20
> On Fri, 6 Jan 2023, Viacheslav A.Dubeyko wrote:
>=20
>> CC: LSF/MM/BPF mailing list. Sorry, missed the list.
>>=20
>>> On Jan 6, 2023, at 11:51 AM, Viacheslav A.Dubeyko =
<viacheslav.dubeyko@bytedance.com> wrote:
>>>=20
>>> Hello,
>>>=20
>>> I believe CXL memory is hot topic now. I believe we have multiple =
topics
>>> for discussion. I personally would like to discuss CXL Fabric =
Manager
>>> and vision of FM architecture implementation. I am going to share =
the topic
>>> in separate email. I would like to suggest a special session for CXL =
memory
>>> related topics.
>>>=20
>>> How everybody feels about it?
>>>=20
>=20
> I think this makes a lot of sense, thanks for suggesting it.
>=20
> Should this be a BoF or just a normal topic proposal?  I assume that =
there=20
> could be several different topics of interest all related to CXL.mem.
>=20

My point is to have a dedicated CXL session where we can discuss
CXL related topics. And we can have likewise session if several CXL
related topics will be suggested. :)

> Specifically interesting would be the division of work between the =
kernel=20
> and userspace to manage memory placement on systems with locally =
attached=20
> CXL.  And, further, what APIs userspace would have at its disposal for=20=

> explicit optimization of this placement that would exist beyond what =
is=20
> available for NUMA.
>=20

Yes, I think this could be important discussion. Because, for example, I =
am working
on figuring out how functionality can be distributed among user-space, =
kernel-space,
and firmware for the case of Fabric Manager. And I believe it could be a =
good topic
that I have in mind.

> I assume we might also want to chat about CXL 2.0 extensions that =
would be=20
> useful, especially for cloud providers.
>=20

What CXL 2.0 extensions would be useful for cloud providers from your =
point of view?

Thanks,
Slava.


