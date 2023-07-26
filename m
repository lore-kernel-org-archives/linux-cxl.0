Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFBCC001DC
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 18:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGZSK6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 14:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGZSK6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 14:10:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4854A2115
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jul 2023 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1690395040; x=1690999840; i=fan.ni@gmx.us;
 bh=pc1vgDCl/4jroaNUgGtX5e8C3nm5lCynxFC83x6DGDU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=UK3/R9q+0a0Bd02HD7EIKvrKTpbAcSS6S+MK5CUKrmre5sSlVHv62L1NRuLeeRK8K6iDtlX
 r9L/a0h52ZZseNh8zZ7g92NJLyoZ6j2MvoUAPO6q+YFuEZh6LEOnIFpG3+x16bsCoqujUZ8A+
 HqHH9okC0obgrHe2jqPGa51RKA+t5JCjBwy7jp2YvvOZVfDgNm5AEBgxAFYO7AR+x3jpUtzmZ
 nIK/M0rVXDAmYHm7z1tyeMFkrY95wqEWbuFNq0RMt1ed3Iom2DgR9vDKFPEya8bwLuDAuxIoP
 HcKz2rnACo7BzjKNXgBq56bTFgmBpm9j67ELCxBFd36MrjLMvjrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([172.58.46.179]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N2V4P-1pkLlQ1wfX-013wmb; Wed, 26 Jul 2023 20:10:40 +0200
From:   fan.ni@gmx.us
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, sunfishho12@gmail.com,
        Fan Ni <fan.ni@gmx.us>
Subject: [ndctl PATCH v2 RESEND 0/2] cxl-graph: add a new command to construct CXL topology graph images
Date:   Wed, 26 Jul 2023 11:09:53 -0700
Message-Id: <20230726180955.88834-1-fan.ni@gmx.us>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t8zgpVsAzxBSXqSH8hftUIMgJ2wD5YDBBUoaGbgJGUXERMs/wRb
 sAzQ0A5T9Q3yBiE9rCBIaaI8tRjMQvrw80io1Ai1rJSJbQovV9QYVADrU5cKBgqc6lUYIt6
 2cQWhSoa91AbysMnJ2k1y8KkCvsyp1Tfl7FnE+cNTWGGrguhCaLEj6Gh0tFyqX6traLBTnf
 FXJP+GKdxu6FlkTGgrXtg==
UI-OutboundReport: notjunk:1;M01:P0:Au3xpXHH7io=;WcdtWeoOKMtGu2zjxj3c0wxUW1+
 pNOeKOsuOro4RB9LwzYxp96FQVuY0YSNA9Tp2J6u4oQbRP7QTnmePJOUMvs6PFsGIm9xm4PtS
 qHKr3qUOhQVXh/u4l2+8l1iEQC7WnzOvdqKRpfrHxai4FrEiZoMVzS4GaEvXQs7pwKj7gftId
 uR4DwPLz7NF+qrvDc5bZksxRI+AFll8cnrvISF7DVpx7Uz/RExyo3Tiq9LjMjAAFHBaqfGquR
 jYrLwEzUPyDBWDaJbQR3DaGP6eegK2HPnam1xuc5Oydhy/jpqbHmkqcSqbb6NnqdCnNyoexL3
 kaEIoe1Z+P59MZp0zYEXFt/tMd8gAHdtHa1dd+Zg9RDjIH8S2yFqnza0vv6n0ltbUG+xVX6QC
 JiOoBzubG2KZv+gE2/NZwb51ktAG8r3PTYo6XkJ+5E4TtSljX2Q0/y6fQm2xeRtUsLxdz91uE
 ZafRxPqvOVFk8VWMXmKNSP88wtrx9jOi1D1pX0Pi2g00C0q4vfvEsqdrkWE5Bbnd4Hr62eccj
 HtNODDRAHFArYpgqt1DhpEzoRVm1jbYbhgIHdBEqvLGjkzlIRiqwop7WYVYTy6BPf8vMffEMI
 5ZpjvCnNdg8ESpbgYcW0nLiB4vra21IN3oXUbX1SHtlL0WJQUIboCmo7707bg55SGEVOUmAYY
 rJdYJJM99T+iMmdk4hiU9hoLlN9kTXC8jRQIYmxKUZq01XZpKocESla3kPuQIrdCfWkfdO2/o
 oWlWozv/cfRF8RrSfuWn48RvX6ciFo83XsrLTpPjNkjtwGxcjD2nXI55KjU7ujpF5ut2dmluR
 z0nHTo6W4Wr6datxEaMgEQUAXV1Q23ofsfEibapTHpO2w452QsUdVWZey2biWJkItEzf+MsoR
 /JssnqQjUn4Tb5/JbPpeIFesaVHyc533CgH7kcErpapfcevKijNy1zCVPwOTTqG2p5AP5y2U8
 IuKQozMvYv62hgC23bIPj76Sc3Q=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <fan.ni@gmx.us>

FYI. The thread of the previous sending (list below) seems broken, making =
it
hard to track and review, so resend the series.
https://lore.kernel.org/linux-cxl/SG2PR06MB3397455E672F8820385E3D95B25BA@S=
G2PR06MB3397.apcprd06.prod.outlook.com/


v1[1]->v2:
1. Simplified Patch 1 which adds parent_dport attribute to root port and
memdev for plotting cxl topology by leveraging the existing function
`cxl_port_get_parent_dport` in ndctl v77.
2. Introduced a new cxl command 'cxl graph' for cxl topology plotting inst=
ead
of implementing the functionality as an option in 'cxl list'.
3. Moved all graph plotting code to a separated file: graph.c.
4. Reverted the changes made to `cxl list` functionality, now its behavior
remains the same as before.
5. Added a new option "-t" for cxl graph command, it takes either 'plain' =
or
'graph' to determine whether we dump cxl topology to a json formatted file
or plot the topology to a graph. By default, it will plot the graph.
6. Added a function to validate the input cxl topology for "--input" optio=
n.
7. Added new code logic to handle cases where there are inactive memdevs.
8 Modified the plotting logic to make plotting work properly with differen=
t
user inputs (from options supported by cxl graph). For example, now we can=
 plot
topology graph only for a specific endpoint or memdev.
9. Fix some comments and bugs in graph.c

Below is the cover letter of v1[1]:
This patch series extends the `cxl list` subcommand to show the cxl
topology visually. Mattew Ho first worked on the code and provided an
initial patch as list below[1].

This patch series includes the following two patches,
1) Patch 1 adds a parent_dport attribute to ports and type 3 memory device=
s
to show which downstream port a component is attached. This attribute will=
 be
used in patch 2 to generate the cxl topology graph.
2) Patch 2 extends the `cxl list` subcommand to dump the cxl topology to a
json format file or generate a graph showing the cxl topology. To use the
extended function, the option `-o output.suffix` is added. Acceptable outp=
ut
suffixes include .jpeg, .jpg and .png for generating a graph and for other
suffix, it will dump the json-formatted cxl topology to the file, which
can be used the input file (with --input option) to generate the graph
later.

Patch 2 reuses the plotting functions in Matthew Ho's patch, which are upd=
ated
to work with parent_dport attribute in patch 1. Also, some bugs are
fixed. More detailed changes are listed in Patch 2's commit log.

The patch series is applied cleanly on ndctl v77, and tested with the
following different cxl topologies,
1) a single memdev attached the only root port of the single HB in the sys=
tem;
2) two memdevs attached to the two root ports of the single HB in the syst=
em;
3) four memdevs attached to two HBs, each of which has two root ports;
4) four memdevs attached to the downstream ports of a cxl switch which is
attached to one of the two root ports of a HB in the system.


[1] [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
https://lore.kernel.org/linux-cxl/20221220182510.2734032-1-fan.ni@samsung.=
com/
[2] Mattew Ho's patch:
https://lore.kernel.org/linux-cxl/cover.1660895649.git.sunfishho12@gmail.c=
om/

Fan Ni (2):
  cxl/list: Add parent_dport attribute to memdev and root port listing
  cxl-graph: Add cxl graph command to construct CXL topology graph
    images

 Documentation/cxl/cxl-graph.txt | 106 +++++
 config.h.meson                  |   3 +
 cxl/builtin.h                   |   1 +
 cxl/cxl.c                       |   1 +
 cxl/filter.c                    |  15 +-
 cxl/filter.h                    |   5 +
 cxl/graph.c                     | 806 ++++++++++++++++++++++++++++++++
 cxl/json.c                      |  23 +-
 cxl/meson.build                 |   9 +
 meson.build                     |   5 +
 meson_options.txt               |   1 +
 ndctl.spec.in                   |   1 +
 12 files changed, 969 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/cxl/cxl-graph.txt
 create mode 100644 cxl/graph.c

=2D-
2.39.2

