Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE1BC6FA99
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Mar 2023 06:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCJGw6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Mar 2023 01:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCJGwr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Mar 2023 01:52:47 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A223F5D1A
        for <linux-cxl@vger.kernel.org>; Thu,  9 Mar 2023 22:52:44 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230310065239epoutp0470d7448d0fd530467c357252f5ef97fb~K-D9G-dID2241922419epoutp04o
        for <linux-cxl@vger.kernel.org>; Fri, 10 Mar 2023 06:52:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230310065239epoutp0470d7448d0fd530467c357252f5ef97fb~K-D9G-dID2241922419epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678431159;
        bh=gVpn+pARNiFWWNh+fQb9RtVNcWoleHZv+ngoxyv5vE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UYsLjJ34DlztZGKqX2urKheaP915ZNZGFVKqU4iuLJSGIDSGVPnwMZ6GPTlg8f11o
         dEH11MChZVr+vNxK5m84PSFu2WK/8WkxgtsV/MOvazHKZjB7FGqLd6/lTlkw4Vfeis
         9RrLB2ZwteXDeQDsWqUCpZH5S18+DXL4Ky1FHRds=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230310065239epcas2p26cb540927dec08175dd25e74afa4350a~K-D8tOOCA1865718657epcas2p2A;
        Fri, 10 Mar 2023 06:52:39 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PXxZG5pQjz4x9Q5; Fri, 10 Mar
        2023 06:52:38 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.AB.61927.5B3DA046; Fri, 10 Mar 2023 15:52:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230310065237epcas2p4e2611e376edbd3351878b690c8f9475f~K-D632pWb3021730217epcas2p4C;
        Fri, 10 Mar 2023 06:52:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230310065237epsmtrp1e18b35964c91aaa8e179c0c30ddc0655~K-D63Ag792276922769epsmtrp1C;
        Fri, 10 Mar 2023 06:52:37 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-4b-640ad3b5b164
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.DE.31821.5B3DA046; Fri, 10 Mar 2023 15:52:37 +0900 (KST)
Received: from jehoon.park.samsung (unknown [10.229.83.133]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230310065237epsmtip1ab9d34fb4ccbcc5de58d085e619622d7~K-D6tB-Ba2724427244epsmtip1g;
        Fri, 10 Mar 2023 06:52:37 +0000 (GMT)
Date:   Fri, 10 Mar 2023 15:54:54 +0900
From:   Jehoon Park <jehoon.park@samsung.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl patch RFC 0/2] add support for IDENTIFY command
Message-ID: <20230310065454.GA2666@jehoon.park.samsung>
MIME-Version: 1.0
In-Reply-To: <ZAkE81CNAjXB48Wz@aschofie-mobl2>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmqe7Wy1wpBp1PdSzuPr7AZtE8eTGj
        xfSpFxgt9j99zmJxftYpFotbE44xObB5LN7zkslj06pONo/Pm+QCmKOybTJSE1NSixRS85Lz
        UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA9ioplCXmlAKFAhKLi5X07WyK
        8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwNDIxMgQoTsjM2fmhjLvikXPH20C2m
        BsZFMl2MnBwSAiYSs05PZuxi5OIQEtjBKDHzzBc2COcTo0TjjZtMEM5nRonTu3+zw7TcfnME
        qmoXo8SuHcug+j8ySsxef4wNpIpFQFWiobWFBcRmE9CWuL99A1hcRCBE4uaBZUBjOTiYBTIk
        9m5lAgkLCzhLTLhyFayEV8Bc4tLVW1C2oMTJmU9YQMo5BfQkFt0KAAmLCihLHNh2HOw4CYGv
        7BLNp7czgtRICLhI/LjHBnGnsMSr41ugbpaSeNnfBmXnS/w8eYsVwi6Q+PTlAwuEbSzx7uZz
        sDizQKbEqt9TWCFGKkscucUCEeaT6Dj8lx0izCvR0SYE0akq0XX8AyOELS1x+MpRZgjbQ2JO
        zwVo4Oxlkvj5/xPrBEb5WUgem4Vk2yxwmGhKrN+lDxGWl2jeOpsZIiwtsfwfB5KKBYxsqxjF
        UguKc9NTi40KDOGxnpyfu4kRnDa1XHcwTn77Qe8QIxMH4yFGCQ5mJRHe71IcKUK8KYmVValF
        +fFFpTmpxYcYTYHxNZFZSjQ5H5i480riDU0sDUzMzAzNjUwNzJXEeaVtTyYLCaQnlqRmp6YW
        pBbB9DFxcEo1MM3/FKfJuSfi+vwFu8waqveU/f+j0vPZQ2CfhzLrE89vxp4q9VXHMthDl1Zu
        tHpR+fmO9e9l9xZ9mvdX4tvifAZ57Qs3J/p9OKzJ+KdfItX61Ww5+d7mereQH1OVs26EzT8f
        P+/y/3k1RcGNGfbSOisT045+OJdqOqnY2dWvf3Huc81WE7/y+rY53Hmbg1+J6E14VRjn/dTt
        wKZw9vWTtVt87L3UWrcvNbUwvrxV7qdkU2urtEXOBp+pdw+aZRd2q/8RXCrMIlOl8oLHYNfO
        uo03HD5n5WWGey05UxRTarSfJVxKuvVZquvLys/i4vMtMzz+r5/N8XV5ivUPfYuJQgelZRfk
        chuKzUjcw1anxFKckWioxVxUnAgAtnoYliQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnO7Wy1wpBr8/ilrcfXyBzaJ58mJG
        i+lTLzBa7H/6nMXi/KxTLBa3JhxjcmDzWLznJZPHplWdbB6fN8kFMEdx2aSk5mSWpRbp2yVw
        ZbTeecVWMFGx4uL1e0wNjHcluxg5OSQETCRuvznC1sXIxSEksINRYsflT2wQCWmJe81X2CFs
        YYn7LUdYIYreM0p8+9PKDJJgEVCVaGhtYQGx2QS0Je5v3wDWLCIQIvH2/HGgGg4OZoEMib1b
        mUDCwgLOEhOuXAUr4RUwl7h09RaYLSSwl0ni3vdSiLigxMmZT8BGMguoS/yZdwlqjLTE8n8c
        EGF5ieats8HCnAJ6EotuBYCERQWUJQ5sO840gVFoFpJBs5AMmoUwaBaSQQsYWVYxSqYWFOem
        5xYbFhjlpZbrFSfmFpfmpesl5+duYgRHhJbWDsY9qz7oHWJk4mA8xCjBwawkwvtdiiNFiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqY5b2P0Zy51Ys/y
        /vfcfW++fvEK0x86cSmqCXaLrQx/9l/LOXnKe9ucel3HOasDTkvNfzd//rt56QvFHTj5Ns50
        l5D2jomLvhW7aWL1t2ijKyzvFkv9Kp4sevVVQLKWY6LPAUnHE/+1grp/WqSw7/7DJZ1UzJGX
        c+O5ruLLzUlJs6pipd6v5mr/d3+X6k0RzTsWPq5H0xtVeW7/yqt7L9x2RXB362tfhnqL1oZl
        E1+ELuaQXs+3IbDtzk6umQZVG6ydkvk6nT/7Oa4vUfFzYLJQ/HND5u38oj/3bn/PWfru2dT/
        5Rnv7fs7Vn9OOFsnt05s+rwLwf3Pz0q6/pOXnqTHbqT8ZbPvscWntstKpimxFGckGmoxFxUn
        AgC799KN9wIAAA==
X-CMS-MailID: 20230310065237epcas2p4e2611e376edbd3351878b690c8f9475f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----d1DfbbeZuDs-BXZQBXO5x5vtJB9JxqaKuP-H-dFtQ4rq1pgC=_1708ae_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788
References: <CGME20230307081917epcas2p1accc8f7bf3f31e08525684abb2efa788@epcas2p1.samsung.com>
        <20230307082102.27195-1-jehoon.park@samsung.com>
        <ZAecHtXUX5ZR9ccU@aschofie-mobl2>
        <20230308090134.GA15397@dell-Precision-7920-Tower>
        <6408d271a2c96_f3f4a2943@iweiny-mobl.notmuch>
        <ZAkE81CNAjXB48Wz@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------d1DfbbeZuDs-BXZQBXO5x5vtJB9JxqaKuP-H-dFtQ4rq1pgC=_1708ae_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Mar 08, 2023 at 01:58:11PM -0800, Alison Schofield wrote:
> On Wed, Mar 08, 2023 at 10:22:41AM -0800, Ira Weiny wrote:
> > Jehoon Park wrote:
> > > On Tue, Mar 07, 2023 at 12:18:38PM -0800, Alison Schofield wrote:
> > > > On Tue, Mar 07, 2023 at 05:21:00PM +0900, Jehoon Park wrote:
> > > > > From: jehoon park <jehoon.park@samsung.com>
> > > > > 
> > > > > This patchset supports CXL IDENTIFY mailbox command and corresponding
> > > > > cxl tool interface command.
> > > > > 
> > > > > CXL 3.0 Spec 8.2.9.8.1 defines IDENTIFY command which retrieves basic
> > > > > information about CXL memory device. The information consist of device's
> > > > > firmware version, capacity, LSA size, event log size, poison list size,
> > > > > inject poison limit, poison handling capabilities and QoS telemetry
> > > > > capabilities. Firmware version, capacity and LSA size are already supported
> > > > > and used for partition commands or sysfs attributes while others are not.
> > > > > Since patches about event log [1] and poison [2] are discussed recently,
> > > > > support for those information will be helpful.
> > > > 
> > > > Hi Jehoon,
> > > > 
> > > > Does this need to be a separate command? Identify fields can be included
> > > > in cxl list options. For example, the -I option to cxl list, issues the
> > > > identify command and includes the partition related entries in that json
> > > > output.
> > > > 
> > > > There are other identify fields that need to be picked up, like the
> > > > poison related fields.  They need to be added to the cxl list 
> > > > options. We may want to include some when we list the poison, and
> > > > some as an option in the memdev listing.
> > > > 
> > > > Is there some reasoning behind separating this out? If not, can we look
> > > > to add the missing fields to the various cxl-list options and add
> > > > new cxl-list options where needed?
> > > > 
> > > > Alison
> > > > 
> > > 
> > > Hi Alison, thank you for comments.
> > > 
> > > I suggested separate identify command since it retrieves basic information
> > > about memdev. Since cxl-list command lists all cxl objects, I intended to
> > > focus memdev information by separating it. Also, I referred to nvme-cli
> > > which has id-ctrl and id-ns commands.
> > > 
> > > However, as you commented, some fields were already included in cxl-list.
> > > I think the idea that providing information to proper listing option also
> > > makes sense.
> > > 
> > > Then, by following the approach, including fields to cxl-list options,
> > > identify fields could be included like below. Do they look fine?
> > > 
> > > 1. FW version and LSA size are included when listing memdev. ("list -m memdev")
> > > 2. For poison related fields (poison_list_max size and inject_poison_limit),
> > > include them when listing poison. ("--media-errors" option, patch [1])
> > > 3. For capabilities fields, add new option "-C, --capabilities" to the
> > > memdev listing. (I see there exists same option for listing nvdimm device)
> > > 
> > > However, I'm confused about event_log_size fields. Could they be included
> > > in capabilities option too? or require new option like "--event"?
> > 
> > Fundamentally why does user space need to know the event log sizes?
> > 
> > I do like the idea of getting the 'raw' results of the identify command in
> > it's entirety.
> > 
> > What if list has an '--identify' option which adds the list of Identify
> > values as a child json object.
> >
> That's a good way to add it. That'll give you all the fields in one
> place, and then, we can still think about if we want to spit out
> specific fields (ie poison related) when we are doing a poison command.
> You will have added all the libcxl accessors, making those easier to add.
> Alison
> 
> 
> > Ira

The idea adding new list option “—identify” to display raw data from Identify
looks good! Providing proper fields to other options will be helpful for users,
however, I think it may be covered by different patchset after basic support
for Identify command is fully handled.

I will revise this patchset by applying your valuable comments. Thank you.

Jehoon

------d1DfbbeZuDs-BXZQBXO5x5vtJB9JxqaKuP-H-dFtQ4rq1pgC=_1708ae_
Content-Type: text/plain; charset="utf-8"


------d1DfbbeZuDs-BXZQBXO5x5vtJB9JxqaKuP-H-dFtQ4rq1pgC=_1708ae_--
