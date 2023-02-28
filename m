Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EB3C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 09:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjB1JpM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 04:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjB1JpF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 04:45:05 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6ADF941
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 01:44:33 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230228094407epoutp02dffa2cefbb044fd4a025ab97d1c814e6~H88zod3QP0649406494epoutp02i
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 09:44:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230228094407epoutp02dffa2cefbb044fd4a025ab97d1c814e6~H88zod3QP0649406494epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677577447;
        bh=A5nSMz2C00bL+LjFn6vHKAQiKJjeR6suvQ00cxGQl6M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q3BmQSRxy9IUMb46JbE4BmJvYgFSznzDpKG9zSdlvSCQKfLuehtxSaXJTA0rDLswb
         hv+tBUKcu9XXZf3BwKGjRNknRC6Y0PTBg1BU5NPD7ROVa8MUXYKwMYVy8WexfePylk
         YJnX3XGELm/9oHSfbMbrhfPMGeCXcVKvN1RLYceM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230228094406epcas2p4ddef1610a6e8388de654557fa436c084~H88yn8k-y2739727397epcas2p4h;
        Tue, 28 Feb 2023 09:44:06 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PQsrj6j9Hz4x9Pr; Tue, 28 Feb
        2023 09:44:05 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        04.A8.05668.5ECCDF36; Tue, 28 Feb 2023 18:44:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20230228094404epcas2p288f0ca1e1c57f93599cb2b3bd624b2e5~H88xIi9ek2110821108epcas2p2b;
        Tue, 28 Feb 2023 09:44:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230228094404epsmtrp2713a30578603d799d4dbc4ad6fdc2389~H88xHuyXB1092810928epsmtrp2a;
        Tue, 28 Feb 2023 09:44:04 +0000 (GMT)
X-AuditID: b6c32a48-1f7ff70000021624-7b-63fdcce51bbe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.B1.17995.4ECCDF36; Tue, 28 Feb 2023 18:44:04 +0900 (KST)
Received: from dell-ArcherCity (unknown [10.229.83.212]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230228094404epsmtip10e43565d27b8116af08ed560be84f499~H88w-Eqos1081410814epsmtip1h;
        Tue, 28 Feb 2023 09:44:04 +0000 (GMT)
Date:   Tue, 28 Feb 2023 18:45:16 +0900
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl 2/3] cxl: add inject-poison command to cxl tool
Message-ID: <Y/3NLEdkuNXoFLb2@dell-ArcherCity>
MIME-Version: 1.0
In-Reply-To: <Y/wivgTuKuxvB2jt@aschofie-mobl2>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmme7TM3+TDW7fMrS4+/gCm0Xz5MWM
        FtOnXmC0OD/rFIvFrQnHmBxYPRbvecnksWlVJ5vH501yAcxR2TYZqYkpqUUKqXnJ+SmZeem2
        St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCuVFMoSc0qBQgGJxcVK+nY2RfmlJakK
        GfnFJbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZr14nF+zgq2iY8Je9gXE3dxcj
        J4eEgIlE87c9jF2MXBxCAjsYJS6fa2aCcD4xSsx+9ZANwvnMKNG/4AMLTMvOvp3sEIldjBLL
        JnczgSSEBN4ySpx/wghiswioSqz6e48VxGYT0Jb42z8dKM7BISJgKLFgmhqIySyQIbF3K1in
        sICzxNvWVrDxvAJ6En+OnWSCsAUlTs58AhbnBIo3vr7BArJWQuAcu8SFpofMEPe4SFxpboe6
        TVji1fEt7BC2lMTnd3vZIOx8iakHJ0LFSyTazhyAso0l3t18DnYms0CmxPft25hAbpMQUJY4
        cosFIswn0XH4LztEmFeio00IolNVYsuGF1BTpCWOTtwEdYGHxJan96EB+pxRYtX26ywTGOVm
        IXlnFpJtELaOxILdn9hmgUNFWmL5Pw4IU1Ni/S79BYysqxjFUguKc9NTi40KTOCxm5yfu4kR
        nPy0PHYwzn77Qe8QIxMH4yFGCQ5mJRHehbf/JAvxpiRWVqUW5ccXleakFh9iNAXGzERmKdHk
        fGD6zSuJNzSxNDAxMzM0NzI1MFcS55W2PZksJJCeWJKanZpakFoE08fEwSnVwFR37eek+JAr
        lxdJhXH/3KTGJjDX0qfnweL1QkcWs+wP7ufJFdj25LFoj/9zhflLl3bbLT+QsfhR5ZS+98G+
        uXsmtq7QPPLEoXDfirm3na6LTzfZ5PGMp75zjlzV+m0HuDhm/knIz7Oo+uGuP7up5E6dliGz
        3w7+GWKyrZu6EnNCL03YLB/vXsu4UujSbTbl3P1f30bNlt4eusnw5G/vkB93Ij6r7jny78Ir
        sfuWs09tqxRlKPcWUfsl0vU8zl9V1MvjZoPckcttnyurEpwmHots/HeyfHuKXlmK+maJRwqb
        J1TvjjRsm/r6ud63R98e3shsO/ds3/F3X7cVHxSdvp4lNkzo5T/m9/u2v80umX1ViaU4I9FQ
        i7moOBEAs0tvCQcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSnO6TM3+TDc7OM7G4+/gCm0Xz5MWM
        FtOnXmC0OD/rFIvFrQnHmBxYPRbvecnksWlVJ5vH501yAcxRXDYpqTmZZalF+nYJXBlfrjxk
        K/jKXXH77Te2BsaJnF2MnBwSAiYSO/t2sncxcnEICexglLg0o4sZIiEtceNRFxuELSxxv+UI
        K0TRa0aJnh+bwIpYBFQlVv29xwpiswloS/ztn87YxcjBISJgKLFgmhqIySyQIbF3KxNIhbCA
        s8Tb1lYWEJtXQE/iz7GTYHEhgeeMEs+3JkLEBSVOznwCVsMsoCVx499LJogx0hLL/3GAhDmB
        Whtf32CZwCgwC0nHLCQdsxA6FjAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5f
        La0djHtWfdA7xMjEwXiIUYKDWUmEd+HtP8lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwX
        EkhPLEnNTk0tSC2CyTJxcEo1MMWU14vzhsl4pws+nOmqLhcS36dRybap+eOVkL95rwyWPFwx
        QzipcdEnjxjmGMspm1hENPQ2dwYt9LfbPDc+ZEJ6tWHPmTsqAs0yj965JrMfsVv05db9b61T
        /+3k1d8l6MMozCkXVb6sX3deV+Nn1e78GULW99t/HNzHdOxryEcWc2PRI2dkmXk/lfkFV90y
        6dxy+WZX/nMN/7eZSgYvWX+ePX5I+cDrxckeZpeLt/9JaTJrS+AQtmZNXeLJqPN9dvNEt2ZB
        DyePzijpTT5Pi/bWLhQ6v9kkWrqu0lVkbfr9U8cLX735LL2maYOPwJ+a4vNXJV9FZ0z/pbxj
        XcM1KXE9407pv9EPWC0nypQrsRRnJBpqMRcVJwIA9AeOV84CAAA=
X-CMS-MailID: 20230228094404epcas2p288f0ca1e1c57f93599cb2b3bd624b2e5
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_11d376_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec
References: <20230220045709.94027-1-junhyeok.im@samsung.com>
        <CGME20230220045608epcas2p11d40339e7401f5bf99a9e97308058fec@epcas2p1.samsung.com>
        <20230220045709.94027-3-junhyeok.im@samsung.com>
        <Y/wivgTuKuxvB2jt@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_11d376_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Feb 26, 2023 at 07:25:50PM -0800, Alison Schofield wrote:
> On Mon, Feb 20, 2023 at 01:57:08PM +0900, Junhyeok Im wrote:
> > Add new command to cli tool, to inject poison into dpa(-a) on the
> > memory device.
> > 
> > DPA written in sysfs attribute(inject_poison) is converted by
> > kstrtou64 with 0 base by 'inject_poison_store' of CXL driver, so if
> > it begins with 0x the number will be parsed as a hexadecimal
> > (case insensitive), if it otherwise begins with 0, it will be parsed
> > as an octal number. Otherwise it will be parsed as a decimal.
> > 
> > Since the validity verification of the dpa would be done in
> > 'cxl_validate_poison_dpa' of CXL driver, no additional logic
> > is added.
> > 
> > Also since it is expected no use case of injecting poison into the
> > same address for multiple devices, this command targets only one
> > memdev, like write-labels command.
> > 
> >  usage: cxl inject-poison <memdev> -a <dpa> [<options>]
> > 
> >     -v, --verbose         turn on debug
> >     -S, --serial          use serial numbers to id memdevs
> >     -a, --address <dpa>   DPA to inject poison
> > 
> 
> Upon successful completion of the command, display the --media-errors
> list for that device.
> 
> <snip>
> 

So, your comment is that the media-errors list (like $ cxl list --media-erros)
should be printed after command completion. 
I agree in terms of the completeness of the command operation. 
Thank you for your good opinion. I'll make up for it.


------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_11d376_
Content-Type: text/plain; charset="utf-8"


------KShBqqPo14.eBT3ESqKA1JUVW8Pp5OSRF8p2BdrChsSVkVya=_11d376_--
