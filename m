Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF49C64EC4
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Mar 2023 08:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCHI70 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCHI7Z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Mar 2023 03:59:25 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4A58F71A
        for <linux-cxl@vger.kernel.org>; Wed,  8 Mar 2023 00:59:21 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230308085919epoutp032d9c33b9245ae3baa36464cd30178664~KZf96SZ8V0630306303epoutp03R
        for <linux-cxl@vger.kernel.org>; Wed,  8 Mar 2023 08:59:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230308085919epoutp032d9c33b9245ae3baa36464cd30178664~KZf96SZ8V0630306303epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678265959;
        bh=4XtP9KAbmHTB6uGoj0bPUdVjzoIV9mKJyTF+PhWMjGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VX2dI4DsPLJdmkPbOLkb44ZC0fazswEtAyxsGsOjqwT7dOZ+eKgq+IEx/NjQnyN3B
         dOVtl6jqOpTGK7lktbKTsa+/Z7hHjdUPqWmq7Q4rl0S58XW1MjpO54Od20I4e1Djpe
         /6i+3aaBSjG8hojPctY5U0o0Wfa+8G52ctPWBzTY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230308085918epcas2p2ba855441e6fdd7b9ea8c5dbaa7a05279~KZf9lOM2z2886728867epcas2p2y;
        Wed,  8 Mar 2023 08:59:18 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PWmTK5cZ5z4x9Q5; Wed,  8 Mar
        2023 08:59:17 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.56.05668.56E48046; Wed,  8 Mar 2023 17:59:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230308085916epcas2p3d8f19b1a4c6615b214d96f909ce1eba1~KZf7dUJuo1250412504epcas2p3F;
        Wed,  8 Mar 2023 08:59:16 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230308085916epsmtrp2913533f05d1ce796b44bce8c3dfd38d2~KZf7cqI-l0477704777epsmtrp2S;
        Wed,  8 Mar 2023 08:59:16 +0000 (GMT)
X-AuditID: b6c32a48-45bfc70000021624-d1-64084e65b51f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.EC.31821.46E48046; Wed,  8 Mar 2023 17:59:16 +0900 (KST)
Received: from dell-Precision-7920-Tower (unknown [10.229.83.133]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230308085916epsmtip2e98b7cc1a49a016908e8c46b5d0018ad~KZf7ULx3T0595305953epsmtip2_;
        Wed,  8 Mar 2023 08:59:16 +0000 (GMT)
Date:   Wed, 8 Mar 2023 18:01:34 +0900
From:   Jehoon Park <jehoon.park@samsung.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl patch RFC 0/2] add support for IDENTIFY command
Message-ID: <20230308090134.GA15397@dell-Precision-7920-Tower>
MIME-Version: 1.0
In-Reply-To: <ZAecHtXUX5ZR9ccU@aschofie-mobl2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTVDfVjyPFYGGzjsXdxxfYLJonL2a0
        mD71AqPF/qfPWSzOzzrFYnFrwjEmBzaPxXteMnlsWtXJ5vF5k1wAc1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbhPw9YChbrVJxoXMzW
        wPhLoYuRk0NCwERi7qfjbF2MXBxCAjsYJVbfWMwM4XxilDjf08MI4XxmlPg3bx07TMv5z90s
        EIldjBJvDk9ihXC+M0oceP2fBaSKRUBFYtaHbWwgNpuAtsT97RuAbA4OEQFDiQXT1EDCzAK1
        Eh0rJzGB2MICzhITrlwFK+cVsJN4tXwCM4QtKHFy5hOwkZwCehLnmnvAjhAVUJY4sO04E8he
        CYGX7BLt9+4zgsyXEHCRmL6rAOJQYYlXx7dAHS0l8fndXjYIO1/i58lbrBB2gcSnLx9YIGxj
        iXc3n7NC3JYpcXzeHCaIkcoSR26xQIT5JDoO/2WHCPNKdLQJQXSqSnQd/8AIYUtLHL5ylBnC
        9pCY03MBLC4ksIVR4thb1QmM8rOQPDYLyTIIW0diwe5PbLOANjADjVr+jwPC1JRYv0t/ASPr
        Kkax1ILi3PTUYqMCE3hUJ+fnbmIEJ0gtjx2Ms99+0DvEyMTBeIhRgoNZSYT3uxRHihBvSmJl
        VWpRfnxRaU5q8SFGU2AkTWSWEk3OB6bovJJ4QxNLAxMzM0NzI1MDcyVxXmnbk8lCAumJJanZ
        qakFqUUwfUwcnFINTMfWP7r3uDTg8Z+SdY1KGd4dAcuDav1e/tP9tU9M8Yc9xwsTPtF7JuoX
        zBbXu29oC/niMq9TKTfyS1LGOwfbuhWXfK7MyjwZnvbn544K37PZc2Jk2e9UVcy/r7S5c8Jb
        6c1P3hxWPHL9zo9zzmfNv8snhnCaGLiLl4t7c7jIPpVut/zx5/T3Q4+UCluFVpQ7tLFpXld6
        cot3a9Yn96a0XM7Zc32Tqu/1l15o7f/mdK+/teeW6qKDi7jOc3Bt0/l5tjKSITBUvUbFjEfP
        Y6vRssWBe5RrTy1dU/TEm5Wp/utT9j98dV0Cx1hN1HaL7BfMX+z4qvhnzuKJzeY3DjFzBK/N
        4rsSOHnOFp3Vv2fvUWIpzkg01GIuKk4EAGv18RAZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvG6KH0eKwdmvEhZ3H19gs2ievJjR
        YvrUC4wW+58+Z7E4P+sUi8WtCceYHNg8Fu95yeSxaVUnm8fnTXIBzFFcNimpOZllqUX6dglc
        GV3rtzMWPNCseHT0BnsD4wW5LkZODgkBE4nzn7tZuhi5OIQEdjBK7HhxmA0iIS1xr/kKO4Qt
        LHG/5QgrRNFXRolZG7czgiRYBFQkZn3YBtbAJqAtcX/7BiCbg0NEwFBiwTQ1kDCzQK1Ex8pJ
        TCC2sICzxIQrV8HKeQXsJF4tn8AMYgsJbGGUWHe5ECIuKHFy5hMWiF4tiRv/XjKBjGQGumf5
        Pw6QMKeAnsS55h6w00QFlCUObDvONIFRcBaS7llIumchdC9gZF7FKJlaUJybnltsWGCUl1qu
        V5yYW1yal66XnJ+7iREc4lpaOxj3rPqgd4iRiYPxEKMEB7OSCO93KY4UId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpjM+DcUP9vM9Uv036MCppteptN2
        fxG4qqEpv6b0onksW3FtQEJDwcJOgcNX9c5Kn8+yD3+p7NshcPVhpeOuW2n/7yQ48q41vh/y
        KemJ9ty6Oe+St4rx1Zj6JwRcWPy29VhQr2wvl9LyK+nrdN7evLOwTj572dSrvnsfu7ivnLjY
        8u9viQ+s+iLz9z+exS3bt4r3etnHqYLh/8XEORwDbsQEnFv2obLUsc32/hKrc0x1DEwS+5x3
        csvt/K76z6v+JcuruOtX/unLPtx2/WGLo93+UtMtWgEhlfsVBQ8Ifv0ZttvszYf7Hy37JRsD
        xZ+9rk/4FxT56/XDd0+NziU+EuzOM1z9+uTBO8c3PSjecNhbiaU4I9FQi7moOBEAafNA9uAC
        AAA=
X-CMS-MailID: 20230308085916epcas2p3d8f19b1a4c6615b214d96f909ce1eba1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----mCHB6Vbp4ppqb7.Eb9hMqMXHvM99xBNVcrtllGKp56PgfQUr=_15c29f_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788
References: <CGME20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788@epcas2p1.samsung.com>
        <20230307082102.27195-1-jehoon.park@samsung.com>
        <ZAecHtXUX5ZR9ccU@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------mCHB6Vbp4ppqb7.Eb9hMqMXHvM99xBNVcrtllGKp56PgfQUr=_15c29f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Mar 07, 2023 at 12:18:38PM -0800, Alison Schofield wrote:
> On Tue, Mar 07, 2023 at 05:21:00PM +0900, Jehoon Park wrote:
> > From: jehoon park <jehoon.park@samsung.com>
> > 
> > This patchset supports CXL IDENTIFY mailbox command and corresponding
> > cxl tool interface command.
> > 
> > CXL 3.0 Spec 8.2.9.8.1 defines IDENTIFY command which retrieves basic
> > information about CXL memory device. The information consist of device's
> > firmware version, capacity, LSA size, event log size, poison list size,
> > inject poison limit, poison handling capabilities and QoS telemetry
> > capabilities. Firmware version, capacity and LSA size are already supported
> > and used for partition commands or sysfs attributes while others are not.
> > Since patches about event log [1] and poison [2] are discussed recently,
> > support for those information will be helpful.
> 
> Hi Jehoon,
> 
> Does this need to be a separate command? Identify fields can be included
> in cxl list options. For example, the -I option to cxl list, issues the
> identify command and includes the partition related entries in that json
> output.
> 
> There are other identify fields that need to be picked up, like the
> poison related fields.  They need to be added to the cxl list 
> options. We may want to include some when we list the poison, and
> some as an option in the memdev listing.
> 
> Is there some reasoning behind separating this out? If not, can we look
> to add the missing fields to the various cxl-list options and add
> new cxl-list options where needed?
> 
> Alison
> 

Hi Alison, thank you for comments.

I suggested separate identify command since it retrieves basic information
about memdev. Since cxl-list command lists all cxl objects, I intended to
focus memdev information by separating it. Also, I referred to nvme-cli
which has id-ctrl and id-ns commands.

However, as you commented, some fields were already included in cxl-list.
I think the idea that providing information to proper listing option also
makes sense.

Then, by following the approach, including fields to cxl-list options,
identify fields could be included like below. Do they look fine?

1. FW version and LSA size are included when listing memdev. ("list -m memdev")
2. For poison related fields (poison_list_max size and inject_poison_limit),
include them when listing poison. ("--media-errors" option, patch [1])
3. For capabilities fields, add new option "-C, --capabilities" to the
memdev listing. (I see there exists same option for listing nvdimm device)

However, I'm confused about event_log_size fields. Could they be included
in capabilities option too? or require new option like "--event"?

Jehoon

[1] https://lore.kernel.org/nvdimm/cover.1668133294.git.alison.schofield@intel.com/

> > 
> > Example:
> 
> Users expect json formatted output here.
> 
> 
> > # cxl identify mem0
> > FW Revision                              : BWFW VERSION 00
> > Total Capacity                           : 1.00 GB
> > Volatile Only Capacity                   : 1.00 GB
> > Persistent Only Capacity                 : 0 B
> > Partition Alignment                      : 0 B
> > Informational Event Log Size             : 0
> > Warning Event Log Size                   : 0
> > Failure Event Log Size                   : 0
> > Fatal Event Log Size                     : 0
> > LSA Size                                 : 0 B
> > Poison List Maximum Media Error Records  : 256
> > Inject Poison Limit                      : 0
> > Poison Handling Capabilities
> > Injects Persistent Poison                : Not Supported
> > Scans for Poison                         : Not Supported
> > QoS Telemetry Capabilities
> > Egress Port Congestion                   : Not Supported
> > Temporary Throughput Reduction           : Not Supported
> > cxl memdev: cmd_identify: identified 1 mem
> > 
> > This patch is RFC because some of the information are already provided by
> > "list -m <memdev>" command and sysfs attributes.
> > I think a separate cxl tool interface command for identify is useful to provide
> > device's information clearly. In case of nvme-cli, there are separate
> > interface commands for identifying controller and namespace: id-ctrl and id-ns.
> > 
> > [1] https://lore.kernel.org/linux-cxl/20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com/
> > [2] https://lore.kernel.org/linux-cxl/cover.1676685180.git.alison.schofield@intel.com/
> > 
> > jehoon park (2):
> >   libcxl: add accessors for IDENTIFY command
> >   cxl: add identify command to cxl tool
> > 
> >  Documentation/cxl/cxl-identify.txt |  57 ++++++++++++
> >  Documentation/cxl/meson.build      |   1 +
> >  cxl/builtin.h                      |   1 +
> >  cxl/cxl.c                          |   1 +
> >  cxl/lib/libcxl.c                   |  73 +++++++++++++++
> >  cxl/lib/libcxl.sym                 |  11 +++
> >  cxl/lib/private.h                  |  11 +++
> >  cxl/libcxl.h                       |  16 ++++
> >  cxl/memdev.c                       | 141 +++++++++++++++++++++++++++++
> >  9 files changed, 312 insertions(+)
> >  create mode 100644 Documentation/cxl/cxl-identify.txt
> > 
> > 
> > base-commit: b830c4af984e72e5849c0705669aad2ffa19db13
> > -- 
> > 2.17.1
> > 

------mCHB6Vbp4ppqb7.Eb9hMqMXHvM99xBNVcrtllGKp56PgfQUr=_15c29f_
Content-Type: text/plain; charset="utf-8"


------mCHB6Vbp4ppqb7.Eb9hMqMXHvM99xBNVcrtllGKp56PgfQUr=_15c29f_--
