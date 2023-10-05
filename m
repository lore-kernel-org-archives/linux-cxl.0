Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D7E92708
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Oct 2023 14:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjJEOgk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjJEOej (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Oct 2023 10:34:39 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318071720
        for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 06:52:55 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231005090338epoutp02686752f2baa59ec9b5d8bba176c07822~LKq_aIdH51329313293epoutp02-
        for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 09:03:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231005090338epoutp02686752f2baa59ec9b5d8bba176c07822~LKq_aIdH51329313293epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696496618;
        bh=Rawy1uqGtZekaZsLJI64u4ot2Fk4u7cWio/j9jjXhdM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZTpA1Kg3K/wVv+bb9xScj3Q0Wm2VeX7V7gmXdiB6oJD46SyxT/dQdkylTbENFQutT
         3vVrOscTydPhIRig4f2vXC/H0PdLXQ72pozukv79WwuTgjmlBLj7X+AM2tc9PT87sL
         LzyGrI1UIOcKhbTK76bQL3qy2AhYoAZGT0+il9W8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20231005090337epcas2p391aa4e8d45527748a254a46285ea8eb8~LKq9wya9Q3190631906epcas2p3E;
        Thu,  5 Oct 2023 09:03:37 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S1QZx0zHyz4x9QG; Thu,  5 Oct
        2023 09:03:37 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.6D.09649.8EB7E156; Thu,  5 Oct 2023 18:03:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231005090336epcas2p23324d8515a0672339947f40c03a36957~LKq81NzOV1485014850epcas2p2A;
        Thu,  5 Oct 2023 09:03:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231005090336epsmtrp16f2046881c4e656b425ab97b4f9c6cd9~LKq80Y3M42633026330epsmtrp1g;
        Thu,  5 Oct 2023 09:03:36 +0000 (GMT)
X-AuditID: b6c32a46-b9ffa700000025b1-79-651e7be84de7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.8D.08742.8EB7E156; Thu,  5 Oct 2023 18:03:36 +0900 (KST)
Received: from jtpark-7920 (unknown [10.229.83.56]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231005090336epsmtip2e5b51c9f9fc739a699af1477ba22da38~LKq8mFFzS2670426704epsmtip2h;
        Thu,  5 Oct 2023 09:03:36 +0000 (GMT)
Date:   Thu, 5 Oct 2023 18:06:32 +0900
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [RFC PATCH 0/3] cxl: Fix background operation handling
Message-ID: <ZR58mPWDrb/QRt3T@jtpark-7920>
MIME-Version: 1.0
In-Reply-To: <yuxcbtl6zjtas55y6d4x6q6jx267fjcsvhjodofk6sqsg25lhh@gcvpdf3j3bmi>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmme7LarlUgzOXmC3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo0XT6rusFh/e/GOxOPC6gd3izNmXrBarFl5js1h8dAazxdE9HBbn
        Z51isbg14RiTxcb779gc+D12zrrL7tFy5C2rx+I9L5k8Nq3qZPPo27KK0WPq7HqPz5vkAtij
        sm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgM5WUihL
        zCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn
        9F+YxlZwRrDi46UPzA2MK/m6GDk5JARMJM6tOsLexcjFISSwg1Fi6Y81TBDOJ0aJnpu9jBDO
        N0aJnaeXMsO0dHb/YgGxhQT2MkqsXC8HUfSCUWL38x6wBIuAisSOqVfAbDYBLYnpMxtYQWwR
        AXWJeWtvg01lFljMInH6+Ud2kISwgLPE+zP72UBsXqCGb4tuM0PYghInZz4BGsTBwSngJ7Gq
        OxukV0JgC4fE16P7oS5ykejvmskIYQtLvDq+hR3ClpJ42d/GDtHQzCjx+jnIRSBOC6PEuts7
        oKqMJd7dfA52HrNAhsTXeR+ZQbZJCChLHLnFAhHmk+g4/JcdIswr0dEmBNGpJDFv6TyoGyQk
        Ls3dAmV7SJxf9xcaqJcZJZ6/28U+gVFuFpJ/ZiHZBmHrSCzY/YltFtAKZgFpieX/OCBMTYn1
        u/QXMLKuYhRLLSjOTU8tNiowgkdxcn7uJkZwOtZy28E45e0HvUOMTByMhxglOJiVRHjTG2RS
        hXhTEiurUovy44tKc1KLDzGaAmNnIrOUaHI+MCPklcQbmlgamJiZGZobmRqYK4nz3mudmyIk
        kJ5YkpqdmlqQWgTTx8TBKdXAdDJQnmXH1L0rA8L27ts82Uz3otbuHbbN7o3vPz5I9Y6WTTBS
        +vjPoXjhS2lP4xlc+044ifoteRLaGL9i9ce1srEcXi8S686f9ryXY7Xv+mwhlrvNHutePfUp
        LhTKTp9bdv1ks3RW0sFzn/3rMr9NWHRvZ/gxq5c8r8/25HoGJbIIblg6/7TJ1KT1DDz7ZbZ/
        n+ljLBdQOpm/J2I6v5hh/edvH3LvWV34Eqwut0h60v7inb6sV+T3qUge+d9cYFpak2cXt710
        qeX8TwK6831iZnffSvT8Ychuq5ByT8m1VOuTQUv/P+5rm1j3SkYymNe4HHLex/Flqz/v3tN7
        3EN/Cm1J+CowUfbDW+VSlk2PlFiKMxINtZiLihMBg+fOKVAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXvdFtVyqwbxl8hZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wiw9v/rFYHHjdwG5x5uxLVotVC6+xWSw+OoPZ4ugeDovz
        s06xWNyacIzJYuP9d2wO/B47Z91l92g58pbVY/Gel0wem1Z1snn0bVnF6DF1dr3H501yAexR
        XDYpqTmZZalF+nYJXBlbPm9nL+jhr5j/jqeBsYmni5GTQ0LARKKz+xdLFyMXh5DAbkaJ5evn
        skEkJCSWb3jBBGELS9xvOcIKUfSMUeJG+zRWkASLgIrEjqlXWEBsNgEtiekzG8DiIgLqEvPW
        3mYEaWAWWMkisX3da3aQhLCAs8T7M/vBNvACNXxbdJsZYuplRonND5azQCQEJU7OfAJmMwMV
        3fj3EugMDiBbWmL5Pw4Qk1PAT2JVd/YERoFZSBpmIWmYhdCwgJF5FaNkakFxbnpusWGBYV5q
        uV5xYm5xaV66XnJ+7iZGcCxpae5g3L7qg94hRiYOxkOMEhzMSiK86Q0yqUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5xV/0pggJpCeWpGanphakFsFkmTg4pRqYrMu9D7O8vOim2J10NGSV24L4
        VKZV+XvMZl/1/3Fyv82xXZHGtR8T15Xv6Hg6ceI9sc23N71XzJmnGdxlsvdUf7OyfLXjl1Vx
        /Y/+rHG+9SP284NZrs9uLNGOvnRSuLNM9YVU0qN8NdFa38c9rkU1JZFRRTXPFkXv0vvZ8059
        8pZXtpW1FWkvbsVbm1y/9nlPgnq61fdnF6M0m/cliHLx7N34pp/dzMXPXk7HLXm22k8Lucnu
        Uk8Mb6rrcwcLLN5z7RlTwJvQC6lnS2YGMZVqzdPsCY6qYdw658Es95Lojxed5Ja+qtjXWps2
        m3nCt5ksHOE2Ucevr9g4lY2fV28q84yjv7tk54c9/KBfvCtMiaU4I9FQi7moOBEAVJBUXRQD
        AAA=
X-CMS-MailID: 20231005090336epcas2p23324d8515a0672339947f40c03a36957
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----xslo3DI.q1fDSeNNPjgkAZmZXyJ4w6T2ybqCQ5Dd8ST06DPX=_9ae01_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e
References: <CGME20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e@epcas2p3.samsung.com>
        <20230922130528.3475445-1-jtp.park@samsung.com>
        <yuxcbtl6zjtas55y6d4x6q6jx267fjcsvhjodofk6sqsg25lhh@gcvpdf3j3bmi>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------xslo3DI.q1fDSeNNPjgkAZmZXyJ4w6T2ybqCQ5Dd8ST06DPX=_9ae01_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Sep 27, 2023 at 06:02:03PM -0700, Davidlohr Bueso wrote:
> On Fri, 22 Sep 2023, Jeongtae Park wrote:
> 
> > Hello,
> > 
> > We are currently trying to add background commands like
> > fw-related and sanitize operation. However, as we modified
> > the code, we found that there was a lot of duplication of
> > code, so we would like to modify the existing background
> > command handling a little bit. We want to make the most of
> > the existing background command handling so that we can
> > easily add other background commands in the future.
> 
> What code duplication? All you need to do is arm the
> struct cxl_mbox_cmd with sensible timeouts. For example,
> see 9521875bbe0 (cxl: add a firmware update mechanism using
> the sysfs firmware loader).
> 
> > The first patch modifies the existing sanitize operation
> > handling to allow other background commands to be used
> > with it, and the second patch modifies sanitize to work
> > with the modified code. Finally, the third patch adds a
> > sysfs file related to the background operation.
> > This sysfs entry is select/poll capable from userspace
> > to notify upon completion of a background operation.
> 
> This says nothing about the motivation of these changes.
> Specially when it has been well discussed in the past that
> exactly because of its monopolizing nature, the driver will
> _only_ do sanitize asynchronously. See the changelog of
> ccadf1310fb (cxl/mbox: Add background cmd handling machinery).
> 
> Thanks,
> Davidlohr

Hello Davidlohr,

I'm afraid that as you mentioned, the cover letter didn't seem to be
written including the problems need to be improved (we are guessing)
and our intentions. I'll review history about them, and make more
specific examples to explain our intentions and how we're going to fix it.

(Sorry for late reply, We've been on long holiday for a while.)

Thanks!
/jtpark

------xslo3DI.q1fDSeNNPjgkAZmZXyJ4w6T2ybqCQ5Dd8ST06DPX=_9ae01_
Content-Type: text/plain; charset="utf-8"


------xslo3DI.q1fDSeNNPjgkAZmZXyJ4w6T2ybqCQ5Dd8ST06DPX=_9ae01_--
