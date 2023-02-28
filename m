Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B163C64EC4
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 23:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjB1XUq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjB1XUp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 18:20:45 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60661E1DC
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 15:20:42 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230228232038usoutp0294af7efb235473bcd993673d9f78e16d~IIFuK3piz1147811478usoutp02R;
        Tue, 28 Feb 2023 23:20:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230228232038usoutp0294af7efb235473bcd993673d9f78e16d~IIFuK3piz1147811478usoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677626438;
        bh=ohZ+yizsQLIUpViu2Qv3WsdPiEePv4pH3zvOQnI1C4s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=disut+zh75ZPbz+763LDjE0pthkd4KHnncM+MZb99Tf/2je66OQWsBP48tqDMY+QL
         3DMSRlL+78OE6uxsNAtIIKqATLakqaA9agNpX7b/uxds6W8eP61Niu7T9EPL8TgieM
         TaJKP6N9we76Fk6WKbj5Q3mCnqvsYZL4jj0+BxSc=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228232038uscas1p18a2482d9effb75d9728af922c72c94b5~IIFuEzKHh1607416074uscas1p1K;
        Tue, 28 Feb 2023 23:20:38 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id B4.53.49129.64C8EF36; Tue,
        28 Feb 2023 18:20:38 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228232038uscas1p20112a8c23b622658b24949147131b78e~IIFttma-l0670506705uscas1p24;
        Tue, 28 Feb 2023 23:20:38 +0000 (GMT)
X-AuditID: cbfec36f-167fe7000001bfe9-08-63fe8c464063
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id B5.49.17110.54C8EF36; Tue,
        28 Feb 2023 18:20:38 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 28 Feb 2023 15:20:37 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        28 Feb 2023 15:20:37 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Alison Schofield <alison.schofield@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/region: Add cxl_memdev_active_region()
Thread-Topic: [PATCH 3/7] cxl/region: Add cxl_memdev_active_region()
Thread-Index: AQHZSIjKgg75QTtW6UqE1hGG9+eV667isUGAgAKpooCAADCqgA==
Date:   Tue, 28 Feb 2023 23:20:37 +0000
Message-ID: <20230228232018.GA1402731@bgt-140510-bm03>
In-Reply-To: <20230228202623.ceytv4ecryxcloxc@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EDD50BA6FF7F44AAA5F3214A8A878F2@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djX87puPf+SDbZ2KVncfXyBzWL61AuM
        FqtvrmG02P/0OYvFqoXX2CzOzzrF4sDm0XLkLavH4j0vmTymzq73+LxJLoAlissmJTUnsyy1
        SN8ugSvjX9thxoKbHBUPH7exNjA+Y+ti5OSQEDCR2Nb2lbWLkYtDSGAlo0TDwRZ2CKeVSaL7
        0CFWmKq97cdYIBJrGSV2zXvDDOF8AnK+z4RqWcYo8ebAH7DBbAKKEvu6toPZIgLqEvPW3mYE
        KWIWOMgk0XH1DFhCWMBZ4t3vR+wQRS4STSt3QzU4SXye0sQIYrMIqEpceb8AzOYVMJNo2XgW
        rIZTwFzixMfLLCA2o4CYxPdTa5hAbGYBcYlbT+YzQdwtKLFo9h5mCFtM4t+uh1BfK0rc//6S
        HaJeR2LB7k9sELadxM7/k6DmaEssW/iaGWKvoMTJmU9YIHolJQ6uuAEOCwmBExwSe5a/A2rm
        AHJcJC5c1YSokZb4e3cZE0Q4WWLVRy6IcI7E/CVboMZYSyz8s55pAqPKLCRXz0Jy0SwkF81C
        ctEsJBctYGRdxSheWlycm55abJSXWq5XnJhbXJqXrpecn7uJEZiKTv87nL+D8fqtj3qHGJk4
        GA8xSnAwK4nwLrz9J1mINyWxsiq1KD++qDQntfgQozQHi5I4r6HtyWQhgfTEktTs1NSC1CKY
        LBMHp1QDU8zaSr7E1vLs4JqU+w7Ok3j5v+x5Nndmr0bOOT6G175Ctzevve0c+Or07Gj+5I49
        D1wZ/r9I2MAgtpk39OJPuVf22hN3XZ41b8VDJc/j7jE7HJi1HBccX6Um9tyn66KllEiKStQ2
        w2U/Q7w94hh22N7JzDGL5V8qXqkhsuGxs9z3td8N5K9ktL6PSfg3KeTazlMuzBcN5+ZNemIo
        3nf+NG/fibZDixgXXjqSbpWuueycdtkOiY+qDScc+Y6szVPcUzdDzGef4/2jZ/9uzj7zh1ng
        gdISR9P1sQ8l/lx5JRebrlKy3mkz14rNnb4VMoEX30qvYO+dF9zhFrSzd1PEF+seqYYGt8RX
        h1nMTzquU2Ipzkg01GIuKk4EAGNNxme0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWS2cA0Udet51+ywdQv7BZ3H19gs5g+9QKj
        xeqbaxgt9j99zmKxauE1Novzs06xOLB5tBx5y+qxeM9LJo+ps+s9Pm+SC2CJ4rJJSc3JLEst
        0rdL4Mr413aYseAmR8XDx22sDYzP2LoYOTkkBEwk9rYfY+li5OIQEljNKDHr2BY2COcTo8TO
        e2eZIJxljBJPdzYygbSwCShK7OvaDtYuIqAuMW/tbUaQImaB/UwSnR1z2UESwgLOEu9+P2KH
        KHKRaFq5G6rBSeLzlCZGEJtFQFXiyvsFYDavgJlEy8azUKt7mCR+rr8P1swpYC5x4uNlFhCb
        UUBM4vupNWBXMAuIS9x6Mp8J4gkBiSV7zjND2KISLx//Y4WwFSXuf3/JDlGvI7Fg9yc2CNtO
        Yuf/SVBztCWWLXzNDHGEoMTJmU9YIHolJQ6uuMEyARgkSNbNQjJqFpJRs5CMmoVk1AJG1lWM
        4qXFxbnpFcVGeanlesWJucWleel6yfm5mxiBsXz63+HoHYy3b33UO8TIxMF4iFGCg1lJhHfh
        7T/JQrwpiZVVqUX58UWlOanFhxilOViUxHlfRk2MFxJITyxJzU5NLUgtgskycXBKNTC1yLzX
        6n/iIvNmt5j8v7vlqpbijttVGuf/4+h607PZfM+3uZt2HbrJK3zgq2Ch7D1j6wsa/ddDlwoZ
        JMTf8he79rLm4/7eH7cEZy1zWlKXxVWrqfL32cnpx9bP2uLZpHaLIXxR+Wrli1HXC3tNa6s+
        Ssuq7u1ZYr/k96YO/a4FV3s2SLa4Ck8z780Jfdu10ra8NkviUYjtJZHNT0JNOjSElqy/lWDv
        UzFh39VgQ+H1y2r6pxRlqMx3ctD7uGyO1r1j2YlL5+k+ve10zPnW3yiVX5e8Nrbs7Le+9Kdd
        xlDz7pfdtumG9cYepjse6z7sasr5yrvI8l/0zjfiDziEKw/Mr500x+bwkoiJPX/iyyYrsRRn
        JBpqMRcVJwIA+LFBqVQDAAA=
X-CMS-MailID: 20230228232038uscas1p20112a8c23b622658b24949147131b78e
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228205514uscas1p1cb55faea3e3885cbcc40fdde48471831
References: <20230224194652.1990604-1-dave@stgolabs.net>
        <20230224194652.1990604-4-dave@stgolabs.net>
        <Y/wno8C4bK3XNoUD@aschofie-mobl2>
        <CGME20230228205514uscas1p1cb55faea3e3885cbcc40fdde48471831@uscas1p1.samsung.com>
        <20230228202623.ceytv4ecryxcloxc@offworld>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 28, 2023 at 12:26:23PM -0800, Davidlohr Bueso wrote:
> Hi Alison,
>=20
> On Sun, 26 Feb 2023, Alison Schofield wrote:
>=20
> > I took a look here as I've been poked around in this space when looking
> > for 'region' names to associate with memdev poison trace events. [1]
>=20
> Thanks for the pointer.
>=20
> > How does the list created get used?
>=20
> It's used by the security commands, in the next patches in the series.
> This came about because Dan requested some way of knowing wether the
> memdev is being used (actively decoding HPA ranges).
>=20
> > If we only need to know that this memdev is mapped in any region,
> > so don't touch it, we can look at it's port->commit_end. If that
> > commit_end >=3D 0, we can look at each endpoint to find the regions
> > it's mapped to.

commit_end will not be updated during commit if the decoder flag is
with CXL_DECODER_F_ENABLE, not sure whether it will cause issue or not
for your case. Can we use hdm_end instead?

Fan
>=20
> I think this is a lot better than using the list approach.
>=20
> Thanks,
> Davidlohr=
