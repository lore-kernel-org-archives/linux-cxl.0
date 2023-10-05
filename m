Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4458E9270F
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Oct 2023 14:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjJEOpb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbjJEOmL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Oct 2023 10:42:11 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CEC89437
        for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 07:17:54 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231005082210epoutp02fcb4b88f32b13de265af7ff1f603f81c~LKGxJL_By0437604376epoutp02S
        for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 08:22:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231005082210epoutp02fcb4b88f32b13de265af7ff1f603f81c~LKGxJL_By0437604376epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696494130;
        bh=9Bql2C6YPLo0m7tbicjxKoo3yZyB5XMUpUwQxC1DxlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jOHhga9ZOGaiFLEhT+x2F9PNQnQIEPod11LVZi6GoLCwccppVX2dVZa2UGXRumWGO
         yF9/ZwADh3j+YQ6CDSOp6JnzlLeVRTcXXP5rzlyqaPr3kRh9O3U7kpOJnFwj7HyjPS
         3ad67LdVbck+3KqzbIF8RElJTvclINx4J+EAkU1U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20231005082209epcas2p272872fa0f66d2b693bedbcf0c3203269~LKGwllOvO1235412354epcas2p2I;
        Thu,  5 Oct 2023 08:22:09 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4S1Pg46m4bz4x9Pv; Thu,  5 Oct
        2023 08:22:08 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.14.09660.0327E156; Thu,  5 Oct 2023 17:22:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231005082208epcas2p1686f153bacd9b1a3af86cd169ef46cc4~LKGvfVYbn2629326293epcas2p1d;
        Thu,  5 Oct 2023 08:22:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231005082208epsmtrp17812a3af39ab8f2db356186b6982baa1~LKGvebEiN0214102141epsmtrp18;
        Thu,  5 Oct 2023 08:22:08 +0000 (GMT)
X-AuditID: b6c32a47-afdff700000025bc-b9-651e72309c54
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.CC.18916.0327E156; Thu,  5 Oct 2023 17:22:08 +0900 (KST)
Received: from jtpark-7920 (unknown [10.229.83.56]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231005082208epsmtip1a5b469e2cce37357946c77bb7c2e43a7~LKGvRUwhX3159531595epsmtip1Z;
        Thu,  5 Oct 2023 08:22:08 +0000 (GMT)
Date:   Thu, 5 Oct 2023 17:24:55 +0900
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        Wonjae Lee <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        Jeongtae Park <jeongtae.park@gmail.com>
Subject: Re: [RFC PATCH 0/3] cxl: Fix background operation handling
Message-ID: <ZR5y1+WfngcPuj3O@jtpark-7920>
MIME-Version: 1.0
In-Reply-To: <5476c53d-d49e-61ba-5f78-abefc5f8c7cf@intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmha5BkVyqwfG5phZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wiw9v/rFYHHjdwG5x5uxLVotVC6+xWSw+OoPZ4ugeDovz
        s06xWNyacIzJYuP9d2wO/B47Z91l92g58pbVY/Gel0wem1Z1snn0bVnF6DF1dr3H501yAexR
        2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGcrKZQl
        5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Iz
        Vv+6yF6wQKjiwb0brA2M8/m6GDk5JARMJC7OamXrYuTiEBLYwShxd8I5dgjnE6PEjo/LWOCc
        /q6JrDAtj5ofQCV2MkrM75rDCOG8YJSY+KybHaSKRUBF4tiv08wgNpuAlsT0mQ1g3SICqhL3
        1z8GW8gssJRFYnvHTjaQhLCAs8T7M/vBbF6ghq/T7zNC2IISJ2c+YQGxOQVsJc5Pes4E0iwh
        sIVD4sHliewQN7lIPPt7iQ3CFpZ4dXwLVFxK4mV/GztEQzOjxOvnV1ggnBZGiXW3d0BVGUu8
        u/kc7D5mgQyJIycbgOIcQHFliSO3WCDCfBIdh/9ChXklOtqEIDqVJOYtnccMYUtIXJq7Bcr2
        kDi/7i80JA8xSsx51c46gVFuFpKHZiHZBmHrSCzY/YltFtAKZgFpieX/OCBMTYn1u/QXMLKu
        YhRLLSjOTU8tNiowhkdycn7uJkZwStZy38E44+0HvUOMTByMQDs5mJVEeNMbZFKFeFMSK6tS
        i/Lji0pzUosPMZoCo2cis5Rocj4wK+SVxBuaWBqYmJkZmhuZGpgrifPea52bIiSQnliSmp2a
        WpBaBNPHxMEp1cDEeNtux4HbJh1XFiVs+3ZJwDkj7JzCbwXBQNaoDz5zZOOsVuxbHFn67Sp/
        SkaH3d4TV64x5q+vnbb7+jwB6/OHHFXVNyZ8rlwY94O9Zu+040Wrkv5/ZbkcE9d6JPSLjPvR
        gz6FKR6KPrc6KjdahilceG11esLK3iNTwx79u7vgfKUIQ+rHqni2uq6l5bb896seX7r0Y4r5
        pvNcUzRvTfQufL1Imsn29rbSqSXSzy4/2C7ArbHKa1WO3Dqrl4YLMuqqJBQa/hafzJPa7zXT
        90WTquD1E3JHpV6vuvB00smigpP3N8366Lh6U/S6xw5ukxiO17sGtiYFHgn5YJ7P8OXhng1V
        e3uN1RfrRjO+KpFRV2Ipzkg01GIuKk4EAHmqwcNSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnK5BkVyqwfzTQhZ3H19gs2ievJjR
        YvrUC4wWJ242slmsvrmG0aJp9V1Wiw9v/rFYHHjdwG5x5uxLVotVC6+xWSw+OoPZ4ugeDovz
        s06xWNyacIzJYuP9d2wO/B47Z91l92g58pbVY/Gel0wem1Z1snn0bVnF6DF1dr3H501yAexR
        XDYpqTmZZalF+nYJXBkz195mLXjAX7H8w2u2BsYf3F2MnBwSAiYSj5ofsHQxcnEICWxnlLjx
        oIEdIiEhsXzDCyYIW1jifssRVoiiZ4wSJ+euBEuwCKhIHPt1mhnEZhPQkpg+s4EVxBYRUJW4
        v/4xG0gDs8BqFonfx16CFQkLOEu8P7OfDcTmBWr4Ov0+I8TUQ4wSz+f0MEIkBCVOznzCAmIz
        AxXd+PcSaBsHkC0tsfwfB0iYU8BW4vyk50wTGAVmIemYhaRjFkLHAkbmVYyiqQXFuem5yQWG
        esWJucWleel6yfm5mxjBcaQVtINx2fq/eocYmTgYgU7hYFYS4U1vkEkV4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYJKJvsX/2mn7heWHG2u3zlm590jH
        7Aez7N+t3BW/3HVJ046ou2umnT3z74xO5iLuqekeXav+H3YWX3/wJJeqdTiPqbXnmV33m4+8
        lpNlfvZ/tbjNcnVlpy5nkdjNfqfMlVuWF/37tiHm59t3S/7Oz/0fnq/inhOUobHHpU1Q2cZy
        8Qf2W7zH/kWZV8++cuv7H7OXp5axPF1Y19myyrr+zeJvp6bmLj/n93dzzWHfb7Kf13Wf1jqm
        lNrXbJGS1p3fJ9OwufnF3fv3rO05Wxk/HZ+TwzO7wPvA3XsaW//H7vnw6OK9icYuJXV2S87M
        1zyonH5khkKjz/U9aamzPmdYp7E0xL3vrOZ9qpqm+3dH/hUFJZbijERDLeai4kQA+vVZ/xID
        AAA=
X-CMS-MailID: 20231005082208epcas2p1686f153bacd9b1a3af86cd169ef46cc4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----UO.gBI9h3KzXx7fAUzAwhoREi3kPxaIpZHHzoQQrAoo4vDHp=_9a398_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e
References: <CGME20230922130253epcas2p3112ca71e8a1dcf42967543063322df1e@epcas2p3.samsung.com>
        <20230922130528.3475445-1-jtp.park@samsung.com>
        <5476c53d-d49e-61ba-5f78-abefc5f8c7cf@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------UO.gBI9h3KzXx7fAUzAwhoREi3kPxaIpZHHzoQQrAoo4vDHp=_9a398_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, Sep 25, 2023 at 03:56:54PM -0700, Dave Jiang wrote:
> 
> 
> On 9/22/23 06:05, Jeongtae Park wrote:
> > Hello,
> > 
> > We are currently trying to add background commands like
> > fw-related and sanitize operation. However, as we modified 
> > the code, we found that there was a lot of duplication of
> > code, so we would like to modify the existing background 
> > command handling a little bit. We want to make the most of
> > the existing background command handling so that we can
> > easily add other background commands in the future.
> > 
> > The first patch modifies the existing sanitize operation
> > handling to allow other background commands to be used 
> > with it, and the second patch modifies sanitize to work
> > with the modified code. Finally, the third patch adds a
> > sysfs file related to the background operation. 
> > This sysfs entry is select/poll capable from userspace 
> > to notify upon completion of a background operation.
> > 
> > Thanks,
> > /jtpark
> 
> Hi Jeongtae,
> For the next version of the series you send out, can you please make sure the series is threaded? Currently all your series are coming as individual mails. Thanks!


Sorry about that, I think there a problem of mail security system
at that time. I'll test internally before sending the patch series.

Thanks!

> 
> 
> > 
> > Jeongtae Park (3):
> >   cxl: Modify background cmd handling for the others
> >   cxl/mbox: Update sanitize opcode support
> >   cxl/memdev: Add background command sysfs file
> > 
> >  Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++
> >  drivers/cxl/core/mbox.c                 |  5 +-
> >  drivers/cxl/core/memdev.c               | 71 +++++++++++++++++++++++--
> >  drivers/cxl/cxlmem.h                    | 33 ++++++++++--
> >  drivers/cxl/pci.c                       | 65 +++++++++++-----------
> >  5 files changed, 141 insertions(+), 43 deletions(-)
> > 
> > 
> > base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9

------UO.gBI9h3KzXx7fAUzAwhoREi3kPxaIpZHHzoQQrAoo4vDHp=_9a398_
Content-Type: text/plain; charset="utf-8"


------UO.gBI9h3KzXx7fAUzAwhoREi3kPxaIpZHHzoQQrAoo4vDHp=_9a398_--
