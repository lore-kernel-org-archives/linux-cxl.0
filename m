Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CA3EB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 16:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjFOQlq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 12:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjFOQl3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 12:41:29 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2092.outbound.protection.outlook.com [40.92.53.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0978FE69
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 09:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN09DU7SjJrM0NgaHn8+bP1sIs0JERyENaITZ1uuHNpCasxdDJS3ZlYVNP4lFUPU8dhB5wRuDfVfptyYTvsWvd4w1v2kE4VTdH6y4Gg+IWdUoauC3TGDPi4mCRZAbESRBdTg/DC340kP2GJOr+CmzNMS+9HC9XCsxkFHCiLOqouq7STet/ADohoLi+ym0pYTMb2GA/JSYcwSexDvEQ2Kj1DfXoM2yVMrDNnWLcATaEHJXUBeIzn6KE3Z2r377Qr02FGsr/JZ+Nfd8k5T5p5idfpLGbjG+cMZOtlmlOOj662FHFAyzZvajwazO8jnSF5V6l6+gifNzQ8oKjkWjr776g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWJ6MR2V+2w9Ui+0FNzoqzgpvbR7G77x1rT3Y8qrzJg=;
 b=VNGwtfqKJf5cZKb1I8xn3fq9HZ8KixPl8gVtzMUUCjxvhxYE85S3AtgGAgUvWQUZXZ47DaRFii2Dv6/aC9rvES4QTWJA99FEvgRk3BgV4XrSRV5SGnx1HD58acjmFcyVwbr17ePXTwBJAlSFT/5C8p1mPNen47waT2qUD2kFji20at+xeb8NLXMMNItzTeVnYCwygJjWDRoSeh30zswmSgeVLS9tliZG3nAkyUwAdJJ6R0dDAFoufMe/bYCIXQl5GoVckn3zeDjDxH7b2VMEN/nHUP185jKr42hPM57SkhrEt+ExMfftReOfAEhcr6/8jT5rpuWhTZqaPe8TM6Nxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWJ6MR2V+2w9Ui+0FNzoqzgpvbR7G77x1rT3Y8qrzJg=;
 b=QCy/WAJlIYzFf8vdCFn6RFd9nLGQdYwgVmJE1/BQhC8DYpvro7eZNHcmf4jyrefJHbLqucLZj1rcXCQyIPYqPlYvvXnAblCQO+nCgfCV7/uWqCy3mX5pTNAYcR/6GxC5404El9PbdGwx3CkZVonSPpKnsuX/+lvAUsxV2xxkg44q+ctmrnJKbk/BCWdvfo/JHdaCDOGLsnDaoeyOOVCXcw766tq0dmIYBw0HCeK5mX3Ntmp9I/NK5dD4HE8iWdK6ay+1YRsu3accWBo25yElqHym+og2pWsVufUDb84z8fi/2QrL5Swb7c0IgKZVBtF1/tNsyE2l/tYtV2AxnH9w9A==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYZPR06MB4479.apcprd06.prod.outlook.com (2603:1096:400:8e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Thu, 15 Jun 2023 16:41:19 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 16:41:20 +0000
From:   nifan@outlook.com
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave@stgolabs.net, a.manzanares@samsung.com, sunfishho12@gmail.com,
        nmtadam.samsung@gmail.com, nifan@outlook.com, fan.ni@samsung.com
Subject: [ndctl PATCH v2 2/2] cxl-graph: Add cxl graph command to construct CXL topology graph images
Date:   Thu, 15 Jun 2023 09:40:50 -0700
Message-ID: <SG2PR06MB33972E16C90E7365A0C1600FB25BA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615164050.3248000-1-nifan@outlook.com>
References: <20230615164050.3248000-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [bUTCpZttXmgcjr/9VUP/MsHckZIt1XeE]
X-ClientProxiedBy: BYAPR07CA0047.namprd07.prod.outlook.com
 (2603:10b6:a03:60::24) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230615164050.3248000-3-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYZPR06MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 807ae718-fc3a-40ea-e979-08db6dbf58ad
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3k8zbo6QEKMNIjQbqf1y1/6ECGjJZmRu45nU8E35hViODNPUQIblEnGqA4ros/l48uqENO/8aHuyYXURTNlKAqMRtz0yxSegxHXBuYPlj298I0sDo7j6k7qFGRx5jwv6XGo/F9UqExbaqOd8Rfrw5BkG2cGzKvfaW1gSy3k3tLm8TFyY+4GDaPM4ja6k15/6ZwG8lZmyPDyIokZRdNpvcA22omkGreieYFjO4BxqzHm/YGX/EhIYuEjI1Jh+MP+d82STapE6UBxV2h0UMr1BVPniBB1VfsOLpI7zBK4ZpM4zvAst0CrF0ycsNHEP0nKP0xzy1aNwmbiBOBdj2wGG0pADZiv9GTt/xx7aoeoOZtMj8JqPgXTU9Wnswm6CyEvoBbTk2B0WDLrl+pJCQqI7/Bm7jsVNgsybqnMDwnljfIHEJEg2CFeX9B4wfPIQh+sV5MNDbnvwRj6urb144xZ92UHw08DgbnhfOPbYcdstKKMaLxMqLU/fwAu9+GHvLqGHPzYqxeiWL+Rzw5o7UyN6VhopqJTu3SeUkdWignLxAP3CM8eUcNCge7+6OO+xpU+5pDylsPzojo1cNosDNUh1YMGu9cbvXIrelctkdOFXH/UQYHF9PV+yB4poyeDhBW8erdVU8z1tAjVj+dMN3s+bjIGE/M3CSK5THh58rRl66Fb6m6HslyxS4mDfx30X3FKylJe0eH/eP9l8aOmb79DQ3tdRTitX4XxvGa1nN/GdCo2cAyB58wZSTR4pUHd3m2v9Uhyi1nIMETdRyPOf10X2N9U
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ebCvgEIzMis2GeNSbEH7OadjhS4jlqBlys63NbijtSnmHoPQAAJC7dZN0cpwbjnj7ttHNU1XJd1isgZKpw4cw6dd0jlMavqPz67C6+N1f1XZ3B7grbnqdT2cDOFD48t0bC9ECpin1BikQ7zDPq88sT9YPAdVJQI7Wg+0SkzayOkCAJmsdFNBaDOUY6mdgguP2fDER9re8fbQbUKlcBHITVJHrOo8Y9HNQtOUxrCF90JNYvZyJNOF/gCKN8ZyxOkYv5NUlaIOZn5Ap9Oh6v5g+wLSByaRDUILHBXVGbXD1Kgbk/EzSSwmMgXzE18r6pYltHxUEe+GMhvAJ/ozJSqJ7Fw5tGdiTDWDfjRi8aRcztZ7BlgbYNCGS4sFK2Hr/iuvLoSnp7O34xB1z6xLrGm0gb71C8YOIQPYtxv4soaDO5nRLCkvWbZRJXaEToTLy6nnj/HPCJZmV53w7pXGhqEDmKavfsn6C3K9EskMqxw4SA5qY0v7m3KzKIX7S4B1mXy0MGcNT32QYgAxUGfeZyMiaF/r7eWQNmAfa1zTkkj7dgRNSgY3YOTXyXzDlCrGbQzfkc4UOKtIGlMVorJwBOyltwbOmd/+DszPnxRhRTw/M0Q=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xrTLf5+YgKOheT1fPUJ//pC7GxuUcw8Vc9F53f9IV7S4E0inDnaswYtvSgH4?=
 =?us-ascii?Q?21PVPsEs/TuTVHblRwbjmDnMzcZBTzxCyind1c+GmV5ECbR6KjoEI7cerdqs?=
 =?us-ascii?Q?562IVsVFYwK53OnF1KsJrUCIRLXHqTujRg/MwVCvVtG+cFLLWkePd2P3rGvQ?=
 =?us-ascii?Q?/ieDUhISURKPCHeJI4LfLcnkaI/PiR49f2HoNtM1WXFUHJwzI4j1J6zsrali?=
 =?us-ascii?Q?IKUWF4KyRTZze+1CcXhyaVzgvtF5ch+T2+KCvUu7OjRFTMVf13FESHcgxA+B?=
 =?us-ascii?Q?x6ISiQchMxmrtfips6/Egqs+rtqcpjDT//Iv929Qwk6+Ya16NH5C6Or17fLs?=
 =?us-ascii?Q?jU2/H00dv+x3YC3lIqrPuNM2pvrouIBr0VLnmJbJyQ7PfY8zYsqkdSv7Ewbs?=
 =?us-ascii?Q?bCobzZo5TBnYprS7jhdw6LPBNUyKwZ1sXLbmod2851bfNTRKBNmT6IU11VUH?=
 =?us-ascii?Q?mhuAKyTfa8/yjahVv5dYdfFLHwQbGio67poec19OW07VJ8wXMzlDrk+Zg75z?=
 =?us-ascii?Q?/xNT49iGqY0csXQJKRwevvMzhSQIII69+EF6lCeIckrtL9IVHmS+kk38zJnf?=
 =?us-ascii?Q?uqlL+wC+YHYAk70vub4RrelZYYK/QCVaFb3jILkyaXihsLgcUo1ebDKjBuRz?=
 =?us-ascii?Q?u+f7IGKI5GPicCb7vcOGTe6aSdd4CnfO2Iknt9Nf2CkbNhHe7IpLSrTgmpD5?=
 =?us-ascii?Q?sC+YV0QvR1BRjfkOgV/zUb7/xOHohpSFQKpezedSEXNw4nzhUaWOF/9fcVfh?=
 =?us-ascii?Q?OMgEd4GcWgwBQQF+Dz0cmD8DuwvCihcDjQBKdwI5mgU82KMx8RYUy6Z39gNv?=
 =?us-ascii?Q?bAi9yT5/pQS06MNZie/EJKuCzfQ5PkIDtpC5aAd0OEXZpsVLHJvtMYa+10SJ?=
 =?us-ascii?Q?lmPC23QOm9HjG2VllpthqGeGvj5Q0yFPR9RcUrKOK2lC73qoXzOiKTK6dXSp?=
 =?us-ascii?Q?7mGqRYWOfbPnOnIG+K1RlP9c8S3DpX9aK6GZnz4ATuiCC77gC0JypDapaLGx?=
 =?us-ascii?Q?3O4FYJds5SZBBrNUoYOoz2an6zLqHyR/WWsF6nNsZJ9lZHE/jJEwv/VpgM8f?=
 =?us-ascii?Q?kbVVTQbWHdfiO8Um4F03IV4RJBIQW9cY3J2msG1a8YsIYFyydUCdo2ul1gKg?=
 =?us-ascii?Q?4uf3vM3qxQXo63sveJCLMB/+++gzKTAPXj3JD+O1Fg1kMrHCtRoJ1ZAEGQMf?=
 =?us-ascii?Q?D+oDh/BcQXw5Bx5e0JvWEUn1bGovOql7zkLYGg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807ae718-fc3a-40ea-e979-08db6dbf58ad
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 16:41:20.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4479
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

This adds a new command "cxl graph" to plot the cxl topology graph or
dump cxl topology to a json formatted file based on the output format
type (-t graph/plain). The command requires cxl port/memdev components have
the "parent_dport" attribute so the topology can be correctly plotted.
The CXL topology can be either read from a file passed to the command with
"--input" option or parsed at runtime as "cxl list" does, and output will be
stored in a file given by "--output".

This addition makes it easier to visualize the CXL topology.
Also, being able to choose to use an input text file
allows one to visualize the CXL topology while not having
access to CXL hardware, which may be convenient.

Signed-off-by: Fan Ni <fan.ni@samsung.com>

The change is based on Matthew Ho' patch as list below[1].

The main changes include,
    1) Instead of implementing the topology plotting function as a
    subcommand of 'cxl list', we add a new cxl command 'cxl graph', and use
    '-t' option to determine whether plotting the cxl topology graph or
    dumping the topology to json formatted plain file.
    2) Instead of using `root port` attribute for plotting the topology,
    the `parent_dport` attribute of the memdev and port.objects are leveraged
    to plot the topology which enables plotting graph for more complicated
    cxl topology.
    3) Add a function to validate the cxl topology input file when `--input`
    option is used.
    4) Move all the graph related functions to graph.c.
    5) Add a new '-t graph/plain' option indicating the output format
    (graph or json formatted plain file).
    6). Add Documentation/cxl/cxl-graph.txt.
    7). Add support for plotting cxl topology with inactive memdev.
    8). Fix some issues in graph plotting related functions.
    9). Fix the error messages, using error() instead of printf.

[1] Matthew Ho's patch:
https://lore.kernel.org/linux-cxl/cover.1660895649.git.sunfishho12@gmail.com/
---
 Documentation/cxl/cxl-graph.txt | 106 +++++
 config.h.meson                  |   3 +
 cxl/builtin.h                   |   1 +
 cxl/cxl.c                       |   1 +
 cxl/filter.c                    |  15 +-
 cxl/filter.h                    |   5 +
 cxl/graph.c                     | 806 ++++++++++++++++++++++++++++++++
 cxl/meson.build                 |   9 +
 meson.build                     |   5 +
 meson_options.txt               |   1 +
 ndctl.spec.in                   |   1 +
 11 files changed, 949 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/cxl/cxl-graph.txt
 create mode 100644 cxl/graph.c

diff --git a/Documentation/cxl/cxl-graph.txt b/Documentation/cxl/cxl-graph.txt
new file mode 100644
index 0000000..f8040e0
--- /dev/null
+++ b/Documentation/cxl/cxl-graph.txt
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022 Fan Ni <fan.ni@samsung.com>
+
+cxl-graph(1)
+===========
+
+NAME
+----
+cxl-graph - plot or dump the CXL topology to a graph or a json formatted file.
+
+SYNOPSIS
+--------
+[verse]
+'cxl graph' [<options>]
+
+options:
+-m::
+--memdev=::
+	Specify CXL memory device name(s) ("mem0"), device id(s) ("0"),
+	and/or host device name(s) ("0000:35:00.0") to filter the listing.
+-M::
+--memdevs::
+	Include CXL memory devices in the listing
+
+-e::
+--endpoint::
+	Specify CXL endpoint device name(s), or device id(s) to filter
+	the emitted endpoint(s).
+-E::
+--endpoints::
+	Include endpoint objects (CXL Memory Device decoders) in the
+	listing.
+
+-b::
+--bus=::
+	Specify CXL root device name(s), device id(s), and / or CXL bus provider
+	names to filter the listing. The supported provider names are "ACPI.CXL"
+	and "cxl_test".
+
+-p::
+--port=::
+	Specify CXL Port device name(s) ("port2"), device id(s) ("2"), host
+	device name(s) ("pci0000:34"), and / or port type name(s) to filter the
+	listing. The supported port type names are "root" and "switch".
+
+-v::
+--verbose::
+	Increase verbosity of the output. This can be specified
+	multiple times to be even more verbose on the
+	informational and miscellaneous output, and can be used
+	to override omitted flags for showing specific
+	information. Note that cxl list --verbose --verbose is
+	equivalent to cxl list -vv.
+	- *-v*
+	  Enable --memdevs, --regions, --buses,
+	  --ports, --decoders, and --targets.
+	- *-vv*
+	  Everything *-v* provides, plus include disabled
+	  devices with --idle.
+	- *-vvv*
+	  Everything *-vv* provides, plus enable
+	  --health and --partition.
+
+-t::
+	Identify the output format of the CXL topology, with "plain"
+	it will dump the cxl topology to a json formatted file, and
+	with "graph" it will generate a graph showing the cxl topology.
+	"graph" is the choice by default.
+
+-o::
+--output-file::
+	Create an image of the CXL topology or a json formatted representation of
+	the CXL based on the output format given by "-t" option. If no output file
+	is given, by default cxl-topology-graph.png is used for "graph" output
+	format, and "cxl-topology-plain.json" is used for "plain" output format.
+
+--input::
+	Take a json-formatted file with valid CXL topology and generate
+	a graph showing the CXL topology accordingly or dump it to the output file
+	based on the output format.
+
+--debug::
+	If the cxl tool was built with debug enabled, turn on debug
+	messages.
+
+EXAMPLE
+-------
+----
+1. Taking 'cxl list' output as input to plot a graph
+	cxl list -vvv > input.json
+	cxl graph -t graph --input input.json [-o graph.png]
+
+2. Parsing the cxl topology as cxl list does and plotting a graph
+	cxl graph -vvv -t graph [-o a.png/a.jpg/a.jpeg]
+
+3. Parsing the cxl topology as cxl list does and dump the topology to a json
+formatted file
+	cxl graph -vvv -t plain -o a.txt/a.json
+
+include::human-option.txt[]
+
+include::../copyright.txt[]
+
+SEE ALSO
+--------
+linkcxl:cxl-graph[1]
diff --git a/config.h.meson b/config.h.meson
index 5441dff..162e8ba 100644
--- a/config.h.meson
+++ b/config.h.meson
@@ -22,6 +22,9 @@
 /* cxl monitor support */
 #mesondefine ENABLE_LIBTRACEFS
 
+/* cxl graph support */
+#mesondefine Enable_LIBGVC
+
 /* Define to 1 if big-endian-arch */
 #mesondefine HAVE_BIG_ENDIAN
 
diff --git a/cxl/builtin.h b/cxl/builtin.h
index 9baa43b..773eb00 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -22,6 +22,7 @@ int cmd_create_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_graph(int argc, const char **argv, struct cxl_ctx *ctx);
 #ifdef ENABLE_LIBTRACEFS
 int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
 #else
diff --git a/cxl/cxl.c b/cxl/cxl.c
index 3be7026..76493e4 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -77,6 +77,7 @@ static struct cmd_struct commands[] = {
 	{ "disable-region", .c_fn = cmd_disable_region },
 	{ "destroy-region", .c_fn = cmd_destroy_region },
 	{ "monitor", .c_fn = cmd_monitor },
+	{ "graph", .c_fn = cmd_graph },
 };
 
 int main(int argc, const char **argv)
diff --git a/cxl/filter.c b/cxl/filter.c
index 6e8d421..b06dff5 100644
--- a/cxl/filter.c
+++ b/cxl/filter.c
@@ -1170,10 +1170,6 @@ struct json_object *cxl_filter_walk(struct cxl_ctx *ctx,
 			}
 		}
 walk_children:
-		dbg(p, "walk decoders\n");
-		walk_decoders(port, p, pick_array(jchilddecoders, jbusdecoders),
-			      pick_array(jchildregions, jregions), flags);
-
 		dbg(p, "walk rch endpoints\n");
 		if (p->endpoints || p->memdevs || p->decoders)
 			walk_endpoints(port, p,
@@ -1182,12 +1178,23 @@ walk_children:
 				       pick_array(jchilddecoders, jepdecoders),
 				       flags);
 
+		/*
+		 * Need to walk ports before walking decoder so dport will be
+		 * properly initialized which is needed to get the correct
+		 * parent_dport of a port. This is needed if we plot the cxl
+		 * graph after some region is created.
+		 */
 		dbg(p, "walk ports\n");
 		walk_child_ports(port, p, pick_array(jchildports, jports),
 				 pick_array(jchilddecoders, jportdecoders),
 				 pick_array(jchildeps, jeps),
 				 pick_array(jchilddecoders, jepdecoders),
 				 pick_array(jchilddevs, jdevs), flags);
+
+		dbg(p, "walk decoders\n");
+		walk_decoders(port, p, pick_array(jchilddecoders, jbusdecoders),
+			      pick_array(jchildregions, jregions), flags);
+
 		cond_add_put_array_suffix(jbus, "ports", devname, jchildports);
 		cond_add_put_array_suffix(jbus, "endpoints", devname,
 					  jchildeps);
diff --git a/cxl/filter.h b/cxl/filter.h
index c486514..0efc446 100644
--- a/cxl/filter.h
+++ b/cxl/filter.h
@@ -6,6 +6,8 @@
 #include <stdbool.h>
 #include <util/log.h>
 #include <util/json.h>
+#include <json-c/json.h>
+#include <graphviz/gvc.h>
 
 struct cxl_filter_params {
 	const char *memdev_filter;
@@ -31,6 +33,9 @@ struct cxl_filter_params {
 	bool dax;
 	int verbose;
 	struct log_ctx ctx;
+	const char *input_file;
+	const char *output_file;
+	const char *output_format; /*plain/graph*/
 };
 
 struct cxl_memdev *util_cxl_memdev_filter(struct cxl_memdev *memdev,
diff --git a/cxl/graph.c b/cxl/graph.c
new file mode 100644
index 0000000..eea13fa
--- /dev/null
+++ b/cxl/graph.c
@@ -0,0 +1,806 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022 Fan Ni <fan.ni@samsung.com>
+// Copyright (C) 2022 Matthew Ho <sunfishho12@gmail.com>
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <limits.h>
+#include <util/json.h>
+#include <json-c/json.h>
+#include <cxl/libcxl.h>
+#include <util/parse-options.h>
+
+#include <graphviz/gvc.h>
+#include <util/util.h>
+#include <util/log.h>
+
+#include "filter.h"
+
+static struct cxl_filter_params param;
+static bool debug;
+
+static bool device_has_parent_dport(struct json_object *dev)
+{
+	json_object_object_foreach(dev, property, value_json) {
+		if (!strcmp(property, "parent_dport"))
+			return true;
+	}
+
+	return false;
+}
+
+static bool device_has_dport(struct json_object *dev)
+{
+	json_object_object_foreach(dev, property, value_json) {
+		if (!strcmp(property, "nr_dports"))
+			return true;
+	}
+
+	return false;
+}
+
+static Agnode_t *create_node(Agraph_t *graph, char *label, bool created)
+{
+	return agnode(graph, label, created);
+}
+
+static const char *find_device_type(struct json_object *device)
+{
+	char *value;
+	int depth = -1;
+	bool is_device = false;
+
+	json_object_object_foreach(device, property, value_json) {
+		value = (char *)json_object_get_string(value_json);
+		if (!strcmp(property, "bus") &&
+		    !strcmp(value, "root0"))
+			return "ACPI0017 Device";
+		if (!strcmp(property, "depth")) {
+			depth = json_object_get_int(value_json);
+			if (is_device) {
+				if (depth == 1)
+					return "Host Bridge";
+				else
+					return "Switch Port";
+			}
+		}
+		if (!strcmp(property, "endpoint"))
+			return "Endpoint";
+		if (!strcmp(property, "parent_dport")) {
+			is_device = true;
+			if (depth == 1)
+				return "Host Bridge";
+			if (depth > 1)
+				return "Switch Port";
+		}
+		if (!strcmp(property, "memdev"))
+			return "Type 3 Memory Device";
+		if (!strcmp(property, "dport"))
+			return "dport";
+		if (!strcmp(property, "decoder"))
+			return "decoder";
+		if (!strcmp(property, "provider") &&
+		    !strcmp(value, "cxl_test"))
+			return "cxl_acpi.0";
+	}
+
+	dbg(&param, "unknown device:\n%s\n",
+		json_object_to_json_string_ext(device, JSON_C_TO_STRING_PRETTY));
+	return NULL;
+}
+
+static bool check_device_type(struct json_object *device, char *type)
+{
+	const char *dev_type = find_device_type(device);
+
+	if (dev_type)
+		return !strcmp(dev_type, type);
+	return false;
+}
+
+/* for labeling purposes */
+static const char *find_device_ID(struct json_object *device)
+{
+	const char *dev_type = find_device_type(device);
+	json_object *ID = NULL;
+
+	if (!dev_type)
+		return NULL;
+
+	if (!strcmp(dev_type, "ACPI0017 Device"))
+		json_object_object_get_ex(device, "bus", &ID);
+
+	if (!strcmp(dev_type, "Host Bridge")
+		|| !strcmp(dev_type, "Switch Port"))
+		json_object_object_get_ex(device, "host", &ID);
+
+	if (!strcmp(dev_type, "Endpoint"))
+		json_object_object_get_ex(device, "endpoint", &ID);
+
+	if (!strcmp(dev_type, "Type 3 Memory Device"))
+		json_object_object_get_ex(device, "memdev", &ID);
+
+	if (!strcmp(dev_type, "dport"))
+		json_object_object_get_ex(device, "dport", &ID);
+
+	return json_object_get_string(ID);
+}
+
+static bool is_device(struct json_object *device)
+{
+	const char *dev_type = find_device_type(device);
+
+	if (dev_type)
+		return (strcmp(dev_type, "dport") && strcmp(dev_type, "decoder"));
+
+	return false;
+}
+
+static const char *find_parent_dport(struct json_object *device)
+{
+	json_object *rp;
+
+	if (!json_object_object_get_ex(device, "parent_dport", &rp))
+		return NULL;
+
+	return json_object_get_string(rp);
+}
+
+static char *find_parent_dport_label(struct json_object *device)
+{
+	char *rp_node_name;
+	const char *id = find_parent_dport(device);
+
+	if (!id)
+		return NULL;
+
+	asprintf(&rp_node_name, "dPort\nID: %s", id);
+	if (!rp_node_name)
+		error("asprintf failed in %s\n", __func__);
+
+	return rp_node_name;
+}
+
+static char *find_root_port_label(struct json_object *device)
+{
+	char *rp_node_name;
+	const char *id = find_parent_dport(device);
+
+	if (!id)
+		return NULL;
+
+	asprintf(&rp_node_name, "Root Port\nID: %s", id);
+	if (!rp_node_name)
+		error("asprintf failed in %s\n", __func__);
+
+	return rp_node_name;
+}
+
+static char *label_device(struct json_object *device)
+{
+	char *label;
+	const char *ID = find_device_ID(device);
+	const char *devname = find_device_type(device);
+
+	assert(devname);
+	asprintf(&label, "%s\nID: %s", devname, ID);
+	if (!label)
+		error("label allocation failed in %s\n", __func__);
+
+	return label;
+}
+
+static void create_root_ports(struct json_object *host_bridge, Agraph_t *graph,
+		       Agnode_t *hb)
+{
+	json_object *rps, *rp, *id_json;
+	char *id, *dport_label;
+	Agnode_t *dport;
+	size_t nr_dports, idx;
+
+	assert(check_device_type(host_bridge, "Host Bridge"));
+	if (!json_object_object_get_ex(host_bridge, "dports", &rps)) {
+		dbg(&param, "no dports attribute found at host bridge\n");
+		return;
+	}
+
+	nr_dports = json_object_array_length(rps);
+	for (idx = 0; idx < nr_dports; idx++) {
+		rp = json_object_array_get_idx(rps, idx);
+		json_object_object_get_ex(rp, "dport", &id_json);
+		id = (char *)json_object_get_string(id_json);
+		asprintf(&dport_label, "Root Port\nID: %s", id);
+		if (!dport_label)
+			error("label allocation failed when creating root port\n");
+		dport = create_node(graph, dport_label, 1);
+		agedge(graph, hb, dport, 0, 1);
+		free(dport_label);
+	}
+}
+
+static void create_downstream_ports(struct json_object *sw_port,
+		Agraph_t *graph, Agnode_t *sw)
+{
+	json_object *dps, *dp, *id_json;
+	char *id, *dport_label;
+	Agnode_t *dport;
+	size_t nr_dports, idx;
+
+	assert(check_device_type(sw_port, "Switch Port"));
+	if (!json_object_object_get_ex(sw_port, "dports", &dps)) {
+		dbg(&param, "no dports attribute found at switch port\n");
+		return;
+	}
+
+	nr_dports = json_object_array_length(dps);
+	for (idx = 0; idx < nr_dports; idx++) {
+		dp = json_object_array_get_idx(dps, idx);
+		json_object_object_get_ex(dp, "dport", &id_json);
+		id = (char *)json_object_get_string(id_json);
+		asprintf(&dport_label, "dPort\nID: %s", id);
+		if (!dport_label)
+			error("label allocation failed when creating downstream port\n");
+		dport = create_node(graph, dport_label, 1);
+		agedge(graph, sw, dport, 0, 1);
+		free(dport_label);
+	}
+}
+
+/* for determining number of devices listed in a json array */
+static size_t count_top_devices(struct json_object *top_array)
+{
+	size_t dev_counter = 0;
+	size_t top_array_len = json_object_array_length(top_array);
+
+	for (size_t idx = 0; idx < top_array_len; idx++)
+		if (is_device(json_object_array_get_idx(top_array, idx)))
+			dev_counter++;
+
+	return dev_counter;
+}
+
+static Agnode_t *plot_anon_memdevs(struct json_object *current_array,
+		Agraph_t *graph)
+{
+	size_t json_array_len, nr_top_devices;
+	size_t idx;
+	Agnode_t *node, *root;
+	char *label;
+	json_object *device;
+
+	json_array_len = json_object_array_length(current_array);
+	nr_top_devices = count_top_devices(current_array);
+	if (!nr_top_devices)
+		return NULL;
+
+	assert(nr_top_devices == json_array_len);
+	label = "anon memdevs";
+	root = create_node(graph, label, 1);
+
+	for (idx = 0; idx < json_array_len; idx++) {
+		device = json_object_array_get_idx(current_array, idx);
+		label = label_device(device);
+		node = create_node(graph, label, 1);
+		agsafeset(node, "shape", "box", "");
+		agedge(graph, root, node, 0, 1);
+		free(label);
+	}
+	return root;
+}
+
+static Agnode_t **draw_subtree(struct json_object *current_array,
+		Agraph_t *graph)
+{
+	size_t json_array_len, nr_top_devices, obj_idx, td_idx;
+	size_t idx, nr_sub_devs, nr_devs_connected;
+	char *label, *parent_dport_label;
+	Agnode_t **top_devices, **sub_devs, *parent_node;
+	bool is_hb, is_sw;
+	json_object *device, *subdev_arr, *subdev;
+	json_object_iter subdev_iter;
+
+	json_array_len = json_object_array_length(current_array);
+	nr_top_devices = count_top_devices(current_array);
+
+	if (!nr_top_devices) {
+		dbg(&param, "no top devices, return directly\n");
+		return NULL;
+	}
+
+	top_devices = malloc(nr_top_devices * sizeof(device));
+	if (!top_devices) {
+		error("allocate memory for top_devices failed\n");
+		return NULL;
+	}
+
+	td_idx = 0;
+	for (obj_idx = 0; obj_idx < json_array_len; obj_idx++) {
+		device = json_object_array_get_idx(current_array, obj_idx);
+		if (!is_device(device))
+			continue;
+
+		label = label_device(device);
+		top_devices[td_idx] = create_node(graph, label, 1);
+
+		agsafeset(top_devices[td_idx], "shape", "box", "");
+
+		is_hb = check_device_type(device, "Host Bridge");
+		is_sw = check_device_type(device, "Switch Port");
+
+		if ((is_hb || is_sw) && !device_has_dport(device)) {
+			error("no nr_dports attribute in the json obj for %s\n",
+					is_hb ? "CXL host bridge" : "CXL switch");
+			return top_devices;
+		}
+
+		/* Create root port nodes if device is a host bridge */
+		if (is_hb)
+			create_root_ports(device, graph, top_devices[td_idx]);
+		else if (is_sw)
+			create_downstream_ports(device, graph, top_devices[td_idx]);
+
+		free(label);
+
+		/* Iterate through all keys and values of an object (device) */
+		json_object_object_foreachC(device, subdev_iter) {
+			bool is_endpoint = check_device_type(device, "Endpoint");
+			char *key = subdev_iter.key;
+
+			if (is_endpoint && !strcmp(key, "memdev")) {
+				/*subdev_arr = convert_json_obj_to_array(subdev_arr);*/
+				Agnode_t *node;
+
+				label = label_device(subdev_iter.val);
+				node = create_node(graph, label, 1);
+				agsafeset(node, "shape", "box", "");
+				free(label);
+				agedge(graph, top_devices[td_idx], node, 0, 1);
+				break;
+			}
+
+			subdev_arr = subdev_iter.val;
+			if (!json_object_is_type(subdev_arr, json_type_array))
+				continue;
+			nr_sub_devs = count_top_devices(subdev_arr);
+			sub_devs = draw_subtree(subdev_arr, graph);
+			if (!sub_devs)
+				continue;
+			if (!is_hb && !is_sw) {
+				for (idx = 0; idx < nr_sub_devs; idx++)
+					agedge(graph, top_devices[td_idx], sub_devs[idx], 0, 1);
+				free(sub_devs);
+				continue;
+			}
+
+			nr_devs_connected = 0;
+			for (idx = 0;
+			     idx < json_object_array_length(subdev_arr);
+			     idx++) {
+				subdev = json_object_array_get_idx(subdev_arr, idx);
+				if (!is_device(subdev))
+					continue;
+
+				if (is_hb)
+					parent_dport_label = find_root_port_label(subdev);
+				else
+					parent_dport_label = find_parent_dport_label(subdev);
+				if (!parent_dport_label) {
+					error("graph function requires parent_dport attribute\n");
+					return NULL;
+				}
+				/* with flag = 0, it will search to locate an existing node */
+				parent_node = create_node(graph, parent_dport_label, 0);
+				if (parent_node) {
+					agedge(graph, parent_node,
+						sub_devs[nr_devs_connected++], 0, 1);
+					free(parent_dport_label);
+				} else {
+					dbg(&param, "create parent node failed: %s\n",
+						parent_dport_label);
+				}
+			}
+			free(sub_devs);
+		}
+		td_idx++;
+	}
+
+	return top_devices;
+}
+
+struct json_object *parse_json_text(const char *path)
+{
+	FILE *fp;
+	char *json_as_string;
+	size_t file_len;
+	json_object *json;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		error("could not read file\n");
+	fseek(fp, 0, SEEK_END);
+	file_len = ftell(fp);
+	fseek(fp, 0, SEEK_SET);
+	json_as_string = malloc(file_len + 1);
+	if (!json_as_string ||
+	    fread(json_as_string, 1, file_len, fp) != file_len) {
+		free(json_as_string);
+		error("could not read file %s\n", path);
+	}
+	json_as_string[file_len] = '\0';
+	json = json_tokener_parse(json_as_string);
+	return json;
+}
+
+static void draw_graph(struct json_object *current_array,
+		Agraph_t *graph)
+{
+	size_t json_array_len = json_object_array_length(current_array);
+	size_t idx;
+	json_object_iter iter;
+	json_object *device;
+	Agnode_t *anon_memdevs = NULL;
+	Agnode_t **top_devices = NULL;
+	size_t num_top_devices = 0;
+
+	if (json_array_len == 1) {
+		if (draw_subtree(current_array, graph))
+			free(top_devices);
+	} else {
+		for (idx = 0; idx < json_array_len; idx++) {
+			device = json_object_array_get_idx(current_array, idx);
+			json_object_object_foreachC(device, iter) {
+				char *key = iter.key;
+				json_object *val = iter.val;
+
+				if (!strcmp(key, "anon memdevs")) {
+					anon_memdevs = plot_anon_memdevs(val, graph);
+				} else if (!strcmp(key, "buses")) {
+					num_top_devices = json_object_array_length(val);
+					top_devices = draw_subtree(val, graph);
+				} else {
+					error("unknown top key from cxl topology\n");
+				}
+			}
+		}
+		if (anon_memdevs && top_devices) {
+			Agnode_t *root = create_node(graph, "CXL sub-system", 1);
+
+			agsafeset(root, "shape", "box", "");
+			agedge(graph, root, anon_memdevs, 0, 1);
+			for (idx = 0; idx < num_top_devices; idx++)
+				agedge(graph, root, top_devices[idx], 0, 1);
+		}
+		if (top_devices)
+			free(top_devices);
+	}
+}
+
+static int create_image(const char *filename, json_object *platform)
+{
+	int rs = 0;
+	char *output_file = (char *)filename;
+	GVC_t *gvc;
+	Agraph_t *graph;
+	char *of_extension = strrchr(output_file, '.');
+	FILE *FP;
+
+	gvc = gvContext();
+	if (!gvc) {
+		error("Creating gvContext failed");
+		return -1;
+	}
+	graph = agopen("graph", Agdirected, 0);
+	if (!graph) {
+		error("agopen failed when creating cxl topology image");
+		rs = -1;
+		goto free_ctx;
+	}
+
+	if (!of_extension || (strcmp(of_extension, ".png") &&
+			strcmp(of_extension, ".jpeg") &&
+			strcmp(of_extension, ".jpg"))) {
+		error("unsupported output image type, only png/jpeg/jpg supported\n");
+		rs = -1;
+		goto close_graph;
+	}
+
+	draw_graph(platform, graph);
+	if (gvLayout(gvc, graph, "dot")) {
+		error("gvLayout failed when creating cxl topology image");
+		rs = -1;
+		goto close_graph;
+	}
+
+	FP = fopen(output_file, "w");
+	if (!FP) {
+		error("open %s for storing the graph failed", output_file);
+		rs = -1;
+		goto create_exit;
+	} else {
+		gvRender(gvc, graph, strrchr(output_file, '.') + 1, FP);
+		fclose(FP);
+	}
+
+create_exit:
+	gvFreeLayout(gvc, graph);
+close_graph:
+	agclose(graph);
+free_ctx:
+	gvFreeContext(gvc);
+
+	return rs;
+}
+
+static const struct option options[] = {
+	OPT_STRING('m', "memdev", &param.memdev_filter, "memory device name(s)",
+		   "filter by CXL memory device name(s)"),
+	OPT_BOOLEAN('M', "memdevs", &param.memdevs,
+		    "include CXL memory device info"),
+	OPT_STRING('b', "bus", &param.bus_filter, "bus device name",
+		   "filter by CXL bus device name(s)"),
+	OPT_STRING('p', "port", &param.port_filter, "port device name",
+		   "filter by CXL port device name(s)"),
+	OPT_STRING('e', "endpoint", &param.endpoint_filter,
+		   "endpoint device name",
+		   "filter by CXL endpoint device name(s)"),
+	OPT_BOOLEAN('E', "endpoints", &param.endpoints,
+		    "include CXL endpoint info"),
+	OPT_BOOLEAN('i', "idle", &param.idle, "include disabled devices"),
+	OPT_STRING(0, "input", &param.input_file,
+		   "input file path for creating topology image",
+		   "path to file containing a json array describing the topology"),
+	OPT_STRING('o', "output-file", &param.output_file, "output file path",
+		   "path to file to generate graph or dump cxl topology to"),
+	OPT_STRING('t', "output-format", &param.output_format, "output format",
+		   "way to output cxl topology: plain or graph (by default)"),
+	OPT_INCR('v', "verbose", &param.verbose, "increase output detail"),
+#ifdef ENABLE_DEBUG
+	OPT_BOOLEAN(0, "debug", &debug, "debug graph plot"),
+#endif
+	OPT_END(),
+};
+
+static int num_list_flags(void)
+{
+	return !!param.memdevs + !!param.buses + !!param.ports +
+	       !!param.endpoints + !!param.decoders + !!param.regions;
+}
+
+static bool validate_cxl_topology_input_helper(json_object *cur_array,
+		bool bus_detected, bool hb_detected)
+{
+	size_t arr_len, obj_idx;
+	size_t nr_top_devices;
+	bool is_hb, is_sw, is_endpoint, is_memdev;
+	json_object *device;
+	json_object_iter subdev_iter;
+
+	arr_len = json_object_array_length(cur_array);
+	nr_top_devices = count_top_devices(cur_array);
+	if (!nr_top_devices)
+		goto validate_exit;
+
+	for (obj_idx = 0; obj_idx < arr_len; obj_idx++) {
+		device = json_object_array_get_idx(cur_array, obj_idx);
+		if (!is_device(device))
+			continue;
+
+		if (check_device_type(device, "ACPI0017 Device"))
+			bus_detected = true;
+
+		is_hb = check_device_type(device, "Host Bridge");
+		is_sw = check_device_type(device, "Switch Port");
+		is_endpoint = check_device_type(device, "Endpoint");
+		is_memdev = check_device_type(device, "Type 3 Memory Device");
+		if (is_memdev || is_endpoint) {
+			if (!hb_detected || !bus_detected)
+				return false;
+		}
+		/* cxl switch must be below cxl HB */
+		if (is_sw) {
+			if (!hb_detected || !bus_detected)
+				return false;
+		}
+		if (is_hb) {
+			if (!bus_detected)
+				return false;
+			hb_detected = true;
+		}
+		if (is_hb || is_sw) {
+			if (!device_has_dport(device)) {
+				error("dport not found for cxl HB or switch.\n ");
+				return false;
+			}
+		}
+		if ((is_hb || is_sw || is_endpoint || is_memdev)
+				&& !device_has_parent_dport(device)) {
+			error("parent_dport not found in cxl topology.\n ");
+			return false;
+		}
+
+		json_object_object_foreachC(device, subdev_iter) {
+			char *key = subdev_iter.key;
+			json_object *subdev_arr = subdev_iter.val;
+
+			if (!json_object_is_type(subdev_arr, json_type_array))
+				continue;
+			/* skip dports list */
+			if (!strcmp(key, "dports"))
+				continue;
+			if (!validate_cxl_topology_input_helper(subdev_arr,
+						bus_detected, hb_detected))
+				return false;
+		}
+	}
+
+validate_exit:
+	return bus_detected;
+}
+
+static bool validate_cxl_topology_input(json_object *cur_array)
+{
+	size_t json_array_len = json_object_array_length(cur_array);
+	size_t idx;
+	json_object_iter iter;
+	json_object *device;
+
+	if (json_array_len == 1)
+		return validate_cxl_topology_input_helper(cur_array, false, false);
+
+	for (idx = 0; idx < json_array_len; idx++) {
+		device = json_object_array_get_idx(cur_array, idx);
+		json_object_object_foreachC(device, iter) {
+			char *key = iter.key;
+			json_object *val = iter.val;
+
+			if (!strcmp(key, "anon memdevs")) {
+				;
+			} else if (!strcmp(key, "buses")) {
+				if (!validate_cxl_topology_input_helper(val, false, false))
+					return false;
+			} else {
+				error("unsupported top key from cxl topology: %s\n",
+						key);
+				return false;
+			}
+		}
+	}
+	return true;
+}
+
+int cmd_graph(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	const char * const u[] = {
+		"cxl graph [<options>]",
+		NULL
+	};
+	int i;
+	json_object *platform;
+	FILE *fp;
+	int rs = 0;
+
+	argc = parse_options(argc, argv, options, u, 0);
+	for (i = 0; i < argc; i++)
+		error("unknown parameter \"%s\"\n", argv[i]);
+
+	if (argc)
+		usage_with_options(u, options);
+
+	if (num_list_flags() == 0) {
+		if (param.memdev_filter)
+			param.memdevs = true;
+		if (param.port_filter)
+			param.ports = true;
+		if (param.endpoint_filter)
+			param.endpoints = true;
+	}
+
+	param.buses = true;
+	param.ports = true;
+	param.targets = true;
+	param.decoders = true;
+	if (!param.endpoints && !param.memdevs) {
+		param.memdevs = true;
+		param.endpoints = true;
+	}
+
+	switch (param.verbose) {
+	default:
+	case 3:
+		param.health = true;
+		param.partition = true;
+		param.alert_config = true;
+		/* fallthrough */
+	case 2:
+		param.idle = true;
+		/* fallthrough */
+	case 1:
+		param.buses = true;
+		param.ports = true;
+		param.endpoints = true;
+		param.decoders = true;
+		param.targets = true;
+		/*fallthrough*/
+	case 0:
+		break;
+	}
+
+	log_init(&param.ctx, "cxl graph", "CXL_GRAPH_LOG");
+	if (debug) {
+		cxl_set_log_priority(ctx, LOG_DEBUG);
+		param.ctx.log_priority = LOG_DEBUG;
+	}
+
+	if (!param.output_format)
+		param.output_format = "graph";
+	else if (strcmp(param.output_format, "graph")
+		&& strcmp(param.output_format, "plain")) {
+		error("only plain/graph is accepted for output_format\n");
+		return 0;
+	}
+
+	if (!param.output_file) {
+		dbg(&param, "no output file given, using topology.png by default\n");
+		if (!strcmp(param.output_format, "graph"))
+			param.output_file = "cxl-topology-graph.png";
+		else
+			param.output_file = "cxl-topology-plain.json";
+	}
+
+	if (param.input_file) {
+		if (access(param.input_file, R_OK)) {
+			error("input file %s cannot be accessed\n", param.input_file);
+			return -EPERM;
+		}
+
+		platform = parse_json_text(param.input_file);
+		if (!validate_cxl_topology_input(platform)) {
+			error("cxl topology from input file `%s` not valid.\n",
+					param.input_file);
+			dbg(&param, "%s\t%s\t%s\t%s\t%s\t%s\n",
+				"valid cxl topology should include following info:\n",
+				"1): cxl bus;\n",
+				"2): cxl host bridge (HB);\n",
+				"3): cxl memdev;\n",
+				"4): nr_dport attribute for HB and switch (if exists);\n",
+				"5): parent_dport attribute for port and memdev objects.\n");
+			dbg(&param, "please generate input file with %s or %s",
+				"\'cxl list\' with -v/-vv/-vvv option",
+				"use \'cxl graph -t plain\'\n");
+			return -1;
+		}
+		if (!strcmp(param.output_format, "graph")) {
+			rs = create_image(param.output_file, platform);
+			goto graph_exit;
+		} else
+			goto dump_plain;
+	}
+
+	dbg(&param, "walk topology\n");
+	platform = cxl_filter_walk(ctx, &param);
+	if (!platform)
+		return -ENOMEM;
+
+	if (!strcmp(param.output_format, "graph"))
+		rs = create_image(param.output_file, platform);
+	else {
+dump_plain:
+		fp = fopen(param.output_file, "w+");
+		if (!fp) {
+			error("dump to output file %s failed.\n", param.output_file);
+			rs = -1;
+		} else {
+			fprintf(fp, "%s\n", json_object_to_json_string_ext(platform,
+				JSON_C_TO_STRING_PRETTY));
+			fclose(fp);
+		}
+	}
+
+graph_exit:
+	if (!rs)
+		;
+		/*util_display_json_array(stdout, platform, cxl_filter_to_flags(&param));*/
+	return 0;
+}
diff --git a/cxl/meson.build b/cxl/meson.build
index 61b4d87..346768f 100644
--- a/cxl/meson.build
+++ b/cxl/meson.build
@@ -25,6 +25,15 @@ deps = [
   versiondep,
 ]
 
+if get_option('libgvc').enabled()
+  cxl_src += [
+    'graph.c',
+  ]
+  deps += [
+    graphviz,
+  ]
+endif
+
 if get_option('libtracefs').enabled()
   cxl_src += [
     'event_trace.c',
diff --git a/meson.build b/meson.build
index 50e83cf..4eabaf0 100644
--- a/meson.build
+++ b/meson.build
@@ -143,6 +143,10 @@ kmod = dependency('libkmod')
 libudev = dependency('libudev')
 uuid = dependency('uuid')
 json = dependency('json-c')
+if get_option('libgvc').enabled()
+  graphviz = dependency('libgvc')
+endif
+
 if get_option('libtracefs').enabled()
   traceevent = dependency('libtraceevent')
   tracefs = dependency('libtracefs')
@@ -237,6 +241,7 @@ conf.set('ENABLE_DESTRUCTIVE', get_option('destructive').enabled())
 conf.set('ENABLE_LOGGING', get_option('logging').enabled())
 conf.set('ENABLE_DEBUG', get_option('dbg').enabled())
 conf.set('ENABLE_LIBTRACEFS', get_option('libtracefs').enabled())
+conf.set('ENABLE_LIBGVC', get_option('libgvc').enabled())
 
 typeof_code = '''
   void func() {
diff --git a/meson_options.txt b/meson_options.txt
index 5c41b1a..08e6c3a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -3,6 +3,7 @@ option('version-tag', type : 'string',
 option('docs', type : 'feature', value : 'enabled')
 option('asciidoctor', type : 'feature', value : 'enabled')
 option('libtracefs', type : 'feature', value : 'enabled')
+option('libgvc', type : 'feature', value : 'enabled')
 option('systemd', type : 'feature', value : 'enabled')
 option('keyutils', type : 'feature', value : 'enabled',
   description : 'enable nvdimm device passphrase management')
diff --git a/ndctl.spec.in b/ndctl.spec.in
index 7702f95..66cdf71 100644
--- a/ndctl.spec.in
+++ b/ndctl.spec.in
@@ -31,6 +31,7 @@ BuildRequires:	pkgconfig(uuid)
 BuildRequires:	pkgconfig(json-c)
 BuildRequires:	pkgconfig(bash-completion)
 BuildRequires:	pkgconfig(systemd)
+BuildRequires:  graphviz
 BuildRequires:	keyutils-libs-devel
 BuildRequires:	systemd-rpm-macros
 BuildRequires:	iniparser-devel
-- 
2.39.2

