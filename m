Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE42AE936EA
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 22:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjJDWIg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 18:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjJDWIf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 18:08:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F7D9
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696457311; x=1727993311;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yznFHA0lQ01H4WPA1Z9QMDpuEgbAMS4fJPI3+gTpSOw=;
  b=INya+KxX4XoBmwr84NEOKboILHEQOiiD/HH93ozibmpzQ/PDDv6hqNtY
   KzEHsj0Fsc5wwdKMPfy/npCLJ0/zjkoCf6tyXSlO1PNGIqheqQ0Cf1/gK
   PtydqLmZ63TVfjpNKo+E/KqC7KROgK2dvOvBvS3ECSfAegSI1talFeCC4
   s3d6GKkxsSyIwfGBOKwpcRH9ykgsOlhi3KGJDVn+FOKYhDnDdZD8vC7fu
   HX02e0qkm5QBrDImokWKjYCs8MlNHAZkDgrPEby3JLZL7GfTctfRqShhZ
   0ldCa0E4+8i+gLO/8HjizRf4rrfNUujIJ4Xx9+/3bnWYvxn8Rh1BgCO07
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383223398"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383223398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="895155804"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="895155804"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.170.46])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 15:07:03 -0700
Subject: [NDCTL PATCH 2/2] cxl: Add check for regions before disabling memdev
From:   Dave Jiang <dave.jiang@intel.com>
To:     vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Wed, 04 Oct 2023 15:08:30 -0700
Message-ID: <169645731012.624805.15404457479294344934.stgit@djiang5-mobl3>
In-Reply-To: <169645730392.624805.16511039948183288287.stgit@djiang5-mobl3>
References: <169645730392.624805.16511039948183288287.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add a check for memdev disable to see if there are active regions present
before disabling the device. This is necessary now regions are present to
fulfill the TODO that was left there. The best way to determine if a
region is active is to see if there are decoders enabled for the mem
device. This is also best effort as the state is only a snapshot the
kernel provides and is not atomic WRT the memdev disable operation. The
expectation is the admin issuing the command has full control of the mem
device and there are no other agents also attempt to control the device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/memdev.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/cxl/memdev.c b/cxl/memdev.c
index f6a2d3f1fdca..314bac082719 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -373,11 +373,21 @@ static int action_free_dpa(struct cxl_memdev *memdev,
 
 static int action_disable(struct cxl_memdev *memdev, struct action_context *actx)
 {
+	struct cxl_endpoint *ep;
+	struct cxl_port *port;
+
 	if (!cxl_memdev_is_enabled(memdev))
 		return 0;
 
-	if (!param.force) {
-		/* TODO: actually detect rather than assume active */
+	ep = cxl_memdev_get_endpoint(memdev);
+	if (!ep)
+		return -ENODEV;
+
+	port = cxl_endpoint_get_port(ep);
+	if (!port)
+		return -ENODEV;
+
+	if (cxl_port_decoders_committed(port) && !param.force) {
 		log_err(&ml, "%s is part of an active region\n",
 			cxl_memdev_get_devname(memdev));
 		return -EBUSY;


