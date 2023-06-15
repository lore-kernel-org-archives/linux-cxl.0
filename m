Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC18EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 16:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjFOQlp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFOQlT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 12:41:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2016.outbound.protection.outlook.com [40.92.53.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A180E69
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 09:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROw/IJt8+/w7K8U1ffijD7i6lqQAdoAC7jP88k7oyGWGZbqBcO8nA0xRkd3kbOp89/wi46z6p0dpKqIQpkv+1MP7YnMeaBfli+vvuzxEMHW5LHJC7PYOIukTkoUiFt237Uem/dEVtaFqkGW4qd+EM6O820H+h21rlHpWJUgmnTqtTdWUNC7FmGbJMiSY/kiQmM7xs1sdAPcZkN39j2/a6YyPPiOxcn9Oa7OrTa2cPYiGHFFSN78DdakOirarWth5pnHDzvsiy0ubnFX0F4ovB9iBpLibZsMMkSqn+8395/feblAFEBhP8j0BgDT0qpe82YfyQTNHuKPyyEYc0rv3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMnvX3m59ZOKp/pMHPGf9fzFAcpqn14LUXL1EF/1DWU=;
 b=W8bq/Qsc5kfRtR0SeBxTPSAzGeD7rX3Er3co+RkZL8d1m+oczqNtm8Et/c6NzuYpop8dfycdts84l2Ru5Y9dmGwmyJdeBmaTGiiBpFzD1TnJTtXgWo2oSRc1Byz+oMrgrqEIeusSMG8Ff2u2G6rQmv9TIgo1XXIEiW6KEJyl2TZgiWDbrDhpj7C3RodCH7IRJokYauoIiUOdMkKbphTP3v6BfmTfdwisE7ytkzYOFXrzH0snSiq2xuKhNn16+DxVBkYEX7DNF6JzRzoqK4jIi6oO8OrHy86LvWdAbu1L2Bd/naNIzwQrIpxN5/ZiSiAcGVAmUiOce21fGy/neVKxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMnvX3m59ZOKp/pMHPGf9fzFAcpqn14LUXL1EF/1DWU=;
 b=d4HqjIpIvnZohhhsmlj8+mA03zjcF5vZignfbYmnljwPPpAjTbMXjU/0aXOTnTlsSxS28jIF96MM3B+wsdxkRhs4wzFWzIDxwIQPE2KuROaSQeXWgAd+H/JbMfJr6Yl8rDkxayFKjutK36DEOHsy4+EDNRGfUqS6XUgeLP9RfcXU+Be+tK+tvr/DncSfbzWNAHhgATXpAWDig855EaOJokzS6TRC1Xk06tumgXlyGVSIlnjPwyhK3jPFuOPb7Oqn1ZXJCEevACp3+1oOYSRI09+bqj7JAwjhxx2xfxfaYIK1NLXsJUxp/AIhIjyVmNF/+D/Ix3wdv79o6XDyZRb93A==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYZPR06MB4479.apcprd06.prod.outlook.com (2603:1096:400:8e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Thu, 15 Jun 2023 16:41:13 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 16:41:13 +0000
From:   nifan@outlook.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, sunfishho12@gmail.com,
        nmtadam.samsung@gmail.com, nifan@outlook.com, fan.ni@samsung.com
Subject: [ndctl PATCH v2 0/2] cxl-graph: add a new command to construct CXL topology graph images
Date:   Thu, 15 Jun 2023 09:40:48 -0700
Message-ID: <SG2PR06MB3397455E672F8820385E3D95B25BA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [gyxz1XszKE0Ukb0H0aA5xBlW4h3MttyN]
X-ClientProxiedBy: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230615164050.3248000-1-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYZPR06MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: a57e3cce-f8ff-402a-8ece-08db6dbf54b1
X-MS-Exchange-SLBlob-MailProps: mWtqiNqNgRuoOpO/k49dL8CDjq0refW4xFDe2vbpbaQuPPjTuf3KPOAXBHw7IGMcx+ZZXiBXIq/C7ekoKb+4UshNlM5rsnOtaU3oOqDvUCykybiwaWvDBg9Ln1u0BjnIAw7pS0DycdiTbCUcnMD4HLK7lD7/x90PhDN2yutzCEP1hgih14UoRjlUBHK9f6h71AWKK8+5FwpWMEOnMuJhmoYEM0yC/cso9tb1cUYeULP/7+bk6Q77YTTlt/ZFcmS83A4cgNONEyCVWN1XJykna+PWH4mEwowSsjRgjNpcR2v8+u94PIhYEa/+2jPQkG2LypnSOjVBP0LAvr9sH5L3ySm5es3OcPxT1SEoFeYAlPFAOLwvZlArvsLnf/ni6kMgTQX9zbvjFjh2fC3P12Pcq/5Xjj18mxFcGhbq1MwC1wI/r8AaEfY7PASfjeNZBa09/4+jxi5xtCFw0FwGlPkbHa72BgUhisFpJBur1MfD0iW5FcVBMrvVsox0aZ3sMtKjxdzsyQ9hYpJAc3+TYD8F7G9PdhsM8HM7XovlM4NkWL7OoaQ82WOCFwjhjlN/3RbKNR7Dehrb8wLdalh69D05Ruo4s/oPRV4Rzcmfisg+Fye3LPbMekfWrvmorvHgKWoFB/JV9lVsWESBesuZy8LaKEPH58Lvd+8Q1v1NgehfNHr4/Ei2GAbOrEPHb2dDL7Dwmjtm7KpYnqApj0e/dJ+Bb1PU9jtv+VllKd39ZZP2wDXA5pYMAV49m6jXPmXfhx/QUrVsaYQ/wAdfyrWGd/HIK3MhUmBpnnWXrlItnF1ODvg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGUIaBiyfMf1oMiMZME3gKNWNHwmEU8PhxmKkc8JUmpZUdlngrbrpSd0L5oLr41Lw+swZQnVsLZB/T6+IfiFTcmcJTFJXxIY5dVj0ac41++coJMllr1uyMdZJ6d2xSSRGbb1u6hBLnaDFNYBsC3ZpFhqI3xlAKT23Kf2yN9DQx8RIcwAxh2bnavKQW2N4YcBTOcUT5My2KGdpVbEIMIcae24i1qEY6118m3zje0fCPKTw/wrmkI0phrzcWoltcjE3OkB6IASfzCas8JVzR2NJmDTHIWfUzuGCxztN7+FhMpJ4GIHgqYN4ELjm+5MEenMZuDnazAnGeAvl95KbC+iSCmTGsP8cFOk4FM4UDg0FmnovnU5eriybCZl5L23zuwms2FeoXZimTg1Yt+bkPig4OdT32Oz+cR/6s7mmo2EtcBjkzTsKhpPU44d8xY7oN2FraBA3DO9Sou7ZZr6KMulUaQpFDEtFjUeC6r+01kiGgUyIYWG4Z5lpncjE+/pfWfmejt74gE1RV8GRpx2BQRxEHAVwYvUKQ7CtW/qOn84++C1PJpGnRtLdNnYCyAIiRcBwYvKwC9Iv/Ek9EZkEfZQDzDSnoQyGPJH7KaFMgEdiyAWccpQCNcMJ45UJRI095SOM7b8JZTBqjKWRbD0dr5+aw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0nJIH1wi7O6sV1UmrOqTxNYKi88gSkMgX1FYMKN2h/37Y697Q00E7n5EDMEE?=
 =?us-ascii?Q?PG1hfMe2opLBp25AnkLGPSisVFmb+sNUOuFwSq5TLIIgVk1l1O0OJ7mgcW8o?=
 =?us-ascii?Q?iCe1Z+rz7oygXa7t3aGG1W2RaVlBlTp0XTragXvhM87zlSzDmJQU2q/Tixz5?=
 =?us-ascii?Q?lP8gnzT18wpPRDWODGFNUT1Cm2DsbwCwlAGeoaOoqJI4kZRBuepTMfiL9vzT?=
 =?us-ascii?Q?i5BOPL5t6knmlEuvs5HVEu6hk3mAibdUHG+lVqAUSkzPS3T8eissbNINDeY2?=
 =?us-ascii?Q?IXK9hJpxVNHbRoKsJboHxz3HLgM6cwgGI0bP5sLUBjLhhVaTzyJA0rG0KuCk?=
 =?us-ascii?Q?Fo1AmvVWqFfTpir8JabHMmVvAR0TtrdKVQzNPK6GMUVQjuNX2Yni98gXhQpZ?=
 =?us-ascii?Q?+6UNjVXp/0W4wT7iAY5/RZPnzT3wqfPd64Qg5nt4OAclwshyNh3w6S28Xkpt?=
 =?us-ascii?Q?D611LkSzgc3Frzk2RBMXiVA3XbVZtA5Z5LG8XSWpw89uOU20oQDSYXjOzTzm?=
 =?us-ascii?Q?zYCd0ygGEpvl18VNE0UDp/GaXEWx5yymTKZcQWGNdcDZUDSUTVmx3n1DQw7t?=
 =?us-ascii?Q?qfAovPOsmg5kUppBS1ZYWpqrTNC4e3hNxkOzA8U7L8xhn+nlyNW0plxTGDoc?=
 =?us-ascii?Q?jxMmmxtkPT6wS/ElN/HVAtVitZaD35fS+nl877YgWaFee/jDAlXKwFWWyeyU?=
 =?us-ascii?Q?h1Y283V1jPOt3n72/D+nyOMhElwMPNrP3nxt7U2c60uAHBQaGBU4fqmu1Pdc?=
 =?us-ascii?Q?xGXHM/+SV8HO4kML5fKb/9SiAjWr55zLPbp6rQrR9IQ/7Xf918WRybes9hMR?=
 =?us-ascii?Q?PwhYsFJ2+JlSo9nA9+cvp6SbcCu5UqoSzUKx8tw4hr9euFStBFNjYDC19RxT?=
 =?us-ascii?Q?16TOS/xm+sZ4zO9J/wXWFN8kLQhABuCPpyjUJVCBDdbUhm6ahtw2Io6H7dHy?=
 =?us-ascii?Q?ph/yQBjHx1GrZmjUO8P45J8E8cbkV+mDS+8GMxgBQlxs965+jD4dtRd1VRO9?=
 =?us-ascii?Q?LgyHMG7DbceBoBnl8GzAOgoc/eSGM9QQM5nm0ejywBQznd/QauPxkcwUxHBI?=
 =?us-ascii?Q?A/yrdpGrOL4t8eu2FOIEGyaJGWV3QdW0DNzZQSKb+eTLkJW/0rvYxZMoed0b?=
 =?us-ascii?Q?qg2nuRZ6AZdjlIyIelQPb3cI0DO6TmOYo5dJ+aNXJOW9FK6o2RQBIJQRIn/P?=
 =?us-ascii?Q?hGXUszF3a4+4hFoGTy4qpwkMeebpvr+CAP2xkw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57e3cce-f8ff-402a-8ece-08db6dbf54b1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:41:13.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4479
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

v1[1]->v2:
1. Simplified Patch 1 which adds parent_dport attribute to root port and
memdev for plotting cxl topology by leveraging the existing function
`cxl_port_get_parent_dport` in ndctl v77.
2. Introduced a new cxl command 'cxl graph' for cxl topology plotting instead
of implementing the functionality as an option in 'cxl list'.
3. Moved all graph plotting code to a separated file: graph.c.
4. Reverted the changes made to `cxl list` functionality, now its behavior
remains the same as before.
5. Added a new option "-t" for cxl graph command, it takes either 'plain' or
'graph' to determine whether we dump cxl topology to a json formatted file
or plot the topology to a graph. By default, it will plot the graph.
6. Added a function to validate the input cxl topology for "--input" option.
7. Added new code logic to handle cases where there are inactive memdevs.
8 Modified the plotting logic to make plotting work properly with different
user inputs (from options supported by cxl graph). For example, now we can plot
topology graph only for a specific endpoint or memdev.
9. Fix some comments and bugs in graph.c

Below is the cover letter of v1[1]:
This patch series extends the `cxl list` subcommand to show the cxl
topology visually. Mattew Ho first worked on the code and provided an
initial patch as list below[1].

This patch series includes the following two patches,
1) Patch 1 adds a parent_dport attribute to ports and type 3 memory devices
to show which downstream port a component is attached. This attribute will be 
used in patch 2 to generate the cxl topology graph.
2) Patch 2 extends the `cxl list` subcommand to dump the cxl topology to a
json format file or generate a graph showing the cxl topology. To use the
extended function, the option `-o output.suffix` is added. Acceptable output
suffixes include .jpeg, .jpg and .png for generating a graph and for other
suffix, it will dump the json-formatted cxl topology to the file, which
can be used the input file (with --input option) to generate the graph
later.

Patch 2 reuses the plotting functions in Matthew Ho's patch, which are updated
to work with parent_dport attribute in patch 1. Also, some bugs are
fixed. More detailed changes are listed in Patch 2's commit log.

The patch series is applied cleanly on ndctl v77, and tested with the
following different cxl topologies,
1) a single memdev attached the only root port of the single HB in the system;
2) two memdevs attached to the two root ports of the single HB in the system;
3) four memdevs attached to two HBs, each of which has two root ports;
4) four memdevs attached to the downstream ports of a cxl switch which is
attached to one of the two root ports of a HB in the system.


[1] [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
https://lore.kernel.org/linux-cxl/20221220182510.2734032-1-fan.ni@samsung.com/
[2] Mattew Ho's patch:
https://lore.kernel.org/linux-cxl/cover.1660895649.git.sunfishho12@gmail.com/

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

-- 
2.39.2

