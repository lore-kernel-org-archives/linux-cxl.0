Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF06C32774
	for <linux-cxl@archiver.kernel.org>; Tue, 23 Aug 2022 07:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiHWHpk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Aug 2022 03:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbiHWHpc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Aug 2022 03:45:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E0A647D4
        for <linux-cxl@vger.kernel.org>; Tue, 23 Aug 2022 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661240731; x=1692776731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQGAynVVQNWd8X9mtXQpToldlZvQ77AW/OreICS7N/k=;
  b=QFBYTji+7v/JnRqJjX7is2mIjihq1mUnjNzfTj1ztWYwqGCbj1v1LE/F
   ltaMoMX4KssQUM0ps7bMOr39g/LWUMUAOLay5HDicXpe9Eb4WpDdu0xul
   k3x0+sjvFXmhletRJKZdXoplnMS7sJ9Jv87j48lMFWRqfBMP/qbiorrQI
   OEUBNgLba6sWJfglPSA0KGMLbizoUtue7EOHrc0xwtTWmI+1LjSvkQmGZ
   UwswyVpZFMzXup3mCfCYcFt7TXMiCoZQRfPLPErw3u1QY1IjzjhFnNmSL
   xVlQ+Biyx7rFNuWcRXd+n4JP7RGx+PdC5RSxhcMqoa7PQYwSQcIvCuOsF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280590968"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280590968"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:45:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="609254276"
Received: from skummith-mobl1.amr.corp.intel.com (HELO vverma7-desk1.intel.com) ([10.212.54.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:45:30 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <nvdimm@lists.linux.dev>, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 0/3] cxl: static analysis fixes
Date:   Tue, 23 Aug 2022 01:45:24 -0600
Message-Id: <20220823074527.404435-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=703; h=from:subject; bh=MQGAynVVQNWd8X9mtXQpToldlZvQ77AW/OreICS7N/k=; b=owGbwMvMwCXGf25diOft7jLG02pJDMksrdMWpf3hSjjnkO6smPXwyNKyS2k37umdFdyxy9ph9bU/ lnucOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRR2mMDLf/3DKa+ixfxClvw92y7S 3PLHayf7y64++r5njVKxZLPC8y/E9kXdadGOl2x0GW4dMpDR79ySytPzQEuJM2fkyddnbKMyYA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp; fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Changes since v1[1]:
- Fix the decoder filter check in patch 1.
- Fix a missed free(path) in patch 2.

[1]: https://lore.kernel.org/linux-cxl/20220823072106.398076-1-vishal.l.verma@intel.com

---

Fix a small handful of issues reported by scan.coverity.com for the
recent region management additions.

Vishal Verma (3):
  cxl/region: fix a dereferecnce after NULL check
  libcxl: fox a resource leak and a forward NULL check
  cxl/filter: Fix an uninitialized pointer dereference

 cxl/lib/libcxl.c | 4 +++-
 cxl/filter.c     | 2 +-
 cxl/region.c     | 5 ++---
 3 files changed, 6 insertions(+), 5 deletions(-)


base-commit: 9a993ce24fdd5de45774b65211570dd514cdf61d
-- 
2.37.2

