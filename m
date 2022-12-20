Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3ABC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Dec 2022 18:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiLTS00 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Dec 2022 13:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiLTS0Z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Dec 2022 13:26:25 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B241AD8C
        for <linux-cxl@vger.kernel.org>; Tue, 20 Dec 2022 10:26:24 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221220182622usoutp0262011bb4912d92bf8559d7516ee21f2c~yk6zhImVX0260402604usoutp021;
        Tue, 20 Dec 2022 18:26:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221220182622usoutp0262011bb4912d92bf8559d7516ee21f2c~yk6zhImVX0260402604usoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671560782;
        bh=0aDtI/Pp8Ivrak8AuG57lsuEeMtGAByeBk7uWzuzrBc=;
        h=From:To:CC:Subject:Date:References:From;
        b=gWtrLm2HVoMpFlLMPa90TAudgeO7yEnkLV0u2IH+f8g3slE97gENYaPvFlByQMwEu
         q9YtSL9/PpgjqMwAk+drV2jSBYqf8QlyAQT4mf+/j6iHZDUVHiQckMmSMj+vCJE9ug
         M9yVJ/1v575nBlvHk90XcVVveKRsbWe+RV+AvFLo=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221220182622uscas1p28faacbdcec30abbd0993917ff187e87f~yk6zTCTP02372023720uscas1p2w;
        Tue, 20 Dec 2022 18:26:22 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 96.B0.26002.E4EF1A36; Tue,
        20 Dec 2022 13:26:22 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c~yk6zCyWve2372023720uscas1p2v;
        Tue, 20 Dec 2022 18:26:21 +0000 (GMT)
X-AuditID: cbfec36d-c41ff70000026592-68-63a1fe4e67ef
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id A0.68.07297.D4EF1A36; Tue,
        20 Dec 2022 13:26:21 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 20 Dec 2022 10:26:20 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        20 Dec 2022 10:26:20 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
Thread-Topic: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph
        images
Thread-Index: AQHZFKCOrtu2YggNCUSipmQFAN4BWA==
Date:   Tue, 20 Dec 2022 18:26:20 +0000
Message-ID: <20221220182510.2734032-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTcRjH+b3v6/YqTn/O4R67qEXRQesgajGTIKtFd1lCdK35uqwduldr
        HdTsItRMoSW+y3ROzVqX0aFdeGTYymaQeIRXiCVamdGhleX2LvC/z8Pz4Xm+Dzw0Kc7wG0PH
        G5IYk0GtkwkCqHvPvrlnrR22a+bk1gkU2dZ6pHA2X0MKN+eiFCmDBUjRkvmMWOKnKudahSrH
        ox5CZbUdU329PWE9tTUgIpbRxe9nTLMjdwXsGbRpE9Il5qbuu5QFVQSlIn8a8Hzov/xZkIoC
        aDG+giCn4z3JF6cI6Ois8ftv1Q11+/GN6wj6ixy+YgBBeeNxymOJcTGCNLvOwwI8CZ6k3hd4
        WIKVkGkp9O4gcQ4BDd+zCU8jFKugurtcmIroEWkdnP2SzPty6Bo651UoPAUufHN4WYQXQbPD
        6mWEw+CH65qXSSyFlq48gk8aAgW2RyTPYTD8oFPA8yRo/9Ej5H05NFnPC3ieCcX2XpKfHwLP
        c7oo3g+HypImypMZcBYN5wr6fEOjoM/xySeNhT+txb7FRkgvq0U8m6HHViLkWQn23zd9QYPg
        z9A75LkXsAjOnBZnIhk36gRuVDxuVDxuVLx8RF1F0mSW1WsZdq6BOSBn1Xo22aCVa4z622jk
        ZV4MV+vLUFnLF3kVImhUhYAmZRJR/VO7RiyKVR88xJiMO03JOoatQmNpSiYVpd3N04ixVp3E
        7GOYBMb0v0vQ/mMshGCeZTBt5C8THW5ucAWOCV/eu7j6Sqwjwu0/zZoWGBV9zyUdyI2fv+Hv
        0k2VQR3M59xb2quh+t29ZmNw/uoXpzYv0xz5ML7dXKg0XKhAJT2T+zTt5RIXeXxpWN1A6crX
        rcHMycdnLkWSb53R6vFx49batjgTPwZmDJQ6W3prU6Y7Pxw7PJGh3FFJ3b+EsyRrmj/aX67a
        0Rj3sz5L6jLq4sq0lDiPc6VQpTG4sa05Y6o48sjWzJ8nsPJgTWKbfmZlwsJtURX1WUWheyP2
        B09507Dk1YxadpPwtzIjTBlz8bvUwuSs3mi/U5ht5oTvbpyeup08+rAm/ebJwgVrgvupThnF
        7lHPnUGaWPU/jUEIyqEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LJbGCapOv7b2Gywe+FRhbTp15gtFh9cw2j
        xflZp1gsGn8uYrS4NeEYkwOrx85Zd9k9Fu95yeQxdXa9x+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        P2enF/SIVNx4tpWlgfEAXxcjJ4eEgInE2V/PWLsYuTiEBFYzSpx5/IkNwvnEKHF2/wpmCGcZ
        o8Tlg/3MIC1sAooS+7q2s4HYIgLWEhMaloB1MAvMZJK4+m06E0hCWMBD4vCznewQRb4Sbace
        M0LYehJPfvWD1bAIqEpM+7oYzOYVsJS4uXgqmM0oICbx/dQaMJtZQFzi1pP5TBC3Ckgs2XOe
        GcIWlXj5+B8rhK0ocf/7S3aIej2JG1OnsEHY2hLLFr5mhpgvKHFy5hMWiHpJiYMrbrBMYBSd
        hWTFLCTts5C0z0LSvoCRZRWjeGlxcW56RbFRXmq5XnFibnFpXrpecn7uJkZgdJ3+dzh6B+Pt
        Wx/1DjEycTAeYpTgYFYS4b1wZGGyEG9KYmVValF+fFFpTmrxIUZpDhYlcd6XURPjhQTSE0tS
        s1NTC1KLYLJMHJxSDUza/+Qa07tv/Xlw6RrbTL7P162WlN9b/Yqf56WCcpTVxvlHp8V93fTB
        /bvvS9bg49Mad/2qZiuc7K5//99j56yshunnLshXxG7/puGX9TzDKvXr6nxVv0+BzjLMOQU6
        VTs87dQkG3Ls6nxkY3rkXTtEbJRSnvN35Tuuve/YK78m/tYls55SWZ5pTOyfriVwe/ZM5Eq5
        Z76/rXKbX+u6iX8O5tUs/831WuJVfKrQihlXmOxtDL8r/1n0JGNWr0tmdYFY2JoT9h9uTJUO
        Cts9T99rl2u2mqGKXpu1b/hpyR8Tdqd3Gf7XebTr+f49j3uNFT9qMMZ+jOVcOHv+BS+3y68q
        nLkz3k6aOHPhQlfn7UosxRmJhlrMRcWJAMr2dvIdAwAA
X-CMS-MailID: 20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c
CMS-TYPE: 301P
X-CMS-RootMailID: 20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c
References: <CGME20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch series extends the `cxl list` subcommand to show the cxl
topology visually. Mattew Ho first worked on the code and provided an
initial patch as list below[1].

This patch series includes the following two patches,
1) Patch 1 adds a parent_dport attribute to ports and type 3 memory devices=
 to
show which downstream port a component is attached. This attribute will be =
used
in patch 2 to generate the cxl topology graph.
2) Patch 2 extends the `cxl list` subcommand to dump the cxl topology to a
json format file or generate a graph showing the cxl topology. To use the
extended function, the option `-o output.suffix` is added. Acceptable outpu=
t
suffixes include .jpeg, .jpg and .png for generating a graph and for other
suffix, it will dump the json-formatted cxl topology to the file, which
can be used the input file (with --input option) to generate the graph
later.

Patch 2 reuses the plotting functions in Matthew Ho's patch, which are upda=
ted
to work with parent_dport attribute in patch 1. Also, some bugs are
fixed. More detailed changes are listed in Patch 2's commit log.

The patch series is tested with the following different cxl topologies,
1) a single memdev attached the only root port of the single HB in the syst=
em;
2) two memdevs attached to the two root ports of the single HB in the syste=
m;
3) four memdevs attached to two HBs, each of which has two root ports;
4) four memdevs attached to the downstream ports of a cxl switch which is
attached to one of the two root ports of a HB in the system.


[1] Mattew Ho's patch:
https://lore.kernel.org/linux-cxl/cover.1660895649.git.sunfishho12@gmail.co=
m/





Fan Ni (2):
  cxl-list: add `parent_dport` to cxl_port/memdev objects
  cxl-list: Construct CXL topology graph images

 Documentation/cxl/cxl-list.txt |  16 ++
 cxl/filter.c                   |  45 +++-
 cxl/filter.h                   |   5 +
 cxl/graph.c                    | 409 +++++++++++++++++++++++++++++++++
 cxl/graph.h                    |  20 ++
 cxl/json.c                     |  11 +
 cxl/lib/libcxl.c               |  43 ++++
 cxl/lib/libcxl.sym             |   6 +
 cxl/lib/private.h              |   1 +
 cxl/libcxl.h                   |   3 +
 cxl/list.c                     |  31 +++
 cxl/meson.build                |   2 +
 meson.build                    |   1 +
 util/json.c                    |   2 +-
 14 files changed, 590 insertions(+), 5 deletions(-)
 create mode 100644 cxl/graph.c
 create mode 100644 cxl/graph.h

--=20
2.25.1
