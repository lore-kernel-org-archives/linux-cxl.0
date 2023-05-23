Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B39C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 23 May 2023 08:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEWIH5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 May 2023 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjEWIHh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 May 2023 04:07:37 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42D3E72
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 01:07:08 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230523075727epoutp046e927f052a6111338634b1d054d2dd41~htrpW9Yw40846608466epoutp04Y
        for <linux-cxl@vger.kernel.org>; Tue, 23 May 2023 07:57:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230523075727epoutp046e927f052a6111338634b1d054d2dd41~htrpW9Yw40846608466epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684828647;
        bh=EnXIQZa7ZBGj9gM8MytDe2InbcZZ33xIBVxsLkHdcmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ebujmq+EhailbYJK0DqKurGFdAQzgdTyaMAXp8H+NLqs6Igieeyd9dlQ8BdkBQS7w
         wtEql9TeMK6F+oGyHEceJ7tpLJMAatYXJc6Q29Xb4jA8OB6ZMgPgn/gVguB6X0yIN6
         5ICAiMnPBJlNMdekWVC+YyvZW9d4Y6gWKlr9+tdA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230523075726epcas2p284726eba9f27455f614d1c3bd1acda57~htrowiMrP2255922559epcas2p2N;
        Tue, 23 May 2023 07:57:26 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QQRVs60Bgz4x9QF; Tue, 23 May
        2023 07:57:25 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.A3.07392.5E17C646; Tue, 23 May 2023 16:57:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230523075724epcas2p28753321afcdcff9bf23f84c0dd3779fd~htrnLw3op2255922559epcas2p2F;
        Tue, 23 May 2023 07:57:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230523075724epsmtrp1be9ea54bc1623b7dddb6dcfb269c81be~htrnKtGpe2688926889epsmtrp1I;
        Tue, 23 May 2023 07:57:24 +0000 (GMT)
X-AuditID: b6c32a47-eedff70000001ce0-79-646c71e51506
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.8C.27706.4E17C646; Tue, 23 May 2023 16:57:24 +0900 (KST)
Received: from dell-ArcherCity (unknown [10.229.83.212]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523075724epsmtip1688463104da39deec26c39d36f4177f8~htrnCNTqz0514605146epsmtip11;
        Tue, 23 May 2023 07:57:24 +0000 (GMT)
Date:   Tue, 23 May 2023 16:57:30 +0900
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        ks0204.kim@samsung.com
Subject: Re: [ndctl PATCH v2 2/2] cxl: add inject-poison & clear-poison
 commands to cxl tool
Message-ID: <ZGxx6qE041xx630G@dell-ArcherCity>
MIME-Version: 1.0
In-Reply-To: <ZGbgJWnC+sCttmhw@aschofie-mobl2>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdljTTPdpYU6KQdtcVou7jy+wWTRPXsxo
        MX3qBUaL/U+fs1gc3cNhcX7WKRaLWxOOMTmweyze85LJY9OqTjaPvi2rGD0+b5ILYInKtslI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ2x5cxn
        toLd4hVb7s5lamA8ItTFyMEhIWAiceyARRcjF4eQwA5Gif73u1ghnE+MEuePLmfpYuQEcr4x
        Suz9lAJigzScv3yEHSK+l1Hi+99wiIa3jBIvjk5kBZnKIqAq8WqXK0gNm4C2xN/+6YwgYREB
        Q4kF09RAypkFpjNKdHw6yAZSIywQJ7GjuZ0ZxOYV0JOYPfUXE4QtKHFy5hOwGziB4tc71rCD
        NEsIvGWXuHv3LjPEBy4SH5fmQdwmLPHq+BZ2CFtK4mV/G5SdLzH14EQou0Si7cwBKNtY4t3N
        56wgNrNAhsTS851MECOVJY7cYoEI80l0HP7LDhHmlehoE4LoVJXYsuEF1BRpiaMTN7FA2B4S
        d380MkNC5DmjxJdfs1gmMMrNQvLNLCTbIGwdiQW7P7HNAlrBDDRr+T8OCFNTYv0u/QWMrKsY
        xVILinPTU4uNCozhkZucn7uJEZwWtdx3MM54+0HvECMTB+MhRgkOZiUR3hPl2SlCvCmJlVWp
        RfnxRaU5qcWHGE2BMTORWUo0OR+YmPNK4g1NLA1MzMwMzY1MDcyVxHmlbU8mCwmkJ5akZqem
        FqQWwfQxcXBKNTD5zJNT2HPPMtGG/WTvLQH9QwpS6/ilTLa6Td/b+rCnWFHn+DHO3K0xG4o2
        TRHNcJGKd9SbbLqD6+aHzcf6bzv0fajeN2XngRvzl5xP3V7bdMX+CqvkJs+Xcyd3endce7HU
        4/n/e31f3/sfm+S7bG19FFu/wc7kaxJT773fuP/aKe9mqz3nf97ccj+svJQn8HcT8/mIagUt
        y8lNb753nDic8dvqQcHkY/NrQ/60NczuVFDR+fL0xva/rGl2eQ/enLa4ZmuaN2HzgktHsvNW
        dl/ofnqPpUG9/Z21/X2tLDnX0qxfL5Pq75xYsGC3S8q/1K/Oe/RN760+Lf1/n/Q2xjdX+o2Z
        Lh0yPD7/8IwNIYniL5VYijMSDbWYi4oTAd1MXlAUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnO6TwpwUg5XrNCzuPr7AZtE8eTGj
        xfSpFxgt9j99zmJxdA+HxflZp1gsbk04xuTA7rF4z0smj02rOtk8+rasYvT4vEkugCWKyyYl
        NSezLLVI3y6BK+Pp5LusBb9FKvbs3cvYwDhXoIuRk0NCwETi/OUj7F2MXBxCArsZJe6tXcsK
        kZCWuPGoiw3CFpa433KEFaLoNaPE2nsvGLsYOThYBFQlXu1yBalhE9CW+Ns/HSwsImAosWCa
        Gkg5s8B0RomOTwfB5ggLxEnsaG5nBrF5BfQkZk/9xQQx8zmjxIEzZ9ggEoISJ2c+YQGxmQW0
        JG78e8kEMpQZ6KDl/zhAwpxAvdc71rBPYBSYhaRjFpKOWQgdCxiZVzFKphYU56bnFhsWGOal
        lusVJ+YWl+al6yXn525iBIe3luYOxu2rPugdYmTiYDzEKMHBrCTCe6I8O0WINyWxsiq1KD++
        qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpjnPf3rwqL3z0jy0hI/VK/DB
        ro+3n89LMuFjU9PlKN3MM3P2/aSdrxdYHPkav/yrovjT/VFbJ5hUxM5gTbP4yHH+XvdDqV9M
        bU7aO4VOTvpWNlnScT2/5NsmtvjEjWxsSz5IecaabXnjJ/yxw2bj5M9fv1YcFVi9OujKhpOu
        kp9e6Qm1JeisWmoY+cxkz0OpRfnb3gS7vlxzfm7pz+iV3Kzbtn2Y/mn3ou8ZO5bt3v7tzFXf
        dJUdMxddK8qYUR7Elhv0M2VZ3urk6L1Jcx8JNO/PaWh7d5eHaf/P+7xcO/usDAQW+nUsTa0t
        a768evVuvkszj/CpRGz0enX1X+OWT/XSpd9SZ8bpCUcZ/Xikx7hfiaU4I9FQi7moOBEAUDUu
        yN4CAAA=
X-CMS-MailID: 20230523075724epcas2p28753321afcdcff9bf23f84c0dd3779fd
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Y9bAoTVPo7TEjNVVx8BuVeRnQePgNsPKB0hZTbOgiEUDqOwX=_234f1_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230517032403epcas2p48fbabf7aec3334b4892c87265b1a7705
References: <20230517032311.19923-1-junhyeok.im@samsung.com>
        <CGME20230517032403epcas2p48fbabf7aec3334b4892c87265b1a7705@epcas2p4.samsung.com>
        <20230517032311.19923-3-junhyeok.im@samsung.com>
        <ZGbgJWnC+sCttmhw@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------Y9bAoTVPo7TEjNVVx8BuVeRnQePgNsPKB0hZTbOgiEUDqOwX=_234f1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, May 18, 2023 at 07:34:13PM -0700, Alison Schofield wrote:
> On Wed, May 17, 2023 at 12:23:11PM +0900, Junhyeok Im wrote:
> > Add new commands to cli tool, to inject and clear poison into dpa(-a) on the
> > memory device(memdev), and add man page documentation for the commands
> > (inject-poison, clear-poison).
> > 
> > Since the validity verification of the dpa would be done in
> > 'cxl_validate_poison_dpa' of CXL driver, no additional logic is added
> > in this patch.
> 
> Hi Junhyeok,
> 
> Thanks for syncing this up with the driver changes.
> 
> How about supporting the end user with checks on that DPA cmdline parameter?
> 
> As you stated, the driver validate the DPA. It does emit meaningful messages
> in a debug kernel:
> dev_dbg(cxlds->dev, "device has no dpa resource\n");
> dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n"
> The driver returns the same, -EINVAL response, to all those errors.
> 
> In addition to being more user friendly, stopping the bad input,
> as soon as it can be detected, is just good practice.
> 

Thanks for the comments. 
I will include your feedback in the next (v3) patch, probably contain a 
'validate_poison_dpa' static function in memdev.c

> a bit more below...
> 
> > 
> > Also since it is expected no use case of injecting / clearing poison into the
> > same address for multiple devices, this command targets only one memdev,
> > like 'write-labels' command.
> > 
> >  usage: cxl {inject,clear}-poison <memdev> -a <dpa> [<options>]
> > 
> >     -v, --verbose         turn on debug
> >     -S, --serial          use serial numbers to id memdevs
> >     -a, --address <dpa>   DPA to inject or clear poison
> 
> What do you think about adding a length option and supporting the inject
> and clear of a range of addresses?
> 
> That's all for now,
> Alison
> 

I think it is a necessary and usable option.
Regarding the specific action with 'length' option, I would like to sync
up with what you have in your mind.
Let's see the following examples, while '-l' means 'length' in bytes from
the dpa specified by '-a'.
  1) $ cxl inject-poison mem0 -a 0x1000 
  2) $ cxl inject-poison mem0 -a 0x1000 -l 0
  3) $ cxl inject-poison mem0 -a 0x1000 -l 0x40
  4) $ cxl inject-poison mem0 -a 0x1000 -l 0x80
In my humble opinion, 
  for the case 1), poison injected to 0x1000
  for the case 2), invalid length
  for the case 3), poison injected to 0x1000, like 1)
  for the case 4), poison injected to 0x1000 and 0x1040.
May I ask what you think about above?

Really thanks.
- Junhyeok Im.
> --snip

------Y9bAoTVPo7TEjNVVx8BuVeRnQePgNsPKB0hZTbOgiEUDqOwX=_234f1_
Content-Type: text/plain; charset="utf-8"


------Y9bAoTVPo7TEjNVVx8BuVeRnQePgNsPKB0hZTbOgiEUDqOwX=_234f1_--
