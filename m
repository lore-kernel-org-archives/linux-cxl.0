Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69FAC77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 06:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjEVGzh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 02:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjEVGzC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 02:55:02 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 May 2023 23:53:05 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDFA1BF2
        for <linux-cxl@vger.kernel.org>; Sun, 21 May 2023 23:53:05 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="96873884"
X-IronPort-AV: E=Sophos;i="6.00,183,1681138800"; 
   d="scan'208";a="96873884"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:51:59 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id F41EADB390
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:51:56 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C362D3F14
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:51:56 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6BDBF11456CA;
        Mon, 22 May 2023 15:51:55 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v2 0/6] cxl/monitor and ndctl/monitor fixes
Date:   Mon, 22 May 2023 14:51:42 +0800
Message-Id: <20230522065148.818977-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27642.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27642.005
X-TMASE-Result: 10--15.705800-10.000000
X-TMASE-MatchedRID: lefCZilwG1QL0MkR8StpMKoXHZz/dXlxyiKgKtIyB4oyiHqxwIX2MVYM
        JR3dIrh2x8o59scni6zp/lHXBmQcxnqDDsxI37Z8sjFnB5RHQ19LGPRv0WdxQt9zZd3pUn7Kffw
        OGyRfzzO+959IOAxa3ZVZrNbX8SJvaYizM4uRZ4UkC1wj1BQEa7TrV2IG143XdqX0RP2SMcepuz
        6cn+0UkbvlPk1VIqp1gDLqnrRlXrbIDt27MLDp0t0H8LFZNFG7bkV4e2xSge7lUP9lzy7KHbHym
        MiQauFOCfup4XgjsmEpEBNkJd5bdEsMHBii02BH
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

V2:
- exchange order of previous patch1 and patch2
- add reviewed tag in patch5
- commit log improvements

It mainly fix monitor not working when log file is specified. For
example
$ cxl monitor -l ./cxl-monitor.log
It seems that someone missed something at the begining.

Furture, it compares the filename with reserved word more accurately

patch1-2: It re-enables logfile(including default_log) functionality
and simplify the sanity check in the combination relative path file
and daemon mode.

patch3 and patch6 change strncmp to strcmp to compare the acurrate
reserved words.

Li Zhijian (6):
  cxl/monitor: Enable default_log and refactor sanity check
  cxl/monitor: replace monitor.log_file with monitor.ctx.log_file
  cxl/monitor: use strcmp to compare the reserved word
  cxl/monitor: always log started message
  Documentation/cxl/cxl-monitor.txt: Fix inaccurate description
  ndctl/monitor: use strcmp to compare the reserved word

 Documentation/cxl/cxl-monitor.txt |  3 +--
 cxl/monitor.c                     | 45 ++++++++++++++++---------------
 ndctl/monitor.c                   |  4 +--
 3 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.29.2

