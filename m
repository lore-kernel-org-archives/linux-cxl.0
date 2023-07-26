Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D7DC0015E
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 20:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGZUnh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 16:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGZUng (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 16:43:36 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B185D100
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jul 2023 13:43:33 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230726204329usoutp01b75727ca2cafc98b462b8c4f4dc9cb71~1hawvgbt21550015500usoutp01h;
        Wed, 26 Jul 2023 20:43:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230726204329usoutp01b75727ca2cafc98b462b8c4f4dc9cb71~1hawvgbt21550015500usoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690404209;
        bh=l+H6dCv5ybsIfLB+hEQtf+MLB17PtOJq5usrp2cmDHA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=e1y5U9kD+VS03CQARav3iLq4BeLgWWz9eqkXN2KtpEOZbptrxx2HdFe9BC4WPTKVf
         ObV5jq+ibrPX0kdDLGKTkE+XhPW3nTd1ziBDhZjb9AIIe16kD4uka55qd+abwp69hu
         6jWg7RBvF1rM9uA6GAT4cRmcpSZVPRT/P6VlycZs=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230726204329uscas1p27269d871ed5f705cccad682d32cdb5e8~1hawrCtzs0282902829uscas1p29;
        Wed, 26 Jul 2023 20:43:29 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id E3.47.51475.17581C46; Wed,
        26 Jul 2023 16:43:29 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726204329uscas1p1ac598f7d24000ef115a2430131e3e879~1hawW3uCj1213512135uscas1p1Z;
        Wed, 26 Jul 2023 20:43:29 +0000 (GMT)
X-AuditID: cbfec36d-635ff7000001c913-59-64c18571f792
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 81.3A.44215.07581C46; Wed,
        26 Jul 2023 16:43:29 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 26 Jul 2023 13:43:28 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        26 Jul 2023 13:43:28 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "fan.ni@gmx.us" <fan.ni@gmx.us>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>
Subject: Re: [ndctl PATCH v2 RESEND 0/2] cxl-graph: add a new command to
 construct CXL topology graph images
Thread-Topic: [ndctl PATCH v2 RESEND 0/2] cxl-graph: add a new command to
        construct CXL topology graph images
Thread-Index: AQHZwAHUJK0XStnXB0eNcaGi/9i+2Q==
Date:   Wed, 26 Jul 2023 20:43:28 +0000
Message-ID: <20230726204319.GA253308@bgt-140510-bm03>
In-Reply-To: <20230726180955.88834-1-fan.ni@gmx.us>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BED10DB5E8EA4148888B2F6E2610FD8D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djXc7qFrQdTDO4dULKYPvUCo8Xqm2sY
        LW6dOsxocX7WKRaLxp+LgNwJx5gc2Dx2zrrL7vFs9zpmj8V7XjJ5TJ1d7/F5k1wAaxSXTUpq
        TmZZapG+XQJXRtvRSYwFnSoVHev2MjUwHpLuYuTgkBAwkdgyN7+LkYtDSGAlo8Tmo7sYIZxW
        JomWOTeYuhg5wYp2vDjGApFYyyjR9qMdyvnEKPFg2gR2CGcZo0TzhedgLWwCihL7urazgdgi
        AsoSW67/AJvLLLCdSWLX03Z2kOXCAnkSH5ZmQNTkS9zatpQRwtaTODPvJgtICYuAqsTT2cEg
        Jq+AqUT/NDWQCk4BY4kLW+eATWcUEJP4fmoN2FZmAXGJW0/mQx0tKLFo9h5mCFtM4t+uh2wQ
        tqLE/e8v2SHqdSQW7P7EBmHbScxZ+g1qjrbEsoWvwXp5geacnPmEBaJXUuLgihtgv0sIXOCQ
        +DH/CiNEwkXiWh9MkbTE37vLmCDBmyyx6iMXRDhHYv6SLVAl1hIL/6xnmsCoMgvJ2bOQnDQL
        yUmzkJw0C8lJCxhZVzGKlxYX56anFhvmpZbrFSfmFpfmpesl5+duYgSmo9P/DufuYNxx66Pe
        IUYmDsZDjBIczEoivIYx+1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xrankwWEkhPLEnNTk0t
        SC2CyTJxcEo1MDFM7HGZcqjg5wfpjPoHM2a2SvdevfTk/b1KzfzP0luuFXUcvrTNn9uY59QG
        R/0vBctunNLeyy9sVXNg/UamAJU19W7zlzusyFphw3gi6NL8mFncTVJTPkbYW/TPvj73sbPV
        wqrZm7W/P9I8Il8Ww6F3wHr1q7M1Bj2mvBeuty2b/71Q/PDH2S7JRvIzin4x/Pq3tEz6XPY3
        /nfer2XcIz5O+9T68LvztZwwt5uteXxn+qsmM62aM/2GhtAzrecRK3KsJc4c/P2+IkjszIsP
        TYWizH5+rB68dnw9YkYW/xYZTN2sXZY73fXh9aCQ46GHluq0rJCZ4PbhoOS/ZL8tBy0aGTp0
        50W4H1k95wiT4QclluKMREMt5qLiRAC9eqDLtgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWS2cA0Sbew9WCKwdvV3BbTp15gtFh9cw2j
        xa1Thxktzs86xWLR+HMRkDvhGJMDm8fOWXfZPZ7tXsfssXjPSyaPqbPrPT5vkgtgjeKySUnN
        ySxLLdK3S+DKaDs6ibGgU6WiY91epgbGQ9JdjJwcEgImEjteHGPpYuTiEBJYzSgxdf4TRgjn
        E6PE2kuzoZxljBJvW3+wgbSwCShK7OvaDmaLCChLbLn+A6yIWWA7k8Sup+3sXYwcHMICeRIf
        lmZA1ORL3N13CapeT+LMvJssICUsAqoST2cHg5i8AqYS/dPUQCqEBIwkzs19yQxicwoYS1zY
        Ogesk1FATOL7qTVMIDazgLjErSfzmSAeEJBYsuc8M4QtKvHy8T9WCFtR4v73l+wQ9ToSC3Z/
        YoOw7STmLP0GNUdbYtnC12C9vAKCEidnPmGB6JWUOLjiBssERolZSNbNQjJqFpJRs5CMmoVk
        1AJG1lWM4qXFxbnpFcVGeanlesWJucWleel6yfm5mxiB0Xz63+HoHYy3b33UO8TIxMF4iFGC
        g1lJhNcwZl+KEG9KYmVValF+fFFpTmrxIUZpDhYlcd6XURPjhQTSE0tSs1NTC1KLYLJMHJxS
        DUzLBRZuVlG35/jEmfR0eq4Vj6v0Y3MWFjbtGm/mioueAsti/or+nC31avWeNz8Ov3/U/nFL
        vs7Geyuao8qm/Utf13TqHdf9b3+nvk2/v+jNA+Vi84VvrPa83ffYZuEks8kv/362Xih4JoaF
        e9n9SX+4HA99XmrsNmvVLD525njp0JnTd3lmBN2svW7+41VpUFa96kF7of/ZrkGGkz4m6C0U
        ZvqeMUePIfvtyesn5ELWim0S7L67epJlLY+zxW032ZUf9i1c+XmV2+ui9Ppp95ofvqzv0dnx
        lW15aISpyEOrVzYTgwpm3db77PU/+/HOS0/qMi9Y58yqfBfUJMNaf9p9nvLxBXf3TDgvtdqq
        Qb9QX4mlOCPRUIu5qDgRAK7pjG9VAwAA
X-CMS-MailID: 20230726204329uscas1p1ac598f7d24000ef115a2430131e3e879
CMS-TYPE: 301P
X-CMS-RootMailID: 20230726204329uscas1p1ac598f7d24000ef115a2430131e3e879
References: <20230726180955.88834-1-fan.ni@gmx.us>
        <CGME20230726204329uscas1p1ac598f7d24000ef115a2430131e3e879@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jul 26, 2023 at 11:09:53AM -0700, fan.ni@gmx.us wrote:

FYI. If you want to use the code directly, try the below code repo:
https://github.com/moking/ndctl/tree/patch-gen

> From: Fan Ni <fan.ni@gmx.us>
>=20
> FYI. The thread of the previous sending (list below) seems broken, making=
 it
> hard to track and review, so resend the series.
> https://lore.kernel.org/linux-cxl/SG2PR06MB3397455E672F8820385E3D95B25BA@=
SG2PR06MB3397.apcprd06.prod.outlook.com/
>=20
>=20
> v1[1]->v2:
> 1. Simplified Patch 1 which adds parent_dport attribute to root port and
> memdev for plotting cxl topology by leveraging the existing function
> `cxl_port_get_parent_dport` in ndctl v77.
> 2. Introduced a new cxl command 'cxl graph' for cxl topology plotting ins=
tead
> of implementing the functionality as an option in 'cxl list'.
> 3. Moved all graph plotting code to a separated file: graph.c.
> 4. Reverted the changes made to `cxl list` functionality, now its behavio=
r
> remains the same as before.
> 5. Added a new option "-t" for cxl graph command, it takes either 'plain'=
 or
> 'graph' to determine whether we dump cxl topology to a json formatted fil=
e
> or plot the topology to a graph. By default, it will plot the graph.
> 6. Added a function to validate the input cxl topology for "--input" opti=
on.
> 7. Added new code logic to handle cases where there are inactive memdevs.
> 8 Modified the plotting logic to make plotting work properly with differe=
nt
> user inputs (from options supported by cxl graph). For example, now we ca=
n plot
> topology graph only for a specific endpoint or memdev.
> 9. Fix some comments and bugs in graph.c
>=20
> Below is the cover letter of v1[1]:
> This patch series extends the `cxl list` subcommand to show the cxl
> topology visually. Mattew Ho first worked on the code and provided an
> initial patch as list below[1].
>=20
> This patch series includes the following two patches,
> 1) Patch 1 adds a parent_dport attribute to ports and type 3 memory devic=
es
> to show which downstream port a component is attached. This attribute wil=
l be
> used in patch 2 to generate the cxl topology graph.
> 2) Patch 2 extends the `cxl list` subcommand to dump the cxl topology to =
a
> json format file or generate a graph showing the cxl topology. To use the
> extended function, the option `-o output.suffix` is added. Acceptable out=
put
> suffixes include .jpeg, .jpg and .png for generating a graph and for othe=
r
> suffix, it will dump the json-formatted cxl topology to the file, which
> can be used the input file (with --input option) to generate the graph
> later.
>=20
> Patch 2 reuses the plotting functions in Matthew Ho's patch, which are up=
dated
> to work with parent_dport attribute in patch 1. Also, some bugs are
> fixed. More detailed changes are listed in Patch 2's commit log.
>=20
> The patch series is applied cleanly on ndctl v77, and tested with the
> following different cxl topologies,
> 1) a single memdev attached the only root port of the single HB in the sy=
stem;
> 2) two memdevs attached to the two root ports of the single HB in the sys=
tem;
> 3) four memdevs attached to two HBs, each of which has two root ports;
> 4) four memdevs attached to the downstream ports of a cxl switch which is
> attached to one of the two root ports of a HB in the system.
>=20
>=20
> [1] [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
> https://lore.kernel.org/linux-cxl/20221220182510.2734032-1-fan.ni@samsung=
.com/
> [2] Mattew Ho's patch:
> https://lore.kernel.org/linux-cxl/cover.1660895649.git.sunfishho12@gmail.=
com/
>=20
> Fan Ni (2):
>   cxl/list: Add parent_dport attribute to memdev and root port listing
>   cxl-graph: Add cxl graph command to construct CXL topology graph
>     images
>=20
>  Documentation/cxl/cxl-graph.txt | 106 +++++
>  config.h.meson                  |   3 +
>  cxl/builtin.h                   |   1 +
>  cxl/cxl.c                       |   1 +
>  cxl/filter.c                    |  15 +-
>  cxl/filter.h                    |   5 +
>  cxl/graph.c                     | 806 ++++++++++++++++++++++++++++++++
>  cxl/json.c                      |  23 +-
>  cxl/meson.build                 |   9 +
>  meson.build                     |   5 +
>  meson_options.txt               |   1 +
>  ndctl.spec.in                   |   1 +
>  12 files changed, 969 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/cxl/cxl-graph.txt
>  create mode 100644 cxl/graph.c
>=20
> --
> 2.39.2
>=20
> =
