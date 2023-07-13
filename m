Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA90BC001B0
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 16:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjGMQNy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjGMQNx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 12:13:53 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFC32710
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 09:13:51 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230713161349usoutp0298122c4b074a767cb27d64e2b9453f08~xeWmlJxMf1299612996usoutp02n;
        Thu, 13 Jul 2023 16:13:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230713161349usoutp0298122c4b074a767cb27d64e2b9453f08~xeWmlJxMf1299612996usoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689264829;
        bh=cZ6caBQ2Oak4TIS3aIdzWcN7F89gozy3FMRByzjzjNQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KkJjIzi7gwcAP/yPYuuoLjcA+cdhHFrr5WVYerLzHY44zXVHarO/+yy1umrn6fKTr
         g++9WyDCFInLUwSDZRPiLpKUM/XK/MGnVfOlikYKRVy1Od0YjaloPdiy5mtm968ZkN
         QEXTmuYRHv5mxhIxFzNRcpZQmD7xB1gBX5r6D6g4=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230713161349uscas1p1d4f93308a61267e602a505a6d3c1ff28~xeWmFLFu80481504815uscas1p1K;
        Thu, 13 Jul 2023 16:13:49 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 89.53.62237.DB220B46; Thu,
        13 Jul 2023 12:13:49 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230713161348uscas1p27a0043e082fcb3f6df2afc03290e3014~xeWlv_IRa1811918119uscas1p2T;
        Thu, 13 Jul 2023 16:13:48 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-68-64b022bd5cd7
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 93.59.38326.CB220B46; Thu,
        13 Jul 2023 12:13:48 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 13 Jul 2023 09:13:48 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Thu,
        13 Jul 2023 09:13:48 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2] cxl: Update MAINTAINERS
Thread-Topic: [PATCH v2] cxl: Update MAINTAINERS
Thread-Index: AQHZtSxvlOMDT7hYQUSG3N4ai4ug16+4VP0A
Date:   Thu, 13 Jul 2023 16:13:48 +0000
Message-ID: <9af281f8-732e-4325-9b17-40ae71434274@nmtadam.samsung>
In-Reply-To: <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <580271A8119B2C4EB24BCB8EA5A8E3AA@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djX87p7lTakGJzuF7K4+/gCm0Xz5MWM
        FtOnXmC0OHGzkc1i9c01jBb7nz5nsVi18BqbxflZp1gsbk04xuTA6dFy5C2rx+I9L5k8Nq3q
        ZPOYOrve4/MmuQDWKC6blNSczLLUIn27BK6MIz+/sBZsEapYdfUgawPjbP4uRk4OCQETiemd
        9xm7GLk4hARWMkqcvTUbymllkvjbc40dpmrr2oksEIm1jBJNFx+yQjifGCW2bF/GDOEsY5T4
        3b0frIVNwEDi9/GNzCC2iIC2xMQ5B8GKmAXuMEkc/HwCaBYHh7CAvkTrogIQUwSo/udca4hy
        I4nZv64ygtgsAqoSsye1gI3hFXCS+PrqFBuIzSkQLjFnagtYDaOAmMT3U2uYQGxmAXGJW0/m
        M0FcLSixaPYeZghbTOLfrodsELaixP3vL9kh6nUkFuz+xAZyArOAncTndVBhbYllC19DrRWU
        ODnzCQtEq6TEwRU3wAEhIfCCQ2J252qohIvEiVPLoPZKS1y9PhVqb77ErrYrUHaFxNXX3VA3
        WEss/LOeaQKjyiwkZ89CctIshJNmITlpFpKTFjCyrmIULy0uzk1PLTbOSy3XK07MLS7NS9dL
        zs/dxAhMV6f/HS7YwXjr1ke9Q4xMHIyHGCU4mJVEeFW2rUsR4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzmtoezJZSCA9sSQ1OzW1ILUIJsvEwSnVwGRUecMyqWFTyNdzdfME2gL3Woh9nRcecjTo
        TBdf16mLBTfEGp8GZRRdnPdC3It15UuXb1v2Z52fwpwm8W+HW4ZRwctn07zSUp9dlXdZO8GV
        MVVIrTF4Kpvr882Rn55M2aM6s1dI/Zd906GFN1TcX3ElPAxt/9pzYMevh603N/T/11V/VLS5
        WG/mJLf9K74Fv7p7YXqj2Ovqls42N5snrJliNc5Pek+fnXPgVm3bisrJeflvjNL1M9as/NK5
        9MPJz84re6NdHVQnn3l9jGPDTbHTPcu4Ivxs3npz9BrMexr9pb+H8+DJG+Jl4Q5ydzbu006c
        slJ9u29n+BSvQ8tuptdVO779f/Vz15sVz7cdSolRYinOSDTUYi4qTgQA1UlplcYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWS2cA0UXeP0oYUg//bTS3uPr7AZtE8eTGj
        xfSpFxgtTtxsZLNYfXMNo8X+p89ZLFYtvMZmcX7WKRaLWxOOMTlwerQcecvqsXjPSyaPTas6
        2Tymzq73+LxJLoA1issmJTUnsyy1SN8ugSvjyM8vrAVbhCpWXT3I2sA4m7+LkZNDQsBEYuva
        iSxdjFwcQgKrGSWuN35ihHA+MUp0bp3KDOEsY5S4/+0DE0gLm4CBxO/jG5lBbBEBbYmJcw6C
        FTEL3GGSOPj5BNAsDg5hAX2J1kUFIKYIUP3PudYQ5UYSs39dZQSxWQRUJWZPagEbwyvgJPH1
        1Sk2iF2rGCUmbP7JDpLgFAiXmDO1BayBUUBM4vupNWA3MAuIS9x6Mp8J4gUBiSV7zjND2KIS
        Lx//Y4WwFSXuf3/JDlGvI7Fg9yc2kHuYBewkPq+DCmtLLFv4GuoGQYmTM5+wQLRKShxccYNl
        AqPELCTbZiGZNAth0iwkk2YhmbSAkXUVo3hpcXFuekWxYV5quV5xYm5xaV66XnJ+7iZGYKyf
        /nc4cgfj0Vsf9Q4xMnEwHmKU4GBWEuFV2bYuRYg3JbGyKrUoP76oNCe1+BCjNAeLkjivkOvE
        eCGB9MSS1OzU1ILUIpgsEwenVAPTMY8EzVtPCwtEWxkk2PZLpxxzu25z0O2ikOhsvQPvxPXT
        3kfcuF+cxmbpmq/+SjLxcN4+Eb3P0472pFw4tuLgxFqrRyvjS/fqJZ2+xOLWKah64FKqgi3/
        5uRJbGXbF58qvC3aLF5tlZbqVcy3X7lN4a/DAun415cvTbu0RVuk6sSfDcrLyzc61q94qub0
        fcGKOfuyBBKDY+vLHmfnqE+4Nu+4QfPpcxvWTmkyYpr/VvLIAedllsmmrD9vJme2Rvn7C/7M
        mfr6jr+04nxr6V3r+t8+/rXjWksF10U1qUyDjJ9XdRoddtQYno/kkmzk5Nv765R7THlTWuLX
        8tla3dVxss8/TWjbaX9y6bzzdjpKLMUZiYZazEXFiQBxfYCbZAMAAA==
X-CMS-MailID: 20230713161348uscas1p27a0043e082fcb3f6df2afc03290e3014
CMS-TYPE: 301P
X-CMS-RootMailID: 20230713015041uscas1p255a990bf69951632212980edaa1875e3
References: <CGME20230713015041uscas1p255a990bf69951632212980edaa1875e3@uscas1p2.samsung.com>
        <168921298745.190279.14706856880354094471.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jul 12, 2023 at 06:50:36PM -0700, Dan Williams wrote:
> Ben, thank you for all the work to get the CXL subsystem off the ground
> and establishing QEMU as a place where hardware vendors can collaborate
> on the new advancements and mechanisms appearing in the CXL
> specification.
>=20
> Jonathan, thank you for your continued review and collaboration, you have
> been a defacto CXL maintainer for a while now.
>=20
> Davidlohr, thank you for getting the background command infrastructure
> off the ground and your leadership on and off the lists.
>=20
> Dave Jiang, thank you for yor continued attention to all the
> cross-subsytem plumbing issues that CXL continues to create.
>=20

Thanks Dave, we notice and appreciate all of your contributions
as well.=20

While we are at it, thanks to you Dan, we can't forget
how much you have contributed here as well as the community
you've helped to create.


> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Adam Manzanares <a.manzanares@samsung.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes in v2:
> - Show Dave Jiang his due as well.
>=20
>  MAINTAINERS |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..82de99b6b340 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5140,10 +5140,12 @@ S:	Maintained
>  F:	include/linux/compiler_attributes.h
> =20
>  COMPUTE EXPRESS LINK (CXL)
> +M:	Davidlohr Bueso <dave@stgolabs.net>
> +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Dave Jiang <dave.jiang@intel.com>
>  M:	Alison Schofield <alison.schofield@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
> -M:	Ben Widawsky <bwidawsk@kernel.org>
>  M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
> =
